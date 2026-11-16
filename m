Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE54606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aprx3D0k;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/X5sgkE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAEB380C97;
	Mon, 16 Nov 2026 00:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DVDMgloZlN38; Mon, 16 Nov 2026 00:20:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9BAEE80D7A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794788406;
	b=Ymam1cpisjP6FN6q8VlKaX2LoVXoe/pbGgVxzVaTARxrPAxjQBfnRSrNTW8rek4s/lvi
	 7EsqcL0fgrO2swo4g/N4BesC+tqnDvNkkRjM4eJ68pww+Pk+5OYa19OP7aCMZQIvpMJfh
	 u5E3ItoMvh+ymRbgZF1unVva8GfF6euiWECH2qcfD9OQAGTwIPzdkB7hoYJQSEV/YarXM
	 /BBaPF68iOqhqjhmTTumpefhabwyCcAk0t0XMtl9hb3dqPzPLDyB0hxjUiwsfdJwlHEVj
	 CjHB4Z0Mq49pY1s8GGr892XlpiXgF9bsQN8joTv1o131xeATumwPn1BRhwPgSAN/JBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794788406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7AVEQn5tneP1FtFsrA49XS9jKMULNOyatTIe0e4M//M=;
	b=cpy4M4qt8I5nghZjdTkZaWporLk8NLOZ8c1UHU+GrlhyieU70G1P/JFPfAkpX6gxJpXx
	 5Q4fy5t7KbR7bOVPdHOVAdDYY9fuBLdfwL+OLm+IcRoYgwrU6/Vhs6m1yu5ZhwyznzyoP
	 oGI7UWY9rBq05XiEuQ3z4e99TQxAltbzMuN7lVaCbS4skchpmoSIJjp2fWGANWpEy06cO
	 gH6CJ7WOYhktpM9lJNUz8+woP0S1j9gcceNp0vyOpwDF6GvN6bv32coVXtWdFvNR2NJ+Q
	 0j7bKwW004owhG+fo/BHFLYM3k4SqTeIqSndIL078LNPjBSVQEfw0zbJeRkQjhFjLZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794788406;
	bh=7AVEQn5tneP1FtFsrA49XS9jKMULNOyatTIe0e4M//M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=aprx3D0kt1dYlDGFsPm3lTlxHtU7vSNUx/EM86mwoIYbSzTxulnDUMjLKk5zTc0Nh
	 A3Pnddo873oisSexE0ATlHkddgSs9/f8MBMCSWCOKu3VOMoiXSDBEEbTl8VnH8gQjC
	 0i+3F5ZiGophzYM1r9nApNEjGikgehCcgt4X6Ix8FUpjtlE46o3RIfrbbi7ocnGXXX
	 xN2gDfBJIdNW13fMWPX1VmpJUnQOIuVU1ZPuRoOXcugW83SjZr+GYyCsndTXOU80Sr
	 67AOPb825Jm7z5xOBKSJgOoI71+SRhyfGdi2+btgVbJt5tNM4sNpeUXU8r6CD01gyD
	 Gvy134kuVwVdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BAEE80D7A;
	Mon, 16 Nov 2026 00:20:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B25EAD7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 00:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 982C3405DE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 00:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3621lXSTi-EH for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 00:20:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35BA6405B8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V/X5sgkE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35BA6405B8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 00:20:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 829AF62599;
 Mon, 16 Nov 2026 00:20:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CC1461F000C6;
 Mon, 16 Nov 2026 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794788401;
 bh=7AVEQn5tneP1FtFsrA49XS9jKMULNOyatTIe0e4M//M=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=V/X5sgkEwnnYlZARxsvnoUh+ivLi7IKkIZHPuVKNlw0rCohqWEBgecOrEZx6NUPhy
 0hm6unNoKRg4L9aa9WU1RmkRQqBd8QiXKCLwKtysi85OWnvJRnXxr1bJM4qzsrE7Ta
 sHJJzr78VWUT2iC5gaVwX28NlT4DtnH9KSCAeqXLQDBC0GYFB8ocbVQClhsiHVfI0z
 0tiOBegxANsPwinrzIfKuw1bAh/L95zN5voPe0RI2POGEMhnzjnjMF5vYaqClnSyu7
 utVegAYVgH232DFFDwIH1cxexEOkuv7crfBbe6ar0JK0B8yKUp+7a7dLSh9+V+Ot0d
 bJTRBYDzsBhaQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2D6584A277;
 Mon, 16 Nov 2026 00:19:59 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 00:19:57 +0000
