Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E7C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E20788CA2;
	Sat, 20 Jul 2024 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lfy0LNwK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ef8HeMhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11B188CA1; Sat, 20 Jul 2024 14:43:56 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB48488655
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nk45qlz9sd6;
 Sat, 20 Jul 2024 14:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCHh+sAwFmokXPatOC2DNqHXW9wZmsh7qFZob8d40Ng=;
 b=lfy0LNwKhESMyx2jOVZI6h0rMlYkSyvbZpXsmwLWC4WwSXrLi1OYsXiP9SFdJg6uPXGif4
 IyM7qRzpO7hFCpInVTUJaei4jS7HbC0ak0qsl1tirwsXoh0tXi9+14faR/5aSwRF9cQeaq
 bwNwsT0zOaUiX3ekJ3B+EQEZkFLeEwtin8OENYdyIFUV7ftCKj2YbwUlLq73vuo0k87Yux
 bYgV05LpkT9L362cHAz3wffPzicwHdDx1uuCDTN5dpDN7YGrWQSJ/VBvPbdE71OGt42DIs
 ve8HbzhZJkLs7qwqdXyS1tDaX3EliZckBWuL11Prv7ldnsr/pwbFrX/t8zjWGw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCHh+sAwFmokXPatOC2DNqHXW9wZmsh7qFZob8d40Ng=;
 b=Ef8HeMhF7r0egVBlN+jtocJ/Z+ie8/aHqk1XQYBSdhnkmd8jjTrkP/AkJmDR1pTI2va/IS
 HKtxzqGgWGRmSISNk5gqG6JWzSjGKg5854wSViWf11meNMs1QyWFwgDpCBjRZZH/wZTq0F
 3Vt2EBleM8MmuAi5zSNcLeE5If0ar6WbjiyFbN1pe/3EwYOjDS3c6KLtfV84AOlKz9E4/P
 jtvPVb1hGeGtC2vTp99Nz/N8Mzgn5Lueu65YrGeVwAtyKhaZnISKoCNG+MCLcbs6PBUI0k
 8ZUDVkF+Ah2//SkLPeGvPPD3pacS6HjPoJDCQpcm1GccR+VOmA18ZhVfKelKPA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 24/40] drivers: power: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:49 +0200
Message-ID: <20240720124239.7553-24-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 42f1775c4282731e01d
X-MBO-RS-META: 469t6fekebokg9u7ejbzo5nth1wow5kp
X-Rspamd-Queue-Id: 4WR5nk45qlz9sd6
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/power/regulator/lp873x_regulator.c  | 1 -
 drivers/power/regulator/lp87565_regulator.c | 1 -
 drivers/power/twl6030.c                     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/power/regulator/lp873x_regulator.c b/drivers/power/regulator/lp873x_regulator.c
index c59d77118ad..271a7e45139 100644
--- a/drivers/power/regulator/lp873x_regulator.c
+++ b/drivers/power/regulator/lp873x_regulator.c
@@ -310,7 +310,6 @@ static int buck_get_enable(struct udevice *dev)
 	bool enable = false;
 	int ret;
 
-
 	ret = lp873x_buck_enable(dev, PMIC_OP_GET, &enable);
 	if (ret)
 		return ret;
diff --git a/drivers/power/regulator/lp87565_regulator.c b/drivers/power/regulator/lp87565_regulator.c
index d622d956815..2212cb5c651 100644
--- a/drivers/power/regulator/lp87565_regulator.c
+++ b/drivers/power/regulator/lp87565_regulator.c
@@ -167,7 +167,6 @@ static int buck_get_enable(struct udevice *dev)
 	bool enable = false;
 	int ret;
 
-
 	ret = lp87565_buck_enable(dev, PMIC_OP_GET, &enable);
 	if (ret)
 		return ret;
diff --git a/drivers/power/twl6030.c b/drivers/power/twl6030.c
index 39c05f9b7d3..0cf2e50d65c 100644
--- a/drivers/power/twl6030.c
+++ b/drivers/power/twl6030.c
@@ -29,7 +29,6 @@ static struct twl6030_data twl6032_info = {
 	.vbat_shift	= TWL6032_VBAT_SHIFT,
 };
 
-
 static int twl6030_gpadc_read_channel(u8 channel_no)
 {
 	u8 lsb = 0;
-- 
2.43.0

