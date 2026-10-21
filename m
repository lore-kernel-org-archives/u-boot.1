Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84783606A329
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u1kvIdqt;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=dx8bsIu4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LURvWHyp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E79D811C1;
	Wed, 21 Oct 2026 16:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qHlAEH_pEbY7; Wed, 21 Oct 2026 16:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28574811BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599374;
	b=mkB2seDygqRS/TP67bR4gGw+cDvRJ/O7EzJ6vBNAGO1EGa25uW1QSrqNNY/hl4Ar1QIy
	 U7ZxZlXUMZCh8iNCH4q14N0uYh7HGAWbztNQCjqkp/qIru8HtrDDSmXfFOvBWFZPOzR+h
	 2Q5k1yb6GOrPCH1V3rLCwHvsFYGmJlM4HNpC7s0PoDaqinHrnbC7kEyU5v9qHwpRyiWsH
	 sTkoEW/OM9t2fINuCajSEGivYlPqbe6dHotN3VZWVf/yKvOGtNPl9sfQmKenrk9I769+P
	 FTPQKxfYjibCwjAUlM3avQE4oZBNVmuOa2zivhVhnmJA84KjqyPYEBwUI1lnH/GEjGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
	b=NV7DegeIIp0p4vmrdafYggsKs0oFnQVXO4PhQRYN5y33JOrXguFbNeKLrhOctQK0l31W
	 ZHD1wLow2QiIDCEMxcALup9XvoTIVr6tvy6hK8ZQ8GPCk8x/dmOQZd5zl33heGuHmfmS0
	 REyR/Wb5fsnAJUqRkSHg9qr7JKSl91/p8qtUFIwhEA29nQWvR8ItRfbAZL8Is0Z5IhznX
	 s63DLukkZNvCya9l8d+7feJOiUPt+t8puuKYi2K1vcqWEYe6mWeKbp3fbgdqwz9xOftpC
	 9so2z0BFp4S9Y7vCyb6Vo/I0GiWj0fsv2rpMYMTP0pKZ+heFSRy7XY/IePOJQkim15g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=dx8bsIu4;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=LURvWHyp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599374;
	bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u1kvIdqtyiMeBGhJePDumkSwgdYL6KWuSw6anm2cajPfUV+mf5qiXP1Q/cxYvu1Uq
	 cLB0e2niHo9aYLn2QSZsBHWmR4wYXA2z9UOoqnmF1Z46Vsuut1MoGDkfcuEbDecSOr
	 DuyIB5gUzo8w7l8expgnrJQ0an4+pA6AwBbJa19o6BVuLdNHcLcSGOucq/Bi1SJAwP
	 3TbW+kAtWYt0ZxKtZqp/Kfx4YtXCS8l5IRtFPtq8e1p/H4kUSR7FW+DBGeSH74xe+e
	 YOyRVjsyR1B7/bTf7wGqyEfU+rq8l589B1MrAzgpZVcMqoAZf5tFkCIC5c9bYvEYF3
	 iViCU2OwFEkrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28574811BF;
	Wed, 21 Oct 2026 16:16:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id 15AC31184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 0773E81160
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id cxm26bFRjLSX for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD21D81103
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598512;
 b=pVYVz4Sr+zL8CVP+LpQc1RMEXwVLiUYlV6cFX8kd1AymXM/64ocYHMlg/KHXd03OFNBl
 BTviaoijshw6qSGymCWPrnkLweIdFS19rnGAbBUhaAPta2I6uGjmN3pgRPfhiMbWCveVc
 5KevyQ3uJDIDKkNMvdxAVUohphv4sFGGXiuf/zuvSZJSWMfgQBTgWVayfj6L5hKaOkjLn
 YSMlqvuSCfKL7lTpnSd5oNBRjnyPYqRjZrMpuQqxD7/xagsHmYdIjjH5kgDWEmqVdBC1s
 Gpzq6MwBxs9KA55+3fLGw0/oq7e+XEOZz+pRr37vFwektqxDcw1oPB99hMGpruJig5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598512;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
 b=cT78u5KCWRwGyh0DJR6bFTjzuSBeBEjGYz3cCPC4+XWhrwnqeLTKebmqpifiONbleSs/
 3yxSxbdFbM/sPCd+g3ZcFQYkWqtWHLnf7PY2U1Rr6VESiwT5Nzth3RFrfP65WAElK4leQ
 QbXOolZH4ByJ3hBq8x5k9EUi7D0kv7q+zzgrO8qCQmMDo6H+0HRdm4ruG2GnGIzzic0/1
 YxzqNGbV/svRjWIzJfGLD/H8+vPvJhlWJX0hffOe0C/4jRHDKfG9sA+kSYgeusFVO1h8Z
 S6+6uSxx+qjXZ/dHEy5Rx570abEwvxpySixcpZz7TSsml+bLrTwys6vDrvoSRQvH7Ww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=dx8bsIu4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LURvWHyp; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=dx8bsIu4; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=LURvWHyp
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id AD21D81103
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598506; bh=Sex27ZDrkkH284XFABbXJ5M
 vifkEAAX2K1HixILeNTg=; b=dx8bsIu48OBgae4oH69LOYj+BZHaThOyWSHSXbBndMYl0qd8sN
 9Y4SENUOz3ZBRjfSwy6L+4lR5wvvLU1D7kZrLZKaG9rNLcb8X/sEf2H8PSw1kX1Iaj5drPm4dFp
 tVz3QBeZKlSq/VTvcUzB7iSLgK6jYkjcxizH2Z1Ag07291ASrQk6RyZ0NDsMUla4f1pC8VrpTH9
 ndDh3evEiVKdl3ODG5ESb/nnPRxKaYf+/bPlSVLGlCu1ponWlTiGCHS6BQOUM1o7mInQEJl3jTi
 /fPgRXWhHmGJSbNWPOUEdrwMmbVX0ejjxWmdf15qJQzs5tUwwNuUIhk0xygfVM3l60g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598506; bh=Sex27ZDrkkH284XFABbXJ5M
 vifkEAAX2K1HixILeNTg=; b=LURvWHypYM6UcyxYfjWbgXcpYmcuFrzuIM+tW9WsVpSaIbmHdH
 fDMVNSZT0jfW7MVgfLnlP5TzGOynliBSBwCg==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: [PATCH v3 04/26] board: powerpc: Remove P3041DS support
