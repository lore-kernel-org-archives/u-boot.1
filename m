Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB24CA9EC1
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39FD781491;
	Fri,  9 Oct 2026 22:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id icsnh-A8vzAC; Fri,  9 Oct 2026 22:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D3E7814BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583938;
	b=RmMSMKb9Ok1JLVAutLfPHwdrnA2cq5R9Og+W4SoxG/RGAWVhmTw1LPQ47Q/vuo+B1WYy
	 dILU3hpXXvhPqNKEB8XZR2vPHdo2tUCsf5ZS/U/6ICjSeY1DK85UrAPEeo5643ow1ritp
	 j19JO0bqYYmIEwl6PnFo5Ve9tghCqlbv0G0m1r6samGGltRuWKQMrSuUwTM8L+ts3OjYs
	 /iRvi+/kXXmQu9NLf7sm0y7HpLI0DkMxvGwtOYWSBsP2q1S6JpBtkIn8wc6hPEyp0Ndly
	 81n8mDb97Q+LySr5gjuM3R0bXnaZqdre0uwOEGjuB5itztW/WJ0BfV6Zd2ZZdK26Qkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g/ioZDLDviZV+3DLewlxQXmZegfcWNeesRxI5sl1xKo=;
	b=bLcW4lcEKKPDQIyNOPowZXyeXWSwj0pqd8QouFIwL5zHiMEERwGvkDtM7OfnG+mwW2pl
	 3xdye4qNa1TrKJb7DfkuDFHjhRlNvgLuUqYeDuS8dVe+sOFsTl8tLkGkVPtbRb7adpjnS
	 TC8WNnzxZl20D+N+3uTK0TIJYFHvZkvfWgijsj966DuL84rDAls2HthqbLZ05aHiyZLGj
	 yNjbSLVOGzubLodf4Io/F/NC5yrYb01XYHd9ENaTs5oL1lnparSN+iptHQmgqGZUVILrw
	 4+IiVVfMpKWQgSDj2aFBWeNXwm+wNvfsHjZudAFInEKTZ6Fm+RrsaSMsGEBMi1XkB/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583938;
	bh=g/ioZDLDviZV+3DLewlxQXmZegfcWNeesRxI5sl1xKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LD0nT+lkTolpzs3mKRGTaRBmnum2fRjP8G/fiygV5Tf12XTjxM1z8HERcCYLwTpFs
	 QZHodaeA7tnyctDsuvwAJtcRUEtjGLxsWMTy3pCyc996Do3Cwgne7/lo2MkaHXPXOb
	 8QHN2c1MpwiNANndRf0nbVfKXmS568Nc9IBVSfrYmnPTuz3fbKVkTts+/fq+QSjLVo
	 oTuTHdIbwnZFZil7gwfrAC6m+DRx3eBVNNzXBRnZdWCsqVte/DOPxlxO3uVhsGxcxR
	 XXU1Ky0Y4dP9QXdvScXOVm3TJ20OzDP6qumxSzVqSBzkK3poBvTWzD9P3f0EQYJQJX
	 uLLXj98DgnlbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D3E7814BE;
	Fri,  9 Oct 2026 22:12:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id D36513B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id C50F84009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id 8eMkWTk8NaRR for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E3D9040053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583827;
 b=Fo/+Q/r/AGT9/WNKrc28KlqxN4MvSJ81lTb1gVDlUkxO7hB67oLErgkrf6WfXyV65ENb
 prkg9jimG+avcU8GgZALeBJ2YxgofBPS0VL9TCCJKRXKdYA4oUXoQBXJaAMJwmMsNqA4F
 6ueS8jV0TS1uljkBP8Z43oh7+XWvQyROHs4gv/lvZFNh7QhRFfbqaTShFLFch9B6fpH0l
 W1kY1U9Q9GUXIf5qQ02rg6XCeCyVADGTd4EbLQ/7C+6lJ/C9NkgQ5pAvhqTDWGu2kyHoX
 kyRuFc30RtFSKHI6jki4YbzApExGry7Z4QuOwW/fYhDi2OGLJ/LIfJk2loCX88gTfng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583827;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=g/ioZDLDviZV+3DLewlxQXmZegfcWNeesRxI5sl1xKo=;
 b=RSo8TE6RIpRipKjngTh8KGVsWhP40DNPvJCDnc3V19cb1TReVkcesJtBL93NdppVlDHK
 a/pZXj4rPmCSo5spnpr04T0F55wYfbZHSanlIRSrYNLzDOdebo0ABjYGEzTL9sPy6Dsmu
 gwjJeYoFiXOqZEYVD3am406yHuVaAEjmlhaHGpL2v6swJ2T1t0aak5Nufz2L5xvnt7+jJ
 giBKYItPDjKodMkf85XBOPQYU/3UikX186n3vRknxgD1GeP/xatMX5qQ/tiC7V2Lepvod
 G1eVF1ADUn1v80Naz1TwLrYkXphnNaE1OpVnxygty735Fcgop1O59Zs9dknRkQonncw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=MSjsMztT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gRobNHTP; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=MSjsMztT; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=gRobNHTP
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id E3D9040053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583818; bh=g/ioZDLDviZV+3DLewlxQXm
 ZegfcWNeesRxI5sl1xKo=; b=MSjsMztTxZU0325dq/wS59C907jupt5SKPyxk6BeV3yw9LraRe
 CSlW05ySJyIEv0K/9SZJNtVKEpqg4kmQhW3oZ6mIyzNPwUustiAIDKTHfNe0Y4qD1O5bqFyJptn
 LYxATZmeBH3sauQsirPW+IeeGxmk3nDKhctpp5XYPRkwgd4jObMlPQP9QCRWLzoeUDk+e2McAYS
 mGcMXeztfi9cyctRoIzWnIMcgSWA4wA9iU5eI6gvfimmgAQXksZbs/9Wd86vlQQRAMHLpWyN6UN
 lfDH/ufsJ/YFphie1UzB/FgdFS7zfKQCx3uFS8xlzcWDBJSLJqEjpvkykorQU35Nc4A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583818; bh=g/ioZDLDviZV+3DLewlxQXm
 ZegfcWNeesRxI5sl1xKo=; b=gRobNHTP1u9xrS3DfjWn/yQ+SxQO/xPzfYE5kUDiNaxjdtIbnV
 NM7rNH+Bjrom41du3F881YQvicUUxENh5tAQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 03/26] board: powerpc: Remove P2020RDB-PC support
