Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4798606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l2XZScl5;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=YgOzW5T5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8546C60E16;
	Fri, 13 Nov 2026 02:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ijx4mUWf3gNy; Fri, 13 Nov 2026 02:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F0F160E1A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537190;
	b=CrMqkm4aDFieP9SQuPp4Ws4W0Qg/mnlGDRb6E49SLjTCIULLGLj7EV02Tym3a6yTSJpD
	 6JY6I4/GDorj3Fzgyf656DClJOPvGXtNlaBQN9VwdLTFADI2Zb7MyUhISNxeNCUVCfD5M
	 AQeyNSvkkdNoR2WZqS+bw+9hdWk5rEoWNkg1IWV+T57OOrlNnTTtWcwtP/CQSvqtFgt/1
	 CsFoy/2nfFUuTgbA59eaRXsTnfz6G3ojEd0UroBVTIB0tCY8k/6zi4J668xIXu7vo5kbS
	 kLhBEcIDsLzBYmc4UzL2884JOo5+ZJdJqya7lBCNtM9OewAGRvBOEN630rjduK5594g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FG5WhTwCLEOv9tBVHPdmjRI2h3+muWaoif79WUunFrQ=;
	b=VMWLfhZzzgIAS5HIWRCcoWF7jsfOktRAc5hMSNXr/djd9MHqkQ6c3Yv7yCclgnb5FK1C
	 fOQIzHBQu6EQ78ZzPFXcFe2iIrnrM8cxAmt6BCcO8ULECCcR3dwz7f3PaId7+cVU0+Akk
	 fD2Dm6y/BNMcZq44+zQb/jX5YUbAixP5fcyvFutD3rQVGW8xi6KeLQ/nmZof72434xnG/
	 f0uWUvr1jg70iXAhD5R6QzLxPCJvzVU7WiCmrp2MTHkCx/tVJHyjD8/jyTV8f3tlafsfl
	 DosRZco7FgcxKvVW61nr4t5mq+IF1t9ipAp9wsxYAR3jT0tk1DBXJRPUTr/fTSiS3bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537190;
	bh=FG5WhTwCLEOv9tBVHPdmjRI2h3+muWaoif79WUunFrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2XZScl5gaT372bb3QsQ1aZ+Mm7rYxee8udQ77Qz66vnYeLEZw2QJv3xZdrhVLZ//
	 4RY9dRJG3LkfiPi5aHiR6ZJ5pdHHxhNQExTUPfztaSnE2PdBSSxEwqBo6JzsdUsyA6
	 kVPf4HblGnco/PYVUEjg7Xhy5i33kXbMPA0//17C01+npEu6PAsqBAWS2a/ZDg6eRN
	 pmx8TwmCqtyBVZ7E6yO1Zo6eK31BaP8r99k/y1Cg0X1epVP26m/+rYNPLjCeeQWotf
	 EOPegj6Zoe0TXYzZ/xxPxPfuwBsOrWyfWWIhOPr2Fk296PDIQYSyd3wjgyOlJRmaRl
	 JfujsDgnYbmuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F0F160E1A;
	Fri, 13 Nov 2026 02:33:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB961F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8F7281496
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DlNFdp0lmIRf for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F6728144C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=YgOzW5T5
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F6728144C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:06 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 4BB0541EC7;
 Fri, 13 Nov 2026 13:32:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FG5WhTwCLEOv9tBVHPdmjRI2h3+muWaoif79WUunFrQ=;
 b=YgOzW5T5QBqkpS5eedhtqMqDjAxe7FBVv4HW3l7QOCdlFUqfnbwULukdBQoGgG4J9l75O0
 +6xPRNtDoB/KELVNVhlMozFLosKIkkeBIDHkkzUkVoyexzE7Qzof8FwWdvOydqY7qlrGgQ
 rNMrjCV2BGcaYkUm9nsF2wAE0xx312Pa7ezGmLUZSqcSXmlMx8zvcq3lelw/AZbbyRPhac
 mgHIpe84ejBK0f+DJ2UHwuu2dtB2yiCeGujcjV1n11UaIdnRdukBlQAxT3nXLF//hExy6r
 001Zq1I658knRsiBcioMg+DkiPzHNox3Q13cilpbja4mUDt6aEzQP5Rpwco5hQ==
