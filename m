Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09603C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7107988CAF;
	Sat,  3 Aug 2024 13:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAvKSxug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FD78827D; Sat,  3 Aug 2024 13:10:52 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316C08827D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2cb7d562so112428651fa.3
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683449; x=1723288249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WREJNXzxVUAGrmmhO+htWtT3ucSAOd25yUlCAiPSVPs=;
 b=CAvKSxugl54uvwXMtmLpy/WmdyDQaOwMPumn/Acz2APG2Jqq0Bih2uzDHgq3rt9Ja2
 QPadYRNLM2c1BjbYq7L4p3ZyBJ7B8MgJWg/M/2gu48ezg7As7zUKp7fLGtkc4CUkjQc4
 ZXGzSCJWLI3iiw5Ui9f2Y6RrA7gwZbZYPEGFaFf/cg8x2hH7PXSbKPM1rIKMCqsvxSpK
 cv1CNPcnby5lGNj8Nb6g7MlOLhQJj/2X2PIQy3bP3oktAE2fTeFyQRfUJMoyGG1HWbvO
 pxjLZuv3tfDgQ5FFk3YxcavP632iFi6JFeQ0ismv0eEQAs0sLkOoUbu8t0rWTRtP+FSQ
 hhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683449; x=1723288249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WREJNXzxVUAGrmmhO+htWtT3ucSAOd25yUlCAiPSVPs=;
 b=goD50kWRJghNB1S43ojRCJ577AKf8HADywpFt6kdwCElLcxPuaySWLBX0ZSHx81sJZ
 lXrvT8Bcglflc76vIs14W6LggiAcXG9LN3uzHvM5iAMQwC6DiVM/8LbY1vMKY2mbFBYJ
 CLU37V3IW1PjDvMsA9sSXPF68iMu7qrQvd+fCrZKukSI9KCku09h0+WMKH+3Lb2cul3j
 BwhupwNck7ffck4C3e00SWeu9ZaFaztqP9FTc6TZ5fiw3VJILDt4AIFqgFGkQ50rK6iV
 8MtuuBVcIgIObYfKZriY6OcV5qoyKmXCIIC9n2qeroirk/Bx712PKh45I0Q8yiYAnK9x
 xmUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdnAlkLUnxbpUVz1xQ++T/zUXqT7yZabkVeKx8yHhmu6Retb/CaRM0+yKt6T4I85KoVb7ctQ8GxPrgBw658E6EmoK3uw==
X-Gm-Message-State: AOJu0YxUPs7bmHpnz0vmGoAgGfviqMeEzimvWSl/Th8/xXWGyNOkoqHb
 y0E+AvW0IM6MthA/EKxp8m3Zdroco8L3rEAjom34aSAJ/HgeBPH9
X-Google-Smtp-Source: AGHT+IHcGYO6cr0Q0VyteEKq/Pt5aDGam08+fqM6l49Q0SrWSuQEUU5anutShCkxnf+dHDh+oGAUOQ==
X-Received: by 2002:a2e:9816:0:b0:2ec:63f:fe91 with SMTP id
 38308e7fff4ca-2f15ab01fe6mr44772791fa.38.1722683448918; 
 Sat, 03 Aug 2024 04:10:48 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 11/15] clk: mediatek: mt7986: comment out CK_TOP_A_TUNER as
 not used
Date: Sat,  3 Aug 2024 10:40:44 +0200
Message-ID: <20240803084050.449-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
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

Comment out CK_TOP_A_TUNER as not used and not defined in upstream
kernel linux. This is to permit support of OF_UPSTREAM and have a 1:1
match with upstream linux clock ID.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      |   3 +-
 include/dt-bindings/clock/mt7986-clk.h | 122 ++++++++++++-------------
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index d8e0a5790e3..08b7ab8a81e 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -58,7 +58,8 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 		   1250),
 	TOP_FACTOR(CK_TOP_RTC_32P7K, "rtc_32p7k", CK_TOP_XTAL, 1,
 		   1220),
