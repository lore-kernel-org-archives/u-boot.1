Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A13C0218F
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8878781111;
	Mon, 27 Jan 2025 08:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="FTYN3VDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356FE81109; Mon, 27 Jan 2025 08:49:11 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405EC80FC4
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737964148; x=1738223348;
 bh=quWTHSBgxz2DPruEPCQXa4AxgjsrM7w4463jq6dokcQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=FTYN3VDEIMXEvuAMOZL03WZIVEkygeVuQhDY864alH7e26f2Q1mtfC4hiD9Ix6+pG
 AQhQW1FQpbcrja9n2J7h8syJC5+vaYd9hjj60aI2E7wasO0M/W7hV4uPgYISIGDlrO
 M5tAOeRR5AkmRBtD7LV3un9fMROopeklvNs4vqEu6gC/mQl3d4wDIHCsmbZa5CkSUo
 eDXFw9MOPC2BiCR/XPpSIx/ktqlJGmsPspec+AZhbAXum5l/MJAEzmz8Ac1GHGuzHK
 +P8Z8KIQkiDDmILrkCdXmhwloIZ/fl8Tdo0VOo3Ri1472v3h4OIjeY+wgt7eYrXs5X
 +nk7h1At2avEw==
Date: Mon, 27 Jan 2025 07:49:03 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
Message-ID: <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
In-Reply-To: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 80bd7a36a0243d60f236f2e229d7126b67e02730
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

msm_rng_enable is supposed to skip writing to LFSR_CFG + CONFIG
registers in the PRNG_ block if PRNG_CONFIG_HW_ENABLE is already set.
The logic to test for this was inverted.

Without this fix, the driver was causing SError aborts on my MSM8916
device. Stephan Gerhold suggested this was probably because TZ has
marked this as a protected register, since it would also be using it for
RNG.

Fixes: 033ec636fcb ("rng: Add Qualcomm MSM PRNG driver")
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/rng/msm_rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
index f790d3b60f99bfc04ecd9acdd21405a8c38c257a..01505509103f28f7c91dd47edb8=
3c23359163c82 100644
--- a/drivers/rng/msm_rng.c
+++ b/drivers/rng/msm_rng.c
@@ -76,7 +76,7 @@ static int msm_rng_enable(struct msm_rng_priv *priv, int =
enable)
 =09if (enable) {
 =09=09/* Enable PRNG only if it is not already enabled */
 =09=09val =3D readl_relaxed(priv->base + PRNG_CONFIG);
-=09=09if (val & PRNG_CONFIG_HW_ENABLE) {
+=09=09if (!(val & PRNG_CONFIG_HW_ENABLE)) {
 =09=09=09val =3D readl_relaxed(priv->base + PRNG_LFSR_CFG);
 =09=09=09val &=3D ~PRNG_LFSR_CFG_MASK;
 =09=09=09val |=3D PRNG_LFSR_CFG_CLOCKS;

--=20
2.47.1


