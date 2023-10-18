Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E5CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F2486FB8;
	Wed, 18 Oct 2023 20:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80C187026; Wed, 18 Oct 2023 20:33:13 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9315C87018
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qtBLw-009oaw-Oh; Wed, 18 Oct 2023 18:33:08 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] board: gateworks: venice: add fixup for GW73xx-F+
Date: Wed, 18 Oct 2023 11:33:06 -0700
Message-Id: <20231018183306.2168046-1-tharvey@gateworks.com>
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

GW73xx-F board revision switched back to the original PCIe switch due to
part availability.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/venice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index a39ae58c8a09..0902a1da3e26 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -238,12 +238,12 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 	if (!strncmp(base_model, "GW73", 4)) {
 		pcbrev = get_pcb_rev(base_model);
 
-		if (pcbrev > 'B') {
+		if (pcbrev > 'B' && pcbrev < 'E') {
 			printf("adjusting dt for %s\n", base_model);
 
 			/*
-			 * revC replaced PCIe 5-port switch with 4-port
-			 * which changed ethernet1 PCIe GbE
+			 * revC/D/E has PCIe 4-port switch which changes
+			 * ethernet1 PCIe GbE:
 			 * from: pcie@0,0/pcie@1,0/pcie@2,4/pcie@6.0
 			 *   to: pcie@0,0/pcie@1,0/pcie@2,3/pcie@5.0
 			 */
-- 
2.25.1

