Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B84AC47DD3
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 23:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C38E876F4;
	Sun, 21 Jan 2024 00:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVViGrg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A9B87869; Sun, 21 Jan 2024 00:28:23 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7D5875C5
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 00:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fr0st61te@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso2415902e87.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705793301; x=1706398101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9edRhZV4RNwO8Pc3qdkyouN8izXXmhlK/VxhTNYo/PU=;
 b=WVViGrg1yFQq0Pmff51y3NzxQ91R1L+cOT9jqAtibbdaMhcnoRbeD7kl8DWOHiKuLq
 K6FPaoZj2mpfkpbVauvnBFtHKZ/fQuzZ74ox+PggGlBuNX8sOH01BlX3ublHpWHD/8lq
 norunOwY8Eh1PzaV9JDIhPwe/KMgEEM+r1zs8Zoojhm//7GJY2QSg49H6k0L5AVxCXkk
 ik/xnnfCqQrbKxWyZHfNI6Jiy9Mp/UugSx4majOaAT37hIR8IapuoTDxKOm5fe54CBaK
 7lajzof+D6zzDTOxe1kP670T/6B1O3SLB9lN8UOVFzDB1Sb2hE8CKbGFQ8RkCtiN087L
 yHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705793301; x=1706398101;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9edRhZV4RNwO8Pc3qdkyouN8izXXmhlK/VxhTNYo/PU=;
 b=rxdSd8nVAbHn9S+ofTUnGa2fon4BPTJKIi8WwS06h4+ytQvwemvLKzrX+IdDsa1Sba
 P7b3Kud4xuiFmY0fJbBQtXEJGvY+e+XTd3ebTU76c663Ts2gwmG65IgzJZ8FiOKl8JO4
 8nm3B8erSS9d/T8VuVIKDyyCVSYJVQ1o3jhCZD/OVsTLVUKvLPC92LWq/pJAIxSj23bp
 MZ8Ul1rvNLun9XPgWSyjIdvxQcB14sE3Ujkj13bdF1DJiJP9HBErmdKEbI78kpnXQ2Xb
 uKqOCAbI1lmXyJbCK7tVf67awPYsJrSe5JFrLwsuWVwZCR/DbmtDvkwy8ktJq9sbVzlg
 RFWg==
X-Gm-Message-State: AOJu0YyV9X/rvfYgMxuxzP7PJRQjsM7wzAFuomK4QJZ84brtZUZx27Cl
 vo7WeHPkh/+ASnkPR9BBOWUUih3E5cjN0+D+2la5xeJrMq9cdm6+1PrylDLOlAzCnw==
X-Google-Smtp-Source: AGHT+IGqec656dWjXblkH052MdUsIYmWTp/Q3eb+cv7rSNv1hkNN5duWuf/ufF1K1+lZAgZROGg/NQ==
X-Received: by 2002:a05:6512:3b90:b0:50e:d5e2:92cc with SMTP id
 g16-20020a0565123b9000b0050ed5e292ccmr1187939lfv.81.1705793300877; 
 Sat, 20 Jan 2024 15:28:20 -0800 (PST)
Received: from fr.lan ([81.200.17.74]) by smtp.googlemail.com with ESMTPSA id
 x25-20020a19e019000000b0050e77abd553sm1475416lfg.76.2024.01.20.15.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 15:28:20 -0800 (PST)
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, openbmc@lists.ozlabs.org,
 Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH] pinctrl: aspeed: add pass-through pins and siopbi/siopbo
Date: Sun, 21 Jan 2024 02:28:13 +0300
Message-ID: <20240120232813.32474-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add THRU0-3 and SIOPBI/SIOPBO pin groups/functions.

Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 arch/arm/dts/ast2600.dtsi                | 20 ++++++++++++++++
 drivers/pinctrl/aspeed/pinctrl_ast2600.c | 30 ++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/dts/ast2600.dtsi b/arch/arm/dts/ast2600.dtsi
index beabcf14f8..43db80edfe 100644
--- a/arch/arm/dts/ast2600.dtsi
+++ b/arch/arm/dts/ast2600.dtsi
@@ -2028,6 +2028,26 @@
 		groups = "SPI2MOSI";
 	};
 
