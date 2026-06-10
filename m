Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334B3CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED74849C5;
	Wed, 10 Jun 2026 16:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YomowMPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A719849C6; Wed, 10 Jun 2026 16:40:20 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA6F9849BF
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68c1f35b15dso899965a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102416; x=1781707216; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oaaz9lyou7fAmam1QzMdDBavnCkPcIuXKrmARL8GE0E=;
 b=YomowMPcrrCfPSiMgKbxUNmuGCZUnrtlSb3UnNtpjv0DHzh3xCLGSjeGZrgLLZcsVW
 QQNGVgKmCs82HzS6QhXCuPT6Aclkpm4aip5P5KEIjzOzlfH9XF56W6wvpn3Clzg5Dq97
 9IyWbQl01FvxyICU8yk8royXLrs7dhr08u3zG0gIXSTOG7SLIwsbDN2G7+Z+VSkDrWfR
 VnzlFNjlH/VSpVI5RTTCJ8OFQgLdtHbWL+k6klTR7zYCEjudvktUTq/5kpShTT+Ne3wy
 EPkp4uVNw9f7Yu+gd+jMXDoHhHlIcvPehPmJTU1twSwqABp2f4bIUuk1HH5A6+fu8qGy
 YuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102416; x=1781707216;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oaaz9lyou7fAmam1QzMdDBavnCkPcIuXKrmARL8GE0E=;
 b=fIldBxoK3XNEqyjC95jtBPNVEpKKIvBvFzJ16rhW5b5WE1NCQZWpMS1RA9fxF9in0R
 6x0/pD5eriMpuecawnlf44zgCJe+gyTq5ca44zzANwJZnzZPtYWzDoOG67Pj53JYNE1O
 a4WyP0gmcwaVpczPtWC7QKAlqwHy+VroGGRkVj5ubVskJlBn9Rw9ZyA1wSaubxIU7GYL
 H751IvcZrhJnAyHqeAKy9xjlBMAFzYG8w6e8QrTZvpP2E7E6JAvHQ2y75jqkMm4n6sO+
 oD7+PhzWDZDoTzmGDuykNtGCY+h6+7wxatw04sDkKPko/XeKJo8ZXK1pL92u+MIFD4K8
 RJuA==
X-Gm-Message-State: AOJu0YwoAwb1kYeRDpmcoEvplyzDhRdAjJIrXUzSi7cUSUj7TfrC0KWx
 cQuPjjiGUBOptCI7PVzeNlpmfCJbdCZB00I7VAguCBQPXUU1Pi8LLKoT
X-Gm-Gg: Acq92OHq+zj0WLaOyG8GK2Cye0nqNnEPhO8+iDxjxhVQh+T7/Zxt+spgEv6X4KsaZkP
 WDv8EqBdHtxiBR01UxlrM0tuL2fDYNQ0gGFyIX02Ypvi8oyQXZQxrwh6MhQjQQOLAYOHBFltFCh
 VW/eq7rrURHCpShJ/LnvNBBUGT16Su+7Z1x7nUjPLqBKAGHE+MRppQ9dHzzsB+M82Nxjm7/xq5N
 ro/yjlr2BEOuW0P9dPyRzzAHCQsvYVaCN4xs0vMEsmKQWOQ9qG7DEGXKk3mgEnUvL1P1Qq4AvcS
 8pdeasSC1NGG5ZDVzjjfcTDeKf8B0stdHv4sxEAja4AkoqBYbEPGvJgm/HNs+gcOQ6cNmGe8biK
 Nd+vLw46C6jtXmSch8FrzJRq3bOqIOKcTQf1Y01XV74btlpMXJbWSPodASSkngpMo6dihDCaSX9
 ae+sdjwEWYBFCfOCLaEI2tt9E/c0RoarXjK04+FEQDxQD7mdtF7TMBaR5wCXg9Gtwa3oUXQyWO
X-Received: by 2002:a05:6402:4405:b0:688:1d5:44dd with SMTP id
 4fb4d7f45d1cf-69237100b10mr2088782a12.0.1781102414697; 
 Wed, 10 Jun 2026 07:40:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6914f3b583bsm5998678a12.29.2026.06.10.07.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:40:14 -0700 (PDT)
Message-ID: <96d12281-5228-4a22-a432-eccd92996ef9@gmail.com>
Date: Wed, 10 Jun 2026 16:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 13/18] Kconfig: power: restyle
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

Restyle all Kconfigs for "power":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/power/Kconfig           | 364 ++++++++++++++---------------
 drivers/power/domain/Kconfig    |   8 +-
 drivers/power/pmic/Kconfig      | 348 ++++++++++++++--------------
 drivers/power/regulator/Kconfig | 398 ++++++++++++++++----------------
 4 files changed, 559 insertions(+), 559 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 1b06d8a66c7c..66c389d073b0 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -1,7 +1,7 @@
 menuconfig POWER
-	 bool "Power"
-	 default y
-	 help
+	bool "Power"
+	default y
+	help
 	  Enable support for power control in U-Boot. This includes support
 	  for PMICs (Power-management Integrated Circuits) and some of the
 	  features provided by PMICs. In particular, voltage regulators can
@@ -63,98 +63,98 @@ choice

 config SUNXI_NO_PMIC
 	bool "board without a pmic"
-	---help---
-	Select this for boards which do not use a PMIC.
+	help
+	  Select this for boards which do not use a PMIC.

 config AXP152_POWER
 	bool "axp152 pmic support"
 	depends on MACH_SUN5I
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the axp152 pmic found on most
-	A10s boards.
+	help
+	  Select this to enable support for the axp152 pmic found on most
+	  A10s boards.

 config AXP209_POWER
 	bool "axp209 pmic support"
 	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUN8I_V3S
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the axp209 pmic found on most
-	A10, A13 and A20 boards.
+	help
+	  Select this to enable support for the axp209 pmic found on most
+	  A10, A13 and A20 boards.

 config AXP221_POWER
 	bool "axp221 / axp223 pmic support"
 	depends on MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the axp221/axp223 pmic found on most
-	A23 and A31 boards.
+	help
+	  Select this to enable support for the axp221/axp223 pmic found on most
+	  A23 and A31 boards.

 config AXP305_POWER
 	bool "axp305 pmic support"
 	depends on MACH_SUN50I_H616
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the axp305 pmic found on most
-	H616 boards.
+	help
+	  Select this to enable support for the axp305 pmic found on most
+	  H616 boards.

 config AXP313_POWER
 	bool "axp313 pmic support"
 	depends on MACH_SUN50I_H616
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the AXP313 PMIC found on some
-	H616 boards.
+	help
+	  Select this to enable support for the AXP313 PMIC found on some
+	  H616 boards.

 config AXP717_POWER
 	bool "axp717 pmic support"
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the AXP717 PMIC found on some boards.
+	help
+	  Select this to enable support for the AXP717 PMIC found on some boards.

 config AXP803_POWER
 	bool "AXP803 PMIC support"
 	select AXP_PMIC_BUS
-	---help---
-	Select this to enable support for the AXP803 PMIC found on some boards.
+	help
+	  Select this to enable support for the AXP803 PMIC found on some boards.

 config AXP809_POWER
 	bool "axp809 pmic support"
 	depends on MACH_SUN9I
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Say y here to enable support for the axp809 pmic found on A80 boards.
+	help
+	  Say y here to enable support for the axp809 pmic found on A80 boards.

 config AXP818_POWER
 	bool "axp818 pmic support"
 	depends on MACH_SUN8I_A83T
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Say y here to enable support for the axp818 pmic found on
-	A83T dev board.
+	help
+	  Say y here to enable support for the axp818 pmic found on
+	  A83T dev board.

 config AXP318W_POWER
 	bool "axp318w pmic support"
 	select AXP_PMIC_BUS
 	select CMD_POWEROFF
-	---help---
-	Select this to enable support for the AXP318W PMIC found on some
-	A733 boards.
+	help
+	  Select this to enable support for the AXP318W PMIC found on some
+	  A733 boards.

 config SY8106A_POWER
 	bool "SY8106A pmic support"
 	depends on MACH_SUNXI_H3_H5
-	---help---
-	Select this to enable support for the SY8106A pmic found on some
-	H3 boards.
+	help
+	  Select this to enable support for the SY8106A pmic found on some
+	  H3 boards.

 endchoice

@@ -166,22 +166,22 @@ config AXP_I2C_ADDRESS
 	default 0x36 if AXP318W_POWER
 	default 0x30 if AXP152_POWER
 	default 0x34
-	---help---
-	I2C address of the AXP PMIC, used for the SPL only.
+	help
+	  I2C address of the AXP PMIC, used for the SPL only.

 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
 	default 3300 if AXP818_POWER || MACH_SUN8I_R40 || AXP803_POWER
 	default 3000 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
-	---help---
-	Set the voltage (mV) to program the axp pmic dcdc1 at, set to 0 to
-	disable dcdc1. On A23 / A31 / A33 (axp221) boards dcdc1 is used for
-	generic 3.3V IO voltage for external devices like the lcd-panal and
-	sdcard interfaces, etc. On most boards dcdc1 is undervolted to 3.0V to
-	save battery. On A31 devices dcdc1 is also used for VCC-IO. On A83T
-	dcdc1 is used for VCC-IO, nand, usb0, sd , etc. On A80 dcdc1 normally
-	powers some of the pingroups, NAND/eMMC, SD/MMC, and USB OTG.
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc1 at, set to 0 to
+	  disable dcdc1. On A23 / A31 / A33 (axp221) boards dcdc1 is used for
+	  generic 3.3V IO voltage for external devices like the lcd-panal and
+	  sdcard interfaces, etc. On most boards dcdc1 is undervolted to 3.0V to
+	  save battery. On A31 devices dcdc1 is also used for VCC-IO. On A83T
+	  dcdc1 is used for VCC-IO, nand, usb0, sd , etc. On A80 dcdc1 normally
+	  powers some of the pingroups, NAND/eMMC, SD/MMC, and USB OTG.

 config AXP_DCDC2_VOLT
 	int "axp pmic dcdc2 voltage"
