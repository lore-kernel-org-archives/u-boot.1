Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F93CA601F
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 19:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E02608D4;
	Fri,  9 Oct 2026 19:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6y26BuLVg94; Fri,  9 Oct 2026 19:54:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B537608D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791575652;
	b=hNvIM6h2FaL8IQnU/BakvkrW/3ljy4pbetgRuv3/vsR2IoVBXgKYZI0XWDkiEeZphXNg
	 bHKZz8mch/HVjjH9IxKyX6oYJiXS3ui+DzuaLVwZbKUIANoaXDBOR/g3ndmMcAG7SK1cY
	 p4uNYwRD/7AC+Y4TkzZHJU7lfzR9qe7MENVJmOYKBqwMc8GgrcmON1Xn8VUB1OUi3hHev
	 zoLN7lDUeoyQ6C+4PBSKEeF4g1rs7YKJndk5kps8qJoS3ONgyWolp09sCXcSfr8zgibFc
	 Eu826rk8C8VHUTWEZAhiLY2TeagWwASufOu7O/3hYaAo9r5PZ2DmGQs87/xW917oWEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791575652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mwpnsA9UQHVEPlEVNK+YxvscHK2wotgTAtS4hlcpTyI=;
	b=E/nA1mvJLHQjHitGljOg0lxVJEtBJ4psTpnU+01HPAp4CekD31Wr4FD3ILhDbWxOzC2B
	 44DMzMuOjVBTVQZZjoy+IOSdok8bGyomsx2TyA0xEiN6Aw/XzCcOt4/9W2J2qIuShZfmC
	 BC5GcmVbX1GisUkvxkey1dpgwRCiURYn0j/z9fwSb6E0tH2qYtj56gv8XXijFmxvKTXvk
	 8PoLCdoyWDBov8DQB/wWynAaBoZ1Meq8eLcouCadgJv3KHj3NxcBuZo0WLLMSY6tfzHGc
	 M6EMLy9vW6SGf5pFr8Cc0vGylwla8Ota5Ub7jRgJFvsHRR0rUAjhSSqAakLMoK03sXQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791575652;
	bh=mwpnsA9UQHVEPlEVNK+YxvscHK2wotgTAtS4hlcpTyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pzoqoFKiV+O2ZwN5g/1rRQyHvdxIizEJBwalSUjC915Qs442SZCCd82M3ixUp7DPI
	 mzK55p0KsvCRgMCgbo97RHjoJHImmIBH+2vN2M6qBJNa67yVw7olNW5g68Y7tUQpVE
	 sENI0HQ6jPksZ3GlSKR1xzJB72LeiWCzUZ2wB3dsvkCiRErb8RDa/Rc5R/XSn5JZAo
	 5oFisYij6RPEWH7DefWTCMNc3FJ9HINcM5s2dpva1QmcBYwcUBMyvjnyOgbc2JWcvD
	 Xk6oTjjX6nvN5kaz18mUAb2eegox+GIFakdraisI2Wq0PfEvcgO19GnTnYWtkFsT7c
	 Syetip33oMGNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B537608D0;
	Fri,  9 Oct 2026 19:54:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id EA1E9317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id DC0D240935
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id TlGsIU-Q4pBk for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 19:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39A23408CB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791574806;
 b=YAx7tUU1r8s4Shr78XBM2znpxBzWAWQdzOnPyp26kBG1NbImUvahPBbcTYSMDka/iX+4
 Z62gnR9all7/Ras8Np2JHL1ItBYCdoJSytHsjp4rs4etp9I1O2+Ww6UCfUBK2s5lqCdz7
 ezHReEJT1ntZxNovqgcsCVWK+uc0brL79KYzhswI9VSzVk385KOwFIdELNfjZ7QK2Dv8Q
 GytnDmrcibZ+BypJnIULHdTvYCY4Gm5DgldGI5DlDFssCEAjMJDAHuTAqkYOWqpw6pt+8
 PlWXxwLq94fDrYkob5Kmzs5yakLFFItxE24wUhYuc3yBO2gB3gGXzAByHxktZov7m1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791574806;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mwpnsA9UQHVEPlEVNK+YxvscHK2wotgTAtS4hlcpTyI=;
 b=m8wBhIsrvd28ADgS6ViWJtI4dO9DnmN7lYb8lVYws6XJbpvEc5BVxvhPwSkB8rL562cJ
 9D8wqUfdzc3bHHUQ7JoGQl54RHu9rxSkr54GB9QfgP8IXFqDTnKVnBHJriOqfpYWkxpJ/
 N9PZKVoG2+3KvY/5NNzxLmTXnUe0tG/oR546eRB7mHs3ykST/XvnTqbCoRzqjf/mihW6o
 fb4H+IAp9Z3PqxMWUC9lJ+ARRXqcTbV3hftDocbrfMBsSQLjno5aks956NAK/BIKOSfsY
 hFl/ypQ34X5Q8orc/OPrMTY7YbkKwVi0LUInUBHEuhR5Oaxtgd58HjyGhcPGMT42kJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=imlqmIJo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="gsmdp/0F"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=imlqmIJo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gsmdp/0F
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 39A23408CB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 19:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574627; bh=mwpnsA9UQHVEPlEVNK+Yxvs
 cHK2wotgTAtS4hlcpTyI=; b=imlqmIJoC/84VAHTQZ0eB0nr+aQVoBBphL+bv/O7hh7pg74V/a
 Fdvd/BDx1cSNozEMkfoT8s2Kkya36ia38a2fMnY086VsqAAUsFTGjP80uZK7zeAjiPFVtoznHK4
 z+c1RBKIXSeDtSS3uQvgHs5Xc1cVLxxcYo1bZa6ZHO7w+naOP9ai34QzW7AXNyaXBb6x6WNNF4k
 oDCVyI9eR7+VQYu+buJfz86w1HxzsCFRxScQaKLRrrCbieaItompcPaL+6sQypWEQKtbIRsXDp7
 Hgx3+ISApZn7GNBbc6rWUU6Qtmt7DTu5wjpdhdq97IyX65Ttu/7KQwXIboIiSj5DjEA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791574627; bh=mwpnsA9UQHVEPlEVNK+Yxvs
 cHK2wotgTAtS4hlcpTyI=; b=gsmdp/0FiPX76KJ1iZUR9T23hjAX3c6ttyKd8Z71dNDAons2SB
 Mb7qm04dT1VKAjxb1AKSCuinPJ7W/Mlc3/BA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Mario Six <mario.six@gdsys.cc>,
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pengpeng Hou <hppiscas@163.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 05/26] board: powerpc: Remove P4080DS support
Date: Fri,  9 Oct 2026 19:36:43 +0000
Message-ID: <20261009193704.13061-6-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009193704.13061-1-brads@mainlining.org>
References: <20261009193704.13061-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 19:54:04 +0000
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

