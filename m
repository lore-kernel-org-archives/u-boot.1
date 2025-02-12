Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02821C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 07:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D287C80BAD;
	Wed, 12 Feb 2025 08:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="fCUJ6GLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD1880BAA; Wed, 12 Feb 2025 08:01:35 +0100 (CET)
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch
 [79.135.106.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5FD80BAD
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1739343692; x=1739602892;
 bh=11l46629qx/ZCePJwprX58aeecUYcUDwBppfyskKdo8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=fCUJ6GLqhxall/05WW4EN5BGoj+5+F07DsCaaxjzYosXSUH47UyoH2irNjkuqtUA7
 v7VBVNWfv2LfO5+5Nw75DQMyXw1gP5D1lpYFv7gtxHYQ/uqzq1/ftQEoHYyVynxFOd
 YlnwVXl1L1cp+ustYmXWV7C/qTxsPT/xlZOCTcH28uvmNPjl+ehLhILOhjLdVHDXSB
 nh8+jZY1IHwk4FuE5NIyI7AYAsxOWeB74yIdpjGQ58Sc/ksZoChm6fCSEEuL8EI9UU
 kvc1zAnaPTtjpzdfYPZ8HgsKfbAO8ULDRstSuYy4PYotp6OtmPGFQwlJ9OwScPacMT
 pZd2dgetZuS2w==
Date: Wed, 12 Feb 2025 07:01:27 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 1/5] clk/qcom: apq8016: use BIT macro for clk en_vals
Message-ID: <20250212-msm-rng-fixes-v2-1-645cf8d3fd3c@samcday.com>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 0e58c3dcfbdcf896ea13bed0283ad95479d88907
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

This reads a little bit nicer (IMO), and is consistent with the kernel.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index b5def55dbc2ac671130624dec56592288a0ceb3d..0c247250bd92b2bc888ecb7dc0a=
06e808e087fc0 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -54,8 +54,8 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
 };
=20
 static const struct gate_clk apq8016_clks[] =3D {
-=09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
-=09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, 0x00000001),
+=09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
+=09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, BIT(0)),
 };
=20
 /* SDHCI */

--=20
2.48.1


