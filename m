Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B20ACD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:21:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8906D83E76;
	Mon, 11 May 2026 20:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DArmhn5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DC283EF9; Mon, 11 May 2026 20:21:07 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05DC83E36
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso4096051a34.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523663; x=1779128463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W+9iYrycPDnckDl0YPrjOnlNedJ6sfCc3GN5JUY6J+s=;
 b=DArmhn5hvwdTs2Y7IHbNxHsKJ20eBtr9R3BZv1BuqucAYmqDsTQ9zQhQ61toWcyPYV
 9e1eCu/H4REiPA1KLqPh+f70A6hIi9IExEzzppeex7D02v6eMRgZPBeksFC6lGUv+3GT
 r069eitlO4rd2s4hdaGz849vSheaCYQj4iJ8F2SBVLNGf+QztzavIwRzUjiz8Ia8dJ+E
 VL4ByQj7DGYpBOkfOe+jGwdzqrKmF273b+zYkTmXcOgmHVcVilTJD5hXiycoFeQvWiBk
 yrnyxhK9eTh/Ba//aF9HwZHeA8y+8oJ4GXHsfLSfIh24ARSSlrkRwR3RXTJFABLLfT1v
 Sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523663; x=1779128463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+9iYrycPDnckDl0YPrjOnlNedJ6sfCc3GN5JUY6J+s=;
 b=H0dwD5HJTUnjrxVJL+MtCxsdGWV/nGzM3hs9aDbdCSW9Bu//h2GNaR55PxT/Nk7HaQ
 B8Ty4MbWvqNoOP6mpn4brJLxz5ON/NrnWCl8/nPdw2gZxBztJEDUb+lppYtCh4KSs8yj
 I829rOT/4Y4ZGTzhyX7Jga7YdB2BHqDa2f3M0Md6pB8bLgNBk0rmh+gvf/TiDAGVPGyn
 EvgTI6FUXcXOZb09JoSuZdgPoU1V7OUUxCtM8sbDXsc3qBS1XSxw4AiCfO577rJYKmkv
 SDrDNJ8mmXBKMchMg8dQt3Xx6xbQh7VgCWjrXUZOgO73Sm2hB/gbWyUB5QLjmcYIslOT
 W6mw==
X-Gm-Message-State: AOJu0YzIWqvZTNmi0J5mvn8t6mLSh3u4JthC1aTAlMkBFIEnBgyFiaxC
 yJKdmInlS67itsCIC04g61waHzcpb5OxoD4X3s11E8cGsy7ohrNmqLfN664QH66z
X-Gm-Gg: Acq92OHhLlOrHKZAKtRXPdkI/CdcmKdJsV4wz6KGUVicCR61ZfLV7C3V86Q553A4qRJ
 MMnpF/iztA2MPiDuKhxn3DBtB//5J8d8G/gJgt4+A15bv+zuMdI5Tdo5uyqt90Wof20r+Prttpc
 f7Hdzgt0uf0rHIzeWYbOkpy2nCOvs/ZBIGFoqNd0kiZF1/Aez2b60JDNbSDJTb6OT6sEOJTnRn2
 3DJ5cPUrg2JMzahLYxIS3hpQMZoThCh7il6zR3dQipZaq7S/nYunm5isfv72DHtUDFOTVBAQNsB
 5FoLyCWrBsq9oAgQavs31uC4ZcV8OmK+frxAJjNNyzh7c64WeEgD7FH1vXmg0V7GeE/kJWFOL+X
 isCSRMBbUga+U+w6jMReNmqC0yFlEOFIbe3OPfaMI90ALFY6YgaVpDHsOAntN9kgJZ6D+lwJkpz
 gysMeBfFc9S2I1nXeu6ehbS62oh+UgDXCEEMfE+2y0sHfE0c0s7g9q5hXn1+Kul5/WoQDuPY4Cf
 0Uep4IxhquUq2fGqGB8jINLtoLiNh+xzwUP62jZDh1RbuebfwBG4OOnFgupVctsBNwAhDmMSKei
 DeyL
