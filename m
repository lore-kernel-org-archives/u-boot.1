Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3559C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 07:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71F0580C16;
	Mon, 27 Jul 2026 07:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0s9rrBUi5_x; Mon, 27 Jul 2026 07:00:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81FCB80C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785135633;
	bh=r8ysNahpUeOon0uCVm7rmTD2QMmoSqNGAgE1F6YY5Hw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZqY3pmsa/CpiEuFGad97w1Tm8gBvvakZlogE3iMHLxlLtuWIMbc9Kty9+oz6DuS9C
	 jWndPJEseDFrDVDdJX9dgJhpuoas6XJfda2rogMlgItO22S1eSfYLXXm4VdLckUHKQ
	 Oy/KivhYR9evPcDVteQAfD5bPb8UNO1kAppXTjaKOYf8GUylN5v4OtrVQgUJazcqCE
	 J+piItw69hvcaDHxXYRghAmyvwlgRVzIDS/dLUmK0iu6fW7rd67qL7rjXw7Jirvd7b
	 2HNzFI1Y4MjDNHJb66tkI+tirq3DdpHmrS272pJ+PfXngv0knjlvp1EQbT9T3anKuG
	 KroZXYfna77Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81FCB80C74;
	Mon, 27 Jul 2026 07:00:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 487262E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39C1E80C76
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uzbf-mO0cMFV for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:00:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 730A580C74
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 730A580C74
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 730A580C74
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:00:31 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so2361825b3a.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785135631; x=1785740431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r8ysNahpUeOon0uCVm7rmTD2QMmoSqNGAgE1F6YY5Hw=;
 b=DvYMZLGVw9oNnilHGolHVa0EzvcXZxE8rlOsnkC/MxnfZz3irceQsts9gScKLBVHiA
 z+wngm9rvHFwJJqNxN5rkTDArKa2i3sDW5mqnA0iGZVzlPgwWhDwwQd9FD8PVjGj6qW9
 AuNMddL3i4WgwfstNxcpN+HUgnIsOlgQgAKz0L6QOI/xoEtNxNaRj7v1ltwSuP4t5Ja+
 S3j2/r7fpAkPcZ3DWgeGIHP7ERsByRs1+LHZ2W6+MGJJ0ycCuxMCoj03mh+lYUQEhzJn
 MsrG4u30WP/f/FW6fx01g8A3giUQVf4jOvwcHqD3DoyXYeaS7HqO5HyrBk5LdpchwVqx
 xKiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrG92GssHNDcIfTGUZO9KcGcksssBFFWN5aVwkU/vlTLOwdwxKBUPVxABB6abw6ymE8fqsLhSw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzFHwoObs0CVkctK8XOaXh/9wSoXnyNSzuU7uz05C/2FCRmDUzZ
 F6Xi6FW5KrvIJEJOjW4fiy4qwYGTJUeTG3FdMOuHKRfDBAdyK6sT69q+kz6O72Uj4DY=
X-Gm-Gg: AR+sD116u9dbkyRNlRBR5QHlwUqlDUPSc5BqUZOrjgH6aJxtxLJrqy2Z3GGc9KI9YUr
 uA6qBYlcneAcj29WY+jGBKM9MMYXhoJka1Id6/IYDaTbO3MyKmRFjHel2OibZD5E6cBuwbIegqF
 pQ1ox42OuKPpYn22DRDym3IhFcQDMVMs8xFKnCmshvPLfSyzgWvHvorntkSuuZBDFDzzwIJ8+lz
 pPLHuaD5y3QmMKFjqitKRSwzTx9LNTS4MbhxeSE1i6DSTlT2x/O1KYdyBXJFI2DWJAQzgrDBDXq
 +2q+JCxXX0XtFpPTzd+a+K0j6lfCiP4h60bYVGSYcw0H0fkiCduWpFIMNF71sfjdA0pSHbNSbmJ
 yTFiXa9EiQEXknwgprnIfyqQwlrkL5Xcs4IY7u90yI09pMFdtHqJlgycKVxZk5ttDIdy6HPsr7x
 O7TUxznnzcHCGQ/7p2KLFK6iUp6JoKQGj0n4T3L2Z4hY6y2dTVlMfWC3GyUqSnI7ExE2bpGgv6O
 dWk/mGtVqkEt1mJ1S5PPFYX1ah6KYtvkr8gVBP2HosM9rgFHBKUNw==
X-Received: by 2002:a05:6a21:9204:b0:3c3:859b:9178 with SMTP id
 adf61e73a8af0-3c67daf4382mr6807331637.34.1785135630601; 
 Mon, 27 Jul 2026 00:00:30 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm22969489c88.11.2026.07.27.00.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 00:00:30 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 27 Jul 2026 14:59:13 +0800
