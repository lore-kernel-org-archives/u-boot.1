Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD00BCDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2868460E;
	Wed, 24 Jun 2026 09:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V4aPmSss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F5684A3E; Wed, 24 Jun 2026 09:45:51 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F7984A38
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 181244E407B2;
 Wed, 24 Jun 2026 07:45:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E0ED7601C5;
 Wed, 24 Jun 2026 07:45:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C670B106C85A9; 
 Wed, 24 Jun 2026 09:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287147; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Xd6RxdTTUWQOY6WMxOgdq0W0f83Qbu7dTg6cDuQfVCI=;
 b=V4aPmSssyQsXHdzmaTd7sCsxLDxoLGN2ldQhdsXofVUyb+NgJVORFRKBmpKOhx6pe5VPll
 OXiBtF9orD2a3dSDcxzU0Njlr2dFhOFklEPNfIXQ4BJ2/CxxKh8DqHMz/+5GAAtYgw3x5z
 Dda15HGCO5k5sS0ezJ0jDa4EN/dFuXrgxE4mVtDWmUvh8Gl6/p3DwyLTMtqKCwQF/hzKZi
 XGEoHhljVK7v/mm2iwV8mp1JZIaaAli6eAVnwToELQKQaCCBgTHRH9GbvnD4bvAsNua79G
 tReMkYVzBHk/MNKajO1npiKjyZb+Wjcmm0nvhzRdPeziZGpv9wHwydUnk8IoSQ==
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
Subject: [PATCH v3 15/19] arm: mach-k3: j722s: Enable LPM resume flow
Date: Wed, 24 Jun 2026 09:44:55 +0200
Message-ID: <20260624074459.873906-16-richard.genoud@bootlin.com>
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

Add support for resuming from suspend in board_init_f for J722S.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly:

- Extract context address from devicetree and send to TIFS.
- Power on the rproc cluster.
- Replay the certificates attached to saved images of ATF and OPTEE.
- Resume sequence for context restore and rproc resume.
- Image entry to DM firmware.

The context address area is firewalled by TIFS to protect it from
other hosts.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..e98c9d93ac53 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -14,6 +14,7 @@
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
 struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
@@ -37,7 +38,7 @@ static void store_boot_info_from_rom(void)
 	       sizeof(struct rom_extended_boot_data));
 }
 
-static void ctrl_mmr_unlock(void)
+void ctrl_mmr_unlock(void)
 {
 	/* Unlock all WKUP_CTRL_MMR0 module registers */
 	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);
@@ -186,6 +187,9 @@ void board_init_f(ulong dummy)
 
 	k3_spl_init();
 	k3_mem_init();
+	if (j7xx_board_is_resuming())
+		do_resume(); /* no return */
+
 	setup_qos();
 
 	if (IS_ENABLED(CONFIG_ESM_K3)) {
