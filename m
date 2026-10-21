Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DF606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xDwZQZpX;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=TWCfIB+5;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=AQpddXYN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56A4B60AE4;
	Wed, 21 Oct 2026 16:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rgB1U-ecPSzz; Wed, 21 Oct 2026 16:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D447C60AF4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599411;
	b=Lip04cRU8BXihKrk3vheaSW0/TJU1B3zt4MMgoEMvine96h88MuL+elPdKEkFcfWASSd
	 1APu0JBCc9h4tGhr/e3MHZfJQrEyc6o9RSUuzDrIlKAK2Ra+Jw4MlikeG2UcUUL34yM10
	 EpfMDTDjqXVqVzasyO2pmhl/gMb8rVYXOIh74ddX7Dt80XPrWY8WaOznfCiW1kxDPVseN
	 ZeED954tDdDWeou9OTh1I7QT0iuBWXOYnUpbuYnTCQ5cb6Nlo98yNh3kiuDbYrl5FZS5o
	 xwzkqcQGh4CAmkTTe+l6UklA6Un95j1rk04ExeRIhl0k+M/ak5lMExQMfNf1+F4AHyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XkwnmZk9jx/5JdhAGMGK/JVoU51Bbt+kXtCZKts8lfI=;
	b=ey3z7fBi7PzMIaZVD5t3ac2Be0+C4cYQfHirY+4GsiqAh17MgfVbFThAde4PLpnme5TC
	 Kp0t5lCXa73HhTJeMO4+YrogQ1dhhLrKrYB6AfmKLqy92QdkVQNTC0w4tBGT2K/rCDOzA
	 DE/mgrQkCEOKBPg7EXZjDHKf+pVDnqEnqbiwZm8K8pjJYE6dwltOWz3WD5jg4n/P3RoKI
	 8EBh8bQyqupaskqH5zqpVXW0YMDsM6gR90ExjFSwP+wF6QQaGA5UHV8AzPEP+jsLEnRc4
	 r4gVtmVkUWbGHDVMaVrpt2aFpOyEXtL7NCKpO5CvFzNMQUdRoDS+tKzNFJdGTfoQg8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=TWCfIB+5;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=AQpddXYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599411;
	bh=XkwnmZk9jx/5JdhAGMGK/JVoU51Bbt+kXtCZKts8lfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDwZQZpX4Kms76A5TcQAStRFwVgPx1rX02C3iN7d2Ku5nFpkNwZZ4/MY7bYRyoe5P
	 32aUCFbLthnXOVetIFnFG74nFNjjUg30aTfQeNq7aDdIHxeBcelAU8/SoWPKPbRxQe
	 yhwwtz12vycDsUWmfLVxwhCLNLIQquWvFGi/VCSTnHVRvCaovEhkf+daQKAuFjut5d
	 ctZKB2XC4e4SdMu4El63qTqSvXxE0YTOQh1dQo+t3YBVan6+zb7Pn1uVheFNdVm6lE
	 3yKQbFl9px4Ac1IMSbqSFSe+pm5K1PFPiQczAS7MMftK2wZoYDe7hCWecJnGDfnix1
	 LrP/nnZ5AdPOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D447C60AF4;
	Wed, 21 Oct 2026 16:16:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id D33B01E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id B956D60852
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id RAE7ECP4xbSw for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A521F60844
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598521;
 b=UtZ44NzbTjQ29qBDIFKEtX6jGa/j//HdFFlkL1t9JeDeH9GpqwdBdfLLQUv+Z5Bl+rRO
 wSQTE3RYgpJ9ACrfTAIVpQRanYqGynOO/gaBJdmSdQXHrS+I+fHVesD++uyo62jLTxuvk
 d7L1vlx53g8pOm5F6wT2OZ7qdUlL72HMlckuTCN0rR/LAsIIF63OJMFsX+BkHHJd92E9s
 av9xr45P1ZdtGeSr3v2vmMLGrq8Nw38nDy8F2pdgCpAQfuKfSiYwGVLs/CZE+Utm/cGFX
 ju5Ux7tB7/fxyriOK5Z0dLgHpg3EqGyjFBxX/9LYmq9PdC+ha9smGeiCA2f/haQO/MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598521;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XkwnmZk9jx/5JdhAGMGK/JVoU51Bbt+kXtCZKts8lfI=;
 b=R4VHG4EXLhBredynGDR4nLibgt3Vc84ZvnmS4nM73m6aI/x/f9H6SOrm/ImYwsqh6giI
 9QaNebUB3aqjkjNHrzrzO5kUvAKL/Pw0KjdDDG2d+tXt46aUG2pcPNYIfDv/ZACXxpRFx
 IqfI8LFRBsElJMrDAuOqPdmyFhCHKYvd7nvyubycWzt6JYMjhLkogiber9TfDn71op43O
 aoR4HzjEW7uupIiS6CuU0vwWgJhcCpMsXZiBhirzAjgPu/XS1PxmTW5s7Y6uy+NZ7qiPv
 fyv6I7qXg0PIGAV53NUAZsB00DGkBG2xwjd3sEaXnJ0AYbfD2ZvO+Nz5chg/c4hC6Hw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=TWCfIB+5; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=AQpddXYN; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=TWCfIB+5; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=AQpddXYN
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id A521F60844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598507; bh=XkwnmZk9jx/5JdhAGMGK/JV
 oU51Bbt+kXtCZKts8lfI=; b=TWCfIB+5YukcxsCNnaZz3rKpVlOlDnuKdVC9seis5W3ISxgIhE
 hKILyh+oAK9WXctk0KVS64F/mBA/nIC0OmpUU4QK1jIqUUugWudz72LDHtXNqmgtrABNrrRNIVf
 34jsDzrtMPcBOGYVCO9TTtHmANISeaHLyngYdxxydQm8SmaEMdcRWLo+cpjMlG3isC1suc9iCJt
 I/lQOBtbBxmxG4pC8CsfTjIxcrDuFkpYI60aBDE2nAfANosrP6EckS4AbYccBtLwrBmAA5mn6Km
 h8thc+4OlsFzgaR5T4Vtsa4nNVskkf6kOoa6FCNLAZdrzijdgki+Bt2sawlIOvbloMg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598507; bh=XkwnmZk9jx/5JdhAGMGK/JV
 oU51Bbt+kXtCZKts8lfI=; b=AQpddXYND2XBHxT8gjVVzCB7w5C9uACjz8bQld9pF3pjgaQkH5
 IQNMjtPuwwCcADhjQfaoxAl41TujTYUvUFDA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 06/26] board: powerpc: Remove P5040DS support
