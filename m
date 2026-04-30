Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F86CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C618284687;
	Thu, 30 Apr 2026 10:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HUbHDmYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65CE84686; Thu, 30 Apr 2026 10:44:34 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C678466B
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7E6D64E42B79;
 Thu, 30 Apr 2026 08:44:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5405360495;
 Thu, 30 Apr 2026 08:44:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BEC311072B7AB; 
 Thu, 30 Apr 2026 10:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538670; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Y6EoOzHO3mIxV1nXF8K4bKSQFNev75nz0tkJ6XsRmfw=;
 b=HUbHDmYqpGWDpQNTn71TpPWZnYDIdLwtyNY++LW3ElyzcMT5fHzmTcpcUhQ922Htv3/Mld
 R4PoXdmovyQ4dQOZVPFyZ3RcI/WuoMPjeU6QvYnDVvwuYhvW8PpcXJsc76wAs1I0Ks5vMw
 ncKU/SK8iS+4b8FJijr4aEppkhBfSVVrblkhdMMl/HdQnP2Pavce22uHWk/okpxkI4yEpi
 JBBVn0RhWdEk1aG4xpfaA6j26ZsTy2XYzlnsbidDnsBbdQKCeuACtVoOOTi/2gMb3C08jw
 INxHDbOIf2lKjCueMSZAicqKKm56S4qUdw26cL/w7O9PWtBZgXn0ZJbW1O6rJA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 02/20] global: k3: use gd to store the resume state
Date: Thu, 30 Apr 2026 10:43:55 +0200
Message-ID: <20260430084414.1354490-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

For J7200, J784s4, J721e, j722s, j721s2 SoCs, the everything is shutdown
at suspend but the PMIC and the DDR.
In order for U-Boot SPL to know that it is resuming from suspend and not
booting, a flag is set in a PMIC register.
So, at startup, U-Boot will read the PMIC register and deduce if the
board is resuming from suspend or not.

This state (resuming or not) is consulted at several places (in
board_init_f() and in k3_ddrss_probe().
As it takes some time to read a i2c register, it's best to cache the
information.
But, as stated by the README, in board_init_f(), the BSS is not
available, so we cannot use global/static variables, only stack
variables and global_data.

Thus, we use gd to store the resume state of the board.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/include/asm/global_data.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b2ec450f9002..f343d3396c1c 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -14,6 +14,14 @@
 #include <linux/types.h>
 #include <asm/u-boot.h>
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+enum k3_resume_state {
+	K3_RESUME_STATE_UNKNOWN = 0,
+	K3_RESUME_STATE_BOOTING,
+	K3_RESUME_STATE_RESUMING
+};
+#endif
+
 /* Architecture-specific global data */
 struct arch_global_data {
 #if defined(CONFIG_FSL_ESDHC) || defined(CONFIG_FSL_ESDHC_IMX)
@@ -108,8 +116,19 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+	enum k3_resume_state k3_resuming;
+#endif
 };
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_ARCH_K3))
+#define gd_k3_resuming() gd->arch.k3_resuming
+#define gd_set_k3_resuming(state) gd->arch.k3_resuming = (state)
+#else
+#define gd_k3_resuming() 0
+#define gd_set_k3_resuming(state)
+#endif
+
 #include <asm-generic/global_data.h>
 
 #if defined(__clang__) || defined(LTO_ENABLE)