X-GPT-Reason: legitimate; the email is a technical commit message
 (Linux kernel patch style) from a known personal address
 (alastair@d-silva.org) to a matching mailbox (alastair@d-silva.org),
 containing no marketing, phishing, or malicious content. The From
 domain matches the recipient domain, the subject describes a specific
 technical hardware power regulator fix, and there are no suspicious
 URLs, urgency, or credential requests.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 03/26] power: axp: Extend AXP318W SPL support with DCDC6/7 and
 LDOs
Date: Fri, 13 Nov 2026 13:32:13 +1100
Message-ID: <20261113023236.569054-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 61c2f29bde1d ("power: regulator: enable AWP318W SPL support")
introduced initial AXP318W DCDC1-DCDC5 support in axp_spl.c, but
Allwinner A733 boards using AXP318W also supply LPDDR5 VDDQ/VDD2 and
PLL/IO rails from DCDC6, DCDC7, ALDO, BLDO, DLDO, and ELDO regulators
during SPL bringup, and sunxi_board_init() did not yet invoke axp_init()
when CONFIG_AXP318W_POWER is enabled.

Extend axp_spl.c with read-modify-write selector updates (preserving
upper control bits outside volt_mask), -1 OTP-default skip semantics,
DCDC6/DCDC7 helpers, and ALDO/BLDO/DLDO/ELDO descriptors and setters for
AXP318W, and wire AXP318W_POWER, DCDC6/7, and BLDO1-4 into Kconfig and
sunxi_board_init().

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 board/sunxi/board.c     |  23 +++++++-
 drivers/power/Kconfig   | 110 +++++++++++++++++++++++++++++++------
 drivers/power/axp_spl.c | 119 +++++++++++++++++++++++++++++++++++++---
 include/axp_pmic.h      |   3 +
 4 files changed, 229 insertions(+), 26 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..299faa890b9 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -586,9 +586,10 @@ void sunxi_board_init(void)
 	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
 	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
 	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER || \
-	defined CONFIG_AXP803_POWER
+	defined CONFIG_AXP803_POWER || defined CONFIG_AXP318W_POWER
 	power_failed = axp_init();
 
+#ifdef AXP_POWER_STATUS
 	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !power_failed) {
 		u8 boot_reason;
 
@@ -598,6 +599,7 @@ void sunxi_board_init(void)
 			pmic_bus_write(0x32, BIT(7));
 		}
 	}
+#endif
 
 #ifdef CONFIG_AXP_DCDC1_VOLT
 	power_failed |= axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
@@ -614,6 +616,12 @@ void sunxi_board_init(void)
 #ifdef CONFIG_AXP_DCDC5_VOLT
 	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
 #endif
+#ifdef CONFIG_AXP_DCDC6_VOLT
+	power_failed |= axp_set_dcdc6(CONFIG_AXP_DCDC6_VOLT);
+#endif
+#ifdef CONFIG_AXP_DCDC7_VOLT
+	power_failed |= axp_set_dcdc7(CONFIG_AXP_DCDC7_VOLT);
+#endif
 
 #ifdef CONFIG_AXP_ALDO1_VOLT
 	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
@@ -628,6 +636,19 @@ void sunxi_board_init(void)
 	power_failed |= axp_set_aldo4(CONFIG_AXP_ALDO4_VOLT);
 #endif
 
