Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4C606A31D
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YdWncUeF;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=coTB14NK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0880F405AC;
	Mon, 23 Nov 2026 01:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lc-bOrnZsjOZ; Mon, 23 Nov 2026 01:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6A6240612
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795396577;
	b=p51mdFeaeGSVpC3caLwb5ohlIFquSXwS7adGGteTivBfsVOLSdBgQVDKtW+kPMhvylny
	 KL90nJj4w8cRYzEVp3VgdsJGBDgombux5W2hledSWOZdHE+0fS+ErGsJ2MpzST2F18yNE
	 XnLj8RXGyRnUGxI3UZLwFkD3687SnsjKsCD7SaHVVxSodlscUaBVOqPB8Vk23TXUjDzGn
	 /g75uw/AOT8A+QkP8n195mdetTbVOaI4MaJwlg+C0iLyucIsU4i078Vt3JwdsQMlbteZH
	 4XW9pI4kSJXp/mTBHwBnWGx2foi+CgPCXqGeppM9phlw8tgU2iDlPapULtqgrUFWAZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795396577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BzM7IyHKn9IaHw9adCSQ5HaL0mRGnBfjyB3eNc9vlrw=;
	b=N/yxbD2N3fkPHOa5Vedx6bX+/wXtIqvvbMoDbF5YJo1j4KrGCQFMZs6A2YQuvKkBCh9n
	 VLlkyqerJEoRSj8syaoJQvzQGbcP+dzZXGRH90DQLGLDx9gLJR6XZLV4SPGgQcTd3LApN
	 8TncpHxlBTrzqy8K1WxSYuJrE+CQvCLK8poPgedXRPR1fjmREyYKkskxgYQpl3iJG9xyB
	 O7WME3uvwp+4oy/Aqx3gRh/W3yH1D0bANThEZNaqwx1TZXIoLEZI5z08BzcufZvl7ZhAC
	 Qt5rqSNa97fL2ic3G/a4JaYcwuHuv26Mz38v22xTj/FSjBoXo2GfsmeCXUB49fhCAxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=d-silva.org;
	spf=fail smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=coTB14NK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795396577;
	bh=BzM7IyHKn9IaHw9adCSQ5HaL0mRGnBfjyB3eNc9vlrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdWncUeFvGvLG0oxmEaIAXbUXBNZtu8CrSNs3qshvNLP4nmI8v8PktMa/umkB4ZtT
	 k8Mra5TPfP8mdyBBAayDWCx11ioXfx+kr2qJAIjiZh/nBgwUQklmr68t8onvHam9fr
	 okQAyWYPpWHb0vopu6M0A8Ckvzw5LLge6zBMYSXBM7dyr6k1L11rSkXqSXN0EzCplr
	 GSrcHEHdl0Z6iwlmDWVci+bwzsCtRi++LxGDf5cwB3HuZofd74QsRsBNQOgk5ROQM/
	 PTpFon6ZvTDhjrReohYcUzsaSLGH5UYPq9gVT+0R+/ByLdECUMfveOrKHMA5eHHqRt
	 qpl8ms7t4vIiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6A6240612;
	Mon, 23 Nov 2026 01:16:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA082DA6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABD2940623
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlL9OuP-JLQY for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 01:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB7C5405AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=d-silva.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=coTB14NK
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB7C5405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:16:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C19D84409; Mon, 23 Nov 2026 02:16:12 +0100 (CET)
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6900846F7
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 02:16:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=d-silva.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alastair@d-silva.org
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 2A60842712;
 Mon, 23 Nov 2026 12:15:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795396556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzM7IyHKn9IaHw9adCSQ5HaL0mRGnBfjyB3eNc9vlrw=;
 b=coTB14NKBqBZrpS0RuWcweA3uBAb9fMSY7KfLH1oluLOqiOE+z1F4IiSQrOqF0D8pY2riz
 gonRRXHXLxW387P+U2hYmFJH6OoMcBRg+9JLKJZsziY2IgnCZ5/yNT+LIsTkXbiva9rg7+
 0XfpJ8CRTX8NNIuH7CqbrRKpTnP2ZtJuhIsRWrSXNZmgR8EaN+9ArMkLlPlVuPAM6Ivh6G
 ry/SjdrlYD6ZQM0saJW2AP4MuPFWDhhDhy1OxUO9ROqh2/tKMuXffoJVzHEHTWVam/Qhyu
 M6aRIjtNFgyHgZfiSX/Q7H+KFZSpfe33dkbzldv57DwVHiyazux5D9sXU6HDtg==
X-GPT-Reason: legitimate. The email is a technical, personal correspondence
 from alastair@d-silva.org which matches the intended mailbox
 (alastair@d-silva.org). The content describes a Linux kernel patch
 [PATCH 3/3] regarding power regulator support for AXP318W hardware,
 which is consistent with a developer/technical role. There are
 no phishing indicators, no urgency/scare tactics, no suspicious
 URLs, and the From domain perfectly aligns with the recipient's
 known personal/business domain.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 3/3] power: axp: Extend AXP318W SPL support with DCDC6/7 and
 LDOs
