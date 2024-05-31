Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C72C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9152488827;
	Fri, 31 May 2024 16:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y4N8bMyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC5D88826; Fri, 31 May 2024 16:19:58 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB82887B9
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2bfff08fc29so1677084a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165194; x=1717769994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gben/dVluhF95hZs4N8FI8oY0T+ecGR5Ot5Qeue04ig=;
 b=Y4N8bMyj7nJx2SAuC96VxTFlYmxkJl5RhUZeJ8hI2lo3RvJbcJS0SpHPnugOLJvHIz
 xdfPO1trHgvf9bUERhIkDadf2enBuWchtV+IzSmG1/x9ug9RQabJ2qfze4LcgmGJ379m
 Q6W4ZZhO3MHHOVkiTNOaXANsUgyOdndKsOUwIH1dekPMmO07JBJgR1l384L/sQxsc5GN
 Ixj1wadahD7Eg6ygcKqs1JLiVOxwedkKF2sns/u7erYmJ94TuDWn9blutdijuAK+XLqH
 BFqDJY/DC680g5Sgx/3McA5i2LVyRblzSKH0M1lCwE7QqaK+p760F31EADLvxBqGFl/w
 gukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165194; x=1717769994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gben/dVluhF95hZs4N8FI8oY0T+ecGR5Ot5Qeue04ig=;
 b=TezwDqe/ppK66SN0YPrt+iaaJDMyM3uBDfW9X+iY1/WIrLBcCR23R1elPgcdSJO658
 0iVJsmVY1HpeLXB+aY1xlg9fXWi+VkjsPD/2xgccOJAPbS1ju2krD8ApHa1U69Ppx8+1
 r+AYsJAIEXRyoW/AfX6bpJF0I3U3spb3qAQadXJmKEXH+GV3dT9SXYUgytYwBOWKHSWB
 mqiwJM5/K/iRuhCK5NRGd7GUSy9uT2OV8qS5wC4DGNihOVnzdF7PAV+WCZ/NCbfXQJ9n
 AYvB6pHNWnaeNWPWMS0zzF5Z6XMqsOW486wOp79O8zL3PLRMFtmniw890mZ7q5ZGBDVs
 RuXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSQ/9p907VTU9h4blUJ4Yhv9zdl4lLQTrxgvsFEJA+8rLVDN7Y0yZMAi62bchWqXrHpEw30BUh6c/12e3McwyRP7g1hQ==
X-Gm-Message-State: AOJu0Yy3yoQT7ngLXvoVNVC8nLT5hDjl13EiV+aDlfeOo2g0WHA6Etjk
 y82dIJZFNpbE3Quyoi2/evmDePE2kTbX8vfyaaIy73fq+cXimYzU
X-Google-Smtp-Source: AGHT+IFnMGsqwIUr/56BxjnQFH/okCtelPCRoPb6CS5+7m+A+/lxy+Md3UXNYCkJbYSBUaXzwK6PJQ==
X-Received: by 2002:a17:90b:1051:b0:2bf:d6da:ce62 with SMTP id
 98e67ed59e1d1-2c1dc5cd585mr1732497a91.43.1717165194330; 
 Fri, 31 May 2024 07:19:54 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:53 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 19/23] rockchip: RV1108: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:33 +0530
Message-ID: <20240531141837.13189-20-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Enable DISPLAY_CPUINFO options to support on all RV1108 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/elgin-rv1108_defconfig | 1 -
 configs/evb-rv1108_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/elgin-rv1108_defconfig b/configs/elgin-rv1108_defconfig
index 454ed9e0a6..1fffa99793 100644
--- a/configs/elgin-rv1108_defconfig
+++ b/configs/elgin-rv1108_defconfig
@@ -17,7 +17,6 @@ CONFIG_SYS_LOAD_ADDR=0x62000000
 CONFIG_DEBUG_UART=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_DEFAULT_FDT_FILE="rv1108-elgin-r1.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
index 6204cb4b96..8bff3a99e5 100644
--- a/configs/evb-rv1108_defconfig
+++ b/configs/evb-rv1108_defconfig
@@ -14,7 +14,6 @@ CONFIG_SYS_LOAD_ADDR=0x62000000
 CONFIG_DEBUG_UART=y
 CONFIG_BOOTCOMMAND="sf probe;sf read 0x62000000 0x140800 0x500000;dcache off;go 0x62000000"
 CONFIG_DEFAULT_FDT_FILE="rv1108-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_CMD_USB=y
-- 
2.44.0

