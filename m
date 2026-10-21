Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573F606B6E6
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oqNEi0lX;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=FpzQA0ij;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=fv7HaRgQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FCC681253;
	Wed, 21 Oct 2026 16:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FNio4TsWRrZf; Wed, 21 Oct 2026 16:16:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F08098123E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599395;
	b=TwXI+cNtp2Nz1YLnBfqZKuqkfa+paaFf4mFm+fd96Dmya000lwO6zRZ7hwfCVIgY27FG
	 Q9I2gL/JakXuE97WSkwHY9bKr//JFXDOUv4EljpDeUYcKCJHPIyI6GwYgGZhvlBKH5vdx
	 pOpm+HYw0A8gBmHKVZrbtwvRtf5MEh2uaG8DmnYxQf33uQD4q7lUU9O0ORBxkz/ebfQ6V
	 CBLrZUnFdJl7sHoVQXUX6FufuiDmpR8h6csL0yesG7A9PohQTB6kM4IuwIWIrHw3wulwc
	 F3QOVazXl2trF1ihNnWG4yChi0ILngH7YqR5LidQbMrw3pFrZRwjyQo5IuKxDq+1Deg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R6DCSwGv59BtYX+2mBrDpmQrrMudm5M0OVqmCWTy86s=;
	b=fcvodV/myvUsWuQZJjxg+pqSUZYmH8K1yMET1UdA2QtjGyHgVqwawrOOusZv3JKts7Ps
	 pU1dO9pWoLXFQrl1BtbQafL91uhapUlGzyVc3Dmh9Dzelc2iCVpW2pBbcFVWvDPj9ehMX
	 3tWwk9l+yzWA3wuwlxa4tqpYB3KwbpbMKkpjKBSzGBLozE0QH8YH3DcJJzk3BpAk9YT/m
	 gDDENiKkW1weU2uQwnSrQMY5A6P/+Z0ugxEpdcsnjGWAWB55YLDp29qniHMIzHoq6qvvg
	 8SM0451JnAFTT9G7Q0ZswLHMn3Fk4Jtz41BiRerOT/gOiTHYH2Kur6zZwMQQuU3mCQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=FpzQA0ij;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=fv7HaRgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599395;
	bh=R6DCSwGv59BtYX+2mBrDpmQrrMudm5M0OVqmCWTy86s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oqNEi0lXHqyApnB/8GNMS+cqXfWAioPXZutLbi4EeJZSOOGE5H86JuKKAmVDUSmmz
	 whaFJXzKmDYGPaW1tvAZ9doe56qPQ3CoPszA7P10XZF6mdnKEtvxkvwAxIC6e2ximN
	 wDK5hkXDuZkOpf5JQXg7eBaZiysRUI8apQfR2+gNTFKTOcqobM7UtQPGDQeh/fV4Zo
	 Qf6aOpb9wQWv8fcFVTZA6I+4xHe5qQ7pIO44jJTuTbgeAQpsr96Ools8BqNrcL6uC9
	 MyOi9s/feKDQOzJ9iBJpVRhHyoFfCX09BRGB+ZIn73Syu3kF8Vnx7j7Pikdp3cHE5h
	 PeESzed3wnO2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F08098123E;
	Wed, 21 Oct 2026 16:16:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 3DB0095C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 2F5F681160
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id NnQZT9gELtqF for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7BF2E8117B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598519;
 b=Z6w+LBFHSf1HQ7hkgfLOUR2GGws6UOru4ee3b8C1UDy/ifzmLz1Tibyk4iairn15ow4Q
 7U7o9xpYxMHVy0OAJZT02+Kg21NLAudxPWB1uOd3ub8DG//tFwNKvIxJ2CAwiwANChvds
 C5m6+OJDoGhUjowxQfM4DIreCggtYXMV2FXiSTMlHjyrRbS4JgpyYaDfcQ+t4smdwmoVe
 cxveukXG+xK7Kza5z4kHe5/C/BOTgFED8lKpR3zh2FNtJVV464f5rXCsod8M5uN/rLJ+5
 /KzVtyM0UpHhaLTiWijpRL+idaw/cSQIfYorwldfAbGB/nfLTl+EflOsZBxhryhV+Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598519;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=R6DCSwGv59BtYX+2mBrDpmQrrMudm5M0OVqmCWTy86s=;
 b=tTbTpjU06OOLZGv1P6Huh5MuDuaXKsFhBeRAsOY/KuFyReQRwMFAMqaQzfhXYyrhi87c
 b7PnSJ18/PQWRZOseOTanhjI7OYBs9nWowRj2BGdZ+NJSSXnkxoU7J62JAN1FBTdsAf9s
 321Ur4f/WJnfZTisB37xaiYuLSsktn++yvkvp7jd9kNcJdKuKJESRhUmfKxoZk+sSfP4G
 a6wxIj8f+Y1uoWOJQO4nWHdY+beRZRRG82q0vokI50atD8g9sbpBI4QcT1OBLqLnYiw2p
 LGVsr1oAIRAjf6jblWxPuTRf0GdoO3g4hux7pV/A8o2Sc3N+K89SEGR8uAuN83QKUFg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=FpzQA0ij; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=fv7HaRgQ; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=FpzQA0ij; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=fv7HaRgQ
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 7BF2E8117B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598507; bh=R6DCSwGv59BtYX+2mBrDpmQ
 rrMudm5M0OVqmCWTy86s=; b=FpzQA0ijmeHPA0Mi+8pK8/HSDRDmcp4zzzOI4NvMBLAP+TSvBz
 ep+gbITljpbox8WiFF6bb66D2xwleREJT4PGJxChfEZvEWTOdvdFNj9TWFtqpyFHWvv+A7YLuLC
 nKLX+M5LsUbPeoKSk5IbleeJmK2qrnR4h4Aau6ub3ipVO6y7YQ5fY9Bl+YdOPLBU8TRbvAXaXg2
 8IKtaZt18sccRWw2mNzQCf0ps1GeGutrP1AtzIu+eR0Df1qrZB3BJUKNSgj/jAGm18I2PSy4Xvn
 It3cH8lAsmjufs+70CNkomSNu9KwD7o0FfEAQHLoau3FlcPrAwOcz6Ks6H1T2P3XMmQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598507; bh=R6DCSwGv59BtYX+2mBrDpmQ
 rrMudm5M0OVqmCWTy86s=; b=fv7HaRgQ26hqmnxQT9dTQ9xBO1jJoTS+5MbulSWNZWaruwbxX3
 AkikvwTwzTPxSqOVul5ozjEQn3FvwDoWcEDA==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 05/26] board: powerpc: Remove P4080DS support
Date: Wed, 21 Oct 2026 16:01:01 +0000
Message-ID: <20261021160145.10430-6-brads@mainlining.org>
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

The P4080DS development system is unmaintained and lacks active
community testing. Drop its target, device trees, and board guide.

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