Date: Mon, 23 Nov 2026 12:15:34 +1100
Message-ID: <20261123011534.1692975-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123011534.1692975-1-alastair@d-silva.org>
References: <20261123011534.1692975-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 61c2f29bde1d ("power: regulator: enable AWP318W SPL support")
added AXP318W DCDC1-DCDC5 descriptors to axp_spl.c.
However, sunxi_board_init() still skips axp_init() when
CONFIG_AXP318W_POWER is enabled.
The Orange Pi 4 Pro also needs DCDC6, DCDC7, and ALDO/BLDO/DLDO/ELDO
rails during SPL bringup.

Add ALDO, BLDO, DLDO, and ELDO descriptors and setters for AXP318W.
Update axp_set_reg() to use read-modify-write and skip -1 OTP defaults.
Add DCDC6, DCDC7, and BLDO1-4 Kconfig options and wire AXP318W_POWER
into sunxi_board_init().

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
index 66c389d073b..cfc722e86c2 100644
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
 	default 1400 if AXP152_POWER || AXP209_POWER
 	default 1000 if AXP313_POWER
@@ -207,7 +213,10 @@ config AXP_DCDC2_VOLT
 
 config AXP_DCDC3_VOLT
 	int "axp pmic dcdc3 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || \
+		   AXP809_POWER || AXP818_POWER || AXP313_POWER || \
+		   AXP717_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 900 if AXP809_POWER || AXP818_POWER
 	default 1500 if AXP152_POWER
 	default 1250 if AXP209_POWER
@@ -229,7 +238,9 @@ config AXP_DCDC3_VOLT
 
 config AXP_DCDC4_VOLT
 	int "axp pmic dcdc4 voltage"
-	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || AXP305_POWER
+	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || \
+		   AXP305_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 1250 if AXP152_POWER
 	default 1200 if MACH_SUN6I
 	default 0 if MACH_SUN8I
@@ -247,7 +258,9 @@ config AXP_DCDC4_VOLT
 
 config AXP_DCDC5_VOLT
 	int "axp pmic dcdc5 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || \
+		   AXP803_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 1500 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
 	help
 	  Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
@@ -255,9 +268,28 @@ config AXP_DCDC5_VOLT
 	  On A23 / A31 / A33 / A80 / A83T / R40 boards dcdc5 is VCC-DRAM and
 	  should be 1.5V, 1.35V if DDR3L is used.
 
+config AXP_DCDC6_VOLT
+	int "axp pmic dcdc6 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc6 at, set to 0 to
+	  disable dcdc6, or -1 to leave the OTP default untouched.
+	  On the Orange Pi 4 Pro, dcdc6 supplies VDDQ-DRAM (0.5V-0.56V).
+
+config AXP_DCDC7_VOLT
+	int "axp pmic dcdc7 voltage"
+	depends on AXP318W_POWER
+	default -1
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc7 at, set to 0 to
+	  disable dcdc7, or -1 to leave the OTP default untouched.
+	  On the Orange Pi 4 Pro, dcdc7 supplies VDD2-DRAM (1.05V-1.08V).
+
 config AXP_ALDO1_VOLT
 	int "axp pmic (a)ldo1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0 if MACH_SUN6I || MACH_SUN8I_R40
 	default 1800 if MACH_SUN8I_A83T
 	default 3000 if MACH_SUN8I || MACH_SUN9I
@@ -272,7 +304,9 @@ config AXP_ALDO1_VOLT
 
 config AXP_ALDO2_VOLT
 	int "axp pmic (a)ldo2 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || \
+		   AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3000 if AXP152_POWER || AXP209_POWER
 	default 0 if MACH_SUN6I || MACH_SUN9I
 	default 1800 if MACH_SUN8I_A83T
@@ -290,7 +324,9 @@ config AXP_ALDO2_VOLT
 
 config AXP_ALDO3_VOLT
 	int "axp pmic (a)ldo3 voltage"
-	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || \
+		   AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0 if AXP209_POWER || MACH_SUN9I
 	default 3000 if MACH_SUN6I || MACH_SUN8I
 	help
@@ -347,16 +383,50 @@ config AXP_ALDO3_INRUSH_QUIRK
 
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
@@ -366,7 +436,8 @@ config AXP_DLDO1_VOLT
 
 config AXP_DLDO2_VOLT
 	int "axp pmic dldo2 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 3000 if MACH_SUN9I
 	default 0
 	help
@@ -376,7 +447,8 @@ config AXP_DLDO2_VOLT
 
 config AXP_DLDO3_VOLT
 	int "axp pmic dldo3 voltage"
-	depends on AXP221_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic dldo3 at, set to 0 to
@@ -384,7 +456,8 @@ config AXP_DLDO3_VOLT
 
 config AXP_DLDO4_VOLT
 	int "axp pmic dldo4 voltage"
-	depends on AXP221_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic dldo4 at, set to 0 to
@@ -392,7 +465,8 @@ config AXP_DLDO4_VOLT
 
 config AXP_ELDO1_VOLT
 	int "axp pmic eldo1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic eldo1 at, set to 0 to
@@ -400,7 +474,8 @@ config AXP_ELDO1_VOLT
 
 config AXP_ELDO2_VOLT
 	int "axp pmic eldo2 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP318W_POWER
+	default -1 if AXP318W_POWER
 	default 0
 	help
 	  Set the voltage (mV) to program the axp pmic eldo2 at, set to 0 to
@@ -408,7 +483,8 @@ config AXP_ELDO2_VOLT
 
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

