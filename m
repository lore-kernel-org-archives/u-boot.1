Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD713C83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2923D83092;
	Mon,  7 Jul 2025 00:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261C982F14; Sun,  6 Jul 2025 13:29:36 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D769D8277D
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4a6f0bcdf45so31223141cf.0
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801372; x=1752406172;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4IyP+lGMVbfNCQtjYP+9yqFwjpLy6W47LDhzbLRiqwk=;
 b=kTtMryuDTe8mVicdStCvqHEXaCdMU8UZDlcSX9LI7BV5e+LDRChgf/Es+ELb6QpNBK
 Qp7VYqj5tT5Vg3C/r+Z5msFVqNhbvqUq4WX8KoB6OSBF3rwiPt2ormdNnQLeGYcb5MaJ
 y8GJZWueYU422+qasuSHZ2YopiYoBph2KbckHhLjZglkUK0pZPhoouIyfXjZcw2F4Lno
 T7f+MYllyBe9VlGNmeOFb/j9oDElUG9XAVoPZK1KkjNp1Et5IRFOqpmyErUG/jzLkAlp
 a1glt0j6O3zNOlPyOeDDh5MXFL4aI59cItt8PZP9A7BKqe5ewFnKf7rvIkOlRHG8KtOI
 tuTQ==
X-Gm-Message-State: AOJu0Yx5NQcnNtNt2OaDSYIOAtu/iJTp4TaVZo3Tc0BEyI/G2b5bS3rr
 obp7Bink6KCijjxZeEUFtLWetv05mit6+089X7dhSVVZBYN84cP+AdvRS6SGQNzJ
X-Gm-Gg: ASbGncvW/3tgwrBCR36Mpnkz50uwzAiIVbmCrqla3p8qBOTFhnsokMB2Qz/tiQj3lc+
 nPqh39omEkicyRgoc/6jrlXq6tUq9n/HI7B3znMsiZKHFAGSr0vz6L6wmQN+g/d8ynx9Ixf8f06
 VMV3R3dE2jIPouUVKaa/Jm11sEygEmD8If2dXULmODnzHpTpn3hLbiMQQL5Kl9fCURYQ7GyiJxK
 0GUlOJclj+CWivy+JOJWgbbGCIvi9AGcgz6xY67U5ii4YrdEN6VtEPdfmCvycxD/adl9lRQKRxQ
 FXk8xmbS2SYOZ9x3Xat7JJprV8rguBTjNfTNFrAurZil6e7iuLao6CPp8nGVXJZBUs//ei6kFKz
 lMQEpKd0=
X-Google-Smtp-Source: AGHT+IHAS5iKqIkg8NK4kShEn+qHnGm4cYd1O3dXS6RhZZmERsM6nMabFWUHGS/k06n4Ei1DJHkJtQ==
X-Received: by 2002:a05:622a:13d4:b0:4a5:a632:2888 with SMTP id
 d75a77b69052e-4a9968bc76amr141942841cf.47.1751801372257; 
 Sun, 06 Jul 2025 04:29:32 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949e5221sm46007541cf.2.2025.07.06.04.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:31 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, marek.vasut+renesas@mailbox.org,
 Chris.Brandt@renesas.com, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:29:29 +0200
Message-Id: <175180136965.86839.10195243856147148306.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
X-Mailman-Approved-At: Mon, 07 Jul 2025 00:18:49 +0200
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

Extend the sh_eth driver to also support RZ/A2. While at it fix the RZ/A1
handling to also take the Ethernet controller base address from the DT node.

Tested on:
- RZ/A1H Genmai (MII) with U2 uPD60610 by Renesas
- RZ/A2M GR-Mango (ch0 MII) with U13 LAN8710 by Mikrochip
- RZ/A2M RZA2MBTC + emoEdgeExpanderV2 (ch1 RMII) with IC1 RTL8201 by Realtek

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - new patch

 drivers/net/sh_eth.c |   16 ++++++++++++----
 drivers/net/sh_eth.h |   31 ++++++++++++++++---------------
 2 files changed, 28 insertions(+), 19 deletions(-)

