Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFB2C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753E18836C;
	Tue,  2 Apr 2024 10:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a0cjROtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771A188301; Tue,  2 Apr 2024 10:49:30 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB01880E5
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 410D0424A7
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047763;
 bh=iCyf9Eh9pZLi/g1WblAo1KAEWUKkwi6fjh3REKCQQUU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=a0cjROtKwNDASNpi9zhD9tWFgs40p5nBENsQIglzDjiOXKbhczkHWhYSh9eV/Qne8
 jq2qRsscEKezx0pymGCM+vv/+cHk9rjQeRrkAEDDxHhSa4/BXTWFOL03FVlNt96SiR
 ebmV0d1ZCA8w1k9knHNMoyXcJqUPH5pGC3yJloWmga/HbdIDjI2JG3IJ+/62fFnJVv
 NrQDnvo7h6c5giBMhh6oHJmBdH84MUebqRfJg1b6lHlOBJm/SPqHqWBAxjKIHi2+J0
 6NfIsOAl9xMVWrbA0ZBFzlNLu2FdXEShr20LSj0T2xfvcAdte2GLbpJuzfO0lW9gKt
 I0bVgzScGx1mA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41463be093aso23432495e9.3
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047763; x=1712652563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCyf9Eh9pZLi/g1WblAo1KAEWUKkwi6fjh3REKCQQUU=;
 b=mRrYzuPfkOKnY7rUCecsve6Fve453+5PQFVI9/edviYrx5jVo4mV7z+AkuTVoSZ3tT
 DyLJMuUF7ldm+OX1XwT2aphO/qwWN7ANk0rdBLEJDkI85FFxnc/uGDlPhRZvzq9gV/zL
 qn9kvc+1dWt8hPzFUhDl7VgExNGtqMXl2mZ451GzpJppMzQwWFn8EooDOZao6UaMlcbX
 hdSU+tl23SPBr/IYOS8UHNNtGVLYELZfNZ73O0GXj+E6LuaRAr+8QyM54zbgGTWfV4gh
 wxLk5DUdXJXnsUT6273QrDgtZPTMzZ9nnPP5RrcYHulg4Dt6vnv2nUc5wBDo5VQI+Bv8
 uOdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6AvOtgpNhVecl31uAsMLTO1UO1LQIg0MzzU/nwsD9MlOqG3Oy9NXGuLriXLPYupPeK7zGzmkcoioEMASV5tJct5jsOA==
X-Gm-Message-State: AOJu0Yzkv0WqnfwkHRUAtKGo0lLRL3bm3hC/H+Baoudu8pzjsYUhmEkf
 dGH7VJcqC5+2MvVeTdKsrotRaI0cVBV1cbSfKnf/u5toaDyLHugGUuZEYlizDONc1OcNhi4vo+Y
 Yu8IYKLsNUV1U4w6ltgI1PaM3GDd4A84Y1VlNNI+m+aDdcDFAg6QmgN5LU7FR7nOPIGE=
X-Received: by 2002:a05:600c:5246:b0:414:69be:54b0 with SMTP id
 fc6-20020a05600c524600b0041469be54b0mr7847879wmb.22.1712047762847; 
 Tue, 02 Apr 2024 01:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfcI75MnPxI2Mru5rqFddpjCf5HP4HoojhFiydHKeZxRW4NKswz7LL1WXEhuC2gcdi9BsD7g==
X-Received: by 2002:a05:600c:5246:b0:414:69be:54b0 with SMTP id
 fc6-20020a05600c524600b0041469be54b0mr7847867wmb.22.1712047762568; 
 Tue, 02 Apr 2024 01:49:22 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004148c3685ffsm17409318wmq.3.2024.04.02.01.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:49:22 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 4/6] board: starfive: support Milk-V Mars board
Date: Tue,  2 Apr 2024 10:49:10 +0200
Message-ID: <20240402084912.43228-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
References: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
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

The differences between the Milk-V Mars board and the VisionFive 2 board
are small enough that we can support both using the same U-Boot build.

* The model and compatible property are taken from proposed Linux patches.
* The EEPROM is atmel,24c02 according to the vendor U-Boot.
* The second Ethernet port is not available.

usb@10100000 does not exist in U-Boot yet. So we don't have to reflect
differences in usage here.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
For the mmc card-detect a separate patch has been created:
https://lore.kernel.org/u-boot/20240328214615.21501-1-heinrich.schuchardt@canonical.com/

