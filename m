Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9458C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 08:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FED980836;
	Fri, 11 Jul 2025 10:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE5D582998; Fri, 11 Jul 2025 09:35:14 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60667805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7da6ca0f1acso198551985a.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752219311; x=1752824111;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XD1WDuX7kDoQ7+NVEM/5HFQAfdQeXCvWH5MBrXl0jo=;
 b=I/JotXj7yhkBj/UHYHLd+c7mkd4y9mP8TrtD05WI0Pdrr/GraQpzbjzCvAYNuPOQV8
 q+D8mW9FQh5p7u2QB4z6UKT/2tZeTu0yijqX7ybuyEzgFqOoULEt4W+ov/TpbP9Q5c0z
 gfdpsKOYoWlBcgJHVr70tKhTpCdQnidx1tbom7ZlK5tb3vD5tl1aWdvMSE/ppR9nSNub
 AgRy11s8upyvuZFRbiz17V4S0RdxrMaI/fxvS8KDWOuTgAl3UYcWanQMlv0YFZ+ySpWm
 cuEi4Ghtd93cOfDvANY5MzHMHlTZO1aBnJlwxPryqiIKG73l2xr3rj6M7L0NBJryJVKX
 +5GQ==
X-Gm-Message-State: AOJu0YzQLkw9vJdZyAoDSunaFeemi1S/+xT21XRm93xTS3RjoDV4jejD
 V7MutRurwldG4KuVT9W8f3z7Chk3nk7fsLV2fbO+GbtvwlbVPGdNRjc720FKiXmZ
X-Gm-Gg: ASbGnctfpvvPYBzlsrkN5SMvwiTeycr3P8lVCuy+6iHShlMw9/CGJUe5Bjw1jg/+lCU
 +E2NKMad7Eg6A51Fef8YDisyGJx7CJnFTIY43Rgx1eLVb2P7VyYCqJC9NwocLKSTOAGsnVOMkZ/
 yIK3Yloz4cnN0eVz5R//Zm5F4xYFzSU5ZPY7rrUgufKx7XjT+L4xfxUMXP5HoVy9biYfxK6OzFX
 TpbvMqRPxYXeVqM+rvOqSxe1YQgZiokmuIn6O/6r6XV1FPqHeUniZ2Z3oHtvndzFFUhnxuc1IlP
 EtwptYYsJiuzCBW2fvP7fvhu3abR6AYVnX2W9YYIOn+4p6BAUGqbsH6RhZk+4tTZapd8h5oHQwy
 5+Me3np6W564ca6uhZxgUijl6FlWT0nsdSS5fRGIkZ0B380Awsg65rDvXlAZs65ByCQg=
X-Google-Smtp-Source: AGHT+IHh5IHGmRXLGaLSvSScPZ+JdZmnmyrPrTkhd2Fqs1wnko4jFQ5+L0gk95fxaT1eCWnuRf6sVA==
X-Received: by 2002:a05:620a:178e:b0:7c5:5cd6:5cf2 with SMTP id
 af79cd13be357-7ddea0350f8mr345514885a.17.1752219310845; 
 Fri, 11 Jul 2025 00:35:10 -0700 (PDT)
Received: from bjoern-magnuss-macbook-pro.local ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcdc0fa32asm198217985a.48.2025.07.11.00.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 00:35:10 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>,marek.vasut+renesas@mailbox.org
Date: Fri, 11 Jul 2025 09:35:08 +0200
Message-Id: <175221930820.13074.8101998451225642919.sendpatchset@bjoern-magnuss-macbook-pro.local>
Subject: [PATCH] RZ/A1 Genmai SDRAM setup prototype
X-Mailman-Approved-At: Fri, 11 Jul 2025 10:15:12 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Magnus Damm <damm@opensource.se>

Here's a hack that adds SDRAM setup code to the r7s72100 Genmai board.

Might be useful in case someone wants to boot Linux on the Genmai board.

Before merge a few unclear points remain:
 - How to make best use of the on-chip SDRAM?
   The U-Boot DTS currently has a node for the 10 MiB at 0x20000000
   Also used by CONFIG_CUSTOM_SYS_INIT_SP_ADDR in renesas_rza1.config
 - CONFIG_NR_DRAM_BANKS is set to 3 but lmb_dump_all shows 2 (see below).
 - It would be nicer to use DT for the pinmux instead of RZA1_PINMUX()

Serial Console Log:

