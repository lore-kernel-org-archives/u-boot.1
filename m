Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515BC25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA02F87AF3;
	Thu, 26 Oct 2023 01:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvJY6iwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4539B86F9F; Thu, 26 Oct 2023 01:13:24 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BDA87009
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41ccd38eaa5so2299571cf.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275600; x=1698880400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2m8Cr6FkHI6eD8h4B0KTjKXuvjBkKx0CRSyeNOEicc=;
 b=SvJY6iwoJ8ygQHbTNMqR6JIycgw/K/OKtdDis+eMrs4awX3pEXedioudZx63h9m/aU
 jBJWEKngdAemcm50QrvRWnzE5NluYJGkz0N9nARqCVuR4WO0IGuT3++PVkC9WhyDp4rC
 mzvYNS3Wm7k+WIzNPYtJiarHwk5H2I1QAUjOgkKqk20KVwrSFh1S+hkdeZPTxwnZD+mZ
 AbxBq+0fkpFnX56TiKUnhOGpwAp4X/ayLipIBT2C1uaFhxgNOqSNAb4qw8Z0vNNzKpB7
 M3zJwtR/AlzUbQzY8NpeEqEMltDGRSuOn5IKjpr69L3ypjGWzcrBtt8p3UtxHwzUSdv+
 inOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275600; x=1698880400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2m8Cr6FkHI6eD8h4B0KTjKXuvjBkKx0CRSyeNOEicc=;
 b=xDqHTepoNddPMwoxJgi9W3ouFFUWUCSddHCzV697uuYTL0tf7PR4T6ow+ebJ2atGfZ
 RrPmSNkBhSCGzm81UuQpcJD//gU8701ztvDcy+mA503KfCn2I4l0ksP8JyvUcPsw707O
 QMm7j1t5On9xjoHrdZQm+exPxAReIV2FjufV80LCMYBcxPHX0OVz0w10BrmB3gqUVNIe
 JjB/VaeZomAuEryeQDnZeYsWdfJSFLwexEfsPkj9NoMwfAPhHqU013RVfKVf+rDLEWH6
 ecG670K2VXu9j1ChAl6z4hulDTtHaelELaWPL+bpTXU12WISS4KNtXA8Cb6U4XBH4siA
 ylMg==
X-Gm-Message-State: AOJu0YyijvCsD1pDjfgLgw5/2mNx3dt07pvVtXOkrSiXszUvtwWxdyjN
 PW+QR8cGbrfJ7MjrNp8Zg3s3VNcBx4w=
X-Google-Smtp-Source: AGHT+IHN+AIMRpCcVCVVBxFpm1TCjLwOd1wAwjqYyVp8PG8QA6RQWMvyF+8AYXOXrPKBzQkrgrWVVQ==
X-Received: by 2002:a05:622a:1a89:b0:40f:dfbc:2405 with SMTP id
 s9-20020a05622a1a8900b0040fdfbc2405mr1291104qtc.27.1698275600519; 
 Wed, 25 Oct 2023 16:13:20 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ac8730a000000b004180fdcb482sm4576814qto.81.2023.10.25.16.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:13:19 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>
Subject: [PATCH 3/3] arm: rmobile: rzg2_beacon: Auto select Linux device tree
 by SoC
Date: Wed, 25 Oct 2023 18:13:11 -0500
Message-Id: <20231025231311.8701-3-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025231311.8701-1-aford173@gmail.com>
References: <20231025231311.8701-1-aford173@gmail.com>
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

There is a function inside the board file to autodetect which device
tree is needed by U-Boot to properly load its own device tree, but
it currently defaults to always loading RZ/G2M for Linux.  This is
not correct for other SoC variants.  Add board_late_init function
to query the SoC name and use that to determine which device tree
is loaded for booting Linux.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/board/beacon/beacon-rzg2m/beacon-rzg2m.c b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
index 99fe1edfb3..6d37ff6ac9 100644
--- a/board/beacon/beacon-rzg2m/beacon-rzg2m.c
+++ b/board/beacon/beacon-rzg2m/beacon-rzg2m.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -17,6 +18,38 @@ int board_init(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+static u8 get_SoC_letter(void)
+{
+	const u8 *name = rzg_get_cpu_name();
+
+	if (*name)
+		return name[6];
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	/* If already defined, exit */
+	if (!env_get("fdt_file")) {
+		switch (get_SoC_letter()) {
+		case 'A':
+			env_set("fdt_file", "r8a774a1-beacon-rzg2m-kit.dtb");
+			break;
+		case 'B':
+			env_set("fdt_file", "r8a774b1-beacon-rzg2n-kit.dtb");
+			break;
+		case 'E':
+			env_set("fdt_file", "r8a774e1-beacon-rzg2h-kit.dtb");
+			break;
+		}
+	}
+
+	return 0;
+}
+#endif /* CONFIG_BOARD_LATE_INIT */
+
 #if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
 int board_fit_config_name_match(const char *name)
 {
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index 534f641e84..6894448b22 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -21,6 +21,7 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_DEFAULT_FDT_FILE="r8a774a1-beacon-rzg2m-kit.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
diff --git a/include/configs/beacon-rzg2m.h b/include/configs/beacon-rzg2m.h
index 65c01835cc..493b98fbdf 100644
--- a/include/configs/beacon-rzg2m.h
+++ b/include/configs/beacon-rzg2m.h
@@ -18,7 +18,6 @@
 	"fdt_addr=0x48000000\0" \
 	"loadaddr=0x48080000\0" \
 	"boot_fdt=try\0" \
-	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"initrd_addr=0x43800000\0"		\
 	"mmcdev=1\0" \
 	"mmcpart=1\0" \
-- 
2.40.1