X-Received: by 2002:a05:6830:3983:b0:7dc:da80:42be with SMTP id
 46e09a7af769-7e1df1b71e3mr16106593a34.21.1778523663281; 
 Mon, 11 May 2026 11:21:03 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-106-55.hlrn.qwest.net.
 [71.218.106.55]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be2238sm7294696a34.6.2026.05.11.11.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:21:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Date: Mon, 11 May 2026 12:20:25 -0600
Message-ID: <20260511182036.50453-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Environment callbacks can already be configured from Kconfig with
CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
require board headers to define CFG_ENV_FLAGS_LIST_STATIC.

Add CONFIG_ENV_FLAGS_LIST_STATIC and use it as the only board-provided
static environment flags list. Convert the remaining default-config users
from CFG_ENV_FLAGS_LIST_STATIC to defconfig settings and drop the legacy
header macro from ENV_FLAGS_LIST_STATIC.

Move the environment flags format documentation out of README and into
the developer environment documentation. Include the format in the
Kconfig help as well.

This lets boards configure writeable-list policy and type validation
from defconfig without adding a config header solely for env flags.

This preserves the behavior of default configs. Header-only cases that
were inactive in upstream defconfigs are not converted into defconfig
entries: iot2050 can add its list when enabling ENV_WRITEABLE_LIST, and
smegw01 can add mmcdev:dw support if the unlocked SYS_BOOT_LOCKED=n
configuration is needed.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes v2 -> v3:
  - Note that inactive header-only iot2050 flags and the smegw01
    SYS_BOOT_LOCKED=n mmcdev:dw flag are not converted into defconfigs.

Changes v1 -> v2:
  - Convert existing CFG_ENV_FLAGS_LIST_STATIC users to
    CONFIG_ENV_FLAGS_LIST_STATIC in defconfigs.
  - Drop CFG_ENV_FLAGS_LIST_STATIC support instead of appending the new
    Kconfig value after the legacy C macro.
  - Remove the trailing-comma requirement for board-specific static flags.
  - Place the migrated defconfig entries in savedefconfig order.
  - Move environment flags documentation from README to
    doc/develop/environment.rst.
  - Add the flags-list format to the CONFIG_ENV_FLAGS_LIST_STATIC Kconfig
    help text.
---
 README                               | 45 +---------------------------
 configs/aristainetos2c_defconfig     |  1 +
 configs/aristainetos2ccslb_defconfig |  1 +
 configs/hmibsc_defconfig             |  1 +
 configs/imx6q_bosch_acc_defconfig    |  1 +
 configs/imx8qxp_capricorn.config     |  1 +
 configs/smegw01_defconfig            |  1 +
 configs/socrates_defconfig           |  1 +
 doc/develop/environment.rst          | 40 +++++++++++++++++++++++++
 env/Kconfig                          | 23 ++++++++++++++
 include/configs/aristainetos2.h      |  3 --
 include/configs/capricorn-common.h   | 13 --------
 include/configs/hmibsc.h             |  4 ---
 include/configs/imx6q-bosch-acc.h    | 12 --------
 include/configs/iot2050.h            |  8 -----
 include/configs/smegw01.h            | 15 ----------
 include/configs/socrates.h           |  2 --
 include/env_flags.h                  |  6 +---
 18 files changed, 72 insertions(+), 106 deletions(-)

diff --git a/README b/README
index 6836a917c79..664d88a5505 100644
--- a/README
+++ b/README
@@ -799,7 +799,7 @@ The following options need to be configured:
 		The same can be accomplished in a more flexible way
 		for any variable by configuring the type of access
 		to allow for those variables in the ".flags" variable
-		or define CFG_ENV_FLAGS_LIST_STATIC.
+		or by setting CONFIG_ENV_FLAGS_LIST_STATIC.
 
 - Protected RAM:
 		CFG_PRAM
@@ -1106,49 +1106,6 @@ Configuration Settings:
 - CONFIG_SYS_FLASH_USE_BUFFER_WRITE
 		Use buffered writes to flash.
 