NXP marks the P4080 Development System no longer manufactured. Drop its target, device trees, and board guide.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig   |   9 --
 arch/powerpc/dts/Makefile          |   1 -
 arch/powerpc/dts/p4080.dtsi        | 148 -------------------
 arch/powerpc/dts/p4080ds.dts       | 220 -----------------------------
 arch/powerpc/dts/p4080si-post.dtsi |  62 --------
 board/nxp/common/Makefile          |   2 -
 doc/README.srio-pcie-boot-corenet  | 118 ----------------
 7 files changed, 560 deletions(-)
 delete mode 100644 arch/powerpc/dts/p4080.dtsi
 delete mode 100644 arch/powerpc/dts/p4080ds.dts
 delete mode 100644 arch/powerpc/dts/p4080si-post.dtsi
 delete mode 100644 doc/README.srio-pcie-boot-corenet

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 65081b5bd63..5e480325062 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -87,15 +87,6 @@ config TARGET_SOCRATES
 	select ARCH_MPC8544
 	select BINMAN
 
-config TARGET_P4080DS
-	bool "Support P4080DS"
-	select PHYS_64BIT
-	select ARCH_P4080
-	select BOARD_LATE_INIT if CHAIN_OF_TRUST
-	select FSL_NGPIXIS
-	imply SATA
-	imply PANIC_HANG
-
 config TARGET_P5040DS
 	bool "Support P5040DS"
 	select PHYS_64BIT
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index c603369e7cc..09b79faf165 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
-dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
 dtb-$(CONFIG_TARGET_T1024RDB) += t1024rdb.dtb