Date: Fri,  9 Oct 2026 22:09:53 +0000
Message-ID: <20261009221017.20385-4-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
References: <20261009221017.20385-1-brads@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 22:11:54 +0000
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

The P2020RDB-PC board is unmaintained and lacks active community
testing. Remove its target, configurations, and board specific code.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig             |  10 --
 arch/powerpc/dts/Makefile                    |   1 -
 arch/powerpc/dts/p2020rdb-pc.dts             |  59 -------
 arch/powerpc/dts/p2020rdb-pc.dtsi            |  50 ------
 arch/powerpc/dts/p2020rdb-pc_36b.dts         |  59 -------
 board/nxp/p1_p2_rdb_pc/Kconfig               |   3 +-
 board/nxp/p1_p2_rdb_pc/MAINTAINERS           |   8 -
 board/nxp/p1_p2_rdb_pc/README                |   6 +-
 board/nxp/p1_p2_rdb_pc/ddr.c                 |  31 ----
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c        |   2 -
 boot/Kconfig                                 |   2 +-
 configs/P2020RDB-PC_36BIT_NAND_defconfig     | 164 -------------------
 configs/P2020RDB-PC_36BIT_SDCARD_defconfig   | 145 ----------------
 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig | 147 -----------------
 configs/P2020RDB-PC_36BIT_defconfig          | 125 --------------
 configs/P2020RDB-PC_NAND_defconfig           | 162 ------------------
 configs/P2020RDB-PC_SDCARD_defconfig         | 142 ----------------
 configs/P2020RDB-PC_SPIFLASH_defconfig       | 145 ----------------
 configs/P2020RDB-PC_defconfig                | 123 --------------
 doc/README.mpc85xx-sd-spi-boot               |   3 -
 drivers/ddr/fsl/Kconfig                      |   2 +-
 include/configs/p1_p2_rdb_pc.h               |  21 ---
 22 files changed, 5 insertions(+), 1405 deletions(-)
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dts
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc.dtsi
 delete mode 100644 arch/powerpc/dts/p2020rdb-pc_36b.dts
 delete mode 100644 configs/P2020RDB-PC_36BIT_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_36BIT_defconfig
 delete mode 100644 configs/P2020RDB-PC_NAND_defconfig
 delete mode 100644 configs/P2020RDB-PC_SDCARD_defconfig
 delete mode 100644 configs/P2020RDB-PC_SPIFLASH_defconfig
 delete mode 100644 configs/P2020RDB-PC_defconfig

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index 309becda5ac..7e885014ebe 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -157,16 +157,6 @@ config TARGET_P1020RDB_PD
 	imply SATA
 	imply PANIC_HANG
 
