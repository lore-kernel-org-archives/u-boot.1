Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC3AC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 06:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 865D040653;
	Wed, 19 Aug 2026 06:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1MDwR0YCdqqM; Wed, 19 Aug 2026 06:59:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787122790;
	bh=Hcp+XHnvPOIIKDPt4EPOItG9eKBjnfEFGrDwRyRXoZs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AJjFkT8AogMOeRUFj83wd+VHsqWmIORNhmDAdctfwEB7BstqHkA73HA8OOeqSAAvg
	 cQM6nIFns3zC46QjMYn9gMeLodX0yrl3VBwJxOMlATU72cDwcQ5mlGECL1wllpsz1+
	 kbH7Aq0T3Rqofmn4sUUXP3Z2ySp+z1WjUIwHJPgwASNbQQojQ2fREG/BpOvrokW7X8
	 5igQotTslDYJXhg/FQOw5ulpNIZRAMM0lvRdxo8/Xg4ad8FksfIS9/uRiXM50s5srF
	 g/V2Pi5RYJSuAUv8ZlWdQ+0RDQGpt9Bhi/K4fIUyquP5rq7eJFZyGX6Tgw+gL0wsK7
	 kuQbtlS9a0ZyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6785C40697;
	Wed, 19 Aug 2026 06:59:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 256761EA4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0782F400C5
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdMcsd6yvvfX for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 06:59:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=ONWQipYQ
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8289440026
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:45 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787122782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hcp+XHnvPOIIKDPt4EPOItG9eKBjnfEFGrDwRyRXoZs=;
 b=ONWQipYQ4u2s3X+VxG8oOx409x1vA5krZVjpcF0xYE6fK2CTOfmZNZYhZvbc7NrG3p5w5A
 I0L4YqFfREoIdKv5f3n0LqQx3UF4FzZqg4K5Zjgikw9dMluE8+kFhNKMuY0dkoZFzML7E4
 GErxKfdSvFZ0UIMeeDGIN6FdxfUxH24Sp0jvyvGkbpccwkh4aroo1P+x50PR8x5jVBNyHG
 iFVyXeTYWEyalzDMu95Js2Kgbnv14nies7H7LF1xcfb9K6Z3kJlBqUvfl4r3o1QjQ3DRCX
 wpJiWt+Z47PHUsK+iNGMwA0HK+vLoi6W2ftC767IbLiEcuLwRi8orsvdHQjpGg==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/4] ddr: imx: Reload the training firmware for every PHY
 configuration
Date: Wed, 19 Aug 2026 08:57:58 +0200
Message-ID: <20260819065804.32156-1-frieder@fris.de>
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
 drivers/ddr/imx/phy/ddrphy_train.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

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
-- 
2.55.0

