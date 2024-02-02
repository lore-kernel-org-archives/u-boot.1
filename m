Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ED2C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1B187D3B;
	Fri,  2 Feb 2024 01:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="u+r3OKkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A5D87D14; Fri,  2 Feb 2024 01:12:04 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FCC87D14
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad07=JL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706832696;
 bh=4lPTqHF2yIPs27gw5slV5re0BsJNFh6BlB9/kRBmDO8=;
 b=u+r3OKkr8IHKHfk6jCZ1i2IlaST4rMiIFbmomdBZAZY/+HvqkYYvnTRzDmkfl2V6aQL27gZ/2
 k9vl6ZlL5b9dK9qcG9iKPXUDgH7TzncCrS0z9mz+0IsWfw1LcISEOaXA1ZWWGAzrTR5wiTJBvLQ
 ORJYBtLm+LfxJnwU2xulCpmV8R7am3YKLxisGJ3SF9NciZ9IfI++mjkDD67Xmu3OPj5uzHd+WDv
 wLuyey50syqVm3uuJN88Xjb97YAWyc1IP6JFbeUuZAOdgylvrEtOXO0yFBhCtt7kAUuFzCfgfaN
 WkUoYcvfuqGxSWxqx2eG8l2wliMfrY/0fXSli/WbsVlw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [RFC] rockchip: spl: Support reading FIT from eMMC boot partition
Date: Fri,  2 Feb 2024 00:11:27 +0000
Message-ID: <20240202001129.530825-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bc3337a8c4c88990720b20
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

Enable support for loading FIT from eMMC boot partition when
SUPPORT_EMMC_BOOT Kconfig option is enabled.

FIT is only loaded from boot partition when the boot partition is set to
boot0 (1) or boo1 (2) in the extcsd partition config. FIT is read from
sector 1024 (512 KiB) of the configured boot partition.

Following can be used to write U-Boot to boot partition 1 of eMMC:

  # Load TPL+SPL from SD-card
  => load mmc 1:1 20000000 idbloader.img

  => mmc dev 0
  # Access eMMC user partition
  => mmc partconf 0 0 0 0
  # Write TPL+SPL to eMMC user partition (512 KiB @ 32 KiB)
  => mmc write 20000000 40 400

  # Load FIT from SD-card
  => load mmc 1:1 20000000 u-boot.itb

  => mmc dev 0
  # Access eMMC boot partition 1
  => mmc partconf 0 0 0 1
  # Write FIT to eMMC boot partition 1 (2 MiB @ 512 KiB)
  => mmc write 20000000 400 1000

  # Configure to use boot partition 1
  => mmc partconf 0 0 1 0
  # Show partition config
  => mmc partconf 0

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
- Is loading FIT from emmc boot partition a feature of intereset to
  anyone else?
- I used a @ 512 KiB offset for FIT, should leave enough space for e.g.
  TPL/SPL, vendor storage or environment before FIT.
- Is @ 512 KiB offset a good default option? Or would e.g. @ 0 or
  @ 32KiB a more apropriate offset?
- This does not add kind of fallback to use the normal @ 8 MiB offset in
  user partition. Is that something that would be needed?
---
 arch/arm/mach-rockchip/spl.c     | 23 +++++++++++++++++++++++
 configs/generic-rk3568_defconfig |  1 +
 configs/generic-rk3588_defconfig |  1 +
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
index c4d3983a6735..2015d9d72dbd 100644
--- a/arch/arm/mach-rockchip/spl.c
+++ b/arch/arm/mach-rockchip/spl.c
@@ -68,9 +68,32 @@ u32 spl_boot_device(void)
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 {
+	if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT) && !IS_SD(mmc)) {
+		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+		case 1:
+		case 2:
+			/* Read FIT from a boot partition */
+			return MMCSD_MODE_EMMCBOOT;
+		}
+	}
+
 	return MMCSD_MODE_RAW;
 }
 
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long raw_sect)
+{
+	if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT) && !IS_SD(mmc)) {
+		switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
+		case 1:
+		case 2:
+			/* Read FIT from sector 1024 (512 KiB) of boot partition */
+			return 0x400;
+		}
+	}
+
+	return raw_sect;
+}
+
 #define TIMER_LOAD_COUNT_L	0x00
 #define TIMER_LOAD_COUNT_H	0x04
 #define TIMER_CONTROL_REG	0x10
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index 18a62b0033a0..b90ecb643dc7 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -51,6 +51,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 # CONFIG_ROCKCHIP_IODOMAIN is not set
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 4755b27c1dea..a9329eb1c625 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -52,6 +52,7 @@ CONFIG_SPL_CLK=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_SPL_MMC_HS200_SUPPORT=y
 CONFIG_MMC_DW=y
-- 
2.43.0

