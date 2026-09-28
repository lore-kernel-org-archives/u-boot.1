Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB385CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C6880CB0;
	Mon, 28 Sep 2026 13:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yT9LTid6ZlP4; Mon, 28 Sep 2026 13:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B1AB180CBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602905;
	b=DL9d14pYGORtpcSUh7ibg271z8XMIc53FGzbfbTI0PuGh65pf8RQ6B/RopU4EaszrHwf
	 HTPcWIx46OreKmLJ7t/OtutWsyGOaZ5/gt60mZPjhLO5RzJVo03OomVD3sEHI0CxRtnpu
	 j11ybO78M/azLdfzqgAd9XiYXZOTMac9M3kvJLTPM04/3ybkrt+ontesIflid6Q1pNl71
	 XDjybs7obiRvITMGJ2uPotybxuppr84bKhBik1+Mecz0lcjdeGzHyukZfcEsOgaBGEDlL
	 s+VI7yfA6r55+JOdsZYSiLmS+vZKqVauMO89wwj0YgQeNGesUFCt3Va+dkRyCaDs0mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=z7l+Mhz2qaj/erE822Y6tkYFlpBUrBtbMVN9EGG9dDU=;
	b=mnSAkrbnp+ODuxAIl4OTt2fUztGSNpq12a+h2416stCeBTTJhc/go6XM6Fzynq+7qMgQ
	 ngvmZ5hVIdM8GyKItjXttJCj6uj2OSiuBZGsa++lQHt9zwg3c+UBqxmAKkowwWmlNgSsd
	 CuEAO2wzmj8Z9vCExm/J+wYHm+m9zn/dl0MTthtALlAjPSP2XdLGmTl8ZrbQBiJyoVuW5
	 GE0mFooGJTc+abKeQYQUhQQrwwB+dQm2SThuWUOSXumqoJB8g4G5WMfFanSLf5drAsdfG
	 bsieKq2HO5MxLiYOH2740gyEqym2Jc4wCcEknrlwWpSErKyf8nM3em+PvnkGxPfXXvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602905;
	bh=z7l+Mhz2qaj/erE822Y6tkYFlpBUrBtbMVN9EGG9dDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aZYTOUOMAgJWhf9lajA+qF/sj52gerhY1WKVvOh4ZO7ikJL/9Xti2LcdPngii/zRl
	 acZM7tiL6rNpanlUMhjZCiihVbHdgxXArZfb/fbK34jrlQJ3kZGP0F9xOFcuK4cmtz
	 Dgy2JU5OYpf6Ca4/fbUi8t2cXZ3JDzkmf9PV4RmAp8mQvJNVqTg6y5Bbbgvfke/t3O
	 6Gi/fBIrabcR0dFmxFBUgkYY7d972+C2GG/M8hHkDhAgFaL0uOCNbuBZvzPGniIUlX
	 dXiWhJ5vdwdFvpzFXIBtq0IHRLrVyPrlfOAz7VPMcknvTXQhjce8H/I7HCZRgT8MYk
	 qjS6FrwKFhsDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1AB180CBA;
	Mon, 28 Sep 2026 13:41:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1909335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3348405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABYFV9ChcDo5 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D7C0405AB
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790581142;
 b=JAK4MVDHrMzY1ARHlxo9Ly5rZV8uGsxYUWot56r9dzD9RNvoU33dp2+/oS4PWLPVeuic
 ZHMSM8EJkx1iRQCZtQ9Ftc6WGROdgwmj/iGL3GcWWAtSjiqThKAN+W/ffbvde1ZWjq1dj
 K5Zk63YCkGfY0h6l0rjCDe4mBoNYbwtCU77F+cQP+UZc8ARBd4X1XvDaaHX3EYKzP0ESP
 RjOhLFfP3BKv3UgkOGAiu07Mdpzyw0mctwZZMDEaiKRsM+Pd5YXf51+Kgh/ZNI/APcwLf
 p7jv4stJn+KLdl8cw6fgBzXmeJITwkj8rYWMEcqL1zddqiLJrvLU4CpjUXrOjOLmlYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790581142;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=z7l+Mhz2qaj/erE822Y6tkYFlpBUrBtbMVN9EGG9dDU=;
 b=S3OuDcH6FxLfQi9i9EKNYCzSB6wUdoMbuEnrg/REQuIDs+w2fp/aJR9hIS6ztY7eal5p
 ImzGE0ucE+N6w9Y7lSlRsXB0/H0KZlyEtrzwUFbAXxF3BcIwH9iHNZsVxOb6HoUSZp0s8
 ecrkYxMc9glk1GevVFecJGvuxeL96jTavwMULMCuthA6U/TACD8YffzDkohKFXkZ2ap3y
 EqytNqBzATWrVCt8yZeWSmumi903785JKWyLOmTCjLY3F2bJeoLK3QCYZzApRyOVqollO
 ut/EtwI90i9v6AmC/S+qnkQCxi+PlJew/1DBxzS9a+nNumQshmJD6k6fYkIbfpyF7Tg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IUeloevE; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+dinesh.v.adlinktech.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IUeloevE
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D7C0405AB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EBA0143820;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA6C4C2BCB3;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790581140;
 bh=+xbsaxVTpu3LlfM+c0CamZdpqZ01Ttci4dIr7TVFft0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=IUeloevE7Xv9kTampNya2OYWKWA+2l7OpBsA9WjQHP1h+pj6kl2kq4MpAaMiyHUua
 r92UPK1ak2zOsklcxR+jyztnpjqEQMp0pzBJOrdTWI7TFbE4UTTWNnvK857LOk/6NJ
 VSZGtmppORWDb6habvFv+lAbDrXMfYAK7Dk6vUr1DquSA1TXD0J3eStERk9setoOi2
 G6+whoUy/WYxQHM8U3IvXzkL+1P7ug/TJ6Z+dqZ3CmFlCq1K3diGopYZB9+RwliIrO
 J4npNPRaPjUnpdrY7sEDtkbo5XDI0wbfEXQX63YipzYUwraTf7f43cQy2Cfv1KjbVP
 zZAb62EYhs1rQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B2437C9832F;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
