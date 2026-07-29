Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AA7C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE43440856;
	Wed, 29 Jul 2026 14:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPck00XzlEIL; Wed, 29 Jul 2026 14:49:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B34F540801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336593;
	bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0S5aCgqd93BhS1Y9GkuO60Zz/IXWkSL4p1sQobjefBYMM1m6kL2+OPqy9cgoh9bUN
	 39PvTq4GKq9KSdtIxcR5t+W8wnjUs1Im+h506awX3ucdXv3X+A+IK5kkRs4pYS+RiD
	 ayLNZSjg3jeUsiHNqQGTQPAxYAHdx7g5DRarCjSm1LPJFGZt2e6t/MZV88od6+7xyy
	 JjPfe8I5GNdzjtUUIXfgGjG0xjh1lalxgTm79Xs6lLDn4FXBovzGi/+eaTeNeqxBG8
	 wn8FSKc9CXrQqRuUtiPUXgp6iRi26l8FJrbYVrItTSIdkIKErhO5UTIRNYOaDjjUWk
	 7zvTUcO8aTg9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B34F540801;
	Wed, 29 Jul 2026 14:49:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5C273B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B37D880AF9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CAtsTZg2z5S2 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1569880AAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1569880AAE
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1569880AAE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:51 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso703884a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336591; x=1785941391;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
 b=SefIMyxcVD3jDTyydP+z7TVm0Ax3abNLc5AJEmPLHEN+Ck56Y5GiKwdQD8r9EY5jj/
 +IVniouEnpIsES6AMRBX4xzE5uuaqmCEyUjTiK+pGVVw/HO9gER/r5d1e6ep7R4vjJFB
 g8F8tbWGQf0QaXCeDLQX+5njzQL6aQUUbtcmRjDWpV+luFDNZehIpZmdN/4C+97hjrnb
 y2eIub5ItKM20kZO/slMLq2QT34u+O5Mog9fF2VG+RbCbnwb2f96lHVG9NovTgTZ4eMt
 k0Q1i54kChGvHvRC+TGeQ4S/O9zlHZPnqu8ABA0C0fluDLZ3y/NwHnN2l761pa3y/ZT1
 8KHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdHdZzAejfGu863F0chSWRhFL4ssgHoFt1dxTVRY40bt+dOUg0z8fetKq8mK5eTYcWA+iP5wg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyCcxEVWSmSQwV/tcSyQopWaJDHloJM6CqtOY2OivzwlWtRKPAV
 kSw6N6WCue+sPNf4kapFwz2ayYjH7RbMmayoaqQDuMNP0ahj6cnFX2a6TjEICvkNJpA=
X-Gm-Gg: AR+sD13fD2SLuifCxfIez+Lbyr+eeQ/ue+tTbfSb/fr04P1T5UoHEJkb4KjVaXr5mhJ
 6eXy/BMmsgUzwbGfqoRtb/3gCE4fokv8r7gptu7I9BNSK8J21UE+l4PvTc65scr2tr//uCviZHn
 CblqVB6EmsHVzXYm1XSsKjhuTplDt+Diz3Y8qhVQc6jmppYMTIKXLiZ7QzrGKd7vm/bkUcKsnLY
 lU1yw7HwAdOPYTAMl8M4IoVfluOYO6SbW54enCtuSfhaIfh34o/uuyQ2jU3iX97eP01A3e2aAOA
 LJED2jCpviI2/uHrsK8nlSXCoH0g5ZG4B40iI8DDDjiP/mZHD7mWftJwmrEVVtstEPkcSTAD/1H
 v5XluG1skcPt9JyhJG56Ae080Ucc4zWWrH9IAGlOWs+qf/fSB/gDW19LLpjBsVgImp3QYACTTMz
 9/u+sWrp/4fr7Yu665YMHlvGvD9nBVlDXF3zrORnRTcSOtcDG2BX4x6lGdsKxIHsPSUvthUv8KT
 /MpJyYJHcmlADi2uGJu9iI+6WM3Xt679WUQpVg5GIOCktEIQXKg7JmjtMyy4MDZ94xsWRXF/qVM
 fkTJbgrrZscDEKRmaWiT5zhEU7X5ogrnwiMS
X-Received: by 2002:a05:6a20:e291:b0:3c3:7a0a:18a7 with SMTP id
 adf61e73a8af0-3c8ba5adcb9mr8271025637.55.1785336591348; 
 Wed, 29 Jul 2026 07:49:51 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:50 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:29 +0800
Subject: [PATCH v7 11/11] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-11-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336591; x=1785941391;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKmnvLFSvmbrwKauHOlEp0XRYx6izjeRSN+qLb3Vtqw=;
 b=iZfysD/Lm2ctqQkkvyFcACQsWxNMbXoy616IFsXq+2GLUBYaUQNy5JASazqaHxvCzS
 MHHm0OwCTu2rmiJ3mcIC+ImpU4zeu6sYppE74x4rJo6VUmXUoP1iLP+vj84C7bfghU5n
 IU58ZNoE68t/6GPaCkx4B4DNmiZDnt4f5FgU0+KrmTtALetJ5stsBMlXFtU2J0/j3Vqb
 fKAgPfwvceZ3TcUwqRcDnKT2NPxRABrYZjOAKm1TqSg7SvJzM4EnpQNXZcH1+bXpyMu8
 KZrqhpVQRrvF9DwYsaP7A3NrgzrfBTMZXvy3DY2mJZyG4eS8cENzNp7hOXbgzsvcmOsu
 EIjg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=iZfysD/L
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