@@ -194,16 +194,16 @@ config AXP_DCDC2_VOLT
 	default 1200 if MACH_SUN6I
 	default 1100 if MACH_SUN8I
 	default 0 if MACH_SUN9I
-	---help---
-	Set the voltage (mV) to program the axp pmic dcdc2 at, set to 0 to
-	disable dcdc2.
-	On A10(s) / A13 / A20 boards dcdc2 is VDD-CPU and should be 1.4V.
-	On A31 boards dcdc2 is used for VDD-GPU and should be 1.2V.
-	On A23/A33 boards dcdc2 is used for VDD-SYS and should be 1.1V.
-	On A80 boards dcdc2 powers the GPU and can be left off.
-	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 0.9V.
-	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
-	On boards using the AXP313 or AXP717 it's often VDD-CPU.
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc2 at, set to 0 to
+	  disable dcdc2.
+	  On A10(s) / A13 / A20 boards dcdc2 is VDD-CPU and should be 1.4V.
+	  On A31 boards dcdc2 is used for VDD-GPU and should be 1.2V.
+	  On A23/A33 boards dcdc2 is used for VDD-SYS and should be 1.1V.
+	  On A80 boards dcdc2 powers the GPU and can be left off.
+	  On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 0.9V.
+	  On R40 boards dcdc2 is VDD-CPU and should be 1.1V
+	  On boards using the AXP313 or AXP717 it's often VDD-CPU.

 config AXP_DCDC3_VOLT
 	int "axp pmic dcdc3 voltage"
@@ -214,18 +214,18 @@ config AXP_DCDC3_VOLT
 	default 1100 if AXP313_POWER
 	default 1100 if MACH_SUN8I_R40
 	default 1200 if MACH_SUN6I || MACH_SUN8I
-	---help---
-	Set the voltage (mV) to program the axp pmic dcdc3 at, set to 0 to
-	disable dcdc3.
-	On A10(s) / A13 / A20 boards with an axp209 dcdc3 is VDD-INT-DLL and
-	should be 1.25V.
-	On A10s boards with an axp152 dcdc3 is VCC-DRAM and should be 1.5V.
-	On A23 / A31 / A33 boards dcdc3 is VDD-CPU and should be 1.2V.
-	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 0.9V.
-	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 0.9V.
-	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
-	On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
-	be 1.1V for LPDDR4.
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc3 at, set to 0 to
+	  disable dcdc3.
+	  On A10(s) / A13 / A20 boards with an axp209 dcdc3 is VDD-INT-DLL and
+	  should be 1.25V.
+	  On A10s boards with an axp152 dcdc3 is VCC-DRAM and should be 1.5V.
+	  On A23 / A31 / A33 boards dcdc3 is VDD-CPU and should be 1.2V.
+	  On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 0.9V.
+	  On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 0.9V.
+	  On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
+	  On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
+	  be 1.1V for LPDDR4.

 config AXP_DCDC4_VOLT
 	int "axp pmic dcdc4 voltage"
@@ -235,25 +235,25 @@ config AXP_DCDC4_VOLT
 	default 0 if MACH_SUN8I
 	default 900 if MACH_SUN9I
 	default 1500 if AXP305_POWER
-	---help---
-	Set the voltage (mV) to program the axp pmic dcdc4 at, set to 0 to
-	disable dcdc4.
-	On A10s boards with an axp152 dcdc4 is VDD-INT-DLL and should be 1.25V.
-	On A31 boards dcdc4 is used for VDD-SYS and should be 1.2V.
-	On A23 / A33 boards dcdc4 is unused and should be disabled.
-	On A80 boards dcdc4 powers VDD-SYS, HDMI, USB OTG and should be 0.9V.
-	On A83T boards dcdc4 is used for VDD-GPU.
-	On H616 boards dcdcd is used for VCC-DRAM.
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc4 at, set to 0 to
+	  disable dcdc4.
+	  On A10s boards with an axp152 dcdc4 is VDD-INT-DLL and should be 1.25V.
+	  On A31 boards dcdc4 is used for VDD-SYS and should be 1.2V.
+	  On A23 / A33 boards dcdc4 is unused and should be disabled.
+	  On A80 boards dcdc4 powers VDD-SYS, HDMI, USB OTG and should be 0.9V.
+	  On A83T boards dcdc4 is used for VDD-GPU.
+	  On H616 boards dcdcd is used for VCC-DRAM.

 config AXP_DCDC5_VOLT
 	int "axp pmic dcdc5 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
 	default 1500 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
-	---help---
-	Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
-	disable dcdc5.
-	On A23 / A31 / A33 / A80 / A83T / R40 boards dcdc5 is VCC-DRAM and
-	should be 1.5V, 1.35V if DDR3L is used.
+	help
+	  Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
+	  disable dcdc5.
+	  On A23 / A31 / A33 / A80 / A83T / R40 boards dcdc5 is VCC-DRAM and
+	  should be 1.5V, 1.35V if DDR3L is used.

 config AXP_ALDO1_VOLT
 	int "axp pmic (a)ldo1 voltage"
@@ -261,14 +261,14 @@ config AXP_ALDO1_VOLT
 	default 0 if MACH_SUN6I || MACH_SUN8I_R40
 	default 1800 if MACH_SUN8I_A83T
 	default 3000 if MACH_SUN8I || MACH_SUN9I
-	---help---
-	Set the voltage (mV) to program the axp pmic aldo1 at, set to 0 to
-	disable aldo1.
-	On A31 boards aldo1 is often used to power the wifi module.
-	On A23 / A33 boards aldo1 is used for VCC-IO and should be 3.0V.
-	On A80 boards aldo1 powers the USB hosts and should be 3.0V.
-	On A83T / H8 boards aldo1 is used for MIPI CSI, DSI, HDMI, EFUSE, and
-	should be 1.8V.
+	help
+	  Set the voltage (mV) to program the axp pmic aldo1 at, set to 0 to
+	  disable aldo1.
+	  On A31 boards aldo1 is often used to power the wifi module.
+	  On A23 / A33 boards aldo1 is used for VCC-IO and should be 3.0V.
+	  On A80 boards aldo1 powers the USB hosts and should be 3.0V.
+	  On A83T / H8 boards aldo1 is used for MIPI CSI, DSI, HDMI, EFUSE, and
+	  should be 1.8V.

 config AXP_ALDO2_VOLT
 	int "axp pmic (a)ldo2 voltage"
@@ -277,188 +277,188 @@ config AXP_ALDO2_VOLT
 	default 0 if MACH_SUN6I || MACH_SUN9I
 	default 1800 if MACH_SUN8I_A83T
 	default 2500 if MACH_SUN8I
-	---help---
-	Set the voltage (mV) to program the axp pmic aldo2 at, set to 0 to
-	disable aldo2.
-	On A10(s) / A13 / A20 boards aldo2 is AVCC and should be 3.0V.
-	On A31 boards aldo2 is typically unused and should be disabled.
-	On A31 boards aldo2 may be used for LPDDR2 then it should be 1.8V.
-	On A23 / A33 boards aldo2 is used for VDD-DLL and should be 2.5V.
-	On A80 boards aldo2 powers PB pingroup and camera IO and can be left off.
-	On A83T / H8 boards aldo2 powers VDD-DLL, VCC18-PLL, CPVDD, VDD18-ADC,
-	LPDDR2, and the codec. It should be 1.8V.
+	help
+	  Set the voltage (mV) to program the axp pmic aldo2 at, set to 0 to
+	  disable aldo2.
+	  On A10(s) / A13 / A20 boards aldo2 is AVCC and should be 3.0V.
+	  On A31 boards aldo2 is typically unused and should be disabled.
+	  On A31 boards aldo2 may be used for LPDDR2 then it should be 1.8V.
+	  On A23 / A33 boards aldo2 is used for VDD-DLL and should be 2.5V.
+	  On A80 boards aldo2 powers PB pingroup and camera IO and can be left off.
+	  On A83T / H8 boards aldo2 powers VDD-DLL, VCC18-PLL, CPVDD, VDD18-ADC,
+	  LPDDR2, and the codec. It should be 1.8V.

 config AXP_ALDO3_VOLT
 	int "axp pmic (a)ldo3 voltage"
 	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0 if AXP209_POWER || MACH_SUN9I
 	default 3000 if MACH_SUN6I || MACH_SUN8I
-	---help---
-	Set the voltage (mV) to program the axp pmic aldo3 at, set to 0 to
-	disable aldo3.
-	On A10(s) / A13 / A20 boards aldo3 should be 2.8V.
-	On A23 / A31 / A33 / R40 boards aldo3 is VCC-PLL and AVCC and should
-	be 3.0V.
-	On A80 boards aldo3 is normally not used.
-	On A83T / H8 boards aldo3 is AVCC, VCC-PL, and VCC-LED, and should be
-	3.0V.
+	help
+	  Set the voltage (mV) to program the axp pmic aldo3 at, set to 0 to
+	  disable aldo3.
+	  On A10(s) / A13 / A20 boards aldo3 should be 2.8V.
+	  On A23 / A31 / A33 / R40 boards aldo3 is VCC-PLL and AVCC and should
+	  be 3.0V.
+	  On A80 boards aldo3 is normally not used.
+	  On A83T / H8 boards aldo3 is AVCC, VCC-PL, and VCC-LED, and should be
+	  3.0V.

 choice
 	prompt "axp pmic (a)ldo3 voltage rate control"
 	depends on AXP209_POWER
 	default AXP_ALDO3_VOLT_SLOPE_NONE