Subject: [PATCH v6 11/11] spacemit: k1: load product name from environment
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-m4-v6-11-2f58566d48ca@riscstar.com>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
In-Reply-To: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785135631; x=1785740431;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r8ysNahpUeOon0uCVm7rmTD2QMmoSqNGAgE1F6YY5Hw=;
 b=qOg5ApKTVaKpCxTF4lx5LNyRmvvD0+3rFal8XuOMr5SU4B01aPYhnAdjf4xya/pCid
 Bj6behnDa/55oOVw5EL+fbDqEqByerEqFGPHa2TuxcLOsEOtp4tyhOZQ2x3EUwo/M+7D
 aa0uFCpw8JvCpWnKVp/Xv3BJprEtlqhxLqmpbqgfeQepGD8bP8xU9/w15XuHtDqqUO3g
 zTpU0jC7S7XpBFyTgs3yrbZpqZwTWCAe0Obox3NZqX6kVGs5US/ReB7VhHp/ECuKiQgK
 q7hIAbCUkuiWyIQvPNTchgpnwaSPjcEvYZYN+ZZl3lVFNJ5VyW8Z+HdXJxYHWO6l6b7C
 qmOA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qOg5ApKT
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

Read the product name from the environment instead of EEPROM,
as the EEPROM may not be programmed and the environment always
contains this information.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v6:
- Rebased onto latest upstream. Cleaned up board_fit_config_name_match()
  to maintain consistentcy with v5.
---
 board/spacemit/k1/spl.c | 89 +++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 613e8c4cf02..69c992ea57a 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -12,9 +12,9 @@
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <env.h>
 #include <i2c.h>
 #include <linux/bitfield.h>
-#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
@@ -97,37 +97,41 @@ static void i2c_early_init(void)
 	}
 }
 
-int read_product_name(char *name, int size)
+static const struct {
+	const char *eeprom_name;
+	const char *fit_name;
+} k1_board_map[] = {
+	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
+	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
+	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+};
+
+static void fixup_product_name(void)
 {
-	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
-	struct tlvinfo_header *tlv_hdr;
-	struct tlvinfo_tlv *tlv_entry;
-	int ret, i = 0;
-	u32 entry_size;
+	char fdt_name[I2C_BUF_SIZE], *name;
+	int i;
 
-	if (!name || size <= 0)
-		return -EINVAL;
-	ret = read_tlvinfo_tlv_eeprom(eeprom_data, &tlv_hdr,
-				      &tlv_entry, i);
-	if (ret)
-		return ret;
-	p = (u8 *)tlv_entry;
-	for (i = 0; i < tlv_hdr->totallen; ) {
-		if (tlv_entry->type == TLV_CODE_PRODUCT_NAME) {
-			if (tlv_entry->length < size)
-				size = tlv_entry->length;
-			memset(name, 0, size);
-			memcpy(name, &tlv_entry->value[0], size);
-			return 0;
+	memset(product_name, 0, I2C_BUF_SIZE);
+	env_init();
+	env_load();
+	name = env_get("product_name");
+	if (name)
+		snprintf(product_name, I2C_BUF_SIZE, "%s", name);
+	memset(fdt_name, 0, I2C_BUF_SIZE);
+	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
+		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
+			     strlen(k1_board_map[i].eeprom_name))) {
+			snprintf(fdt_name, I2C_BUF_SIZE, "%s",
+				 k1_board_map[i].fit_name);
+			break;
 		}
-		if (tlv_entry->type == TLV_CODE_CRC_32)
-			return -ENOENT;
-		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
-		i += entry_size;
-		p += entry_size;
-		tlv_entry = (struct tlvinfo_tlv *)p;
 	}
-	return -ENOENT;
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, CONFIG_DEFAULT_DEVICE_TREE);
+	}
+	memset(product_name, 0, I2C_BUF_SIZE);
+	memcpy(product_name, fdt_name, I2C_BUF_SIZE);
 }
 
 static void clk_early_init(void)
@@ -364,11 +368,6 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 
 	i2c_early_init();
-	ret = read_product_name(product_name, I2C_BUF_SIZE);
-	if (ret)
-		log_info("Fail to detect board:%d\n", ret);
-	else
-		log_info("Get board name:%s\n", product_name);
 	pmic_init();
 
 	ddr_early_init();
@@ -430,26 +429,14 @@ void spl_board_init(void)
 {
 }
 
-int board_fit_config_name_match(const char *name)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
-	char fdt_name[I2C_BUF_SIZE];
-	int i;
+	fixup_product_name();
+}
 
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
+int board_fit_config_name_match(const char *name)
+{
+	if (!strcmp(name, product_name))
 		return 0;
 	return -ENOENT;
 }

-- 
2.51.0