-config TARGET_P2020RDB
-	bool "Support P2020RDB-PC"
-	select SUPPORT_SPL
-	select SUPPORT_TPL
-	select ARCH_P2020
-	select SYS_L2_SIZE_512KB
-	imply CMD_EEPROM
-	imply SATA
-	imply SATA_SIL
-
 config TARGET_TURRIS_1X
 	bool "Support Turris 1.x"
 	select SUPPORT_SPL
diff --git a/arch/powerpc/dts/Makefile b/arch/powerpc/dts/Makefile
index 01191273269..e44d49cabdf 100644
--- a/arch/powerpc/dts/Makefile
+++ b/arch/powerpc/dts/Makefile
@@ -11,7 +11,6 @@ dtb-$(CONFIG_TARGET_P1010RDB_PA) += p1010rdb-pa.dtb p1010rdb-pa_36b.dtb
 dtb-$(CONFIG_TARGET_P1010RDB_PB) += p1010rdb-pb.dtb p1010rdb-pb_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PC) += p1020rdb-pc.dtb p1020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P1020RDB_PD) += p1020rdb-pd.dtb
-dtb-$(CONFIG_TARGET_P2020RDB) += p2020rdb-pc.dtb p2020rdb-pc_36b.dtb
 dtb-$(CONFIG_TARGET_P3041DS) += p3041ds.dtb
 dtb-$(CONFIG_TARGET_P4080DS) += p4080ds.dtb
 dtb-$(CONFIG_TARGET_P5040DS) += p5040ds.dtb
diff --git a/arch/powerpc/dts/p2020rdb-pc.dts b/arch/powerpc/dts/p2020rdb-pc.dts
deleted file mode 100644
index 84d32360baa..00000000000
--- a/arch/powerpc/dts/p2020rdb-pc.dts
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P2020RDB-PC Device Tree Source
- *
- * Copyright 2013 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-/include/ "p2020.dtsi"
-
-/ {
-	model = "fsl,P2020RDB-PC";
-	compatible = "fsl,P2020RDB-PC";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	lbc: localbus@ffe05000 {
-		reg = <0 0xffe05000 0 0x1000>;
-	};
-
-	soc: soc@ffe00000 {
-		ranges = <0x0 0x0 0xffe00000 0x100000>;
-	};
-
-	pci2: pcie@ffe08000 {
-		reg = <0x0 0xffe08000 0x0 0x1000>;	/* registers */
-		status = "disabled";
-	};
-
-	pci1: pcie@ffe09000 {
-		reg = <0x0 0xffe09000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pci0: pcie@ffe0a000 {
-		reg = <0x0 0xffe0a000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	aliases {
-		spi0 = &espi0;
-	};
-};
-
-/include/ "p2020rdb-pc.dtsi"
-/include/ "p2020-post.dtsi"
-
-&espi0 {
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		spi-max-frequency = <10000000>; /* input clock */
-	};
-};
diff --git a/arch/powerpc/dts/p2020rdb-pc.dtsi b/arch/powerpc/dts/p2020rdb-pc.dtsi
deleted file mode 100644
index 0d2acc746e4..00000000000
--- a/arch/powerpc/dts/p2020rdb-pc.dtsi
+++ /dev/null
@@ -1,50 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P2020 RDB-PC Device Tree Source stub (no addresses or top-level ranges)
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- * Copyright 2020 NXP
- */
-
-&soc {
-	mdio@24520 {
-		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
-			reg = <0x0>;
-			};
-		phy1: ethernet-phy@1 {
-			interrupts = <2 1 0 0>;
-			reg = <0x1>;
-			};
-	};
-
-	mdio@25520 {
-		tbi0: tbi-phy@11 {
-			reg = <0x11>;
-			device_type = "tbi-phy";
-		};
-	};
-
-	mdio@26520 {
-		status = "disabled";
-	};
-
-	enet0: ethernet@24000 {
-		phy-connection-type = "rgmii-id";
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-		};
-	};
-
-	enet1: ethernet@25000 {
-		tbi-handle = <&tbi0>;
-		phy-handle = <&phy0>;
-		phy-connection-type = "sgmii";
-	};
-
-	enet2: ethernet@26000 {
-		phy-handle = <&phy1>;
-		phy-connection-type = "rgmii-id";
-	};
-};
diff --git a/arch/powerpc/dts/p2020rdb-pc_36b.dts b/arch/powerpc/dts/p2020rdb-pc_36b.dts
deleted file mode 100644
index c847417df99..00000000000
--- a/arch/powerpc/dts/p2020rdb-pc_36b.dts
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR X11
-/*
- * P2020RDB-PC (36-bit address map) Device Tree Source
- *
- * Copyright 2013 - 2015 Freescale Semiconductor Inc.
- * Copyright 2019 NXP
- */
-
-/include/ "p2020.dtsi"
-
-/ {
-	model = "fsl,P2020RDB-PC";
-	compatible = "fsl,P2020RDB-PC";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&mpic>;
-
-	lbc: localbus@fffe05000 {
-		reg = <0xf 0xffe05000 0 0x1000>;
-	};
-
-	soc: soc@fffe00000 {
-		ranges = <0x0 0xf 0xffe00000 0x100000>;
-	};
-
-	pci2: pcie@fffe08000 {
-		reg = <0xf 0xffe08000 0x0 0x1000>;	/* registers */
-		status = "disabled";
-	};
-
-	pci1: pcie@fffe09000 {
-		reg = <0xf 0xffe09000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	pci0: pcie@fffe0a000 {
-		reg = <0xf 0xffe0a000 0x0 0x1000>;	/* registers */
-		ranges = <0x01000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x00010000   /* downstream I/O */
-			  0x02000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000>; /* non-prefetchable memory */
-	};
-
-	aliases {
-		spi0 = &espi0;
-	};
-};
-
-/include/ "p2020rdb-pc.dtsi"
-/include/ "p2020-post.dtsi"
-
-&espi0 {
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0>;
-		spi-max-frequency = <10000000>; /* input clock */
-	};
-};
diff --git a/board/nxp/p1_p2_rdb_pc/Kconfig b/board/nxp/p1_p2_rdb_pc/Kconfig
index 2ab46d99434..2c82048564d 100644
--- a/board/nxp/p1_p2_rdb_pc/Kconfig
+++ b/board/nxp/p1_p2_rdb_pc/Kconfig
@@ -1,6 +1,5 @@
 if	TARGET_P1020RDB_PC	|| \
