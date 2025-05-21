Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1B0C54E90
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 20:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B13182E2D;
	Wed, 21 May 2025 22:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ditigal.xyz header.i=@ditigal.xyz header.b="PA/GRcB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62B882E40; Wed, 21 May 2025 20:16:42 +0200 (CEST)
Received: from mail.ditigal.xyz (ditigal.xyz [IPv6:2a01:4f8:1c1b:6a1c::])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5EDC82E28
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 20:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rutherther@ditigal.xyz
Received: by cerebrum (OpenSMTPD) with ESMTPSA id a1841d70
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Wed, 21 May 2025 18:16:40 +0000 (UTC)
From: Rutherther <rutherther@ditigal.xyz>
To: u-boot@lists.denx.de
Cc: Frantisek Bohacek <rutherther@ditigal.xyz>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
Date: Wed, 21 May 2025 20:16:20 +0200
Message-ID: <20250521181620.8175-1-rutherther@ditigal.xyz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ditigal.xyz;
 i=@ditigal.xyz; q=dns/txt; s=20240917; t=1747851400; h=from : to : cc
 : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=MM5PU+6ZHB7qUo9mB5V1n0uKzWosPSopBGpvZNg8SFE=;
 b=PA/GRcB4RfirZ6uBNQChKpCOyT8q0TdJReUR6R//SvfQjis0IOZ4fhDYIM1V4AT833aKo
 0qsKIYmDaSMXHkkNSKs8p9Rz34MATuFcYhtaCZEBR9VYDyN6jlBkgRs9pJ+rcrlH00xgtQ6
 yBPQTjLqpEou8sqwWP+5Zi7tyPRnfOE=
X-Mailman-Approved-At: Wed, 21 May 2025 22:12:24 +0200
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

The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
four bits for each GEM, and one bit reserved in between.

This has caused that using more than one GEM is impossible,
additionally corrupting the GEM0's configuration, leaving GEM0
unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
going to write to GEM0's registers wrong value, leaving GEM0 unusable)

Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>
---
 drivers/phy/phy-zynqmp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
index 7049e740d56..9649e660220 100644
--- a/drivers/phy/phy-zynqmp.c
+++ b/drivers/phy/phy-zynqmp.c
@@ -138,6 +138,7 @@
 #define PROT_BUS_WIDTH_40		0x2
 #define PROT_BUS_WIDTH_MASK		0x3
 #define PROT_BUS_WIDTH_SHIFT		2
+#define GEM_CLK_CTRL_WIDTH_SHIFT	5

 /* Number of GT lanes */
 #define NUM_LANES			4
@@ -400,6 +401,7 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 {
 	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 	u32 shift = gtr_phy->lane * PROT_BUS_WIDTH_SHIFT;
+	u32 clk_ctrl_shift = gtr_phy->lane * GEM_CLK_CTRL_WIDTH_SHIFT;

 	/* Set SGMII protocol TX and RX bus width to 10 bits. */
 	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, PROT_BUS_WIDTH_MASK << shift,
@@ -417,9 +419,9 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
 	 */
 	/* GEM I/O Clock Control */
 	clrsetbits_le32(ZYNQMP_IOU_SLCR_BASEADDR + IOU_SLCR_GEM_CLK_CTRL,
-			0xf << shift,
+			0xf << clk_ctrl_shift,
 			(GEM_CTRL_GEM_SGMII_MODE | GEM_CTRL_GEM_REF_SRC_SEL) <<
-			shift);
+			clk_ctrl_shift);

 	/* Setup signal detect */
 	clrsetbits_le32(ZYNQMP_IOU_SLCR_BASEADDR + IOU_SLCR_GEM_CTRL,
--
2.49.0