-- CONFIG_ENV_FLAGS_LIST_DEFAULT
-- CFG_ENV_FLAGS_LIST_STATIC
-	Enable validation of the values given to environment variables when
-	calling env set.  Variables can be restricted to only decimal,
-	hexadecimal, or boolean.  If CONFIG_CMD_NET is also defined,
-	the variables can also be restricted to IP address or MAC address.
-
-	The format of the list is:
-		type_attribute = [s|d|x|b|i|m]
-		access_attribute = [a|r|o|c]
-		attributes = type_attribute[access_attribute]
-		entry = variable_name[:attributes]
-		list = entry[,list]
-
-	The type attributes are:
-		s - String (default)
-		d - Decimal
-		x - Hexadecimal
-		b - Boolean ([1yYtT|0nNfF])
-		i - IP address
-		m - MAC address
-
-	The access attributes are:
-		a - Any (default)
-		r - Read-only
-		o - Write-once
-		c - Change-default
-
-	- CONFIG_ENV_FLAGS_LIST_DEFAULT
-		Define this to a list (string) to define the ".flags"
-		environment variable in the default or embedded environment.
-
-	- CFG_ENV_FLAGS_LIST_STATIC
-		Define this to a list (string) to define validation that
-		should be done if an entry is not found in the ".flags"
-		environment variable.  To override a setting in the static
-		list, simply add an entry for the same variable name to the
-		".flags" variable.
-
-	If CONFIG_REGEX is defined, the variable_name above is evaluated as a
-	regular expression. This allows multiple variables to define the same
-	flags without explicitly listing them for each variable.
-
 The following definitions that deal with the placement and management
 of environment data (variable area); in general, we support the
 following configurations:
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index 6923d27f79a..6c44e670cbc 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_FLAGS_LIST_STATIC="ethaddr:mw,serial#:sw,board_type:sw,sysnum:dw,panel:sw,ipaddr:iw,serverip:iw"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index 3ffebb15375..5016646ef87 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_FLAGS_LIST_STATIC="ethaddr:mw,serial#:sw,board_type:sw,sysnum:dw,panel:sw,ipaddr:iw,serverip:iw"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_EARLY=y
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 1e3d744193d..c8fad154e31 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -41,6 +41,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 # CONFIG_OF_UPSTREAM is not set
+CONFIG_ENV_FLAGS_LIST_STATIC="BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_MMC_EMMC_HW_PARTITION=2
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 6f0ef2eaee3..87cf676ed4c 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -74,6 +74,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clocks clock-names interrupt-parent"
+CONFIG_ENV_FLAGS_LIST_STATIC="bootset:bw,clone_pending:bw,endurance_test:bw,env_persisted:bw,factory_reset:bw,fdtcontroladdr:xw,fitpart:dw,mmcpart:dw,production:bw,ustate:dw"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
index 2bae5b1a862..91da5554db0 100644
--- a/configs/imx8qxp_capricorn.config
+++ b/configs/imx8qxp_capricorn.config
@@ -92,6 +92,7 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_FLAGS_LIST_STATIC="bootcount:dw,bootdelay:sw,bootlimit:dw,partitionset_active:sw,rastate:dw,sig_a:sw,sig_b:sw,target_env:sw,upgrade_available:dw,ustate:dw"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index 529836e7bdd..e5d4014d640 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_FLAGS_LIST_STATIC="mmcpart:dw,mmcpart_committed:dw,ustate:dw,bootcount:dw,bootlimit:dw,upgrade_available:dw"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/socrates_defconfig b/configs/socrates_defconfig
index 217141cceda..79e40268c6b 100644
--- a/configs/socrates_defconfig
+++ b/configs/socrates_defconfig
@@ -66,6 +66,7 @@ CONFIG_MTDIDS_DEFAULT="nor0=fe000000.nor_flash,nand0=socrates_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=fe000000.nor_flash:13312k(system1),13312k(system2),5120k(data),128k(env),128k(env-red),768k(u-boot);socrates_nand:256M(ubi-data1),-(ubi-data2)"
 # CONFIG_CMD_IRQ is not set
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_FLAGS_LIST_STATIC="ethaddr:mw,eth1addr:mw,system1_addr:xw,serial#:sw,ethact:sw,ethprime:sw"
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_ADDR_REDUND=0xFFF00000
diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
index e46cd39d601..a7ed4aab0a5 100644
--- a/doc/develop/environment.rst
+++ b/doc/develop/environment.rst
@@ -49,3 +49,43 @@ The signature of the callback functions is::
   include/search.h
 
 The return value is 0 if the variable change is accepted and 1 otherwise.