+#ifdef CONFIG_AXP_BLDO1_VOLT
+	power_failed |= axp_set_bldo(1, CONFIG_AXP_BLDO1_VOLT);
+#endif
+#ifdef CONFIG_AXP_BLDO2_VOLT
+	power_failed |= axp_set_bldo(2, CONFIG_AXP_BLDO2_VOLT);
+#endif
+#ifdef CONFIG_AXP_BLDO3_VOLT
+	power_failed |= axp_set_bldo(3, CONFIG_AXP_BLDO3_VOLT);
+#endif
+#ifdef CONFIG_AXP_BLDO4_VOLT
+	power_failed |= axp_set_bldo(4, CONFIG_AXP_BLDO4_VOLT);
+#endif
+
 #ifdef CONFIG_AXP_DLDO1_VOLT
 	power_failed |= axp_set_dldo(1, CONFIG_AXP_DLDO1_VOLT);
 	power_failed |= axp_set_dldo(2, CONFIG_AXP_DLDO2_VOLT);
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index b3fd0232938..e202790c4cc 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -171,12 +171,15 @@ config AXP_I2C_ADDRESS
 
 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || \
+		   AXP803_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3300 if AXP818_POWER || MACH_SUN8I_R40 || AXP803_POWER
 	default 3000 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
 	help
 	  Set the voltage (mV) to program the axp pmic dcdc1 at, set to 0 to
-	  disable dcdc1. On A23 / A31 / A33 (axp221) boards dcdc1 is used for
+	  disable dcdc1, or -1 on AXP318W to leave the OTP default untouched.
+	  On A23 / A31 / A33 (axp221) boards dcdc1 is used for
 	  generic 3.3V IO voltage for external devices like the lcd-panal and
 	  sdcard interfaces, etc. On most boards dcdc1 is undervolted to 3.0V to
 	  save battery. On A31 devices dcdc1 is also used for VCC-IO. On A83T
@@ -185,7 +188,10 @@ config AXP_DCDC1_VOLT
 
 config AXP_DCDC2_VOLT
 	int "axp pmic dcdc2 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER || AXP803_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || \
+		   AXP809_POWER || AXP818_POWER || AXP313_POWER || \
+		   AXP717_POWER || AXP803_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 900 if AXP818_POWER
 	default 1400 if AXP152_POWER || (AXP209_POWER && !MACH_SUN8I_V3S)
 	default 1000 if AXP313_POWER
@@ -209,7 +215,10 @@ config AXP_DCDC2_VOLT
 
 config AXP_DCDC3_VOLT
 	int "axp pmic dcdc3 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || \
+		   AXP809_POWER || AXP818_POWER || AXP313_POWER || \
+		   AXP717_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 900 if AXP809_POWER || AXP818_POWER
 	default 1500 if AXP152_POWER
 	default 1250 if (AXP209_POWER && !MACH_SUN8I_V3S)
@@ -233,7 +242,9 @@ config AXP_DCDC3_VOLT
 
 config AXP_DCDC4_VOLT
 	int "axp pmic dcdc4 voltage"
-	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || AXP305_POWER
+	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || \
+		   AXP305_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 1250 if AXP152_POWER
 	default 1200 if MACH_SUN6I
 	default 0 if MACH_SUN8I
@@ -251,7 +262,9 @@ config AXP_DCDC4_VOLT
 
 config AXP_DCDC5_VOLT
 	int "axp pmic dcdc5 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || \
+		   AXP803_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 1500 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
 	help
 	  Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
@@ -259,9 +272,28 @@ config AXP_DCDC5_VOLT
 	  On A23 / A31 / A33 / A80 / A83T / R40 boards dcdc5 is VCC-DRAM and
 	  should be 1.5V, 1.35V if DDR3L is used.
 
+config AXP_DCDC6_VOLT
+	int "axp pmic dcdc6 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc6 at, set to 0 to
+	  disable dcdc6, or -1 to leave the OTP default untouched.
+	  On A733 LPDDR5 boards dcdc6 typically supplies VDDQ-DRAM (0.5V-0.56V).
+
+config AXP_DCDC7_VOLT
+	int "axp pmic dcdc7 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc7 at, set to 0 to
+	  disable dcdc7, or -1 to leave the OTP default untouched.
+	  On A733 LPDDR5 boards dcdc7 typically supplies VDD2-DRAM (1.05V-1.08V).
+
 config AXP_ALDO1_VOLT
 	int "axp pmic (a)ldo1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0 if MACH_SUN6I || MACH_SUN8I_R40
 	default 1800 if MACH_SUN8I_A83T
 	default 3000 if MACH_SUN8I || MACH_SUN9I