U-Boot 2025.07 (Jul 11 2025 - 16:12:56 +0900)                                  
                                                                               
Model: Genmai                                                                  
DRAM:  10 MiB (total 138 MiB)                                                  
Core:  30 devices, 12 uclasses, devicetree: separate                           
Loading Environment from MTD... *** Warning - get_mtd_device_nm() failed, usingt
                                                                               
In:    serial@e8008000                                                         
Out:   serial@e8008000                                                         
Err:   serial@e8008000                                                         
Net:                                                                           
Warning: ethernet@e8203000 (eth0) using random MAC address - 9e:a3:2c:7a:0f:3a 
eth0: ethernet@e8203000                                                        
=> bd                                                                          
boot_params = 0x20000100                                                       
DRAM bank   = 0x00000000                                                       
-> start    = 0x08000000                                                       
-> size     = 0x04000000                                                       
DRAM bank   = 0x00000001                                                       
-> start    = 0x0c000000                                                       
-> size     = 0x04000000                                                       
DRAM bank   = 0x00000002                                                       
-> start    = 0x20000000                                                       
-> size     = 0x00a00000                                                       
flashstart  = 0x00000000                                                       
flashsize   = 0x00000000                                                       
flashoffset = 0x00000000                                                       
baudrate    = 115200 bps                                                       
relocaddr   = 0x209b5000                                                       
reloc off   = 0x209b5000                                                       
Build       = 32-bit                                                           
current eth = ethernet@e8203000                                                
ethaddr     = 9e:a3:2c:7a:0f:3a                                                
IP addr     = <NULL>                                                           
fdt_blob    = 0x208afac0                                                       
lmb_dump_all:                                                                  
 memory.count = 0x2                                                            
 memory[0]      [0x8000000-0xfffffff], 0x8000000 bytes, flags: none            
 memory[1]      [0x20000000-0x209fffff], 0xa00000 bytes, flags: none           
 reserved.count = 0x0                                                          
devicetree  = separate                                                         
arch_number = 0x00000000                                                       
TLB addr    = 0x209f0000                                                       
irq_sp      = 0x208afab0                                                       
sp start    = 0x208afaa0                                                       
Early malloc usage: 3bc / 400                                                  
=> 

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of u-boot master 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
   also 5f520875bdf reverted to work around build issues

 board/renesas/genmai/genmai.c                    |  112 +++++++++++++++++++---
 configs/genmai_defconfig                         |    5 
 configs/grpeach_defconfig                        |    2 
 configs/renesas_rza1.config                      |    1 
 dts/upstream/src/arm/renesas/r7s72100-genmai.dts |   22 +++-
 5 files changed, 124 insertions(+), 18 deletions(-)
 
--- 0001/board/renesas/genmai/genmai.c
+++ work/board/renesas/genmai/genmai.c	2025-07-11 16:11:32.621707802 +0900
@@ -12,6 +12,16 @@
 #define CS0WCR		(RZA1_BCR_BASE + 0x28)
 #define CS1BCR		(RZA1_BCR_BASE + 0x08)
 #define CS1WCR		(RZA1_BCR_BASE + 0x2c)
+#define CS2BCR		(RZA1_BCR_BASE + 0x0c)
+#define CS2WCR		(RZA1_BCR_BASE + 0x30)
+#define CS3BCR		(RZA1_BCR_BASE + 0x10)
+#define CS3WCR		(RZA1_BCR_BASE + 0x34)
+#define SDCR		(RZA1_BCR_BASE + 0x4c)
+#define RTCOR		(RZA1_BCR_BASE + 0x58)
+#define RTCSR		(RZA1_BCR_BASE + 0x50)
+
+#define SDRAM_MODE_CS2 0x3FFFD040 /* CS2: CAS=2, burst write, 16bit bus */
+#define SDRAM_MODE_CS3 0x3FFFE040 /* CS3: CAS=2, burst write, 16bit bus */
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -27,23 +37,101 @@ int board_init(void)
 	return 0;
 }
 