Date: Wed, 21 Oct 2026 16:01:02 +0000
Message-ID: <20261021160145.10430-7-brads@mainlining.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The P5040DS board is unmaintained and lacks active community testing.
Drop the target, device trees, and its PIXIS support.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig   |  13 --
 arch/powerpc/dts/Makefile          |   1 -
 arch/powerpc/dts/p5040.dtsi        | 137 --------------
 arch/powerpc/dts/p5040ds.dts       | 281 -----------------------------
 arch/powerpc/dts/p5040si-post.dtsi |  70 -------
 board/nxp/common/Makefile          |   5 -
 board/nxp/common/ics307_clk.c      | 149 ---------------
 board/nxp/common/ics307_clk.h      |  14 --
 board/nxp/common/ngpixis.c         | 247 -------------------------
 board/nxp/common/ngpixis.h         |  60 ------
 10 files changed, 977 deletions(-)
 delete mode 100644 arch/powerpc/dts/p5040.dtsi
 delete mode 100644 arch/powerpc/dts/p5040ds.dts
 delete mode 100644 arch/powerpc/dts/p5040si-post.dtsi
 delete mode 100644 board/nxp/common/ics307_clk.c
 delete mode 100644 board/nxp/common/ics307_clk.h
 delete mode 100644 board/nxp/common/ngpixis.c
 delete mode 100644 board/nxp/common/ngpixis.h

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 5e480325062..8a37191bea0 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -87,16 +87,6 @@ config TARGET_SOCRATES
 	select ARCH_MPC8544
 	select BINMAN
 
-config TARGET_P5040DS
-	bool "Support P5040DS"
-	select PHYS_64BIT
-	select ARCH_P5040
-	select BOARD_LATE_INIT if CHAIN_OF_TRUST
-	select FSL_NGPIXIS
-	select SYS_FSL_RAID_ENGINE
-	imply SATA
-	imply PANIC_HANG
-
 config TARGET_P1010RDB_PA
 	bool "Support P1010RDB_PA"
 	select ARCH_P1010
@@ -1392,9 +1382,6 @@ config FSL_CORENET
 	bool
 	select SYS_FSL_CPC
 
-config FSL_NGPIXIS
-	bool
-
 config SYS_CPC_REINIT_F
 	bool
 	help
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 09b79faf165..3f5473b80af 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
-dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
 dtb-$(CONFIG_TARGET_T1024RDB) += t1024rdb.dtb
 dtb-$(CONFIG_TARGET_T1042D4RDB) += t1042d4rdb.dtb