@@ -276,7 +308,9 @@ config AXP_ALDO1_VOLT
 
 config AXP_ALDO2_VOLT
 	int "axp pmic (a)ldo2 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || \
+		   AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3000 if AXP152_POWER || AXP209_POWER
 	default 0 if MACH_SUN6I || MACH_SUN9I
 	default 1800 if MACH_SUN8I_A83T
@@ -294,7 +328,9 @@ config AXP_ALDO2_VOLT
 
 config AXP_ALDO3_VOLT
 	int "axp pmic (a)ldo3 voltage"
-	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || \
+		   AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0 if AXP209_POWER || MACH_SUN9I
 	default 3000 if MACH_SUN6I || MACH_SUN8I
 	help
@@ -351,16 +387,50 @@ config AXP_ALDO3_INRUSH_QUIRK
 
 config AXP_ALDO4_VOLT
 	int "axp pmic (a)ldo4 voltage"
-	depends on AXP209_POWER
+	depends on AXP209_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0 if AXP209_POWER
 	help
 	  Set the voltage (mV) to program the axp pmic aldo4 at, set to 0 to
 	  disable aldo4.
 	  On A10(s) / A13 / A20 boards aldo4 should be 2.8V.
 
+config AXP_BLDO1_VOLT
+	int "axp pmic bldo1 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic bldo1 at, set to 0 to
+	  disable bldo1, or -1 to leave the OTP default untouched.
+
+config AXP_BLDO2_VOLT
+	int "axp pmic bldo2 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic bldo2 at, set to 0 to
+	  disable bldo2, or -1 to leave the OTP default untouched.
+
+config AXP_BLDO3_VOLT
+	int "axp pmic bldo3 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic bldo3 at, set to 0 to
+	  disable bldo3, or -1 to leave the OTP default untouched.
+
+config AXP_BLDO4_VOLT
+	int "axp pmic bldo4 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic bldo4 at, set to 0 to
+	  disable bldo4, or -1 to leave the OTP default untouched.
+
 config AXP_DLDO1_VOLT
 	int "axp pmic dldo1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic dldo1 at, set to 0 to
@@ -370,7 +440,8 @@ config AXP_DLDO1_VOLT
 
 config AXP_DLDO2_VOLT
 	int "axp pmic dldo2 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3000 if MACH_SUN9I
 	default 0
 	help
@@ -380,7 +451,8 @@ config AXP_DLDO2_VOLT
 
 config AXP_DLDO3_VOLT
 	int "axp pmic dldo3 voltage"
-	depends on AXP221_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic dldo3 at, set to 0 to
@@ -388,7 +460,8 @@ config AXP_DLDO3_VOLT
 
 config AXP_DLDO4_VOLT
 	int "axp pmic dldo4 voltage"
-	depends on AXP221_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic dldo4 at, set to 0 to
@@ -396,7 +469,8 @@ config AXP_DLDO4_VOLT
 
 config AXP_ELDO1_VOLT
 	int "axp pmic eldo1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic eldo1 at, set to 0 to
@@ -404,7 +478,8 @@ config AXP_ELDO1_VOLT
 
 config AXP_ELDO2_VOLT
 	int "axp pmic eldo2 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic eldo2 at, set to 0 to
@@ -412,7 +487,8 @@ config AXP_ELDO2_VOLT
 
 config AXP_ELDO3_VOLT
 	int "axp pmic eldo3 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3000 if MACH_SUN9I
 	default 0
 	help
diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
index 0162ef5e4cc..af638e30ec5 100644
--- a/drivers/power/axp_spl.c
+++ b/drivers/power/axp_spl.c
@@ -81,10 +81,45 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
 	{ 0x11, BIT(0), 0x1a, 0x7f,  500, 1840,  10, 70 },
 };
 