Subject: [PATCH v2] board: rockchip: Add Kobol Helios64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-b4-helios64-v2-1-3631141e429e@iav.lv>
X-B4-Tracking: v=1; b=H4sIACxM+moC/23MQQrCMBCF4auUWTuSCSGprryHdBHNxAyUVhIJS
 sndjV27/B+8b4PCWbjAedggc5Ui69JDHwa4J788GCX0Bq20JaUJbwYTz7IWa9BRVHQKPAYXoD+
 emaO8d+069U5SXmv+7Hil3/rfqYSEzvjIo/c2OH0RX49zham19gWN5CXRowAAAA==
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8534; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=FG8iV04kG5xqqb4pjZAAv2G2Zl4yqRflIsHr3IP1tNs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/fPRyFk5aPX3lbo+C2p6fe+ceWhzeH7uv8P0c8elLj
 cRy1ooLdZSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJZF9h+KfQN3HTB03ug//q
 mZtE4jc1qb1k22W0+m15O+9Vh25Zm6UM/4OSZNR4Xz74o5wZ8+Wwga7VUafLM2qULnmw/V3ONif
 KiAkA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Add support for the Kobol Helios64, an RK3399 NAS board with 4 GiB of
LPDDR4, eMMC, SD card, SPI NOR flash, a 1 GbE RTL8211F PHY, a 2.5 GbE
RTL8156 on USB and a JMB585 SATA controller on PCIe.

