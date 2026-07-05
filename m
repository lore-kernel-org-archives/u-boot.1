Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F9C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AEE849F6;
	Sun,  5 Jul 2026 08:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="a4xDxsfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20027849F6; Sun,  5 Jul 2026 08:09:21 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67D7849D2
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2536267a91.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231757; x=1783836557;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QYx5slSjGDzOuqlW2pxq73xV7d58n7Lf9UNUClClsFM=;
 b=a4xDxsfQo78Pe2bRseuCrSt+VFdqrcSCXyjRymce/JlMdWHMHhu/9UznUka0BGirAs
 TmQA1Yod8hWAfFcLdW1XXIKWJJJwED5Mf5IbDQrx7QazsAubFEEdN41y1XxlCYxasDVl
 BEnAeI1+G+FQ+4qrqq/MZWh6OtUimLDWNi3jS0z8mkWUd2s1dlSkRUC0S9s7mnXz0uWr
 8GM3Kf5sdxv4Uf9OZVm2OJDH5U/4kXWi5Z6cV4LO+YZmaf8+hGuz18VEJqRCjsFJIoM4
 +9mBr99PdBfjfRk89U/GExG+HhmZADxyZqXklt5L+acMyxXWtO1OIaQLHiE9bPVLXNGp
 TGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231757; x=1783836557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QYx5slSjGDzOuqlW2pxq73xV7d58n7Lf9UNUClClsFM=;
 b=esoAFjAuMcKXcvJv7eLn3LeA1AvRUQXnK10P4kj6pOnGvHBXkQpl7mjcfuwvE16sum
 umefrm+GRE3r+5ra/BoW1QUFbMUsvKlbGgdcUPWc8b0Y7omI+DjcIP5M6cBhDDdNLsHo
 iZ22oT0pgUnNeXVqlvN4FB7xrwTUtmGrtY4kBTU+gOq53mUDreuofsJntMce79TRaZPc
 UVuBgKfXl0Ua26cIZLtJ9pgtojb7mE+DHyu9vh37APjHdNQFtyBuL+S4d6yMqIlzq6cS
 UH/hdqHSAHAFgu5ngu5YPR0ubRw8Rm/CGBTsVQ21DTojYzvX1KzGK09G1EAgVizbN6pg
 1Pvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RopUalzyRwHXYuFYEVywxLOF6elvz/51KDYCqfUSUEtZQp2nL91TLJrqPX3lQZMWOTOvcTGumg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+TMSxPkLYMPJyJzdp8Ql+Ye63LyXxf7jDm0m2byppS+5AJscb
 XKEvIuJL9BXF/VKXRcXZ4BEs6TC7XEJPY4HyEAKrUeQb3zVkDWc6FYLMq1UVh5SH9B0=
X-Gm-Gg: AfdE7clW1Zb7tq6FD2fEo6NYOVotbez8++6hUG4tTLN4rGlVMgA7Q2wdLHElPClIZ/K
 uMq+H5xACeCthqJN1XrbDVt1E5xTcfwO++YY2Pzy2tsxlb6YvKPJTWZyvKbDIN2/cAGMmC+mUYz
 Y4MKtzMnoFoI/TRCCMYATG5IZ6FAPqgwMx/C1rrOPquCWZPixwZA17BaWe6c00yboWPAV85D2YK
 BM+chNVv7T1mqrmHo0V577+RFLzh0G/+pZA31xn2T9WgILKxqj2i+lQjMAj0QFABYtqBHD3IRyd
 DGnL3tOfOtHG/FzmWiEeqU5NJT4F2ty6YtnnJAi+Awc5jnJtqGBefYwZ7tFMHFdbRFILOvP/HtO
 KYJS8xP9pVpUJ/JEhw9wtY8mSLoUm8vWS60Nq1l5r1dJZLw/VxgojSbxY0jM/h3IPLqlMJzlw63
 HwMuEtYBSmTASd2Ee3NxJ+639QxOLdVL/pUePIM+opvGrAT0oLaZum7tQchWCDfPaOMwcOBPJW4
 wrWzDF2D+Ds4m4hGYN9hy+RpijZJvjwIhEjRPF6zDQlsFyD3ahj+w==
X-Received: by 2002:a17:90b:224d:b0:381:e74f:8a6a with SMTP id
 98e67ed59e1d1-3829eb1d7a8mr5579862a91.16.1783231757247; 
 Sat, 04 Jul 2026 23:09:17 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:09:16 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:08:00 +0800
Subject: [PATCH v3 9/9] spacemit: k1: load product name from environment
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-9-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
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

