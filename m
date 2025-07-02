Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6FEC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8648300B;
	Wed,  2 Jul 2025 03:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hzKeKRkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4EE8303E; Wed,  2 Jul 2025 03:04:34 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023AB82103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4067106dd56so2337418b6e.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418271; x=1752023071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lH2YZGj7p33x1Rm8EJsGZSkv8A2GdTh2brNi2daim7Q=;
 b=hzKeKRkg5NvlDxIaeXFJ47+xRE9AlbWbl7dz86kgyo5y+DlaMDdVZG+m0rVij71SwC
 Y8IPULP4+F1jfC1GS3RP/xh/Z4S41ZCn6EYbyjO0QAPoLUaMYQEyWuEBDRSAOg6v1jmM
 xmVRGCld0v44E+mqL4cbgckwoaa6KeAQeOcio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418271; x=1752023071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lH2YZGj7p33x1Rm8EJsGZSkv8A2GdTh2brNi2daim7Q=;
 b=VHiH0rX0p+FO45J8RtRQf/6xIBf/9X55CDHLL77dIJk87T1QO/SAFaEIpsqvNliPLq
 hAdctN3QR5QdNIxLvBFjubGvK+yl7xuhWoc6RYUCgHbNfkBYy92H+iRThMvCym4vbyHB
 PHR6gt+1eDwGr6Rnsr7D0NJikAGdsvYnWi2ANDIO9ulvR3grqbsMTKm7Um1WegjM+AHl
 FYwXRC6HyTBu5yW7RJvpxasCUAqzujlXpCt0K2bZ3ObyPFVAuO1act/3ABP6CI2YW1jc
 g1PyGJhBfHQCHF2edbBz+2z00qNAXoYnEsWu7xCEqGHnwmFhYEx9o80xhj+WKxlrpHU2
 HnHg==
X-Gm-Message-State: AOJu0Ywvj3srP4rc+RnjBs/H7DFLSRj+lMmN6U1c6x73CceQfRKAdVk+
 OAS8HQXMVOGxvexEbwrVUXuTUplYw5ntyMckaHCqBWnW7LF/6CySlwVw9/oZyNJTn/aghl5nwNH
 RZKPRwu8=
X-Gm-Gg: ASbGncv2SYl0gjeKD3iOdfobxQgX0ZRdGouNdsiqrsPEZXrCVKKOBlr3hwga+JUW8tv
 RjOIoB1Uf18QKkul7IJI7z0Z/NfY1IgWrdVIyfe/Lsg3qpBUGlXe/X75xGgHX56YicZgcicFgzN
 LF5z1czB036AkyhSHF0hrvuJLk9BGrkRR9Nt1laqZst6PXWUKJGKZvIffEv+okweTSX4ysAKguJ
 pTk0cXqMtQO0dqZk/LCw/0/+N5DE5uqRVhkPACWDxpT7QpzqEB/oUxfx9H5if2B8MItdJn2KB7N
 e0kAJj9JF2LqBUh7rVH9q49qLsW9QTl5YSnPaWE7jJxTJOJhcc27377zwZt9xxVG3BuTx62hLgk
 3RVx55D8/T508zu7DokshfRM=
X-Google-Smtp-Source: AGHT+IGwABZUD0CcLHzlFy0EPn3TzqLj1UAeE4P05zDRX9fe4tSh6d9aMgoL6ailSk+bL70tkPhn1w==
X-Received: by 2002:a05:6808:3097:b0:405:6b13:ca55 with SMTP id
 5614622812f47-40b8952131bmr586104b6e.37.1751418270593; 
 Tue, 01 Jul 2025 18:04:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420a76sm2375225b6e.38.2025.07.01.18.04.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] ata: Correct two dependency issues
Date: Tue,  1 Jul 2025 19:04:29 -0600
Message-ID: <20250702010429.18958-1-trini@konsulko.com>
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

First, the SATA_MV driver can only build on kirkwood or mvebu platforms
due to header requirements, so add that as a dependency here. Second,
SYS_SATA_MAX_DEVICE is also used by the API code so allow it to be
configured in that case.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/ata/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 29ceab849c02..da9c72a99d03 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -131,6 +131,7 @@ config FSL_SATA_V2
 
 config SATA_MV
 	bool "Enable Marvell SATA controller driver support"
+	depends on ARCH_KIRKWOOD || ARCH_MVEBU
 	select AHCI
 	select LIBATA
 	help
@@ -148,7 +149,7 @@ config SATA_SIL
 
 config SYS_SATA_MAX_DEVICE
 	int "Maximum number of SATA devices"
-	depends on !AHCI || FSL_SATA || SATA_MV
+	depends on !AHCI || FSL_SATA || SATA_MV || API
 	help
 	  Sets the maximum number of SATA devices which can be supported
 	  by U-Boot.
-- 
2.43.0

