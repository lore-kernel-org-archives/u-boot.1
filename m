Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB24C35FF1
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092298186D;
	Sun, 16 Mar 2025 14:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bcvaTn3L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RxMBbDPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9056181100; Sun, 16 Mar 2025 14:54:49 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AD480C93
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZG03C3NxDz9sqg;
 Sun, 16 Mar 2025 14:54:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9s5tipXqnwX+z5Qn22zb9TKBbADdj47j02nDVXPzB30=;
 b=bcvaTn3LwSIa+S41tGonMDodbUddsSf6lQFDyrqRf0bBY+oLHzcYtjWJSvvFH7ItS57raG
 Ft/4pEfB/RZ6td3/Og1HrhfbY3i0ffH5UJgnqX/PaEiglPpQK0F1gMnxy70gjvMqgWPcvv
 f26bmtiZ6LhvMf53j6zd6mqUGcSTojoXO3Wm3ilpWlNTWhTm8IBf3ksXlbs7BNWirWeMYX
 Xp7aiKQ0tWMRPSRdSwkByQR06wc+VaQu9jeVXTuIFprCYWIt7WzFZ4/dsKEPM/uKhdadkX
 LVTecpLb643mSpQGOky0PmDRVz3aXpUKVvMzhC0Z+MfRChCrhcC1jXa5PkYm5g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9s5tipXqnwX+z5Qn22zb9TKBbADdj47j02nDVXPzB30=;
 b=RxMBbDPkfHXb+AcBBgyyj1ri+XFdvfOEhlibqLXLUrZH63sFIvndtKWm7ZCk/HERp7uCgl
 FEPCaeDMWy9hgJtEjvdlDifpN2Q3yiV4YumnomSccg4t/Uah0SehLYbL62D1eifNLlS0uU
 csj6Lo8EjDf3Bnj0z53HFDbmXpAgZtlutlelQk23IsYFv1PsMKnkDXeiXnFHCEG1Kk2UhK
 qNSyDc8dCDL8FO280c3tndUW8k7FVxRXiQONeFhgC7BL8zpKi9kbnhNE2ap+ELiTi5s2aM
 W08bvjjEzkmVP4v/XKCrGc0qO4bB+oSEH3JfFWkx6AmoJ81qYbN1hkBwMYFJNA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] ram: renesas: dbsc5: Fix DBTR11 calculation
Date: Sun, 16 Mar 2025 14:51:41 +0100
Message-ID: <20250316135417.7909-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3c824d4b5c269884fd3
X-MBO-RS-META: mfs7cbxupss4jo3nepuukmdhbrrunk95
X-Rspamd-Queue-Id: 4ZG03C3NxDz9sqg
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

Reinstate missing increment by two in DBTR11 calculation based
on the original DBSC5 initialization code rev.0.80. The original
code did ... ODTLon - (js2[JS2_tODTon_min] - 1) + 1 , which was
incorrectly converted into ODTLon - js2[JS2_tODTon_min], but
should have been converted to ODTLon - js2[JS2_tODTon_min] + 2.
Add the missing +2 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 289d1224673..0616658e9f8 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -2635,7 +2635,7 @@ static void dbsc5_dbsc_regset(struct udevice *dev)
 	 */
 	dbsc5_reg_write(regs_dbsc_d + DBSC_DBTR(11),
 			priv->RL + 4 + priv->js2[JS2_tWCK2DQO_HF] -
-			js1[priv->js1_ind].ODTLon - priv->js2[JS2_tODTon_min]);
+			js1[priv->js1_ind].ODTLon - priv->js2[JS2_tODTon_min] + 2);
 
 	/* DBTR12.TWRRD_S : WL + BL/2 + tWTR_S, TWRRD_L : WL + BL + tWTR_L */
 	dbsc5_reg_write(regs_dbsc_d + DBSC_DBTR(12),
-- 
2.47.2

