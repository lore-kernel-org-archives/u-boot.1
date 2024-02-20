Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3786DC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F67187F9D;
	Tue, 20 Feb 2024 09:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LF8Bibjn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ui3XsekG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8321D87FA5; Tue, 20 Feb 2024 09:38:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D46F87FA1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TfCTt2pMdz9snn;
 Tue, 20 Feb 2024 09:38:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgL23ObvBRSmJ2KBgXTBtioo6wyDnYmWwp9AAJpiUUQ=;
 b=LF8Bibjne92bx04wTY0/2TUXsYFHegzrx0exGCuKIwz8i/VTGH1jj0HStIi5xS/1lcBMGN
 EqcCx2c/9w9y/Tiuu2VDFq+UJ6CFuILSJNBzjN4ifw1pNW3AL3FbPD+ppp0+XEf6ImbudN
 k/7/HX/dVqLk83sjx9XqkBwN4JuZ22fnSVOfrGboOoJ5fv94U4XjPxHIKVSCT/GMC/k+sK
 /3xJ3RrPJWVp/iXwKDWNjBdqGqgxUv7F67DbUlqBk/MhLpJoTVebFijoKoxG0FS6bZPHgy
 kWv1g3EHZ7/Vx5N2cjIKLsCJob2MUTDDAs+3wSuRsEMfwUn943uiBRLx9W9Nhw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1708418288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgL23ObvBRSmJ2KBgXTBtioo6wyDnYmWwp9AAJpiUUQ=;
 b=Ui3XsekG/HOYgHGKX1NPT1dRpeVkZlI4bGKvuVuyXCRIkcj3Nf3MwjXq0KyG+BDE1j5Rwk
 CMgUqcnToj6wCg+JqP8rXgNXknBkK3nYo6aQQjYDAsnDbxPd4L2Puqw59Dd+ejODwMxCNz
 USpCLDjpSZv6a5XBHNoSPp2EErNArZLMyHT86+7WsEbFSyQHxkV2vSE7YkbyoDoFd9CL0z
 kllt62z9Sr4m5m83ZC6vUyPRPVBjTsPTg2KJwIMXga23PZ76n/PPQmHO5YTLCctj5blaJz
 gx9FOQ4CQq+HVs6PF0iJJvqMNnPdRnE389iH7FY0VGcgprEek19cdCq5v9cWGQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] mmc: Add generic tuning flag
Date: Tue, 20 Feb 2024 09:37:48 +0100
Message-ID: <20240220083755.34449-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
References: <20240220083755.34449-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 27de69d6a2f95de30a3
X-MBO-RS-META: js4cj9fdzknzz5pu8b3em1xuyj7kdqho
X-Rspamd-Queue-Id: 4TfCTt2pMdz9snn
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

Set generic mmc->tuning flag when performing tuning to indicate
this condition to drivers. Drivers may use this to bypass various
checks during tuning.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/mmc-uclass.c | 8 +++++++-
 include/mmc.h            | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 328456831dd..304bd5eaee2 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -124,7 +124,13 @@ static int dm_mmc_execute_tuning(struct udevice *dev, uint opcode)
 
 int mmc_execute_tuning(struct mmc *mmc, uint opcode)
 {
-	return dm_mmc_execute_tuning(mmc->dev, opcode);
+	int ret;
+
+	mmc->tuning = true;
+	ret = dm_mmc_execute_tuning(mmc->dev, opcode);
+	mmc->tuning = false;
+
+	return ret;
 }
 #endif
 
diff --git a/include/mmc.h b/include/mmc.h
index 92cffc6a19a..47ccf5f45a1 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -736,6 +736,7 @@ struct mmc {
 				  * accessing the boot partitions
 				  */
 	u32 quirks;
+	bool tuning;
 	bool hs400_tuning;
 
 	enum bus_mode user_speed_mode; /* input speed mode from user */
-- 
2.43.0

