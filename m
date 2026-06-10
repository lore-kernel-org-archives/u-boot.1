Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F706CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E130084940;
	Wed, 10 Jun 2026 16:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UR8MEDJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A0384949; Wed, 10 Jun 2026 16:37:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379BA84940
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68cebf2657cso1074837a12.3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102252; x=1781707052; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PEx4+P2LtrDq0ygVvNwpcLQAjXmwkF5Y29oKT+5+OKM=;
 b=UR8MEDJbMHo7zeQX1gFcuzDbNhp7SVuqOoDyOcM4SwOrUoem7+oQ7hY9OWd6ko7m98
 y5leNE+g1v/VK2udp/1xnHWm+SR285BJsd8TOAjKngNKcFQhNAfdhPzP6N9fZiuw4hJK
 KVHIz3Nne8xJ6y2M5jl33h5/qy+dhuqu86t9JE8htSz1yGdFS+ms90BDb/1EU0lFTPyC
 cbjq8jn/Qlc2rm/WAp5XP3caWjy8ANNLQzd7W7fbC0TyMCz96yXiZBFaMSSF3qG9oaNm
 mnM8+Z/twd88xrQk1pb34YXJccSLbyz7tJjGqg/tD5C7mmihqxRrOI6KZpJRSGxW3N9A
 k3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102252; x=1781707052;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PEx4+P2LtrDq0ygVvNwpcLQAjXmwkF5Y29oKT+5+OKM=;
 b=hDn6KnA2A9X3C6lWNfxJZdMeYlTS0F9x8q16v84V3Hx0UHBWdHw6W8SILKryIROjPE
 rlAjnaWC4CgpjEF9JXFQlBc/u4ROz35SklWGcfNxSgsOTgHwrLmn147SrWZU5/L+3KFn
 PEgNJbYUh1c3nciJBiIa0S72q1sz+dXzMB8Pu2ctRZX0DGMzLnw7ln4rrTrnAYTT9cbr
 ya3P00xw5qFwRrJzvtb0wN8/J3pi+R5IpV/rhJecUsPLYER71x/jOaLB66Ha2os6vOTW
 DhXCYkfj+mYAkobIoxdK/RUmz4ATwl2wjogtIzu2GP2shPbnS4ew7qr0vpCjx7dMUeuK
 RdQg==
X-Gm-Message-State: AOJu0Yyk2zckNji4/3w+UkvFCJgaBjMFw3HHMKO2V2ijyxNocOnpJaOT
 xDfDMHipKIhI6+6EW3RbHo+FL67DiRHwkzKwxc91T30PLkqKCsYMotRXfPTpYA==
X-Gm-Gg: Acq92OFkoDYzib+zPUrpLSAiOL9nPd/qb8RSAmfprr0lLHc8Mdzby4Qn/+i8WlyHsnt
 N5wXPbOipWRgei1od313snsZjH8fSNGGmmU6JOAgwaAwZ+VF7pN9xi0drInBeGRSEv81W6xzIhe
 51S3WWms/uZliIFl6PQzV10SG+YNY3ilM6MvqRjwv53IXDmDuVLtBfgQU1+C4Xw3VFCzn8TtDeN
 AGucOuY0m69HGfyj+v1WTCnms0w8FjMqbBvQfTe3g88u22SBumOaCGcNnhnWipuLSFX1rvdctYe
 z6VBSJuXbKdQmot+OlBbP9lNtc+zbO+GTpGOCh+E+abgMv3k6fbcpqRYHZvsXKBIA8daE5Bs0Mf
 xby+Ftyof+/lfW+WRSViWNvGRxy3XD/7P0Uxzibf7thU5BDDLUYE3I1KZ0LSwrNvWLm48FAFjpW
 8RiWrvRfi6AbY2HSjTYx9EvnBrXCT642M2JG3DVZb5kKxmZiuf3mMdIVgMB0sOaAhpKux2GOjF
