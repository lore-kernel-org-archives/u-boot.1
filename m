Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5DCC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93177870B5;
	Thu,  9 Nov 2023 01:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pDeEMvCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6430C8713C; Thu,  9 Nov 2023 01:36:46 +0100 (CET)
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com
 [IPv6:2a00:1450:4864:20::149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86428709A
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3milMZQkKBk8uz358z44Fx55x2v.t53B-s55A2z9A9.uv4E.uv@flex--dimorinny.bounces.google.com
Received: by mail-lf1-x149.google.com with SMTP id
 2adb3069b0e04-507d4583c4cso233080e87.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699490202; x=1700095002; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zi5Nw6hx9HGnjHEcq0u2Dd9zVnDlwWJNF9+iI4mAoDA=;
 b=pDeEMvCTMgzOXjKrFb+Xntg81SoqnG/yFCqXx1AEy494CmgDtsjxlwp+Q1yN5wXl7F
 w4VS1JLFJ/Obrp/ZwZBGmJiYaw+kgL/k3XptnstWafT5btY4GwCJXv8lnjL23hcYVgy0
 8hR5klXWB8L3IgqYQXab25wTtfKB8gAe3M/2/+GmbYMjyEBDgDdxJuU6dH6LJ92hFRdY
 djIBptMGiJewUdIHNo6KD0EtNXvKeC9aayxmOY0O4rEHirj04q9O1S4sLB68InvrisYx
 nPNSRa/huKU7E6ytm/jADXDNHQuoK2VkuULqBMXA8m2BTYGjgVwTXE+sf49tfy/3OpoB
 wEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699490202; x=1700095002;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zi5Nw6hx9HGnjHEcq0u2Dd9zVnDlwWJNF9+iI4mAoDA=;
 b=a4cENl231THnkldL0VH9e1VUiNemLd/59LsS+IvhCm2ZZ10En8wJkMXAkrs8LemjWf
 h1U1Wqh5trLGSk8AJcOPtYYlT+iNvVewz4oamc0x02MnAL2+5KzAFrA2jbk1QHKpa4mt
 rdhBBGW7HrbxCCU0vGhl3FE3U6h8XG7ZeEee0ifHLclI/cmheb1JcYdcjZDvCqat2T2z
 zNEeZoSbF4MXrhJeZwI/2ZUoM+miMkvxpL2VQF+hCRG6uVaOHdwe1ghv36Y6cKzDYYOk
 vTQeZHPE3Y2ObDpCWfARN5aoGXHiUZ0Om01E+V7HIXKpAxREYy56qNIEirqyaamDmNOu
 ekAQ==
X-Gm-Message-State: AOJu0YxnLDMchScAEGTXc/sThAREulpb69IwBVxUSeAiWYn2yREsYuwM
 WLSnP7xM1ZV/JPVF6hl3UyH6udQ0Mhv199698syslg5JplfLVNrZT6bUvS4fYQoSKSE9y+SCR+1
 xoyBTB8fuHzmzY2j5cqAQhfp5XIQTBqjJoHdoZ5xzhxA5Ba38f4BchFiTGFlhTFzpZ+0=
X-Google-Smtp-Source: AGHT+IHoPXN36NjBOKyjVGP57+rm1cfWmEcdGimaXkFY3Edm8Iu7qy6xDUS0yLHK6XKqAqanMrwlhbAF8R/F9iw=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:a191:82a1:563a:5b26])
 (user=dimorinny job=sendgmr) by 2002:a05:6512:902:b0:509:4603:23e with SMTP
 id e2-20020a056512090200b005094603023emr3624lft.5.1699490202006; Wed, 08 Nov
 2023 16:36:42 -0800 (PST)
Date: Thu,  9 Nov 2023 00:36:33 +0000
In-Reply-To: <20231109003634.577152-1-dimorinny@google.com>
Mime-Version: 1.0
References: <20231109003634.577152-1-dimorinny@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109003634.577152-2-dimorinny@google.com>
Subject: [PATCH 1/2] cmd: bcb: support various block device interfaces for BCB
 command
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Eugeniu Rosca <erosca@de.adit-jv.com>, Ying-Chun Liu <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Cody Schuffelen <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently BCB command-line, C APIs and implementation only
support MMC interface. Extend it to allow various block
device interfaces.

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Cody Schuffelen <schuffelen@google.com>
---
 cmd/Kconfig                  |  1 -
 cmd/bcb.c                    | 70 ++++++++++++++++++++++--------------
 doc/android/bcb.rst          | 34 +++++++++---------
 drivers/fastboot/fb_common.c |  2 +-
 include/bcb.h                |  5 +--
 5 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index df6d71c103..ce2435bbb8 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -981,7 +981,6 @@ config CMD_ADC
 
 config CMD_BCB
 	bool "bcb"
-	depends on MMC
 	depends on PARTITIONS
 	help
 	  Read/modify/write the fields of Bootloader Control Block, usually
diff --git a/cmd/bcb.c b/cmd/bcb.c
index 02d0c70d87..5d8c232663 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -25,6 +25,7 @@ enum bcb_cmd {
 	BCB_CMD_STORE,
 };
 
