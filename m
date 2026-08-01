Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07DCC55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64B8B80EC9;
	Sat,  1 Aug 2026 16:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZzzcYPtchud; Sat,  1 Aug 2026 16:42:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AE0980EC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602531;
	bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1S4chAmK7MZ8lNOwRq4EsVbPH8JwquTId7IVJ2kQ8Izm7zWJRsZCWPST1nglYiP/
	 hWYbjTjBNPVg5n56I023GTU3Zn7ybGiN7gs6sWxx9Fw0KVDN29dlyTEDCGUPjdV+2D
	 pqdOXo3Pjx40F9vXsbTMjbZGfZRxSorjwSFkRF6/NTpT+XOBKzjtHQ01ozps8BTssX
	 dKiAoOlljk0J3bZPq1DblBxB7tbfOzowJOE6jhOyfgq4vPX3oZxreAP1NvDENTfEWI
	 M2gV5Tzs+u56VNnIOWBXmlwhBzSDN7LgTAV2VBBE5z+agEd4pMDNyJ01XNVVYLfS4k
	 a/M/zI0x3DxaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AE0980EC6;
	Sat,  1 Aug 2026 16:42:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A63BE3B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D2346070C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEFp6YZnKeJE for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5573A6070F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5573A6070F
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5573A6070F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:08 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca80d708489so1225593a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602528; x=1786207328;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
 b=dtmZpHTbW07ozOdTP3h2R+VGAuYoJRSAaE+DJCq7KXKnjXgnFP99myy2pCUJRVp3pX
 9R3kSoRXbSMLsgfH2uR7tb1vbxxRVldqsXlcRRl6mSX77ZqMVw6/xGFXLOVo7wFw/fa7
 IcDds+sraxAx6WSJudZa/ry7X87wBerNBJApMoEqHHFlmsCfcvaRj7DM2a3SDWq9cI3W
 6G99ShN5NdvOK8ZqRUrkbJExgpJIzCxB5jIosvRmJGXx3wmTaCGxKC1pfNdL67dzJT0O
 YQmAuf78Uz8Tdd4TkDXMZx7Fp3xXabYU3tDJfWARkrsS6qOEcvVQy5k6Q/Qm4qo2g7m3
 xQFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RptKZuDjNqARFb21pe+lkRDUIi+j9qHWV9xYuWKCtOrUmI0LzlVzolmZWS4zHJT9yrwCwpgdfs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxUEBr4mwIGO3TcKTKPJSjJwU+vDvZZr4YENEmibdNlvK9aoZmp
 43KNi2KMPO3/hK/7o/+nT0ld+m+vbtUbvorNH20DY4j/55KdUqyhGTZiclZpa2+wn0Q=
X-Gm-Gg: AR+sD10u+yUIQMOpXGuRphW17pqh/YxDiExpAZjUN3fYXpCY7JBucrvifPVNe7SZ2QY
 +GGZMBl/6iPkieiREspuRBLNWUCX4U5R1o9tw2d0DueNnFP34rHzf4ReiFOGJozmYMd8CQAW+5O
 dE4O1AvHhFbCKhuxjKmcFgB1+b5oo5ylhOSh90rEEcwNBN88+ba4S2cbfxNpLLl09aDm3HT1DTk
 nwSqYtrA9tuzWZkGAqEC+drlA6qN5se4rikllcESsqcK+0o5OdSmog+qkmr0BfkyEKGFhtteFYY
 VvZU74B5zuK0gKQ9lcGFAy28t2PE9JCKEN5h0l/zVV9tZDHJnFjEkqJkqL55nxeq6VfFngnh3zR
 xibblrH7zqjph0w6x2k7sgycug7HYlWVhffHxkW+5VQwAaMC56of1xgrE1z2C0orwrIaMVDL8UF
 4UD0XF/ELAYUC7OdlNuz+CL2YXC6CDC9NzHh6l/WJIrmb4iuSm1HLP6ERHLWb7/hkIkB5mn8fDv
 IMEdfx1/Its4OhkYBhq0FLOitGDhR2dd6rCL1uN3B+ypsFg5OukWBeyfGMy+3RZDpvX7i0EQPCg
 lxTtsfhTkqvc7MYzXbTwKAqVSA==