-	TARGET_P1020RDB_PD	|| \
-	TARGET_P2020RDB
+	TARGET_P1020RDB_PD
 
 config SYS_BOARD
 	default "p1_p2_rdb_pc"
diff --git a/board/nxp/p1_p2_rdb_pc/MAINTAINERS b/board/nxp/p1_p2_rdb_pc/MAINTAINERS
index 1ce3501f379..d9a5cdf3f42 100644
--- a/board/nxp/p1_p2_rdb_pc/MAINTAINERS
+++ b/board/nxp/p1_p2_rdb_pc/MAINTAINERS
@@ -15,11 +15,3 @@ F:	configs/P1020RDB-PD_defconfig
 F:	configs/P1020RDB-PD_NAND_defconfig
 F:	configs/P1020RDB-PD_SDCARD_defconfig
 F:	configs/P1020RDB-PD_SPIFLASH_defconfig
-F:	configs/P2020RDB-PC_defconfig
-F:	configs/P2020RDB-PC_36BIT_defconfig
-F:	configs/P2020RDB-PC_36BIT_NAND_defconfig
-F:	configs/P2020RDB-PC_36BIT_SDCARD_defconfig
-F:	configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
-F:	configs/P2020RDB-PC_NAND_defconfig
-F:	configs/P2020RDB-PC_SDCARD_defconfig
-F:	configs/P2020RDB-PC_SPIFLASH_defconfig
diff --git a/board/nxp/p1_p2_rdb_pc/README b/board/nxp/p1_p2_rdb_pc/README
index fd849bfc29a..5bf27816ab2 100644
--- a/board/nxp/p1_p2_rdb_pc/README
+++ b/board/nxp/p1_p2_rdb_pc/README
@@ -6,10 +6,8 @@ P1_P2_RDB_PC represents a set of boards including
     P1020RDB-PD
     P1021RDB-PC
     P1024RDB
-    P2020RDB-PC
 
-They have similar design of P1020RDB but have DDR3 instead of DDR2. P2020RDB-PC
-has 64-bit DDR. All others have 32-bit DDR.
+They have similar design of P1020RDB but have DDR3 instead of DDR2.
 
 Key features on these boards include:
     * DDR3
