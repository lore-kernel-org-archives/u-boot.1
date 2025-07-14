Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CBFC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B4583020;
	Mon, 14 Jul 2025 19:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F683830B6; Mon, 14 Jul 2025 19:23:10 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A3B82F14
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ubMtN-008k39-Qt;
 Mon, 14 Jul 2025 17:23:05 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/4] venice: lpddr4_timing_imx8mm: add DDRC_ADDRMAP7 config
Date: Mon, 14 Jul 2025 10:23:01 -0700
Message-Id: <20250714172304.4095241-1-tharvey@gateworks.com>
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

Add the configuration register for DDRC_ADDRMAP7 which was added in the
RAP spreadsheet v19. This has no functional change but allows DRAM
configuration to be patched in a later commit.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 board/gateworks/venice/lpddr4_timing_imx8mm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/gateworks/venice/lpddr4_timing_imx8mm.c b/board/gateworks/venice/lpddr4_timing_imx8mm.c
index 956071c5125d..485649ab4f40 100644
--- a/board/gateworks/venice/lpddr4_timing_imx8mm.c
+++ b/board/gateworks/venice/lpddr4_timing_imx8mm.c
@@ -1890,6 +1890,7 @@ static struct dram_cfg_param lpddr4_ddrc_cfg_1gb[] = {
 	{ 0x3d400204, 0x80808 },
 	{ 0x3d400214, 0x7070707 },
 	{ 0x3d400218, 0xf070707 },
+	{ 0x3d40021c, 0xf0f },
 	{ 0x3d400250, 0x29001701 },
 	{ 0x3d400254, 0x2c },
 	{ 0x3d40025c, 0x4000030 },
@@ -2549,6 +2550,7 @@ static struct dram_cfg_param lpddr4_ddrc_cfg_4gb[] = {
 	{ 0x3d400204, 0x80808 },
 	{ 0x3d400214, 0x7070707 },
 	{ 0x3d400218, 0x7070707 },
+	{ 0x3d40021c, 0xf0f },
 	{ 0x3d400250, 0x29001701 },
 	{ 0x3d400254, 0x2c },
 	{ 0x3d40025c, 0x4000030 },
@@ -3065,6 +3067,7 @@ static struct dram_cfg_param lpddr4_ddrc_cfg_2gb[] = {
 	{ 0x3d400204, 0x80808 },
 	{ 0x3d400214, 0x7070707 },
 	{ 0x3d400218, 0x7070707 },
+	{ 0x3d40021c, 0xf0f },
 	{ 0x3d400250, 0x29001701 },
 	{ 0x3d400254, 0x2c },
 	{ 0x3d40025c, 0x4000030 },
-- 
2.25.1

