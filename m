Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649E9D1038E
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 02:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32FC88EEB;
	Fri, 25 Oct 2024 04:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZjhPfSZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF7C88FED; Fri, 25 Oct 2024 04:02:41 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD4388DDC
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b15416303aso101402985a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729821751; x=1730426551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2FKi6AvzADxkSAtCZPRyIlx1EgsG1LhomoWDDgmc08=;
 b=ZjhPfSZ/Rn6nHw96YHWa5uNinxSAkppLg3OGaORS3geTCFTAa7NWS9wPyO0ExEC8vC
 abCKvocoW6D8ldSVSCPMJwos35hDBaCU31IQl52/3vIo9g5JO4dGQ9ydOMQGh3LRmaqq
 IO4WpeZIsc2wn1rJ6wZDtp9NVweQ6QFNsxGhBh5/m0+B3RQ74oZcbnFSncsj9AgLy3xI
 2E9alQ25WmkIOqlvqbB9md1Od28F1Ux02PmkgHVHK0Hg22R7+387DBNPWnG6HUUYk1C9
 fj25AA45zImnlXAaXb3yfC6xtd0eHqa5xsiPcyTWNe9k5OE5bZjyqpkKy1ZuO/BRxvtJ
 Ke+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729821751; x=1730426551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2FKi6AvzADxkSAtCZPRyIlx1EgsG1LhomoWDDgmc08=;
 b=fBF1RsJDoyAT2AVp8vpb2lTOFTyya+RP4SiprWG9VVYijrKTYx+52cul88JTJVfLJ2
 S5+0eIJHn0tON5xmlf40sG89vC59uVrXb4tUCX+kygmb1iqpwkkgXoP5xrjcvfxwrcDV
 hKm0ZEL3Vf2fbpwyFKPqLxAiIu6kX9rWSgoFb+xh3trBKkcm1abGMM8OBZaVZzH7Yb3L
 aSTY5HIw4GQaUoHbTD6BoWoeyv8jFfvXIVHElpav+oVhrpQGyH1i2WvCCfnj6Q7sdp/8
 fAmrd+AHN/yja5clWOA6zHZOM7ZbcLfouNyhXjM+enY1k3NwV15r6O3XHG0reBcw1mjD
 4b8Q==
X-Gm-Message-State: AOJu0YxxSUD0HtY9zm9HZP7zVvR4lqBF7y6HS6UOh8JWzyDQBg3ST8LF
 MZRWkJ+QshecEAFdovANnkTFBz6THhap6ulT3ch9Iry2828f4FYZWcYmvOdH
X-Google-Smtp-Source: AGHT+IHIgzRV7/BBhhmjXyc4UW61L1OuTagydwwc6+di7lLhdJ73bilVYp7hkFv+R52v8DTZK+Fl6g==
X-Received: by 2002:a05:620a:248c:b0:7a9:c0f3:3b71 with SMTP id
 af79cd13be357-7b17e56a02fmr1155941585a.19.1729821751628; 
 Thu, 24 Oct 2024 19:02:31 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294b3fsm11607585a.33.2024.10.24.19.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 19:02:30 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] imx: imxrt1050-evk: Fix missing clocks for mmc
Date: Thu, 24 Oct 2024 22:02:26 -0400
Message-ID: <20241025020228.1686306-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Two of the clocks required by the usdhc1 controller are missing from the
clock controller node. A recent change enables all the clocks in the
esdhc node, which fails as they are not defined in the clock controller.

Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imxrt1050.dtsi     | 2 +-
 drivers/clk/imx/clk-imxrt1050.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imxrt1050.dtsi b/arch/arm/dts/imxrt1050.dtsi
index 03e6a858a7b..a25eae9bd38 100644
--- a/arch/arm/dts/imxrt1050.dtsi
+++ b/arch/arm/dts/imxrt1050.dtsi
@@ -87,7 +87,7 @@
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
-				<&clks IMXRT1050_CLK_OSC>,
+				<&clks IMXRT1050_CLK_AHB_PODF>,
 				<&clks IMXRT1050_CLK_USDHC1>;
 			clock-names = "ipg", "ahb", "per";
 			bus-width = <4>;
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 788e0650a92..2c029ec5a6e 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -144,6 +144,9 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 	clk_dm(IMXRT1050_CLK_AHB_PODF,
 	       imx_clk_divider("ahb_podf", "periph_sel",
 			       base + 0x14, 10, 3));
+	clk_dm(IMXRT1050_CLK_IPG_PDOF,
+	       imx_clk_divider("ipg_podf", "ahb_podf",
+			       base + 0x14, 8, 2));
 	clk_dm(IMXRT1050_CLK_USDHC1_PODF,
 	       imx_clk_divider("usdhc1_podf", "usdhc1_sel",
 			       base + 0x24, 11, 3));
-- 
2.45.2

