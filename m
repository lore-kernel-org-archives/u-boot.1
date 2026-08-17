Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDF1C5DF77
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B83214062E;
	Mon, 17 Aug 2026 15:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnZJtKDRXvRN; Mon, 17 Aug 2026 15:36:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D75024064F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981007;
	bh=BJyVVmQPp24eAnLF2y0ZtMJeJ8MtjQIgkQ/BBHkR32c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpIKkLoJAU82+FjPKl/K0P+qym7OYtklDhTzww+UvV72vrSwpyuWx/Giy7AiODeD1
	 2XSBG3Tw83KAGTB+ZBNOZh0w/ZJOBEle1pPXI+x4agbXVYvZrL7DunO/9bZHjIw+RM
	 IvMHbwIZNjuDHzWvxFhVvwF9xydwqhRKkoq6oh0bRGOkWlCgI47/ypeRzjCG9HgsoD
	 1PtonIXWoDsOpqBDElNt2J54j2Mi2ncXXSmAYhS7VxSPotGz/Gva70Srt5qYAAS6+W
	 ejR2Nr7JHfXPkeqOsFaXJe9Z/byo7HkD+Vv1Ke4JI3Mo+z8hf8B40skhqnpP0XSA6V
	 TSKvKBOm6lipg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75024064F;
	Mon, 17 Aug 2026 15:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E04DB282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DF380EBE
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sp3arC-SjetE for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:36:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C3C9880ECF
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3C9880ECF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=jDRcE8++
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3C9880ECF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 380FEB00563;
 Mon, 17 Aug 2026 17:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981003;
 bh=/xnDhuXlB6FWpzCz0iVUUlm9BcJMTSJKnYoO+eeDB60=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jDRcE8++ZyMf4fo2Z2+27ebtNxCi+NtW9UwDBLNZJ/V7u0gdS//PIfbxsb2bgHBfp
 ZQ/+uaxyjklsSiPgesOqC2gMu72kN6l1Tmvb7HmmkG8kyzSnVgVBL+oXw9i44/Z2Oj
 npCizrgMQODRDq7WTyF9nLslv9acl0xrAo/6YoaiC2apqFKdh5pGg781KDT24nxtHy
 ogLNTd1uBgBcRAO6WcuKtExEVy19D+tqyqJW4dx27EPF5hVPfacznaKbd8M4LpGaUp
 qLIL5lKfN1bUt4QijpJJ8ZGrLKqO5lGaei91j8foRab5OdlDiVfMR1Hk6oanubb8UU
 pdeUgQsJ9vIdA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 16/23] board: nbxv3: describe the I2C buses and their on
 module devices
Date: Mon, 17 Aug 2026 17:31:34 +0200
Message-ID: <20260817153144.1951036-17-vjardin@free.fr>
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

Enable the remaining I2C controllers and set the devices on
those bus.

 - &i2c0 (IIC1, on CPU module management)
 - &i2c1 (IIC2, carrier), &i2c2 (IIC3, carrier devices), &i2c3 (IIC4,
   carrier logics).
 - &i2c5 (IIC6, carrier SMBus, SFPs, etc.)

The purpose is to help i2c bus and i2c probe to see the same topology
than the kernel.

