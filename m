Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDB606A32E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m6QnDoSu;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=IvR2OkQo;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=5r2g3ZQh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B255F608FB;
	Wed, 21 Oct 2026 16:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SCK4pUYE_TKb; Wed, 21 Oct 2026 16:16:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A871E608F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599375;
	b=D9KLQ2xdyDfk6MVTEHTrWrEmPVM5oqkp5ysewCGzKaJqEgKUtGTdgetauKxSkFip4rib
	 FMq4vhRwN8FSqfTNwOkA6R1q8FDRY1BaZXJJjEEZn7age5CWSVgIkl89xbHYxOo5wWC2T
	 0T2rjDvHDWMPMO4Nq/Fe9lT+t9bbuNV9k0anvne+0z3fGbyw2IY/WUYqBajtPb/J+MRaJ
	 MA2bEarJuJ5WHgFC5FYPLT+IAKNkyr18ArSVyIYZUvkpD6+PJuEXTYhMcRnpTYRU+NyJJ
	 3+7wgmu6ASQZ0/7qkmxpsQjCTq6NFTQ1YLdzNCgN5EUCDRX0I3dAz1o8wQCmNZsyKvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XoLpti8PlHMomLkhh4CQMCA4ByouajETdQlz/NIWzBk=;
	b=aWOpyrg4tz3nMLBSf9xOFjX5BWxChhpRZp0KzZmFP2YZc0/n8J0MQkh5ozAkor8oLtN0
	 KpQxEHnr6am3YhF35l9jtq926bxCZUMZk7Gyg/5/1vRMAn98gsxBAszwrkFpOAfrWfMfu
	 k099rG42qDEIC+vBG1iFi7dQi0xdMU4qL7tBu6X1V0Mw5utZphC4vqN2erAlGFGqcJMqE
	 AdGpmPr1AxQb7cfAluyaWYvYj6XNaQ9z8I+76JxLaPkAWhkUQLXwlsvSQuDBsF75Oh6p1
	 ECBGjQDQewpfqo3I81IcZBgNJ5dXajyZu4pvBv+6Yc7lpQZzS8fQ/S/0QCMFCNaO6nw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599375;
	bh=XoLpti8PlHMomLkhh4CQMCA4ByouajETdQlz/NIWzBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6QnDoSuzZbGqK2VFfL4Bx/aHm2vvrya2gL5PU/YN0hszdztZsLm58QhusJOfzCda
	 3bqJlCzgIKfTMV2PuWbKP31KMec1ZeNifqQG43vo+IWFVQOLCGiSdZzdPDAOmAZ1N7
	 3N14ZvMQ1PwNbit6Oz3BRmUF1BFQYOnLIkiOVy/4wRe8xSAIbEayOiMQ8gcs9ZPBUk
	 t3zq6AJasKcsSqU/BciwgfdrxD1YWB+OLZksVfzephpV3XvOLPVM0G8gFukifUKgUF
	 Wsf0dIPDzFChnELMiQ8S9He+/vMGGqTgDUXKD8z6KOHy9f9gl+Dvk73F9z8gIilZoT
	 HuAa3EOv/GJzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A871E608F8;
	Wed, 21 Oct 2026 16:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 9559B1E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 8759640877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id tCTT0r-47oK2 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 87D074084B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598512;
 b=ZSKl9keTOQuMxLhX3lDP2Y9zGJVLRO5jtoYyMZ/+X9PbLhG6kqwnV6HIc+a5OyAnS3xA
 Zl3KVAQeEqvr+k6gmDoes37cSTdJKwEFOm8ofSdpAFDGayymG5fUFBiEWPM3Iv2YlZj6/
 CupoORbdzZzweOus+2YJDCcDR6rOmYIO3QAc0y8YYMhdVAbjC83JzkwVN1FuNSlDfyj3G
 o9RvwPJnZWJx27RQABidHdHj4LSvBXPEoo21rktLxyiBfbzc9+Azi2WTWCSLF6530GR7v
 Zyi1Sh1GOi5zFCobWF2t2w9/LlArrWULeDUBbjgTJTReoJCLInFIsUp6LmdXAM4ThNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598512;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XoLpti8PlHMomLkhh4CQMCA4ByouajETdQlz/NIWzBk=;
 b=Gpm/wrT1OdMRzIeMRTpZgokmloYmVWhGpEQ824gBj5GLyc2XHYf7UdcTRsc8HzP4bHQa
 vtkt/FmQ4+qjaQNLaPa4NzDKY9hew/+8WrQiO5QjuciTmn+wNSiPUwCKZHqtwDkqIiZpk
 e4SaXLdrg4i7pi4revEvU9wuRlGelQiB37/xkQHkKizmgPc6EVZlKzEJFn5V25Lstkv78
 icbi4N9zPTU5RigkMDIIzNvhoCS5eRXXsRxn7Ztym5AK9AJTCw2JEtTTZ3pwCAPf6tldG
 lY3hCUOsT86H2r6bAoGQiZMdda9S429H1rehCX3lyNQ9fZdQAX2pmOdkZKKzTBBqcoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=IvR2OkQo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=5r2g3ZQh; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=IvR2OkQo; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=5r2g3ZQh
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 87D074084B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598505; bh=XoLpti8PlHMomLkhh4CQMCA
 4ByouajETdQlz/NIWzBk=; b=IvR2OkQoc75OWAg8dtN7S9izMqN///TGtn1PWysWWgtnQoYebZ
 HgYehVssrdn1ZjABo1eYH0HAsU2Z1oB7LgC8spHMvZWFHPrhJAJ0Wms3D/VSHZMO+v81qk1yWDg
 rgCzvZ9ARz854oa/9FizOPrEzZHxvq3UujdkhnADLj1HEEjPygGa23jO6oERXlfG8d4NNmb1X6x
 r9AGmUpCdO3C0EEhMl4f/FuZWUNk7sZZjKQjWHW80VxVm0vh38VAcXi6iZLh5ovx3KbaOeV9GN4
 xV5GKIDyFVXqbLTUnWaVa8PC39MyHlcHvXTTISEcr9wg2UMzYMPp+umXJiHXVgPSesg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598505; bh=XoLpti8PlHMomLkhh4CQMCA
 4ByouajETdQlz/NIWzBk=; b=5r2g3ZQh+mCvTCI6BE5Kl9gzEpU3nbFRjhK/HpGbviJ0dnaLFh
 q4O09uawQ33+yGC2NQekpHKuH5RlgXowFvBQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>, Mario Six <mario.six@gdsys.cc>,
 Sinan Akman <sinan@writeme.com>
