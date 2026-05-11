Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B46CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C366B83FEC;
	Mon, 11 May 2026 20:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j5bhUMEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0E0845E3; Mon, 11 May 2026 20:21:11 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B1C83FEC
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so5053231a34.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523668; x=1779128468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoHVk7iKqtTQazlrYvRPt89wwn09aE876gAGE9eUfsc=;
 b=j5bhUMEiRLxzST4dcjYu87nRNyBysVkCG+HhgAyxw+Wn4BgeqYTbk8NcfibGYmf5wN
 sJMecht0+hIZlStBORQqtm0UMjHqz3KiyrpahcFqlV0DUAoEAPX+rmNyxQOjFSToOX+L
 0WaGRSL//XMSoMB0dVrPgR0sbT5MOLARX4/HXNgG8aM1C2/zIyfIDwI5DYG0kR04B8ja
 6uHV3T7XeqR57X9TCh5wmjXCFwDA6zyDKCAJf0uRtSoeScyirkKPsCQE3slI8Xj6zzuW
 2ams4OCAXE4Vc84T0vBh+WZdvemWr9rC76E6DlAXdfYrAGGdRQN45ttixVtS3MhgSh8A
 BV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523668; x=1779128468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SoHVk7iKqtTQazlrYvRPt89wwn09aE876gAGE9eUfsc=;
 b=MGyQhU7cSq9ZWK0VIvjyzKqq+GNQ3P2dVsl2Cpp/JnIxMoNWRwWRT8vVsbhzr9mZ7X
 OLGLIScW4BTRMQDNecyDTFIfI83+tMonjuxHB8GDWwoKQ0vN3G9zjpxJ445liFb+Mpd5
 tYQjTd0lKcnx/6mkX7xCoMn82K+AtM2PxxVeRql3ben84vHLFTVsv12xV3d7FQ0flLLS
 Qzl1nn/WpqTZC5jjBnQ1D9UAvuC/ha/e3255TpjPbjvxZm56E5csQ/tzm09BLUsc8rZh
 3Bly1Htloebk+Uvv25MOAwW3D1ErSYrXAwTeTJ44aFE3Zmasj2ndAe7vGp8bk7fJrU/3
 LpcA==
X-Gm-Message-State: AOJu0YwsrKVix+8gPtaPzXaTDG2vd8kqIqYhQpiCiTrvTH7UHn3JJqtW
 Yta+PVGq28CgeB4xFLCpUk2Qla1Cp/Ca8d/UFYRXlyT6EASgg9kiQti5kv+/v5H8
X-Gm-Gg: Acq92OGz7SJPXveh9Fevla/wPSK4TAQdK7EHMfPcjGqKWNmI7Cj0ydr7PXc/rUjfxs/
 pz6w8aOGiOaOfV8i4Zf2bRFSpib9idvnXMXofbJGGjmoAXBiQO11PrgWJLpCYomjIdlBUQCQiYm
 +zJ+nAg6DPY/nDF4QJFos6kn6k5cEn+DwoCAfrYbhp93B/kDfdh7iK0Tyne1ppZey2M8i9sNWqY
 DyIsnc01xD1+NlVtI3UymBD4H63NMPGzkO9H1lWPTVporhOwHg/ECKzuiiBj3u5tpdwLCQr1fgz
 jMQBPxxX64qIiABeliRnJ66wTr6VMUisdqWfOsKw6q7mdItanJuUTNsjOBKU44nN/DL4jcEC1uC
 RMrNl54UHg8bB2oxm0s3zonp/y751aneI3d3PEiQe1UFkV4Ahf+kJ+2qkJfNnElzqrvI+KgNEgx
 wfwzyNsKuyTFt/BVwTEIjO0/CGA7Mnhbsq/KLGQOwZ933pC1wWQaiRfEsCkBVfbGtf47HVKn+bj
 kUL/CtaSchTIQdXMawfEDH4v9eq1OQJYuR/zAY4/tz58hOzwZmtk9ytNk0m4Scw5Oezkw==
X-Received: by 2002:a05:6830:378e:b0:7d7:f638:7a03 with SMTP id
 46e09a7af769-7e1deef8085mr16381001a34.10.1778523667745; 
 Mon, 11 May 2026 11:21:07 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-106-55.hlrn.qwest.net.
 [71.218.106.55]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be2238sm7294696a34.6.2026.05.11.11.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:21:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Fabio Estevam <festevam@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philip Molloy <philip.molloy@analog.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>, Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peter Robinson <pbrobinson@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH v3 2/2] doc: remove configuration settings from README
Date: Mon, 11 May 2026 12:20:26 -0600
Message-ID: <20260511182036.50453-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511182036.50453-1-james.hilliard1@gmail.com>
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
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

The remaining configuration settings section is legacy README content.
Its details belong in Kconfig help or the rST documentation.

Remove the section instead of keeping partial stale configuration
documentation in README.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 README | 124 ---------------------------------------------------------
 1 file changed, 124 deletions(-)

diff --git a/README b/README
index 664d88a5505..e10a4bc472a 100644
--- a/README
+++ b/README
@@ -1033,130 +1033,6 @@ typically in board_init_f() and board_init_r().
 - CONFIG_BOARD_EARLY_INIT_R: Call board_early_init_r()
 - CONFIG_BOARD_LATE_INIT: Call board_late_init()
 
