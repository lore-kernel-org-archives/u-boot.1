Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C9BEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B783864AB;
	Tue, 22 Aug 2023 20:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B583864A8; Tue, 22 Aug 2023 20:10:45 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id E38178647A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,193,1684767600"; d="scan'208";a="177305233"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 03:10:40 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.37])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8A811406ED4D;
 Wed, 23 Aug 2023 03:10:38 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 2/2] serial: sh: Tidy up pre-processor directive indentation
Date: Tue, 22 Aug 2023 19:10:24 +0100
Message-Id: <20230822181025.339748-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Let's make the indentation of pre-processor macros and conditionals in
serial_sh.h consistent before we add to the confusion with a new SoC.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/serial/serial_sh.h | 84 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/serial/serial_sh.h b/drivers/serial/serial_sh.h
index 149ec1fe7397..3109c5a946b9 100644
--- a/drivers/serial/serial_sh.h
+++ b/drivers/serial/serial_sh.h
@@ -116,9 +116,9 @@ struct uart_port {
 	defined(CONFIG_CPU_SH7751R) || \
 	defined(CONFIG_CPU_SH7763)  || \
 	defined(CONFIG_CPU_SH7780)
-#define SCI_CTRL_FLAGS_REIE 0x08 /* 7750 SCIF */
+# define SCI_CTRL_FLAGS_REIE 0x08 /* 7750 SCIF */
 #else
-#define SCI_CTRL_FLAGS_REIE 0
+# define SCI_CTRL_FLAGS_REIE 0
 #endif
 /*		SCI_CTRL_FLAGS_MPIE 0x08  * 7707 SCI, 7708 SCI, 7709 SCI, 7750 SCI */
 /*		SCI_CTRL_FLAGS_TEIE 0x04  * 7707 SCI, 7708 SCI, 7709 SCI, 7750 SCI */
@@ -174,7 +174,7 @@ struct uart_port {
 #endif
 
 #ifndef SCIF_ORER
-#define SCIF_ORER	0x0000
+# define SCIF_ORER	0x0000
 #endif
 
 #define SCxSR_TEND(port)\
@@ -282,45 +282,45 @@ static inline void sci_##name##_out(struct uart_port *port,\
 	}
 
 #if defined(CONFIG_R8A7740)
-#if defined(CONFIG_CPU_SH7721) || \
+# if defined(CONFIG_CPU_SH7721) || \
 	defined(CONFIG_SH73A0)
-#define SCIF_FNS(name, scif_offset, scif_size) \
+#  define SCIF_FNS(name, scif_offset, scif_size) \
 	CPU_SCIF_FNS(name, scif_offset, scif_size)
-#elif defined(CONFIG_R8A7740)
-#define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
+# elif defined(CONFIG_R8A7740)
+#  define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
 				sh4_scifb_offset, sh4_scifb_size) \
 	CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
 				sh4_scifb_offset, sh4_scifb_size)
-#define SCIF_FNS(name, scif_offset, scif_size) \
+#  define SCIF_FNS(name, scif_offset, scif_size) \
 	CPU_SCIF_FNS(name, scif_offset, scif_size)
-#else
-#define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
+# else
+#  define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
 				sh4_sci_offset, sh4_sci_size, \
 				sh3_scif_offset, sh3_scif_size,\
 				sh4_scif_offset, sh4_scif_size, \
 				h8_sci_offset, h8_sci_size) \
 	CPU_SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
 				sh3_scif_offset, sh3_scif_size)
-#define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size,\
+#  define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size,\
 				sh4_scif_offset, sh4_scif_size) \
 	CPU_SCIF_FNS(name, sh3_scif_offset, sh3_scif_size)
-#endif
+# endif
 #elif defined(CONFIG_CPU_SH7723)
-		#define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
-					sh4_scif_offset, sh4_scif_size) \
-			CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
-					sh4_scif_offset, sh4_scif_size)
-		#define SCIF_FNS(name, sh4_scif_offset, sh4_scif_size) \
-			CPU_SCIF_FNS(name, sh4_scif_offset, sh4_scif_size)
+# define SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
+			sh4_scif_offset, sh4_scif_size) \
+	CPU_SCIx_FNS(name, sh4_scifa_offset, sh4_scifa_size,\
+			sh4_scif_offset, sh4_scif_size)
+# define SCIF_FNS(name, sh4_scif_offset, sh4_scif_size) \
+	CPU_SCIF_FNS(name, sh4_scif_offset, sh4_scif_size)
 #else
-#define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
+# define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
 				sh4_sci_offset, sh4_sci_size, \
 				sh3_scif_offset, sh3_scif_size,\
 				sh4_scif_offset, sh4_scif_size, \
 				h8_sci_offset, h8_sci_size) \
 	CPU_SCIx_FNS(name, sh4_sci_offset, sh4_sci_size,\
 					sh4_scif_offset, sh4_scif_size)
-#define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size, \
+# define SCIF_FNS(name, sh3_scif_offset, sh3_scif_size, \
 				sh4_scif_offset, sh4_scif_size) \
 	CPU_SCIF_FNS(name, sh4_scif_offset, sh4_scif_size)
 #endif