Date: Wed, 21 Oct 2026 16:01:00 +0000
Message-ID: <20261021160145.10430-5-brads@mainlining.org>
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

The P3041DS development system is unmaintained and lacks active
community testing. Drop its target and device tree.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig   |   9 --
 arch/powerpc/dts/Makefile          |   1 -
 arch/powerpc/dts/p3041.dtsi        | 149 ---------------------------
 arch/powerpc/dts/p3041ds.dts       | 158 -----------------------------
 arch/powerpc/dts/p3041si-post.dtsi |  43 --------
 board/nxp/common/Makefile          |   2 -
 6 files changed, 362 deletions(-)
 delete mode 100644 arch/powerpc/dts/p3041.dtsi
 delete mode 100644 arch/powerpc/dts/p3041ds.dts
 delete mode 100644 arch/powerpc/dts/p3041si-post.dtsi

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 7e885014ebe..65081b5bd63 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -87,15 +87,6 @@ config TARGET_SOCRATES
 	select ARCH_MPC8544
 	select BINMAN
 
-config TARGET_P3041DS
-	bool "Support P3041DS"
-	select PHYS_64BIT
-	select ARCH_P3041
-	select BOARD_LATE_INIT if CHAIN_OF_TRUST
-	select FSL_NGPIXIS
-	imply SATA
-	imply PANIC_HANG
-
 config TARGET_P4080DS
 	bool "Support P4080DS"
 	select PHYS_64BIT
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index e44d49cabdf..c603369e7cc 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
-dtb-$(CONFIG_TARGET_P3041DS) += p3041ds.dtb
 dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
 dtb-$(CONFIG_TARGET_SOCRATES) += socrates.dtb
