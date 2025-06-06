Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404CC5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80CD81FEE;
	Fri,  6 Jun 2025 11:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="BKpawqhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9320D828F8; Fri,  6 Jun 2025 11:51:07 +0200 (CEST)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F4E803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
 by mxout4.routing.net (Postfix) with ESMTP id 2949D10001E;
 Fri,  6 Jun 2025 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1749203465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yg6xzIcUsTBsc/YaJiNmkcrlLnhfdulS7B33swcSuuM=;
 b=BKpawqhJCZ1atMfQmN+FdCU+umZ7Xl0/bVZAamt/yS1ymykf+MktMONm+gVPSMDY7b4M6R
 qoX9eNblwLZmBcndWsfGnl6vbXSVjNWvqy2sPOeEgxFpr0wTdSq54qnVMM8vBT/DXZnsL0
 qS6f7yWMK0ogWLy2SbWjIGpIdmBXDM8=
Received: from frank-u24.. (fttx-pool-194.15.80.120.bambit.de [194.15.80.120])
 by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 06EA01226D4;
 Fri,  6 Jun 2025 09:51:05 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Michal Simek <michal.simek@amd.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Maksim Kiselev <bigunclemax@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1] i2c: muxes: pca954x: add pca9545 support
Date: Fri,  6 Jun 2025 11:50:54 +0200
Message-ID: <20250606095056.22082-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
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

From: Frank Wunderlich <frank-w@public-files.de>

Add support for 4 channel pca9545 found on Bananapi R4.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/i2c/muxes/pca954x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index 9dd269727036..d13947a0d9cc 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -22,6 +22,7 @@ enum pca_type {
 	MAX7369,
 	PCA9543,
 	PCA9544,
+	PCA9545,
 	PCA9546,
 	PCA9547,
 	PCA9548,
@@ -79,6 +80,10 @@ static const struct chip_desc chips[] = {
 		.muxtype = pca954x_ismux,
 		.width = 4,
 	},
+	[PCA9545] = {
+		.muxtype = pca954x_isswi,
+		.width = 4,
+	},
 	[PCA9546] = {
 		.muxtype = pca954x_isswi,
 		.width = 4,
@@ -141,6 +146,7 @@ static const struct udevice_id pca954x_ids[] = {
 	{ .compatible = "maxim,max7369", .data = MAX7369 },
 	{ .compatible = "nxp,pca9543", .data = PCA9543 },
 	{ .compatible = "nxp,pca9544", .data = PCA9544 },
+	{ .compatible = "nxp,pca9545", .data = PCA9545 },
 	{ .compatible = "nxp,pca9546", .data = PCA9546 },
 	{ .compatible = "nxp,pca9547", .data = PCA9547 },
 	{ .compatible = "nxp,pca9548", .data = PCA9548 },
-- 
2.43.0

