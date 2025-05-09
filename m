Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4EC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 16:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4CF82977;
	Fri,  9 May 2025 18:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ditigal.xyz header.i=@ditigal.xyz header.b="KvbJ7VYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFAF82935; Fri,  9 May 2025 16:41:10 +0200 (CEST)
Received: from mail.ditigal.xyz (ditigal.xyz [IPv6:2a01:4f8:1c1b:6a1c::])
 (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E65F8283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 16:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ditigal.xyz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rutherther@ditigal.xyz
Received: by cerebrum (OpenSMTPD) with ESMTPSA id 4ade6a7a
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 9 May 2025 14:41:07 +0000 (UTC)
From: Rutherther <rutherther@ditigal.xyz>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
	Rutherther <rutherther@ditigal.xyz>
Subject: [PATCH] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
Date: Fri,  9 May 2025 16:40:53 +0200
Message-ID: <20250509144053.17647-1-rutherther@ditigal.xyz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ditigal.xyz;
 i=@ditigal.xyz; q=dns/txt; s=20240917; t=1746801667; h=from : to : cc
 : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=FXye0HePfRnVjyQLM3RLp8eEi2SbtSevBjY23G4ANGw=;
 b=KvbJ7VYvXERYfSkdZvHxhYAnoq1rrvLuTJDD54pg7hB2KgaTLLeGPd3GYby6/0PIIB4wW
 Qzecgd8BDL2w5lLYjy+A47uodWXWZSPo/RTfIyFFTCEve+wF1cfpgRVUWCgZtRDg6xAw90A
 GauW3nyW/vL3DBeceuAJ/zfhVcZ6uV4=
X-Mailman-Approved-At: Fri, 09 May 2025 18:48:46 +0200
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

This bug has caused that using more than one GEM is impossible,
additionally corrupting the GEM0's configuration, leaving GEM0
unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
going to write to GEM0's registers wrong value, leaving GEM0 unusable)
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
