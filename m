Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37072EE49A5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6DF864D7;
	Wed, 23 Aug 2023 02:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sgZ33Eb2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BwxqZGHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FEB864C1; Wed, 23 Aug 2023 02:18:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E071C864BE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RVmz85fv9z9sdD;
 Wed, 23 Aug 2023 02:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SowIvMIi1je9gCrbCNGyFgx85iUhmQKUq8pnEGetqw=;
 b=sgZ33Eb2AN3abv6aP7w9q/wDDTCGJEZPfnBmSoieuhXUll96J8vDEyANpWZLYeQlQaZ7rs
 rVhBP86j8NVxy9bsdiheAJDdJQbXElYUtDixw+TCyjkhF1sVL480DTIAB18j+XK8myJ8ua
 Or9ATdonx9VXNmK7hBqxQdULFYor+WixeklRoOoGcrltw1txaeCfVdiLF9v6FG38jwO6gC
 w6Jy1vlwI0FzgySG2BaNIyHf9He/qLrp9znXuPQUXxpUdM5PH0OBH8VI5uNXW9o61DXVG+
 ZLNKquTvmw/Wl3P/lDZARqw8VnkIHDH4YF48X/5Ejp9Q2u6/KqVgOFsUY0hEgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SowIvMIi1je9gCrbCNGyFgx85iUhmQKUq8pnEGetqw=;
 b=BwxqZGHkBs+LcHUZVq82zevVe3WHtc3Do7crOELkifH7QJrBvYSK9mxPQtlDxMBOHUi99j
 7lZSI6kyRigjL1XBA7+uY3qChckNnkg7dkEQgHgVV8j7LIRtxUhtRSceSiOpr7GXw4bR2X
 TFkeotrgCLpjdwjhNH4q9s4QlW6zm5U/IvOlVcRu9yDbTu5PmDhPr4PYGQQZvJj+fVWWUJ
 /YQUTyTWAl//RutPJxB3X2bINtRwZagHMBWLXtg9jyf1m+2hAD0ngiPF0a0D4D1czy0KoE
 Z/U75iBeu7vaNxmjoRnw87EIt3Aa7E2Ds0CTjDpq80Dufftpo43yvxnm9A6Sww==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/5] drivers/mtd/nvmxip: Move sandbox_set_enable_memio() to
 test
Date: Wed, 23 Aug 2023 02:18:20 +0200
Message-Id: <20230823001821.266578-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t9fry5bn7fbc3bf7taiu4e1gdradf1qg
X-MBO-RS-ID: 7cd0a63843757b0c480
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

The sandbox_set_enable_memio() should only ever be set during
sandbox testing, not within driver itself, move it back to test/ .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: New patch
---
 drivers/mtd/nvmxip/nvmxip-uclass.c | 4 ----
 test/dm/nvmxip.c                   | 2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 36eb056c213..9a316d1de39 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -29,10 +29,6 @@ int nvmxip_probe(struct udevice *udev)
 	char bdev_name[NVMXIP_BLKDEV_NAME_SZ + 1];
 	int devnum;
 
-#if CONFIG_IS_ENABLED(SANDBOX64)
-	sandbox_set_enable_memio(true);
-#endif
-
 	devnum = uclass_id_count(UCLASS_NVMXIP);
 	snprintf(bdev_name, NVMXIP_BLKDEV_NAME_SZ, "blk#%d", devnum);
 
diff --git a/test/dm/nvmxip.c b/test/dm/nvmxip.c
index 89bf481f616..f0ad47d4efe 100644
--- a/test/dm/nvmxip.c
+++ b/test/dm/nvmxip.c
@@ -103,6 +103,8 @@ static int dm_test_nvmxip(struct unit_test_state *uts)
 	void *buffer = NULL;
 	unsigned long flashsz;
 
+	sandbox_set_enable_memio(true);
+
 	/* set the flash content first for both devices */
 	dm_nvmxip_flash_sanity(uts, 0, NULL);
 	dm_nvmxip_flash_sanity(uts, 1, NULL);
-- 
2.40.1