+	pinctrl_thru0_default: thru0_default {
+		function = "THRU0";
+		groups = "THRU0";
+	};
+
+	pinctrl_thru1_default: thru1_default {
+		function = "THRU1";
+		groups = "THRU1";
+	};
+
+	pinctrl_thru2_default: thru2_default {
+		function = "THRU2";
+		groups = "THRU2";
+	};
+
+	pinctrl_thru3_default: thru3_default {
+		function = "THRU3";
+		groups = "THRU3";
+	};
+
 	pinctrl_timer3_default: timer3_default {
 		function = "TIMER3";
 		groups = "TIMER3";
diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
index 97e8b4ec9b..8a4f9705ca 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
@@ -267,6 +267,14 @@ static struct aspeed_sig_desc fmcquad_link[] = {
 	{ 0x438, GENMASK(5, 4), 0 },
 };
 
+static struct aspeed_sig_desc siopbi_link[] = {
+	{ 0x418, BIT(6), 0 },
+};
+
+static struct aspeed_sig_desc siopbo_link[] = {
+	{ 0x418, BIT(5), 0 },
+};
+
 static struct aspeed_sig_desc spi1_link[] = {
 	{ 0x438, GENMASK(13, 11), 0 },
 };
@@ -303,6 +311,22 @@ static struct aspeed_sig_desc spi2quad_link[] = {
 	{ 0x434, GENMASK(31, 30), 0 },
 };
 
+static struct aspeed_sig_desc thru0_link[] = {
+	{ 0x4bc, GENMASK(25, 24), 0 },
+};
+
+static struct aspeed_sig_desc thru1_link[] = {
+	{ 0x4bc, GENMASK(27, 26), 0 },
+};
+
+static struct aspeed_sig_desc thru2_link[] = {
+	{ 0x4bc, GENMASK(29, 28), 0 },
+};
+
+static struct aspeed_sig_desc thru3_link[] = {
+	{ 0x4bc, GENMASK(31, 30), 0 },
+};
+
 static struct aspeed_sig_desc fsi1[] = {
 	{ 0xd48, GENMASK(21, 20), 0 },
 };
@@ -458,6 +482,8 @@ static const struct aspeed_group_config ast2600_groups[] = {
 	{ "EMMC", ARRAY_SIZE(emmc_link), emmc_link },
 	{ "EMMCG8", ARRAY_SIZE(emmcg8_link), emmcg8_link },
 	{ "FMCQUAD", ARRAY_SIZE(fmcquad_link), fmcquad_link },
+	{ "SIOPBI", ARRAY_SIZE(siopbi_link), siopbi_link },
+	{ "SIOPBO", ARRAY_SIZE(siopbo_link), siopbo_link },
 	{ "SPI1", ARRAY_SIZE(spi1_link), spi1_link },
 	{ "SPI1ABR", ARRAY_SIZE(spi1abr_link), spi1abr_link },
 	{ "SPI1CS1", ARRAY_SIZE(spi1cs1_link), spi1cs1_link },
@@ -467,6 +493,10 @@ static const struct aspeed_group_config ast2600_groups[] = {
 	{ "SPI2CS1", ARRAY_SIZE(spi2cs1_link), spi2cs1_link },
 	{ "SPI2CS2", ARRAY_SIZE(spi2cs2_link), spi2cs2_link },
 	{ "SPI2QUAD", ARRAY_SIZE(spi2quad_link), spi2quad_link },
+	{ "THRU0", ARRAY_SIZE(thru0_link), thru0_link },
+	{ "THRU1", ARRAY_SIZE(thru1_link), thru1_link },
+	{ "THRU2", ARRAY_SIZE(thru2_link), thru2_link },
+	{ "THRU3", ARRAY_SIZE(thru3_link), thru3_link },
 	{ "I2C1", ARRAY_SIZE(i2c1_link), i2c1_link },
 	{ "I2C2", ARRAY_SIZE(i2c2_link), i2c2_link },
 	{ "I2C3", ARRAY_SIZE(i2c3_link), i2c3_link },
-- 
2.43.0

