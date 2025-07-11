Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E4C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 13:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC02803DF;
	Fri, 11 Jul 2025 15:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5A882063; Fri, 11 Jul 2025 14:39:39 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBC2805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7d7f0fcef86so198717985a.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 05:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752237575; x=1752842375;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MX6bbDDfWL4DVXk7tLcFMvx7enmA6N8hr6cAzq+q/PA=;
 b=DyK1yLozqar1pVdfgPx8H9RaORHhTQYSqcndZsI20jacs2gEZJQMWKzTDpQJ9ftXEm
 d9ZhlTjYsh5Nq91gAMH0kONMdBD5FjccdJVs0rfhXVmYQhMYN0OkxPIq0cAnBAau7mxM
 1eUbkG5V8tqKofjnW+dbd1bE+drgxGiONTHXP+/QJgWaDGW8nIAnPkSRATKKbJEd9zMX
 m//7jHHy+MpY5JNsmYlidrxOXymr9fSS+Ve2bhMVzzOHwhwo3ZFt2xObTXPWRGc5uUOu
 36YrSxlV+7+WvUzbxIKbeEBw2iqb+VmKr3hKJxQrJXumn2VuQvxFdq0Vn5VYwGNXNmbc
 9OTw==
X-Gm-Message-State: AOJu0Yx0JIxy8bIPlSI5BaP2R4sEUhZI+crmDoj9001rgy9ZK44Rs2Ne
 3kWC9+76qmcgoZ2JlIxI+YWWNk7gZGo0BS5NNX7OXcq+5luRrdArQUOU1v3iLxZZ
X-Gm-Gg: ASbGnctguuW99xiuXiZjP7joL+BpeRkvPIuN2HzbJIi1lO8wRmY45VOGSd0H6pIcQu9
 N0rWzASSs3z1g0Fjh+SbmbEVeYL1pBsOPMF4jYpJQhQJBefgPoKZl1kREFdcS/rn6E/clX3A5Ee
 ivebm/Gb9BvyI+PzDLnofIwjd8RzAZO2DrxvYV/hXgRm7MS4hIRH8wveN8e56knRcCCZvclf+BG
 QhmceT5ZwZ34xFru+YLEwgqAFyLEBbctyFc+blt7y4iI1mLc+cdBo1omq1wNHm6i4lo8X5MrFUO
 I9sm4d4wztxmEd1KDKEBuJB67nmGSFOYxTwRfWc5WvbIKtOSeyVAX+6i/E9v+iZlZluDXy1VgJ2
 j2Lu0088Kzhrvk/Vil0AJQ4nkf4KkAbACFr3rQgcbxv4=
X-Google-Smtp-Source: AGHT+IHT2s+J3+OJLSxCsZ4dDOP/ZDsMqPCGBbEKl7jFMoe4ksPCSw28a6FeVkuhXEXKsOD7U0ApGg==
X-Received: by 2002:a05:620a:2a15:b0:7db:fdfc:5591 with SMTP id
 af79cd13be357-7ddec744aadmr602613685a.48.1752237575169; 
 Fri, 11 Jul 2025 05:39:35 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcdbb2583bsm218783785a.8.2025.07.11.05.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 05:39:34 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>,marek.vasut+renesas@mailbox.org
Date: Fri, 11 Jul 2025 14:39:32 +0200
Message-Id: <175223757242.14072.4447733023600486815.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH] net: sh_eth: Cleanup the driver to remove most
X-Mailman-Approved-At: Fri, 11 Jul 2025 15:20:21 +0200
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

Cleanup the sh_eth.c and sh_eth.h files to get rid of #ifdefs and
replace with DT compat string checks where appropriate.

In the sh_eth driver the offset tables (such as sh_eth_offset_rz[])
are so far used to determine the location of the registers, but with
this patch the offset table is now also used to determine during run
time if registers are are present or not. This is expected to work for
all registers except EDSR.

The functions sh_eth_reg_present() and sh_eth_write_if_present() may be
used to check if a register is present and also perform a conditional
write only in case the register is present.

In the patch sh_eth_offset_rz[] is reworked to try to make it match
the RZ/A1 datasheet. The somewhat funny ordering is there to make it
match the documentation. The code has been ping tested on RZ/A1 Genmai
so the reworked offset table at least shows some sign of correctness.

