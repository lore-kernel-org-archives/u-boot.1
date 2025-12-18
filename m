Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F01D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806C483642;
	Fri, 19 Dec 2025 00:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e9rkJIZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9888367F; Fri, 19 Dec 2025 00:23:04 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C46800AB
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44fe6771b2dso324006b6e.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100180; x=1766704980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKAxKj5LoBPRCCu2ngsT/CSQv4EloClSMlWNBL52PnA=;
 b=e9rkJIZEZKVeu+ppGj1ONivR2wvMkwNWvs5XnRYp+UaQvNs/fEp+UxZcucJ0LAlzjq
 E9Wm90s3BHf5CfUR3nSgf8dEaHHxtB62TMYe50IFhv8ijBA/CPpcEO2m7wNBcfbRurFN
 xBUAWQ5MbQeatfwQfZU88oxN8iwXsCsZN93nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100180; x=1766704980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iKAxKj5LoBPRCCu2ngsT/CSQv4EloClSMlWNBL52PnA=;
 b=b+yXhuXjzoFRvdBYzmO8rURUEdOb+eeXgqqwWGGiUg2xItjvj37v34/fnr56HGOUYY
 W7F3u92oPHppmZ2pGNFnB8UoV6ZD1KMPcKp9EVm1/uM1cxzGG5HaCRYS7ssnYuQeixxq
 2LRxI81h3fgcihlkrU4EtlRW5QGWFd1RBejm9gX8Yi2XlzKyRId3i+yBtGljr4nig+bD
 2D0gELBEl+s7tV6q06U3KpUrpr6TkUxHrc3I9gRDE10tw58pQetl49w07Oh3+djymdr2
 gPvS704RsMUW+N9ym5Ht0odLy4CKZIzq4zGN7MD48C+l1GoFKxhQWyue2gBDOEXYnyX7
 eCIw==
X-Gm-Message-State: AOJu0YzMuDzi0HqDHzomWfPYhsNiZxVb6wij73UuRKo0cWX4ncAHYcml
 Uxqieuus8Aiy+NQV3U3il8yyNWlW6jiaQs6fzT0XQKfcHtzlLmm9gEYIgCRf9oQjcePbtS88Zsq
 hQWQLN0I=
X-Gm-Gg: AY/fxX73hD65Sjqy3rsR2A01ckxM+vJFyDFyAtG97qx4OfffpIUOrLQSupuOLUsS9eS
 tUE94h+PYeLbZJP6wNjacDdRJEmVCyhHJCY4QgquFnDhJvXL0HuhtNVaYtbzvtxelgIpSpyU7sd
 pwNo9nCMRVyzfxpiUCfQP9B58taG9rr409VKCjZXSZ3C/+8hKMquOc0KI2peqqUIQx/++bCNkN1
 lBG7eX+f1zT7OSYyyajxa0YnqE3ZQ5F1e5pVx1CWpaclbPX0BLiEfkorPjhA3bY1i10Lo2DtWHu
 2AFASDH0g7QyHpGRrYr2pjBpkCAe3AK1DXy/u39v4V/Ec57ldnsynKTrD1Dc9TsxGR+4JWo57iL
 a4OLaIsmQcLzlsWxtEEWVwI5hkNShZ++BChlq+ssErCAP45vUkO2gvzcMv8m/cPs+2nZ2cReMwv
 EOBNb3zHVdOApwfWPM62JiMxOlpUCuwEJQnWLJKIm3ZblswFu1OoKv
X-Google-Smtp-Source: AGHT+IHSW4zeUdhL35+EWHkAWWv1q/LoHuV0lCi1lv4j6i0c2Uugv/xhA/QK8RwjtX303i/gLrrSAA==
X-Received: by 2002:a05:6808:4f5f:b0:450:1d1a:5d9c with SMTP id
 5614622812f47-457b2185330mr603539b6e.33.1766100179884; 
 Thu, 18 Dec 2025 15:22:59 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:22:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>,
	Stefan Roese <stefan.roese@mailbox.org>
Subject: [RFC PATCH 1/9] lzma: Add Kconfig options to optimize for size
Date: Thu, 18 Dec 2025 17:10:13 -0600
Message-ID: <20251218232255.3934258-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
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

Currently, our LZMA library has an option for optimizing for size,
rather than speed. It is a minimal savings today, and has not been worth
enabling. As this will change in the near future, add options now to
allow disabling it in full U-Boot or in SPL, and enable these on
gardena-smart-gateway-mt7688 which is very close to the size limit
today.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 configs/gardena-smart-gateway-mt7688_defconfig |  2 ++
 lib/Kconfig                                    | 14 ++++++++++++++
 lib/lzma/Makefile                              |  1 +
 3 files changed, 17 insertions(+)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 3c2bcc6a3c44..aba8a2ffd1de 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -101,4 +101,6 @@ CONFIG_MT7621_SPI=y
 CONFIG_WDT=y
 CONFIG_WDT_MT7621=y
 CONFIG_LZMA=y
+CONFIG_LZMA_SIZE_OPTIMIZATION=y
 CONFIG_SPL_LZMA=y
+CONFIG_SPL_LZMA_SIZE_OPTIMIZATION=y
diff --git a/lib/Kconfig b/lib/Kconfig
index fe0b878a206b..96032eaddf95 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -838,6 +838,13 @@ config LZMA
 	  ratio and fairly fast decompression speed. See also
 	  CONFIG_CMD_LZMADEC which provides a decode command.
 
+config LZMA_SIZE_OPTIMIZATION
+	bool "Optimize the LZMA algorithm for smaller binary size"
+	help
+	  This enables building the LZMA library optimized for size, rather
+	  than performance. This can be a loss of 15-20% in decompression
+	  speed, but a savings of close to two kilobytes in many cases.
+
 config LZO
 	bool "Enable LZO decompression support"
 	help
@@ -932,6 +939,13 @@ config SPL_LZMA
 	help
 	  This enables support for LZMA compression algorithm for SPL boot.
 
+config SPL_LZMA_SIZE_OPTIMIZATION
+	bool "Optimize the LZMA algorithm for smaller binary size in SPL"
+	help
+	  This enables building the LZMA library optimized for size, rather
+	  than performance. This can be a loss of 15-20% in decompression
+	  speed, but a savings of close to two kilobytes in many cases.
+
 config TPL_LZMA
 	bool "Enable LZMA decompression support for TPL build"
 	depends on TPL
diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
index c2fd3e494541..b8ad570ab1c2 100644
--- a/lib/lzma/Makefile
+++ b/lib/lzma/Makefile
@@ -7,5 +7,6 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 ccflags-y += -D_LZMA_PROB32
+ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -D_LZMA_SIZE_OPT
 
 obj-y += LzmaDec.o LzmaTools.o
-- 
2.43.0