+static enum uclass_id bcb_uclass_id = UCLASS_INVALID;
 static int bcb_dev = -1;
 static int bcb_part = -1;
 static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) = { { 0 } };
@@ -53,6 +54,9 @@ static int bcb_is_misused(int argc, char *const argv[])
 
 	switch (cmd) {
 	case BCB_CMD_LOAD:
+		if (argc != 3 && argc != 4)
+			goto err;
+		break;
 	case BCB_CMD_FIELD_SET:
 		if (argc != 3)
 			goto err;
@@ -115,7 +119,7 @@ static int bcb_field_get(char *name, char **fieldp, int *sizep)
 	return 0;
 }
 
-static int __bcb_load(int devnum, const char *partp)
+static int __bcb_load(const char *iface, int devnum, const char *partp)
 {
 	struct blk_desc *desc;
 	struct disk_partition info;
@@ -123,14 +127,14 @@ static int __bcb_load(int devnum, const char *partp)
 	char *endp;
 	int part, ret;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, devnum);
+	desc = blk_get_dev(iface, devnum);
 	if (!desc) {
 		ret = -ENODEV;
 		goto err_read_fail;
 	}
 
 	/*
-	 * always select the USER mmc hwpart in case another
+	 * always select the first hwpart in case another
 	 * blk operation selected a different hwpart
 	 */
 	ret = blk_dselect_hwpart(desc, 0);
@@ -161,18 +165,20 @@ static int __bcb_load(int devnum, const char *partp)
 		goto err_read_fail;
 	}
 
+	bcb_uclass_id = desc->uclass_id;
 	bcb_dev = desc->devnum;
 	bcb_part = part;
-	debug("%s: Loaded from mmc %d:%d\n", __func__, bcb_dev, bcb_part);
+	debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev, bcb_part);
 
 	return CMD_RET_SUCCESS;
 err_read_fail:
-	printf("Error: mmc %d:%s read failed (%d)\n", devnum, partp, ret);
+	printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp, ret);
 	goto err;
 err_too_small:
-	printf("Error: mmc %d:%s too small!", devnum, partp);
+	printf("Error: %s %d:%s too small!", iface, devnum, partp);
 	goto err;
 err:
+	bcb_uclass_id = UCLASS_INVALID;
 	bcb_dev = -1;
 	bcb_part = -1;
 
@@ -182,15 +188,23 @@ err:
 static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char * const argv[])
 {
+	int devnum;
 	char *endp;
-	int devnum = simple_strtoul(argv[1], &endp, 0);
+	char *iface = "mcc";
+
+	if (argc == 4) {
+		iface = argv[1];
+		argc--;
+		argv++;
+	}
 
+	devnum = simple_strtoul(argv[1], &endp, 0);
 	if (*endp != '\0') {
 		printf("Error: Device id '%s' not a number\n", argv[1]);
 		return CMD_RET_FAILURE;
 	}
 
-	return __bcb_load(devnum, argv[2]);
+	return __bcb_load(iface, devnum, argv[2]);
 }
 
 static int __bcb_set(char *fieldp, const char *valp)
@@ -298,7 +312,7 @@ static int __bcb_store(void)
 	u64 cnt;
 	int ret;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, bcb_dev);
+	desc = blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
 	if (!desc) {
 		ret = -ENODEV;
 		goto err;
@@ -317,7 +331,7 @@ static int __bcb_store(void)
 
 	return CMD_RET_SUCCESS;
 err:
-	printf("Error: mmc %d:%d write failed (%d)\n", bcb_dev, bcb_part, ret);
+	printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id, bcb_dev, bcb_part, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -328,11 +342,11 @@ static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
 	return __bcb_store();
 }
 
-int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp)
+int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp)
 {
 	int ret;
 
-	ret = __bcb_load(devnum, partp);
+	ret = __bcb_load(iface, devnum, partp);
 	if (ret != CMD_RET_SUCCESS)
 		return ret;
 
@@ -385,21 +399,23 @@ static int do_bcb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	bcb, CONFIG_SYS_MAXARGS, 1, do_bcb,
 	"Load/set/clear/test/dump/store Android BCB fields",
-	"load  <dev> <part>       - load  BCB from mmc <dev>:<part>\n"
-	"bcb set   <field> <val>      - set   BCB <field> to <val>\n"
-	"bcb clear [<field>]          - clear BCB <field> or all fields\n"
-	"bcb test  <field> <op> <val> - test  BCB <field> against <val>\n"
-	"bcb dump  <field>            - dump  BCB <field>\n"
-	"bcb store                    - store BCB back to mmc\n"
+	"load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>\n"
+	"load <dev> <part>              - load  BCB from mmc <dev>:<part>\n"
+	"bcb set   <field> <val>        - set   BCB <field> to <val>\n"
+	"bcb clear [<field>]            - clear BCB <field> or all fields\n"
+	"bcb test  <field> <op> <val>   - test  BCB <field> against <val>\n"
+	"bcb dump  <field>              - dump  BCB <field>\n"
+	"bcb store                      - store BCB back to <interface>\n"
 	"\n"
 	"Legend:\n"
-	"<dev>   - MMC device index containing the BCB partition\n"
-	"<part>  - MMC partition index or name containing the BCB\n"
-	"<field> - one of {command,status,recovery,stage,reserved}\n"
-	"<op>    - the binary operator used in 'bcb test':\n"
-	"          '=' returns true if <val> matches the string stored in <field>\n"
-	"          '~' returns true if <val> matches a subset of <field>'s string\n"
-	"<val>   - string/text provided as input to bcb {set,test}\n"
-	"          NOTE: any ':' character in <val> will be replaced by line feed\n"
-	"          during 'bcb set' and used as separator by upper layers\n"
+	"<interface> - storage device interface (virtio, mmc, etc)\n"
+	"<dev>       - storage device index containing the BCB partition\n"
+	"<part>      - partition index or name containing the BCB\n"
+	"<field>     - one of {command,status,recovery,stage,reserved}\n"
+	"<op>        - the binary operator used in 'bcb test':\n"
+	"              '=' returns true if <val> matches the string stored in <field>\n"
+	"              '~' returns true if <val> matches a subset of <field>'s string\n"
+	"<val>       - string/text provided as input to bcb {set,test}\n"
+	"              NOTE: any ':' character in <val> will be replaced by line feed\n"
+	"              during 'bcb set' and used as separator by upper layers\n"
 );