-	---help---
-	The AXP can slowly ramp up voltage to reduce the inrush current when
-	changing voltages.
-	Note, this does not apply when enabling/disabling LDO3. See
-	"axp pmic (a)ldo3 inrush quirk" below to enable a slew rate to limit
-	inrush current on broken board designs.
+	help
+	  The AXP can slowly ramp up voltage to reduce the inrush current when
+	  changing voltages.
+	  Note, this does not apply when enabling/disabling LDO3. See
+	  "axp pmic (a)ldo3 inrush quirk" below to enable a slew rate to limit
+	  inrush current on broken board designs.

 config AXP_ALDO3_VOLT_SLOPE_NONE
 	bool "No voltage slope"
-	---help---
-	Tries to reach the next voltage setting near instantaneously. Measurements
-	indicate that this is about 0.0167 V/uS.
+	help
+	  Tries to reach the next voltage setting near instantaneously. Measurements
+	  indicate that this is about 0.0167 V/uS.

 config AXP_ALDO3_VOLT_SLOPE_16
 	bool "1.6 mV per uS"
-	---help---
-	Increases the voltage by 1.6 mV per uS until the final voltage has
-	been reached. Note that the scaling is in 25 mV steps and thus
-	the slew rate in reality is about 25 mV/31.250 uS.
+	help
+	  Increases the voltage by 1.6 mV per uS until the final voltage has
+	  been reached. Note that the scaling is in 25 mV steps and thus
+	  the slew rate in reality is about 25 mV/31.250 uS.

 config AXP_ALDO3_VOLT_SLOPE_08
 	bool "0.8 mV per uS"
-	---help---
-	Increases the voltage by 0.8 mV per uS until the final voltage has
-	been reached. Note that the scaling is in 25 mV steps however and thus
-	the slew rate in reality is about 25 mV/15.625 uS.
-	This is the slowest supported rate.
+	help
+	  Increases the voltage by 0.8 mV per uS until the final voltage has
+	  been reached. Note that the scaling is in 25 mV steps however and thus
+	  the slew rate in reality is about 25 mV/15.625 uS.
+	  This is the slowest supported rate.

 endchoice

 config AXP_ALDO3_INRUSH_QUIRK
 	bool "axp pmic (a)ldo3 inrush quirk"
 	depends on AXP209_POWER
-	---help---
-	The reference design denotes a value of 4.7 uF for the output capacitor
-	of LDO3. Some boards have too high capacitance causing 	an inrush current
-	and resulting an AXP209 shutdown.
+	help
+	  The reference design denotes a value of 4.7 uF for the output capacitor
+	  of LDO3. Some boards have too high capacitance causing 	an inrush current
+	  and resulting an AXP209 shutdown.

 config AXP_ALDO4_VOLT
 	int "axp pmic (a)ldo4 voltage"
 	depends on AXP209_POWER
 	default 0 if AXP209_POWER
-	---help---
-	Set the voltage (mV) to program the axp pmic aldo4 at, set to 0 to
-	disable aldo4.
-	On A10(s) / A13 / A20 boards aldo4 should be 2.8V.
+	help
+	  Set the voltage (mV) to program the axp pmic aldo4 at, set to 0 to
+	  disable aldo4.
+	  On A10(s) / A13 / A20 boards aldo4 should be 2.8V.

 config AXP_DLDO1_VOLT
 	int "axp pmic dldo1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic dldo1 at, set to 0 to
-	disable dldo1. On sun6i (A31) boards with ethernet dldo1 is often used
-	to power the ethernet phy. On A23, A33 and A80 boards this is often
-	used to power the wifi.
+	help
+	  Set the voltage (mV) to program the axp pmic dldo1 at, set to 0 to
+	  disable dldo1. On sun6i (A31) boards with ethernet dldo1 is often used
+	  to power the ethernet phy. On A23, A33 and A80 boards this is often
+	  used to power the wifi.

 config AXP_DLDO2_VOLT
 	int "axp pmic dldo2 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 3000 if MACH_SUN9I
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic dldo2 at, set to 0 to
-	disable dldo2.
-	On A80 boards dldo2 normally powers the PL pins and should be 3.0V.
+	help
+	  Set the voltage (mV) to program the axp pmic dldo2 at, set to 0 to
+	  disable dldo2.
+	  On A80 boards dldo2 normally powers the PL pins and should be 3.0V.

 config AXP_DLDO3_VOLT
 	int "axp pmic dldo3 voltage"
 	depends on AXP221_POWER || AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic dldo3 at, set to 0 to
-	disable dldo3.
+	help
+	  Set the voltage (mV) to program the axp pmic dldo3 at, set to 0 to
+	  disable dldo3.

 config AXP_DLDO4_VOLT
 	int "axp pmic dldo4 voltage"
 	depends on AXP221_POWER || AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic dldo4 at, set to 0 to
-	disable dldo4.
+	help
+	  Set the voltage (mV) to program the axp pmic dldo4 at, set to 0 to
+	  disable dldo4.

 config AXP_ELDO1_VOLT
 	int "axp pmic eldo1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic eldo1 at, set to 0 to
-	disable eldo1.
+	help
+	  Set the voltage (mV) to program the axp pmic eldo1 at, set to 0 to
+	  disable eldo1.

 config AXP_ELDO2_VOLT
 	int "axp pmic eldo2 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic eldo2 at, set to 0 to
-	disable eldo2.
+	help
+	  Set the voltage (mV) to program the axp pmic eldo2 at, set to 0 to
+	  disable eldo2.

 config AXP_ELDO3_VOLT
 	int "axp pmic eldo3 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
 	default 3000 if MACH_SUN9I
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic eldo3 at, set to 0 to
-	disable eldo3. On some A31(s) tablets it might be used to supply
-	1.2V for the SSD2828 chip (converter of parallel LCD interface
-	into MIPI DSI).
-	On A80 boards it powers the PM pingroup and should be 3.0V.
+	help
+	  Set the voltage (mV) to program the axp pmic eldo3 at, set to 0 to
+	  disable eldo3. On some A31(s) tablets it might be used to supply
+	  1.2V for the SSD2828 chip (converter of parallel LCD interface
+	  into MIPI DSI).
+	  On A80 boards it powers the PM pingroup and should be 3.0V.

 config AXP_FLDO1_VOLT
 	int "axp pmic fldo1 voltage"
 	depends on AXP818_POWER
 	default 0 if MACH_SUN8I_A83T
-	---help---
-	Set the voltage (mV) to program the axp pmic fldo1 at, set to 0 to
-	disable fldo1.
-	On A83T / H8 boards fldo1 is VCC-HSIC and should be 1.2V if HSIC is
-	used.
+	help
+	  Set the voltage (mV) to program the axp pmic fldo1 at, set to 0 to
+	  disable fldo1.
+	  On A83T / H8 boards fldo1 is VCC-HSIC and should be 1.2V if HSIC is
+	  used.

 config AXP_FLDO2_VOLT
 	int "axp pmic fldo2 voltage"
 	depends on AXP818_POWER
 	default 900 if MACH_SUN8I_A83T
-	---help---
-	Set the voltage (mV) to program the axp pmic fldo2 at, set to 0 to
-	disable fldo2.
-	On A83T / H8 boards fldo2 is VCC-CPUS and should be 0.9V.
+	help
+	  Set the voltage (mV) to program the axp pmic fldo2 at, set to 0 to
+	  disable fldo2.
+	  On A83T / H8 boards fldo2 is VCC-CPUS and should be 0.9V.

 config AXP_FLDO3_VOLT
 	int "axp pmic fldo3 voltage"
 	depends on AXP818_POWER
 	default 0
-	---help---
-	Set the voltage (mV) to program the axp pmic fldo3 at, set to 0 to
-	disable fldo3.
+	help
+	  Set the voltage (mV) to program the axp pmic fldo3 at, set to 0 to
+	  disable fldo3.

 config AXP_SW_ON
 	bool "axp pmic sw on"
 	depends on AXP809_POWER || AXP818_POWER
-	---help---
-	Enable to turn on axp pmic sw.
+	help
+	  Enable to turn on axp pmic sw.

 config SY8106A_VOUT1_VOLT
 	int "SY8106A pmic VOUT1 voltage"
 	depends on SY8106A_POWER
 	default 1200
-	---help---
-	Set the voltage (mV) to program the SY8106A pmic VOUT1. This
-	is typically used to power the VDD-CPU and should be 1200mV.
-	Values can range from 680mV till 1950mV.
+	help
+	  Set the voltage (mV) to program the SY8106A pmic VOUT1. This
+	  is typically used to power the VDD-CPU and should be 1200mV.
+	  Values can range from 680mV till 1950mV.

 config TPS6586X_POWER
 	bool "Enable legacy driver for TI TPS6586x power management chip"
@@ -467,9 +467,9 @@ config TWL4030_POWER
 	depends on OMAP34XX
 	bool "Enable driver for TI TWL4030 power management chip"
 	imply CMD_POWEROFF
-	---help---
-	The TWL4030 in a combination audio CODEC/power management with
-	GPIO and it is commonly used with the OMAP3 family of processors
+	help
+	  The TWL4030 in a combination audio CODEC/power management with
+	  GPIO and it is commonly used with the OMAP3 family of processors

 config POWER_MT6323
 	bool "Poweroff driver for mediatek mt6323"
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 4112b777371d..bb9c52155d2d 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -35,10 +35,10 @@ config BCM6328_POWER_DOMAIN

 config IMX8_POWER_DOMAIN
 	bool "Enable i.MX8 power domain driver"
