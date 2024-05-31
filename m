Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036CEC25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661778882E;
	Fri, 31 May 2024 16:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y8ISy1aT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943B5885AF; Fri, 31 May 2024 16:20:06 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD2588832
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c195eb9af3so1571413a91.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165202; x=1717770002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1ndpMra5w0OjZuye9XJHHOzVCYI2ZZ8lp5dAkRFCrU=;
 b=Y8ISy1aTzUvaAYmrYoI1a71wYNyzyBDomKuNrM0+pLL9qnhdVFtZoAYlPnSOh51pPQ
 c5m1h/aaosmVl7OSDiiOQFZcMmiiPxbn2jtkFK8KUb7TaqLJWUm4qPLhun8EPrhaib6M
 4lczY+tvo8DZeHMTafWu5unFoHum6wFSj/J1zJlu+0VaC/4IPkI1sFIkbrTEaig962CX
 YLbPcGunBmVTgsDWVCuiOjdyEw1VG561DlCb0Z8hnTsBF7u4IF+p4Kdt25R61hpXJCyk
 qJBnux3PK2kc91qSsq2wQSFEUz8Iv57qrBusVdZDst+z5r1ZysFD/ZNHwDlttBwP9lth
 XRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165202; x=1717770002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1ndpMra5w0OjZuye9XJHHOzVCYI2ZZ8lp5dAkRFCrU=;
 b=XpueVu5BALiMzyqCodkC+9077aoc4sZgxCPMOmC6jhBVd2F63rh/9pQSPTXTC1UTLW
 zp43bMifzPWTWPOP9SHyLN2T6/YZDYOmz6ZdVDJYaGZKEIWJGViwUUCgajFP2Oh/+7nf
 Obsc4i4qUbbppt87FTV5APtUSPygeUx54cqTL06O9o8fbJHcz1Hfmf72FSxiBJ0pfPsZ
 aAywKAcnzCn3O4HDV4upCNhZO3C7XVbiIGlvtOUrCACOJ6PdYLNeMWe/SKg5lZAJFstV
 4sq4HUpKX/NQ0qFe7oSAFUO7BKT0dQe5rzGmYOh1IbuF5QXaS8/SaHxIOEH2xaIBHKnj
 5Diw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOzVvUCdaxmu7BoQ0VA+VyePNQAoqceeXd5VDzAmJy6ea5mwYnsuCzfhGrZSTG9iLRCrudwNVq2n0Xx5n2nZY81Yuwmw==
X-Gm-Message-State: AOJu0Ywy5GHLTWBJlqq5NEs0kcMWzw8UTxGR8TkWe0vwzgESf660NLXR
 EqVPCEs7zF9+9q40U3SO8vc0pnHFTVCbCWOz6JgOQxWLz9fgnaTlxXzKs9qS
X-Google-Smtp-Source: AGHT+IEffOHF4yR4Q70TizGOqnifJmUlU3F2qhlYyLlwaMsjZ4QK/L2uVxGLijx4oEK7m9XsUzVMTg==
X-Received: by 2002:a17:90a:e00a:b0:2bd:fa57:b35c with SMTP id
 98e67ed59e1d1-2c1dc590a25mr1816272a91.28.1717165201898; 
 Fri, 31 May 2024 07:20:01 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:20:01 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 21/23] rockchip: RV1126: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:35 +0530
Message-ID: <20240531141837.13189-22-linux.amoon@gmail.com>
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

Enable DISPLAY_CPUINFO options to support on all RV1126 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/neu2-io-rv1126_defconfig      | 1 -
 configs/sonoff-ihost-rv1126_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index 2a4c9b45a0..0bca5dfffb 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -16,7 +16,6 @@ CONFIG_DEBUG_UART=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_DEFAULT_FDT_FILE="rv1126-edgeble-neu2-io.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index 4890644c7e..aa77ff3be4 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -17,7 +17,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_DEFAULT_FDT_FILE="rv1126-sonoff-ihost.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
-- 
2.44.0

