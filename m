Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDC7E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE4780214;
	Wed, 11 Dec 2024 08:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fPfwnmuj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r1JOu1p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C832D802E6; Wed, 11 Dec 2024 08:32:39 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D03E80235
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S4532ZMz9svD;
 Wed, 11 Dec 2024 08:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cil2xC1vz2ZkVuALhwxHxM+IErJP9zlTGafHdrpoL3A=;
 b=fPfwnmujvN3DjdE+nPgArCJNAy6kTD9Gg5th1Zj6h8TJFN6+6552sqoxRZvvQW3NA2sSWI
 8E9LSHnA4UYhAs8dJsLL8wJwQrjIqZ96MTLNMV4JthUJ42YnUvAizQEhB6UhZ2aSP8s3rf
 atpUCYTdfIyV1bln78l2FjTVDUVTUFrM6plsWFtraqFKfeXGoUnD8JerSfnD1K9Lo3sx6m
 YG+vu9ZObXTgoZ0+GCTirvOxtXisPNDyqiEEeZTYtArzFalszM4W+hp8/AEiCv6kKcAkyK
 LGLcYGz0fC+ndOLk4qs3ZTOhYXA77kf3/fYs7fyydWR7I+4D6eAe/ZPzXMXmKw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cil2xC1vz2ZkVuALhwxHxM+IErJP9zlTGafHdrpoL3A=;
 b=r1JOu1p83bJFilu5SG89IT9Fw4mRWPfpFFVtC+YO6zqQFCK2rv3zGpkVeWQ2giLLih7LYJ
 R2vORBA5jH1jeuejC8GIyh74RLQ60OhXnCnIRn0B/2YsfRqqSxRbyr4SRFmVxRzjxLjWvW
 oMcBt5sGtlQdodXpGKg771nRWn1oY18VYl8aEtqL/wtVDhSLLeIWc1iV0gvv7Tf+dJ7Eik
 UlEfvqH5b8Iyjn8UFTuXMlLDdl2PDToA/du+SjEITa/wLZkvQw3MomcwcrLlGhLUYAJYKj
 Ee1G7/VQppz6Y5wziSp5tqYvW3CAgTtbaHcCAm0Sj8bIO8eVW8sb8ZznzC1cxg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/13] phy: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:33 +0100
Message-ID: <20241211073210.8087-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b78822a07fc4a878b86
X-MBO-RS-META: sz4fr836bgyxzwx5okq8fxyddfxpk11k
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

The correct spelling is R-Car, including the dash, update the usage.
Comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Update commit message, do not mention Kconfig
---
 drivers/phy/phy-rcar-gen2.c | 2 +-
 drivers/phy/phy-rcar-gen3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index f9428c7ad12..be736629d51 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen2 USB PHY driver
+ * Renesas R-Car Gen2 USB PHY driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
index b278f995f37..8c004eaf4c6 100644
--- a/drivers/phy/phy-rcar-gen3.c
+++ b/drivers/phy/phy-rcar-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas RCar Gen3 USB PHY driver
+ * Renesas R-Car Gen3 USB PHY driver
  *
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

