Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEADECDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14257849E5;
	Wed, 24 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HbnjVLQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AD784995; Wed, 24 Jun 2026 09:45:16 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3010D84671
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D3BED1A0911;
 Wed, 24 Jun 2026 07:45:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A8456601C5;
 Wed, 24 Jun 2026 07:45:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8398D106C85A3; 
 Wed, 24 Jun 2026 09:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287112; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=dWex8iUEAEMjrmiWY7gwQFF+Rfx81FwT+DSNiHvR/hs=;
 b=HbnjVLQv2MtzssdjA1tcd3KnFhMvd4Cz9o4eTL3hlc1pJpz+D9bQUvP+SPvmRKuscGtrwb
 NEa5jRyCduQb1ITL8XNQw3SoKHnfdv3Va4lRIBaXteuj4McLgyeD43tvcjnL6XoYqKPYsn
 tH2fb9aDcZawpW7df5W7PvGk3YFdkaDYkoKIOrg+6q4DprNnmnmp0TAL5TxSxK3EV7Ur6t
 LivNr20XPiSx1B/PA4emWuTCIdQWkHU6f5qFH+LYeTedmJIk31yhnD+hoi+O3jc/U3RZe6
 pcaQHuSyMdF/LLVtvjgguo/f/jsgQp4WZ/W4Lgf5jtOKa+M26gjoRQept7oYRg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 03/19] global: k3: use gd to store the resume state
Date: Wed, 24 Jun 2026 09:44:43 +0200
Message-ID: <20260624074459.873906-4-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/include/asm/global_data.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index b2ec450f9002..a146206fdff9 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -14,6 +14,14 @@
 #include <linux/types.h>
 #include <asm/u-boot.h>
 
+#if IS_ENABLED(CONFIG_ARCH_K3)
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