-Configuration Settings:
------------------------
-
-- CONFIG_SYS_LONGHELP: Defined when you want long help messages included;
-		undefine this when you're short of memory.
-
-- CFG_SYS_HELP_CMD_WIDTH: Defined when you want to override the default
-		width of the commands listed in the 'help' command output.
-
-- CONFIG_SYS_PROMPT:	This is what U-Boot prints on the console to
-		prompt for user input.
-
-- CFG_SYS_BAUDRATE_TABLE:
-		List of legal baudrate settings for this board.
-
-- CFG_SYS_MEM_RESERVE_SECURE
-		Only implemented for ARMv8 for now.
-		If defined, the size of CFG_SYS_MEM_RESERVE_SECURE memory
-		is substracted from total RAM and won't be reported to OS.
-		This memory can be used as secure memory. A variable
-		gd->arch.secure_ram is used to track the location. In systems
-		the RAM base is not zero, or RAM is divided into banks,
-		this variable needs to be recalcuated to get the address.
-
-- CFG_SYS_SDRAM_BASE:
-		Physical start address of SDRAM. _Must_ be 0 here.
-
-- CFG_SYS_FLASH_BASE:
-		Physical start address of Flash memory.
-
-- CONFIG_SYS_MALLOC_LEN:
-		Size of DRAM reserved for malloc() use.
-
-- CFG_SYS_BOOTMAPSZ:
-		Maximum size of memory mapped by the startup code of
-		the Linux kernel; all data that must be processed by
-		the Linux kernel (bd_info, boot arguments, FDT blob if
-		used) must be put below this limit, unless "bootm_low"
-		environment variable is defined and non-zero. In such case
-		all data for the Linux kernel must be between "bootm_low"
-		and "bootm_low" + CFG_SYS_BOOTMAPSZ.	 The environment
-		variable "bootm_mapsize" will override the value of
-		CFG_SYS_BOOTMAPSZ.  If CFG_SYS_BOOTMAPSZ is undefined,
-		then the value in "bootm_size" will be used instead.
-
-- CONFIG_SYS_BOOT_GET_CMDLINE:
-		Enables allocating and saving kernel cmdline in space between
-		"bootm_low" and "bootm_low" + BOOTMAPSZ.
-
-- CONFIG_SYS_BOOT_GET_KBD:
-		Enables allocating and saving a kernel copy of the bd_info in
-		space between "bootm_low" and "bootm_low" + BOOTMAPSZ.
-
-- CONFIG_SYS_FLASH_PROTECTION
-		If defined, hardware flash sectors protection is used
-		instead of U-Boot software protection.
-
-- CONFIG_SYS_FLASH_CFI:
-		Define if the flash driver uses extra elements in the
-		common flash structure for storing flash geometry.
-
-- CONFIG_FLASH_CFI_DRIVER
-		This option also enables the building of the cfi_flash driver
-		in the drivers directory
-
-- CONFIG_FLASH_CFI_MTD
-		This option enables the building of the cfi_mtd driver
-		in the drivers directory. The driver exports CFI flash
-		to the MTD layer.
-
-- CONFIG_SYS_FLASH_USE_BUFFER_WRITE
-		Use buffered writes to flash.
-
-The following definitions that deal with the placement and management
-of environment data (variable area); in general, we support the
-following configurations:
-
-BE CAREFUL! The first access to the environment happens quite early
-in U-Boot initialization (when we try to get the setting of for the
-console baudrate). You *MUST* have mapped your NVRAM area then, or
-U-Boot will hang.
-
-Please note that even with NVRAM we still use a copy of the
-environment in RAM: we could work on NVRAM directly, but we want to
-keep settings there always unmodified except somebody uses "saveenv"
-to save the current settings.
-
-BE CAREFUL! For some special cases, the local device can not use
-"saveenv" command. For example, the local device will get the
-environment stored in a remote NOR flash by SRIO or PCIE link,
-but it can not erase, write this NOR flash by SRIO or PCIE interface.
-
-- CONFIG_NAND_ENV_DST
-
-	Defines address in RAM to which the nand_spl code should copy the
-	environment. If redundant environment is used, it will be copied to
-	CONFIG_NAND_ENV_DST + CONFIG_ENV_SIZE.
-
-Please note that the environment is read-only until the monitor
-has been relocated to RAM and a RAM copy of the environment has been
-created; also, when using EEPROM you will have to use env_get_f()
-until then to read environment variables.
-
-The environment is protected by a CRC32 checksum. Before the monitor
-is relocated into RAM, as a result of a bad CRC you will be working
-with the compiled-in default environment - *silently*!!! [This is
-necessary, because the first environment variable we need is the
-"baudrate" setting for the console - if we have a bad CRC, we don't
-have any device yet where we could complain.]
-
-Note: once the monitor has been relocated, then it will complain if
-the default environment is used; a new CRC is computed as soon as you
-use the "saveenv" command to store a valid environment.
-
-- CONFIG_DISPLAY_BOARDINFO
-		Display information about the board that U-Boot is running on
-		when U-Boot starts up. The board function checkboard() is called
-		to do this.
-
-- CONFIG_DISPLAY_BOARDINFO_LATE
-		Similar to the previous option, but display this information
-		later, once stdio is running and output goes to the LCD, if
-		present.
-
 Low Level (hardware related) configuration options:
 ---------------------------------------------------
 
-- 
2.53.0