Subject: [PATCH v3 02/26] board: powerpc: Remove MPC837XERDB support
Date: Wed, 21 Oct 2026 16:00:58 +0000
Message-ID: <20261021160145.10430-3-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MPC837XERDB board is unmaintained and lacks active community
testing. Drop this target and its board files.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc83xx/Kconfig    |   7 -
 arch/powerpc/dts/Makefile           |   1 -
 arch/powerpc/dts/mpc8379erdb.dts    | 153 ------------------
 board/nxp/mpc837xerdb/Kconfig       |  15 --
 board/nxp/mpc837xerdb/MAINTAINERS   |   6 -
 board/nxp/mpc837xerdb/Makefile      |   6 -
 board/nxp/mpc837xerdb/README        |  97 -----------
 board/nxp/mpc837xerdb/mpc837xerdb.c | 242 ----------------------------
 configs/MPC837XERDB_defconfig       | 193 ----------------------
 include/configs/MPC837XERDB.h       | 218 -------------------------
 10 files changed, 938 deletions(-)
 delete mode 100644 arch/powerpc/dts/mpc8379erdb.dts
 delete mode 100644 board/nxp/mpc837xerdb/Kconfig
 delete mode 100644 board/nxp/mpc837xerdb/MAINTAINERS
 delete mode 100644 board/nxp/mpc837xerdb/Makefile
 delete mode 100644 board/nxp/mpc837xerdb/README
 delete mode 100644 board/nxp/mpc837xerdb/mpc837xerdb.c
 delete mode 100644 configs/MPC837XERDB_defconfig
 delete mode 100644 include/configs/MPC837XERDB.h

diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index 0dc72c87423..088283d646c 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -24,12 +24,6 @@ config TARGET_CMPCPRO
 	bool "Support CMPCPRO board from CSSI"
 	select ARCH_MPC832X
 
-config TARGET_MPC837XERDB
-	bool "Support MPC837XERDB"
-	select ARCH_MPC837X
-	select BOARD_EARLY_INIT_F
-	select SYS_83XX_DDR_USES_CS0
-
 config TARGET_KMETER1
 	bool "Support kmeter1"
 	select VENDOR_KM
@@ -208,7 +202,6 @@ config FSL_SERDES
 config NEVER_ASSERT_ODT_TO_CPU
 	bool "Never assert ODT to internal IOs"
 
-source "board/nxp/mpc837xerdb/Kconfig"
 source "board/gdsys/mpc8308/Kconfig"
 source "board/cssi/cmpcpro/Kconfig"
 
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 2540684307e..01191273269 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -7,7 +7,6 @@ dtb-$(CONFIG_TARGET_KMOPTI2) += kmopti2.dtb
 dtb-$(CONFIG_TARGET_KMSUPX5) += kmsupc5.dtb kmsupm5.dtb
 dtb-$(CONFIG_TARGET_KMTEGR1) += kmtegr1.dtb
 dtb-$(CONFIG_TARGET_KMTEPR2) += kmtepr2.dtb
