Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8828CD6E43
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7FA86C91;
	Wed, 11 Oct 2023 10:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KbkoEhxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C2486C66; Wed, 11 Oct 2023 10:48:28 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194B986C71
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-690b7cb71aeso601377b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014099; x=1697618899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWrPqD+Hg/9Y+6ClL0j/pz2UA00yPY4cN+Rh/IvElu8=;
 b=KbkoEhxlusjkUR5/9pRegu7RwKYpeM8uak6FM8avTtwFf0j4hyvbYlYrU3okIjsckL
 k87s2BYfNATh0M510li9urU9xHxhAXmUr9NOxcH6U3R90Y/CRs/ukSSUGCfJSVCcOF/1
 c4uhOOC2ZbaZpSs9PdRWgMHAURDbwUw3HwrG7UiMWV+XNZqBkKrtjBt1QXyh/XUTAt9X
 +Hwe+x23siPlIrQRbtNJSAQFgypC+T4ipK1IWGLnwgmMBORQbIIujTXN59Mkw/j9CmfY
 fK4w6U4UPoOF0WKtqxDPKvbOiwf7ncdZWE/q/x8tvIgAPF+HvwVH/ujMuxiXS2vVX4lB
 ibCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014099; x=1697618899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWrPqD+Hg/9Y+6ClL0j/pz2UA00yPY4cN+Rh/IvElu8=;
 b=RSWS1Xqfw3r23E++IIW7SZBsLzqHLgPbEHOscNTO9AkTT7qn9wQdVtnbR0Y4KJ4ciz
 tTD8eO7UPEzj5WNA25ad9GxWzQPnsxYEtZfYDoQ/RfOH+qMYlLfgL9v/0hRoS72PPq+d
 Vt42I8e5fYhBvl4Du+XIyL1tvlYN0EaXlMG7PwN1TeWvcpT+pBuineKXC1o2JneVdB75
 hEW05EkSzXsMl1O2oo+Q9m6sL4SHuG2xZexUqrULxwK2BC0gnP9oWaeAQMto4kOqmcoP
 N2YkWo3eZ33NexMuIJFkZCVYLZkmdoSuVTiuF1E9G2vI6+nxhx/F7v1dRSwt9n5wI7sY
 8QAA==
X-Gm-Message-State: AOJu0YxLchb87LUbrQ8f+YWm4vzuHbptdshPdnfm1oW/mY75oORlMIwt
 WT8K3xFSPx1cG479sljyHWvkFeKhpDheSw==
X-Google-Smtp-Source: AGHT+IGWtcaF/QVyYhyL4Tpzf4+8V1tWBK+nVJ2uLvUD2zFzsNWm/1GpOuMdyEvTiBmcNIxdaQ2jUA==
X-Received: by 2002:a05:6a20:4282:b0:15d:b407:b0a0 with SMTP id
 o2-20020a056a20428200b0015db407b0a0mr29280842pzj.26.1697014099655; 
 Wed, 11 Oct 2023 01:48:19 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:19 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/5] configs: npcm: support more uart baud rate
Date: Wed, 11 Oct 2023 16:45:30 +0800
Message-Id: <20231011084533.2325296-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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

add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 include/configs/arbel.h | 5 ++++-
 include/configs/poleg.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 891257bc93..c45b2ac137 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -7,10 +7,13 @@
 #define __CONFIG_ARBEL_H
 
 #define CFG_SYS_SDRAM_BASE		0x0
-#define CFG_SYS_BOOTMAPSZ		(30 << 20)
+#define CFG_SYS_BOOTMAPSZ		(128 << 20)
 #define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
+#define CONFIG_SYS_BAUDRATE_TABLE	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, \
+					  380400, 460800, 921600 }
+
 
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
diff --git a/include/configs/poleg.h b/include/configs/poleg.h
index 1e96e838be..fd0e9a7362 100644
--- a/include/configs/poleg.h
+++ b/include/configs/poleg.h
@@ -13,6 +13,8 @@
 #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
 #define CFG_SYS_SDRAM_BASE           0x0
 
+#define CONFIG_SYS_BAUDRATE_TABLE	{ 57600, 115200, 230400, 460800 }
+
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80200000\0"   \
 		"stdin=serial\0"   \
-- 
2.34.1