diff --git a/arch/powerpc/dts/p4080.dtsi b/arch/powerpc/dts/p4080.dtsi
deleted file mode 100644
index 8ab5cf541a0..00000000000
--- a/arch/powerpc/dts/p4080.dtsi
+++ /dev/null
@@ -1,148 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P4080/P4040 Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-/include/ "e500mc_power_isa.dtsi"
-
-/ {
-	compatible = "fsl,P4080";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e500mc@0 {
-			device_type = "cpu";
-			reg = <0>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu1: PowerPC,e500mc@1 {
-			device_type = "cpu";
-			reg = <1>;
-			fsl,portid-mapping = <0x40000000>;
-		};
-		cpu2: PowerPC,e500mc@2 {
-			device_type = "cpu";
-			reg = <2>;
-			fsl,portid-mapping = <0x20000000>;
-		};
-		cpu3: PowerPC,e500mc@3 {
-			device_type = "cpu";
-			reg = <3>;
-			fsl,portid-mapping = <0x10000000>;
-		};
-		cpu4: PowerPC,e500mc@4 {
-			device_type = "cpu";
-			reg = <4>;
-			fsl,portid-mapping = <0x08000000>;
-		};
-		cpu5: PowerPC,e500mc@5 {
-			device_type = "cpu";
-			reg = <5>;
-			fsl,portid-mapping = <0x04000000>;
-		};
-		cpu6: PowerPC,e500mc@6 {
-			device_type = "cpu";
-			reg = <6>;
-			fsl,portid-mapping = <0x02000000>;
-		};
-		cpu7: PowerPC,e500mc@7 {
-			device_type = "cpu";
-			reg = <7>;
-			fsl,portid-mapping = <0x01000000>;
-		};
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <4>;
-			reg = <0x40000 0x40000>;
-			compatible = "fsl,mpic", "chrp,open-pic";
-			device_type = "open-pic";
-			clock-frequency = <0x0>;
-		};
-
-		espi0: spi@110000 {
-			compatible = "fsl,mpc8536-espi";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0x110000 0x1000>;
-			fsl,espi-num-chipselects = <4>;
-			status = "disabled";
-		};
-
-		esdhc: esdhc@114000 {
-			compatible = "fsl,esdhc";
-			reg = <0x114000 0x1000>;
-			clock-frequency = <0>;
-		};
-
-		usb0@210000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "ulpi";
-		};
-
-		usb1@211000 {
-			compatible = "fsl-usb2-dr";
-			reg = <0x211000 0x1000>;
-			phy_type = "ulpi";
-		};
-		/include/ "qoriq-i2c-0.dtsi"
-		/include/ "qoriq-i2c-1.dtsi"
-	};
-
-	pcie@ffe200000 {
-		compatible = "fsl,pcie-p4080", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe200000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8000000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe201000 {
-		compatible = "fsl,pcie-p4080", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe201000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <1>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe202000 {
-		compatible = "fsl,pcie-p4080", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe202000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <2>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8020000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-};
diff --git a/arch/powerpc/dts/p4080ds.dts b/arch/powerpc/dts/p4080ds.dts
deleted file mode 100644
index d5618f1e49a..00000000000
--- a/arch/powerpc/dts/p4080ds.dts
+++ /dev/null
@@ -1,220 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P4080DS Device Tree Source
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/include/ "p4080.dtsi"
-
-/ {
-	model = "fsl,P4080DS";
-	compatible = "fsl,P4080DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases {
-		phy_rgmii = &phyrgmii;
-		phy5_slot3 = &phy5slot3;
-		phy6_slot3 = &phy6slot3;
-		phy7_slot3 = &phy7slot3;
-		phy8_slot3 = &phy8slot3;
-		emi1_slot3 = &p4080mdio2;
-		emi1_slot4 = &p4080mdio1;
-		emi1_slot5 = &p4080mdio3;
-		emi1_rgmii = &p4080mdio0;
-		emi2_slot4 = &p4080xmdio1;
-		emi2_slot5 = &p4080xmdio3;
-		spi0 = &espi0;
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-
-		fman@400000 {
-			ethernet@e0000 {
-				phy-handle = <&phy0>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e2000 {
-				phy-handle = <&phy1>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-handle = <&phy2>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-handle = <&phy3>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy10>;
-				phy-connection-type = "xgmii";
-			};
-		};
-
-		fman@500000 {
-			ethernet@e0000 {
-				phy-handle = <&phy5>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e2000 {
-				phy-handle = <&phy6>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-handle = <&phy7>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-handle = <&phy8>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy11>;
-				phy-connection-type = "xgmii";
-			};
-		};
-	};
-
-	mdio-mux-emi1 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "mdio-mux-gpio", "mdio-mux";
-		mdio-parent-bus = <&mdio0>;
-		gpios = <&gpio0 1 0>, <&gpio0 0 0>;
-
-		p4080mdio0: mdio@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			phyrgmii: ethernet-phy@0 {
-				reg = <0x0>;
-			};
-		};
-
-		p4080mdio1: mdio@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-
-			phy5: ethernet-phy@1c {
-				reg = <0x1c>;
-			};
-
-			phy6: ethernet-phy@1d {
-				reg = <0x1d>;
-			};
-
-			phy7: ethernet-phy@1e {
-				reg = <0x1e>;
-			};
-
-			phy8: ethernet-phy@1f {
-				reg = <0x1f>;
-			};
-		};
-
-		p4080mdio2: mdio@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-			status = "disabled";
-
-			phy5slot3: ethernet-phy@1c {
-				reg = <0x1c>;
-			};
-
-			phy6slot3: ethernet-phy@1d {
-				reg = <0x1d>;
-			};
-
-			phy7slot3: ethernet-phy@1e {
-				reg = <0x1e>;
-			};
-
-			phy8slot3: ethernet-phy@1f {
-				reg = <0x1f>;
-			};
-		};
-
-		p4080mdio3: mdio@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-
-			phy0: ethernet-phy@1c {
-				reg = <0x1c>;
-			};
-
-			phy1: ethernet-phy@1d {
-				reg = <0x1d>;
-			};
-
-			phy2: ethernet-phy@1e {
-				reg = <0x1e>;
-			};
-
-			phy3: ethernet-phy@1f {
-				reg = <0x1f>;
-			};
-		};
-	};
-
-	mdio-mux-emi2 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "mdio-mux-gpio", "mdio-mux";
-		mdio-parent-bus = <&xmdio0>;
-		gpios = <&gpio0 3 0>, <&gpio0 2 0>;
-
-		p4080xmdio1: mdio@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-
-			phy11: ethernet-phy@0 {
-				compatible = "ethernet-phy-ieee802.3-c45";
-				reg = <0x0>;
-			};
-		};
-
-		p4080xmdio3: mdio@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-
-			phy10: ethernet-phy@4 {
-				compatible = "ethernet-phy-ieee802.3-c45";
-				reg = <0x4>;
-			};
-		};
-	};
-};
-
-&espi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		/* input clock */
-		spi-max-frequency = <10000000>;
-	};
-};
-
-/include/ "p4080si-post.dtsi"
diff --git a/arch/powerpc/dts/p4080si-post.dtsi b/arch/powerpc/dts/p4080si-post.dtsi
deleted file mode 100644
index 56b79b14f4a..00000000000
--- a/arch/powerpc/dts/p4080si-post.dtsi
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * P4080/P4040 Silicon/SoC Device Tree Source (post include)
- *
- * Copyright 2011 - 2015 Freescale Semiconductor Inc.
- * Copyright 2020 NXP
- *
- */
-
-&soc {
-
-/include/ "qoriq-clockgen1.dtsi"
-/include/ "qoriq-gpio-0.dtsi"
-/include/ "qoriq-sec4.0-0.dtsi"
-
-/* include used FMan blocks */
-/include/ "qoriq-fman-0.dtsi"
-/include/ "qoriq-fman-0-1g-0.dtsi"
-/include/ "qoriq-fman-0-1g-1.dtsi"
-/include/ "qoriq-fman-0-1g-2.dtsi"
-/include/ "qoriq-fman-0-1g-3.dtsi"
-/include/ "qoriq-fman-0-10g-0.dtsi"
-	fman@400000 {
-		enet0: ethernet@e0000 {
-		};
-
-		enet1: ethernet@e2000 {
-		};
-
-		enet2: ethernet@e4000 {
-		};
-
-		enet3: ethernet@e6000 {
-		};
-
-		enet4: ethernet@f0000 {
-		};
-	};
-
-/include/ "qoriq-fman-1.dtsi"
-/include/ "qoriq-fman-1-1g-0.dtsi"
-/include/ "qoriq-fman-1-1g-1.dtsi"
-/include/ "qoriq-fman-1-1g-2.dtsi"
-/include/ "qoriq-fman-1-1g-3.dtsi"
-/include/ "qoriq-fman-1-10g-0.dtsi"
-	fman@500000 {
-		enet5: ethernet@e0000 {
-		};
-
-		enet6: ethernet@e2000 {
-		};
-
-		enet7: ethernet@e4000 {
-		};
-
-		enet8: ethernet@e6000 {
-		};
-
-		enet9: ethernet@f0000 {
-		};
-	};
-};
diff --git a/board/nxp/common/Makefile b/board/nxp/common/Makefile
index ba1aa084aa4..8fd6d6ce8c2 100644
--- a/board/nxp/common/Makefile
+++ b/board/nxp/common/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_DEEP_SLEEP)		+= mpc85xx_sleep.o
 endif
 
 