X-Received: by 2002:a17:907:28ca:b0:b9b:1963:2ff2 with SMTP id
 a640c23a62f3a-bf36d2c1748mr469720166b.0.1781102251152; 
 Wed, 10 Jun 2026 07:37:31 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0553040a7sm1199168966b.50.2026.06.10.07.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:37:30 -0700 (PDT)
Message-ID: <efb12ce2-6346-454d-8616-2a0f71542764@gmail.com>
Date: Wed, 10 Jun 2026 16:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 02/18] Kconfig: cmd: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "cmd":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 cmd/Kconfig    | 74 +++++++++++++++++++++++++-------------------------
 cmd/ti/Kconfig | 18 ++++++------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..6ca414e90743 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -881,12 +881,12 @@ config EEPROM_LAYOUT_VERSIONS
 	  via the -l option.

 config EEPROM_LAYOUT_HELP_STRING
-	  string "Tells user what layout names are supported"
-	  depends on EEPROM_LAYOUT_VERSIONS
-	  default "<not defined>"
-	  help
-	    Help printed with the LAYOUT VERSIONS part of the 'eeprom'
-	    command's help.
+	string "Tells user what layout names are supported"
+	depends on EEPROM_LAYOUT_VERSIONS
+	default "<not defined>"
+	help
+	  Help printed with the LAYOUT VERSIONS part of the 'eeprom'
+	  command's help.

 config SYS_I2C_EEPROM_BUS
 	int "I2C bus of the EEPROM device."
@@ -967,14 +967,14 @@ config CMD_MEMORY
 	default y
 	help
 	  Memory commands.
-	    md - memory display
-	    mm - memory modify (auto-incrementing address)
-	    nm - memory modify (constant address)
-	    mw - memory write (fill)
-	    cp - memory copy
-	    cmp - memory compare
-	    base - print or set address offset
-	    loop - initialize loop on address range
+	  md - memory display
+	  mm - memory modify (auto-incrementing address)
+	  nm - memory modify (constant address)
+	  mw - memory write (fill)
+	  cp - memory copy
+	  cmp - memory compare
+	  base - print or set address offset
+	  loop - initialize loop on address range

 config CMD_MEM_SEARCH
 	bool "ms - Memory search"
@@ -1115,9 +1115,9 @@ config CMD_ARMFFA
 	help
 	  Provides a test command for the FF-A support
 	  supported options:
-		- Listing the partition(s) info
-		- Sending a data pattern to the specified partition
-		- Displaying the arm_ffa device info
+	  - Listing the partition(s) info
+	  - Sending a data pattern to the specified partition
+	  - Displaying the arm_ffa device info

 config CMD_ARMFLASH
 	bool "armflash"
@@ -1214,9 +1214,9 @@ config CMD_FLASH
 	depends on FLASH_CFI_DRIVER || MTD_NOR_FLASH
 	help
 	  NOR flash support.
-	    flinfo - print FLASH memory information
-	    erase - FLASH memory
-	    protect - enable or disable FLASH write protection
+	  flinfo - print FLASH memory information
+	  erase - FLASH memory
+	  protect - enable or disable FLASH write protection

 config CMD_FPGA
 	bool "fpga"
@@ -1548,7 +1548,7 @@ config CMD_OPTEE
 	bool "Enable OP-TEE commands"
 	depends on OPTEE
 	help
-	 OP-TEE commands support.
+	  OP-TEE commands support.

 config CMD_MTD
 	bool "mtd"
@@ -1606,7 +1606,7 @@ config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
 	help
-	 List, select, and deselect mux controllers on the fly.
+	  List, select, and deselect mux controllers on the fly.

 config CMD_NAND
 	bool "nand"
@@ -1814,7 +1814,7 @@ config CMD_UFS
 	depends on UFS
 	help
 	  "This provides commands to initialise and configure universal flash
-	   subsystem devices"
+	  subsystem devices"

 config CMD_USB
 	bool "usb"