The board uses the upstream device tree. The -u-boot.dtsi adds the
LPDDR4 timings for the open-source TPL and the vdd_log PWM regulator
and the vdd_center RK808 buck, and sets both rails to 950 mV. RockPro64
sets vdd_center the same way, see commit f210cbc1f3d4 ("arm: dts:
rk3399-rockpro64: slightly increase center voltage").

The upstream device tree gains both rails in Linux 7.5. Until
dts/upstream catches up, the -u-boot.dtsi describes them; after that
only the 950 mV settings remain here.

Without the vdd_log and vdd_center nodes, Linux 7.3 reset or hung about
2.3 s into the boot in 2 of 2 cold boots. With both rails at 950 mV,
20 cold boots of Linux 7.3 showed no memory errors.

Linux can leave the SD card at 1.8 V across a watchdog reset or a panic,
and the RK808 LDO that supplies the card I/O (vcc_sdio_s0) keeps that
voltage. Enable the IO-domain driver in SPL, so that SPL sets the SDMMC
IO domain from the voltage of that regulator and can read the card.

U-Boot proper sits at 0xE0000 in SPI flash, the RK3399 default, rather
than at 0x80000 as in Kobol's vendor U-Boot. Kobol's instructions start
from microSD, and Armbian, the image Kobol recommended, always wrote the
whole loader to SPI at once. In normal use nobody flashes the U-Boot
stages to SPI separately, so old TPL/SPL never meet a new proper and
nothing depends on 0x80000. Whoever updates the stages one by one by
hand does it on purpose and knows where each goes. There is no reason
for a board-specific offset.

Features tested on a Helios64:
- eMMC boot (TF-A v2.13.0 BL31, open-source TPL), also after watchdog
  resets and power cycles
- SD card boot, also after a watchdog reset or a panic left the card
  at 1.8 V
- SPI flash boot
- GMAC Ethernet (DHCP, TFTP)
- USB 3 host

Not working yet: PCIe, and the RTL8156, which U-Boot has no driver for.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
vdd_log and vdd_center are applied for Linux 7.5:
https://lore.kernel.org/r/20261021-helios64-vdd-log-center-v1-1-4cafd110e0e5@iav.lv
I said I would wait for devicetree-rebasing, but the rest of this patch
does not depend on it. Until the sync the nodes stay in -u-boot.dtsi;
after it a follow-up reduces them to the 950 mV settings. Is that fine,
or should this wait for the sync?
---
Changes in v2:
- Add an R: entry to board/rockchip/evb_rk3399/MAINTAINERS.
- Use the default ENV_OFFSET.
- Drop SPL_ATF_NO_PLATFORM_PARAM (upstream TF-A).
- Keep clock-names in the SPL DTB.
- Drop the USB Ethernet adapters and USB EHCI.
- Enable the IO-domain driver in SPL, for the SD card at 1.8 V (SPL I2C,
  PMIC and regulators; bootph on i2c0_xfer, io_domains, vcc_sdio_s0).
- Keep U-Boot proper at the RK3399 default 0xE0000 in SPI, see the
  commit message.
- Test SD card and SPI flash boot, watchdog resets and power cycles.
- Rebase on main.
- Link to v1: https://lore.kernel.org/r/20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv
---
 arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi | 68 ++++++++++++++++++++++
 board/rockchip/evb_rk3399/MAINTAINERS          |  6 ++
 configs/helios64-rk3399_defconfig              | 80 ++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                |  1 +
 4 files changed, 155 insertions(+)

diff --git a/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
new file mode 100644
index 00000000000..89b063af418
--- /dev/null
+++ b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-u-boot.dtsi"
+#include "rk3399-sdram-lpddr4-100.dtsi"
+
+/ {
+	vdd_log: regulator-vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <830000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
+	};
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&rk808 {
+	regulators {
+		vdd_center: DCDC_REG1 {
+			regulator-name = "vdd_center";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <950000>;
+		};
+	};
+};
+
+&gpio0 {
+	bootph-pre-ram;
+};
+
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&io_domains {
+	bootph-pre-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+};
+
+&sdmmc0_pwr_h {
+	bootph-pre-ram;
+};
+
+&spiflash {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&vcc3v0_sd {
+	bootph-pre-ram;
+};
+
+&vcc_sdio_s0 {
+	bootph-pre-ram;
+};
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index 860dd028759..57ed4d43f73 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -20,6 +20,12 @@ S:	Maintained
 F:	configs/generic-rk3399_defconfig
 F:	arch/arm/dts/rk3399-generic*
 
+HELIOS64
+R:	Igor Velkov <iav@iav.lv>
+S:	Maintained
+F:	configs/helios64-rk3399_defconfig
+F:	arch/arm/dts/rk3399-kobol-helios64*
+
 KHADAS-EDGE
 M:	Nick Xie <nick@khadas.com>
 S:	Maintained
diff --git a/configs/helios64-rk3399_defconfig b/configs/helios64-rk3399_defconfig
new file mode 100644
index 00000000000..3c70b566e6b
--- /dev/null
+++ b/configs/helios64-rk3399_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-kobol-helios64"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_TARGET_EVB_RK3399=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-kobol-helios64.dtb"
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
+CONFIG_TPL=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SPL_ROCKCHIP_IODOMAIN=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e22c2d6c575..8b7a52233f5 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -92,6 +92,7 @@ List of mainline supported Rockchip boards:
      - Khadas Edge (khadas-edge-rk3399)
      - Khadas Edge-Captain (khadas-edge-captain-rk3399)
      - Khadas Edge-V (hadas-edge-v-rk3399)
+     - Kobol Helios64 (helios64-rk3399)
      - Orange Pi RK3399 (orangepi-rk3399)
      - Pine64 RockPro64 (rockpro64-rk3399)
      - Radxa ROCK 4C+ (rock-4c-plus-rk3399)

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261021-b4-helios64-71f019de8d7d

Best regards,
-- 
Igor Velkov <iav@iav.lv>