+static const struct axp_reg_desc_spl axp_spl_aldo_regulators[] = {
+	{ 0x20, BIT(0), 0x24, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(1), 0x25, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(2), 0x26, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(3), 0x27, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(4), 0x28, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(5), 0x29, 0x1f,  500, 3400, 100, NA },
+};
+
+static const struct axp_reg_desc_spl axp_spl_bldo_regulators[] = {
+	{ 0x20, BIT(6), 0x2a, 0x1f,  500, 3400, 100, NA },
+	{ 0x20, BIT(7), 0x2b, 0x1f,  500, 3400, 100, NA },
+	{ 0x21, BIT(0), 0x2c, 0x1f,  500, 3400, 100, NA },
+	{ 0x21, BIT(1), 0x2d, 0x1f,  500, 3400, 100, NA },
+	{ 0x21, BIT(2), 0x2e, 0x1f,  500, 3400, 100, NA },
+};
+
+static const struct axp_reg_desc_spl axp_spl_dldo_regulators[] = {
+	{ 0x22, BIT(0), 0x34, 0x1f,  500, 3400, 100, NA },
+	{ 0x22, BIT(1), 0x35, 0x1f,  500, 3400, 100, NA },
+	{ 0x22, BIT(2), 0x36, 0x1f,  500, 3400, 100, NA },
+	{ 0x22, BIT(3), 0x37, 0x1f,  500, 3400, 100, NA },
+	{ 0x22, BIT(4), 0x38, 0x1f,  500, 3400, 100, NA },
+	{ 0x22, BIT(5), 0x39, 0x1f,  500, 3400, 100, NA },
+};
+
+static const struct axp_reg_desc_spl axp_spl_eldo_regulators[] = {
+	{ 0x22, BIT(6), 0x3a, 0x3f,  500, 1500,  25, NA },
+	{ 0x22, BIT(7), 0x3b, 0x3f,  500, 1500,  25, NA },
+	{ 0x23, BIT(0), 0x3c, 0x3f,  500, 1500,  25, NA },
+	{ 0x23, BIT(1), 0x3d, 0x3f,  500, 1500,  25, NA },
+	{ 0x23, BIT(2), 0x3e, 0x3f,  500, 1500,  25, NA },
+	{ 0x23, BIT(3), 0x3f, 0x3f,  500, 1500,  25, NA },
+};
+
 #define AXP_CHIP_VERSION	0
 #define AXP_CHIP_VERSION_MASK	0
 #define AXP_CHIP_ID		0
-#define AXP_SHUTDOWN_REG	0x55
+#define AXP_SHUTDOWN_REG	AXP318_SHUTDOWN
 #define AXP_SHUTDOWN_MASK	BIT(7)
 
 #elif defined(CONFIG_AXP305_POWER)				/* AXP305 */
@@ -127,26 +162,38 @@ static u8 axp_mvolt_to_cfg(int mvolt, const struct axp_reg_desc_spl *reg)
 	return reg->split + mvolt / (reg->step_mV * 2);
 }
 
-static int axp_set_dcdc(int dcdc_num, unsigned int mvolt)
+static int axp_set_reg(const struct axp_reg_desc_spl *reg, unsigned int mvolt)
 {
-	const struct axp_reg_desc_spl *reg;
+	u8 cfg, val;
 	int ret;
 
-	if (dcdc_num < 1 || dcdc_num > ARRAY_SIZE(axp_spl_dcdc_regulators))
-		return -EINVAL;
-
-	reg = &axp_spl_dcdc_regulators[dcdc_num - 1];
+	if (mvolt == (unsigned int)-1)
+		return 0;
 
 	if (mvolt == 0)
 		return pmic_bus_clrbits(reg->enable_reg, reg->enable_mask);
 
-	ret = pmic_bus_write(reg->volt_reg, axp_mvolt_to_cfg(mvolt, reg));
+	cfg = axp_mvolt_to_cfg(mvolt, reg);
+	ret = pmic_bus_read(reg->volt_reg, &val);
+	if (ret)
+		return ret;
+
+	val = (val & ~reg->volt_mask) | (cfg & reg->volt_mask);
+	ret = pmic_bus_write(reg->volt_reg, val);
 	if (ret)
 		return ret;
 
 	return pmic_bus_setbits(reg->enable_reg, reg->enable_mask);
 }
 
