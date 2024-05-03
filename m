Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608F2C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 09:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBE588C0C;
	Fri,  3 May 2024 11:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rz5Acqn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB96488C07; Fri,  3 May 2024 11:00:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D308823D
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 11:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B92753F29F
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714726854;
 bh=j+2mSTl9nsYuEP1cItsvboXCsAue6JnxxElx8ZfT7iw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rz5Acqn8e93V9hDEfrU/ggnHl7fEOcKbVCnA3T7rCNVlhsfZeCYkej/s71ezthsmw
 Z/X5XxxyaKhmidO3vFt6yUdOiXW8ad8FLhu/yWx4ZkgSsIPjeE+d/sdoK1/Oy6xSzW
 qaPGvWAKNnTFbUvoDL4hW+gRr1IX1O2dBauwvWyzVr20+RykEqJnSmJDdlA6NgwC46
 AdI7ZDwqApkREyNpDA5watnelbLQLoOtxMo/Ms96kYVO6w9CIh7q4UY0Fi70nlfoBq
 GVnr+7qmHsPJgdBXNq6qSH1OavzjvtHffE9XWACRKvxuD7vL5BFxZqX8aJaV1Plmqc
 U5V+kjnwh0FBw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-346c08df987so1290277f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 02:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726847; x=1715331647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+2mSTl9nsYuEP1cItsvboXCsAue6JnxxElx8ZfT7iw=;
 b=pBsbmlhuk5cJtIdEpiQQ1DPwScDkTI4rw6T9236xGAgaJowp7mJZfzdMdvL1Hjjxx/
 3mwgQ5gZqSYSLrnRQEFAm8DsHTFJnGC38FYxRBKlgJejIMhwiKMeCS1+CgCqCh4Ci5bO
 LYk+QnuI59yiutdKpw++KASoHAKmn4vDxFQj4kL0o5EItH1LiOCtYmHstB4H9Qktwoz/
 dFqNIJ8Z0KRqhaAb3nI6g4d33Yw/8g8bi6anlKLP17I25FhXENTQ30T60RlFXjI1bSMo
 dUkbazeUiiPFdHloDfHG5uDpfj+JIZfRGm1U0YZJwqqIPJ5so5POUOskQxRkExuCklYd
 sY/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRFg9Qls7oC8MITk5a4aUh4dgRhUTsltDSMNLkoa7uSX/XqRGInM9f2iPF9rDNfocccqfrWNCpq3drwjaSmNo4Or1qLQ==
X-Gm-Message-State: AOJu0Yy+a9ar7Z/POZy0kFHc6zVULSxvGEnpWqUHImO8Q+pPy9v0SMN0
 ApPBJGzlxHaKJr2/s1muTdZ81JKZgcROAfWGnbiM4zxoGs/eussYUbyETKEsyiDH5XUrW4gNjOp
 pw2jD/Mi5vGFl8OVuaIYucXE/QKepf+7Tht6wdwS1tPLomFpf6kzc62ZD+S9HVP4QBcU=
X-Received: by 2002:adf:eece:0:b0:34d:a0b4:d122 with SMTP id
 a14-20020adfeece000000b0034da0b4d122mr1925316wrp.30.1714726847323; 
 Fri, 03 May 2024 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYmaMsVpjKtd4VMl6pAShxxtzEY70MfCvjnLGuzUpJPaTGCOTUWW7HEy6AeJxrKO49CE4N2Q==
X-Received: by 2002:adf:eece:0:b0:34d:a0b4:d122 with SMTP id
 a14-20020adfeece000000b0034da0b4d122mr1925284wrp.30.1714726846886; 
 Fri, 03 May 2024 02:00:46 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0560001cc900b00341b451a31asm3247313wrb.36.2024.05.03.02.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 02:00:46 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/4] board: add support for Milk-V Mars CM
Date: Fri,  3 May 2024 11:00:01 +0200
Message-ID: <20240503090011.37849-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
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

We already support the VisionFive 2 and the Milk-V Mars board by
patching the VisionFive 2 device tree. With this patch the same
is done for the Milk-V Mars CM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
	rename device-trees for Mars CM and Mars CM Lite
	change model and compatible properties
---
 board/starfive/visionfive2/spl.c              | 28 ++++++++++++++++++-
 .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index ca61b5be227..b555189556a 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -129,6 +129,30 @@ void spl_fdt_fixup_mars(void *fdt)
 	}
 }
 
+void spl_fdt_fixup_mars_cm(void *fdt)
+{
+	const char *compat;
+	const char *model;
+
+	spl_fdt_fixup_mars(fdt);
+
+	if (!get_mmc_size_from_eeprom()) {
+		int offset;
+
+		model = "Milk-V Mars CM Lite";
+		compat = "milkv,mars-cm-lite\0starfive,jh7110";
+
+		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
+		/* GPIOMUX(22, GPOUT_SYS_SDIO0_RST, GPOEN_ENABLE, GPI_NONE) */
+		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
+	} else {
+		model = "Milk-V Mars CM";
+		compat = "milkv,mars-cm\0starfive,jh7110";
+	}
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
+}
+
 void spl_fdt_fixup_version_a(void *fdt)
 {
 	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
@@ -236,7 +260,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		pr_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		spl_fdt_fixup_mars_cm(spl_image->fdt_addr);
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		spl_fdt_fixup_mars(spl_image->fdt_addr);
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index a86bca533b2..6be53489626 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
+#define FDTFILE_MILK_V_MARS_CM \
+	"starfive/jh7110-milkv-mars-cm.dtb"
+#define FDTFILE_MILK_V_MARS_CM_LITE \
+	"starfive/jh7110-milkv-mars-cm-lite.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
 	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
@@ -61,7 +65,12 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		if (get_mmc_size_from_eeprom())
+			fdtfile = FDTFILE_MILK_V_MARS_CM;
+		else
+			fdtfile = FDTFILE_MILK_V_MARS_CM_LITE;
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
-- 
2.43.0

