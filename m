Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6CFC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 18:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24B182F42;
	Mon, 30 Jun 2025 20:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6259980B9B; Mon, 30 Jun 2025 17:39:54 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352AA800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=opensource.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=magnus.damm@gmail.com
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d219896edeso488467185a.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297991; x=1751902791;
 h=subject:message-id:date:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a61sLOONmihmdhd4OGSI+Q/bLDe72p696O7IHFjET24=;
 b=EaQNMZ+Lpf4uJfr8nr3tGkEgcjYidxY3TTrBNXatKnugQhDfAWZ8Y3V2oQhmkhcu5e
 95Ib4Sd6FI18O5blZbnHVKPsuP0bBy9ai7bHJoBcLEoyj+H4OU0Zs9maVPImaZjw8TZJ
 mKUkeX1ndl9nuFLm2axjdsp276Uz5Fqp4z1PSqPDplRCbsjuc9GsZIs5s7jqNQpDcbPa
 KrZycK4InLihVKQgpqNjRG/5DnvFQahYrRS972GUc2YvvzL2D2S1IdsErW5w4YU1TZ9t
 7mkSWh7aHvPqGgqKBIrdBno/aAMm4F6V9RP00TheNa284pZqv4dIfXlJ/GDlwwxV+rZN
 QihA==
X-Gm-Message-State: AOJu0Yxh7rr7USSRmSUceVAszTkiHOJuIv2Oa8SxfvZ79cpSPvMuScOf
 lpEj0aLthgWehdZBQI1VWIHUps/m2DD0lqycb3JUvcza2AzKWJO34Pd5xMjfP+dm
X-Gm-Gg: ASbGncvXBjdMvAw4LT9I4CUllvoAjkjeuQP2RbuPTVjmWkJ/WJd8qU2S3Xr4X/xTyLf
 AuqAZjQXKZpWGBKD7znWh0loz5CTJk3S0k1mRCjURDXffm+2UkCbHyEYBwxQhJIjJf0uWRDksW+
 E5Lutmmg21CxQNeATn1L7z1eckj67M9NJjA/w0nNX8AO7pSNoBmAu0rRzcGQ65N7jm2cBKB8drg
 uDW7CT73pSEjro6pnmhqtyjtPqtEn704yODjo8xXLrKKJE0nLSy5rrTM/DjeTVYN7fvFus+xl74
 +UB6kfUm5FF7NGDq8xFfK4yYWotBLUVlgHwYex1g/GquSrgyw8ZNQKtsCDImD956Zquj9OVHCUd
 xODQW49OSbrlE0IedlMnHIaI=
X-Google-Smtp-Source: AGHT+IGab2Rpxw8S74G9Cl4XbKLKmmvJ1C6HTsflUwBT1DGGZAgZ3eRA0zkJzxAJLD8LviT0E8vncg==
X-Received: by 2002:ad4:5ae8:0:b0:6fa:c81a:6202 with SMTP id
 6a1803df08f44-700036ae7cdmr215570046d6.29.1751297990674; 
 Mon, 30 Jun 2025 08:39:50 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([167.99.4.198])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772e434bsm69722956d6.67.2025.06.30.08.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:39:50 -0700 (PDT)
From: Magnus Damm <damm@opensource.se>
To: u-boot@lists.denx.de
Cc: Magnus Damm <damm@opensource.se>, Chris.Brandt@renesas.com,
 marek.vasut+renesas@gmail.com
Date: Mon, 30 Jun 2025 17:39:47 +0200
Message-Id: <175129798741.60585.4269510571459746691.sendpatchset@1.0.0.127.in-addr.arpa>
Subject: [PATCH] serial: sh: Initial RZ/A2 R7S9210 support
X-Mailman-Approved-At: Mon, 30 Jun 2025 20:53:16 +0200
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
