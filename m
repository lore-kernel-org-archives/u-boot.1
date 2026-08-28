Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A68C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A36480FB4;
	Fri, 28 Aug 2026 13:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3E-gzrIQ_EU; Fri, 28 Aug 2026 13:58:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925530;
	bh=VO7T60b5P6Oxt8fGkZaiEdMbKbqITd31Zm0GQFj+6aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UUVN3g/vg2H5xhb9BdV9iVUSMj4GqLJbDWy7vYTXxOp9rg8C3I1IRvjGBXZ9+FMdu
	 UiNAaJfNBdzZ7p5LBffYEFOeo30VQ2JhDwa2lVkGvDC4Tvi+f+Ff8AM6U8PhnYylAd
	 aWrwrJ+kxdBF3x4f2jIXHWNa6s6DceAFTmvNz7s/rnhy+iH3yVRMkT/HqTS/3rARQe
	 hfDF4Js5eqPMS3sgAm1ePlw2eHGWxi1nCebCJFGdsltV0gBNOi98fzS9iaCQ6g+hXg
	 c2AdDCxxK8taCip54fLp3GyWzcwQVktghtQbPbvFi81kZVcYERoyqQWfdcM7xNJU76
	 uhFdyT/iX1XuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B86A80FAE;
	Fri, 28 Aug 2026 13:58:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD7F5127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B171E4088B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBJ6MrTcjagP for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=GRPs5zY8
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABE2D408B0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AB2BA1A18A3;
 Fri, 28 Aug 2026 13:58:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E7F760537;
 Fri, 28 Aug 2026 13:58:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 41BE911C7833A; 
 Fri, 28 Aug 2026 15:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925524; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=VO7T60b5P6Oxt8fGkZaiEdMbKbqITd31Zm0GQFj+6aM=;
 b=GRPs5zY8w9KzqmC8EJ+fH39uVLliynVcD7P2MvhlNvnRhwcYaJ5l4VdZTrL96s5+F3mPZZ
 DTctYggbfuV9QU0cuAx3FZ9oVIHxUsil1PWvVRNBQ6LmyxjmLWumrcd8nOOpnen48LsAnU
 m/7T0ZSwniF8x9VVy01uUuCuZ1EqKPao2op/noJtHr7rupJWsbUxJIE1TEUvQhHJRq6HdS
 /mHgBuP7fpiXB166vOFLI6gYpBAfuHKfA91+1osyVqmumuTLc5B2qwYkflctlX/qvJB5JL
 xOBa5jrgypWIEqxj4dtMPGx3n2kWv9eCDv7p2qvJnGmm1hYB7j3QweZRrMWF6Q==
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
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 18/21] arm: mach-k3: j721s2: Enable LPM resume flow
Date: Fri, 28 Aug 2026 15:57:27 +0200
Message-ID: <20260828135730.1565643-19-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

Add the board specific part of the exit retention sequence for k3-ddrss:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power
Then generic resume path is run.

Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 49 ++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 780d853423f8..e35b00ff2dbb 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -16,12 +16,20 @@
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
+#include <mach/k3-ddr.h>
 #include <mmc.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 
 #include "../sysfw-loader.h"
+#include "../lpm-common.h"
 #include "../common.h"
 
+#define MAX_DDR_CONTROLLERS	2
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(3)
+
 /* NAVSS North Bridge (NB) */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
 #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
@@ -262,9 +270,12 @@ bool check_rom_loaded_sysfw(void)
 void k3_mem_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
 		if (ret)
 			panic("Probe of msmc failed: %d\n", ret);
@@ -272,10 +283,40 @@ void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+		devs[0] = dev;
+		ctrl++;
 
-		ret = uclass_next_device_err(&dev);
-		if (ret && ret != -ENODEV)
-			panic("DRAM 1 init failed: %d\n", ret);
+		while (ctrl < MAX_DDR_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
+			ctrl++;
+		}
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+
+			do_resume();
+		}
 	}
 	spl_enable_cache();
 }
