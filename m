Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04845C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 15:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 817B084AC5;
	Tue,  7 Jul 2026 17:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="PnaBqucm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D828C84AC7; Tue,  7 Jul 2026 17:23:12 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF212849B1
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 17:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3351590a91.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783437788; x=1784042588;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QYx5slSjGDzOuqlW2pxq73xV7d58n7Lf9UNUClClsFM=;
 b=PnaBqucm5j3NJcd7BgPt8szrPcVqd3+KZ17OTrMzt9jyUunkqKhhdCm03Ac4eza43s
 93LqAWBfuVADH/4mnCeJnEtbzJhf4ypwxZeyCvWRY6P7YCfN1DjIcks3WVuUqtG9PjhV
 d5TO3EWHB39+BX0HtE/byA8YEtPo/+G2n68HD3+6Km0ibXZ0hFH04eg7Zllpv+LwjMaE
 a5U3OtaiZdqadbI6I3cRJ2oFJxtP8cpSlX1+jGd3ts29hrdknM+ggOE9HyaotrNn3FZV
 KCRloEV/KDmE86PwxPfxeuPQsbzTiZ4HXvhaeZ66gYlDQYD25BzZXEvHbI+DXuOK1cpe
 qawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437788; x=1784042588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QYx5slSjGDzOuqlW2pxq73xV7d58n7Lf9UNUClClsFM=;
 b=ROTXGsZLMiQ41PWDS5OfTcw2b3Hk61cUIDWkLxf2Uf/zCG2a/oy6pmrSj092y7rh/b
 /Ou4zBP+EcUOHTpdzHinM4G/jInxnVzTPjItxu5H1fvAHWLPIX4Z6/fqS/yil4K0bVu6
 w6v2wk2Gu1LJGpN+XYjOx54WJHMf/UCp0ncmVjRsHSywHBQhH+n/PyS5tdS26j6u9UTv
 p7sf9JvOZ+kEg0lH3M5DidmuGZ5ynwS+uGkyZfLkY4gHRUwCumLk7nGhkr4xo9u9PSHo
 0mE1Pr3ZwEY8sjFEpAyO7tZSzEChsHjkP705OM1ImUHxXQORQ4An8VI5AEFyiTcxTh8+
 /LnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnJeEFueC8MZbdyB1/sIX7AaKcEd8wg9tbZGYNHQVMB88U6WMRLjAUplaLj7OkRPIpVBqfKqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwkNLHjccjBcXPfn+f74QH/Hg6XWeRLy39jdltx18/PQw0YAfC7
 yHLL0Nq1pkbYBDFU2PBljWZ0rKV37SpLCv8xabxZfHMOVLzLdHTi5KggdQaxVtqvdSQ=
X-Gm-Gg: AfdE7clRtNopWdBdpOV36u3lngRfYP1lIaj4FyvCKHO0tSfp69ckcAlggk2Yz3U0Dph
 d47tld6BOSexuYeGU+pFWxghNmcsQ1PmS+jaVmHZJEHVWAwZV5R7AlY9zTZcNoFert/OkJgNdkm
 EB/52N1DLrkPQKGSjZcfMeFrh3pjoXaa1EVeep9DPop0QH5MNO49SzmMUO81iou6Eh3V0YnD1RL
 CC0rq7xGzqrpDOQWxYTFOt5eqrkcmQy62Sj5co1CAgtoMWfhN+XoWmOJn9HDlfA4HzfKCnDGKsL
 IctWBRTs3N53DFOCFLH8rCuPume0wdoLOk7jbUR7ArfVzYbnE9aM6cEtLhjPc+NHLrGAoxYHOX7
 4w8737oHeWOypSNVYuMbW8hR9jWfirQczr1SVza41gruKQW0nxuwjPYongwjBYOet+IucDinFMX
 ILmkl/wUwu/1KEYOOA/zubY3L5yb6Jd0uFb+otSd+3nJblIwQyjDQekdP0ms/dfrnujZ0N9V1QN
 9rAzX8Ja747dL5lgKdtQXeuK1O3IL8RA7I34cVH/gaNgauKja2rMg==
X-Received: by 2002:a17:90b:1646:b0:381:cef1:11b0 with SMTP id
 98e67ed59e1d1-38758554767mr5814064a91.33.1783437788452; 
 Tue, 07 Jul 2026 08:23:08 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483ddd1sm9594997eec.9.2026.07.07.08.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:23:07 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 07 Jul 2026 23:21:51 +0800
Subject: [PATCH v4 10/10] spacemit: k1: load product name from environment
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-m4-v4-10-dbd01185f911@riscstar.com>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
In-Reply-To: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Read the product name from the environment instead of EEPROM,
as the EEPROM may not be programmed and the environment always
contains this information.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 board/spacemit/k1/spl.c | 51 +++++++++++--------------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 70579637b5e..1387c2ef9b3 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -12,6 +12,7 @@
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <env.h>
 #include <i2c.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
@@ -96,39 +97,6 @@ static void i2c_early_init(void)
 	}
 }
 
-int read_product_name(char *name, int size)
-{
-	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
-	struct tlvinfo_header *tlv_hdr;
-	struct tlvinfo_tlv *tlv_entry;
-	int ret, i = 0;
-	u32 entry_size;
-
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
-		}
-		if (tlv_entry->type == TLV_CODE_CRC_32)
-			return -ENOENT;
-		entry_size = tlv_entry->length + sizeof(struct tlvinfo_tlv);
-		i += entry_size;
-		p += entry_size;
-		tlv_entry = (struct tlvinfo_tlv *)p;
-	}
-	return -ENOENT;
-}
-
 static const struct {
 	const char *eeprom_name;
 	const char *fit_name;
@@ -140,9 +108,15 @@ static const struct {
 
 static void fixup_product_name(void)
 {
-	char fdt_name[I2C_BUF_SIZE];
+	char fdt_name[I2C_BUF_SIZE], *name;
 	int i;
 
+	memset(product_name, 0, I2C_BUF_SIZE);
+	env_init();
+	env_load();
+	name = env_get("product_name");
+	if (name)
+		snprintf(product_name, I2C_BUF_SIZE, "%s", name);
 	memset(fdt_name, 0, I2C_BUF_SIZE);
 	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
 		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
@@ -451,13 +425,10 @@ u32 spl_boot_device(void)
 
 void spl_board_init(void)
 {
-	int ret;
+}
 
-	ret = read_product_name(product_name, I2C_BUF_SIZE);
-	if (ret)
-		log_info("Fail to detect board:%d\n", ret);
-	else
-		log_info("Get board name:%s\n", product_name);
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
+{
 	fixup_product_name();
 }
 

-- 
2.51.0