diff --git a/arch/powerpc/dts/p5040.dtsi b/arch/powerpc/dts/p5040.dtsi
deleted file mode 100644
index 10402cf2224..00000000000
--- a/arch/powerpc/dts/p5040.dtsi
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P5040 Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2012 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-/include/ "e5500_power_isa.dtsi"
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: PowerPC,e5500@0 {
-			device_type = "cpu";
-			reg = <0>;
-			fsl,portid-mapping = <0x80000000>;
-		};
-		cpu1: PowerPC,e5500@1 {
-			device_type = "cpu";
-			reg = <1>;
-			fsl,portid-mapping = <0x40000000>;
-		};
-		cpu2: PowerPC,e5500@2 {
-			device_type = "cpu";
-			reg = <2>;
-			fsl,portid-mapping = <0x20000000>;
-		};
-		cpu3: PowerPC,e5500@3 {
-			device_type = "cpu";
-			reg = <3>;
-			fsl,portid-mapping = <0x10000000>;
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
-		usb@210000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		usb@211000 {
-			compatible = "fsl-usb2-dr";
-			reg = <0x211000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		sata: sata@220000 {
-			compatible = "fsl,pq-sata-v2";
-			reg = <0x220000 0x1000>;
-			interrupts = <68 0x2 0 0>;
-			sata-offset = <0x1000>;
-			sata-number = <2>;
-			sata-fpdma = <0>;
-		};
-
-		esdhc: esdhc@114000 {
-			compatible = "fsl,esdhc";
-			reg = <0x114000 0x1000>;
-			clock-frequency = <0>;
-		};
-
-		/include/ "qoriq-i2c-0.dtsi"
-		/include/ "qoriq-i2c-1.dtsi"
-	};
-
-	pcie@ffe200000 {
-		compatible = "fsl,pcie-p5040", "fsl,pcie-fsl-qoriq";
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
-		compatible = "fsl,pcie-p5040", "fsl,pcie-fsl-qoriq";
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
-		compatible = "fsl,pcie-p5040", "fsl,pcie-fsl-qoriq";
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
diff --git a/arch/powerpc/dts/p5040ds.dts b/arch/powerpc/dts/p5040ds.dts
deleted file mode 100644
index c2ec765d3e4..00000000000
--- a/arch/powerpc/dts/p5040ds.dts
+++ /dev/null
@@ -1,281 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P5040DS Device Tree Source
- *
- * Copyright 2012 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/include/ "p5040.dtsi"
-
-/ {
-	model = "fsl,P5040DS";
-	compatible = "fsl,P5040DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases{
-		phy_sgmii_slot2_1c = &phy_sgmii_slot2_1c;
-		phy_sgmii_slot2_1d = &phy_sgmii_slot2_1d;
-		phy_sgmii_slot2_1e = &phy_sgmii_slot2_1e;
-		phy_sgmii_slot2_1f = &phy_sgmii_slot2_1f;
-		phy_sgmii_slot3_1c = &phy_sgmii_slot3_1c;
-		phy_sgmii_slot3_1d = &phy_sgmii_slot3_1d;
-		phy_sgmii_slot3_1e = &phy_sgmii_slot3_1e;
-		phy_sgmii_slot3_1f = &phy_sgmii_slot3_1f;
-		phy_sgmii_slot5_1c = &phy_sgmii_slot5_1c;
-		phy_sgmii_slot5_1d = &phy_sgmii_slot5_1d;
-		phy_sgmii_slot5_1e = &phy_sgmii_slot5_1e;
-		phy_sgmii_slot5_1f = &phy_sgmii_slot5_1f;
-		phy_sgmii_slot6_1c = &phy_sgmii_slot6_1c;
-		phy_sgmii_slot6_1d = &phy_sgmii_slot6_1d;
-		phy_sgmii_slot6_1e = &phy_sgmii_slot6_1e;
-		phy_sgmii_slot6_1f = &phy_sgmii_slot6_1f;
-		hydra_rg = &hydra_rg;
-		hydra_sg_slot2 = &hydra_sg_slot2;
-		hydra_sg_slot3 = &hydra_sg_slot3;
-		hydra_sg_slot5 = &hydra_sg_slot5;
-		hydra_sg_slot6 = &hydra_sg_slot6;
-		hydra_xg_slot1 = &hydra_xg_slot1;
-		hydra_xg_slot2 = &hydra_xg_slot2;
-		spi0 = &espi0;
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-
-		fman@400000 {
-			ethernet@e0000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e2000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e8000 {
-				phy-handle = <&phy_rgmii_0>;
-				phy-connection-type = "rgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy_xgmii_slot_2>;
-				phy-connection-type = "xgmii";
-			};
-		};
-
-		fman@500000 {
-			ethernet@e0000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e2000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e8000 {
-				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy_xgmii_slot_1>;
-				phy-connection-type = "xgmii";
-			};
-		};
-	};
-
-	lbc: localbus@ffe124000 {
-		reg = <0xf 0xfe124000 0 0x1000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000
-			  2 0 0xf 0xffa00000 0x00040000
-			  3 0 0xf 0xffdf0000 0x00008000>;
-
-		board-control@3,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p5040ds-fpga", "fsl,fpga-ngpixis";
-			reg = <3 0 0x40>;
-			ranges = <0 3 0 0x40>;
-
-			mdio-mux-emi1 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "mdio-mux-mmioreg", "mdio-mux";
-				mdio-parent-bus = <&mdio0>;
-				reg = <9 1>;
-				mux-mask = <0x78>;
-
-				hydra_rg:rgmii-mdio@8 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <8>;
-					status = "disabled";
-
-					phy_rgmii_0: ethernet-phy@0 {
-						reg = <0x0>;
-					};
-
-					phy_rgmii_1: ethernet-phy@1 {
-						reg = <0x1>;
-					};
-				};
-
-				hydra_sg_slot2: sgmii-mdio@28 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0x28>;
-					status = "disabled";
-
-					phy_sgmii_slot2_1c: ethernet-phy@1c {
-						reg = <0x1c>;
-					};
-
-					phy_sgmii_slot2_1d: ethernet-phy@1d {
-						reg = <0x1d>;
-					};
-
-					phy_sgmii_slot2_1e: ethernet-phy@1e {
-						reg = <0x1e>;
-					};
-
-					phy_sgmii_slot2_1f: ethernet-phy@1f {
-						reg = <0x1f>;
-					};
-				};
-
-				hydra_sg_slot3: sgmii-mdio@68 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0x68>;
-					status = "disabled";
-
-					phy_sgmii_slot3_1c: ethernet-phy@1c {
-						reg = <0x1c>;
-					};
-
-					phy_sgmii_slot3_1d: ethernet-phy@1d {
-						reg = <0x1d>;
-					};
-
-					phy_sgmii_slot3_1e: ethernet-phy@1e {
-						reg = <0x1e>;
-					};
-
-					phy_sgmii_slot3_1f: ethernet-phy@1f {
-						reg = <0x1f>;
-					};
-				};
-
-				hydra_sg_slot5: sgmii-mdio@38 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0x38>;
-					status = "disabled";
-
-					phy_sgmii_slot5_1c: ethernet-phy@1c {
-						reg = <0x1c>;
-					};
-
-					phy_sgmii_slot5_1d: ethernet-phy@1d {
-						reg = <0x1d>;
-					};
-
-					phy_sgmii_slot5_1e: ethernet-phy@1e {
-						reg = <0x1e>;
-					};
-
-					phy_sgmii_slot5_1f: ethernet-phy@1f {
-						reg = <0x1f>;
-					};
-				};
-				hydra_sg_slot6: sgmii-mdio@48 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0x48>;
-					status = "disabled";
-
-					phy_sgmii_slot6_1c: ethernet-phy@1c {
-						reg = <0x1c>;
-					};
-
-					phy_sgmii_slot6_1d: ethernet-phy@1d {
-						reg = <0x1d>;
-					};
-
-					phy_sgmii_slot6_1e: ethernet-phy@1e {
-						reg = <0x1e>;
-					};
-
-					phy_sgmii_slot6_1f: ethernet-phy@1f {
-						reg = <0x1f>;
-					};
-				};
-			};
-
-			mdio-mux-emi2 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "mdio-mux-mmioreg", "mdio-mux";
-				mdio-parent-bus = <&xmdio0>;
-				reg = <9 1>;
-				mux-mask = <0x06>;
-
-				hydra_xg_slot1: hydra-xg-slot1@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-					status = "disabled";
-
-					phy_xgmii_slot_1: ethernet-phy@0 {
-						compatible = "ethernet-phy-ieee802.3-c45";
-						reg = <4>;
-					};
-				};
-
-				hydra_xg_slot2: hydra-xg-slot2@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-
-					phy_xgmii_slot_2: ethernet-phy@4 {
-						compatible = "ethernet-phy-ieee802.3-c45";
-						reg = <0>;
-					};
-				};
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
-/include/ "p5040si-post.dtsi"
diff --git a/arch/powerpc/dts/p5040si-post.dtsi b/arch/powerpc/dts/p5040si-post.dtsi
deleted file mode 100644
index fae3ed31a5d..00000000000
--- a/arch/powerpc/dts/p5040si-post.dtsi
+++ /dev/null
@@ -1,70 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * P5040 Silicon/SoC Device Tree Source (post include)
- *
- * Copyright 2012 - 2015 Freescale Semiconductor Inc.
- * Copyright 2020 NXP
- *
- */
-
-&soc {
-
-/include/ "qoriq-clockgen1.dtsi"
-/include/ "qoriq-gpio-0.dtsi"
-/include/ "qoriq-sec5.2-0.dtsi"
-
-/* include used FMan blocks */
-/include/ "qoriq-fman-0.dtsi"
-/include/ "qoriq-fman-0-1g-0.dtsi"
-/include/ "qoriq-fman-0-1g-1.dtsi"
-/include/ "qoriq-fman-0-1g-2.dtsi"
-/include/ "qoriq-fman-0-1g-3.dtsi"
-/include/ "qoriq-fman-0-1g-4.dtsi"
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
-		enet4: ethernet@e8000 {
-		};
-
-		enet5: ethernet@f0000 {
-		};
-	};
-
-/include/ "qoriq-fman-1.dtsi"
-/include/ "qoriq-fman-1-1g-0.dtsi"
-/include/ "qoriq-fman-1-1g-1.dtsi"
-/include/ "qoriq-fman-1-1g-2.dtsi"
-/include/ "qoriq-fman-1-1g-3.dtsi"
-/include/ "qoriq-fman-1-1g-4.dtsi"
-/include/ "qoriq-fman-1-10g-0.dtsi"
-	fman@500000 {
-		enet6: ethernet@e0000 {
-		};
-
-		enet7: ethernet@e2000 {
-		};
-
-		enet8: ethernet@e4000 {
-		};
-
-		enet9: ethernet@e6000 {
-		};
-
-		enet10: ethernet@e8000 {
-		};
-
-		enet11: ethernet@f0000 {
-		};
-	};
-};
diff --git a/board/nxp/common/Makefile b/board/nxp/common/Makefile
index 8fd6d6ce8c2..8817fcf027d 100644
--- a/board/nxp/common/Makefile
+++ b/board/nxp/common/Makefile
@@ -28,9 +28,6 @@ endif
 
 obj-$(CONFIG_FSL_CADMUS)	+= cadmus.o
 obj-$(CONFIG_FMAN_ENET)	+= fman.o
-ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_FSL_NGPIXIS)	+= ngpixis.o
-endif
 obj-$(I2C_COMMON)		+= i2c_common.o
 obj-$(CONFIG_FSL_USE_PCA9547_MUX)		+= i2c_mux.o
 obj-$(CONFIG_$(PHASE_)VID)	+= vid.o
@@ -49,7 +46,6 @@ obj-$(CONFIG_DEEP_SLEEP)		+= mpc85xx_sleep.o
 endif
 
 
-obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
@@ -65,7 +61,6 @@ obj-$(CONFIG_EMC2305)              += emc2305.o
 
 # deal with common files for P-series corenet based devices
 obj-$(CONFIG_TARGET_P2041RDB)	+= p_corenet/
-obj-$(CONFIG_TARGET_P5040DS)	+= p_corenet/
 
 obj-$(CONFIG_LAYERSCAPE_NS_ACCESS)	+= ns_access.o
 
diff --git a/board/nxp/common/ics307_clk.c b/board/nxp/common/ics307_clk.c
deleted file mode 100644
index af30faa0c5f..00000000000
--- a/board/nxp/common/ics307_clk.c
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
- */
-
-#include <config.h>
-#include <clock_legacy.h>
-#include <log.h>
-#include <asm/io.h>
-
-#include "ics307_clk.h"
-
-#if defined(CONFIG_FSL_NGPIXIS)
-#include "ngpixis.h"
-#define fpga_reg pixis
-#elif defined(CONFIG_FSL_QIXIS)
-#include "qixis.h"
-#define fpga_reg ((struct qixis *)QIXIS_BASE)
-#else
-#include "pixis.h"
-#define fpga_reg pixis
-#endif
-
-/* define for SYS CLK or CLK1Frequency */
-#define TTL		1
-#define CLK2		0
-#define CRYSTAL		0
-#define MAX_VDW		(511 + 8)
-#define MAX_RDW		(127 + 2)
-#define MIN_VDW		(4 + 8)
-#define MIN_RDW		(1 + 2)
-#define NUM_OD_SETTING	8
-/*
- * These defines cover the industrial temperature range part,
- * for commercial, change below to 400000 and 55000, respectively
- */
-#define MAX_VCO		360000
-#define MIN_VCO		60000
-
-/* decode S[0-2] to Output Divider (OD) */
-static u8 ics307_s_to_od[] = {
-	10, 2, 8, 4, 5, 7, 3, 6
-};
-
-/*
- * Find one solution to generate required frequency for SYSCLK
- * out_freq: KHz, required frequency to the SYSCLK
- * the result will be retuned with component RDW, VDW, OD, TTL,
- * CLK2 and crystal
- */
-unsigned long ics307_sysclk_calculator(unsigned long out_freq)
-{
-	const unsigned long input_freq = CFG_ICS307_REFCLK_HZ;
-	unsigned long vdw, rdw, odp, s_vdw = 0, s_rdw = 0, s_odp = 0, od;
-	unsigned long tmp_out, diff, result = 0;
-	int found = 0;
-
-	for (odp = 0; odp < NUM_OD_SETTING; odp++) {
-		od = ics307_s_to_od[odp];
-		if (od * out_freq < MIN_VCO || od * out_freq > MAX_VCO)
-			continue;
-		for (rdw = MIN_RDW; rdw <= MAX_RDW; rdw++) {
-			/* Calculate the VDW */
-			vdw = out_freq * 1000 * od * rdw / (input_freq * 2);
-			if (vdw > MAX_VDW)
-				vdw = MAX_VDW;
-			if (vdw < MIN_VDW)
-				continue;
-			/* Calculate the temp out frequency */
-			tmp_out = input_freq * 2 * vdw / (rdw * od * 1000);
-			diff = max(out_freq, tmp_out) - min(out_freq, tmp_out);
-			/*
-			 * calculate the percent, the precision is 1/1000
-			 * If greater than 1/1000, continue
-			 * otherwise, we think the solution is we required
-			 */
-			if (diff * 1000 / out_freq > 1)
-				continue;
-			else {
-				s_vdw = vdw;
-				s_rdw = rdw;
-				s_odp = odp;
-				found = 1;
-				break;
-			}
-		}
-	}
-
-	if (found)
-		result = (s_rdw - 2) | (s_vdw - 8) << 7 | s_odp << 16 |
-			CLK2 << 19 | TTL << 21 | CRYSTAL << 22;
-
-	debug("ICS307-02: RDW: %ld, VDW: %ld, OD: %d\n", s_rdw - 2, s_vdw - 8,
-			ics307_s_to_od[s_odp]);
-	return result;
-}
-
-/*
- * Calculate frequency being generated by ICS307-02 clock chip based upon
- * the control bytes being programmed into it.
- */
-static unsigned long ics307_clk_freq(u8 cw0, u8 cw1, u8 cw2)
-{
-	const unsigned long input_freq = CFG_ICS307_REFCLK_HZ;
-	unsigned long vdw = ((cw1 << 1) & 0x1FE) + ((cw2 >> 7) & 1);
-	unsigned long rdw = cw2 & 0x7F;
-	unsigned long od = ics307_s_to_od[cw0 & 0x7];
-	unsigned long freq;
-
-	/*
-	 * CLK1 Freq = Input Frequency * 2 * (VDW + 8) / ((RDW + 2) * OD)
-	 *
-	 * cw0:  C1 C0 TTL F1 F0 S2 S1 S0
-	 * cw1:  V8 V7 V6 V5 V4 V3 V2 V1
-	 * cw2:  V0 R6 R5 R4 R3 R2 R1 R0
-	 *
-	 * R6:R0 = Reference Divider Word (RDW)
-	 * V8:V0 = VCO Divider Word (VDW)
-	 * S2:S0 = Output Divider Select (OD)
-	 * F1:F0 = Function of CLK2 Output
-	 * TTL = duty cycle
-	 * C1:C0 = internal load capacitance for cyrstal
-	 *
-	 */
-
-	freq = input_freq * 2 * (vdw + 8) / ((rdw + 2) * od);
-
-	debug("ICS307: CW[0-2]: %02X %02X %02X => %lu Hz\n", cw0, cw1, cw2,
-			freq);
-	return freq;
-}
-
-unsigned long get_board_sys_clk(void)
-{
-	return ics307_clk_freq(
-			in_8(&fpga_reg->sclk[0]),
-			in_8(&fpga_reg->sclk[1]),
-			in_8(&fpga_reg->sclk[2]));
-}
-
-#ifdef CONFIG_DYNAMIC_DDR_CLK_FREQ
-unsigned long get_board_ddr_clk(void)
-{
-	return ics307_clk_freq(
-			in_8(&fpga_reg->dclk[0]),
-			in_8(&fpga_reg->dclk[1]),
-			in_8(&fpga_reg->dclk[2]));
-}
-#endif
diff --git a/board/nxp/common/ics307_clk.h b/board/nxp/common/ics307_clk.h
deleted file mode 100644
index 163496930c8..00000000000
--- a/board/nxp/common/ics307_clk.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2010-2011 Freescale Semiconductor, Inc.
- */
-#ifndef __ICS_CLK_H_
-#define __ICS_CLK_H_	1
-
-#ifndef __ASSEMBLY__
-
-extern unsigned long get_board_sys_clk(void);
-extern unsigned long ics307_sysclk_calculator(unsigned long out_freq);
-#endif
-
-#endif	/* __ICS_CLK_H_ */
diff --git a/board/nxp/common/ngpixis.c b/board/nxp/common/ngpixis.c
deleted file mode 100644
index 74c345807e6..00000000000
--- a/board/nxp/common/ngpixis.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/**
- * Copyright 2010-2011 Freescale Semiconductor
- * Author: Timur Tabi <timur@freescale.com>
- *
- * This file provides support for the ngPIXIS, a board-specific FPGA used on
- * some Freescale reference boards.
- *
- * A "switch" is black rectangular block on the motherboard.  It contains
- * eight "bits".  The ngPIXIS has a set of memory-mapped registers (SWx) that
- * shadow the actual physical switches.  There is also another set of
- * registers (ENx) that tell the ngPIXIS which bits of SWx should actually be
- * used to override the values of the bits in the physical switches.
- *
- * The following macros need to be defined:
- *
- * PIXIS_BASE - The virtual address of the base of the PIXIS register map
- *
- * PIXIS_LBMAP_SWITCH - The switch number (i.e. the "x" in "SWx"). This value
- *    is used in the PIXIS_SW() macro to determine which offset in
- *    the PIXIS register map corresponds to the physical switch that controls
- *    the boot bank.
- *
- * PIXIS_LBMAP_MASK - A bit mask the defines which bits in SWx to use.
- *
- * PIXIS_LBMAP_SHIFT - The shift value that corresponds to PIXIS_LBMAP_MASK.
- *
- * PIXIS_LBMAP_ALTBANK - The value to program into SWx to tell the ngPIXIS to
- *    boot from the alternate bank.
- */
-
-#include <command.h>
-#include <asm/io.h>
-
-#include "ngpixis.h"
-
-static u8 __pixis_read(unsigned int reg)
-{
-	void *p = (void *)PIXIS_BASE;
-
-	return in_8(p + reg);
-}
-u8 pixis_read(unsigned int reg) __attribute__((weak, alias("__pixis_read")));
-
-static void __pixis_write(unsigned int reg, u8 value)
-{
-	void *p = (void *)PIXIS_BASE;
-
-	out_8(p + reg, value);
-}
-void pixis_write(unsigned int reg, u8 value)
-	__attribute__((weak, alias("__pixis_write")));
-
-/*
- * Reset the board. This ignores the ENx registers.
- */
-void __pixis_reset(void)
-{
-	PIXIS_WRITE(rst, 0);
-
-	while (1);
-}
-void pixis_reset(void) __attribute__((weak, alias("__pixis_reset")));
-
-/*
- * Reset the board.  Like pixis_reset(), but it honors the ENx registers.
- */
-void __pixis_bank_reset(void)
-{
-	PIXIS_WRITE(vctl, 0);
-	PIXIS_WRITE(vctl, 1);
-
-	while (1);
-}
-void pixis_bank_reset(void) __attribute__((weak, alias("__pixis_bank_reset")));
-
-/**
- * Set the boot bank to the power-on default bank
- */
-void __clear_altbank(void)
-{
-	u8 reg;
-
-	/* Tell the ngPIXIS to use this the bits in the physical switch for the
-	 * boot bank value, instead of the SWx register.  We need to be careful
-	 * only to set the bits in SWx that correspond to the boot bank.
-	 */
-	reg = PIXIS_READ(s[PIXIS_LBMAP_SWITCH - 1].en);
-	reg &= ~PIXIS_LBMAP_MASK;
-	PIXIS_WRITE(s[PIXIS_LBMAP_SWITCH - 1].en, reg);
-}
-void clear_altbank(void) __attribute__((weak, alias("__clear_altbank")));
-
-/**
- * Set the boot bank to the alternate bank
- */
-void __set_altbank(void)
-{
-	u8 reg;
-
-	/* Program the alternate bank number into the SWx register.
-	 */
-	reg = PIXIS_READ(s[PIXIS_LBMAP_SWITCH - 1].sw);
-	reg = (reg & ~PIXIS_LBMAP_MASK) | PIXIS_LBMAP_ALTBANK;
-	PIXIS_WRITE(s[PIXIS_LBMAP_SWITCH - 1].sw, reg);
-
-	/* Tell the ngPIXIS to use this the bits in the SWx register for the
-	 * boot bank value, instead of the physical switch.  We need to be
-	 * careful only to set the bits in SWx that correspond to the boot bank.
-	 */
-	reg = PIXIS_READ(s[PIXIS_LBMAP_SWITCH - 1].en);
-	reg |= PIXIS_LBMAP_MASK;
-	PIXIS_WRITE(s[PIXIS_LBMAP_SWITCH - 1].en, reg);
-}
-void set_altbank(void) __attribute__((weak, alias("__set_altbank")));
-
-#ifdef DEBUG
-static void pixis_dump_regs(void)
-{
-	unsigned int i;
-
-	printf("id=%02x\n", PIXIS_READ(id));
-	printf("arch=%02x\n", PIXIS_READ(arch));
-	printf("scver=%02x\n", PIXIS_READ(scver));
-	printf("csr=%02x\n", PIXIS_READ(csr));
-	printf("rst=%02x\n", PIXIS_READ(rst));
-	printf("aux=%02x\n", PIXIS_READ(aux));
-	printf("spd=%02x\n", PIXIS_READ(spd));
-	printf("brdcfg0=%02x\n", PIXIS_READ(brdcfg0));
-	printf("brdcfg1=%02x\n", PIXIS_READ(brdcfg1));
-	printf("addr=%02x\n", PIXIS_READ(addr));
-	printf("data=%02x\n", PIXIS_READ(data));
-	printf("led=%02x\n", PIXIS_READ(led));
-	printf("vctl=%02x\n", PIXIS_READ(vctl));
-	printf("vstat=%02x\n", PIXIS_READ(vstat));
-	printf("vcfgen0=%02x\n", PIXIS_READ(vcfgen0));
-	printf("ocmcsr=%02x\n", PIXIS_READ(ocmcsr));
-	printf("ocmmsg=%02x\n", PIXIS_READ(ocmmsg));
-	printf("gmdbg=%02x\n", PIXIS_READ(gmdbg));
-	printf("sclk=%02x%02x%02x\n",
-	       PIXIS_READ(sclk[0]), PIXIS_READ(sclk[1]), PIXIS_READ(sclk[2]));
-	printf("dclk=%02x%02x%02x\n",
-	       PIXIS_READ(dclk[0]), PIXIS_READ(dclk[1]), PIXIS_READ(dclk[2]));
-	printf("watch=%02x\n", PIXIS_READ(watch));
-
-	for (i = 0; i < 8; i++) {
-		printf("SW%u=%02x/%02x ", i + 1,
-			PIXIS_READ(s[i].sw), PIXIS_READ(s[i].en));
-	}
-	putc('\n');
-}
-#endif
-
-void pixis_sysclk_set(unsigned long sysclk)
-{
-	unsigned long freq_word;
-	u8 sclk0, sclk1, sclk2;
-
-	freq_word = ics307_sysclk_calculator(sysclk);
-	sclk2 = freq_word & 0xff;
-	sclk1 = (freq_word >> 8) & 0xff;
-	sclk0 = (freq_word >> 16) & 0xff;
-
-	/* set SYSCLK enable bit */
-	PIXIS_WRITE(vcfgen0, 0x01);
-
-	/* SYSCLK to required frequency */
-	PIXIS_WRITE(sclk[0], sclk0);
-	PIXIS_WRITE(sclk[1], sclk1);
-	PIXIS_WRITE(sclk[2], sclk2);
-}
-
-int pixis_reset_cmd(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[])
-{
-	unsigned int i;
-	unsigned long sysclk;
-	char *p_altbank = NULL;
-#ifdef DEBUG
-	char *p_dump = NULL;
-#endif
-	char *unknown_param = NULL;
-
-	/* No args is a simple reset request.
-	 */
-	if (argc <= 1)
-		pixis_reset();
-
-	for (i = 1; i < argc; i++) {
-		if (strcmp(argv[i], "altbank") == 0) {
-			p_altbank = argv[i];
-			continue;
-		}
-
-#ifdef DEBUG
-		if (strcmp(argv[i], "dump") == 0) {
-			p_dump = argv[i];
-			continue;
-		}
-#endif
-		if (strcmp(argv[i], "sysclk") == 0) {
-			sysclk = simple_strtoul(argv[i + 1], NULL, 0);
-			i += 1;
-			pixis_sysclk_set(sysclk);
-			continue;
-		}
-
-		unknown_param = argv[i];
-	}
-
-	if (unknown_param) {
-		printf("Invalid option: %s\n", unknown_param);
-		return 1;
-	}
-
-#ifdef DEBUG
-	if (p_dump) {
-		pixis_dump_regs();
-
-		/* 'dump' ignores other commands */
-		return 0;
-	}
-#endif
-
-	if (p_altbank)
-		set_altbank();
-	else
-		clear_altbank();
-
-	pixis_bank_reset();
-
-	/* Shouldn't be reached. */
-	return 0;
-}
-
-U_BOOT_LONGHELP(pixis,
-	"- hard reset to default bank\n"
-	"pixis_reset altbank - reset to alternate bank\n"
-#ifdef DEBUG
-	"pixis_reset dump - display the PIXIS registers\n"
-#endif
-	"pixis_reset sysclk <SYSCLK_freq> - reset with SYSCLK frequency(KHz)\n");
-
-U_BOOT_CMD(
-	pixis_reset, CONFIG_SYS_MAXARGS, 1, pixis_reset_cmd,
-	"Reset the board using the FPGA sequencer", pixis_help_text
-	);
diff --git a/board/nxp/common/ngpixis.h b/board/nxp/common/ngpixis.h
deleted file mode 100644
index 7a20ee015fa..00000000000
--- a/board/nxp/common/ngpixis.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/**
- * Copyright 2010-2011 Freescale Semiconductor
- * Author: Timur Tabi <timur@freescale.com>
- *
- * This file provides support for the ngPIXIS, a board-specific FPGA used on
- * some Freescale reference boards.
- */
-
-/* ngPIXIS register set. Hopefully, this won't change too much over time.
- * Feel free to add board-specific #ifdefs where necessary.
- */
-typedef struct ngpixis {
-	u8 id;
-	u8 arch;
-	u8 scver;
-	u8 csr;
-	u8 rst;
-	u8 serclk;
-	u8 aux;
-	u8 spd;
-	u8 brdcfg0;
-	u8 brdcfg1;	/* On some boards, this register is called 'dma' */
-	u8 addr;
-	u8 brdcfg2;
-	u8 gpiodir;
-	u8 data;
-	u8 led;
-	u8 tag;
-	u8 vctl;
-	u8 vstat;
-	u8 vcfgen0;
-	u8 res4;
-	u8 ocmcsr;
-	u8 ocmmsg;
-	u8 gmdbg;
-	u8 res5[2];
-	u8 sclk[3];
-	u8 dclk[3];
-	u8 watch;
-	struct {
-		u8 sw;
-		u8 en;
-	} s[9];		/* s[0]..s[7] is SW1..SW8, and s[8] is SW11 */
-} __attribute__ ((packed)) ngpixis_t;
-
-/* Pointer to the PIXIS register set */
-#define pixis ((ngpixis_t *)PIXIS_BASE)
-
-/* The PIXIS SW register that corresponds to board switch X, where x >= 1 */
-#define PIXIS_SW(x)		(pixis->s[(x) - 1].sw)
-
-/* The PIXIS EN register that corresponds to board switch X, where x >= 1 */
-#define PIXIS_EN(x)		(pixis->s[(x) - 1].en)
-
-u8 pixis_read(unsigned int reg);
-void pixis_write(unsigned int reg, u8 value);
-
-#define PIXIS_READ(reg) pixis_read(offsetof(ngpixis_t, reg))
-#define PIXIS_WRITE(reg, value) pixis_write(offsetof(ngpixis_t, reg), value)
-- 
2.47.3