diff --git a/arch/powerpc/dts/p3041.dtsi b/arch/powerpc/dts/p3041.dtsi
deleted file mode 100644
index e34117b65a0..00000000000
--- a/arch/powerpc/dts/p3041.dtsi
+++ /dev/null
@@ -1,149 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P3041 Silicon/SoC Device Tree Source (pre include)
- *
- * Copyright 2010 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/dts-v1/;
-
-/include/ "e500mc_power_isa.dtsi"
-
-/ {
-	compatible = "fsl,P3041";
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
-		usb0: usb@fe210000 {
-			compatible = "fsl-usb2-mph";
-			reg = <0x210000 0x1000>;
-			phy_type = "utmi";
-		};
-
-		usb1: usb@fe211000 {
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
-		/include/ "qoriq-i2c-0.dtsi"
-		/include/ "qoriq-i2c-1.dtsi"
-	};
-
-	pcie@ffe200000 {
-		compatible = "fsl,pcie-p3041", "fsl,pcie-fsl-qoriq";
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
-		compatible = "fsl,pcie-p3041", "fsl,pcie-fsl-qoriq";
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
-		compatible = "fsl,pcie-p3041", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe202000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <2>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8020000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pcie@ffe203000 {
-		compatible = "fsl,pcie-p3041", "fsl,pcie-fsl-qoriq";
-		reg = <0xf 0xfe203000 0x0 0x1000>;   /* registers */
-		law_trgt_if = <3>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0x0 0xff>;
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xf8030000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xe0000000 0xc 0x60000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-};
diff --git a/arch/powerpc/dts/p3041ds.dts b/arch/powerpc/dts/p3041ds.dts
deleted file mode 100644
index 069dae3b85b..00000000000
--- a/arch/powerpc/dts/p3041ds.dts
+++ /dev/null
@@ -1,158 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P3041DS Device Tree Source
- *
- * Copyright 2010 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019-2020 NXP
- */
-
-/include/ "p3041.dtsi"
-
-/ {
-	model = "fsl,P3041DS";
-	compatible = "fsl,P3041DS";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	aliases{
-		phy_rgmii_0 = &phy_rgmii_0;
-		phy_rgmii_1 = &phy_rgmii_1;
-		phy_sgmii_1c = &phy_sgmii_1c;
-		phy_sgmii_1d = &phy_sgmii_1d;
-		phy_sgmii_1e = &phy_sgmii_1e;
-		phy_sgmii_1f = &phy_sgmii_1f;
-		phy_xgmii_1 = &phy_xgmii_1;
-		phy_xgmii_2 = &phy_xgmii_2;
-		emi1_rgmii = &hydra_mdio_rgmii;
-		emi1_sgmii = &hydra_mdio_sgmii;
-		emi2_xgmii = &hydra_mdio_xgmii;
-		spi0 = &espi0;
-	};
-
-	soc: soc@ffe000000 {
-		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
-		reg = <0xf 0xfe000000 0 0x00001000>;
-		fman@400000{
-			ethernet@e0000 {
-				phy-handle = <&phy_sgmii_1c>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e2000 {
-				phy-handle = <&phy_sgmii_1d>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e4000 {
-				phy-handle = <&phy_sgmii_1e>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e6000 {
-				phy-handle = <&phy_sgmii_1f>;
-				phy-connection-type = "sgmii";
-			};
-
-			ethernet@e8000 {
-				phy-handle = <&phy_rgmii_1>;
-				phy-connection-type = "rgmii";
-			};
-
-			ethernet@f0000 {
-				phy-handle = <&phy_xgmii_1>;
-				phy-connection-type = "xgmii";
-			};
-
-			hydra_mdio_xgmii: mdio@f1000 {
-				status = "disabled";
-
-				phy_xgmii_1: ethernet-phy@4 {
-					compatible = "ethernet-phy-ieee802.3-c45";
-					reg = <0x4>;
-				};
-
-				phy_xgmii_2: ethernet-phy@0 {
-					compatible = "ethernet-phy-ieee802.3-c45";
-					reg = <0x0>;
-				};
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
-			compatible = "fsl,p3041ds-fpga", "fsl,fpga-ngpixis";
-			reg = <3 0 0x30>;
-			ranges = <0 3 0 0x30>;
-
-			mdio-mux-emi1 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "mdio-mux-mmioreg", "mdio-mux";
-				mdio-parent-bus = <&mdio0>;
-				reg = <9 1>;
-				mux-mask = <0x78>;
-
-				hydra_mdio_rgmii: rgmii-mdio@8 {
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
-				hydra_mdio_sgmii: sgmii-mdio@28 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0x28>;
-					status = "disabled";
-
-					phy_sgmii_1c: ethernet-phy@1c {
-						reg = <0x1c>;
-					};
-
-					phy_sgmii_1d: ethernet-phy@1d {
-						reg = <0x1d>;
-					};
-
-					phy_sgmii_1e: ethernet-phy@1e {
-						reg = <0x1e>;
-					};
-
-					phy_sgmii_1f: ethernet-phy@1f {
-						reg = <0x1f>;
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
-/include/ "p3041si-post.dtsi"
diff --git a/arch/powerpc/dts/p3041si-post.dtsi b/arch/powerpc/dts/p3041si-post.dtsi
deleted file mode 100644
index a3e8088d25b..00000000000
--- a/arch/powerpc/dts/p3041si-post.dtsi
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * P3041 Silicon/SoC Device Tree Source (post include)
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
-/include/ "qoriq-sec4.2-0.dtsi"
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
-};
diff --git a/board/nxp/common/Makefile b/board/nxp/common/Makefile
index 46e43a4e45a..ba1aa084aa4 100644
--- a/board/nxp/common/Makefile
+++ b/board/nxp/common/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_DEEP_SLEEP)		+= mpc85xx_sleep.o
 endif
 
 
-obj-$(CONFIG_TARGET_P3041DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P4080DS)		+= ics307_clk.o
 obj-$(CONFIG_TARGET_P5040DS)		+= ics307_clk.o
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
@@ -67,7 +66,6 @@ obj-$(CONFIG_EMC2305)              += emc2305.o
 
 # deal with common files for P-series corenet based devices
 obj-$(CONFIG_TARGET_P2041RDB)	+= p_corenet/
-obj-$(CONFIG_TARGET_P3041DS)	+= p_corenet/
 obj-$(CONFIG_TARGET_P4080DS)	+= p_corenet/
 obj-$(CONFIG_TARGET_P5040DS)	+= p_corenet/
 
-- 
2.47.3

