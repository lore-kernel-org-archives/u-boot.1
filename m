Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E07DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 20:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4CC884D0;
	Wed, 17 Apr 2024 22:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D3E884D8; Wed, 17 Apr 2024 22:01:59 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFF68847B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rxBTe-006Wfm-QH;
 Wed, 17 Apr 2024 20:01:54 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: fix dt adjustment for gw73xx
 baseboard for imx8mp
Date: Wed, 17 Apr 2024 13:01:53 -0700
Message-Id: <20240417200153.3748943-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

The GW73xx baseboard needs a PCI dt adjustment for revC/D based on a
change of the PCIe switch. Make sure we are only doing this for a pci
based ethernet to avoid causing a boot hang when the ethernet1 alias
points to eqos or fec. To know this is a pcie device ensure the alias
begins with the pcie controller.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/venice.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index f54f1186b686..5b105d7659e4 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -230,6 +230,7 @@ uint mmc_get_env_part(struct mmc *mmc)
 int ft_board_setup(void *fdt, struct bd_info *bd)
 {
 	const char *base_model = eeprom_get_baseboard_model();
+	const char *path;
 	char pcbrev;
 	int off;
 
@@ -238,10 +239,10 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 
 	if (!strncmp(base_model, "GW73", 4)) {
 		pcbrev = get_pcb_rev(base_model);
+		path = fdt_get_alias(fdt, "ethernet1");
 
-		if (pcbrev > 'B' && pcbrev < 'E') {
-			printf("adjusting dt for %s\n", base_model);
-
+		if (pcbrev > 'B' && pcbrev < 'E' && path && !strncmp(path, "/soc@0/pcie@", 12)) {
+			printf("adjusting %s pcie\n", base_model);
 			/*
 			 * revC/D/E has PCIe 4-port switch which changes
 			 * ethernet1 PCIe GbE:
-- 
2.25.1

