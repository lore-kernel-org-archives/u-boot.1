Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F55EC5DF9C
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 06:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B4B6405BD;
	Tue, 25 Aug 2026 06:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBZ0q4X5eFuP; Tue, 25 Aug 2026 06:05:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787637932;
	bh=espoh+WtzvmY2VnwyJqecINyACeBwYtgMNbpUGduwUc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vdWnFAqkzNRlQVMn3HCL8fpcX15qYAdBuvGqGXJEd/3/c5yqLfB+CwXI1t+m9gGJ1
	 Jidmuzns4sAP/IbhuVcUTob3gcy6QMKcBYuB+x1xbHXPtiL+L/rHcvV3xOEp1Xen6d
	 UCN7XuPpqpcs75bIZBsKLnGYtDz/WsalGekGYaVQtnMLLdQi8Jq0wkhtAeH5jhc6J/
	 bIAFG4tjEec9hUNImNJU4Ijb4Ls/geCl1BMKji6Ewnk10Y8k1fn87Nov1v2BfdShTz
	 3D+9VZr6/ZnDx/P6KWF4zfiEXNBeQ/g0HuC3avbJMybgTN3pyh+1EMjK3VRzFao1Zs
	 csHGixKCYxt4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58F29405BE;
	Tue, 25 Aug 2026 06:05:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B32F335E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A50E2405BD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id At-kypRrFrCY for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 06:05:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=jNgrZPrl
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 088E34059E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 06:05:29 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787637924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=espoh+WtzvmY2VnwyJqecINyACeBwYtgMNbpUGduwUc=;
 b=jNgrZPrlthALA44nUBZRLzUzeS8WvW4jAS6eg+hvoU4MhrhwCA5Ym24CebAriFTQAUQlbo
 0kAaVZ1Gx7JF5S1cNBA6NI7SeSKwmuNYJHtRWZ6hVtWJ2tRWM5V9lECZGD8oskwWJ+0xYZ
 4gkSnlT7z2g9RIJR20hZcQmHJjNdI2LKq7IjJUVyUZVEKnxduhMf+7VEYGeQ+/f+TBJX4Z
 bzX3h6sk/TXF1hJKdDphqhftDxLeQ4VI2uy7dtdpOFKPOjvq9VRNQSZsoKqAiIcv4chcnU
 oakdrR0BQeM2ViCoyqphwTaI5iI0szqX32bBldfnB+OmnwV84mjsT9wEJsYg7Q==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Marek Vasut <marex@nabladev.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3] ddr: imx: Reload the training firmware for every PHY
 configuration
Date: Tue, 25 Aug 2026 08:05:03 +0200
Message-ID: <20260825060504.4974-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

ddr_load_train_firmware() remembers the type of the last loaded firmware
image in a static variable and returns early if the same type is
requested again. That is valid within a single ddr_cfg_phy() call, where
the 1D image is used for several frequency setpoints in a row, but the
state also survives across calls.

Boards that probe several DDR configurations call ddr_init() more than
once. The power up procedure at the beginning of ddr_init() resets the
DDR PHY, which leaves the image in the PHY memory in an undefined state.
The second call then skips the loading, starts the PMU on whatever is
left of it and the training firmware never reports a result. As the PHY
also stops answering on its APB interface at that point, the boot hangs
in a register read, which no software timeout can recover from.

On some specific Kontron SL i.MX8MM with 1GB or 2GB DDR, where the first
init is expected to fail and the second one uses an adjusted
configuration, this made the boot hang every few cycles.

Move the check into ddr_cfg_phy(), the only caller, so that the loading
is still skipped for repeated setpoints of one run, but never across
runs.

Fixes: b614ddb5d335 ("ddr: imx: Save the FW loading if it hasn't changed")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3:
* Drop patch 2-4 as they need to be sent separately

Changes in v2:
* Add missing hunk due to rebase gone wrong
---
 drivers/ddr/imx/phy/ddrphy_train.c | 14 ++++++++++++--
 drivers/ddr/imx/phy/helper.c       |  7 -------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 1a2d071d6f1..63a6ca800a3 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -12,6 +12,7 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 {
 	struct dram_cfg_param *dram_cfg;
 	struct dram_fsp_msg *fsp_msg;
+	int last_fw_type = -1;
 	unsigned int num;
 	int i = 0;
 	int j = 0;
@@ -33,9 +34,18 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 		/* set dram PHY input clocks to desired frequency */
 		ddrphy_init_set_dfi_clk(fsp_msg->drate);
 
-		/* load the dram training firmware image */
+		/*
+		 * Load the DRAM training firmware image, unless the same image has
+		 * already been loaded for an earlier frequency setpoint of this run.
+		 * It must be loaded again for every ddr_cfg_phy() call as the caller
+		 * resets the PHY before this, which leaves the image in the PHY memory
+		 * in an undefined state.
+		 */
 		dwc_ddrphy_apb_wr(0xd0000, 0x0);
-		ddr_load_train_firmware(fsp_msg->fw_type);
+		if (fsp_msg->fw_type != last_fw_type) {
+			ddr_load_train_firmware(fsp_msg->fw_type);
+			last_fw_type = fsp_msg->fw_type;
+		}
 
 		/* load the frequency set point message block parameter */
 		dram_cfg = fsp_msg->fsp_cfg;
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index 147ec9ab061..3c39c89de19 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -50,15 +50,8 @@ void ddr_load_train_firmware(enum fw_type type)
 	unsigned long imem_start = (unsigned long)_end + fw_offset;
 	unsigned long dmem_start;
 	unsigned long imem_len = IMEM_LEN, dmem_len = DMEM_LEN;
-	static enum fw_type last_type = -1;
 	unsigned long spl_start = 0;
 
-	/* If FW doesn't change, we can save the loading. */
-	if (last_type == type)
-		return;
-
-	last_type = type;
-
 #ifdef CONFIG_SPL_OF_CONTROL
 	if (gd->fdt_blob && !fdt_check_header(gd->fdt_blob)) {
 		imem_start = roundup((unsigned long)_end +
-- 
2.55.0