-        depends on ARCH_IMX8
-        help
-          Enable support for manipulating NXP i.MX8 on-SoC power domains via IPC
-          requests to the SCU.
+	depends on ARCH_IMX8
+	help
+	  Enable support for manipulating NXP i.MX8 on-SoC power domains via IPC
+	  requests to the SCU.

 config IMX8M_POWER_DOMAIN
 	bool "Enable i.MX8M power domain driver"
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 8504ae2b0796..42c67755a6f5 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -1,14 +1,14 @@
 config DM_PMIC
 	bool "Enable Driver Model for PMIC drivers (UCLASS_PMIC)"
 	depends on DM
-	---help---
-	This config enables the driver-model PMIC support.
-	UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
-	For the multi-function PMIC devices, this can be used as parent I/O
-	device for each IC's interface. Then, each children uses its parent
-	for read/write. For detailed description, please refer to the files:
-	- 'drivers/power/pmic/pmic-uclass.c'
-	- 'include/power/pmic.h'
+	help
+	  This config enables the driver-model PMIC support.
+	  UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
+	  For the multi-function PMIC devices, this can be used as parent I/O
+	  device for each IC's interface. Then, each children uses its parent
+	  for read/write. For detailed description, please refer to the files:
+	  - 'drivers/power/pmic/pmic-uclass.c'
+	  - 'include/power/pmic.h'

 if DM_PMIC

@@ -16,34 +16,34 @@ config SPL_DM_PMIC
 	bool "Enable Driver Model for PMIC drivers (UCLASS_PMIC) in SPL"
 	depends on SPL_DM
 	default y
-	---help---
-	This config enables the driver-model PMIC support in SPL.
-	UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
-	For the multi-function PMIC devices, this can be used as parent I/O
-	device for each IC's interface. Then, each children uses its parent
-	for read/write. For detailed description, please refer to the files:
-	- 'drivers/power/pmic/pmic-uclass.c'
-	- 'include/power/pmic.h'
+	help
+	  This config enables the driver-model PMIC support in SPL.
+	  UCLASS_PMIC - designed to provide an I/O interface for PMIC devices.
+	  For the multi-function PMIC devices, this can be used as parent I/O
+	  device for each IC's interface. Then, each children uses its parent
+	  for read/write. For detailed description, please refer to the files:
+	  - 'drivers/power/pmic/pmic-uclass.c'
+	  - 'include/power/pmic.h'

 config PMIC_CHILDREN
 	bool "Allow child devices for PMICs"
 	default y
-	---help---
-	This allows PMICs to support child devices (such as regulators) in
-	SPL. This adds quite a bit of code so if you are not using this
-	feature you can turn it off. Most likely you should turn it on for
-	U-Boot proper.
+	help
+	  This allows PMICs to support child devices (such as regulators) in
+	  SPL. This adds quite a bit of code so if you are not using this
+	  feature you can turn it off. Most likely you should turn it on for
+	  U-Boot proper.

 config SPL_PMIC_CHILDREN
 	bool "Allow child devices for PMICs in SPL"
 	depends on SPL_DM_PMIC
 	default y
-	---help---
-	This allows PMICs to support child devices (such as regulators) in
-	SPL. This adds quite a bit of code so if you are not using this
-	feature you can turn it off. In this case you may need a 'back door'
-	to call your regulator code (e.g. see rk8xx.c for direct functions
-	for use in SPL).
+	help
+	  This allows PMICs to support child devices (such as regulators) in
+	  SPL. This adds quite a bit of code so if you are not using this
+	  feature you can turn it off. In this case you may need a 'back door'
+	  to call your regulator code (e.g. see rk8xx.c for direct functions
+	  for use in SPL).

 config PMIC_AB8500
 	bool "Enable driver for ST-Ericsson AB8500 PMIC via PRCMU"
@@ -57,11 +57,11 @@ config PMIC_AB8500
 config PMIC_ACT8846
 	bool "Enable support for the active-semi 8846 PMIC"
 	depends on DM_I2C
-	---help---
-	This PMIC includes 4 DC/DC step-down buck regulators and 8 low-dropout
-	regulators (LDOs). It also provides some GPIO, reset and battery
-	functions. It uses an I2C interface and is designed for use with
-	tablets and smartphones.
+	help
+	  This PMIC includes 4 DC/DC step-down buck regulators and 8 low-dropout
+	  regulators (LDOs). It also provides some GPIO, reset and battery
+	  functions. It uses an I2C interface and is designed for use with
+	  tablets and smartphones.

 config PMIC_AXP
 	bool "Enable Driver Model for X-Powers AXP PMICs"
@@ -101,8 +101,8 @@ config PMIC_AS3722
 	  required for a tablets or laptop.

 config DM_PMIC_BD71837
- 	bool "Enable Driver Model for PMIC BD71837"
- 	help
+	bool "Enable Driver Model for PMIC BD71837"
+	help
 	  This config enables implementation of driver-model pmic uclass features
 	  for PMIC BD71837. The driver implements read/write operations.

@@ -173,120 +173,120 @@ config SPL_DM_PMIC_PCA9450

 config DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC PFUZE100. The driver implements read/write operations.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PFUZE100. The driver implements read/write operations.

 config SPL_DM_PMIC_PFUZE100
 	bool "Enable Driver Model for PMIC PFUZE100 in SPL"
 	depends on SPL_DM_PMIC
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC PFUZE100 in SPL. The driver implements read/write operations.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC PFUZE100 in SPL. The driver implements read/write operations.

 config DM_PMIC_MAX8907
 	bool "Enable Driver Model for PMIC MAX8907"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC MAX8907. The driver implements read/write operations.
-	This is a Power Management IC with a decent set of peripherals from which
-	3 DC-to-DC Step-Down (SD) Regulators, 20 Low-Dropout Linear (LDO) Regulators,
-	Real-Time Clock (RTC) and more with I2C Compatible Interface.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MAX8907. The driver implements read/write operations.
+	  This is a Power Management IC with a decent set of peripherals from which
+	  3 DC-to-DC Step-Down (SD) Regulators, 20 Low-Dropout Linear (LDO) Regulators,
+	  Real-Time Clock (RTC) and more with I2C Compatible Interface.

 config DM_PMIC_MAX77663
 	bool "Enable Driver Model for PMIC MAX77663"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC MAX77663. The driver implements read/write operations.
-	This is a Power Management IC with a decent set of peripherals from which
-	4 DC-to-DC Step-Down (SD) Regulators, 9 Low-Dropout Linear (LDO) Regulators,
-	8 GPIOs, Real-Time Clock (RTC) and more with I2C Compatible Interface.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MAX77663. The driver implements read/write operations.
+	  This is a Power Management IC with a decent set of peripherals from which
+	  4 DC-to-DC Step-Down (SD) Regulators, 9 Low-Dropout Linear (LDO) Regulators,
+	  8 GPIOs, Real-Time Clock (RTC) and more with I2C Compatible Interface.

 config DM_PMIC_MAX77686
 	bool "Enable Driver Model for PMIC MAX77686"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC MAX77686. The driver implements read/write operations.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MAX77686. The driver implements read/write operations.

 config DM_PMIC_MAX8998
 	bool "Enable Driver Model for PMIC MAX8998"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC MAX8998. The driver implements read/write operations.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MAX8998. The driver implements read/write operations.

 config DM_PMIC_MC34708
 	bool "Enable Driver Model for PMIC MC34708"
 	help
-	 This config enables implementation of driver-model pmic uclass features
-	 for PMIC MC34708. The driver implements read/write operations.
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MC34708. The driver implements read/write operations.

 config PMIC_MAX8997
 	bool "Enable Driver Model for PMIC MAX8997"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for PMIC MAX8997. The driver implements read/write operations.
-	This is a Power Management IC with RTC, Fuel Gauge, MUIC control on Chip.
-	- 21x LDOs
-	- 12x GPIOs
-	- Haptic motor driver
-	- RTC with two alarms
-	- Fuel Gauge and one backup battery charger
-	- MUIC
-	- Others
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for PMIC MAX8997. The driver implements read/write operations.
+	  This is a Power Management IC with RTC, Fuel Gauge, MUIC control on Chip.
+	  - 21x LDOs
+	  - 12x GPIOs
+	  - Haptic motor driver
+	  - RTC with two alarms
+	  - Fuel Gauge and one backup battery charger
+	  - MUIC
+	  - Others

 config PMIC_QCOM
 	bool "Enable Driver Model for Qualcomm generic PMIC"
-	---help---
-	The Qcom PMIC is connected to one (or several) processors
-	with SPMI bus. It has 2 slaves with several peripherals:
-	- 18x LDO
-	- 4x GPIO
-	- Power and Reset buttons
-	- Watchdog
-	- RTC
-	- Vibrator drivers
-	- Others
+	help
+	  The Qcom PMIC is connected to one (or several) processors
+	  with SPMI bus. It has 2 slaves with several peripherals:
+	  - 18x LDO
+	  - 4x GPIO
+	  - Power and Reset buttons
+	  - Watchdog
+	  - RTC
+	  - Vibrator drivers
+	  - Others

 	Driver binding info: doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt

 config PMIC_RK8XX
 	bool "Enable support for Rockchip PMIC RK8XX"
 	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