@@ -46,7 +44,7 @@ enable QE-TDM for linux kernel, set "qe;tdm" in hwconfig. Syntax is as below
 
 Device tree support and how to enable it for different configs
 --------------------------------------------------------------
-Device tree support is available for p1020rdb and p2020rdb for below mentioned boot,
+Device tree support is available for p1020rdb for below mentioned boot,
 1. NOR Boot
 2. NAND Boot
 3. SD Boot
diff --git a/board/nxp/p1_p2_rdb_pc/ddr.c b/board/nxp/p1_p2_rdb_pc/ddr.c
index 8622a5a610a..74c9c78c4e1 100644
--- a/board/nxp/p1_p2_rdb_pc/ddr.c
+++ b/board/nxp/p1_p2_rdb_pc/ddr.c
@@ -46,37 +46,6 @@ dimm_params_t ddr_raw_timing = {
 	.refresh_rate_ps = 7800000,
 	.tfaw_ps = 37500,
 };
-#elif defined(CONFIG_TARGET_P2020RDB)
-/* Micron MT41J128M16_15E */
-dimm_params_t ddr_raw_timing = {
-	.n_ranks = 1,
-	.rank_density = 1073741824u,
-	.capacity = 1073741824u,
-	.primary_sdram_width = 64,
-	.ec_sdram_width = 0,
-	.registered_dimm = 0,
-	.mirrored_dimm = 0,
-	.n_row_addr = 14,
-	.n_col_addr = 10,
-	.n_banks_per_sdram_device = 8,
-	.edc_config = 0,
-	.burst_lengths_bitmask = 0x0c,
-
-	.tckmin_x_ps = 1500,
-	.caslat_x = 0x7e << 4,	/* 5,6,7,8,9,10 */
-	.taa_ps = 13500,
-	.twr_ps = 15000,
-	.trcd_ps = 13500,
-	.trrd_ps = 6000,
-	.trp_ps = 13500,
-	.tras_ps = 36000,
-	.trc_ps = 49500,
-	.trfc_ps = 160000,
-	.twtr_ps = 7500,
-	.trtp_ps = 7500,
-	.refresh_rate_ps = 7800000,
-	.tfaw_ps = 30000,
-};
 #elif (defined(CONFIG_TARGET_P1020MBG) || defined(CONFIG_TARGET_P1020RDB_PD))
 /* Micron MT41J512M8_187E */
 dimm_params_t ddr_raw_timing = {
diff --git a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index a19a98dd0d1..57c355068db 100644
--- a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -220,8 +220,6 @@ int board_early_init_f(void)
 #define BOARD_NAME "P1020RDB-PC"
 #elif defined(CONFIG_TARGET_P1020RDB_PD)
 #define BOARD_NAME "P1020RDB-PD"
-#elif defined(CONFIG_TARGET_P2020RDB)
-#define BOARD_NAME "P2020RDB-PC"
 #endif
 
 int checkboard_p1_p2(void)
diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..11b5036caad 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1179,7 +1179,7 @@ config RAMBOOT_PBL
 choice
 	prompt "Freescale PBL (or predecessor) load location"
 	depends on RAMBOOT_PBL || ((TARGET_P1010RDB_PA || TARGET_P1010RDB_PB \
-		|| TARGET_P1020RDB_PC || TARGET_P1020RDB_PD || TARGET_P2020RDB) \
+		|| TARGET_P1020RDB_PC || TARGET_P1020RDB_PD) \
 		&& !CMD_NAND) || (TARGET_TURRIS_1X && SYS_MPC85XX_NO_RESETVEC)
 
 config SDCARD
