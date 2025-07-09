Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D88C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 11:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C65C83443;
	Wed,  9 Jul 2025 13:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B8Xf01Qa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB478343B; Wed,  9 Jul 2025 13:49:13 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119EA83447
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 13:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45310223677so34031225e9.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752061750; x=1752666550; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0PAW0Pl9MVJAW51EomZ3nJ2ePJoNaS70qkNElDNH2Ek=;
 b=B8Xf01QaqVcF133lVGGj5T62OQcUFHw6S7wEfF8DoyfeQPjUYHaepbmhB7+eJ7xFzb
 wN1QFiosGc8vdNH7DNAy8byo3TAxB2QcfhC+w/m12zwxtGQ3sd8QSqJjxFjxynFxQi9i
 Zb5zmhI8UV675ntgxx+AXgXB3tEy1Zraqkzdaa87ImSwrIQ2mJy75hNbUlAESX3X1Pxt
 E16n8V2iv2cuyQED9GaAVXNktLxae3veDFWxrq+PC5DkAhCxTI8E0mbwH9fRKaqzvGD9
 2YtQLMzU1wswZ9N8in7X5oqlFqK5SvtwzYzuTGC8wkqCKt62ln9WOQxCSXaknXGhv3RD
 29Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752061750; x=1752666550;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0PAW0Pl9MVJAW51EomZ3nJ2ePJoNaS70qkNElDNH2Ek=;
 b=OkwZ1YCLNlBtA5JBufhQYBncOVNHiDKtiJh239qyhovoQNe9drzeF0X3xvM9vsrrCC
 IL9bVV13UB/pypF6DyAA2sK5vrdP9cjbTHyTMSjfodk/dz+iWNrc7Z5bCd29zeuSOtjg
 S7oNtlJYVGWEwI9Z8+giTr305TLTMD12gQ0RuHCs8Dtkdom0OVXgal4ABUtC3ReRwD2s
 9JHLzLKN4n4gmKhfo4G20KFD2q66sxGEWNFdswcP34hg6LFzy6gC6Vdv3+onS/nILRmk
 kgpN3auIG01iJ+TYogCG288nFK1HcPMXosnlVy4YY6aodLxfmZzCLXJ0h4Jn+oRdvfq9
 Z8PQ==
X-Gm-Message-State: AOJu0YxKnwhyoBTFe4oks0TIxZHAtmW27qRgpfpm99aRvuUEF4ySgF9K
 3p/133OLycnRbLCe/5CVcKP9zWCuXMx0AXRAs0b6gnONQtWdNj7UNscLMTnIi1y4aNCaxS29PUN
 n22Ap
X-Gm-Gg: ASbGncuzVkvmPg/au8ck+0zFqxrvtm69xm6eL6IWNmzcSN6VWc7rtHFPYczDoExTBQX
 SGQHQZ20oJTgtznmGRqp3+6wuyZjfyTIYmHOf4mIiVXqWSqyKUAHBmBg0ZNjTkyOxcvV2rg35P5
 JcmNzJiMiNAxE2uzyj6nf9CIdqeNxJGJUYCvw16knKS0G+F9HQ/DE8n79PalePNbDyyboNIIbc7
 l7T9RjtI2CVXjAtQwTs6AKJz9DSR9KoC/3ZWxusDKnwFGTLb5yV55f9gGCMiD98UoB/C+ZQ1xEH
 hQMDXUDOM60ggdAKT9oJbn2Ximt8wV+izronzfPqaDuwUdm5JZRQp5Ynrg5E9xiY3fskFR6DSxh
 +pmJzIYc3MoMo8g==
X-Google-Smtp-Source: AGHT+IEC4wcq22WBhciv7gST9e9PiDhullDhtYqPlR3x/+ve/22v+LjTxyI3sILa4Vs2CoUIY08rHA==
X-Received: by 2002:a05:600c:314c:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-454d5311363mr20637715e9.2.1752061750417; 
 Wed, 09 Jul 2025 04:49:10 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:7978:74ac:133f:8950])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96726sm15847034f8f.58.2025.07.09.04.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 04:49:09 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 09 Jul 2025 12:49:09 +0100
Subject: [PATCH v2] boot: Ensure method_flags is initialised before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-bootflow_fix-v2-1-bd803a226f4c@linaro.org>
X-B4-Tracking: v=1; b=H4sIADRXbmgC/3WNTQ6CMBBGr0K6tmY6RgyuvIchpi0DNMGOmTaoI
 dzdwt7l+37yFpVIAiV1rRYlNIcUOBbAQ6X8aONAOnSFFQKeocaLdsy5n/j96MNHOwCwHaDxHlW
 5OJtIO7HRj9vpaVMm2YqXUNnvnntbeAwps3x37Wy29I9hNtro3sCpcdjU2NW3KUQrfGQZVLuu6
 w87W/mBwgAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The local variable method_flags is only assigned to in some of the
code paths leaving it possibly uninitialised at first use.
Initialise method_flags at declaration to ensure that it cannot be
used uninitialised. Also remove now redundant assignments.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- When scanning a UCLASS set method_flags appropriately. This was
  only happening accidentaly when method_flags was not initialised.
- Link to v1: https://lore.kernel.org/r/20250627-bootflow_fix-v1-1-f1039b2962d6@linaro.org
---
 boot/bootflow.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 4054a966af8..d79f303486d 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -245,7 +245,7 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
 		ret = -ENOENT;
 	} else {
-		int method_flags;
+		int method_flags = 0;
 
 		ret = 0;
 		dev = iter->dev;
@@ -264,7 +264,6 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
 			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
 			log_debug("next in single\n");
-			method_flags = 0;
 			do {
 				/*
 				 * Move to the next bootdev child of this media
@@ -296,6 +295,7 @@ static int iter_incr(struct bootflow_iter *iter)
 					log_debug("looking for next device %s: %s\n",
 						  iter->dev->name,
 						  dev ? dev->name : "<none>");
+					method_flags = BOOTFLOW_METHF_SINGLE_UCLASS;
 				} else {
 					dev = NULL;
 				}
@@ -306,7 +306,6 @@ static int iter_incr(struct bootflow_iter *iter)
 				}
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
-				method_flags = 0;
 			}
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,

---
base-commit: 359e3012921f2fc2d43f3c4e320a752173f82b82
change-id: 20250627-bootflow_fix-b000ad021cc2

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