--- 0013/drivers/net/sh_eth.c
+++ work/drivers/net/sh_eth.c	2025-07-05 17:45:07.333754799 +0900
@@ -144,10 +144,10 @@ static int sh_eth_reset(struct sh_eth_in
 {
 #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 	int ret = 0, i;
-
+#if !defined(CONFIG_RZA2)
 	/* Start e-dmac transmitter and receiver */
 	sh_eth_write(port_info, EDSR_ENALL, EDSR);
-
+#endif
 	/* Perform a software reset and wait for it to complete */
 	sh_eth_write(port_info, EDMR_SRST, EDMR);
 	for (i = 0; i < TIMEOUT_CNT; i++) {
@@ -215,9 +215,11 @@ static int sh_eth_tx_desc_init(struct sh
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->tx_desc_base), TDLAR);
 #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->tx_desc_base), TDFAR);
+#if !defined(CONFIG_RZA2)
 	sh_eth_write(port_info, ADDR_TO_PHY(cur_tx_desc), TDFXR);
 	sh_eth_write(port_info, 0x01, TDFFR);/* Last discriptor bit */
 #endif
+#endif
 
 err:
 	return ret;
@@ -282,9 +284,11 @@ static int sh_eth_rx_desc_init(struct sh
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->rx_desc_base), RDLAR);
 #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
 	sh_eth_write(port_info, ADDR_TO_PHY(port_info->rx_desc_base), RDFAR);
+#if !defined(CONFIG_RZA2)
 	sh_eth_write(port_info, ADDR_TO_PHY(cur_rx_desc), RDFXR);
 	sh_eth_write(port_info, RDFFR_RDLF, RDFFR);
 #endif
+#endif
 
 	return ret;
 
@@ -408,7 +412,7 @@ static int sh_eth_phy_regs_config(struct
 		sh_eth_write(port_info, GECMR_100B, GECMR);
 #elif defined(CONFIG_CPU_SH7757) || defined(CONFIG_CPU_SH7752)
 		sh_eth_write(port_info, 1, RTRATE);
-#elif defined(CONFIG_RCAR_GEN2) || defined(CONFIG_R8A77980)
+#elif defined(CONFIG_RCAR_GEN2) || defined(CONFIG_R8A77980) || defined(CONFIG_RZA2)
 		val = ECMR_RTM;
 #endif
 	} else if (phy->speed == 10) {
@@ -722,8 +726,11 @@ static int sh_ether_probe(struct udevice
 		goto err_mdio_register;
 
 	priv->bus = mdiodev;
-
+#ifdef BASE_IO_ADDR
 	port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
+#else
+	port_info->iobase = (void __iomem *)pdata->iobase;
+#endif
 
 #if CONFIG_IS_ENABLED(CLK)
 	ret = clk_enable(&priv->clk);
@@ -797,6 +804,7 @@ int sh_ether_of_to_plat(struct udevice *
 
 static const struct udevice_id sh_ether_ids[] = {
 	{ .compatible = "renesas,ether-r7s72100" },
+	{ .compatible = "renesas,ether-r7s9210" },
 	{ .compatible = "renesas,ether-r8a7790" },
 	{ .compatible = "renesas,ether-r8a7791" },
 	{ .compatible = "renesas,ether-r8a7793" },
--- 0013/drivers/net/sh_eth.h
+++ work/drivers/net/sh_eth.h	2025-07-05 17:42:00.409687244 +0900
@@ -339,9 +339,10 @@ static const u16 sh_eth_offset_fast_sh4[
 #elif defined(CONFIG_RCAR_GEN2)
 #define SH_ETH_TYPE_ETHER
 #define BASE_IO_ADDR	0xEE700200
-#elif defined(CONFIG_R7S72100)
+#elif defined(CONFIG_RZA1)
+#define SH_ETH_TYPE_RZ
+#elif defined(CONFIG_RZA2)
 #define SH_ETH_TYPE_RZ
-#define BASE_IO_ADDR	0xE8203000
 #elif defined(CONFIG_R8A77980)
 #define SH_ETH_TYPE_GETHER
 #define BASE_IO_ADDR	0xE7400000
@@ -351,7 +352,7 @@ static const u16 sh_eth_offset_fast_sh4[
  * Register's bits
  * Copy from Linux driver source code
  */
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
 /* EDSR */
 enum EDSR_BIT {
 	EDSR_ENT = 0x01, EDSR_ENR = 0x02,
@@ -363,11 +364,11 @@ enum EDSR_BIT {
 enum DMAC_M_BIT {
 	EDMR_NBST	= 0x80, /* DMA transfer burst mode */
 	EDMR_DL1 = 0x20, EDMR_DL0 = 0x10,
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
 	EDMR_SRST	= 0x03, /* Receive/Send reset */
 	EMDR_DESC_R	= 0x30, /* Descriptor reserve size */
 	EDMR_EL		= 0x40, /* Litte endian */
-#elif defined(SH_ETH_TYPE_ETHER)
+#elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
 	EDMR_SRST	= 0x01,
 	EMDR_DESC_R	= 0x30, /* Descriptor reserve size */
 	EDMR_EL		= 0x40, /* Litte endian */
@@ -389,7 +390,7 @@ enum DMAC_M_BIT {
 
 /* EDTRR */
 enum DMAC_T_BIT {
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
 	EDTRR_TRNS = 0x03,
 #else
 	EDTRR_TRNS = 0x01,
@@ -434,7 +435,7 @@ enum PHY_STATUS_BIT { PHY_ST_LINK = 0x01
 
 /* EESR */
 enum EESR_BIT {
-#if defined(SH_ETH_TYPE_ETHER)
+#if defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA1)
 	EESR_TWB  = 0x40000000,
 #else
 	EESR_TWB  = 0xC0000000,
@@ -451,7 +452,7 @@ enum EESR_BIT {
 	EESR_FTC  = 0x00200000, EESR_TDE  = 0x00100000,
 	EESR_TFE  = 0x00080000, EESR_FRC  = 0x00040000,
 	EESR_RDE  = 0x00020000, EESR_RFE  = 0x00010000,
-#if defined(SH_ETH_TYPE_ETHER)
+#if defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA1)
 	EESR_CND  = 0x00000800,
 #endif
 	EESR_DLC  = 0x00000400,
@@ -539,7 +540,7 @@ enum TD_STS_BIT {
 enum RECV_RST_BIT { RMCR_RST = 0x01, };
 /* ECMR */
 enum FELIC_MODE_BIT {
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
 	ECMR_TRCCM = 0x04000000, ECMR_RCSC = 0x00800000,
 	ECMR_DPAD = 0x00200000, ECMR_RZPF = 0x00100000,
 #endif
@@ -550,16 +551,16 @@ enum FELIC_MODE_BIT {
 	ECMR_PRM = 0x00000001,
 #ifdef CONFIG_CPU_SH7724
 	ECMR_RTM = 0x00000010,
-#elif defined(CONFIG_RCAR_GEN2) || defined (CONFIG_R8A77980)
+#elif defined(CONFIG_RCAR_GEN2) || defined (CONFIG_R8A77980) || defined(CONFIG_RZA2)
 	ECMR_RTM = 0x00000004,
 #endif
 
 };
 
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER) || defined(CONFIG_RZA1)
 #define ECMR_CHG_DM (ECMR_TRCCM | ECMR_RZPF | ECMR_ZPF | ECMR_PFR | \
 			ECMR_RXF | ECMR_TXF | ECMR_MCT)
-#elif defined(SH_ETH_TYPE_ETHER)
+#elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
 #define ECMR_CHG_DM (ECMR_ZPF | ECMR_PFR | ECMR_RXF | ECMR_TXF)
 #else
 #define ECMR_CHG_DM	(ECMR_ZPF | ECMR_PFR | ECMR_RXF | ECMR_TXF | ECMR_MCT)
@@ -640,11 +641,11 @@ enum FIFO_SIZE_BIT {
 static inline unsigned long sh_eth_reg_addr(struct sh_eth_info *port,
 					    int enum_index)
 {
-#if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
+#if defined(SH_ETH_TYPE_GETHER)
 	const u16 *reg_offset = sh_eth_offset_gigabit;
-#elif defined(SH_ETH_TYPE_ETHER)
+#elif defined(SH_ETH_TYPE_ETHER) || defined(CONFIG_RZA2)
 	const u16 *reg_offset = sh_eth_offset_fast_sh4;
-#elif defined(SH_ETH_TYPE_RZ)
+#elif defined(CONFIG_RZA1)
 	const u16 *reg_offset = sh_eth_offset_rz;
 #else
 #error