diff --git a/doc/android/bcb.rst b/doc/android/bcb.rst
index 8861608300..2226517d39 100644
--- a/doc/android/bcb.rst
+++ b/doc/android/bcb.rst
@@ -41,23 +41,25 @@ requirements enumerated above. Below is the command's help message::
    bcb - Load/set/clear/test/dump/store Android BCB fields
 
    Usage:
-   bcb load  <dev> <part>       - load  BCB from mmc <dev>:<part>
-   bcb set   <field> <val>      - set   BCB <field> to <val>
-   bcb clear [<field>]          - clear BCB <field> or all fields
-   bcb test  <field> <op> <val> - test  BCB <field> against <val>
-   bcb dump  <field>            - dump  BCB <field>
-   bcb store                    - store BCB back to mmc
+   bcb load <interface> <dev> <part>  - load  BCB from <interface> <dev>:<part>
+   load <dev> <part>              - load  BCB from mmc <dev>:<part>
+   bcb set   <field> <val>        - set   BCB <field> to <val>
+   bcb clear [<field>]            - clear BCB <field> or all fields
+   bcb test  <field> <op> <val>   - test  BCB <field> against <val>
+   bcb dump  <field>              - dump  BCB <field>
+   bcb store                      - store BCB back to <interface>
 
    Legend:
-   <dev>   - MMC device index containing the BCB partition
-   <part>  - MMC partition index or name containing the BCB
-   <field> - one of {command,status,recovery,stage,reserved}
-   <op>    - the binary operator used in 'bcb test':
-             '=' returns true if <val> matches the string stored in <field>
-             '~' returns true if <val> matches a subset of <field>'s string
-   <val>   - string/text provided as input to bcb {set,test}
-             NOTE: any ':' character in <val> will be replaced by line feed
-             during 'bcb set' and used as separator by upper layers
+   <interface> - storage device interface (virtio, mmc, etc)
+   <dev>       - storage device index containing the BCB partition
+   <part>      - partition index or name containing the BCB
+   <field>     - one of {command,status,recovery,stage,reserved}
+   <op>        - the binary operator used in 'bcb test':
+                 '=' returns true if <val> matches the string stored in <field>
+                 '~' returns true if <val> matches a subset of <field>'s string
+   <val>       - string/text provided as input to bcb {set,test}
+                 NOTE: any ':' character in <val> will be replaced by line feed
+                 during 'bcb set' and used as separator by upper layers
 
 
 'bcb'. Example of getting reboot reason
@@ -91,7 +93,7 @@ The following Kconfig options must be enabled::
 
    CONFIG_PARTITIONS=y
    CONFIG_MMC=y
-   CONFIG_BCB=y
+   CONFIG_CMD_BCB=y
 
 .. [1] https://android.googlesource.com/platform/bootable/recovery
 .. [2] https://source.android.com/devices/bootloader
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 4e9d9b719c..2a6608b28c 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -105,7 +105,7 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
 		return -EINVAL;
 
-	return bcb_write_reboot_reason(mmc_dev, "misc", boot_cmds[reason]);
+	return bcb_write_reboot_reason("mmc", mmc_dev, "misc", boot_cmds[reason]);
 }
 
 /**
diff --git a/include/bcb.h b/include/bcb.h
index 5edb17aa47..a6326523c4 100644
--- a/include/bcb.h
+++ b/include/bcb.h
@@ -9,10 +9,11 @@
 #define __BCB_H__
 
 #if IS_ENABLED(CONFIG_CMD_BCB)
-int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp);
+int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp);
 #else
 #include <linux/errno.h>
-static inline int bcb_write_reboot_reason(int devnum, char *partp, const char *reasonp)
+static inline int bcb_write_reboot_reason(const char *iface, int devnum,
+					  char *partp, const char *reasonp)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.42.0.869.gea05f2083d-goog