-obj-$(CONFIG_TARGET_P4080DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
@@ -66,7 +65,6 @@ obj-$(CONFIG_EMC2305)              += emc2305.o
 
 # deal with common files for P-series corenet based devices
 obj-$(CONFIG_TARGET_P2041RDB)	+= p_corenet/
-obj-$(CONFIG_TARGET_P4080DS)	+= p_corenet/
 obj-$(CONFIG_TARGET_P5040DS)	+= p_corenet/
 
 obj-$(CONFIG_LAYERSCAPE_NS_ACCESS)	+= ns_access.o
diff --git a/doc/README.srio-pcie-boot-corenet b/doc/README.srio-pcie-boot-corenet
deleted file mode 100644
index 5625ad1a2bb..00000000000
--- a/doc/README.srio-pcie-boot-corenet
+++ /dev/null
@@ -1,118 +0,0 @@
----------------------------------------
-SRIO and PCIE Boot on Corenet Platforms
----------------------------------------
-
-For some PowerPC processors with SRIO or PCIE interface, boot location can be
-configured to SRIO or PCIE by RCW. The processor booting from SRIO or PCIE can
-do without flash for u-boot image, ucode and ENV. All the images can be fetched
-from another processor's memory space by SRIO or PCIE link connected between
-them.
-
-This document describes the processes based on an example implemented on P4080DS
-platforms and a RCW example with boot from SRIO or PCIE configuration.
-
-Environment of the SRIO or PCIE boot:
-	a) Master and slave can be SOCs in one board or SOCs in separate boards.
-	b) They are connected with SRIO or PCIE links, whether 1x, 2x or 4x, and
-	   directly or through switch system.
-	c) Only Master has NorFlash for booting, and all the Master's and Slave's
-	   U-Boot images, UCodes will be stored in this flash.
-	d) Slave has its own EEPROM for RCW and PBI.
-	e) Slave's RCW should configure the SerDes for SRIO or PCIE boot port, set
-	   the boot location to SRIO or PCIE, and holdoff all the cores.
-
-	-----------       -----------             -----------
-	|         |       |         |             |         |
-	|         |       |         |             |         |
-	| NorFlash|<----->| Master  |SRIO or PCIE |  Slave  |<---->[EEPROM]
-	|         |       |         |<===========>|         |
-	|         |       |         |             |         |
-	-----------       -----------             -----------
-
-The example based on P4080DS platform:
-	Two P4080DS platforms can be used to implement the boot from SRIO or PCIE.
-	Their SRIO or PCIE ports 1 will be connected directly and will be used for
-	the boot from SRIO or PCIE.
-
-	1. Slave's RCW example for boot from SRIO port 1 and all cores in holdoff.
-		00000000: aa55 aa55 010e 0100 0c58 0000 0000 0000
-		00000010: 1818 1818 0000 8888 7440 4000 0000 2000
-		00000020: f440 0000 0100 0000 0000 0000 0000 0000
-		00000030: 0000 0000 0083 0000 0000 0000 0000 0000
-		00000040: 0000 0000 0000 0000 0813 8040 063c 778f
-
-	2. Slave's RCW example for boot from PCIE port 1 and all cores in holdoff.
-		00000000: aa55 aa55 010e 0100 0c58 0000 0000 0000
-		00000010: 1818 1818 0000 8888 1440 4000 0000 2000
-		00000020: f040 0000 0100 0000 0020 0000 0000 0000
-		00000030: 0000 0000 0083 0000 0000 0000 0000 0000
-		00000040: 0000 0000 0000 0000 0813 8040 547e ffc9
-
-	3. Sequence in Step by Step.
-		a) Update RCW for slave with boot from SRIO or PCIE port 1 configuration.
-		b) Program slave's U-Boot image, UCode, and ENV parameters into master's
-		   NorFlash.
-		c) Set environment variable "bootmaster" to "SRIO1" or "PCIE1" and save
-		   environment for master.
-					env set bootmaster SRIO1
-				or
-					env set bootmaster PCIE1
-					saveenv
-		d) Restart up master and it will boot up normally from its NorFlash.
-		   Then, it will finish necessary configurations for slave's boot from
-		   SRIO or PCIE port 1.
-		e) Master will set inbound SRIO or PCIE windows covered slave's U-Boot
-		   image stored in master's NorFlash.
-		f) Master will set an inbound SRIO or PCIE window covered slave's UCode
-		   and ENV stored in master's NorFlash.
-		g) Master will set outbound SRIO or PCIE  windows in order to configure
-		   slave's registers for the core's releasing.
-		h) Since all cores of slave in holdoff, slave should be powered on before
-		   all the above master's steps, and wait to be released by master. In the
-		   startup phase of the slave from SRIO or PCIE, it will finish some
-		   necessary configurations.
-		i) Slave will set a specific TLB entry for the boot process.
-		j) Slave will set a LAW entry with the TargetID SRIO or PCIE port 1 for
-		   the boot.
-		k) Slave will set a specific TLB entry in order to fetch UCode and ENV
-		   from master.
-		l) Slave will set a LAW entry with the TargetID SRIO or PCIE port 1 for
-		   UCode and ENV.
-
-How to use this feature:
-	To use this feature, you need to focus those points.
-
-	1. Slave's RCW with SRIO or PCIE boot configurations, and all cores in holdoff
-	   configurations.
-	   Please refer to the examples given above.
-
-	2. U-Boot image's compilation.
-	   For master, U-Boot image should be generated normally.
-
-	   For example, master U-Boot image used on P4080DS should be compiled with
-
-				make P4080DS_config.
-
-	   For slave, U-Boot image should be generated specifically by
-
-				make xxxx_SRIO_PCIE_BOOT_config.
-
-	   For example, slave U-Boot image used on P4080DS should be compiled with
-
-				make P4080DS_SRIO_PCIE_BOOT_config.
-
-	3. Necessary modifications based on a specific environment.
-	   For a specific environment, the addresses of the slave's U-Boot image,
-	   UCode, ENV stored in master's NorFlash, and any other configurations
-	   can be modified in the file:
-				include/configs/corenet_ds.h.
-
-	4. Set and save the environment variable "bootmaster" with "SRIO1", "SRIO2"
-	   or "PCIE1", "PCIE2", "PCIE3" for master, and then restart it in order to
-	   perform the role as a master for boot from SRIO or PCIE.
-
-NOTE: When the Slave's ENV parameters are stored in Master's NorFlash,
-      it can fetch them through PCIE or SRIO interface. But the ENV
-      parameters can not be modified by "saveenv" or other commands under
-      the Slave's u-boot environment, because the Slave can not erase,
-      write Master's NorFlash by PCIE or SRIO link.
-- 
2.47.3

