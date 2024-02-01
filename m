Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175EDC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D9987C58;
	Thu,  1 Feb 2024 15:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ewCdv5XI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE44987C92; Thu,  1 Feb 2024 15:05:48 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8B287B6C
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B57CC61F10;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6828BC43394;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706796343;
 bh=QqDy4nhpjP9bczgUZB1oRs2acrhmt7eiCA6XgXaytA0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ewCdv5XI1HMrqIIE4yYkpRDQkBHjxpSR3uVpEcGP0NFFOV8T4FKEos2LLC0/jZ7AA
 9ptBF8lFQN+p4A/zeeMhf7VREayc0goWaYU9uFqSN9QXpvd+hkwY2axp7zlLzhkvsB
 AIKmmbJg9E6ECyQZZ6cjDrKNLsvkGoK/QDH3GLoCwCD1B9iLKXhNSFIb6B7YtJTMOa
 DCVTOa8yl4rArM//MxNfUL7fwaqEioaMdByGEjpDDSUJ6ucX/+F7bCzlQGlF5a2eME
 7Tga/061d9MS5nR4YV63kEkAExs2RP8D0CSIFy5DxocYNjNQhlQF9xuX7cdrQ+yXfU
 U7c9MQ2HAuJRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6DFC48294;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 01 Feb 2024 22:05:44 +0800
Subject: [PATCH v2 3/3] mmc: hi6220_dw_mmc: add fifoth_val to private data
 and set it in .probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-mmc-v2-3-9f09dc1335fd@outlook.com>
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
In-Reply-To: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706796342; l=1853;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=k/PjMbPi1J4MPo25pPuP0uhtm5RSzobNHIIRi+djbLo=;
 b=k4eZdCit7W3fOzhs+AeZoX48vbifXzpedgoIk+5esiHaeEzBxbnh3bJNwTT76ejPWx6HnDums
 styR28cCNZsBHyYaoQmZC53DUuVUL23gtrxl5akJ5lhPtvMR0pxt8Hp
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

The value defaults to 0 and is ignored by dw_mmc code, so the other
users are not affected.

Setting this explicitly fixes some weird reading error found on Hi3798MV200.

Fixes: 8a5dc8140e62 ("mmc: hi6220_dw_mmc: add compatible for HC2910 support")

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/hi6220_dw_mmc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
index a4b8072976..dc0210402b 100644
--- a/drivers/mmc/hi6220_dw_mmc.c
+++ b/drivers/mmc/hi6220_dw_mmc.c
@@ -37,6 +37,7 @@ struct hi6220_dwmmc_priv_data {
 struct hisi_mmc_data {
 	unsigned int clock;
 	bool use_fifo;
+	u32 fifoth_val;
 };
 
 static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
@@ -125,6 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
 	host->mmc = &plat->mmc;
 
 	host->fifo_mode = mmc_data->use_fifo;
+	host->fifoth_val = mmc_data->fifoth_val;
 	host->mmc->priv = &priv->host;
 	upriv->mmc = host->mmc;
 	host->mmc->dev = dev;
@@ -154,13 +156,20 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
 	.use_fifo = false,
 };
 
+static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
+	.clock = 50000000,
+	.use_fifo = false,
+	// FIFO depth is 256
+	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
+};
+
 static const struct udevice_id hi6220_dwmmc_ids[] = {
 	{ .compatible = "hisilicon,hi6220-dw-mshc",
 	  .data = (ulong)&hi6220_mmc_data },
 	{ .compatible = "hisilicon,hi3798cv200-dw-mshc",
 	  .data = (ulong)&hi6220_mmc_data },
 	{ .compatible = "hisilicon,hi3798mv200-dw-mshc",
-	  .data = (ulong)&hi6220_mmc_data },
+	  .data = (ulong)&hi3798mv2x_mmc_data },
 	{ .compatible = "hisilicon,hi3660-dw-mshc",
 	  .data = (ulong)&hi3660_mmc_data },
 	{ }

-- 
2.43.0

