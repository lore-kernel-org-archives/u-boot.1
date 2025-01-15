Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44F7C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB358073F;
	Wed, 15 Jan 2025 02:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GmvbN3jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA74806D4; Wed, 15 Jan 2025 02:23:41 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90C680761
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dcf63155b0so28107646d6.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736904217; x=1737509017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jRA12D15okh0TJIP9l2WSBsuKMAfqiIvN5isH6TVcs=;
 b=GmvbN3jJykuCRr5XgzOG9NrMkvx+XiOdEy098jVsUjFEgQBxlSOtPLR9qEwcgR2KKN
 8ZZ98kvlCHgqV1LqijggW7xqUogR6QQmQVNgSF2mkKbLIR5LufXMZxcagYJQMI2x9Qu6
 LUJODk8HBZsSRsg3oGi3nzS9ChytUbj+VgXPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736904217; x=1737509017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jRA12D15okh0TJIP9l2WSBsuKMAfqiIvN5isH6TVcs=;
 b=pIVVmd+LvWMUOAT70lD/AxchZdsCvoQr6Oos/fDnyicHyFiZHNNzLagkDSvO1Jvdh2
 zWFfFfk/+QjZcklg9YaEdacHqIDIo0snnhFKU7RVHp4SxatXEdFcHpZ044CrWdKBWu5g
 mnz3vnYunyw1uICxhhYlzSOqEW9cyzKAeHIpnwANKk/1y5a2rAzfk3YXvFO0xFTXKU5b
 J+5+ZSQ4CpSUwiMZCbfE9USUzUg1GXZDG2xMufgVyF/QJmfFPO6O2cL4CSgOw9Po0//T
 1n9KOhf5eF7gXv+8ArMT4VVAtPMjczIKeagJlCMIgz/ei/uxZblgl77oyre6powV/VTf
 obyw==
X-Gm-Message-State: AOJu0Yxxwo+K3QT2sjMHLwnZaSglmkVD6YgmMLHjn0rlRQAFaP30kMAS
 TB/9GxW+rzKT3+CatlOUTd1wsMBobuIScAQvssKYxshM0aMXNJloY5RiKZd9UsxKm1x340VQwKT
 c
X-Gm-Gg: ASbGncs5M38u2Cd6IXJljH58LGF07nOw1wJrch1GxxdUzmnlhygW1egJQF38MzSpabW
 MrDKC9gK0t7FICC9aAwXhcpejXlnKXaZRYyj/Y9EXtT3or1gJS0RuLm+eOY7JaPc9TyYxjNvosE
 ejRU3xmiwSzJL82+vs409oWjrqBaEKUURXMJ+EsobkODyWF4U1hoSI/XKgXsIGWz7GKBzNmwp6B
 Xv5ZQ73oRIaZfdTxURrlwtqQ2RmS/fpcVIyR6rlGuGQDJkN2IRGyxlxHMHfRyDp2kKff7ynQl7I
X-Google-Smtp-Source: AGHT+IFSYvPGTIIYx3OMNTUj02hyMSj9Y+3hOdq1SO5MbICbciWuAsk7sU/rI7Zdol1CWodbvB0peA==
X-Received: by 2002:a05:6214:e6a:b0:6d4:3b7a:313a with SMTP id
 6a1803df08f44-6df9b2d36c0mr396277636d6.32.1736904217720; 
 Tue, 14 Jan 2025 17:23:37 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm59817096d6.50.2025.01.14.17.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:23:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCHv2 5/6] mtd: Correct dependency of BLK
Date: Tue, 14 Jan 2025 19:22:12 -0600
Message-ID: <20250115012322.215243-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115012322.215243-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
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

In the case of MTD_BLOCK and UBI_BLOCK they should be select'ing BLK as
they provide block device functionality and not depending on some other
block device already being enabled too (as is the typical case).

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- None.
---
 drivers/mtd/Kconfig     | 2 +-
 drivers/mtd/ubi/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index c71c1e5547cc..185e83462135 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -34,7 +34,7 @@ config MTD_CONCAT
 
 config MTD_BLOCK
 	bool "Enable block device access to MTD devices"
-	depends on BLK
+	select BLK
 	help
 	  Enable support for block device access to MTD devices
 	  using blk_ops abstraction.
diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
index c027d898a640..ba77c0347365 100644
--- a/drivers/mtd/ubi/Kconfig
+++ b/drivers/mtd/ubi/Kconfig
@@ -116,7 +116,7 @@ config MTD_UBI_FM_DEBUG
 
 config UBI_BLOCK
 	bool "Enable UBI block device support"
-	depends on BLK
+	select BLK
 	help
 	  Enable UBI block device support using blk_ops abstraction.
 
-- 
2.43.0

