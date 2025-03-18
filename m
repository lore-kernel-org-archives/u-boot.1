Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21BCC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3E781D67;
	Wed, 19 Mar 2025 04:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="inEjggKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E5D810F4; Tue, 18 Mar 2025 18:42:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5876800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319742; x=1773855742;
 h=from:to:subject:date:message-id:mime-version;
 bh=N9r1ddpyyvMuouLYAwMYsJAt7fKMoRuCNwrW9BIdaGg=;
 b=inEjggKpXfxavXV+FNWChHo6WAfJwyTDIOTMAsGc09LDNexA1Z3m+38J
 On8sy8ZK2BgWsMV45Q4Om9gYJc9XlQlsjNWr7OGy5ULfhcVCdJcpIsSFh
 br/4QVRj2anMV10N1S2lMJVAsPzEZymuk+uAKL7S2QgxMgAxi1idAxzbt
 UEcSHJlBzqVKoHwnJeWV5/iCZRZ23KSUkRtSPzxSN/qIp/HZ89n/JYRNU
 mEXpPTvRXo5tnlaUA6cqUZNwqyxweGD0LDBSWMYen0QuphUmZytHB5voH
 dfn0y+H5FOPAanM6HdjHXd1xAdF2LGN0HUnE9kKZ3W/4d9gpqj7YfWfSR A==;
X-CSE-ConnectionGUID: B00UO1WcQOiRvKyCCf+rmQ==
X-CSE-MsgGUID: XjWk9IGkRBCkx0nQkSAf0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47123952"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="47123952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:42:19 -0700
X-CSE-ConnectionGUID: tGp5XeZ2Tj6zk/V0WSoJhg==
X-CSE-MsgGUID: Zj8NOjiLTFWxq5391InPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122163972"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:42:09 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 5/5] configs: Add coreboot64-no-spl_defconfig for 64-bit X86
 without SPL
Date: Tue, 18 Mar 2025 10:42:06 -0700
Message-ID: <87plietevl.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
 95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
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


Create a new defconfig file called `coreboot64-no-spl_defconfig`,
tailored specifically for 64-bit X86 architecture systems that operate
without the Secondary Program Loader (SPL). This configuration takes its
inspiration from `coreboot64_defconfig`..

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 configs/coreboot64-no-spl_defconfig | 62 +++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 configs/coreboot64-no-spl_defconfig

diff --git a/configs/coreboot64-no-spl_defconfig b/configs/coreboot64-no-spl_defconfig
new file mode 100644
index 00000000000..dd07524560b
--- /dev/null
+++ b/configs/coreboot64-no-spl_defconfig
@@ -0,0 +1,62 @@
+CONFIG_X86=y
+CONFIG_TEXT_BASE=0x1110000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="coreboot"
+CONFIG_PRE_CON_BUF_ADDR=0x100000
+CONFIG_X86_RUN_64BIT_NO_SPL=y
+CONFIG_VENDOR_COREBOOT=y
+CONFIG_TARGET_COREBOOT=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_SYS_MONITOR_BASE=0x01110000
+CONFIG_SHOW_BOOT_PROGRESS=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then bootflow boot; fi"
+CONFIG_PRE_CONSOLE_BUFFER=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_LOGF_LINE=y
+CONFIG_LOGF_FUNC=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CMD_IDE=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SATA=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_SOUND=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_MAC_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="bzImage"
+CONFIG_TFTP_TSIZE=y
+CONFIG_USE_ROOTPATH=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+# CONFIG_ACPIGEN is not set
+CONFIG_SYS_IDE_MAXDEVICE=4
+CONFIG_SYS_ATA_DATA_OFFSET=0
+CONFIG_SYS_ATA_REG_OFFSET=0
+CONFIG_SYS_ATA_ALT_OFFSET=0
+CONFIG_ATAPI=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_NVME_PCI=y
+# CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SOUND=y
+CONFIG_SOUND_I8254=y
+CONFIG_VIDEO_COPY=y
+CONFIG_CONSOLE_TRUETYPE=y
+CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_GZIP is not set
+CONFIG_SMBIOS_PARSER=y
-- 
2.48.1

