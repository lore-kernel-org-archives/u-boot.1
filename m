Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C638C0218F
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C5A81101;
	Mon, 27 Jan 2025 08:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="b+7mVNFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8292A81109; Mon, 27 Jan 2025 08:49:04 +0100 (CET)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAFE810FC
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737964141; x=1738223341;
 bh=+raOPA36eHRHX9519+++xAWYMRb2hoe4AlwM3cU35yE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=b+7mVNFyRryKzVTe7NCAkDLCIqJg4QZFTtnDAh/6jCytEqN+J9XvS9RJR9UTQwnM7
 mhtoWi/HfrKJbARHt8Ci8E2YK3PFg37snDbGhHQ6O5MY9p0eq1twLBhqMxuRvG6hM3
 Ufho1vLMQ3Jnjpp6fryTXNTDcF3LaqACbtBTROSdsNtdXkGYucC/JfHOlAIEQXLNLw
 1wXvpE9dEO/bVYnNN8nVVSnme1DankgePiC+7NrHbPUl6pS+WRkBHbNMwFx2Xb26kd
 AClakA7QRiPB087sdxnC8l+3OH6o0VjywPmFWH7kftBACovVGp272Fwj5j4LrQaxgy
 ip+0Epq+M+Ykg==
Date: Mon, 27 Jan 2025 07:48:54 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 1/4] clk/qcom: apq8016: add PRNG_AHB_CLK
Message-ID: <20250127-msm-rng-fixes-v1-1-00f5d2284314@samcday.com>
In-Reply-To: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: f18ee8d05614f8748a875e32bf4c545f59f27a23
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

This clock needs to be enabled for the msm-rng driver to work on
MSM8916, otherwise accessing the PRNG register block causes a data
abort.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index b5def55dbc2ac671130624dec56592288a0ceb3d..ff5e7ca6f02148427240b80fb08=
efdd356934cd5 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -54,8 +54,9 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
 };
=20
 static const struct gate_clk apq8016_clks[] =3D {
-=09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
-=09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, 0x00000001),
+=09GATE_CLK(GCC_PRNG_AHB_CLK,=090x45004, BIT(8)),
+=09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
+=09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, BIT(0)),
 };
=20
 /* SDHCI */

--=20
2.47.1


