Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C23C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 07:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 804CD80C72;
	Wed, 12 Feb 2025 08:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="OjkspRy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E5CA80EAF; Wed, 12 Feb 2025 08:02:05 +0100 (CET)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F3F80C8F
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1739343716; x=1739602916;
 bh=xEzSx3cns/G+pY8KNc9BLVDtP7Jpsk0AKvrXokHxBvg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=OjkspRy90DnPhftqOHDK0hQdYagDYuL9MS66n+eJuUfFa5/re/mFaewj6c7GdYW57
 B+f0hywZFHuY3yX0ar+1NxamtsZkFsWh96emfOy8PXkFQ6E/BjOHRBkrIqZtlQ5Fu7
 pNae8OFfs2gnuvngc3M9epoeN+o0s4qlukFz2FOkt8YMfA+ehGYHgFnZjBGL25P/rB
 VUvE0TIs5VFzyPgMDjD8CUuKodvpqy51BpttFjEi7ejqyEVanKEhfpn3yCK+Vfqooo
 PqgMDH7XV6MqDAiHWpHl7p5UqOQTYHRJQ9kEG5lwPTA9FgEBHpsPLVfXPzPonTY3UN
 wTmpWTMBmabcg==
Date: Wed, 12 Feb 2025 07:01:39 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v2 3/5] rng: msm: don't enable PRNG if it's already enabled
Message-ID: <20250212-msm-rng-fixes-v2-3-645cf8d3fd3c@samcday.com>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: f4e28117b374928edd05be968a0aff3104ebb5ed
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
Suggested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
2.48.1