+
+Flags for environment variables
+-------------------------------
+
+Environment flags validate the values given to environment variables and
+restrict how environment variables can be changed.
+
+The static list is configured with CONFIG_ENV_FLAGS_LIST_STATIC. The list
+must be in the following format::
+
+    type_attribute = [s|d|x|b|i|m]
+    access_attribute = [a|r|o|c|w]
+    attributes = type_attribute[access_attribute]
+    entry = variable_name[:attributes]
+    list = entry[,list]
+
+The type attributes are:
+
+* s - String (default)
+* d - Decimal
+* x - Hexadecimal
+* b - Boolean ([1yYtT|0nNfF])
+* i - IP address, if networking is enabled
+* m - MAC address, if networking is enabled
+
+The access attributes are:
+
+* a - Any (default)
+* r - Read-only
+* o - Write-once
+* c - Change-default
+* w - Writeable, if CONFIG_ENV_WRITEABLE_LIST is enabled
+
+CONFIG_ENV_FLAGS_LIST_DEFAULT defines the ``.flags`` variable in the
+default or embedded environment. Any association in ``.flags`` overrides
+an association in the static list.
+
+If CONFIG_REGEX is defined, the variable name is evaluated as a regular
+expression. This allows multiple variables to define the same flags without
+explicitly listing them all.
diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..3c9aaeb1f16 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -34,6 +34,29 @@ config ENV_CALLBACK_LIST_STATIC
 	  If the callback name is not specified, then the callback is deleted.
 	  Spaces are also allowed anywhere in the list.
 
+config ENV_FLAGS_LIST_STATIC
+	string "Static flags list"
+	default ""
+	help
+	  The environment flags are associated with variables in a static
+	  list. Define this list in the following format:
+
+	  type_attribute = [s|d|x|b|i|m]
+	  access_attribute = [a|r|o|c|w]
+	  attributes = type_attribute[access_attribute]
+	  entry = variable_name[:attributes]
+	  list = entry[,list]
+
+	  The type attributes are s for string, d for decimal, x for
+	  hexadecimal and b for boolean. If networking is enabled, i can
+	  be used for IP addresses and m for MAC addresses.
+
+	  The access attributes are a for any, r for read-only, o for
+	  write-once and c for change-default. When CONFIG_ENV_WRITEABLE_LIST
+	  is enabled, w can be used to mark variables as writable.
+
+	  Spaces are also allowed anywhere in the list.
+
 config SAVEENV
 	def_bool y if CMD_SAVEENV
 
diff --git a/include/configs/aristainetos2.h b/include/configs/aristainetos2.h
index 8a66b1275df..c0e5c72764e 100644
--- a/include/configs/aristainetos2.h
+++ b/include/configs/aristainetos2.h
@@ -413,7 +413,4 @@
 
 /* UBI support */
 
-#define CFG_ENV_FLAGS_LIST_STATIC "ethaddr:mw,serial#:sw,board_type:sw," \
-		"sysnum:dw,panel:sw,ipaddr:iw,serverip:iw"
-
 #endif                         /* __ARISTAINETOS2_CONFIG_H */
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index ee13d2ab950..7120a44d186 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -38,19 +38,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	AHAB_ENV
 
-#ifdef CONFIG_ENV_WRITEABLE_LIST
-#define CFG_ENV_FLAGS_LIST_STATIC \
-	"bootcount:dw," \
-	"bootdelay:sw," \
-	"bootlimit:dw," \
-	"partitionset_active:sw," \
-	"rastate:dw," \
-	"sig_a:sw,sig_b:sw," \
-	"target_env:sw," \
-	"upgrade_available:dw," \
-	"ustate:dw"
-#endif
-
 /* Default location for tftp and bootm */
 
 /* On CCP board, USDHC1 is for eMMC */
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
index 950ec8b190d..ea9762ee448 100644
--- a/include/configs/hmibsc.h
+++ b/include/configs/hmibsc.h
@@ -8,8 +8,4 @@
 #ifndef __CONFIGS_HMIBSC_H
 #define __CONFIGS_HMIBSC_H
 
