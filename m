Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92D2C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 13:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A320A60E7E;
	Fri, 18 Sep 2026 13:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LggpnNyld4Ga; Fri, 18 Sep 2026 13:28:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EED4B60E65
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738115;
	b=PgExyWldVIj8N+9SmADpNI6IbMvYenmxVxuyvGRlmuVMdIQr28hua2mD34RTFIbHUiyu
	 FvN+phMLpJsSozYvbNSjXP3muWFX8R4FQuUMr/8UKokICaJtW5c873+a3QjtDRPuLircQ
	 4fJlnSXRJzLnY4HnXK+ybkL2L9G2Wnx9RIBLy/8J5Sei0R4Uh92HthhIqlGSzLJ9Jr62N
	 QsKlsPmFFw+jpXmFGnwRT/rvhFQswzF+pSA/6IjlEntJI3F3CgxeYdvNhNvYWrQ49zVvU
	 t2YAl/jOKZhnCXyaKTxZOp3hUJWoe9bgUgLgiDzDGBDmrtt7BJZfKt4tKoq/E0Mxs7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XNZ3mFnKH/ztZ7ARTf05OgpfLCbMFK5P589uC+n/FcI=;
	b=DTVaj3IQjlHSt4G9MHieTkDZkl5gev4TKON1XdPb6PbZu9SM22Pqy++iKcW7MrKwp+0Q
	 SfOvNtvvioIXfZ45wAaU2b024i8/X0JVi3DBU9xy3qUh0HHZT3Un4VlM4HfjRmsmddcWq
	 Kiu1GHINXQIYuYyTd3SMiwFczB0H6McL8msM/11rYOGdTb8Vb5MtTW/q1+zBtBHsurXix
	 FAyO6JQPA/n8tQUymfjCaqYAnCL2KEVkeJYSmYI2mb5Lnzxt9b9tx1Be0xbLeDKl5WJDy
	 RMEGqwyI0bqGAgKTr/IJo8dwJRgnZULAZEszThuJfZf9t4OBR0wx2dj/iUHFM30Va5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789738115;
	bh=XNZ3mFnKH/ztZ7ARTf05OgpfLCbMFK5P589uC+n/FcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D1SmjExL7bgVvB5IMgAbaoMdg952mL8tCdiTlTj0BmNhRMFHSgVani1MfRwaDQ2S8
	 NWs6aPO9G12zlzvnRTmhNpofzdWzkIf0d0UzEi7x0uLfeueykdZFOXymmP5jxDH61T
	 WZ+EsPW1Bpq5vg7lFo7Ua5MHHI22J3vWw/Du3rj/f7Feb0belmPD/Ne12mHursbjgD
	 V+aaYy5UIysFvbiw0LWQ0ydunRWJks4llLOESVwS26RrdZ6lJ32Fxlu28tLz7Mz6VI
	 sN8tVeBEryJTDF1Uy7PPmh82rZU4VsaXI/S76rBKrG3VDg6SX1txSCu4J70c08ycv4
	 N79RGChunC4Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EED4B60E65;
	Fri, 18 Sep 2026 13:28:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DF723B6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03EF040049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAWwyH5lul8I for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:00:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 481C240048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789732819;
 b=kJOeH21Rk8GUhSZAbdeLpWEB31yURn1tyM8PEA4fdkICjh+ELTGUesuCwxF4HX2Jwquy
 3+e7RJBLlJpCG9/IWW25dJa5kIRXO4jpJPjcnpYnmXgkx3XYPh7+m5Zf+d/pV7KIlYxsJ
 K1YXv+Mg43qHZuKUZLFzk6XN1fnF2vTicTabCOYiEeEFvy391BaSRc2uNgm6Fwe4R+rKd
 PSdmG56yc/QfLfeKL6VJC4cEeXgheyObITwxBuVNkbOP8DJge3jr2XGqd+iu/7MgbsxB2
 Yt2J3uM4fZuLflhMmk92CbdbkBa18lBQE4ZqTJkmVx3QSf9u66HVM5PkhJoeuqwJ2mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789732819;
 h=Received-SPF:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
 bh=XNZ3mFnKH/ztZ7ARTf05OgpfLCbMFK5P589uC+n/FcI=;
 b=tWrv+GfkNl3JRcwXOvWhFZUHRtVANJBcbHND+0ioYU8hwHLH8BKakFsQE3M5MeS0dPJ8
 Ui0IJhK1T4bktYyP1LqZEZyWwub+xPNfv0UQ8ipUAeVX4gGfd92UuLweB9a32doWY+yvS
 Cuk1FW2cSJZejLMqPBlOOxGpVNelNUvALPVGVoyUIFiJ+kUSFTWh9Yh2tkhZeJSeECNjU
 QJFiFM6OSY6KQRT1oNQ+0Fc6m/OgKWTN6ET0PdTNIR5TpAVx/JJGqvtZ8GcJiBJMjoT8Z
 WTPSv8ykSJICTaebZiGZCA7Gnq1PZEXRZtM5YKKJ6iQgwKGYm6Y0Z84Oa3IFBSNjCRw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=jmu.edu.cn; 
 arc=none smtp.remote-ip=45.254.49.197
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.197;
 helo=mail-m49197.qiye.163.com; envelope-from=amadeus@jmu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 481C240048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:00:10 +0000 (UTC)