-	TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1),
+	/* Not defined upstream and not used */
+	/* TOP_FACTOR(CK_TOP_A_TUNER, "a_tuner", CK_TOP_A_TUNER_SEL, 2, 1), */
 	/* MPLL */
 	PLL_FACTOR(CK_TOP_MPLL_D2, "mpll_d2", CK_APMIXED_MPLL, 1, 2),
 	PLL_FACTOR(CK_TOP_MPLL_D4, "mpll_d4", CK_APMIXED_MPLL, 1, 4),
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index 478538d7cce..7df13665900 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -19,67 +19,67 @@
 #define CK_TOP_XTAL_D2			1
 #define CK_TOP_RTC_32K			2
 #define CK_TOP_RTC_32P7K		3
-#define CK_TOP_A_TUNER			4
-#define CK_TOP_MPLL_D2			5
-#define CK_TOP_MPLL_D4			6
-#define CK_TOP_MPLL_D8			7
-#define CK_TOP_MPLL_D8_D2		8
-#define CK_TOP_MPLL_D3_D2		9
-#define CK_TOP_MMPLL_D2			10
-#define CK_TOP_MMPLL_D4			11
-#define CK_TOP_MMPLL_D8			12
-#define CK_TOP_MMPLL_D8_D2		13
-#define CK_TOP_MMPLL_D3_D8		14
-#define CK_TOP_MMPLL_U2PHYD		15
-#define CK_TOP_APLL2_D4			16
-#define CK_TOP_NET1PLL_D4		17
-#define CK_TOP_NET1PLL_D5		18
-#define CK_TOP_NET1PLL_D5_D2		19
-#define CK_TOP_NET1PLL_D5_D4		20
-#define CK_TOP_NET1PLL_D8_D2		21
-#define CK_TOP_NET1PLL_D8_D4		22
-#define CK_TOP_NET2PLL_D4		23
-#define CK_TOP_NET2PLL_D4_D2		24
-#define CK_TOP_NET2PLL_D3_D2		25
-#define CK_TOP_WEDMCUPLL_D5_D2		26
-#define CK_TOP_NFI1X_SEL		27
-#define CK_TOP_SPINFI_SEL		28
-#define CK_TOP_SPI_SEL			29
-#define CK_TOP_SPIM_MST_SEL		30
-#define CK_TOP_UART_SEL			31
-#define CK_TOP_PWM_SEL			32
-#define CK_TOP_I2C_SEL			33
-#define CK_TOP_PEXTP_TL_SEL		34
-#define CK_TOP_EMMC_250M_SEL		35
-#define CK_TOP_EMMC_416M_SEL		36
-#define CK_TOP_F_26M_ADC_SEL		37
-#define CK_TOP_DRAMC_SEL		38
-#define CK_TOP_DRAMC_MD32_SEL		39
-#define CK_TOP_SYSAXI_SEL		40
-#define CK_TOP_SYSAPB_SEL		41
-#define CK_TOP_ARM_DB_MAIN_SEL		42
-#define CK_TOP_ARM_DB_JTSEL		43
-#define CK_TOP_NETSYS_SEL		44
-#define CK_TOP_NETSYS_500M_SEL		45
-#define CK_TOP_NETSYS_MCU_SEL		46
-#define CK_TOP_NETSYS_2X_SEL		47
-#define CK_TOP_SGM_325M_SEL		48
-#define CK_TOP_SGM_REG_SEL		49
-#define CK_TOP_A1SYS_SEL		50
-#define CK_TOP_CONN_MCUSYS_SEL		51
-#define CK_TOP_EIP_B_SEL		52
-#define CK_TOP_PCIE_PHY_SEL		53
-#define CK_TOP_USB3_PHY_SEL		54
-#define CK_TOP_F26M_SEL			55
-#define CK_TOP_AUD_L_SEL		56
-#define CK_TOP_A_TUNER_SEL		57
-#define CK_TOP_U2U3_SEL			58
-#define CK_TOP_U2U3_SYS_SEL		59
-#define CK_TOP_U2U3_XHCI_SEL		60
-#define CK_TOP_DA_U2_REFSEL		61
-#define CK_TOP_DA_U2_CK_1P_SEL		62
-#define CK_TOP_AP2CNN_HOST_SEL		63
-#define CLK_TOP_NR_CLK			64
+/* #define CK_TOP_A_TUNER		4 */
+#define CK_TOP_MPLL_D2			4
+#define CK_TOP_MPLL_D4			5
+#define CK_TOP_MPLL_D8			6
+#define CK_TOP_MPLL_D8_D2		7
+#define CK_TOP_MPLL_D3_D2		8
+#define CK_TOP_MMPLL_D2			9
+#define CK_TOP_MMPLL_D4			10
+#define CK_TOP_MMPLL_D8			11
+#define CK_TOP_MMPLL_D8_D2		12
+#define CK_TOP_MMPLL_D3_D8		13
+#define CK_TOP_MMPLL_U2PHYD		14
+#define CK_TOP_APLL2_D4			15
+#define CK_TOP_NET1PLL_D4		16
+#define CK_TOP_NET1PLL_D5		17
+#define CK_TOP_NET1PLL_D5_D2		18
+#define CK_TOP_NET1PLL_D5_D4		19
+#define CK_TOP_NET1PLL_D8_D2		20
+#define CK_TOP_NET1PLL_D8_D4		21
+#define CK_TOP_NET2PLL_D4		22
+#define CK_TOP_NET2PLL_D4_D2		23
+#define CK_TOP_NET2PLL_D3_D2		24
+#define CK_TOP_WEDMCUPLL_D5_D2		25
+#define CK_TOP_NFI1X_SEL		26
+#define CK_TOP_SPINFI_SEL		27
+#define CK_TOP_SPI_SEL			28
+#define CK_TOP_SPIM_MST_SEL		29
+#define CK_TOP_UART_SEL			30
+#define CK_TOP_PWM_SEL			31
+#define CK_TOP_I2C_SEL			32
+#define CK_TOP_PEXTP_TL_SEL		33
+#define CK_TOP_EMMC_250M_SEL		34
+#define CK_TOP_EMMC_416M_SEL		35
+#define CK_TOP_F_26M_ADC_SEL		36
+#define CK_TOP_DRAMC_SEL		37
+#define CK_TOP_DRAMC_MD32_SEL		38
+#define CK_TOP_SYSAXI_SEL		39
+#define CK_TOP_SYSAPB_SEL		40
+#define CK_TOP_ARM_DB_MAIN_SEL		41
+#define CK_TOP_ARM_DB_JTSEL		42
+#define CK_TOP_NETSYS_SEL		43
+#define CK_TOP_NETSYS_500M_SEL		44
+#define CK_TOP_NETSYS_MCU_SEL		45
+#define CK_TOP_NETSYS_2X_SEL		46
+#define CK_TOP_SGM_325M_SEL		47
+#define CK_TOP_SGM_REG_SEL		48
+#define CK_TOP_A1SYS_SEL		49
+#define CK_TOP_CONN_MCUSYS_SEL		50
+#define CK_TOP_EIP_B_SEL		51
+#define CK_TOP_PCIE_PHY_SEL		52
+#define CK_TOP_USB3_PHY_SEL		53
+#define CK_TOP_F26M_SEL			54
+#define CK_TOP_AUD_L_SEL		55
+#define CK_TOP_A_TUNER_SEL		56
+#define CK_TOP_U2U3_SEL			57
+#define CK_TOP_U2U3_SYS_SEL		58
+#define CK_TOP_U2U3_XHCI_SEL		59
+#define CK_TOP_DA_U2_REFSEL		60
+#define CK_TOP_DA_U2_CK_1P_SEL		61
+#define CK_TOP_AP2CNN_HOST_SEL		62
+#define CLK_TOP_NR_CLK			63
 
 /*
  * INFRACFG_AO
-- 
2.45.2

