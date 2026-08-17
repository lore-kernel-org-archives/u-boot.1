Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2FC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C92D2607B3;
	Mon, 17 Aug 2026 15:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YnbtqXtff3PV; Mon, 17 Aug 2026 15:35:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22A446078D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980919;
	bh=5a/JRFCKRHzdWkC5YmREdnbjztaGNhzZrMB385atVWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ua0D0fSjTANYFSdJ0fsqZF78oCBZGc/uHKMhcPYeD/1cJ++40Qzw3BJ4MNxMnneVL
	 8GU/LCwbsOKsMb6wElcX12llH286gqHHr58A6RFN9vwoNJ1U30AoUxuf5DYLkCTcOT
	 wED2+jnt7wFS0vVlOuRi83mxqA0zrhgffR6X5IfbHtnQMY4J5NiogQaF6Dgydzx3n+
	 gBr3BGn8+HALyERQZiURj4ZwCzQqehc8raNSaix024NLTyuEmUbPAaL/V5LgEfYTks
	 ebAL4ij1+l6PoYa2cOMEDs4v+d86Q4v45sSkFe/uE29V+msoyuyWZfZKI4ezU2f3BJ
	 fJ5bI5xOf8yBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A446078D;
	Mon, 17 Aug 2026 15:35:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61A65282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 479166078D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGryrrp2hMtE for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:35:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1380660721
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1380660721
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=U4DCKdWw
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1380660721
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 682C3B0053D;
 Mon, 17 Aug 2026 17:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980915;
 bh=ixcz8cqz1WV0kd6Y6usinT+4rTpkaSzQo0P6u3NhVDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U4DCKdWw0e3N1NIsa6iqR5DM7vezdYjlBcLRQadTbURKKhpTpuXNUSKRpQ7YrNfH3
 ZJti1qMGeQv/Sz02CIZu1R0TVRFCScD5DFGROSEqmPDeVLwFAayOsWSizJisNAEzwK
 +p7QWJDyUVe2ASYnVwdWyvBYlsC8RID/UNamBs+ng7WvZAmwWHtxgnMuUebcqZ2Aat
 V3bDgycPDi6OnEGsfB8/v7j5LopycPwsByCmxEGI3maAjlIfM2keQm/+pK5I+PnZRW
 YPOdshcBCdVTymKkf6j5iZCplkZ/t9h+/9cy1UivxiSleOkjeCRn9sDhcpIUN/Yrn3
 +rPtDaAc0ZoDw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 11/23] board: nbxv3: enable FlexSPI boot NOR (GD55LB02GF)
 and FIT boot
Date: Mon, 17 Aug 2026 17:31:29 +0200
Message-ID: <20260817153144.1951036-12-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the SPI controllers used on the module and attach the boot NOR:

 - &fspi (FlexSPI) supports the 256 MiB GigaDevice GD55LB02GF boot NOR
 - &dspi0 (lx2160a DSPI1, on module management SPI, already carrying the
   ZL30733 DPLL) and &dspi2 (DSPI3, it is the carrier general purpose SPI)
   are enabled.

SPI bus alias map, so the boot NOR is always `sf probe 3:0`:
 spi0 = &dspi0,
 spi2 = &dspi2,
 spi3 = &fspi.

defconfig: add the needed dependencies for loading FIT images.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 23 +++++++++++++++++++++++
 configs/nbxv3_tfa_defconfig        |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 9b79d2c3253..fad6e3c292a 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -16,6 +16,9 @@
 
 	aliases {
 		serial0 = &uart0;
+		spi0 = &dspi0;
+		spi2 = &dspi2;
+		spi3 = &fspi;
 	};
 };
 
@@ -79,9 +82,29 @@
 };
 
 &dspi0 { /* DSPI1: on module management SPI */
+	status = "okay";
+
 	dpll@0 {
 		compatible = "microchip,zl30733";
 		reg = <0>;
 		spi-max-frequency = <12500000>;
 	};
 };
+
+&fspi {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "gigadevice,gd55lb02gf", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <150000000>;
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&dspi2 {
+	status = "okay";
+};
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 6d55a808a76..9cdf11b9975 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -10,6 +10,7 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-lx2160a-nbxv3"
+CONFIG_FSPI_AHB_EN_4BYTE=y
 CONFIG_SYS_MONITOR_LEN=958464
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
@@ -19,6 +20,7 @@ CONFIG_REMAKE_ELF=y
 CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_PBSIZE=532
@@ -26,6 +28,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
+CONFIG_CMD_SPI=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
 CONFIG_DYNAMIC_DDR_CLK_FREQ=y
@@ -33,10 +36,15 @@ CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
 CONFIG_SYS_FSL_DDR_INTLV_256B=y
 CONFIG_DM_I2C=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
+CONFIG_NXP_FSPI=y
 CONFIG_WDT=y
 CONFIG_WDT_SBSA=y
+CONFIG_ZSTD=y
-- 
2.43.0

