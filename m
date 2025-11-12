Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA61CD4849
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 21:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D47383D0D;
	Wed, 12 Nov 2025 22:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cwVkdT4N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B2983D40; Wed, 12 Nov 2025 22:18:46 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F78483CEA
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 22:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c2846c961fso105154a34.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762982323; x=1763587123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ud7xwnS/HbI9AnV9+rol708eiFeeMmMkWefgpMx8ssU=;
 b=cwVkdT4NCM+DgEJcRb6yGkC35GODWPCaQLbqHwphElG69V9imHXz92PH+Q2XZB6wd4
 dm/R8MZPT6Ue0+dMy/IIdXy0BJFUNd+g+NdXmdzw5MK8Byy0UpcCS6TmKc4RFkJChUnk
 6ycKCu88TK4rghW8Wly9EjWN1C0/e2H87TAzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762982323; x=1763587123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ud7xwnS/HbI9AnV9+rol708eiFeeMmMkWefgpMx8ssU=;
 b=jGI0Bm9leNHh/4DCcA53UB0jMUUN9ANgml5gigLaNYp5zmNcVpgSOALn13l8HVyaKf
 pQQHi6qNIIf7DOvyJID+JPJYGdzEnlNHtICPaYVBZIAzf8y+3Thdq1b36D2lX/be9EBS
 9xJHdRlNmT4kPf8pQXXY6YonEIIb8zEKFbvY9AqbzGSulAmSZiOTD5d9MpXVjoL7pH+s
 LkrAVVQrQ1RWa9XmeSYV7qhMTPV3WHWOr5thO5M8pwI7hb2LJ4s/71PtjFvkzqLYl1Rd
 GhQ6nTPV482BMMG+A8/yNhrnriuxP8UTUKAYIwyt6gsbbTjdY11K8oaEfWG6mYVJjLf1
 iIJQ==
X-Gm-Message-State: AOJu0YzIUeIuSoQByNRZZHRCM90MIqTzI2uD1cMj7cdyrPqjcrYCjutt
 7iyzyAbfb79Zxgr8feDNtc06UVLoGIkdVCu/2CuowIq5gRy2Os0iSTBpKXkUv50sOCQpOXi3QJd
 zyvglGGt6Hg==
X-Gm-Gg: ASbGnctS/1h4aLgm6QRwhJySeg5HHK4+lyf2iAcXORw/mQHu27O1kOeCaJZaQmgIwz0
 ZGOr2vTWYQDF8ERysp3aF/XQtZsRXcCV6k2qShjfZ1OfTsyvC4DUokIJGgj8GSrQ1L3w8Xh9ZDh
 OwoxOzXOH/5RFpiw9GsgC/Qqv9IQa1va0reeLUXZEHEwhIEugXWWbN0tQDxTA+z4YUxn3pld27K
 f7XyJc30VudGPxB5LqFbyoTtMgZrua2mihH1vBjCaJPGmZFEDUYpnKgQ4i8vKVjGqx381ASGoX6
 pEJoJW9FwX97xlEbzFTJLqEBroUgnrSw9E8+raCydBPaitrc+jXZwkGln1DM9HNEwqQziGqREF4
 4Jg+aV6PXEy3avoZay8JRWIeLNUdTj07qXvTEMCT4e4zZp226P56NXcN49nj12em8sNWUzX1SUw
 Uk4tfBCsmnszOYkcQalIJgYSm61wRSDLP+UP8Brkws1A==
X-Google-Smtp-Source: AGHT+IH5OoywjO2tPG2YqGtsr1u3KwhEG/piCLCATKDYT8KiB6Y9yvWaCaeunaEK1XtXvfElOacCTg==
X-Received: by 2002:a05:6808:66dc:b0:450:7dc5:541e with SMTP id
 5614622812f47-4507dc557b1mr1140192b6e.54.1762982323249; 
 Wed, 12 Nov 2025 13:18:43 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45002752ca9sm8895186b6e.14.2025.11.12.13.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 13:18:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH] ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name
Date: Wed, 12 Nov 2025 15:18:41 -0600
Message-ID: <20251112211841.1428696-1-trini@konsulko.com>
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

All instances of U_BOOT_DRIVER must be unique or we will have link time
failures. It is possible to enable both ufs-renesas-rcar.c and
ufs-renesas-rcar-gen5.c at the same time, so give
ufs-renesas-rcar-gen5.c a new unique U_BOOT_DRIVER name.

Fixes: 3351fe7ecc1a ("ufs: Add UFS driver for Renesas R-Car X5H")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs-renesas-rcar-gen5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
index 3c66022579fc..cc53e91449c3 100644
--- a/drivers/ufs/ufs-renesas-rcar-gen5.c
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -258,7 +258,7 @@ static const struct udevice_id ufs_renesas_pltfm_ids[] = {
 	{ /* sentinel */ }
 };
 
-U_BOOT_DRIVER(ufs_renesas) = {
+U_BOOT_DRIVER(ufs_renesas_gen5) = {
 	.name		= "ufs-renesas-gen5",
 	.id		= UCLASS_UFS,
 	.of_match	= ufs_renesas_pltfm_ids,
-- 
2.43.0