diff --git a/configs/P2020RDB-PC_36BIT_NAND_defconfig b/configs/P2020RDB-PC_36BIT_NAND_defconfig
deleted file mode 100644
index 6a8b750555b..00000000000
--- a/configs/P2020RDB-PC_36BIT_NAND_defconfig
+++ /dev/null
@@ -1,164 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc_36b"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_TPL_TEXT_BASE=0xF8F80000
-CONFIG_TPL_LIBCOMMON_SUPPORT=y
-CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_TPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xFF800000
-CONFIG_SPL=y
-CONFIG_TPL_MAX_SIZE=0x20000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_TPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PHYS_64BIT=y
-CONFIG_MP=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x1000
-CONFIG_SPL_NAND_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_INIT_MINIMAL=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_RELOC_TEXT_BASE=0xf8ffe000
-CONFIG_SPL_RELOC_STACK=0xf8fffff0
-CONFIG_TPL_GD_ADDR=0xf8fac000
-CONFIG_TPL_RELOC_TEXT_BASE=0xf8f80000
-CONFIG_TPL_RELOC_STACK=0xf8fb0000
-CONFIG_TPL_RELOC_MALLOC=y
-CONFIG_TPL_RELOC_MALLOC_ADDR=0xf8fb4000
-CONFIG_TPL_RELOC_MALLOC_SIZE=0xc000
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_TPL=y
-CONFIG_TPL_ENV_SUPPORT=y
-CONFIG_TPL_I2C=y
-CONFIG_TPL_MPC8XXX_INIT_DDR=y
-CONFIG_TPL_NAND_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=fef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RANGE=0xc000
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFF800C21
-CONFIG_SYS_OR0_PRELIM=0xFFFF8396
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xEF001001
-CONFIG_SYS_OR1_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_TPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_TPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_ELBC=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x4000
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x20000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
diff --git a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig b/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
deleted file mode 100644
index e516e8c0d6e..00000000000
--- a/configs/P2020RDB-PC_36BIT_SDCARD_defconfig
+++ /dev/null
@@ -1,145 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc_36b"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xf8f80000
-CONFIG_SPL=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PHYS_64BIT=y
-CONFIG_MP=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_FSL_FIXED_MMC_LOCATION=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_MMC_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_GD_ADDR=0xf8f9c000
-CONFIG_SPL_RELOC_STACK=0xf8f9d000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=fef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
diff --git a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig b/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
deleted file mode 100644
index bc25dbe17df..00000000000
--- a/configs/P2020RDB-PC_36BIT_SPIFLASH_defconfig
+++ /dev/null
@@ -1,147 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc_36b"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xf8f80000
-CONFIG_SPL=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PHYS_64BIT=y
-CONFIG_MP=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SPIFLASH=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_SPI_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_GD_ADDR=0xf8f9c000
-CONFIG_SPL_RELOC_STACK=0xf8f9d000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=fef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
diff --git a/configs/P2020RDB-PC_36BIT_defconfig b/configs/P2020RDB-PC_36BIT_defconfig
deleted file mode 100644
index 429b83465ad..00000000000
--- a/configs/P2020RDB-PC_36BIT_defconfig
+++ /dev/null
@@ -1,125 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0xEFF40000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc_36b"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_ENV_ADDR=0xEFF20000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PHYS_64BIT=y
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_NO_PBL=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=fef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=fef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_COMMON_INIT_DDR=y
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
diff --git a/configs/P2020RDB-PC_NAND_defconfig b/configs/P2020RDB-PC_NAND_defconfig
deleted file mode 100644
index e60677d55dc..00000000000
--- a/configs/P2020RDB-PC_NAND_defconfig
+++ /dev/null
@@ -1,162 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_TPL_TEXT_BASE=0xF8F80000
-CONFIG_TPL_LIBCOMMON_SUPPORT=y
-CONFIG_TPL_LIBGENERIC_SUPPORT=y
-CONFIG_TPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xFF800000
-CONFIG_SPL=y
-CONFIG_TPL_MAX_SIZE=0x20000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_TPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_MP=y
-CONFIG_TPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x1000
-CONFIG_SPL_NAND_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_INIT_MINIMAL=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_RELOC_TEXT_BASE=0xf8ffe000
-CONFIG_SPL_RELOC_STACK=0xf8fffff0
-CONFIG_TPL_GD_ADDR=0xf8fac000
-CONFIG_TPL_RELOC_TEXT_BASE=0xf8f80000
-CONFIG_TPL_RELOC_STACK=0xf8fb0000
-CONFIG_TPL_RELOC_MALLOC=y
-CONFIG_TPL_RELOC_MALLOC_ADDR=0xf8fb4000
-CONFIG_TPL_RELOC_MALLOC_SIZE=0xc000
-CONFIG_SPL_NAND_SUPPORT=y
-CONFIG_TPL=y
-CONFIG_TPL_ENV_SUPPORT=y
-CONFIG_TPL_I2C=y
-CONFIG_TPL_MPC8XXX_INIT_DDR=y
-CONFIG_TPL_NAND_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=ef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RANGE=0xc000
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFF800C21
-CONFIG_SYS_OR0_PRELIM=0xFFFF8396
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xEF001001
-CONFIG_SYS_OR1_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_TPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_TPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_ELBC=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x4000
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x20000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPL_NS16550_MIN_FUNCTIONS=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
diff --git a/configs/P2020RDB-PC_SDCARD_defconfig b/configs/P2020RDB-PC_SDCARD_defconfig
deleted file mode 100644
index fe433c5e358..00000000000
--- a/configs/P2020RDB-PC_SDCARD_defconfig
+++ /dev/null
@@ -1,142 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x0
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xf8f80000
-CONFIG_SPL=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_MP=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_FSL_FIXED_MMC_LOCATION=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_MMC_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_GD_ADDR=0xf8f9c000
-CONFIG_SPL_RELOC_STACK=0xf8f9d000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=ef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
diff --git a/configs/P2020RDB-PC_SPIFLASH_defconfig b/configs/P2020RDB-PC_SPIFLASH_defconfig
deleted file mode 100644
index 0184dcb4e8b..00000000000
--- a/configs/P2020RDB-PC_SPIFLASH_defconfig
+++ /dev/null
@@ -1,145 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0x11000000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_TEXT_BASE=0xf8f80000
-CONFIG_SPL=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_MP=y
-CONFIG_SPL_SYS_MONITOR_BASE=0xF8F80000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SPIFLASH=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-# CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_SPI_BOOT=y
-CONFIG_SPL_SYS_CCSR_DO_NOT_RELOCATE=y
-CONFIG_SPL_FLUSH_IMAGE=y
-CONFIG_SPL_GD_ADDR=0xf8f9c000
-CONFIG_SPL_RELOC_STACK=0xf8f9d000
-CONFIG_SPL_RELOC_MALLOC=y
-CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
-CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_MPC8XXX_INIT_DDR=y
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=ef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SPL_SYS_NS16550_SERIAL=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
diff --git a/configs/P2020RDB-PC_defconfig b/configs/P2020RDB-PC_defconfig
deleted file mode 100644
index a3efd89e218..00000000000
--- a/configs/P2020RDB-PC_defconfig
+++ /dev/null
@@ -1,123 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0xEFF40000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_SECT_SIZE=0x20000
-CONFIG_DEFAULT_DEVICE_TREE="p2020rdb-pc"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_ENV_ADDR=0xEFF20000
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-# CONFIG_CMD_ERRATA is not set
-CONFIG_TARGET_P2020RDB=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_L2_CACHE=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_MP=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_NO_PBL=y
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw rootdelay=30 console=$consoledev,$baudrate $othbootargs;usb start;ext2load usb 0:1 $loadaddr /boot/$bootfile;ext2load usb 0:1 $fdtaddr /boot/$fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-# CONFIG_MISC_INIT_R is not set
-CONFIG_HUSH_PARSER=y
-# CONFIG_AUTO_COMPLETE is not set
-CONFIG_CMD_IMLS=y
-CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3
-CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-# CONFIG_CMD_HASH is not set
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nor0=ef000000.nor"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=ef000000.nor:256k(vsc7385-firmware),256k(dtb),4608k(kernel),9984k(fs),1280k(u-boot)"
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_FLASH=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eTSEC1"
-CONFIG_USE_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_LBA48=y
-CONFIG_DDR_CLK_FREQ=66666666
-CONFIG_SYS_SPD_BUS_NUM=1
-CONFIG_CHIP_SELECTS_PER_CTRL=1
-CONFIG_SYS_DDR_RAW_TIMING=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xEF001001
-CONFIG_SYS_OR0_PRELIM=0xFC000FF7
-CONFIG_SYS_BR2_PRELIM_BOOL=y
-CONFIG_SYS_BR2_PRELIM=0xFFB00801
-CONFIG_SYS_OR2_PRELIM=0xFFFE09FF
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFA00801
-CONFIG_SYS_OR3_PRELIM=0xFFF009F7
-CONFIG_COMMON_INIT_DDR=y
-CONFIG_SPL_COMMON_INIT_DDR=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_FSL_I2C_OFFSET=0x3000
-CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
-CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
-CONFIG_SYS_I2C_EEPROM_ADDR=0x52
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_FLASH_CFI_MTD=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=128
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_MII=y
-CONFIG_VSC7385_ENET=y
-CONFIG_TSEC_ENET=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_BROADCOM=y
-CONFIG_PHY_DAVICOM=y
-CONFIG_PHY_LXT=y
-CONFIG_PHY_MARVELL=y
-CONFIG_PHY_NATSEMI=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_SMSC=y
-CONFIG_PHY_VITESSE=y
-CONFIG_PHY_FIXED=y
-CONFIG_PCIE_FSL=y
-CONFIG_DM_RTC=y
-CONFIG_RTC_PT7C4338=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_STORAGE=y
diff --git a/doc/README.mpc85xx-sd-spi-boot b/doc/README.mpc85xx-sd-spi-boot
index 7608fc3aacb..8e98fc9f659 100644
--- a/doc/README.mpc85xx-sd-spi-boot
+++ b/doc/README.mpc85xx-sd-spi-boot
@@ -59,9 +59,6 @@ P1022DS		config_sram_p1022ds.dat
 P2020DS		config_sram_p2020ds.dat
 P1020RDB	config_ddr2_1g_p1020rdb_533M.dat
 P1020RDB	config_ddr2_1g_p1020rdb_667M.dat
