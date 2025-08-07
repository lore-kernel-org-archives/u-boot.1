Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F74C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A014284548;
	Thu,  7 Aug 2025 15:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="ejdouKTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8298C84548; Thu,  7 Aug 2025 15:13:57 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB1384517
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Or8CuyRu7JSayPiBTnlTPud0KNcnlY/H0w5KKlgvr8Y=; b=ejdouKTtsRY9LmrPawenjNe35a
 UWP4G+3fPGuOt7o9MTV6ZRPkj7yk4bI49sLW0GkN+55k3WwYHKsDN1gcZtsIcrPRr9XOQhB2iMtkN
 fiMWizpB5nOWsVaVJl2q0TsjKX3hcZHtCra7fCvpYmloL5j3lOAVmYAY79/uA2V7VMYe+jbquOGLX
 +tHRmzKtMjmTejhw4d0JKkpBXs6IbDvZr2ayhywdBjtLQ5rQ3zFJMKYb2/qRGjLEMh0vD78H7m2bo
 ym2g4f3ChpJiPTxqm9wy3JJrd/iCer7PRl/QT7g7VqanJUkE2sbBdYc60f21uPPaj45gV7BuCG0hi
 1sMjY2KQ==;
Received: from [89.212.21.243] (port=44244 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uk0RO-00DGtF-2Z;
 Thu, 07 Aug 2025 15:13:54 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] board: phytec: phycore-imx93: Add VOLT_LOW_DRIVE
 frequency fixup
Date: Thu,  7 Aug 2025 15:13:54 +0200
Message-Id: <20250807131354.1531908-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807131354.1531908-1-primoz.fiser@norik.com>
References: <20250807131354.1531908-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

For phyCORE-i.MX93 SoMs with i.MX93 parts running in VOLT_LOW_DRIVE mode
(SoCs with speed grade fuse set to 900 MHz) reduce usdhc clocks from 400
MHz to 266 MHz. Do this in board code since global imx9 board_fix_fdt()
is not used in case of phycore-imx93 board since commit d3b9b7996889
("board: phytec: imx93: Add eeprom-based hardware introspection").

While at it, add a note to ft_board_setup() function to inform that
fixup for Linux device-tree is taken care by ft_system_setup() in imx9
global arch/arm/mach-imx/imx9/soc.c implementation.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore-imx93.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index a55795e06034..b64138053935 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -82,6 +82,10 @@ int board_fix_fdt(void *blob)
 
 	emmc_fixup(blob, &data);
 
+	/* Update dtb clocks for low drive mode */
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		low_drive_freq_update(blob);
+
 	return 0;
 }
 
@@ -89,5 +93,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	emmc_fixup(blob, NULL);
 
+	/**
+	 * NOTE: VOLT_LOW_DRIVE fixup is done by the ft_system_setup()
+	 * in arch/arm/mach-imx/imx9/soc.c for Linux device-tree.
+	 */
+
 	return 0;
 }
-- 
2.34.1