From: Dinesh kumar v via B4 Relay <devnull+dinesh.v.adlinktech.com@kernel.org>
Date: Mon, 28 Sep 2026 13:08:59 +0530
Subject: [PATCH 3/4] configs: Add ADLINK LEC-iMX95 defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lec-imx95-v1-v1-3-9e0c9b94ccbe@adlinktech.com>
References: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
In-Reply-To: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Alice Guo <alice.guo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790581138; l=4398;
 i=dinesh.v@adlinktech.com; s=20260928; h=from:subject:message-id;
 bh=SgDjtjn4IYBxcFmiRPrCaf0rh7y5H7TxtnEED03wWa8=;
 b=MaDlNjPCU9nkz4v/my47UBB4rT0imuXlNG7I7OgraA2+J7XXipAZ+HKbuFnREYnynKoz4IdO8
 3jiAIN3Tpb1BgMRzR7VkFRilV18eTagjeetnINBvspFTm4aWcvZ36jN
X-Developer-Key: i=dinesh.v@adlinktech.com; a=ed25519;
 pk=2+xm2aDQjQT68aPFzfLMgdZrQGpCMUU3Qp1CwWoRlus=
X-Endpoint-Received: by B4 Relay for dinesh.v@adlinktech.com/20260928 with
 auth_id=1074
X-Original-From: Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: dinesh.v@adlinktech.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Dinesh kumar v <dinesh.v@adlinktech.com>

Add the defconfig for the ADLINK LEC-iMX95 board.

Signed-off-by: Dinesh kumar v <dinesh.v@adlinktech.com>
---
 configs/lec-imx95_defconfig | 153 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/configs/lec-imx95_defconfig b/configs/lec-imx95_defconfig
new file mode 100644
index 00000000000..2c329483bc5
--- /dev/null
+++ b/configs/lec-imx95_defconfig
@@ -0,0 +1,153 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="lec_imx95"
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SF_DEFAULT_SPEED=200000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="lec-imx95"
+CONFIG_TARGET_LEC_IMX95=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="lec-imx95-lt9611.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y

-- 
2.25.1


