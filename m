Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A7CF07A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFC889124;
	Thu, 10 Oct 2024 07:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ghyJo37N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E96848911E; Thu, 10 Oct 2024 07:56:00 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20DB890BF
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20241010055557cfe829235669ea392e for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Lv0ut2tY6XlI1jFjodmFd39h11wE5epFQMypq6ar62Q=;
 b=ghyJo37Nurt/bom38O75V155gi8Gr6IHa18szpnFpuO2Y1Ib9vqKoSNi6YFoSgJh3HH032
 z0m79buiWcqOGkwlyW6/EMhhrQtrn/otDxPakJaA08cFCtt44+RBi4ON3pHVC3t7TrJieB4L
 yzhmrqZLJZZLMmCqvTGneRafHt7P78MBkErNJwm7++boKVTAajeRbu5aeOkO30wI9TCc5Vru
 +4JWrVH9ObURrSA6QNszpk2vfZKjC4H76g7CtNyj/ow47N/La4Gqx3z+YWVjVjBWj41B13D1
 o0S7Cejc75+ieTuuxMbdHdmjZsvsQPnMSsVw6/nYYpGesTsbKrlAdTaA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 03/11] board: siemens: iot2050: Control pcie power for all
 variants
Date: Thu, 10 Oct 2024 07:55:47 +0200
Message-ID: <b770395ca5c7d41eab30aaaa7ad7e97a48595eec.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

The power control pin of pcie interface not only works for M.2 interface
but also for miniPCIE, so promote this logic to all variants to
workaround the module hang issue.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index e5c7ce58b06..85cb999f17f 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -185,6 +185,12 @@ static void remove_mmc1_target(void)
 	free(boot_targets);
 }
 
+static void enable_pcie_connector_power(void)
+{
+	set_pinvalue("gpio@601000_17", "P3V3_PCIE_CON_EN", 1);
+	udelay(4 * 100);
+}
+
 void set_board_info_env(void)
 {
 	struct iot2050_info *info = IOT2050_INFO_DATA;
@@ -288,10 +294,6 @@ static void m2_connector_setup(void)
 	struct m2_config_pins config_pins;
 	unsigned int n;
 
-	/* enable M.2 connector power */
-	set_pinvalue("gpio@601000_17", "P3V3_M2_EN", 1);
-	udelay(4 * 100);
-
 	if (m2_manual_config < CONNECTOR_MODE_INVALID) {
 		mode_info = " [manual mode]";
 		connector_mode = m2_manual_config;
@@ -429,6 +431,8 @@ int board_late_init(void)
 	/* change CTRL_MMR register to let serdes0 not output USB3.0 signals. */
 	writel(0x3, SERDES0_LANE_SELECT);
 
+	enable_pcie_connector_power();
+
 	if (board_is_m2())
 		m2_connector_setup();
 
-- 
2.43.0

