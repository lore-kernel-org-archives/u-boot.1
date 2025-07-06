Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF961C83F07
	for <u-boot@archiver.kernel.org>; Sun,  6 Jul 2025 22:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF7C8304F;
	Mon,  7 Jul 2025 00:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BDF82F00; Sun,  6 Jul 2025 13:29:20 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758C1810EB
 for <u-boot@lists.denx.de>; Sun,  6 Jul 2025 13:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a9b08740e3so7497891cf.3
 for <u-boot@lists.denx.de>; Sun, 06 Jul 2025 04:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751801357; x=1752406157;
 h=subject:references:in-reply-to:message-id:date:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRH3lcPn+dKDObGd2uvVELqXCZe2Pv2iWK+aSFApY1M=;
 b=RfEbmX5OlBdhasvSw/7ROzfXBm0qQ0si+1SD9wcUDM2HDyRvuTIjuMzcBmtAgl3stz
 MTv+1RxvyaIRDdw8iIUwb6p3KWnEvzyvm83j5d2nJAVKv0tB0/y37uXr5Sax/XHs/ny0
 OSWiUWSTc4k7jAvxptQfFbwsQ5F3YAcRNtcym5p5q6hv9op/5z29FkKYDihppOZoW/Cq
 C/Cx7MFaxrochrJwN66i4AU0d/uDjHE4S3OFDz7cJIXrDMAIhizbrbuKmE4I1AEAUdLy
 C7sWsSpB0r3jq0Y5m2PjGeXNEXnIaFWJKD4el0+1noJiCV3DcLXsndH52WrcVCEctS1n
 e5cA==
X-Gm-Message-State: AOJu0YwsdgiBC/jLnbbFM4OMe+dsyjELa/HgBtuskPOL5DORl8gv/BqU
 xP+PrhAxYUrB22cOEwW6Eua4EJLiifEQ2nwrGDg4Deobx1MpdYW3cHP4Zshz8nay
X-Gm-Gg: ASbGncuG6HePOpx4SodO79VhNEF/YTKqUQyh23JqIylDlHnMDrHsBJg6eVSEi45KAfl
 Zt9Sl1Eo6dd/yH6387CaPAID4Y+44308syVIBGJo/qr8gsDYG9stKVN2d9kxZwBOwaHNTwoIGXD
 cXmTleKvbxr22DCQS1q1s6nz7GosKGyqupKxCWn+0611y8H0QwT1cb5NwB2s49XxplY+QJHkBDW
 BWpiQVhh2R25LXIHInzYhn04L5YRsJTZauZ9AOxoSZxHO2RCtkAM9R6JakDp3i9B+OYIkz4QoTB
 lFSGenaugKjmy7qm1hLImTJkjgM3rSdUQ8xQFnrXV2mJ2/+qmZW/ty1YO7fNhgr0EDXgb20itU4
 wD9K3paqQhdJDZ1O+IQ==
X-Google-Smtp-Source: AGHT+IFMajMR2DnaMGs0YCrnwBEwPiJ1ShaTLuK9wPMqFs0LsJ83d5LO4HK6j+ZBbOLDG2FHpW8mpA==
X-Received: by 2002:a05:622a:260e:b0:49b:eb1d:18ac with SMTP id
 d75a77b69052e-4a9b02c35d8mr48357161cf.46.1751801357118; 
 Sun, 06 Jul 2025 04:29:17 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79d83sm45946291cf.39.2025.07.06.04.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Jul 2025 04:29:16 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 Magnus Damm <damm@opensource.se>, geert+renesas@glider.be
Date: Sun, 06 Jul 2025 13:29:14 +0200
Message-Id: <175180135455.86839.11496632527387524963.sendpatchset@1.0.0.127.in-addr.arpa>
In-Reply-To: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v3 5/9] serial: sh: Add RZ/A2 SCIF support
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

Add SCIF support for RZ/A2 r7s9210 including a work around to prevent
the driver from hanging on boot due to TEND flag handling.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since v2:
 - none

 Changes since v1:
 - match RZ/A2 SCIF on "renesas,scif-r7s9210" instead of "renesas,scif"
 - use same compat string to run time enable loop back work around
 
 drivers/serial/serial_sh.c |   26 +++++++++++++++++++++-----
 drivers/serial/serial_sh.h |   15 +++++++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)

--- 0001/drivers/serial/serial_sh.c
+++ work/drivers/serial/serial_sh.c	2025-07-03 05:04:09.318895842 +0900
@@ -46,7 +46,9 @@ static int scif_rxfill(struct uart_port
 }
 #endif
 