-dtb-$(CONFIG_TARGET_MPC837XERDB) += mpc8379erdb.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
diff --git a/arch/powerpc/dts/mpc8379erdb.dts b/arch/powerpc/dts/mpc8379erdb.dts
deleted file mode 100644
index 3db5ececaec..00000000000
--- a/arch/powerpc/dts/mpc8379erdb.dts
+++ /dev/null
@@ -1,153 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * MPC8379E RDB Device Tree Source
- *
- * Copyright 2020 NXP
- */
-
-/dts-v1/;
-
-/ {
-	compatible = "fsl,mpc8379erdb";
-
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		serial0 = &serial0;
-		serial1 = &serial1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8379@0 {
-			device_type = "cpu";
-			reg = <0x0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;
-			bus-frequency = <0>;
-			clock-frequency = <0>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x10000000>;  // 256MB at 0
-	};
-
-	localbus@e0005000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,elbc", "simple-bus";
-		reg = <0xe0005000 0x1000>;
-		interrupts = <77 0x8>;
-		interrupt-parent = <&ipic>;
-	};
-
-	immr@e0000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0 0xe0000000 0x00100000>;
-		reg = <0xe0000000 0x00000200>;
-		bus-frequency = <0>;
-
-		sdhc@2e000 {
-			compatible = "fsl,esdhc";
-			reg = <0x2e000 0x1000>;
-			bus-width = <0x4>;
-			clock-frequency = <0>;
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <333333000>;
-			interrupts = <9 0x8>;
-			interrupt-parent = <&ipic>;
-			bootph-all;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <333333000>;
-			interrupts = <10 0x8>;
-			interrupt-parent = <&ipic>;
-			bootph-all;
-		};
-
-		ipic: interrupt-controller@700 {
-			compatible = "fsl,ipic";
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x700 0x100>;
-			device_type = "ipic";
-		};
-
-		usb@23000 {
-			compatible = "fsl-usb2-dr";
-			reg = <0x23000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupt-parent = <&ipic>;
-			interrupts = <38 0x8>;
-			phy_type = "ulpi";
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "eTSEC";
-			compatible = "fsl,etsec2";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <32 0x8 33 0x8 34 0x8>;
-			phy-connection-type = "mii";
-			interrupt-parent = <&ipic>;
-			fixed-link = <1 0 1000 0 0>;
-			phy-handle = <&phy>;
-			fsl,magic-packet;
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,etsec2-mdio";
-				reg = <0x520 0x20>;
-
-				phy: ethernet-phy@2 {
-					interrupt-parent = <&ipic>;
-					interrupts = <17 0x8>;
-					reg = <0x2>;
-					device_type = "ethernet-phy";
-				};
-			};
-		};
-
-		pci0: pci@e0008300 {
-	                #address-cells = <3>;
-	                #size-cells = <2>;
-	                #interrupt-cells = <1>;
-	                device_type = "pci";
-	                reg = <0x0 0xe0008300 0x0 0x00000fff>;
-			compatible = "fsl,mpc837x-pci";
-	                clock-frequency = <0>;
-		};
-
-	};
-
-};
diff --git a/board/nxp/mpc837xerdb/Kconfig b/board/nxp/mpc837xerdb/Kconfig
deleted file mode 100644
index f11f6f5bfea..00000000000
--- a/board/nxp/mpc837xerdb/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-if TARGET_MPC837XERDB
-
-config PCIE
-	def_bool y
-
-config SYS_BOARD
-	default "mpc837xerdb"
-
-config SYS_VENDOR
-	default "nxp"
-
-config SYS_CONFIG_NAME
-	default "MPC837XERDB"
-
-endif
diff --git a/board/nxp/mpc837xerdb/MAINTAINERS b/board/nxp/mpc837xerdb/MAINTAINERS
deleted file mode 100644
index cc0a6acd8c3..00000000000
--- a/board/nxp/mpc837xerdb/MAINTAINERS
+++ /dev/null
@@ -1,6 +0,0 @@
-MPC837XERDB BOARD
-M:	Sinan Akman <sinan@writeme.com>
-S:	Maintained
-F:	board/nxp/mpc837xerdb/
-F:	include/configs/MPC837XERDB.h
-F:	configs/MPC837XERDB_defconfig
diff --git a/board/nxp/mpc837xerdb/Makefile b/board/nxp/mpc837xerdb/Makefile
deleted file mode 100644
index 4661e4cf232..00000000000
--- a/board/nxp/mpc837xerdb/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# (C) Copyright 2006
-# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
-
-obj-y += mpc837xerdb.o
diff --git a/board/nxp/mpc837xerdb/README b/board/nxp/mpc837xerdb/README
deleted file mode 100644
index 12df2f2e756..00000000000
--- a/board/nxp/mpc837xerdb/README
+++ /dev/null
@@ -1,97 +0,0 @@
-Freescale MPC837xE-RDB Board
------------------------------------------
-
-1.	Board Description
-
-	The MPC837xE-RDB are reference boards featuring the Freescale MPC8377E,
-	MPC8378E, and the MPC8379E processors in a Mini-ITX form factor.
-
-	The MPC837xE-RDB's have the following common features:
-
-	A) 256-MBytes on-board DDR2 unbuffered SDRAM
-	B) 8-Mbytes NOR Flash
-	C) 32-MBytes NAND Flash
-	D) 1 Secure Digital High Speed Card (SDHC) Interface
-	E) 1 Gigabit Ethernet
-	F) 5-port Ethernet switch (Vitesse 7385)
-	G) 1 32-bit, 3.3 V, PCI slot
-	H) 1 32-bit, 3.3 V, Mini-PCI slot
-	I) 4-port USB 2.0 Hub
-	J) 1-port OTG USB
-	K) 2 serial ports (top main console)
-	L) on board Oscillator: 66M
-
-	The MPC837xE-RDB's have the following differences:
-
-			    MPC8377E-RDB    MPC8378E-RDB    MPC8379E-RDB
-	SATA controllers	2		0		4
-	PCI-Express (mini)	2		2		0
-	SGMII Ports		0		2		0
-
-
-2.	Memory Map
-
-2.1.	The memory map should look pretty much like this:
-
-	Address Range			Device			Size		Port Size
-								(Bytes)		(Bits)
-	===========================	=================	=======		=========
-	0x0000_0000	0x0fff_ffff	DDR			256M		64
-	0x1000_0000	0x7fff_ffff	Empty			1.75G		-
-	0x8000_0000	0x8fff_ffff	PCI MEM prefetch	256M		32
-	0x9000_0000	0x9fff_ffff	PCI MEM non-prefetch	256M		32
-	0xe030_0000	0xe03f_ffff	PCI I/O space		1M		32
-	0xe000_0000	0xe00f_ffff	Int Mem Reg Space	1M		-
-	0xe060_0000	0xe060_7fff	NAND Flash		32K		8
-	0xfe00_0000	0xfe7f_ffff	NOR Flash on CS0	8M		16
-
-
-3. Definitions
-
-3.1 Explanation of NEW definitions in:
-
-	include/configs/MPC837XERDB.h
-
-    CONFIG_MPC83xx	    MPC83xx family for both MPC8349 and MPC8360
-    CONFIG_MPC837x	    MPC837x specific
-    CONFIG_MPC837XERDB	    MPC837xE-RDB board specific
-
-
-4. Compilation
-
-	Assuming you're using BASH shell:
-
-		export CROSS_COMPILE=your-cross-compile-prefix
-		cd u-boot
-		make distclean
-		make MPC837XERDB_config
-		make
-
-
-5. Downloading and Flashing Images
-
-5.0 Download over serial line using Kermit:
-
-	loadb $loadaddr
-	[Drop to kermit:
-	    ^\c
-	    send <u-boot-bin-image>
-	    c
-	]
-
-
-	Or via tftp:
-
-	tftp $loadaddr u-boot.bin
-
-5.1 Reflash U-Boot Image using U-Boot
-
-	tftp $loadaddr u-boot.bin
-	protect off fe000000 fe0fffff
-	erase fe000000 fe0fffff
-	cp.b $loadaddr fe000000 $filesize
-
-
-6. Additional Notes:
-	1) The console is connected to the top RS-232 connector and the
-	   baudrate for MPC837XE-RDB is 115200bps.
diff --git a/board/nxp/mpc837xerdb/mpc837xerdb.c b/board/nxp/mpc837xerdb/mpc837xerdb.c
deleted file mode 100644
index 55299745a3c..00000000000
--- a/board/nxp/mpc837xerdb/mpc837xerdb.c
+++ /dev/null
@@ -1,242 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2007 Freescale Semiconductor, Inc.
- * Kevin Lam <kevin.lam@freescale.com>
- * Joe D'Abbraccio <joe.d'abbraccio@freescale.com>
- */
-
-#include <config.h>
-#include <env.h>
-#include <hwconfig.h>
-#include <i2c.h>
-#include <init.h>
-#include <asm/bitops.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/fsl_mpc83xx_serdes.h>
-#include <fdt_support.h>
-#include <spd_sdram.h>
-#include <vsc7385.h>
-#include <fsl_esdhc.h>
-#include <linux/delay.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-#if defined(CFG_SYS_DRAM_TEST)
-int
-testdram(void)
-{
-	uint *pstart = (uint *) CONFIG_SYS_MEMTEST_START;
-	uint *pend = (uint *) CONFIG_SYS_MEMTEST_END;
-	uint *p;
-
-	printf("Testing DRAM from 0x%08x to 0x%08x\n",
-	       CONFIG_SYS_MEMTEST_START,
-	       CONFIG_SYS_MEMTEST_END);
-
-	printf("DRAM test phase 1:\n");
-	for (p = pstart; p < pend; p++)
-		*p = 0xaaaaaaaa;
-
-	for (p = pstart; p < pend; p++) {
-		if (*p != 0xaaaaaaaa) {
-			printf("DRAM test fails at: %08x\n", (uint) p);
-			return 1;
-		}
-	}
-
-	printf("DRAM test phase 2:\n");
-	for (p = pstart; p < pend; p++)
-		*p = 0x55555555;
-
-	for (p = pstart; p < pend; p++) {
-		if (*p != 0x55555555) {
-			printf("DRAM test fails at: %08x\n", (uint) p);
-			return 1;
-		}
-	}
-
-	printf("DRAM test passed.\n");
-	return 0;
-}
-#endif
-
-#if defined(CONFIG_DDR_ECC) && !defined(CONFIG_ECC_INIT_VIA_DDRCONTROLLER)
-void ddr_enable_ecc(unsigned int dram_size);
-#endif
-int fixed_sdram(void);
-
-int dram_init(void)
-{
-	immap_t *im = (immap_t *) CONFIG_SYS_IMMR;
-	u32 msize = 0;
-
-	if ((im->sysconf.immrbar & IMMRBAR_BASE_ADDR) != (u32) im)
-		return -ENXIO;
-
-#if defined(CONFIG_SPD_EEPROM)
-	msize = spd_sdram();
-#else
-	msize = fixed_sdram();
-#endif
-
-#if defined(CONFIG_DDR_ECC) && !defined(CONFIG_ECC_INIT_VIA_DDRCONTROLLER)
-	/* Initialize DDR ECC byte */
-	ddr_enable_ecc(msize * 1024 * 1024);
-#endif
-	/* return total bus DDR size(bytes) */
-	gd->ram_size = msize * 1024 * 1024;
-
-	return 0;
-}
-
-#if !defined(CONFIG_SPD_EEPROM)
-/*************************************************************************
- *  fixed sdram init -- doesn't use serial presence detect.
- ************************************************************************/
-int fixed_sdram(void)
-{
-	immap_t *im = (immap_t *) CONFIG_SYS_IMMR;
-	u32 msize = CFG_SYS_SDRAM_SIZE;
-	u32 msize_log2 = __ilog2(msize);
-
-	im->sysconf.ddrlaw[0].bar = CFG_SYS_SDRAM_BASE & 0xfffff000;
-	im->sysconf.ddrlaw[0].ar = LBLAWAR_EN | (msize_log2 - 1);
-
-	im->sysconf.ddrcdr = CFG_SYS_DDRCDR_VALUE;
-	udelay(50000);
-
-	im->ddr.sdram_clk_cntl = CFG_SYS_DDR_SDRAM_CLK_CNTL;
-	udelay(1000);
-
-	im->ddr.csbnds[0].csbnds = CFG_SYS_DDR_CS0_BNDS;
-	im->ddr.cs_config[0] = CFG_SYS_DDR_CS0_CONFIG;
-	udelay(1000);
-
-	im->ddr.timing_cfg_0 = CFG_SYS_DDR_TIMING_0;
-	im->ddr.timing_cfg_1 = CFG_SYS_DDR_TIMING_1;
-	im->ddr.timing_cfg_2 = CFG_SYS_DDR_TIMING_2;
-	im->ddr.timing_cfg_3 = CFG_SYS_DDR_TIMING_3;
-	im->ddr.sdram_cfg = CFG_SYS_DDR_SDRAM_CFG;
-	im->ddr.sdram_cfg2 = CFG_SYS_DDR_SDRAM_CFG2;
-	im->ddr.sdram_mode = CFG_SYS_DDR_MODE;
-	im->ddr.sdram_mode2 = CFG_SYS_DDR_MODE2;
-	im->ddr.sdram_interval = CFG_SYS_DDR_INTERVAL;
-	sync();
-	udelay(1000);
-
-	im->ddr.sdram_cfg |= SDRAM_CFG_MEM_EN;
-	udelay(2000);
-	return CFG_SYS_SDRAM_SIZE >> 20;
-}
-#endif	/*!CONFIG_SYS_SPD_EEPROM */
-
-int checkboard(void)
-{
-	puts("Board: Freescale MPC837xERDB\n");
-	return 0;
-}
-
-int board_early_init_f(void)
-{
-	immap_t *immr = (immap_t *)CONFIG_SYS_IMMR;
-#ifdef CONFIG_FSL_SERDES
-	u32 spridr = in_be32(&immr->sysconf.spridr);
-
-	/* we check only part num, and don't look for CPU revisions */
-	switch (PARTID_NO_E(spridr)) {
-	case SPR_8377:
-		fsl_setup_serdes(CFG_FSL_SERDES1, FSL_SERDES_PROTO_SATA,
-				 FSL_SERDES_CLK_100, FSL_SERDES_VDD_1V);
-		fsl_setup_serdes(CFG_FSL_SERDES2, FSL_SERDES_PROTO_PEX,
-				 FSL_SERDES_CLK_100, FSL_SERDES_VDD_1V);
-		break;
-	case SPR_8378:
-		fsl_setup_serdes(CFG_FSL_SERDES2, FSL_SERDES_PROTO_PEX,
-				 FSL_SERDES_CLK_100, FSL_SERDES_VDD_1V);
-		break;
-	case SPR_8379:
-		fsl_setup_serdes(CFG_FSL_SERDES1, FSL_SERDES_PROTO_SATA,
-				 FSL_SERDES_CLK_100, FSL_SERDES_VDD_1V);
-		fsl_setup_serdes(CFG_FSL_SERDES2, FSL_SERDES_PROTO_SATA,
-				 FSL_SERDES_CLK_100, FSL_SERDES_VDD_1V);
-		break;
-	default:
-		printf("serdes not configured: unknown CPU part number: "
-		       "%04x\n", spridr >> 16);
-		break;
-	}
-#endif /* CONFIG_FSL_SERDES */
-
-#ifdef CONFIG_FSL_ESDHC
-	clrsetbits_be32(&immr->sysconf.sicrl, SICRL_USB_B, SICRL_USB_B_SD);
-	clrsetbits_be32(&immr->sysconf.sicrh, SICRH_SPI, SICRH_SPI_SD);
-#endif
-	return 0;
-}
-
-#ifdef CONFIG_FSL_ESDHC
-#if !(CONFIG_IS_ENABLED(DM_MMC) || CONFIG_IS_ENABLED(DM_USB))
-int board_mmc_init(struct bd_info *bd)
-{
-	struct immap __iomem *im = (struct immap __iomem *)CONFIG_SYS_IMMR;
-	char buffer[HWCONFIG_BUFFER_SIZE] = {0};
-	int esdhc_hwconfig_enabled = 0;
-
-	if (env_get_f("hwconfig", buffer, sizeof(buffer)) > 0)
-		esdhc_hwconfig_enabled = hwconfig_f("esdhc", buffer);
-
-	if (esdhc_hwconfig_enabled == 0)
-		return 0;
-
-	clrsetbits_be32(&im->sysconf.sicrl, SICRL_USB_B, SICRL_USB_B_SD);
-	clrsetbits_be32(&im->sysconf.sicrh, SICRH_SPI, SICRH_SPI_SD);
-
-	return fsl_esdhc_mmc_init(bd);
-}
-#endif
-#endif
-
-/*
- * Miscellaneous late-boot configurations
- *
- * If a VSC7385 microcode image is present, then upload it.
-*/
-int misc_init_r(void)
-{
-	int rc = 0;
-
-#ifdef CFG_VSC7385_IMAGE
-	if (vsc7385_upload_firmware((void *) CFG_VSC7385_IMAGE,
-		CFG_VSC7385_IMAGE_SIZE)) {
-		puts("Failure uploading VSC7385 microcode.\n");
-		rc = 1;
-	}
-#endif
-
-	return rc;
-}
-
-int board_late_init(void)
-{
-	volatile immap_t *immap = (immap_t *) CONFIG_SYS_IMMR;
-#ifdef CONFIG_USB_HOST
-	clrsetbits_be32(&immap->sysconf.sicrl, SICRL_USB_A, 0x40000000);
-#endif
-	return 0;
-}
-
-#if defined(CONFIG_OF_BOARD_SETUP)
-
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-#ifdef CONFIG_PCI
-	ft_pci_setup(blob, bd);
-#endif
-	ft_cpu_setup(blob, bd);
-	fsl_fdt_fixup_dr_usb(blob, bd);
-	fdt_fixup_esdhc(blob, bd);
-
-	return 0;
-}
-#endif /* CONFIG_OF_BOARD_SETUP */
diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
deleted file mode 100644
index a9d06785186..00000000000
--- a/configs/MPC837XERDB_defconfig
+++ /dev/null
@@ -1,193 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0xFE000000
-CONFIG_SYS_MALLOC_LEN=0x80000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="mpc8379erdb"
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_DEBUG_UART_BASE=0xe0004500
-CONFIG_DEBUG_UART_CLOCK=333333000
-CONFIG_SYS_CLK_FREQ=66666667
-CONFIG_ENV_ADDR=0xFE080000
-# CONFIG_SYS_PCI_64BIT is not set
-CONFIG_MPC83xx=y
-CONFIG_HIGH_BATS=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_TARGET_MPC837XERDB=y
-CONFIG_DDR_MC_CLOCK_MODE_1_1=y
-CONFIG_SYSTEM_PLL_FACTOR_5_1=y
-CONFIG_CORE_PLL_RATIO_2_1=y
-CONFIG_PCI_HOST_MODE_ENABLE=y
-CONFIG_PCI_INT_ARBITER1_ENABLE=y
-CONFIG_BOOT_MEMORY_SPACE_LOW=y
-CONFIG_BOOT_ROM_INTERFACE_GPCM_16BIT=y
-CONFIG_TSEC1_MODE_RGMII=y
-CONFIG_TSEC2_MODE_RGMII=y
-CONFIG_LDP_PIN_MUX_STATE_0=y
-CONFIG_BAT0=y
-CONFIG_BAT0_NAME="SDRAM_LOWER"
-CONFIG_BAT0_BASE=0x00000000
-CONFIG_BAT0_LENGTH_256_MBYTES=y
-CONFIG_BAT0_ACCESS_RW=y
-CONFIG_BAT0_ICACHE_MEMORYCOHERENCE=y
-CONFIG_BAT0_DCACHE_MEMORYCOHERENCE=y
-CONFIG_BAT0_USER_MODE_VALID=y
-CONFIG_BAT0_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT1=y
-CONFIG_BAT1_NAME="SDRAM_UPPER"
-CONFIG_BAT1_BASE=0x10000000
-CONFIG_BAT1_LENGTH_256_MBYTES=y
-CONFIG_BAT1_ACCESS_RW=y
-CONFIG_BAT1_ICACHE_MEMORYCOHERENCE=y
-CONFIG_BAT1_DCACHE_MEMORYCOHERENCE=y
-CONFIG_BAT1_USER_MODE_VALID=y
-CONFIG_BAT1_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT2=y
-CONFIG_BAT2_NAME="IMMR"
-CONFIG_BAT2_BASE=0xE0000000
-CONFIG_BAT2_LENGTH_8_MBYTES=y
-CONFIG_BAT2_ACCESS_RW=y
-CONFIG_BAT2_ICACHE_INHIBITED=y
-CONFIG_BAT2_DCACHE_INHIBITED=y
-CONFIG_BAT2_DCACHE_GUARDED=y
-CONFIG_BAT2_USER_MODE_VALID=y
-CONFIG_BAT2_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT3=y
-CONFIG_BAT3_NAME="L2_SWITCH"
-CONFIG_BAT3_BASE=0xF0000000
-CONFIG_BAT3_ACCESS_RW=y
-CONFIG_BAT3_ICACHE_INHIBITED=y
-CONFIG_BAT3_DCACHE_INHIBITED=y
-CONFIG_BAT3_DCACHE_GUARDED=y
-CONFIG_BAT3_USER_MODE_VALID=y
-CONFIG_BAT3_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT4=y
-CONFIG_BAT4_NAME="FLASH"
-CONFIG_BAT4_BASE=0xFE000000
-CONFIG_BAT4_LENGTH_32_MBYTES=y
-CONFIG_BAT4_ACCESS_RW=y
-CONFIG_BAT4_ICACHE_MEMORYCOHERENCE=y
-CONFIG_BAT4_DCACHE_INHIBITED=y
-CONFIG_BAT4_DCACHE_GUARDED=y
-CONFIG_BAT4_USER_MODE_VALID=y
-CONFIG_BAT4_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT5=y
-CONFIG_BAT5_NAME="STACH_IN_DCACHE"
-CONFIG_BAT5_BASE=0xE6000000
-CONFIG_BAT5_ACCESS_RW=y
-CONFIG_BAT5_USER_MODE_VALID=y
-CONFIG_BAT5_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT6=y
-CONFIG_BAT6_NAME="PCI_MEM"
-CONFIG_BAT6_BASE=0x80000000
-CONFIG_BAT6_LENGTH_256_MBYTES=y
-CONFIG_BAT6_ACCESS_RW=y
-CONFIG_BAT6_ICACHE_MEMORYCOHERENCE=y
-CONFIG_BAT6_DCACHE_MEMORYCOHERENCE=y
-CONFIG_BAT6_USER_MODE_VALID=y
-CONFIG_BAT6_SUPERVISOR_MODE_VALID=y
-CONFIG_BAT7=y
-CONFIG_BAT7_NAME="PCI_MMIO"
-CONFIG_BAT7_BASE=0x90000000
-CONFIG_BAT7_LENGTH_256_MBYTES=y
-CONFIG_BAT7_ACCESS_RW=y
-CONFIG_BAT7_ICACHE_INHIBITED=y
-CONFIG_BAT7_DCACHE_INHIBITED=y
-CONFIG_BAT7_DCACHE_GUARDED=y
-CONFIG_BAT7_USER_MODE_VALID=y
-CONFIG_BAT7_SUPERVISOR_MODE_VALID=y
-CONFIG_LBLAW0=y
-CONFIG_LBLAW0_BASE=0xFE000000
-CONFIG_LBLAW0_NAME="FLASH"
-CONFIG_LBLAW0_LENGTH_8_MBYTES=y
-CONFIG_LBLAW1=y
-CONFIG_LBLAW1_BASE=0xE0600000
-CONFIG_LBLAW1_NAME="NAND"
-CONFIG_LBLAW1_LENGTH_32_KBYTES=y
-CONFIG_LBLAW2=y
-CONFIG_LBLAW2_BASE=0xF0000000
-CONFIG_LBLAW2_NAME="VSC7385"
-CONFIG_LBLAW2_LENGTH_128_KBYTES=y
-CONFIG_HID0_FINAL_EMCP=y
-CONFIG_HID0_FINAL_ICE=y
-CONFIG_HID2_HBE=y
-CONFIG_ACR_PIPE_DEP_4=y
-CONFIG_ACR_RPTCNT_4=y
-CONFIG_SPCR_TSECEP_3=y
-CONFIG_LCRR_DBYP_PLL_BYPASSED=y
-CONFIG_LCRR_CLKDIV_8=y
-CONFIG_FSL_SERDES=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_DEBUG_UART=y
-CONFIG_BOOTDELAY=6
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_MISC_INIT_R=y
-CONFIG_PCI_INIT_R=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="TSEC0"
-CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="mpc837x_rdb"
-CONFIG_USE_ROOTPATH=y
-CONFIG_ROOTPATH="/nfsroot"
-CONFIG_SATA=y
-CONFIG_FSL_SATA=y
-CONFIG_SYS_SATA_MAX_DEVICE=2
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFE001001
-CONFIG_SYS_OR0_PRELIM=0xFF800193
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xE0600C21
-CONFIG_SYS_OR1_PRELIM=0xFFFF8396
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xF0000801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_I2C_SLAVE=0x7F
-CONFIG_SYS_I2C_SPEED=400000
-CONFIG_FSL_ESDHC=y
-CONFIG_FSL_ESDHC_PIN_MUX=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_FLASH_SHOW_PROGRESS=0
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_SYS_FLASH_PROTECTION=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_MAX_FLASH_SECT=256
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_RGMII=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_RTC_DS1374=y
-CONFIG_SPECIFY_CONSOLE_INDEX=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
diff --git a/include/configs/MPC837XERDB.h b/include/configs/MPC837XERDB.h
deleted file mode 100644
index b22c720d07f..00000000000
--- a/include/configs/MPC837XERDB.h
+++ /dev/null
@@ -1,218 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2007 Freescale Semiconductor, Inc.
- * Kevin Lam <kevin.lam@freescale.com>
- * Joe D'Abbraccio <joe.d'abbraccio@freescale.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include <linux/stringify.h>
-
-/*
- * High Level Configuration Options
- */
-
-/* System performance - define the value i.e. CONFIG_SYS_XXX
-*/
-
-/* System Clock Configuration Register */
-#define CFG_SYS_SCCR_TSEC1CM	1		/* eTSEC1 clock mode (0-3) */
-#define CFG_SYS_SCCR_TSEC2CM	1		/* eTSEC2 clock mode (0-3) */
-#define CFG_SYS_SCCR_SATACM	SCCR_SATACM_2	/* SATA1-4 clock mode (0-3) */
-
-/*
- * System IO Config
- */
-#define CFG_SYS_SICRH		0x08200000
-#define CFG_SYS_SICRL		0x00000000
-
-/*
- * Output Buffer Impedance
- */
-#define CFG_SYS_OBIR		0x30100000
-
-/*
- * Device configurations
- */
-
-/* Vitesse 7385 */
-
-#ifdef CONFIG_VSC7385_ENET
-
-/* The flash address and size of the VSC7385 firmware image */
-#define CFG_VSC7385_IMAGE		0xFE7FE000
-#define CFG_VSC7385_IMAGE_SIZE	8192
-
-#endif
-
-/*
- * DDR Setup
- */
-#define CFG_SYS_SDRAM_BASE		0x00000000 /* DDR is system memory */
-#define CFG_SYS_DDR_SDRAM_CLK_CNTL	0x03000000
-
-#define CFG_SYS_DDRCDR_VALUE	(DDRCDR_DHC_EN | DDRCDR_ODT | DDRCDR_Q_DRN)
-
-/*
- * Manually set up DDR parameters
- */
-#define CFG_SYS_SDRAM_SIZE		0x10000000 /* 256 MiB */
-#define CFG_SYS_DDR_CS0_BNDS		0x0000000f
-#define CFG_SYS_DDR_CS0_CONFIG	(CSCONFIG_EN \
-					| CSCONFIG_ODT_WR_ONLY_CURRENT \
-					| CSCONFIG_ROW_BIT_13 \
-					| CSCONFIG_COL_BIT_10)
-
-#define CFG_SYS_DDR_TIMING_3	0x00000000
-#define CFG_SYS_DDR_TIMING_0	((0 << TIMING_CFG0_RWT_SHIFT) \
-				| (0 << TIMING_CFG0_WRT_SHIFT) \
-				| (0 << TIMING_CFG0_RRT_SHIFT) \
-				| (0 << TIMING_CFG0_WWT_SHIFT) \
-				| (2 << TIMING_CFG0_ACT_PD_EXIT_SHIFT) \
-				| (6 << TIMING_CFG0_PRE_PD_EXIT_SHIFT) \
-				| (8 << TIMING_CFG0_ODT_PD_EXIT_SHIFT) \
-				| (2 << TIMING_CFG0_MRS_CYC_SHIFT))
-				/* 0x00260802 */ /* DDR400 */
-#define CFG_SYS_DDR_TIMING_1	((3 << TIMING_CFG1_PRETOACT_SHIFT) \
-				| (9 << TIMING_CFG1_ACTTOPRE_SHIFT) \
-				| (3 << TIMING_CFG1_ACTTORW_SHIFT) \
-				| (7 << TIMING_CFG1_CASLAT_SHIFT) \
-				| (13 << TIMING_CFG1_REFREC_SHIFT) \
-				| (3 << TIMING_CFG1_WRREC_SHIFT) \
-				| (2 << TIMING_CFG1_ACTTOACT_SHIFT) \
-				| (2 << TIMING_CFG1_WRTORD_SHIFT))
-				/* 0x3937d322 */
-#define CFG_SYS_DDR_TIMING_2	((0 << TIMING_CFG2_ADD_LAT_SHIFT) \
-				| (5 << TIMING_CFG2_CPO_SHIFT) \
-				| (3 << TIMING_CFG2_WR_LAT_DELAY_SHIFT) \
-				| (2 << TIMING_CFG2_RD_TO_PRE_SHIFT) \
-				| (3 << TIMING_CFG2_WR_DATA_DELAY_SHIFT) \
-				| (3 << TIMING_CFG2_CKE_PLS_SHIFT) \
-				| (8 << TIMING_CFG2_FOUR_ACT_SHIFT))
-				/* 0x02984cc8 */
-
-#define CFG_SYS_DDR_INTERVAL	((1024 << SDRAM_INTERVAL_REFINT_SHIFT) \
-				| (0 << SDRAM_INTERVAL_BSTOPRE_SHIFT))
-				/* 0x06090100 */
-
-#define CFG_SYS_DDR_SDRAM_CFG	(SDRAM_CFG_SREN \
-					| SDRAM_CFG_SDRAM_TYPE_DDR2)
-					/* 0x43000000 */
-#define CFG_SYS_DDR_SDRAM_CFG2	0x00001000 /* 1 posted refresh */
-#define CFG_SYS_DDR_MODE		((0x0406 << SDRAM_MODE_ESD_SHIFT) \
-					| (0x0442 << SDRAM_MODE_SD_SHIFT))
-					/* 0x04400442 */ /* DDR400 */
-#define CFG_SYS_DDR_MODE2		0x00000000
-
-/*
- * Memory test
- */
-#undef CFG_SYS_DRAM_TEST		/* memory test, takes time */
-
-/*
- * The reserved memory
- */
-
-/*
- * Initial RAM Base Address Setup
- */
-#define CFG_SYS_INIT_RAM_ADDR	0xE6000000 /* Initial RAM address */
-#define CFG_SYS_INIT_RAM_SIZE	0x1000 /* Size of used area in RAM */
-
-/*
- * FLASH on the Local Bus
- */
-#define CFG_SYS_FLASH_BASE		0xFE000000 /* FLASH base address */
-#define CFG_SYS_FLASH_SIZE		8 /* max FLASH size is 32M */
-
-/*
- * NAND Flash on the Local Bus
- */
-#define CFG_SYS_NAND_BASE	0xE0600000
-
-/* Vitesse 7385 */
-
-#define CFG_SYS_VSC7385_BASE	0xF0000000
-
-#define CFG_SYS_BAUDRATE_TABLE \
-		{300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 115200}
-
-#define CFG_SYS_NS16550_COM1	(CONFIG_SYS_IMMR+0x4500)
-#define CFG_SYS_NS16550_COM2	(CONFIG_SYS_IMMR+0x4600)
-
-/* SERDES */
-#define CFG_FSL_SERDES1	0xe3000
-#define CFG_FSL_SERDES2	0xe3100
-
-/* I2C */
-#define CFG_SYS_I2C_NOPROBES		{ {0, 0x51} }
-
-/*
- * Config on-board RTC
- */
-#define CFG_SYS_I2C_RTC_ADDR	0x68 /* at address 0x68 */
-
-/*
- * General PCI
- * Addresses are mapped 1-1.
- */
-#define CFG_SYS_PCIE1_CFG_BASE	0xA0000000
-#define CFG_SYS_PCIE1_CFG_SIZE	0x08000000
-#define CFG_SYS_PCIE1_MEM_PHYS	0xA8000000
-#define CFG_SYS_PCIE1_IO_PHYS	0xB8000000
-
-#define CFG_SYS_PCIE2_CFG_BASE	0xC0000000
-#define CFG_SYS_PCIE2_CFG_SIZE	0x08000000
-#define CFG_SYS_PCIE2_MEM_PHYS	0xC8000000
-#define CFG_SYS_PCIE2_IO_PHYS	0xD8000000
-
-#ifdef CONFIG_MMC
-#define CFG_SYS_FSL_ESDHC_ADDR	CFG_SYS_MPC83xx_ESDHC_ADDR
-#endif
-
-/*
- * Miscellaneous configurable options
- */
-
-/*
- * For booting Linux, the board info and command line data
- * have to be in the first 256 MB of memory, since this is
- * the maximum mapped by the Linux kernel during initialization.
- */
-#define CFG_SYS_BOOTMAPSZ	(256 << 20) /* Initial Memory map for Linux */
-
-/*
- * Environment Configuration
- */
-
-#define FDTFILE			"mpc8379_rdb.dtb"
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"netdev=eth1\0"				\
-	"uboot=" CONFIG_UBOOTPATH "\0"					\
-	"tftpflash=tftp $loadaddr $uboot;"				\
-		"protect off " __stringify(CONFIG_TEXT_BASE)	\
-			" +$filesize; "	\
-		"erase " __stringify(CONFIG_TEXT_BASE)		\
-			" +$filesize; "	\
-		"cp.b $loadaddr " __stringify(CONFIG_TEXT_BASE)	\
-			" $filesize; "	\
-		"protect on " __stringify(CONFIG_TEXT_BASE)		\
-			" +$filesize; "	\
-		"cmp.b $loadaddr " __stringify(CONFIG_TEXT_BASE)	\
-			" $filesize\0"	\
-	"fdtaddr=780000\0"						\
-	"fdtfile=" FDTFILE "\0"					\
-	"ramdiskaddr=1000000\0"						\
-	"ramdiskfile=rootfs.ext2.gz.uboot\0"				\
-	"console=ttyS0\0"						\
-	"setbootargs=setenv bootargs "					\
-		"root=$rootdev rw console=$console,$baudrate $othbootargs\0" \
-	"setipargs=setenv bootargs nfsroot=$serverip:$rootpath "	\
-		"ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:"	\
-							"$netdev:off "	\
-		"root=$rootdev rw console=$console,$baudrate $othbootargs\0"
-
-#endif	/* __CONFIG_H */
-- 
2.47.3

