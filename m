Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D079CFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4F584261;
	Tue, 17 Mar 2026 02:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8YP2zh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FFC84246; Tue, 17 Mar 2026 02:24:41 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6302784227
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46726528f1cso3561757b6e.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710677; x=1774315477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dkmEo95UvdNBfE4JfIYR8wKkHFnIYP83niYKSi023R8=;
 b=p8YP2zh3ol66vXg6b2/bIIcmDMyzMM6jsa8L1mnA8vemDzklvu0fEp8MoA8GT2b7iL
 yXKjNugutyE+mPjADBJNr7mkwRCuFuPnnKY8N6qSnkHlpHphRJpOth54l6FIogsgr/O4
 z6xzCcfl3gsdNclmzsKQe+tPWel1uB8hFmDrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710677; x=1774315477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkmEo95UvdNBfE4JfIYR8wKkHFnIYP83niYKSi023R8=;
 b=NKVLIH9w4ovHzEStgZ66p0F1kGStsivodKQqUEvRx/YiLoKB356zqhUYc/VDJcvcPe
 FkVY/Bsjog8XeKwYSDtd/1O8ic93B5UUuFfEs+tIcqokIGXb0fzyV4Acw78J5+DdgCCp
 uq4YMFpj1a1rExCEenQrkiZ7uBN5uRyUkw1ZAlQmH2PEff46HvABCiAF6kb/i5Z2kyM5
 iC3hF++qejpqHkBxEw3K+M/5yVS5e3z6XxbTZaJGhQfBZB6SbL3V7Mfs4zXLiUhJ1klh
 27CByj19U/WO+qPfdtVNmWy4hkScR/gBL8iC43NVAupN8iFl1WYCvqKiekzhqX+oPRmJ
 YcGQ==
X-Gm-Message-State: AOJu0YxkoCaWT1q/s99MRdV0xGDHXREb1V2JUXn0WOoCArmCAAhXSdJ9
 pSivi7DnF2FUp4mtHBqQ5HcTQMMGJndZWp9qyJWkTWD2xXjVQb4awYx89Z7K1mRbysV4TRKTl4H
 UEIRiOB4=
X-Gm-Gg: ATEYQzxP5+5Hnqj15pGu+0YsSIcqlHAQbuNFY5omhh42ZsTRrLkmD8kFCZQLZMVt+Fj
 I45tA+wAF+J/HWKIfGbahvKAHJhMwkRnOCIo9ygYbdUF56FlP9tDx7fbHNy6PdS6pmBn5b7cTXN
 ItPWXUH5UoW2MP2QuIKe8poSLtQa7L4oC+NrwlTqhg6XXxCYpRFSMq0YH1JUwMj0WH0UXeTa6YC
 zhuGp67c3pnihOrz8NFJx8Conz2NSj0a39FQ9atOVay2GFk+Y2KCwVV4JkvZoqodaBAiNAKRuNe
 IG/KmdNNzCzleZWrT6gJ4GtrEukuFaB3KHaNvzuyHhYLUliBzCdZvkpxJNkJVebNz9w6zOUfu+i
 fEFgQOGfKgOeHyeGyxXwBWRHvIr6SmFt1ssZ5+2tNi/nHW6YsyVoV+mSAhfhULCLJt6ZHudyi1F
 GTCyRojXBUn4v4qQOQKqZ1jKpo1Z07DQve+7TxKwNB+CDYo8GTWswEB42+5IMQNTYHnVZnIjfns
 FjknpVJlGD/auzevLLxXfj6yxeFWrQpUYqVqywaiAsA3Pps1l4=
X-Received: by 2002:a05:6808:140a:b0:467:22fe:eb10 with SMTP id
 5614622812f47-467572eb815mr9035546b6e.34.1773710677127; 
 Mon, 16 Mar 2026 18:24:37 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342c084asm10220242b6e.12.2026.03.16.18.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH] dfu: Correct dependencies for DFU_TFTP
Date: Mon, 16 Mar 2026 19:24:35 -0600
Message-ID: <20260317012435.4162538-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for DFU_TFTP. This really depends on the legacy networking stack being
enabled, not just lwIP not being enabled (as it will fail in the NO_NET
case).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/dfu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 962bda40ad2d..1d5d8caa7daa 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -20,7 +20,7 @@ if DFU
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
-	depends on !NET_LWIP
+	depends on NET # Legacy stack only
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
-- 
2.43.0