@@ -1936,7 +1936,7 @@ config CMD_SETEXPR
 	default y
 	help
 	  Evaluate boolean and math expressions and store the result in an env
-	    variable.
+	  variable.
 	  Also supports loading the value at a memory location into a variable.
 	  If CONFIG_REGEX is enabled, setexpr also supports a gsub function.

@@ -2642,9 +2642,9 @@ config CMD_PSTORE_ECC_SIZE
 	depends on CMD_PSTORE
 	default "0"
 	help
-	if non-zero, the option enables ECC support and specifies ECC buffer
-	size in bytes (1 is a special value, means 16 bytes ECC), should be
-	identical to ramoops.ramoops_ecc parameter used by kernel
+	  if non-zero, the option enables ECC support and specifies ECC buffer
+	  size in bytes (1 is a special value, means 16 bytes ECC), should be
+	  identical to ramoops.ramoops_ecc parameter used by kernel

 endif

@@ -3156,15 +3156,15 @@ config CMD_AVB
 	help
 	  Enables a "avb" command to perform verification of partitions using
 	  Android Verified Boot 2.0 functionality. It includes such subcommands:
-	    avb init - initialize avb2 subsystem
-	    avb read_rb - read rollback index
-	    avb write_rb - write rollback index
-	    avb is_unlocked - check device lock state
-	    avb get_uuid - read and print uuid of a partition
-	    avb read_part - read data from partition
-	    avb read_part_hex - read data from partition and output to stdout
-	    avb write_part - write data to partition
-	    avb verify - run full verification chain
+	  avb init - initialize avb2 subsystem
+	  avb read_rb - read rollback index
+	  avb write_rb - write rollback index
+	  avb is_unlocked - check device lock state
+	  avb get_uuid - read and print uuid of a partition
+	  avb read_part - read data from partition
+	  avb read_part_hex - read data from partition and output to stdout
+	  avb write_part - write data to partition
+	  avb verify - run full verification chain

 config CMD_STACKPROTECTOR_TEST
 	bool "Test command for stack protector"
@@ -3194,7 +3194,7 @@ config CMD_UBI_RENAME
 	depends on CMD_UBI
 	help
 	  Enable a "ubi" command to rename ubi volume:
-	   ubi rename <oldname> <newname>
+	  ubi rename <oldname> <newname>

 config CMD_UBIFS
 	tristate "Enable UBIFS - Unsorted block images filesystem commands"
diff --git a/cmd/ti/Kconfig b/cmd/ti/Kconfig
index 43fe9ef2f080..17cf867dd91d 100644
--- a/cmd/ti/Kconfig
+++ b/cmd/ti/Kconfig
@@ -4,24 +4,24 @@ config CMD_DDR3
 	bool "command for verifying DDR features"
 	depends on ARCH_KEYSTONE || DRA7XX
 	help
-	   Support for testing ddr3 on TI platforms. This command
-	   supports memory verification, memory comapre and ecc
-	   verification if supported.
+	  Support for testing ddr3 on TI platforms. This command
+	  supports memory verification, memory comapre and ecc
+	  verification if supported.

 config CMD_DDR4
 	bool "command for verifying DDRSS Inline ECC features"
 	depends on ARCH_K3
 	help
-	   Support for testing DDRSS on TI platforms. This command supports
-	   memory verification, memory compare and inline ECC verification
-	   if supported.
+	  Support for testing DDRSS on TI platforms. This command supports
+	  memory verification, memory compare and inline ECC verification
+	  if supported.

 config CMD_PD
 	bool "command for verifying power domains"
 	depends on TI_POWER_DOMAIN
 	help
-	   Debug command for K3 power domains. For this to work, the
-	   K3 power domain driver must be enabled for the u-boot; by
-	   default it is only enabled for SPL.
+	  Debug command for K3 power domains. For this to work, the
+	  K3 power domain driver must be enabled for the u-boot; by
+	  default it is only enabled for SPL.

 endmenu
--
2.39.5