The RZ/A1 and RZ/A2 cases are switched over from TYPE_RZ to TYPE_GETHER,
however the sh_eth_reg_offs() function (formerly sh_eth_reg_addr()) has
been reworked to follow a certain order that prioritizes CONFIG_RZA1 and
CONFIG_RZA2 over the gigabit offset table. This ordering also applies to
plenty of the bit definition #ifdefs in sh_eth.h.

Please note that sh_eth_is_gether() does not care about the offset table,
it returns true on RZ even though different offset tables are used. Right
now it is used to determine if the device comes with a self-clearing reset
bit or not.

This means that RZ/A1 and RZ/A2 are similar to devices with GETHER in many
ways but with different offset tables and also no gigabit support.

Also some recently introduced #ifdef gets reworked to instead use
run time matching on DT compat string "renesas,gether-r8a77980".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of u-boot master 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
 and
 [PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
 also 5f520875bdf has been reverted to work around build issues

 drivers/net/sh_eth.c |  167 ++++++++++++++++++++++++--------------------------
 drivers/net/sh_eth.h |  115 +++++++++++++++++++++-------------
 2 files changed, 155 insertions(+), 127 deletions(-)

--- 0004/drivers/net/sh_eth.c
+++ work/drivers/net/sh_eth.c	2025-07-11 20:31:22.438699670 +0900
@@ -29,6 +29,8 @@
 
 #include "sh_eth.h"
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static void flush_cache_wback(void *addr, unsigned long len)
 {
 	flush_dcache_range((unsigned long)addr,
@@ -142,34 +144,34 @@ static void sh_eth_recv_finish(struct sh
 
 static int sh_eth_reset(struct sh_eth_info *port_info)
 {
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 	int ret = 0, i;
-#if !defined(CONFIG_RZA2)
-	/* Start e-dmac transmitter and receiver */
-	sh_eth_write(port_info, EDSR_ENALL, EDSR);
-#endif
-	/* Perform a software reset and wait for it to complete */
-	sh_eth_write(port_info, EDMR_SRST, EDMR);
-	for (i = 0; i < TIMEOUT_CNT; i++) {
-		if (!(sh_eth_read(port_info, EDMR) & EDMR_SRST))
-			break;
-		udelay(1000);
-	}
 
-	if (i == TIMEOUT_CNT) {
-		printf(SHETHER_NAME  ": Software reset timeout\n");
-		ret = -EIO;
+	if (sh_eth_is_gether(port_info)) {
+		/* Start e-dmac transmitter and receiver */
+		sh_eth_write(port_info, EDSR_ENALL, EDSR);
+
+		/* Perform a software reset and wait for it to complete */
+		sh_eth_write(port_info, EDMR_SRST, EDMR);
+		for (i = 0; i < TIMEOUT_CNT; i++) {
+			if (!(sh_eth_read(port_info, EDMR) & EDMR_SRST))
+				break;
+			udelay(1000);
+		}
+
+		if (i == TIMEOUT_CNT) {
+			printf(SHETHER_NAME  ": Software reset timeout\n");
+			ret = -EIO;
+		}
+	} else {
+		/* no self-clearing bit */
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, EDMR) | EDMR_SRST, EDMR);
+		mdelay(3);
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, EDMR) & ~EDMR_SRST, EDMR);
 	}
 
 	return ret;
-#else
-	sh_eth_write(port_info, sh_eth_read(port_info, EDMR) | EDMR_SRST, EDMR);
-	mdelay(3);
-	sh_eth_write(port_info,
-		     sh_eth_read(port_info, EDMR) & ~EDMR_SRST, EDMR);
-
-	return 0;
-#endif
 }
 
 static int sh_eth_tx_desc_init(struct sh_eth_info *port_info)
@@ -213,13 +215,11 @@ static int sh_eth_tx_desc_init(struct sh
 	 * addresses
 	 */
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->tx_desc_base), TDLAR);
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
-	sh_eth_write(port_info, ADDR_TO_PHY(port_info->tx_desc_base), TDFAR);
-#if !defined(CONFIG_RZA2)
-	sh_eth_write(port_info, ADDR_TO_PHY(cur_tx_desc), TDFXR);
-	sh_eth_write(port_info, 0x01, TDFFR);/* Last discriptor bit */
-#endif
-#endif
+	sh_eth_write_if_present(port_info,
+				ADDR_TO_PHY(port_info->tx_desc_base),
+				TDFAR);
+	sh_eth_write_if_present(port_info, ADDR_TO_PHY(cur_tx_desc), TDFXR);
+	sh_eth_write_if_present(port_info, 0x01, TDFFR);/* Last desc bit */
 
 err:
 	return ret;