-	---help---
-	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
-	an RTC and two low Rds (resistance (drain to source)) switches. It is
-	accessed via an I2C interface. The device is used with Rockchip SoCs.
-	This driver implements register read/write operations.
+	help
+	  The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
+	  an RTC and two low Rds (resistance (drain to source)) switches. It is
+	  accessed via an I2C interface. The device is used with Rockchip SoCs.
+	  This driver implements register read/write operations.

 config SPL_PMIC_RK8XX
 	bool "Enable support for Rockchip PMIC RK8XX in SPL"
 	depends on SPL_DM_PMIC
-	---help---
-	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
-	an RTC and two low Rds (resistance (drain to source)) switches. It is
-	accessed via an I2C interface. The device is used with Rockchip SoCs.
-	This driver implements register read/write operations.
+	help
+	  The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
+	  an RTC and two low Rds (resistance (drain to source)) switches. It is
+	  accessed via an I2C interface. The device is used with Rockchip SoCs.
+	  This driver implements register read/write operations.

 config PMIC_S2MPS11
 	bool "Enable Driver Model for PMIC Samsung S2MPS11"
-	---help---
-	The Samsung S2MPS11 PMIC provides:
-	 - 38 adjustable LDO regulators
-	 - 9 High-Efficiency Buck Converters
-	 - 1 BuckBoost Converter
-	 - RTC with two alarms
-	 - Backup battery charger
-	 - I2C Configuration Interface
-	This driver provides access to I/O interface only.
-	Binding info: doc/device-tree-bindings/pmic/s2mps11.txt
+	help
+	  The Samsung S2MPS11 PMIC provides:
+	  - 38 adjustable LDO regulators
+	  - 9 High-Efficiency Buck Converters
+	  - 1 BuckBoost Converter
+	  - RTC with two alarms
+	  - Backup battery charger
+	  - I2C Configuration Interface
+	  This driver provides access to I/O interface only.
+	  Binding info: doc/device-tree-bindings/pmic/s2mps11.txt

 config DM_PMIC_SANDBOX
 	bool "Enable Driver Model for emulated Sandbox PMIC"
-	---help---
-	Enable the driver for Sandbox PMIC emulation. The emulated PMIC device
-	depends on two drivers:
-	- sandbox PMIC I/O driver - implements dm pmic operations
-	- sandbox PMIC i2c emul driver - emulates the PMIC's I2C transmission
+	help
+	  Enable the driver for Sandbox PMIC emulation. The emulated PMIC device
+	  depends on two drivers:
+	  - sandbox PMIC I/O driver - implements dm pmic operations
+	  - sandbox PMIC i2c emul driver - emulates the PMIC's I2C transmission

 	A detailed information can be found in header: '<power/sandbox_pmic.h>'

@@ -307,123 +307,123 @@ config DM_PMIC_SANDBOX
 config DM_PMIC_CPCAP
 	bool "Enable Driver Model for Motorola CPCAP"
 	help
-	The CPCAP is a Motorola/ST-Ericsson creation, a multifunctional IC
-	whose main purpose is power control. It was used in a wide variety of
-	Motorola products, both Tegra and OMAP based. The most notable devices
-	using this PMIC are the Motorola Droid 4, Atrix 4G, and Droid X2.
-	Unlike most PMICs, this one is not I2C based; it uses the SPI bus. The
-	core driver provides both read and write access to the device registers.
+	  The CPCAP is a Motorola/ST-Ericsson creation, a multifunctional IC
+	  whose main purpose is power control. It was used in a wide variety of
+	  Motorola products, both Tegra and OMAP based. The most notable devices
+	  using this PMIC are the Motorola Droid 4, Atrix 4G, and Droid X2.
+	  Unlike most PMICs, this one is not I2C based; it uses the SPI bus. The
+	  core driver provides both read and write access to the device registers.

 config PMIC_S5M8767
 	bool "Enable Driver Model for the Samsung S5M8767 PMIC"
-	---help---
-	The S5M8767 PMIC provides a large array of LDOs and BUCKs for use
-	as a SoC power controller. It also provides 32KHz clock outputs. This
-	driver provides basic register access and sets up the attached
-	regulators if regulator support is enabled.
+	help
+	  The S5M8767 PMIC provides a large array of LDOs and BUCKs for use
+	  as a SoC power controller. It also provides 32KHz clock outputs. This
+	  driver provides basic register access and sets up the attached
+	  regulators if regulator support is enabled.

 config PMIC_RN5T567
 	bool "Enable driver for Ricoh RN5T567 PMIC"
-	---help---
-	The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
-	regulators Real-Time Clock and 4 GPIOs. This driver provides
-	register access only.
+	help
+	  The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
+	  regulators Real-Time Clock and 4 GPIOs. This driver provides
+	  register access only.

 config SPL_PMIC_RN5T567
 	bool "Enable driver for Ricoh RN5T567 PMIC in SPL"
 	depends on SPL_DM_PMIC
-	---help---
-	The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
-	regulators Real-Time Clock and 4 GPIOs. This driver provides
-	register access only.
+	help
+	  The RN5T567 is a PMIC with 4 step-down DC/DC converters, 5 LDO
+	  regulators Real-Time Clock and 4 GPIOs. This driver provides
+	  register access only.

 config PMIC_TPS65090
 	bool "Enable driver for Texas Instruments TPS65090 PMIC"
-	---help---
-	The TPS65090 is a PMIC containing several LDOs, DC to DC convertors,
-	FETs and a battery charger. This driver provides register access
-	only, and you can enable the regulator/charger drivers separately if
-	required.
+	help
+	  The TPS65090 is a PMIC containing several LDOs, DC to DC convertors,
+	  FETs and a battery charger. This driver provides register access
+	  only, and you can enable the regulator/charger drivers separately if
+	  required.

 config PMIC_PALMAS
 	bool "Enable driver for Texas Instruments PALMAS PMIC"
-	---help---
-	The PALMAS is a PMIC containing several LDOs, SMPS.
-	This driver binds the pmic children.
+	help
+	  The PALMAS is a PMIC containing several LDOs, SMPS.
+	  This driver binds the pmic children.

 config PMIC_LP873X
 	bool "Enable driver for Texas Instruments LP873X PMIC"
-	---help---
-	The LP873X is a PMIC containing couple of LDOs and couple of SMPS.
-	This driver binds the pmic children.
+	help
+	  The LP873X is a PMIC containing couple of LDOs and couple of SMPS.
+	  This driver binds the pmic children.

 config PMIC_LP87565
 	bool "Enable driver for Texas Instruments LP87565 PMIC"
-	---help---
-	The LP87565 is a PMIC containing a bunch of SMPS.
-	This driver binds the pmic children.
+	help
+	  The LP87565 is a PMIC containing a bunch of SMPS.
+	  This driver binds the pmic children.

 config DM_PMIC_TPS65910
 	bool "Enable driver for Texas Instruments TPS65910 PMIC"
-	---help---
-	The TPS65910 is a PMIC containing 3 buck DC-DC converters, one boost
-	DC-DC converter, 8 LDOs and a RTC. This driver binds the SMPS and LDO
-	pmic children.
+	help
+	  The TPS65910 is a PMIC containing 3 buck DC-DC converters, one boost
+	  DC-DC converter, 8 LDOs and a RTC. This driver binds the SMPS and LDO
+	  pmic children.

 config DM_PMIC_TPS80031
 	bool "Enable driver for Texas Instruments TPS80031/TPS80032 PMIC"
-	---help---
-	This config enables implementation of driver-model pmic uclass features
-	for TPS80031/TPS80032 PMICs. The driver implements read/write operations.
-	This is a Power Management IC with a decent set of peripherals from which
-	5 Buck Converters referred as Switched-mode power supply (SMPS), 11 General-
-	Purpose Low-Dropout Voltage Regulators (LDO), USB OTG Module, Real-Time
-	Clock (RTC) with Timer and Alarm Wake-Up, Two Digital PWM Outputs and more
-	with I2C Compatible Interface. PMIC occupies 4 I2C addresses.
+	help
+	  This config enables implementation of driver-model pmic uclass features
+	  for TPS80031/TPS80032 PMICs. The driver implements read/write operations.
+	  This is a Power Management IC with a decent set of peripherals from which
+	  5 Buck Converters referred as Switched-mode power supply (SMPS), 11 General-
+	  Purpose Low-Dropout Voltage Regulators (LDO), USB OTG Module, Real-Time
+	  Clock (RTC) with Timer and Alarm Wake-Up, Two Digital PWM Outputs and more
+	  with I2C Compatible Interface. PMIC occupies 4 I2C addresses.

 config PMIC_STPMIC1
 	bool "Enable support for STMicroelectronics STPMIC1 PMIC"
 	depends on DM_I2C
 	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF && !ARM_PSCI_FW
-	---help---
-	The STPMIC1 PMIC provides 4 BUCKs, 6 LDOs, 1 VREF and 2 power switches.
-	It is accessed via an I2C interface. The device is used with STM32MP1
-	SoCs. This driver implements register read/write operations.
+	help
+	  The STPMIC1 PMIC provides 4 BUCKs, 6 LDOs, 1 VREF and 2 power switches.
+	  It is accessed via an I2C interface. The device is used with STM32MP1
+	  SoCs. This driver implements register read/write operations.

 config SPL_PMIC_PALMAS
 	bool "Enable driver for Texas Instruments PALMAS PMIC"
 	depends on SPL_DM_PMIC
 	help
-	The PALMAS is a PMIC containing several LDOs, SMPS.
-	This driver binds the pmic children in SPL.
+	  The PALMAS is a PMIC containing several LDOs, SMPS.
+	  This driver binds the pmic children in SPL.

 config SPL_PMIC_LP873X
 	bool "Enable driver for Texas Instruments LP873X PMIC"
 	depends on SPL_DM_PMIC
 	help