-P2020RDB	config_ddr2_1g_p2020rdb_800M.dat
-P2020RDB	config_ddr2_1g_p2020rdb_667M.dat
-P2020RDB	config_ddr3_1gb_64bit_p2020rdb_pc.dat
 P1020RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1011RDB	config_ddr3_1gb_p1_p2_rdb_pc_800M.dat
 P1010RDB	config_ddr3_1gb_p1010rdb_800M.dat
diff --git a/drivers/ddr/fsl/Kconfig b/drivers/ddr/fsl/Kconfig
index b11fa79ca59..d5c0af7d3b1 100644
--- a/drivers/ddr/fsl/Kconfig
+++ b/drivers/ddr/fsl/Kconfig
@@ -291,7 +291,7 @@ config SYS_OR7_PRELIM
 endmenu
 
 if TARGET_P1010RDB_PA || TARGET_P1010RDB_PB || TARGET_P1020RDB_PC || \
-	TARGET_P1020RDB_PD || TARGET_P2020RDB
+	TARGET_P1020RDB_PD
 
 config COMMON_INIT_DDR
 	bool "Do not have a TLB entry to cover common DDR init with serial presence detect (SPD)"
diff --git a/include/configs/p1_p2_rdb_pc.h b/include/configs/p1_p2_rdb_pc.h
index 2d9d5b27511..2ef8fa02188 100644
--- a/include/configs/p1_p2_rdb_pc.h
+++ b/include/configs/p1_p2_rdb_pc.h
@@ -60,25 +60,6 @@
  */
 #endif
 
