Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1381AC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64ED781FEE;
	Thu,  3 Jul 2025 09:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A79C3822D7; Wed,  2 Jul 2025 22:40:27 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 725D681FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 22:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7d21cecc11fso1227343985a.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 13:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751488824; x=1752093624;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uZFIhiQZCexJosDBWlis/eLgQ416zPL1kmhcC16fIpg=;
 b=HJCINeP09IOA2wVPMjm7ayk5YMIPUEpyQt4p4I3lIqURsISrrqnXrnKXRrte7JxU8H
 g6iHmOpZjFzGP0aKX9HtJGIb5mh4WpIaIylXQLlupFA/JX26aAghYdTMOkhtRbWRYxAQ
 eKn2sTcArllyIvyCxeCkxC3kBXnmil42bUs0bAaSQfqdgQ3k8KpGE0mDn7tfemy7Z094
 3MzQZJMZ+KblLU8i7q4q/DDkqSFtsnVh5svmBSSZ2ee1LWLrQp6bKGoOcsfs4hKtP3s6
 psVrV9mUVeIpxI2Ev5YP2rXHTdbrFy8zwg5F5iiKze6lA6+XVdQU8pCPaFp1K7LfslYs
 2z/g==
X-Gm-Message-State: AOJu0Yzy9BuxlthJPkjS8/xxKW56vTnstfkiYgJBnLu46MGrSxxYnFNh
 9qfjoimVjD3z38qopUUxZx4vuOV3LlDZc5pOK5oe91V6CEU6qL1pkk1UKBPl0uP+
X-Gm-Gg: ASbGncuQ1AHWM+UeZZ9bNH0P/tr6lCG72EPRJx4f/GZiU6ilgTkxEgq8f6au4mtk7Zg
 DIP4KP95VWP7sSJZJ4ZljFkZJ0dWG37r/8e60Tj2JsSuvWnQA/y30CzGIZEf9HqvV5yh9I624JB
 tj/9r+6k9x1xAJp7kxuF4uQXZCbjuIFh5BN1Lg0q+vBmEXbDCjAGfdhsqoD62j9jOH9fxlQyMtA
 mqIkcepQZ1VJjBy3PhrsGo5s8m0tgotIrQR6/xniEo0W+g7cmhLcz8l04voxvcFFVlydNElHdu/
 BMSAgNLFX5o6Yy5/9TKJIurgQnJtAqGI69y73vG+QAMzBGwpeWn7XMmr5cf3o4SW3NO4EqQzZIE
 Uu6/eZPCQDmss
X-Google-Smtp-Source: AGHT+IHgRAx3hMow/R5vGjnB68GhByEnPf+lYfVR7ek1vPaRKvgIshekZJ9fTB5VAW/GBc1HTAnYeg==
X-Received: by 2002:a05:620a:1708:b0:7c3:c9f4:522 with SMTP id
 af79cd13be357-7d5d13d9ee5mr132965885a.14.1751488823958; 
 Wed, 02 Jul 2025 13:40:23 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443201824sm990315585a.53.2025.07.02.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 13:40:23 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org
Date: Wed, 02 Jul 2025 22:40:21 +0200
Message-Id: <175148882142.69738.8505591187674592876.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH v2] serial: sh: Initial RZ/A2 R7S9210 support
X-Mailman-Approved-At: Thu, 03 Jul 2025 09:28:54 +0200
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