-	The LP873X is a PMIC containing couple of LDOs and couple of SMPS.
-	This driver binds the pmic children in SPL.
+	  The LP873X is a PMIC containing couple of LDOs and couple of SMPS.
+	  This driver binds the pmic children in SPL.

 config SPL_PMIC_LP87565
 	bool "Enable driver for Texas Instruments LP87565 PMIC"
 	depends on SPL_DM_PMIC
 	help
-	The LP87565 is a PMIC containing a bunch of SMPS.
-	This driver binds the pmic children in SPL.
+	  The LP87565 is a PMIC containing a bunch of SMPS.
+	  This driver binds the pmic children in SPL.

 config PMIC_TPS65941
 	bool "Enable driver for Texas Instruments TPS65941 PMIC"
 	depends on DM_PMIC
 	help
-	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
-	This driver binds the pmic children.
+	  The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
+	  This driver binds the pmic children.

 config PMIC_TPS65219
 	bool "Enable driver for Texas Instruments TPS65219 PMIC"
 	depends on DM_PMIC
 	help
-	The TPS65219 is a PMIC containing a bunch of SMPS & LDOs.
-	This driver binds the pmic children.
+	  The TPS65219 is a PMIC containing a bunch of SMPS & LDOs.
+	  This driver binds the pmic children.

 config PMIC_RAA215300
 	bool "Renesas RAA215300 PMIC driver"
@@ -445,11 +445,11 @@ endif

 config PMIC_TPS65217
 	bool "Enable driver for Texas Instruments TPS65217 PMIC"
-	---help---
-	The TPS65217 is a PMIC containing several LDOs, DC to DC convertors,
-	FETs and a battery charger. This driver provides register access
-	only, and you can enable the regulator/charger drivers separately if
-	required.
+	help
+	  The TPS65217 is a PMIC containing several LDOs, DC to DC convertors,
+	  FETs and a battery charger. This driver provides register access
+	  only, and you can enable the regulator/charger drivers separately if
+	  required.

 config POWER_TPS65218
 	bool "Enable legacy driver for TPS65218 PMIC"
@@ -485,9 +485,9 @@ config POWER_PFUZE3000

 config POWER_MC34VR500
 	bool "Enable driver for Freescale MC34VR500 PMIC"
-	---help---
-	The MC34VR500 is used in conjunction with the FSL T1 and LS1 series
-	SoC. It provides 4 buck DC-DC convertors and 5 LDOs, and it is accessed
-	via an I2C interface.
+	help
+	  The MC34VR500 is used in conjunction with the FSL T1 and LS1 series
+	  SoC. It provides 4 buck DC-DC convertors and 5 LDOs, and it is accessed
+	  via an I2C interface.

 endif
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index ca5de5b87269..13a650f2f6d5 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -1,38 +1,38 @@
 config DM_REGULATOR
 	bool "Enable Driver Model for REGULATOR drivers (UCLASS_REGULATOR)"
 	depends on DM
-	---help---
-	This config enables the driver model regulator support.
-	UCLASS_REGULATOR - designed to provide a common API for basic regulator's
-	functions, like get/set Voltage or Current value, enable state, etc...
-	Note:
-	When enabling this, please read the description, found in the files:
-	- 'include/power/pmic.h'
-	- 'include/power/regulator.h'
-	- 'drivers/power/pmic/pmic-uclass.c'
-	- 'drivers/power/pmic/regulator-uclass.c'
-	It's important to call the device_bind() with the proper node offset,
-	when binding the regulator devices. The pmic_bind_childs() can be used
-	for this purpose if PMIC I/O driver is implemented or dm_scan_fdt_dev()
-	otherwise. Detailed information can be found in the header file.
+	help
+	  This config enables the driver model regulator support.
+	  UCLASS_REGULATOR - designed to provide a common API for basic regulator's
+	  functions, like get/set Voltage or Current value, enable state, etc...
+	  Note:
+	  When enabling this, please read the description, found in the files:
+	  - 'include/power/pmic.h'
+	  - 'include/power/regulator.h'
+	  - 'drivers/power/pmic/pmic-uclass.c'
+	  - 'drivers/power/pmic/regulator-uclass.c'
+	  It's important to call the device_bind() with the proper node offset,
+	  when binding the regulator devices. The pmic_bind_childs() can be used
+	  for this purpose if PMIC I/O driver is implemented or dm_scan_fdt_dev()
+	  otherwise. Detailed information can be found in the header file.

 config SPL_DM_REGULATOR
 	bool "Enable regulators for SPL"
 	depends on DM_REGULATOR && SPL_POWER
-	---help---
-	Regulators are seldom needed in SPL. Even if they are accessed, some
-	code space can be saved by accessing the PMIC registers directly.
-	Enable this option if you need regulators in SPL and can cope with
-	the extra code size.
+	help
+	  Regulators are seldom needed in SPL. Even if they are accessed, some
+	  code space can be saved by accessing the PMIC registers directly.
+	  Enable this option if you need regulators in SPL and can cope with
+	  the extra code size.

 config REGULATOR_ACT8846
 	bool "Enable driver for ACT8846 regulator"
 	depends on DM_REGULATOR && PMIC_ACT8846
-	---help---
-	Enable support for the regulator functions of the ACT8846 PMIC. The
-	driver implements get/set api for the various BUCKS and LDOS supported
-	by the PMIC device. This driver is controlled by a device tree node
-	which includes voltage limits.
+	help
+	  Enable support for the regulator functions of the ACT8846 PMIC. The
+	  driver implements get/set api for the various BUCKS and LDOS supported
+	  by the PMIC device. This driver is controlled by a device tree node
+	  which includes voltage limits.

 config REGULATOR_AS3722
 	bool "Enable driver for AS7322 regulator"
@@ -75,33 +75,33 @@ config DM_REGULATOR_BD71837
 	bool "Enable Driver Model for ROHM BD71837/BD71847 regulators"
 	depends on DM_REGULATOR && DM_PMIC_BD71837
 	help
-	This config enables implementation of driver-model regulator uclass
-	features for regulators on ROHM BD71837 and BD71847 PMICs.
-	BD71837 contains 8 bucks and 7 LDOS. BD71847 is reduced version
-	containing 6 bucks and 6 LDOs. The driver implements get/set api for
-	value and enable.
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on ROHM BD71837 and BD71847 PMICs.
+	  BD71837 contains 8 bucks and 7 LDOS. BD71847 is reduced version
+	  containing 6 bucks and 6 LDOs. The driver implements get/set api for
+	  value and enable.

 config SPL_DM_REGULATOR_BD71837
 	bool "Enable Driver Model for ROHM BD71837/BD71847 regulators in SPL"
 	depends on DM_REGULATOR_BD71837 && SPL
 	help
-	This config enables implementation of driver-model regulator uclass
-	features for regulators on ROHM BD71837 and BD71847 in SPL.
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on ROHM BD71837 and BD71847 in SPL.

 config DM_REGULATOR_PCA9450
 	bool "Enable Driver Model for NXP PCA9450 regulators"
 	depends on DM_REGULATOR && DM_PMIC_PCA9450
 	help
-	This config enables implementation of driver-model regulator uclass
-	features for regulators on NXP PCA9450 PMICs. PCA9450 contains 6 bucks
-	and 5 LDOS. The driver implements get/set api for value and enable.
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on NXP PCA9450 PMICs. PCA9450 contains 6 bucks
+	  and 5 LDOS. The driver implements get/set api for value and enable.

 config SPL_DM_REGULATOR_PCA9450
 	bool "Enable Driver Model for NXP PCA9450 regulators in SPL"
 	depends on DM_REGULATOR_PCA9450 && SPL
 	help
-	This config enables implementation of driver-model regulator uclass
-	features for regulators on ROHM PCA9450 in SPL.
+	  This config enables implementation of driver-model regulator uclass
+	  features for regulators on ROHM PCA9450 in SPL.

 config DM_REGULATOR_DA9063
 	bool "Enable Driver Model for REGULATOR DA9063"
@@ -127,55 +127,55 @@ config DM_REGULATOR_PFUZE100
 	bool "Enable Driver Model for REGULATOR PFUZE100"
 	depends on DM_REGULATOR && DM_PMIC_PFUZE100
 	default DM_PMIC_PFUZE100
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for REGULATOR PFUZE100. The driver implements get/set api for:
-	value, enable and mode.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for REGULATOR PFUZE100. The driver implements get/set api for:
+	  value, enable and mode.

 config SPL_DM_REGULATOR_PFUZE100
 	bool "Enable Driver Model for REGULATOR PFUZE100 in SPL"
 	depends on SPL_DM_REGULATOR && SPL_DM_PMIC_PFUZE100
 	default SPL_DM_PMIC_PFUZE100
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for REGULATOR PFUZE100. The driver implements get/set api for:
-	value, enable and mode.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for REGULATOR PFUZE100. The driver implements get/set api for:
+	  value, enable and mode.

 config REGULATOR_PWM
 	bool "Enable driver for PWM regulators"
 	depends on DM_REGULATOR && DM_PWM