-/*
- * The Genmai DT will most likely contain memory nodes describing the external
- * SDRAM memory connected to CS2 and CS3, however we do not yet have any code
- * in U-Boot to setup the memory controller. For now ignore DT and make use of
- * the RZ/A1H on-chip memory which is 10 MiB at CFG_SYS_SDRAM_BASE.
- */
+// nicked from pinctrl-rza1.c
+#define PINCTRL_BASE 0xfcfe3000
+#define PFC(b) (PINCTRL_BASE + 0x0500 + (b) * 4)
+#define PFCE(b) (PINCTRL_BASE + 0x0600 + (b) * 4)
+#define PMCSR(b) (PINCTRL_BASE + 0x0900 + (b) * 4)
+#define PFCAE(b) (PINCTRL_BASE + 0x0A00 + (b) * 4)
+#define PIBC(b) (PINCTRL_BASE + 0x4000 + (b) * 4)
+#define PBDC(b) (PINCTRL_BASE + 0x4100 + (b) * 4)
+#define PIPC(b) (PINCTRL_BASE + 0x4200 + (b) * 4)
+
+static void pinctrl(u16 ba, u16 li, u16 fu, u16 in, u16 bi)
+{
+	clrsetbits_le16(PFCAE(ba), BIT(li), (fu & BIT(2)) ? BIT(li) : 0);
+	clrsetbits_le16(PFCE(ba), BIT(li), (fu & BIT(1)) ? BIT(li) : 0);
+	clrsetbits_le16(PFC(ba), BIT(li), (fu & BIT(0)) ? BIT(li) : 0);
+	clrsetbits_le16(PIBC(ba), BIT(li), in ? BIT(li) : 0);
+	clrsetbits_le16(PBDC(ba), BIT(li), bi ? BIT(li) : 0);
+	setbits_le32(PMCSR(ba), BIT(li + 16) | BIT(li));
+	setbits_le16(PIPC(ba), BIT(li));
+}
+
+#define RZA1_PINMUX(bank, line, func) pinctrl(bank, line, (func) - 1, 0, 0)
+#define RZA1_PINMUX_BI(bank, line, func) pinctrl(bank, line, (func) - 1, 0, 1)
+
+void setup_external_memory(void)
+{
+	/* Dual 16-bit SDRAM 'IS42S16320B-75' on CS2 and CS3 */
+	RZA1_PINMUX_BI(6, 0, 1); /* P6_0 = D0 */
+	RZA1_PINMUX_BI(6, 1, 1); /* P6_1 = D1 */
+	RZA1_PINMUX_BI(6, 2, 1); /* P6_2 = D2 */
+	RZA1_PINMUX_BI(6, 3, 1); /* P6_3 = D3 */
+	RZA1_PINMUX_BI(6, 4, 1); /* P6_4 = D4 */
+	RZA1_PINMUX_BI(6, 5, 1); /* P6_5 = D5 */
+	RZA1_PINMUX_BI(6, 6, 1); /* P6_6 = D6 */
+	RZA1_PINMUX_BI(6, 7, 1); /* P6_7 = D7 */
+	RZA1_PINMUX_BI(6, 8, 1); /* P6_8 = D8 */
+	RZA1_PINMUX_BI(6, 9, 1); /* P6_9 = D9 */
+	RZA1_PINMUX_BI(6, 10, 1); /* P6_10 = D10 */
+	RZA1_PINMUX_BI(6, 11, 1); /* P6_11 = D11 */
+	RZA1_PINMUX_BI(6, 12, 1); /* P6_12 = D12 */
+	RZA1_PINMUX_BI(6, 13, 1); /* P6_13 = D13 */
+	RZA1_PINMUX_BI(6, 14, 1); /* P6_14 = D14 */
+	RZA1_PINMUX_BI(6, 15, 1); /* P6_15 = D15 */
+	RZA1_PINMUX(7, 9, 1); /* P7_9 = A1 */
+	RZA1_PINMUX(7, 10, 1); /* P7_10 = A2 */
+	RZA1_PINMUX(7, 11, 1); /* P7_11 = A3 */
+	RZA1_PINMUX(7, 12, 1); /* P7_12 = A4 */
+	RZA1_PINMUX(7, 13, 1); /* P7_13 = A5 */
+	RZA1_PINMUX(7, 14, 1); /* P7_14 = A6 */
+	RZA1_PINMUX(7, 15, 1); /* P7_15 = A7 */
+	RZA1_PINMUX(8, 0, 1); /* P8_0 = A8 */
+	RZA1_PINMUX(8, 1, 1); /* P8_1 = A9 */
+	RZA1_PINMUX(8, 2, 1); /* P8_2 = A10 */
+	RZA1_PINMUX(8, 3, 1); /* P8_3 = A11 */
+	RZA1_PINMUX(8, 4, 1); /* P8_4 = A12 */
+	RZA1_PINMUX(8, 5, 1); /* P8_5 = A13 */
+	RZA1_PINMUX(8, 6, 1); /* P8_6 = A14 */
+	RZA1_PINMUX(8, 7, 1); /* P8_7 = A15 */
+	RZA1_PINMUX(7, 2, 1); /* P7_2 = RAS */
+	RZA1_PINMUX(7, 3, 1); /* P7_3 = CAS */
+	RZA1_PINMUX(7, 4, 1); /* P7_4 = CKE */
+	RZA1_PINMUX(7, 5, 1); /* P7_5 = RDWR */
+	RZA1_PINMUX(7, 6, 1); /* P7_6 = WE0/DQMLL */
+	RZA1_PINMUX(7, 7, 1); /* P7_7 = DQMLU */
+	RZA1_PINMUX(5, 8, 6); /* P5_8 = CS2 */
+	RZA1_PINMUX(7, 1, 1); /* P7_1 = CS3 */
+
+	/**********************************************/
+	/* Configure SDRAM (CS2, CS3)                 */
+	/**********************************************/
+
+	writel(0x00004c00, CS2BCR);
+	writel(0x00000080, CS2WCR);
+	writel(0x00004c00, CS3BCR);
+	writel(0x00002492, CS3WCR);
+	writel(0x00120812, SDCR);
+	writel(0xa55a0020, RTCOR);
+	writel(0xa55a0010, RTCSR);
+
+	for (int i = 0; i < 0x33f1; i++)
+		asm("nop");
+
+	writew(0, SDRAM_MODE_CS2);
+	writew(0, SDRAM_MODE_CS3);
+}
 
 int dram_init(void)
 {
-	gd->ram_base = CFG_SYS_SDRAM_BASE;
-	gd->ram_size = 10 << 20;
-	return 0;
+	/* 64 MiB SDRAM at 0x08000000 + 64 MiB SDRAM at 0x0c000000 */
+	setup_external_memory();
+
+	return fdtdec_setup_mem_size_base();
 }
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = gd->ram_size;
-	return 0;
+	return fdtdec_setup_memory_banksize();
 }