X-Received: by 2002:a05:6a21:6089:b0:3c4:2cd3:f0bb with SMTP id
 adf61e73a8af0-3c91a777750mr6648944637.10.1785602527652; 
 Sat, 01 Aug 2026 09:42:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:42:06 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:52 +0800
Subject: [PATCH v8 11/11] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-11-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602528; x=1786207328;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
 b=JpNZzeqCQ9z+5CoRNzIJlkyG+yd/LFp26cQF9CzM830Km9R5cMd42rJNTa4iS2e3gW
 Rz1Fty4CvNocqyhG7b/XycbAbmDNUv0qpQkIOzdEsBhg2I5qIzgAAEmO1gFMeR3VDvYY
 a2CKOT61C/H/iSOfe5tg6h525pVmfTFfmfFsCeRjnGt/xGc1msOAiMZlTZb9aytOjXZH
 rlNVgwdJByo6eQuHP54YzCwOXj7FRfzDnMsKG0zXKO2q1bh5vjMPIojH6HcSTPDQpA+6
 VYQADABgyUoWXTr8+Fm8lHiwbT383hr8W7syAeW1JvSJcAt+5S1IpvkvLBk/KnyFxow5
 NIcQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=JpNZzeqC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use a table to handle DTB matching.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Abandon to load product name from ENV.
v6:
- Rebased onto latest upstream. Cleaned up board_fit_config_name_match()
  to maintain consistentcy with v5.
---
 board/spacemit/k1/spl.c | 50 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 613e8c4cf02a..9f200f2fc184 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -97,6 +97,15 @@ static void i2c_early_init(void)
 	}
 }
 
+static const struct {
+	const char *eeprom_name;
+	const char *fit_name;
+} k1_board_map[] = {
+	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
+	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
+	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+};
+
 int read_product_name(char *name, int size)
 {
 	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
@@ -130,6 +139,27 @@ int read_product_name(char *name, int size)
 	return -ENOENT;
 }
 
+static void fixup_product_name(void)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
+		memset(fdt_name, 0, I2C_BUF_SIZE);
+		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
+			     strlen(k1_board_map[i].eeprom_name))) {
+			snprintf(fdt_name, I2C_BUF_SIZE, "%s",
+				 k1_board_map[i].fit_name);
+			break;
+		}
+	}
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, CONFIG_DEFAULT_DEVICE_TREE);
+	}
+	memcpy(product_name, fdt_name, I2C_BUF_SIZE);
+}
+
 static void clk_early_init(void)
 {
 	struct udevice *dev;
@@ -369,6 +399,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", product_name);
+	fixup_product_name();
 	pmic_init();
 
 	ddr_early_init();
@@ -432,24 +463,7 @@ void spl_board_init(void)
 
 int board_fit_config_name_match(const char *name)
 {
-	char fdt_name[I2C_BUF_SIZE];
-	int i;
-
-	memset(fdt_name, 0, I2C_BUF_SIZE);
-	if (!strncmp(product_name, "k1-x_", 5)) {
-		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
-			 &product_name[5]);
-	}
-	if (fdt_name[0] == '\0') {
-		/* set default board name */
-		sprintf(fdt_name, "k1-musepi-pro");
-	}
-	for (i = 0; i < I2C_BUF_SIZE; i++) {
-		if (fdt_name[i] == '\0')
-			break;
-		fdt_name[i] = tolower(fdt_name[i]);
-	}
-	if (!strcmp(name, fdt_name))
+	if (!strcmp(name, product_name))
 		return 0;
 	return -ENOENT;
 }

-- 
2.51.0