Received: from Vostro-3710.. (unknown [14.220.232.127])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4e4b3dc02;
 Fri, 18 Sep 2026 20:00:07 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Chukun Pan <amadeus@jmu.edu.cn>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/2] board: rockchip: add HINLINK H28K
Date: Fri, 18 Sep 2026 20:00:01 +0800
Message-Id: <20260918120001.2256317-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
References: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b463642503a2kunm0bbbbba53cca06
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE4dVhkdTkgYHklDQ0tLQlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVUpJTFlXWRYaDxIVHRRZQVlPS0hVSktJT0
 9PS1VKS0tVS1kG
X-Mailman-Approved-At: Fri, 18 Sep 2026 13:28:29 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The HINLINK H28K is a single board computer based on the
RK3528 SoC. Add support for the HINLINK H28K board.

Features tested on HINLINK H28K:
- SD-card boot
- eMMC boot
- Ethernet

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v2:
  Remove USB OTG / DWC3 / GADGET Kconfig options
  Remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS
---
 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi | 11 ++++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 +++
 configs/hinlink-h28k-rk3528_defconfig        | 55 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 4 files changed, 73 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
 create mode 100644 configs/hinlink-h28k-rk3528_defconfig

diff --git a/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi b/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
new file mode 100644
index 000000000000..3e2fbd81da17
--- /dev/null
+++ b/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index 111fe0270dfd..95543b40dd3e 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3528-generic*
 F:	configs/generic-rk3528_defconfig
 
+HINLINK-H28K-RK3528
+M:	Chukun Pan <amadeus@jmu.edu.cn>
+S:	Maintained
+F:	arch/arm/dts/rk3528-hinlink-h28k*
+F:	configs/hinlink-h28k-rk3528_defconfig
+
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/hinlink-h28k-rk3528_defconfig b/configs/hinlink-h28k-rk3528_defconfig
new file mode 100644
index 000000000000..46d4c367f8cd
--- /dev/null
+++ b/configs/hinlink-h28k-rk3528_defconfig
@@ -0,0 +1,55 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-hinlink-h28k"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-hinlink-h28k.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_RNG_SEED=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..2c0232d36a0b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -105,6 +105,7 @@ List of mainline supported Rockchip boards:
      - ArmSoM Sige1 (sige1-rk3528)
      - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
      - Generic RK3528 (generic-rk3528)
+     - HINLINK H28K (hinlink-h28k-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)
      - Radxa ROCK 2A/2F (rock-2-rk3528)
 
-- 
2.34.1