v3:
	Replace misplaced starfive_verb[i] by milk_v_mars[i].
v2:
	do not overwrite /soc/i2c@12050000/eeprom@50/compatible
---
 board/starfive/visionfive2/spl.c | 99 ++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 1b49945d11b..e8f97d963a0 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -27,6 +27,26 @@ struct starfive_vf2_pro {
 	const char *value;
 };
 
+static const struct starfive_vf2_pro milk_v_mars[] = {
+	{"/soc/ethernet@16030000", "starfive,tx-use-rgmii-clk", NULL},
+	{"/soc/ethernet@16040000", "starfive,tx-use-rgmii-clk", NULL},
+
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-adj-enabled", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-100-inverted", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,tx-clk-1000-inverted", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-clk-drv-microamp", "3970"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-data-drv-microamp", "2910"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"rx-internal-delay-ps", "1900"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"tx-internal-delay-ps", "1500"},
+};
+
 static const struct starfive_vf2_pro starfive_vera[] = {
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0", "rx-internal-delay-ps",
 		"1900"},
@@ -67,6 +87,49 @@ static const struct starfive_vf2_pro starfive_verb[] = {
 		"tx-internal-delay-ps", "0"},
 };
 
+void spl_fdt_fixup_mars(void *fdt)
+{
+	static const char compat[] = "milkv,mars\0starfive,jh7110";
+	u32 phandle;
+	u8 i;
+	int offset;
+	int ret;
+
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model",
+			   "Milk-V Mars");
+
+	/* gmac0 */
+	offset = fdt_path_offset(fdt, "/soc/clock-controller@17000000");
+	phandle = fdt_get_phandle(fdt, offset);
+	offset = fdt_path_offset(fdt, "/soc/ethernet@16030000");
+
+	fdt_setprop_u32(fdt, offset, "assigned-clocks", phandle);
+	fdt_appendprop_u32(fdt, offset, "assigned-clocks", JH7110_AONCLK_GMAC0_TX);
+	fdt_setprop_u32(fdt, offset,  "assigned-clock-parents", phandle);
+	fdt_appendprop_u32(fdt, offset,  "assigned-clock-parents",
+			   JH7110_AONCLK_GMAC0_RMII_RTX);
+
+	/* gmac1 */
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/soc/ethernet@16040000"),
+			   "status", "disabled");
+
+	for (i = 0; i < ARRAY_SIZE(milk_v_mars); i++) {
+		offset = fdt_path_offset(fdt, milk_v_mars[i].path);
+
+		if (milk_v_mars[i].value)
+			ret = fdt_setprop_u32(fdt, offset, milk_v_mars[i].name,
+					      dectoul(milk_v_mars[i].value, NULL));
+		else
+			ret = fdt_setprop_empty(fdt, offset, milk_v_mars[i].name);
+
+		if (ret) {
+			pr_err("%s set prop %s fail.\n", __func__, milk_v_mars[i].name);
+				break;
+		}
+	}
+}
+
 void spl_fdt_fixup_version_a(void *fdt)
 {
 	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
@@ -167,22 +230,34 @@ void spl_fdt_fixup_version_b(void *fdt)
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
 	u8 version;
+	const char *product_id;
 
-	version = get_pcb_revision_from_eeprom();
-	switch (version) {
-	case 'a':
-	case 'A':
-		spl_fdt_fixup_version_a(spl_image->fdt_addr);
-		break;
-
-	case 'b':
-	case 'B':
-	default:
-		spl_fdt_fixup_version_b(spl_image->fdt_addr);
+	product_id = get_product_id_from_eeprom();
+	if (!product_id) {
+		pr_err("Can't read EEPROM\n");
+		return;
+	}
+	if (!strncmp(product_id, "MARS", 4)) {
+		spl_fdt_fixup_mars(spl_image->fdt_addr);
+	} else if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		switch (version) {
+		case 'a':
+		case 'A':
+			spl_fdt_fixup_version_a(spl_image->fdt_addr);
+			break;
+
+		case 'b':
+		case 'B':
+		default:
+			spl_fdt_fixup_version_b(spl_image->fdt_addr);
 		break;
+		};
+	} else {
+		pr_err("Unknown product %s\n", product_id);
 	};
 
-	/* Update the memory size which read form eeprom or DT */
+	/* Update the memory size which read from eeprom or DT */
 	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
 }
 
-- 
2.43.0

