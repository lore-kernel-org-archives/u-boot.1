Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FF6C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E4B86564;
	Thu, 21 Mar 2024 19:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wWpPdSiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2964386564; Thu, 21 Mar 2024 19:12:43 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78BB8810F
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B53D842455
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044746;
 bh=HcZKWtKNyyoA40umCtjPdpbZBklkeZwGwAfqQTSqRXI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wWpPdSiAWQw+7X+MxnGmf7kdY48T9lEgLHGJZ0pYqbRtruUH6SQNJHTYFdDyknS+0
 f6mQJGk3Tx38p/PPRIq6lVy0ZKkuu0WUbvDHFuznYSL2g/VE9NJY9Vpmi6CgtTjm3T
 zeNHsGCGL38+hCZlTjzHt8pMk4CQjNek9c6c+r+evw5fw0JNtUgU0BARcT0Nfmbke/
 u9rvhcfrkfxgCNDQV6FseVbfd/x8PXaMunH0+XgDwsrFhvozzbWW2t9Fgc7H2JXT+Z
 3zIzxR3r+uAtMVsjRwjc0uLRrylenVK+65rza4/m/Ca+hn8JhURfSH+0598Vw4OOQq
 msH0TsxDW4m7A==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-413f7a2167dso6339745e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044739; x=1711649539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcZKWtKNyyoA40umCtjPdpbZBklkeZwGwAfqQTSqRXI=;
 b=q1jlJTtAd+vnoAV8z/yOzEmL4p691D/5hRIGkl7CUJJjdu/wuVCFvbEdRGV9hwQ5KL
 BJOJCsWmVhTEU7fMLjHxicov9i+xgqOQVAQCHhq2XuP2WTUyKdnz7YFy0WBdsJ/R7T/7
 EJPOeTTgiR5Sw+a1zlJF7V+bbDtq2f4ALXKoLE8BHxD1XzTV2CCUaDAT0y6IF5FPirWy
 CMpbvV8J3udeIkKkyp0lj8/5HHPNP1Ghnjpn6fANKu9luxPa92qIcIjtHKW53ZUmdBqv
 lfn/0ty0arnmcwpATSOe09RPi2RBRaiVru7SH5XiH8+QKC76K5gXbb2yQxMWNeiAjs4O
 JELg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUonIcfJReMAwqHN2/NxkW+zf1XmxX/znvaAYRIkuqmWezG9SK7m/Vkt9+yB7EOjRzLh1qtW+fC0fOULNpirbSq8PYzrA==
X-Gm-Message-State: AOJu0Yw5D0wSbhiAc9Gbqz9RPtLQFN7XOdAGVpbuxErJKh9NbdIsLYze
 /wbHylLk5Sfx23pIw+dmySMC4OHpNGXq4UoFjeZPxEULRI1aJsGRnVYvqhuoSLd3kGXedR1hR9K
 Lvhqg4NJB5uKL8Hf8AauApzUJqTxaMOtbc4TxeSl+O6q8vBDsKvkmbXt1trqjxIplw5o=
X-Received: by 2002:a05:600c:5254:b0:414:6cc9:6d88 with SMTP id
 fc20-20020a05600c525400b004146cc96d88mr1724842wmb.36.1711044739698; 
 Thu, 21 Mar 2024 11:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPcEziGLvESH+kSCnJ29fiYikphGvtFdCMfAdbBXA28jGLuFZ9uow8l0rtzAi952IRI10yNA==
X-Received: by 2002:a05:600c:5254:b0:414:6cc9:6d88 with SMTP id
 fc20-20020a05600c525400b004146cc96d88mr1724832wmb.36.1711044739411; 
 Thu, 21 Mar 2024 11:12:19 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Date: Thu, 21 Mar 2024 19:11:47 +0100
Message-ID: <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	do not overwrite /soc/i2c@12050000/eeprom@50/compatible
	
---
 board/starfive/visionfive2/spl.c | 99 ++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 12 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 1b49945d11b..e0e33cb37ba 100644
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
+		if (starfive_verb[i].value)
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