+static int axp_set_dcdc(int dcdc_num, unsigned int mvolt)
+{
+	if (dcdc_num < 1 || dcdc_num > ARRAY_SIZE(axp_spl_dcdc_regulators))
+		return -EINVAL;
+
+	return axp_set_reg(&axp_spl_dcdc_regulators[dcdc_num - 1], mvolt);
+}
+
 int axp_set_dcdc1(unsigned int mvolt)
 {
 	return axp_set_dcdc(1, mvolt);
@@ -172,6 +219,62 @@ int axp_set_dcdc5(unsigned int mvolt)
 	return axp_set_dcdc(5, mvolt);
 }
 
+#ifdef CONFIG_AXP318W_POWER
+int axp_set_dcdc6(unsigned int mvolt)
+{
+	return axp_set_dcdc(6, mvolt);
+}
+
+int axp_set_dcdc7(unsigned int mvolt)
+{
+	return axp_set_dcdc(7, mvolt);
+}
+
+int axp_set_aldo1(unsigned int mvolt)
+{
+	return axp_set_reg(&axp_spl_aldo_regulators[0], mvolt);
+}
+
+int axp_set_aldo2(unsigned int mvolt)
+{
+	return axp_set_reg(&axp_spl_aldo_regulators[1], mvolt);
+}
+
+int axp_set_aldo3(unsigned int mvolt)
+{
+	return axp_set_reg(&axp_spl_aldo_regulators[2], mvolt);
+}
+
+int axp_set_aldo4(unsigned int mvolt)
+{
+	return axp_set_reg(&axp_spl_aldo_regulators[3], mvolt);
+}
+
+int axp_set_bldo(int bldo_num, unsigned int mvolt)
+{
+	if (bldo_num < 1 || bldo_num > ARRAY_SIZE(axp_spl_bldo_regulators))
+		return -EINVAL;
+
+	return axp_set_reg(&axp_spl_bldo_regulators[bldo_num - 1], mvolt);
+}
+
+int axp_set_dldo(int dldo_num, unsigned int mvolt)
+{
+	if (dldo_num < 1 || dldo_num > ARRAY_SIZE(axp_spl_dldo_regulators))
+		return -EINVAL;
+
+	return axp_set_reg(&axp_spl_dldo_regulators[dldo_num - 1], mvolt);
+}
+
+int axp_set_eldo(int eldo_num, unsigned int mvolt)
+{
+	if (eldo_num < 1 || eldo_num > ARRAY_SIZE(axp_spl_eldo_regulators))
+		return -EINVAL;
+
+	return axp_set_reg(&axp_spl_eldo_regulators[eldo_num - 1], mvolt);
+}
+#endif
+
 int axp_init(void)
 {
 	int ret = pmic_bus_init();
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index 5df0e269b9d..b2463876e52 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -49,10 +49,13 @@ int axp_set_dcdc2(unsigned int mvolt);
 int axp_set_dcdc3(unsigned int mvolt);
 int axp_set_dcdc4(unsigned int mvolt);
 int axp_set_dcdc5(unsigned int mvolt);
+int axp_set_dcdc6(unsigned int mvolt);
+int axp_set_dcdc7(unsigned int mvolt);
 int axp_set_aldo1(unsigned int mvolt);
 int axp_set_aldo2(unsigned int mvolt);
 int axp_set_aldo3(unsigned int mvolt);
 int axp_set_aldo4(unsigned int mvolt);
+int axp_set_bldo(int bldo_num, unsigned int mvolt);
 int axp_set_dldo(int dldo_num, unsigned int mvolt);
 int axp_set_eldo(int eldo_num, unsigned int mvolt);
 int axp_set_fldo(int fldo_num, unsigned int mvolt);
-- 
2.53.0

