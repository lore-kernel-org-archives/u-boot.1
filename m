Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B16C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E10F82F00;
	Tue,  1 Jul 2025 08:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D044082ADA; Tue,  1 Jul 2025 08:17:02 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8577D8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 08:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a774209cf0so32684941cf.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 23:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751350606; x=1751955406;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bb7cN5x5ZWyu1luVUzuw/d0buvL1azW3dPUAOpJDC/0=;
 b=m6SIPsJaZt7cVUaeJ+4jVtqp5q9CsshrA/gDeuA9vYoO9qWRiWyashvZjz8FsLzdD0
 dZ2lP4Ff03a7mXer1K33D/47GsjFTR0QWfhxlP3h66fAKB8FRu1nzgfwphpqK9G4a01d
 YCeKMAI1wwAA95ZWDvROJAzmfdPYE7gJ306kNfCOyG0c8sYPGKHj59YgpugEaLg9Dtjt
 CluM/STOjR/opTKyeoIVPwAKaEpVDeA37tk9L9rmBrcMdFHuuhbhq3x56F7dwptm2NuF
 UltD+n/Dty2N8PKfZKTHYHdiH/mt02Sriti7NMfabB/aQAFxhLjq3Bwd0V/qSoTQxgKV
 iujQ==
X-Gm-Message-State: AOJu0Yz0OX74OgkNYKAyI97jMUF1RtYgumrBMwiT/Frbzeui0/QKFNgM
 9SljRVlMqMxdNOlPbca8ItQRSCk0/n1NnjVoKvALRP8Xf8r5n8wjg94q0TZEaXmg
X-Gm-Gg: ASbGncu/OePsc8RaGDPk9cCASeYkjo+t559DAFpQUz5Wh4W6CP4YDIQV40MwSvNDIGL
 RSGe95QgE/VE7VsltGiCUc3sE3cvx6jP0+KMFsPTmKm6tjM7h/IMR6crs71ktS0C/xVk8SQpmg0
 /xdf5hpL82xga2zIDqfZQZhiNTcvoub7i4qa1Rgg+qPIOkQKp0hxqjFWhlljC65PQvBae8w8faB
 h4PtnqNs1UN4rtDQreOZYYtwpYbFWhzn8X4p/9mlOvsL5rhz83cdrn2l5JH/j8cOsjcOhUe2xpg
 qyjf7Q5z4unhefnyvk0Bt9r1lR3qhoJb0S2o03Ok6vlQvk2o5hnVSQf+ht3NzW5TJ178sO52ZpZ
 824dR/qGM83sh
X-Google-Smtp-Source: AGHT+IFm/wv98dEkUtS9QLeCUIhASsCsXfwUmmlLYngAJRGpsFJUZTkmtN9r+jPaapYI9z2CJWF38w==
X-Received: by 2002:ac8:7dca:0:b0:4a4:2fad:7cdd with SMTP id
 d75a77b69052e-4a7fcbb038bmr194118391cf.24.1751350605516; 
 Mon, 30 Jun 2025 23:16:45 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc13aa95sm70431361cf.19.2025.06.30.23.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 23:16:45 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, Magnus Damm <damm@opensource.se>,
 marek.vasut+renesas@mailbox.org
Date: Tue, 01 Jul 2025 08:16:42 +0200
Message-Id: <175135060199.63074.4714042121815587151.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH] serial: sh: Initial RZ/A2 R7S9210 support
X-Mailman-Approved-At: Tue, 01 Jul 2025 08:48:20 +0200
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

 (Resending with updated email address to Marek)

 drivers/serial/serial_sh.c |   15 +++++++++++++--
 drivers/serial/serial_sh.h |   15 +++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

--- 0001/drivers/serial/serial_sh.c
+++ work/drivers/serial/serial_sh.c	2025-07-01 00:29:33.340877501 +0900
@@ -55,10 +55,21 @@ static void sh_serial_init_generic(struc
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
+	 * To rememdy the situation, send a character with loopback enabled.
+	 */
+	sci_out(port, SCFCR, 1); /* enable loopback */
+	sci_out(port, SCxTDR, 'Z'); /* TX data */
+	mdelay(10);
+	sci_out(port, SCFCR, 6); /* assert FIFO reset to clear RX data */
+	sci_out(port, SCFCR, 0); /* deassert FIFO reset, disable loopback */
+#endif
 #if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)
 	if (port->type == PORT_HSCIF)
 		sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
--- 0001/drivers/serial/serial_sh.h
+++ work/drivers/serial/serial_sh.h	2025-07-01 00:26:47.080924446 +0900
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