-#if defined(CONFIG_TARGET_P2020RDB)
-#define __SW_BOOT_MASK		0x03
-#define __SW_BOOT_NOR		0xc8
-#define __SW_BOOT_SPI		0x28
-#define __SW_BOOT_SD		0x68
-#define __SW_BOOT_SD2		0x18
-#define __SW_BOOT_NAND		0xe8
-#define __SW_BOOT_PCIE		0xa8
-#define __SW_NOR_BANK_MASK	0xfd
-#define __SW_NOR_BANK_UP	0x00
-#define __SW_NOR_BANK_LO	0x02
-#define __SW_BOOT_NOR_BANK_UP	0xc8 /* (__SW_BOOT_NOR | __SW_NOR_BANK_UP) */
-#define __SW_BOOT_NOR_BANK_LO	0xca /* (__SW_BOOT_NOR | __SW_NOR_BANK_LO) */
-#define __SW_BOOT_NOR_BANK_MASK	0x01 /* (__SW_BOOT_MASK & __SW_NOR_BANK_MASK) */
-/*
- * Dynamic MTD Partition support with mtdparts
- */
-#endif
-
 #ifdef CONFIG_SDCARD
 #define CFG_SYS_MMC_U_BOOT_SIZE	(768 << 10)
 #define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
@@ -125,7 +106,6 @@
 #define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
 
 /* Default settings for DDR3 */
-#ifndef CONFIG_TARGET_P2020RDB
 #define CFG_SYS_DDR_CS0_BNDS		0x0000003f
 #define CFG_SYS_DDR_CS0_CONFIG	0x80014302
 #define CFG_SYS_DDR_CS0_CONFIG_2	0x00000000
@@ -155,7 +135,6 @@
 #define CFG_SYS_DDR_MODE_1		0x40461520
 #define CFG_SYS_DDR_MODE_2		0x8000c000
 #define CFG_SYS_DDR_INTERVAL		0x0C300000
-#endif
 
 /*
  * Memory map
-- 
2.47.3