@@ -282,13 +282,11 @@ static int sh_eth_rx_desc_init(struct sh
 
 	/* Point the controller to the rx descriptor list */
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->rx_desc_base), RDLAR);
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
-	sh_eth_write(port_info, ADDR_TO_PHY(port_info->rx_desc_base), RDFAR);
-#if !defined(CONFIG_RZA2)
-	sh_eth_write(port_info, ADDR_TO_PHY(cur_rx_desc), RDFXR);
-	sh_eth_write(port_info, RDFFR_RDLF, RDFFR);
-#endif
-#endif
+	sh_eth_write_if_present(port_info,
+				ADDR_TO_PHY(port_info->rx_desc_base),
+				RDFAR);
+	sh_eth_write_if_present(port_info, ADDR_TO_PHY(cur_rx_desc), RDFXR);
+	sh_eth_write_if_present(port_info, RDFFR_RDLF, RDFFR);
 
 	return ret;
 
@@ -353,7 +351,9 @@ static void sh_eth_write_hwaddr(struct s
 	sh_eth_write(port_info, val, MALR);
 }
 
-static void sh_eth_mac_regs_config(struct sh_eth_info *port_info, unsigned char *mac)
+static void sh_eth_mac_regs_config(struct sh_eth_info *port_info,
+				   unsigned char *mac,
+				   int node)
 {
 	unsigned long edmr;
 
@@ -361,9 +361,11 @@ static void sh_eth_mac_regs_config(struc
 	edmr = sh_eth_read(port_info, EDMR);
 	edmr &= ~EMDR_DESC_R;
 	edmr |= EMDR_DESC | EDMR_EL;
-#if defined(CONFIG_R8A77980)
-	edmr |= EDMR_NBST;
-#endif
+
+	if (fdt_node_check_compatible(gd->fdt_blob, node,
+				      "renesas,gether-r8a77980") == 0)
+		edmr |= EDMR_NBST;
+
 	sh_eth_write(port_info, edmr, EDMR);
 
 	sh_eth_write(port_info, 0, EESIPR);
@@ -371,9 +373,7 @@ static void sh_eth_mac_regs_config(struc
 	sh_eth_write(port_info, 0, TFTR);
 	sh_eth_write(port_info, (FIFO_SIZE_T | FIFO_SIZE_R), FDR);
 	sh_eth_write(port_info, RMCR_RST, RMCR);
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
-	sh_eth_write(port_info, 0, RPADIR);
-#endif
+	sh_eth_write_if_present(port_info, 0, RPADIR);
 	sh_eth_write(port_info, (FIFO_F_D_RFF | FIFO_F_D_RFD), FCFTR);
 
 	/* Configure e-mac registers */
@@ -383,66 +383,61 @@ static void sh_eth_mac_regs_config(struc
 	sh_eth_write_hwaddr(port_info, mac);
 
 	sh_eth_write(port_info, RFLR_RFL_MIN, RFLR);
-#if defined(SH_ETH_TYPE_GETHER)
-	sh_eth_write(port_info, 0, PIPR);
-#endif
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
-	sh_eth_write(port_info, APR_AP, APR);
-	sh_eth_write(port_info, MPR_MP, MPR);
-	sh_eth_write(port_info, TPAUSER_TPAUSE, TPAUSER);
-#endif
 
-#if defined(CONFIG_CPU_SH7734) || defined(CONFIG_R8A7740)
-	sh_eth_write(port_info, CONFIG_SH_ETHER_SH7734_MII, RMII_MII);
-#elif defined(CONFIG_RCAR_GEN2) || defined(CONFIG_R8A77980)
-	sh_eth_write(port_info, sh_eth_read(port_info, RMIIMR) | 0x1, RMIIMR);
+	sh_eth_write_if_present(port_info, 0, PIPR);
+	sh_eth_write_if_present(port_info, APR_AP, APR);
+	sh_eth_write_if_present(port_info, MPR_MP, MPR);
+	sh_eth_write_if_present(port_info, TPAUSER_TPAUSE, TPAUSER);
+
+#ifdef CONFIG_SH_ETHER_SH7734_MII
+	sh_eth_write_if_present(port_info,
+				CONFIG_SH_ETHER_SH7734_MII,
+				RMII_MII);
 #endif
+	if (sh_eth_reg_present(port_info, RMIIMR))
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, RMIIMR) | 0x1,
+			     RMIIMR);
 }
 
 static int sh_eth_phy_regs_config(struct sh_eth_info *port_info)
 {
 	struct phy_device *phy = port_info->phydev;
 	int ret = 0;
-	u32 val = 0;
+	u32 val = ECMR_CHG_DM | ECMR_RE | ECMR_TE;
 
 	/* Set the transfer speed */
 	if (phy->speed == 100) {
 		printf(SHETHER_NAME ": 100Base/");
-#if defined(SH_ETH_TYPE_GETHER)
-		sh_eth_write(port_info, GECMR_100B, GECMR);
-#elif defined(CONFIG_CPU_SH7757) || defined(CONFIG_CPU_SH7752)
-		sh_eth_write(port_info, 1, RTRATE);
-#elif defined(CONFIG_RCAR_GEN2) || defined(CONFIG_R8A77980) || defined(CONFIG_RZA2)
-		val = ECMR_RTM;
-#endif
+		if (sh_eth_reg_present(port_info, GECMR) ||
+		    sh_eth_reg_present(port_info, RTRATE)) {
+			sh_eth_write_if_present(port_info, GECMR_100B, GECMR);
+			sh_eth_write_if_present(port_info, 1, RTRATE);
+		} else {
+			val |= ECMR_RTM;
+		}
 	} else if (phy->speed == 10) {
 		printf(SHETHER_NAME ": 10Base/");
-#if defined(SH_ETH_TYPE_GETHER)
-		sh_eth_write(port_info, GECMR_10B, GECMR);
-#elif defined(CONFIG_CPU_SH7757) || defined(CONFIG_CPU_SH7752)
-		sh_eth_write(port_info, 0, RTRATE);
-#endif
-	}
-#if defined(SH_ETH_TYPE_GETHER)
-	else if (phy->speed == 1000) {
+		sh_eth_write_if_present(port_info, GECMR_10B, GECMR);
+		sh_eth_write_if_present(port_info, 0, RTRATE);
+	} else if ((phy->speed == 1000) &&
+		 sh_eth_reg_present(port_info, GECMR)) {
 		printf(SHETHER_NAME ": 1000Base/");
 		sh_eth_write(port_info, GECMR_1000B, GECMR);
+	} else {
+		ret = -EINVAL;
 	}
-#endif
 
 	/* Check if full duplex mode is supported by the phy */
 	if (phy->duplex) {
 		printf("Full\n");
-		sh_eth_write(port_info,
-			     val | (ECMR_CHG_DM | ECMR_RE | ECMR_TE | ECMR_DM),
-			     ECMR);
+		val |= ECMR_DM;
 	} else {
 		printf("Half\n");
-		sh_eth_write(port_info,
-			     val | (ECMR_CHG_DM | ECMR_RE | ECMR_TE),
-			     ECMR);
 	}
 
+	sh_eth_write(port_info, val, ECMR);
+
 	return ret;
 }
 
@@ -460,7 +455,9 @@ static void sh_eth_stop(struct sh_eth_in
 	sh_eth_write(port_info, ~EDRRR_R, EDRRR);
 }
 
-static int sh_eth_init_common(struct sh_eth_info *port_info, unsigned char *mac)
+static int sh_eth_init_common(struct sh_eth_info *port_info,
+			      unsigned char *mac,
+			      int node)
 {
 	int ret = 0;
 
@@ -472,7 +469,7 @@ static int sh_eth_init_common(struct sh_
 	if (ret)
 		return ret;
 
-	sh_eth_mac_regs_config(port_info, mac);
+	sh_eth_mac_regs_config(port_info, mac, node);
 
 	return 0;
 }
@@ -584,7 +581,8 @@ static int sh_ether_start(struct udevice
 	struct sh_eth_info *port_info = &priv->port_info;
 	int ret;
 
-	ret = sh_eth_init_common(port_info, pdata->enetaddr);
+	ret = sh_eth_init_common(port_info, pdata->enetaddr,
+				 dev_of_offset(dev));
 	if (ret)
 		return ret;
 
@@ -729,7 +727,7 @@ static int sh_ether_probe(struct udevice
 #ifdef BASE_IO_ADDR
 	port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
 #else
-	port_info->iobase = (void __iomem *)pdata->iobase;
+	port_info->iobase = (void __iomem *)pdata->iobase; /* from DT */
 #endif
 
 #if CONFIG_IS_ENABLED(CLK)
@@ -738,7 +736,8 @@ static int sh_ether_probe(struct udevice
 		goto err_mdio_register;
 #endif
 
-	ret = sh_eth_init_common(port_info, pdata->enetaddr);
+	ret = sh_eth_init_common(port_info, pdata->enetaddr,
+				 dev_of_offset(udev));
 	if (ret)
 		goto err_phy_config;
 
--- 0004/drivers/net/sh_eth.h
+++ work/drivers/net/sh_eth.h	2025-07-11 20:46:28.154019272 +0900
@@ -213,7 +213,7 @@ static const u16 sh_eth_offset_gigabit[S
 };
 
 static const u16 sh_eth_offset_rz[SH_ETH_MAX_REGISTER_OFFSET] = {
-	[EDSR]	= 0x0000,
+	[EDSR]	= 0x0000, /* EDSR0 @ 0xE8203000 */
 	[EDMR]	= 0x0400,
 	[EDTRR]	= 0x0408,
 	[EDRRR]	= 0x0410,
@@ -236,34 +236,37 @@ static const u16 sh_eth_offset_rz[SH_ETH
 	[FCFTR]	= 0x0468,
 	[CSMR] = 0x04E4,
 
-	[ECMR]	= 0x0500,
+	[ECMR]	= 0x0500, /* ECMR0 @ 0xE8203500 */
 	[ECSR]	= 0x0510,
 	[ECSIPR]	= 0x0518,
 	[PIR]	= 0x0520,
-	[PSR]	= 0x0528,
-	[PIPR]	= 0x052c,
-	[RFLR]	= 0x0508,
-	[APR]	= 0x0554,
-	[MPR]	= 0x0558,
-	[PFTCR]	= 0x055c,
-	[PFRCR]	= 0x0560,
-	[TPAUSER]	= 0x0564,
-	[GECMR]	= 0x05b0,
-	[BCULR]	= 0x05b4,
 	[MAHR]	= 0x05c0,
 	[MALR]	= 0x05c8,
-	[TROCR]	= 0x0700,
-	[CDCR]	= 0x0708,
-	[LCCR]	= 0x0710,
+	[RFLR]	= 0x0508,
 	[CEFCR]	= 0x0740,
 	[FRECR]	= 0x0748,
 	[TSFRCR]	= 0x0750,
 	[TLFRCR]	= 0x0758,
 	[RFCR]	= 0x0760,
-	[CERCR]	= 0x0768,
-	[CEECR]	= 0x0770,
 	[MAFCR]	= 0x0778,
-	[RMII_MII] =  0x0790,
+	[APR]	= 0x0554,
+	[MPR]	= 0x0558,
+	[TPAUSER]	= 0x0564,
+	[PFTCR]	= 0x055c,
+	[PFRCR]	= 0x0560,
+
+	// according to RZ/A1H Group, RZ/A1M Group Users Manual: Hardware
+	// Rev.6.00 Jan 2021, the following registers do not exist
+	//[PSR]	= 0x0528,
+	//[PIPR]	= 0x052c,
+	//[GECMR]	= 0x05b0,
+	//[BCULR]	= 0x05b4,
+	//[TROCR]	= 0x0700,
+	//[CDCR]	= 0x0708,
+	//[LCCR]	= 0x0710,
+	//[CERCR]	= 0x0768,
+	//[CEECR]	= 0x0770,
+	//[RMII_MII] =  0x0790,
 };
 
 static const u16 sh_eth_offset_fast_sh4[SH_ETH_MAX_REGISTER_OFFSET] = {
@@ -340,9 +343,9 @@ static const u16 sh_eth_offset_fast_sh4[
 #define SH_ETH_TYPE_ETHER
 #define BASE_IO_ADDR	0xEE700200
 #elif defined(CONFIG_RZA1)
-#define SH_ETH_TYPE_RZ
+#define SH_ETH_TYPE_GETHER
 #elif defined(CONFIG_RZA2)
-#define SH_ETH_TYPE_RZ
+#define SH_ETH_TYPE_GETHER
 #elif defined(CONFIG_R8A77980)
 #define SH_ETH_TYPE_GETHER
 #define BASE_IO_ADDR	0xE7400000
@@ -352,7 +355,7 @@ static const u16 sh_eth_offset_fast_sh4[
  * Register's bits
  * Copy from Linux driver source code
  */
-#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
+#if defined(SH_ETH_TYPE_GETHER)
 /* EDSR */
 enum EDSR_BIT {
 	EDSR_ENT = 0x01, EDSR_ENR = 0x02,
@@ -364,12 +367,12 @@ enum EDSR_BIT {
 enum DMAC_M_BIT {
 	EDMR_NBST	= 0x80, /* DMA transfer burst mode */
 	EDMR_DL1 = 0x20, EDMR_DL0 = 0x10,
-#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
-	EDMR_SRST	= 0x03, /* Receive/Send reset */
+#if defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
+	EDMR_SRST	= 0x01,
 	EMDR_DESC_R	= 0x30, /* Descriptor reserve size */
 	EDMR_EL		= 0x40, /* Litte endian */
-#elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
-	EDMR_SRST	= 0x01,
+#elif defined(SH_ETH_TYPE_GETHER)
+	EDMR_SRST	= 0x03, /* Receive/Send reset */
 	EMDR_DESC_R	= 0x30, /* Descriptor reserve size */
 	EDMR_EL		= 0x40, /* Litte endian */
 #else
@@ -390,7 +393,7 @@ enum DMAC_M_BIT {
 
 /* EDTRR */
 enum DMAC_T_BIT {
-#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
+#if defined(SH_ETH_TYPE_GETHER)
 	EDTRR_TRNS = 0x03,
 #else
 	EDTRR_TRNS = 0x01,
@@ -463,7 +466,7 @@ enum EESR_BIT {
 	EESR_PRE  = 0x00000002, EESR_CERF = 0x00000001,
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER)
 # define TX_CHECK (EESR_TC1 | EESR_FTC)
 # define EESR_ERR_CHECK	(EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE \
 		| EESR_RFRMER | EESR_TFE | EESR_TDE | EESR_ECI)
@@ -523,8 +526,7 @@ enum FCFTR_BIT {
 
 /* Transfer descriptor bit */
 enum TD_STS_BIT {
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_ETHER) || \
-	defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_ETHER)
 	TD_TACT = 0x80000000,
 #else
 	TD_TACT = 0x7fffffff,
@@ -540,7 +542,7 @@ enum TD_STS_BIT {
 enum RECV_RST_BIT { RMCR_RST = 0x01, };
 /* ECMR */
 enum FELIC_MODE_BIT {
-#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
+#if defined(SH_ETH_TYPE_GETHER)
 	ECMR_TRCCM = 0x04000000, ECMR_RCSC = 0x00800000,
 	ECMR_DPAD = 0x00200000, ECMR_RZPF = 0x00100000,
 #endif
@@ -551,17 +553,17 @@ enum FELIC_MODE_BIT {
 	ECMR_PRM = 0x00000001,
 #ifdef CONFIG_CPU_SH7724
 	ECMR_RTM = 0x00000010,
-#elif defined(CONFIG_RCAR_GEN2) || defined (CONFIG_R8A77980) || defined(CONFIG_RZA2)
+#else
 	ECMR_RTM = 0x00000004,
 #endif
 
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
+#if defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
+#define ECMR_CHG_DM (ECMR_ZPF | ECMR_PFR | ECMR_RXF | ECMR_TXF)
+#elif defined(SH_ETH_TYPE_GETHER)
 #define ECMR_CHG_DM (ECMR_TRCCM | ECMR_RZPF | ECMR_ZPF | ECMR_PFR | \
 			ECMR_RXF | ECMR_TXF | ECMR_MCT)
-#elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
-#define ECMR_CHG_DM (ECMR_ZPF | ECMR_PFR | ECMR_RXF | ECMR_TXF)
 #else
 #define ECMR_CHG_DM	(ECMR_ZPF | ECMR_PFR | ECMR_RXF | ECMR_TXF | ECMR_MCT)
 #endif
@@ -575,7 +577,7 @@ enum ECSR_STATUS_BIT {
 	ECSR_MPD = 0x02, ECSR_ICD = 0x01,
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER)
 # define ECSR_INIT (ECSR_ICD | ECSIPR_MPDIP)
 #else
 # define ECSR_INIT (ECSR_BRCRX | ECSR_PSRTO | \
@@ -596,7 +598,7 @@ enum ECSIPR_STATUS_MASK_BIT {
 	ECSIPR_ICDIP = 0x01,
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER)
 # define ECSIPR_INIT (ECSIPR_LCHNGIP | ECSIPR_ICDIP | ECSIPR_MPDIP)
 #else
 # define ECSIPR_INIT (ECSIPR_BRCRXIP | ECSIPR_PSRTOIP | ECSIPR_LCHNGIP | \
@@ -627,7 +629,7 @@ enum RPADIR_BIT {
 	RPADIR_PADR = 0x0003f,
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER)
 # define RPADIR_INIT (0x00)
 #else
 # define RPADIR_INIT (RPADIR_PADS1)
@@ -638,19 +640,39 @@ enum FIFO_SIZE_BIT {
 	FIFO_SIZE_T = 0x00000700, FIFO_SIZE_R = 0x00000007,
 };
 
-static inline unsigned long sh_eth_reg_addr(struct sh_eth_info *port,
+static inline unsigned long sh_eth_reg_offs(struct sh_eth_info *port,
 					    int enum_index)
 {
-#if defined(SH_ETH_TYPE_GETHER)
-	const u16 *reg_offset = sh_eth_offset_gigabit;
+	/* order is important here, RZA1/RZA2 are also TYPE_GETHER */
+#if defined(CONFIG_RZA1)
+	const u16 *reg_offset = sh_eth_offset_rz;
 #elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
 	const u16 *reg_offset = sh_eth_offset_fast_sh4;
-#elif defined(CONFIG_RZA1)
-	const u16 *reg_offset = sh_eth_offset_rz;
+#elif defined(SH_ETH_TYPE_GETHER)
+	const u16 *reg_offset = sh_eth_offset_gigabit;
 #else
 #error
 #endif
-	return (unsigned long)port->iobase + reg_offset[enum_index];
+	return reg_offset[enum_index];
+}
+
+static inline unsigned long sh_eth_reg_addr(struct sh_eth_info *port, int idx)
+{
+	return (unsigned long)port->iobase + sh_eth_reg_offs(port, idx);
+}
+
+static inline int sh_eth_reg_present(struct sh_eth_info *port, int idx)
+{
+	return !!sh_eth_reg_offs(port, idx);
+}
+
+static inline int sh_eth_is_gether(struct sh_eth_info *port)
+{
+#if defined(SH_ETH_TYPE_GETHER)
+	return 1;
+#else
+	return 0;
+#endif
 }
 
 static inline void sh_eth_write(struct sh_eth_info *port, unsigned long data,
@@ -659,6 +681,13 @@ static inline void sh_eth_write(struct s
 	outl(data, sh_eth_reg_addr(port, enum_index));
 }
 
+static inline void sh_eth_write_if_present(struct sh_eth_info *port,
+					   unsigned long data, int enum_index)
+{
+	if (sh_eth_reg_present(port, enum_index))
+		outl(data, sh_eth_reg_addr(port, enum_index));
+}
+
 static inline unsigned long sh_eth_read(struct sh_eth_info *port,
 					int enum_index)
 {