-static void sh_serial_init_generic(struct uart_port *port)
+static void sh_serial_init_generic(struct uart_port *port,
+				   const void *blob,
+				   int node)
 {
 	sci_out(port, SCSCR , SCSCR_INIT(port));
 	sci_out(port, SCSCR , SCSCR_INIT(port));
@@ -55,10 +57,23 @@ static void sh_serial_init_generic(struc
 	sci_out(port, SCFCR, SCFCR_RFRST|SCFCR_TFRST);
 	sci_in(port, SCFCR);
 	sci_out(port, SCFCR, 0);
-#if defined(CONFIG_RZA1)
+#if defined(CONFIG_RZA1) || defined(CONFIG_RZA2)
 	sci_out(port, SCSPTR, 0x0003);
 #endif
-
+#if defined(CONFIG_RZA2)
+	/* For SCIF on RZ/A2, the default value of TEND after reset is 0,
+	 * however this driver expects it to be 1, so without this workaround
+	 * we will get stuck waiting and never send out the first character.
+	 * To remedy the situation, send a character with loopback enabled.
+	 */
+	if (fdt_node_check_compatible(blob, node, "renesas,scif-r7s9210") == 0) {
+		sci_out(port, SCFCR, 1); /* enable loopback */
+		sci_out(port, SCxTDR, 'Z'); /* TX data */
+		mdelay(10);
+		sci_out(port, SCFCR, 6); /* assert FIFO reset to clear RX data */
+		sci_out(port, SCFCR, 0); /* deassert FIFO reset, disable loopback */
+	}
+#endif
 #if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)
 	if (port->type == PORT_HSCIF)
 		sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
@@ -218,7 +233,7 @@ static int sh_serial_probe(struct udevic
 		}
 	}
 
-	sh_serial_init_generic(priv);
+	sh_serial_init_generic(priv, gd->fdt_blob, dev_of_offset(dev));
 
 	return 0;
 }
@@ -234,6 +249,7 @@ static const struct dm_serial_ops sh_ser
 static const struct udevice_id sh_serial_id[] ={
 	{.compatible = "renesas,sci", .data = PORT_SCI},
 	{.compatible = "renesas,scif", .data = PORT_SCIF},
+	{.compatible = "renesas,scif-r7s9210", .data = PORT_SCIF},
 	{.compatible = "renesas,scif-r9a07g044", .data = PORT_SCIFA},
 	{.compatible = "renesas,scifa", .data = PORT_SCIFA},
 	{.compatible = "renesas,hscif", .data = PORT_HSCIF},
@@ -297,7 +313,7 @@ U_BOOT_DRIVER(serial_sh) = {
 
 static void sh_serial_init_nodm(struct uart_port *port)
 {
-	sh_serial_init_generic(port);
+	sh_serial_init_generic(port, NULL, 0);
 	serial_setbrg();
 }
 
--- 0001/drivers/serial/serial_sh.h
+++ work/drivers/serial/serial_sh.h	2025-07-03 04:39:38.836733286 +0900
@@ -98,6 +98,9 @@ struct uart_port {
 # endif
 # define SCSCR_INIT(port)	(port->clk_mode == EXT_CLK ? 0x32 : 0x30)
 				/* TIE=0,RIE=0,TE=1,RE=1,REIE=0, */
+#elif defined(CONFIG_RZA2)
+# define SCIF_ORER 0x0001               /* Overrun error bit */
+# define SCSCR_INIT(port)       0x30    /* TIE=0,RIE=0,TE=1,RE=1,REIE=0 */
 #else
 # error CPU subtype not defined
 #endif
@@ -390,6 +393,18 @@ SCIF_FNS(SCLSR,  0,  0, 0x14, 16)
 #else
 SCIF_FNS(SCLSR,  0,  0, 0x24, 16)
 #endif
+#elif defined(CONFIG_RZA2)
+SCIF_FNS(SCSMR,  0x00, 8, 0x00, 16)
+SCIF_FNS(SCBRR,  0x01, 8, 0x02,  8)
+SCIF_FNS(SCSCR,  0x02, 8, 0x04, 16)
+SCIF_FNS(SCxTDR, 0x03, 8, 0x06,  8)
+SCIF_FNS(SCxSR,  0x04, 8, 0x08, 16)
+SCIF_FNS(SCxRDR, 0x05, 8, 0x0A,  8)
+SCIF_FNS(SCFCR,     0, 0, 0x0C, 16)
+SCIF_FNS(SCFDR,     0, 0, 0x0E, 16)
+SCIF_FNS(SCSPTR,    0, 0, 0x10, 16)
+SCIF_FNS(SCLSR,     0, 0, 0x12,  16)
+SCIF_FNS(DL,        0, 0, 0x00,  0) /* dummy */
 #elif defined(CONFIG_RZG2L)
 SCIF_FNS(SCSMR,  0x00, 16)
 SCIF_FNS(SCBRR,  0x02,  8)
