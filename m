Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A48C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E61A84A4A;
	Mon, 29 Jun 2026 17:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="s5s9Hlcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D7384A4A; Mon, 29 Jun 2026 17:52:37 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2293284A81
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-139aff562e1so5073091c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748353; x=1783353153;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sFJByqFDXAVCu3KJw4nEsZ1qyhzL9ZCiSCswaB7c6Rc=;
 b=s5s9Hlcr6TVhjS9aWsfhI2eLsEusCpOzHwFb0pNIsnLQATZyfBx6Uvr0yhvJg7owql
 mRyV+o1V14p72w4EVq01SQPNpJXhEJGgsdlFvHw2TS6VDfhVwJuBex/UX3+zLlex2Ar3
 ZZyFjR3m4aohw4PwvkK8/10sTIa1o1xk1UqeohesuyNYWl6VjeEMlEZ3z8WS3RTaft/h
 m6wuchJUMop2ILTkf3ZYDajqHVCxt6wxGKIr+gqpZYjG0NE2R65hdO+dYTO/h5LoIJ9a
 0B3kg8OnKMaRsDpmr/g/nh86bxsPdqMf12pothGIL5ueS/KHuWCV9ZXBFNXRkweLPXCG
 bpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748353; x=1783353153;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sFJByqFDXAVCu3KJw4nEsZ1qyhzL9ZCiSCswaB7c6Rc=;
 b=jdducHdMm1C/NxTj4CjfzcZ5YgJN2ApgiXLdUuAW29vxf02EUk+mbZgEZ2DQknWRTm
 wWqVRNYdkkYDs8GiDNW3qQv/rNqXbfG7jZWUyIRhtRv3oak2GN3MjFRyurltIpQXi/Mx
 eTtdtbbMARklRGxjcV/PhIAFYwwyuufIpWNPkK8p4Gto64QGtB/x/81sZSyHKLu5TE7F
 xT86vA6vAZtFy376rgnAQJ2YoigkqJ/gvHsmZy11NqQjApvg6+hhZXQUnIqfrC0+DNX3
 Tke9qy2Dt6omYdGcDhaM3c99f63u/7PjGfEwPNtzjwK2GKH2UmZwlGf8bwc50fAvjPYt
 DRdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QGDQMEvlNBzW9NzcVth9sa43sDGz/0uS1a90gdT+ifT5yxjc4npr5R6nMSfjD4QegyginC1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+7U3U3rMBKi2t0JprMsLfj1FyZ3hd9wUaW+WPkjEOg6Y45dK3
 t+ZJryIL0JgkIJ7TI3+hpTXtsEqq7TDLKZeFk5Hi5VYAqGOaZ0Fth3Rb8QAm2/sBUgE=
X-Gm-Gg: AfdE7clMRgnjL4G89gbfISx97QvojvwgCzP3lzefYxpqsU0ndRzYOaHSSQiow2qrZYI
 IZoAvGChJ3K/DxNvKxghPnIO6N4YY/A+SvjnJMEAwi4uqUytG4WWHlThPCFVJ1rGf/wMXnB6yMp
 1CuA9vtlVyrH9wk4T+gg/ZIStJ+ddAObPLVTtZwDOwpxcnEKLWyfUJ+T+rgnx6pga/cLd6u/qSf
 htrcM99mbeoduCAyounCOVcQRFlNoYiQOC/2MjwCLUHNSr1pbu+cElVP5x2u60ZNBK3lBceQ9BU
 PaVVDY7NREUgTi+z40Pz/r9riJ0zdwyg3RwZi0d+j63fx6Md/HoDGlQ+D050VuTCdT/0ljDbv3U
 dSZytqmEk87QyMHSbJXN/1O06jhE9v0uEYO0a433CNajz/C2X6ns+/MWHD73gsCBGLhmTO8W5aS
 3YZPfUsYAOz6IAj89nuKcUZ2oHGr/L5mvofk2dh+Yns44fjksLxc34E5RIbKq7KYQnE560VvciG
 x8T8xVcKxybTAMhwiKrmtYmt0BK6YsFL5Pf8t33W6PkrhKZt0UgvA==
X-Received: by 2002:a05:7022:62a9:b0:137:567:14c4 with SMTP id
 a92af1059eb24-13b2a1af262mr2380c88.29.1782748353372; 
 Mon, 29 Jun 2026 08:52:33 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:52:32 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:22 +0800
Subject: [PATCH v2 v2 8/8] spacemit: k1: load product name from environment
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-8-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
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
 board/spacemit/k1/spl.c | 50 ++++++++++---------------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0db362130e4..4f8b2f1035d 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -12,6 +12,7 @@
 #include <configs/k1.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <env.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -73,39 +74,6 @@ static void i2c_early_init(void)
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
@@ -117,9 +85,14 @@ static const struct {
 
 static void fixup_product_name(void)
 {
-	char fdt_name[I2C_BUF_SIZE];
+	char fdt_name[I2C_BUF_SIZE], *name;
 	int i;
 
+	memset(product_name, 0, I2C_BUF_SIZE);
+	env_init();
+	env_load();
+	name = env_get("product_name");
+	snprintf(product_name, I2C_BUF_SIZE, "%s", name);
 	memset(fdt_name, 0, I2C_BUF_SIZE);
 	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
 		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
@@ -384,13 +357,10 @@ u32 spl_boot_device(void)
 
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