@@ -382,11 +382,11 @@ SCIF_FNS(SCSPTR, 0,  0, 0x20, 16)
 SCIF_FNS(DL,     0,  0, 0x30, 16)
 SCIF_FNS(CKS,    0,  0, 0x34, 16)
 SCIF_FNS(HSSRR,  0,  0, 0x40, 16) /* HSCIF only */
-#if defined(CFG_SCIF_A)
+# if defined(CFG_SCIF_A)
 SCIF_FNS(SCLSR,  0,  0, 0x14, 16)
-#else
+# else
 SCIF_FNS(SCLSR,  0,  0, 0x24, 16)
-#endif
+# endif
 #else
 /*      reg      SCI/SH3   SCI/SH4  SCIF/SH3   SCIF/SH4  SCI/H8*/
 /*      name     off  sz   off  sz   off  sz   off  sz   off  sz*/
@@ -397,13 +397,13 @@ SCIx_FNS(SCxTDR, 0x06,  8, 0x0c,  8, 0x06,  8, 0x0C,  8, 0x03,  8)
 SCIx_FNS(SCxSR,  0x08,  8, 0x10,  8, 0x08, 16, 0x10, 16, 0x04,  8)
 SCIx_FNS(SCxRDR, 0x0a,  8, 0x14,  8, 0x0A,  8, 0x14,  8, 0x05,  8)
 SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
-#if defined(CONFIG_CPU_SH7780)
+# if defined(CONFIG_CPU_SH7780)
 SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
 SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
 SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
-#elif defined(CONFIG_CPU_SH7763)
+# elif defined(CONFIG_CPU_SH7763)
 SCIF_FNS(SCFDR,				0,  0, 0x1C, 16)
 SCIF_FNS(SCSPTR2,			0,  0, 0x20, 16)
 SCIF_FNS(SCLSR2,			0,  0, 0x24, 16)
@@ -411,16 +411,16 @@ SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
 SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
 SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
-#else
+# else
 
 SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
-#if defined(CONFIG_CPU_SH7722)
+#  if defined(CONFIG_CPU_SH7722)
 SCIF_FNS(SCSPTR,			0,  0, 0, 0)
-#else
+#  else
 SCIF_FNS(SCSPTR,			0,  0, 0x20, 16)
-#endif
+#  endif
 SCIF_FNS(SCLSR,				0,  0, 0x24, 16)
-#endif
+# endif
 SCIF_FNS(DL,				0,  0, 0x30, 16)
 SCIF_FNS(CKS,				0,  0, 0x34, 16)
 SCIF_FNS(HSSRR,				0,  0, 0x40, 16) /* HSCIF only */
@@ -479,10 +479,10 @@ static inline int sci_rxd_in(struct uart_port *port)
  */
 
 #if defined(CONFIG_CPU_SH7780)
-#define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
+# define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(16*bps)-1)
 #elif defined(CONFIG_CPU_SH7721) || \
 	defined(CONFIG_R8A7740)
-#define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
+# define SCBRR_VALUE(bps, clk) (((clk*2)+16*bps)/(32*bps)-1)
 #elif defined(CONFIG_CPU_SH7723)
 static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 {
@@ -491,14 +491,14 @@ static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 	else
 		return ((clk*2)+16*bps)/(16*bps)-1;
 }
-#define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
+# define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #elif defined(CONFIG_RCAR_GEN2)
-#define DL_VALUE(bps, clk) (clk / bps / 16) /* External Clock */
- #if defined(CFG_SCIF_A) || defined(CFG_HSCIF)
-  #define SCBRR_VALUE(bps, clk) (clk / bps / 16 - 1) /* Internal Clock */
- #else
-  #define SCBRR_VALUE(bps, clk) (clk / bps / 32 - 1) /* Internal Clock */
- #endif
+# define DL_VALUE(bps, clk) (clk / bps / 16) /* External Clock */
+# if defined(CFG_SCIF_A) || defined(CFG_HSCIF)
+#  define SCBRR_VALUE(bps, clk) (clk / bps / 16 - 1) /* Internal Clock */
+# else
+#  define SCBRR_VALUE(bps, clk) (clk / bps / 32 - 1) /* Internal Clock */
+# endif
 #elif defined(CONFIG_RCAR_64)
 static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 {
@@ -507,11 +507,11 @@ static inline int scbrr_calc(struct uart_port *port, int bps, int clk)
 	else /* PORT_HSCIF */
 		return clk / bps / 8 / 2 - 1; /* Internal Clock, Sampling rate = 8 */
 }
-#define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
+# define SCBRR_VALUE(bps, clk) scbrr_calc(port, bps, clk)
 #else /* Generic SH */
-#define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(32*bps)-1)
+# define SCBRR_VALUE(bps, clk) ((clk+16*bps)/(32*bps)-1)
 #endif
 
 #ifndef DL_VALUE
-#define DL_VALUE(bps, clk) 0
+# define DL_VALUE(bps, clk) 0
 #endif
-- 
2.34.1

