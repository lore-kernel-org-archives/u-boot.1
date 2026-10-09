Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF0DCA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 22:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 049B140988;
	Fri,  9 Oct 2026 22:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIK3fArLYgBu; Fri,  9 Oct 2026 22:12:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE67D4098D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791583936;
	b=hwACsGs5HtIhKztb64ygSp33vV3fZ3ZchdzdSXUe+tn8g/uh5XdB4OXrc6WijWj3e/BJ
	 0Og0yWAgbBvhuknQtgw7f5A04TMufpjR/55J8ykJWnOL8dgKbqgAFzs1LU2hOpagwrjgN
	 7fSR07ssZS4FuY5BoZpshryIz/1PmHGlFkF4XRIn+k3PJwuW8xmlbtE4gGObymyeRJU4Z
	 eKIRjkoDzBj8Y09R/KvsHML9XqcaejayLgRJXgUDF6ggOtOZwYUqrR7HwVXs+/0AOptca
	 UtjVQG8ybKbtWzS+ud8HCxho1svTMn7gdbbKVw5k1l2xMyDbkfvx2rm/hLYdUOEK5zQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791583936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
	b=AG8IvwtW1DLYACH7BH6oHjjklglDc8pZ2VrnBRdBb7NXuU/15nX1EVw4ZCVTzT/9FrWB
	 fgQOjhMUOpLdhR5SBVWlXQj+Ql+CSuB5r9sNiDuULgnPUDVi81wXfOdm/PGFWRDHdux1Z
	 CDrirwSmRJYKFTSOKaN6WlPjloJZcUI/QTVkZs1gbFCxc6A/o5smbLq87+drImF+1eYT0
	 1Oqf698zo7U6aVCwSE7EhcF4GJyT8lEQLKDuyQreM0RSZjrs6MthRHzItk+fMdr14hAcv
	 7xmU8yrqAPt+8S128KR4OnXr0c/3CqZejVEcJL26fddVGUDs6MTOjvey1hF3wNOGx3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791583936;
	bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zd2AktfsFT1dhcQf7XUI3386y+eG19XtzNMYAXXx0Gh4usve2WvLRkj8f61rc1bvU
	 kyvIdedUs/B/eLzLJkqIKoQrs+e7RpSVlGAE/oYINki5tas6PLMf5PQzbFFjYdg8C3
	 JstiG8+PfzFjnLT3h0E4HWR0UDrwPOatsdxW7/Y9+LdfmoQfHkStbyoLYFVAcgOk6t
	 JjQOE/PyqA7CnNckUdL/JypU2soXOzb8hHrWYVfBiDJMHAF0D8KlKbk7wKm6KNlzdL
	 lyJ4p6ymwqc3p6KWy1EMZxw7nIIrhCnrX8UEN7ekJBOUkufrfUYrjoeZDkNCpej8wM
	 rCOkQleFgPpOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE67D4098D;
	Fri,  9 Oct 2026 22:12:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id DB150317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 5345F40194
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id qpisr9ZKjxq3 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 22:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 93B954009C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791583827;
 b=XZ9hPSPPRTKI8pkrSASX7JAnVzEcSnExY0b7dGNz2i/o3vmTEgtA0Q2fXVTNitgp5820
 G2q+LmEHdPup2A+LQpULE7KN66JI4Nhd293DuiE2Spi9YKW5m4vKNQA3C4Rrw2tmCgnSw
 ctoiRvicqOL02jWLg5qGEqH8vu/LGaT/WR4J8pGqwKtlb+Dp9PXoWzSkUBunyWe0mvp+/
 EsOr/OY6jlSHKrTNnde9ZsjtKcIUS+z1e4YvYB+UsKZDx3IB6mhMmWeJzM6T6RKJSyYYD
 /hdR5HWegDuwuqQcmGLKzU/61rAeUtpLds7jaZbM/j1+1s6M1XaXxVuW0WeuXYumz2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791583827;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Sex27ZDrkkH284XFABbXJ5MvifkEAAX2K1HixILeNTg=;
 b=BTSMqHG8LnC2rtUu8vXZ/UX+yFw6gEOZbQjUPAvvF+MaNSrkBmROC4HtCf33wis9VrxS
 yQHnruPlZJPCsNdjnpBLw+gZEx/D3XnyFKlQLesmbqCUuJ6tG7DdXL76K8lzNhxITg4qP
 bD7hm/DDxhBfOfJP/dFhEh5N7xlCk+rQ/pvLEOHnaMKevYt4ns6IqSe9ZWUGQvavsE3gd
 vlPF2iUnUdLMW4UcjBKxXNhbJdIK4T1HUwHUmoFgTyMmcqSBK6cAADYZveb/DSHWY4cAm
 Cjogjbc3FQ1fjFtkdrgtNUAZaMwUUdATwvVQo/P/VLh+iVTsWxNt0XF0Hb92RaX/YRA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=TEv8GCF+; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=UlyiH+hH; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=TEv8GCF+; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=UlyiH+hH
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 93B954009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583818; bh=Sex27ZDrkkH284XFABbXJ5M
 vifkEAAX2K1HixILeNTg=; b=TEv8GCF+b8GoYP/Qn+4B05Oos7N6NKVjgdv4n9L3K2suNZotgF
 yoVkQ0LKTmpaLc9hnD15PwKnmG8gvFJOvHW+6737qlQDW6OdPkAbeVj2LEwEexatUX2zHFxVURd
 4mpWeA3XsHiTjrmK0bjg7k0BSwSCtpuV/vfViSApZUa5Q8bpCIC3Avc32JAmuvGzAw8AGP49LGG
 lHW8EjtCfM9O9V7ZIcZbGywMqkKx8AA9QektyLjbScIweB/jwKK0ZudZx6HUulMdIyiWS2uxKjy
 O5hzZRY7584fsDYSyUcszU0uSDpeRx5RqHRPIkrtjvGi3EEhH2p09n7IPoifEQLZ3ig==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1791583818; bh=Sex27ZDrkkH284XFABbXJ5M
 vifkEAAX2K1HixILeNTg=; b=UlyiH+hHe3yObrBAqZAA5a+yUq1CYs1YbEtb3fCy5AJeSZSdwK
 dUhpIk7/OAcf1gy98XwY+v0XM4FuznZOUsDQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 04/26] board: powerpc: Remove P3041DS support
Date: Fri,  9 Oct 2026 22:09:54 +0000
Message-ID: <20261009221017.20385-5-brads@mainlining.org>
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