-	---help---
-	Enable support for the PWM regulator functions which voltage are
-	controlled by PWM duty ratio. Some of Rockchip board using this kind
-	of regulator. The driver implements get/set api for the various BUCKS.
-	This driver is controlled by a device tree node
-	which includes voltage limits.
+	help
+	  Enable support for the PWM regulator functions which voltage are
+	  controlled by PWM duty ratio. Some of Rockchip board using this kind
+	  of regulator. The driver implements get/set api for the various BUCKS.
+	  This driver is controlled by a device tree node
+	  which includes voltage limits.

 config DM_REGULATOR_MAX8907
 	bool "Enable Driver Model for REGULATOR MAX8907"
 	depends on DM_REGULATOR && DM_PMIC_MAX8907
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for REGULATOR MAX8907. The driver supports both DC-to-DC
-	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
-	found in MAX8907 PMIC and implements get/set api for value and enable.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for REGULATOR MAX8907. The driver supports both DC-to-DC
+	  Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
+	  found in MAX8907 PMIC and implements get/set api for value and enable.

 config DM_REGULATOR_MAX77663
 	bool "Enable Driver Model for REGULATOR MAX77663"
 	depends on DM_REGULATOR && DM_PMIC_MAX77663
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for REGULATOR MAX77663. The driver supports both DC-to-DC
-	Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
-	found in MAX77663 PMIC and implements get/set api for value and enable.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for REGULATOR MAX77663. The driver supports both DC-to-DC
+	  Step-Down (SD) Regulators and Low-Dropout Linear (LDO) Regulators
+	  found in MAX77663 PMIC and implements get/set api for value and enable.

 config DM_REGULATOR_MAX77686
 	bool "Enable Driver Model for REGULATOR MAX77686"
 	depends on DM_REGULATOR && DM_PMIC_MAX77686
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for REGULATOR MAX77686. The driver implements get/set api for:
-	value, enable and mode.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for REGULATOR MAX77686. The driver implements get/set api for:
+	  value, enable and mode.

 config DM_REGULATOR_NPCM8XX
 	bool "Enable Driver Model for NPCM8xx voltage supply"
@@ -221,33 +221,33 @@ config DM_REGULATOR_FIXED
 	bool "Enable Driver Model for REGULATOR Fixed value"
 	depends on DM_REGULATOR
 	select DM_REGULATOR_COMMON
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for fixed value regulators. The driver implements get/set api
-	for enable and get only for voltage value.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for fixed value regulators. The driver implements get/set api
+	  for enable and get only for voltage value.

 config SPL_DM_REGULATOR_FIXED
 	bool "Enable Driver Model for REGULATOR Fixed value in SPL"
 	depends on DM_REGULATOR_FIXED && SPL
 	select SPL_DM_REGULATOR_COMMON
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for fixed value regulators in SPL.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for fixed value regulators in SPL.

 config DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR"
 	depends on DM_REGULATOR && DM_GPIO
 	select DM_REGULATOR_COMMON
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for gpio regulators. The driver implements get/set for
-	voltage value.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for gpio regulators. The driver implements get/set for
+	  voltage value.

 config DM_REGULATOR_QCOM_RPMH
 	bool "Enable driver model for Qualcomm RPMh regulator"
 	depends on DM_REGULATOR && QCOM_RPMH
 	select DEVRES
-	---help---
+	help
 	  Enable support for the Qualcomm RPMh regulator. The driver
 	  implements get/set api for a limited set of regulators used
 	  by u-boot.
@@ -255,7 +255,7 @@ config DM_REGULATOR_QCOM_RPMH
 config DM_REGULATOR_QCOM_USB_VBUS
 	bool "Enable driver model for Qualcomm USB vbus regulator"
 	depends on DM_REGULATOR && DM_PMIC
-	---help---
+	help
 	  Enable support for the Qualcomm USB Vbus regulator. The driver
 	  implements get/set api for the regulator to be used by u-boot.

@@ -263,18 +263,18 @@ config SPL_DM_REGULATOR_GPIO
 	bool "Enable Driver Model for GPIO REGULATOR in SPL"
 	depends on DM_REGULATOR_GPIO && SPL_DM_GPIO
 	select SPL_DM_REGULATOR_COMMON
-	---help---
-	This config enables implementation of driver-model regulator uclass
-	features for gpio regulators in SPL.
+	help
+	  This config enables implementation of driver-model regulator uclass
+	  features for gpio regulators in SPL.

 config REGULATOR_RK8XX
 	bool "Enable driver for RK8XX regulators"
 	depends on DM_REGULATOR && PMIC_RK8XX
-	---help---
-	Enable support for the regulator functions of the RK8XX PMIC. The
-	driver implements get/set api for the various BUCKS and LDOs supported
-	by the PMIC device. This driver is controlled by a device tree node
-	which includes voltage limits.
+	help
+	  Enable support for the regulator functions of the RK8XX PMIC. The
+	  driver implements get/set api for the various BUCKS and LDOs supported
+	  by the PMIC device. This driver is controlled by a device tree node
+	  which includes voltage limits.

 config SPL_REGULATOR_RK8XX
 	bool "Enable driver for RK8XX regulators in SPL"
@@ -288,29 +288,29 @@ config SPL_REGULATOR_RK8XX
 config DM_REGULATOR_S2MPS11
 	bool "Enable driver for S2MPS11 regulator"
 	depends on DM_REGULATOR && PMIC_S2MPS11
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR S2MPS11.
-	The driver implements get/set api for: value and enable.
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR S2MPS11.
+	  The driver implements get/set api for: value and enable.

 config REGULATOR_S5M8767
 	bool "Enable support for S5M8767 regulator"
 	depends on DM_REGULATOR && PMIC_S5M8767
-	---help---
-	This enables the regulator features of the S5M8767, allowing voltages
-	to be set, etc. The driver is not fully complete but supports most
-	common requirements, including all LDOs and BUCKs. This allows many
-	supplies to be set automatically using the device tree values.
+	help
+	  This enables the regulator features of the S5M8767, allowing voltages
+	  to be set, etc. The driver is not fully complete but supports most
+	  common requirements, including all LDOs and BUCKs. This allows many
+	  supplies to be set automatically using the device tree values.

 config DM_REGULATOR_SANDBOX
 	bool "Enable Driver Model for Sandbox PMIC regulator"
 	depends on DM_REGULATOR && DM_PMIC_SANDBOX
-	---help---
-	Enable the regulator driver for emulated Sandbox PMIC.
-	The emulated PMIC device depends on two drivers:
-	- sandbox PMIC I/O driver - implements dm pmic operations
-	- sandbox PMIC regulator driver - implements dm regulator operations
-	- sandbox PMIC i2c emul driver - emulates the PMIC's I2C transmission
+	help
+	  Enable the regulator driver for emulated Sandbox PMIC.
+	  The emulated PMIC device depends on two drivers:
+	  - sandbox PMIC I/O driver - implements dm pmic operations
+	  - sandbox PMIC regulator driver - implements dm regulator operations
+	  - sandbox PMIC i2c emul driver - emulates the PMIC's I2C transmission

 	The regulator driver provides uclass operations for sandbox PMIC's
 	regulators. The driver implements get/set api for: voltage, current,
@@ -335,115 +335,115 @@ config DM_REGULATOR_SANDBOX
 config REGULATOR_TPS65090
 	bool "Enable driver for TPS65090 PMIC regulators"
 	depends on PMIC_TPS65090
-	---help---
-	The TPS65090 provides several FETs (Field-effect Transistors,
-	effectively switches) which are supported by this driver as
-	regulators, one for each FET. The standard regulator interface is
-	supported, but it is only possible to turn the regulators on or off.
-	There is no voltage/current control.
+	help
+	  The TPS65090 provides several FETs (Field-effect Transistors,
+	  effectively switches) which are supported by this driver as
+	  regulators, one for each FET. The standard regulator interface is
+	  supported, but it is only possible to turn the regulators on or off.
+	  There is no voltage/current control.

 config DM_REGULATOR_PALMAS
 	bool "Enable driver for PALMAS PMIC regulators"
-       depends on PMIC_PALMAS
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR PALMAS and the family of PALMAS PMICs.
-	The driver implements get/set api for: value and enable.
+	depends on PMIC_PALMAS
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR PALMAS and the family of PALMAS PMICs.
+	  The driver implements get/set api for: value and enable.

 config DM_REGULATOR_PBIAS
 	bool "Enable driver for PBIAS regulator"
 	depends on DM_REGULATOR
 	select REGMAP
 	select SYSCON
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for pseudo-regulator PBIAS found in the OMAP SOCs.
-	This pseudo-regulator is used to provide a BIAS voltage to MMC1
-	signal pads and must be configured properly during a voltage switch.
-	Voltage switching is required by some operating modes of SDcards and
-	eMMC.
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for pseudo-regulator PBIAS found in the OMAP SOCs.
+	  This pseudo-regulator is used to provide a BIAS voltage to MMC1
+	  signal pads and must be configured properly during a voltage switch.
+	  Voltage switching is required by some operating modes of SDcards and
+	  eMMC.

 config DM_REGULATOR_LP873X
 	bool "Enable driver for LP873X PMIC regulators"
-        depends on PMIC_LP873X
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR LP873X and the family of LP873X PMICs.
-	The driver implements get/set api for: value and enable.
+	depends on PMIC_LP873X
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR LP873X and the family of LP873X PMICs.
+	  The driver implements get/set api for: value and enable.

 config DM_REGULATOR_LP87565
 	bool "Enable driver for LP87565 PMIC regulators"
-        depends on PMIC_LP87565
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR LP87565 and the family of LP87565 PMICs.
-	LP87565 series of PMICs have 4 single phase BUCKs that can also
-	be configured in multi phase modes. The driver implements
-	get/set api for value and enable.
+	depends on PMIC_LP87565
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR LP87565 and the family of LP87565 PMICs.
+	  LP87565 series of PMICs have 4 single phase BUCKs that can also
+	  be configured in multi phase modes. The driver implements
+	  get/set api for value and enable.

 config DM_REGULATOR_STM32_VREFBUF
 	bool "Enable driver for STMicroelectronics STM32 VREFBUF"
 	depends on DM_REGULATOR && (STM32H7 || ARCH_STM32MP)
 	help