defconfig:
 - CONFIG_CMD_I2C and CONFIG_I2C_SET_DEFAULT_BUS_NUM for the
   prompt
 - CONFIG_MISC + CONFIG_I2C_EEPROM + CONFIG_CMD_EEPROM with the
   board ID EEPROM geometry
 - CONFIG_DM_PCA953X for the TCA9539s
 - CONFIG_I2C_MUX and CONFIG_I2C_MUX_PCA954x for the mux tree

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 219 +++++++++++++++++++++++++++++
 configs/nbxv3_tfa_defconfig        |  12 ++
 2 files changed, 231 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 08d3aee62a7..3b87ee32d94 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -66,6 +66,49 @@
 
 &i2c0 { /* IIC1: on module management bus */
 	status = "okay";
+	bootph-all;
+	label = "iic1-onmodule-mgmt";
+
+	eeprom@52 { /* Board ID EEPROM */
+		compatible = "atmel,24c32";
+		reg = <0x52>;
+		pagesize = <32>;
+	};
+
+	gpio@74 {
+		compatible = "ti,tca9539";
+		reg = <0x74>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"boardid-0x0001", "boardid-0x0002",
+			"boardid-0x0004", "boardid-0x0008",
+			"boardid-0x0010", "boardid-0x0020",
+			"boardid-0x0040", "boardid-0x0080",
+			"boardid-0x0100", "boardid-0x0200",
+			"boardid-0x0400", "boardid-0x0800",
+			"boardid-0x1000", "boardid-0x2000",
+			"boardid-0x4000", "boardid-0x8000";
+	};
+
+	u800: gpio@75 {
+		compatible = "ti,tca9539";
+		reg = <0x75>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		gpio-line-names =
+			"fap-rst#",
+			"fap-int#",
+			"fap-pcie-rst#",
+			"dpll-fap-rdy#",
+			"dpll-fap-rst#",
+			"carrier-gpio5",  "carrier-gpio6", "carrier-gpio7",
+			"carrier-gpio8",  "carrier-gpio9",
+			"carrier-gpio10", "carrier-gpio11",
+			"", "", "", "";
+	};
 
 	regulator@10 {
 		compatible = "mps,mpq8785";
@@ -121,3 +164,179 @@
 &pcie4 { status = "okay"; };
 &pcie5 { status = "okay"; };
 &pcie6 { status = "okay"; };
+
+&i2c1 {
+	status = "okay";
+	label = "iic2-carrier-i2c0";
+};
+
+&i2c2 {
+	status = "okay";
+	label = "iic3-fap-mgmt";
+};
+
+&i2c3 {
+	status = "okay";
+	label = "iic4-carrier-mcu";
+};
+
+&i2c5 {
+	status = "okay";
+	label = "iic6-carrier-smbus";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+	};
+
+	pca9548@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			tmp411@4c { compatible = "ti,tmp411"; reg = <0x4c>; };
+			tmp411@4d { compatible = "ti,tmp411"; reg = <0x4d>; };
+		};
+
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pmic@15  {
+				compatible = "pmbus";
+				reg = <0x15>;
+				regulator-name = "psu-48v";
+				pmbus,num-pages = <2>;
+			};
+			eeprom@50 { compatible = "atmel,24c32"; reg = <0x50>; };
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			tmp411@4c { compatible = "ti,tmp411"; reg = <0x4c>; };
+			tmp411@4d { compatible = "ti,tmp411"; reg = <0x4d>; };
+
+			gpio@75 {
+				compatible = "ti,tca9539";
+				reg = <0x75>;
+				#gpio-cells = <2>;
+				gpio-controller;
+			};
+
+			carrier_u186: gpio@76 {
+				compatible = "ti,tca9539";
+				reg = <0x76>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				/* P0_4 = fan-en-pwr -- FAN power rail enable, U186.P0_4 */
+			};
+		};
+
+		i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9548@71 {
+				compatible = "nxp,pca9548";
+				reg = <0x71>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c@0 { reg = <0>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@1 { reg = <1>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@2 { reg = <2>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@3 { reg = <3>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@4 { reg = <4>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@5 { reg = <5>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@6 { reg = <6>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@7 { reg = <7>; #address-cells = <1>; #size-cells = <0>; };
+			};
+		};
+
+		i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9548@71 {
+				compatible = "nxp,pca9548";
+				reg = <0x71>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c@0 { reg = <0>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@1 { reg = <1>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@2 { reg = <2>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@3 { reg = <3>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@4 { reg = <4>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@5 { reg = <5>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@6 { reg = <6>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@7 { reg = <7>; #address-cells = <1>; #size-cells = <0>; };
+			};
+		};
+
+		i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9548@71 {
+				compatible = "nxp,pca9548";
+				reg = <0x71>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-mux-idle-disconnect;
+
+				i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					fan-controller@2c { compatible = "microchip,emc2305"; reg = <0x2c>; };
+					eeprom@50         { compatible = "atmel,24c32";       reg = <0x50>; };
+					tmp411@4c         { compatible = "ti,tmp411";          reg = <0x4c>; };
+					tmp411@4d         { compatible = "ti,tmp411";          reg = <0x4d>; };
+				};
+
+				i2c@1 { reg = <1>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@2 { reg = <2>; #address-cells = <1>; #size-cells = <0>; };
+
+				i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					regulator@1f { compatible = "mps,mpq8785"; reg = <0x1f>; };
+					tmp411@4c    { compatible = "ti,tmp411";   reg = <0x4c>; };
+				};
+
+				i2c@5 { reg = <5>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@6 { reg = <6>; #address-cells = <1>; #size-cells = <0>; };
+				i2c@7 { reg = <7>; #address-cells = <1>; #size-cells = <0>; };
+			};
+		};
+	};
+};
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 7043c5c0df6..7af9124bc6e 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -33,6 +33,11 @@ CONFIG_PCI_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
@@ -45,7 +50,14 @@ CONFIG_DYNAMIC_DDR_CLK_FREQ=y
 CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
 CONFIG_SYS_FSL_DDR_INTLV_256B=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x52
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_ESDHC=y
-- 
2.43.0