-/* PHY needs a longer aneg time */
-
-#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
-
 #endif
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index 84da8250684..e00cddfdac0 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -44,18 +44,6 @@
 		"then env set env_persisted 1; run save_env; fi;\0" \
 	"save_env=env save; env save\0"
 
-#define CFG_ENV_FLAGS_LIST_STATIC \
-	"bootset:bw," \
-	"clone_pending:bw," \
-	"endurance_test:bw," \
-	"env_persisted:bw," \
-	"factory_reset:bw," \
-	"fdtcontroladdr:xw," \
-	"fitpart:dw," \
-	"mmcpart:dw," \
-	"production:bw," \
-	"ustate:dw"
-
 #else
 /* SD Card boot */
 #define ENV_EXTRA \
diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 5c58c7bbaab..fac4bbcd4ed 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -38,12 +38,4 @@
        func(MMC, mmc, 0) \
        BOOT_TARGET_USB(func)
 
-#ifdef CONFIG_ENV_WRITEABLE_LIST
-#define CFG_ENV_FLAGS_LIST_STATIC					\
-	"board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"	\
-	"mlfb:sw,fw_version:sw,seboot_version:sw,"			\
-	"m2_manual_config:sw,"						\
-	"eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
-#endif
-
 #endif /* __CONFIG_IOT2050_H */
diff --git a/include/configs/smegw01.h b/include/configs/smegw01.h
index 0aa25f9e2ea..c0ca5a7db2f 100644
--- a/include/configs/smegw01.h
+++ b/include/configs/smegw01.h
@@ -22,21 +22,6 @@
 #define EXTRA_BOOTPARAMS
 #endif
 
-#ifdef CONFIG_SYS_BOOT_LOCKED
-#define EXTRA_ENV_FLAGS
-#else
-#define EXTRA_ENV_FLAGS "mmcdev:dw,"
-#endif
-
-#define CFG_ENV_FLAGS_LIST_STATIC \
-	"mmcpart:dw," \
-	"mmcpart_committed:dw," \
-	"ustate:dw," \
-	"bootcount:dw," \
-	"bootlimit:dw," \
-	"upgrade_available:dw," \
-	EXTRA_ENV_FLAGS
-
 /* Physical Memory Map */
 #define PHYS_SDRAM			MMDC0_ARB_BASE_ADDR
 
diff --git a/include/configs/socrates.h b/include/configs/socrates.h
index 006d649f6ed..68d177d4ca3 100644
--- a/include/configs/socrates.h
+++ b/include/configs/socrates.h
@@ -108,8 +108,6 @@
  */
 #define CFG_SYS_BOOTMAPSZ	(8 << 20)	/* Initial Memory map for Linux	*/
 
-#define CFG_ENV_FLAGS_LIST_STATIC "ethaddr:mw,eth1addr:mw,system1_addr:xw,serial#:sw,ethact:sw,ethprime:sw"
-
 /* pass open firmware flat tree */
 
 #endif	/* __CONFIG_H */
diff --git a/include/env_flags.h b/include/env_flags.h
index 123fdbcb0ba..245dfdbd564 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -37,10 +37,6 @@ enum env_flags_varaccess {
 #define ENV_FLAGS_VARTYPE_LOC 0
 #define ENV_FLAGS_VARACCESS_LOC 1
 
-#ifndef CFG_ENV_FLAGS_LIST_STATIC
-#define CFG_ENV_FLAGS_LIST_STATIC ""
-#endif
-
 #if CONFIG_IS_ENABLED(NET)
 #ifdef CONFIG_REGEX
 #define ETHADDR_WILDCARD "\\d*"
@@ -89,7 +85,7 @@ enum env_flags_varaccess {
 	NET_FLAGS \
 	NET6_FLAGS \
 	SERIAL_FLAGS \
-	CFG_ENV_FLAGS_LIST_STATIC
+	CONFIG_ENV_FLAGS_LIST_STATIC
 
 #ifdef CONFIG_CMD_ENV_FLAGS
 /*
-- 
2.53.0