-	This driver supports STMicroelectronics STM32 VREFBUF (voltage
-	reference buffer) which can be used as voltage reference for
-	internal ADCs, DACs and also for external components through
-	dedicated Vref+ pin.
+	  This driver supports STMicroelectronics STM32 VREFBUF (voltage
+	  reference buffer) which can be used as voltage reference for
+	  internal ADCs, DACs and also for external components through
+	  dedicated Vref+ pin.

 config DM_REGULATOR_TPS65910
 	bool "Enable driver for TPS65910 PMIC regulators"
 	depends on DM_PMIC_TPS65910
-	---help---
-	The TPS65910 PMIC provides 4 SMPSs and 8 LDOs. This driver supports all
-	regulator types of the TPS65910 (BUCK, BOOST and LDO). It implements
-	the get/set api for value and enable.
+	help
+	  The TPS65910 PMIC provides 4 SMPSs and 8 LDOs. This driver supports all
+	  regulator types of the TPS65910 (BUCK, BOOST and LDO). It implements
+	  the get/set api for value and enable.

 config DM_REGULATOR_TPS65911
 	bool "Enable driver for TPS65911 PMIC regulators"
 	depends on DM_PMIC_TPS65910
-	---help---
-	This config enables implementation of driver-model regulator
-	uclass features for the TPS65911 PMIC. The driver supports Step-Down
-	DC-DC Converters for Processor Cores (VDD1 and VDD2), Step-Down DC-DC
-	Converter for I/O Power (VIO), Controller for External FETs (VDDCtrl)
-	and LDO Voltage Regulators found in TPS65911 PMIC and implements
-	get/set api for value and enable.
+	help
+	  This config enables implementation of driver-model regulator
+	  uclass features for the TPS65911 PMIC. The driver supports Step-Down
+	  DC-DC Converters for Processor Cores (VDD1 and VDD2), Step-Down DC-DC
+	  Converter for I/O Power (VIO), Controller for External FETs (VDDCtrl)
+	  and LDO Voltage Regulators found in TPS65911 PMIC and implements
+	  get/set api for value and enable.

 config DM_REGULATOR_TPS62360
 	bool "Enable driver for TPS6236x Power Regulator"
 	depends on DM_REGULATOR
 	help
-	The TPS6236X DC/DC step down converter provides a single output
-	power line peaking at 3A current. This driver supports all four
-	variants of the chip (TPS62360, TPS62361, TPS62362, TPS62363). It
-	implements the get/set api for value only, as the power line is
-	always on.
+	  The TPS6236X DC/DC step down converter provides a single output
+	  power line peaking at 3A current. This driver supports all four
+	  variants of the chip (TPS62360, TPS62361, TPS62362, TPS62363). It
+	  implements the get/set api for value only, as the power line is
+	  always on.

 config DM_REGULATOR_TPS80031
 	bool "Enable driver for TPS80031/TPS80032 PMIC regulators"
 	depends on DM_PMIC_TPS80031
-	---help---
-	This enables implementation of driver-model regulator uclass
-	features for TPS80031/TPS80032 PMICs. The driver implements
-	get/set api for: value and enable.
+	help
+	  This enables implementation of driver-model regulator uclass
+	  features for TPS80031/TPS80032 PMICs. The driver implements
+	  get/set api for: value and enable.

 config DM_REGULATOR_TPS6287X
 	bool "Enable driver for TPS6287x Power Regulator"
 	depends on DM_REGULATOR
 	help
-	The TPS6287X is a step down converter with a fast transient
-	response. This driver supports all four variants of the chip
-	(TPS62870, TPS62871, TPS62872, TPS62873). It implements the
-	get/set api for value only, as the power line is always on.
+	  The TPS6287X is a step down converter with a fast transient
+	  response. This driver supports all four variants of the chip
+	  (TPS62870, TPS62871, TPS62872, TPS62873). It implements the
+	  get/set api for value only, as the power line is always on.

 config DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators"
 	depends on DM_REGULATOR && PMIC_STPMIC1
-	---help---
-	Enable support for the regulator functions of the STPMIC1 PMIC. The
-	driver implements get/set api for the various BUCKS and LDOs supported
-	by the PMIC device. This driver is controlled by a device tree node
-	which includes voltage limits.
+	help
+	  Enable support for the regulator functions of the STPMIC1 PMIC. The
+	  driver implements get/set api for the various BUCKS and LDOs supported
+	  by the PMIC device. This driver is controlled by a device tree node
+	  which includes voltage limits.

 config DM_REGULATOR_ANATOP
 	bool "Enable driver for ANATOP regulators"
@@ -451,18 +451,18 @@ config DM_REGULATOR_ANATOP
 	select REGMAP
 	select SYSCON
 	help
-	Enable support for the Freescale i.MX on-chip ANATOP LDO
-	regulators. It is recommended that this option be enabled on
-	i.MX6 platform.
+	  Enable support for the Freescale i.MX on-chip ANATOP LDO
+	  regulators. It is recommended that this option be enabled on
+	  i.MX6 platform.

 config SPL_DM_REGULATOR_TPS6287X
 	bool "Enable driver for TPS6287x Power Regulator"
 	depends on SPL_DM_REGULATOR
 	help
-	The TPS6287X is a step down converter with a fast transient
-	response. This driver supports all four variants of the chip
-	(TPS62870, TPS62871, TPS62872, TPS62873). It implements the
-	get/set api for value only, as the power line is always on.
+	  The TPS6287X is a step down converter with a fast transient
+	  response. This driver supports all four variants of the chip
+	  (TPS62870, TPS62871, TPS62872, TPS62873). It implements the
+	  get/set api for value only, as the power line is always on.

 config SPL_DM_REGULATOR_STPMIC1
 	bool "Enable driver for STPMIC1 regulators in SPL"
@@ -474,54 +474,54 @@ config SPL_DM_REGULATOR_PALMAS
 	bool "Enable driver for PALMAS PMIC regulators"
 	depends on SPL_PMIC_PALMAS
 	help
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR PALMAS and the family of PALMAS PMICs.
-	The driver implements get/set api for: value and enable in SPL.
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR PALMAS and the family of PALMAS PMICs.
+	  The driver implements get/set api for: value and enable in SPL.

 config SPL_DM_REGULATOR_LP87565
 	bool "Enable driver for LP87565 PMIC regulators"
 	depends on SPL_PMIC_LP87565
 	help
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR LP87565 and the family of LP87565 PMICs.
-	LP87565 series of PMICs have 4 single phase BUCKs that can also
-	be configured in multi phase modes. The driver implements
-	get/set api for value and enable in SPL.
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR LP87565 and the family of LP87565 PMICs.
+	  LP87565 series of PMICs have 4 single phase BUCKs that can also
+	  be configured in multi phase modes. The driver implements
+	  get/set api for value and enable in SPL.

 config SPL_DM_REGULATOR_LP873X
 	bool "Enable driver for LP873X PMIC regulators"
 	depends on SPL_PMIC_LP873X
 	help
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR LP873X and the family of LP873X PMICs.
-	The driver implements get/set api for: value and enable in SPL.
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR LP873X and the family of LP873X PMICs.
+	  The driver implements get/set api for: value and enable in SPL.

 config DM_REGULATOR_TPS65941
 	bool "Enable driver for TPS65941 PMIC regulators"
-        depends on PMIC_TPS65941
+	depends on PMIC_TPS65941
 	help
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR TPS65941 and the family of TPS65941 PMICs.
-	TPS65941 series of PMICs have 5 single phase BUCKs that can also
-	be configured in multi phase modes & 4 LDOs. The driver implements
-	get/set api for value and enable.
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR TPS65941 and the family of TPS65941 PMICs.
+	  TPS65941 series of PMICs have 5 single phase BUCKs that can also
+	  be configured in multi phase modes & 4 LDOs. The driver implements
+	  get/set api for value and enable.

 config DM_REGULATOR_SCMI
 	bool "Enable driver for SCMI voltage domain regulators"
 	depends on DM_REGULATOR
 	select SCMI_AGENT
-        help
-          Enable this option if you want to support regulators exposed through
+	help
+	  Enable this option if you want to support regulators exposed through
 	  the SCMI voltage domain protocol by a SCMI server.

 config DM_REGULATOR_TPS65219
 	bool "Enable driver for TPS65219 PMIC regulators"
-        depends on PMIC_TPS65219
+	depends on PMIC_TPS65219
 	help
-	This enables implementation of driver-model regulator uclass
-	features for REGULATOR TPS65219 and the family of TPS65219 PMICs.
-	TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs.
-	The driver implements get/set api for value and enable.
+	  This enables implementation of driver-model regulator uclass
+	  features for REGULATOR TPS65219 and the family of TPS65219 PMICs.
+	  TPS65219 series of PMICs have 3 single phase BUCKs & 4 LDOs.
+	  The driver implements get/set api for value and enable.

 config REGULATOR_RZG2L_USBPHY
 	bool "Enable driver for RZ/G2L USB PHY VBUS supply"
@@ -534,11 +534,11 @@ config REGULATOR_RZG2L_USBPHY
 config DM_REGULATOR_CPCAP
 	bool "Enable driver for CPCAP PMIC regulators"
 	depends on DM_REGULATOR && DM_PMIC_CPCAP
-	---help---
-	Enable implementation of driver-model regulator uclass features for
-	REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
-	(SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
-	PMIC and implements get/set api for voltage and state.
+	help
+	  Enable implementation of driver-model regulator uclass features for
+	  REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
+	  (SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
+	  PMIC and implements get/set api for voltage and state.

 config DM_REGULATOR_MT6357
 	bool "Enable driver for MediaTek MT6357 PMIC regulators"
--
2.39.5