--- 0001/configs/genmai_defconfig
+++ work/configs/genmai_defconfig	2025-07-11 16:03:57.655983739 +0900
@@ -7,6 +7,11 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-genmai"
 CONFIG_TARGET_GENMAI=y
 
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SYS_MEMTEST_START=0x08000000
+CONFIG_SYS_MEMTEST_END=0x10000000
+CONFIG_CMD_MEMTEST=y
+
 CONFIG_ENV_IS_IN_MTD=y
 CONFIG_ENV_MTD_DEV="nor0"
 CONFIG_ENV_OFFSET=0x80000
--- 0001/configs/grpeach_defconfig
+++ work/configs/grpeach_defconfig	2025-07-11 16:04:10.694062244 +0900
@@ -6,6 +6,8 @@ CONFIG_TEXT_BASE=0x18000000
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r7s72100-gr-peach"
 CONFIG_TARGET_GRPEACH=y
 
+CONFIG_NR_DRAM_BANKS=1
+
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_DM_SPI_FLASH=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
--- 0001/configs/renesas_rza1.config
+++ work/configs/renesas_rza1.config	2025-07-11 16:02:42.505531236 +0900
@@ -31,7 +31,6 @@ CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MAC_PARTITION=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_PHY_SMSC=y
--- 0001/dts/upstream/src/arm/renesas/r7s72100-genmai.dts
+++ work/dts/upstream/src/arm/renesas/r7s72100-genmai.dts	2025-07-11 16:02:42.506531242 +0900
@@ -54,6 +54,11 @@
 		};
 	};
 
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x00a00000>;
+	};
+
 	keyboard {
 		compatible = "gpio-keys";
 
@@ -83,11 +88,6 @@
 		};
 	};
 
-	memory@8000000 {
-		device_type = "memory";
-		reg = <0x08000000 0x08000000>;
-	};
-
 	cvcc2: regulator-mmc {
 		compatible = "regulator-fixed";
 		regulator-name = "Cvcc2";
@@ -152,6 +152,18 @@
 			};
 		};
 	};
+
+	/* 64 MiB SDRAM connected to CS2 */
+	memory@8000000 {
+		device_type = "memory";
+		reg = <0x08000000 0x04000000>;
+	};
+
+	/* 64 MiB SDRAM connected to CS3 */
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x04000000>;
+	};
 };
 
 &ether {
