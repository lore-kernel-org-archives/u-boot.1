Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410DC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 06:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE8C88477;
	Mon, 10 Jun 2024 08:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QcH8EmL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195FF88470; Mon, 10 Jun 2024 08:38:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05AC58826E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f253a06caso25515566b.1
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718001526; x=1718606326;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YkXX4a+CuneOZrLJ6bLzVntjWw3QI6StBqVFpA22XHE=;
 b=QcH8EmL57Z3HjAGxYBgIX44M/QnzLe+uuyge+0LqP5Ax59cGHrIIjrR1WHt1AItJ4T
 2kHOPbzDbveTQWWIqACdqTKqsusXbGAwj2z2W08IKK1rr35wB7uqconPAxL8b7CJ2mqM
 YUJumVfwSKZ2I8GwoQj79vqOCDyCDh1kjYLhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001526; x=1718606326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkXX4a+CuneOZrLJ6bLzVntjWw3QI6StBqVFpA22XHE=;
 b=It15NqoAdGQWjxSwItjN0Ojh8qQQis30U4/VEsv6fOhCStVU57KMLc5BbbjK0ETmJY
 7fOc/6iONUXHwz/qMAyzbGGUqPx0axyeSNE1fIbB7V3+g1r6rVZrierWBCTewf91YFVV
 d/HWH0kZfqCr640KWoUqHRJd0ee8uMgqso18VpCCuU9gocWRecsEQyfkx3lYr8Zje7o4
 TtpokUZQ/3MCkW1NJz1CuXl5XHl1BXslvbNzIy3kNeZbOiZo4yYxFD3ZG/UQ45moEY55
 qAnKlE6c4uM2qeixV/ExhY26iKnt3OvcxpKkLhIl5/RGL2ADG2R4DBlP8fNqvjCQkrtp
 2mGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYFAHcp+CQdFUlxkY7RUjfCyJ/MrtzUNsC3Ki1UqOC+WfhWlqfAeYFg+Z7X3T2CcI3erkODO0jot9quq3d693PmEvpMg==
X-Gm-Message-State: AOJu0Yz7Fez8edwvq+1oaC8qKIhUzPxXVxf3jJ5NU9fhLq0f5JE4Rs/A
 DUwsESLUY2g6+5WAGva7RhV5DaKprsTXrQV27WlVd2vzijj1oDgY29y/zGYNwfo=
X-Google-Smtp-Source: AGHT+IEhJ4JUtFS+ZVoxz6++VDoQ+PCSho+l5Rh67VaCkbPyj3SQ+QhXyjJ/0URj2NbyAi6N6xcCGQ==
X-Received: by 2002:a17:906:b4a:b0:a6f:2994:e0e9 with SMTP id
 a640c23a62f3a-a6f2994e273mr38272966b.33.1718001526324; 
 Sun, 09 Jun 2024 23:38:46 -0700 (PDT)
Received: from panicking.amarulasolutions.com ([109.52.5.62])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1b3b2d7esm146070566b.24.2024.06.09.23.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 23:38:45 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: festevam@gmail.com, linux-amarula@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, patrick.barsanti@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] board: imx8mn_s2: Update timing with production one
Date: Mon, 10 Jun 2024 08:38:42 +0200
Message-ID: <20240610063842.192786-1-michael@amarulasolutions.com>
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

The timing upstream was wrong corresponding to the production.
This come evident after commit b614ddb5d33
(ddr: imx: Save the FW loading if it hasn't changed). This
change fix booting from usb

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c | 23 ++++++++++++---------
 board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c | 14 +++++++------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c b/board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c
index 0da641834d..33452d2ad5 100644
--- a/board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c
+++ b/board/bsh/imx8mn_smm_s2/ddr3l_timing_256m.c
@@ -18,15 +18,15 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x20 },
 	{ 0x3d400000, 0xa1040001 },
-	{ 0x3d400064, 0x610040 },
+	{ 0x3d400064, 0x300040 },
 	{ 0x3d4000d0, 0xc00200c5 },
 	{ 0x3d4000d4, 0x1000b },
 	{ 0x3d4000dc, 0x1d700004 },
-	{ 0x3d4000e0, 0x180000 },
+	{ 0x3d4000e0, 0x580000 },
 	{ 0x3d4000e4, 0x90000 },
-	{ 0x3d4000f0, 0x0 },
+	{ 0x3d4000f0, 0x2 },
 	{ 0x3d4000f4, 0xee5 },
-	{ 0x3d400100, 0xc101b0e },
+	{ 0x3d400100, 0xc100d0e },
 	{ 0x3d400104, 0x30314 },
 	{ 0x3d400108, 0x4060509 },
 	{ 0x3d40010c, 0x2006 },
@@ -67,10 +67,10 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{ 0x3d400498, 0x7ff },
 	{ 0x3d40049c, 0xe00 },
 	{ 0x3d4004a0, 0x7ff },
-	{ 0x3d402064, 0x28001b },
+	{ 0x3d402064, 0x14001b },
 	{ 0x3d4020dc, 0x12200004 },
-	{ 0x3d4020e0, 0x0 },
-	{ 0x3d402100, 0x7090b07 },
+	{ 0x3d4020e0, 0x400000 },
+	{ 0x3d402100, 0x7090507 },
 	{ 0x3d402104, 0x20209 },
 	{ 0x3d402108, 0x3030407 },
 	{ 0x3d40210c, 0x2006 },
@@ -680,12 +680,13 @@ struct dram_cfg_param ddr_fsp0_cfg[] = {
 	{ 0x54006, 0x140 },
 	{ 0x54007, 0x1000 },
 	{ 0x54008, 0x101 },
+	{ 0x54009, 0x200 },
 	{ 0x5400b, 0x31f },
 	{ 0x5400c, 0xc8 },
 	{ 0x54012, 0x1 },
 	{ 0x5402f, 0x1d70 },
 	{ 0x54030, 0x4 },
-	{ 0x54031, 0x18 },
+	{ 0x54031, 0x58 },
 	{ 0x5403a, 0x1323 },
 	{ 0xd0000, 0x1 },
 };
@@ -700,11 +701,13 @@ struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0x54006, 0x140 },
 	{ 0x54007, 0x1000 },
 	{ 0x54008, 0x101 },
+	{ 0x54009, 0x200 },
 	{ 0x5400b, 0x21f },
 	{ 0x5400c, 0xc8 },
 	{ 0x54012, 0x1 },
 	{ 0x5402f, 0x1220 },
 	{ 0x54030, 0x4 },
+	{ 0x54031, 0x40 },
 	{ 0x5403a, 0x1323 },
 	{ 0xd0000, 0x1 },
 };
@@ -886,11 +889,11 @@ struct dram_cfg_param ddr_phy_pie[] = {
 	{ 0xd00e7, 0x400 },
 	{ 0x90017, 0x0 },
 	{ 0x90026, 0x2b },
-	{ 0x2000b, 0x32 },
+	{ 0x2000b, 0x1c2 },
 	{ 0x2000c, 0x64 },
 	{ 0x2000d, 0x3e8 },
 	{ 0x2000e, 0x2c },
-	{ 0x12000b, 0x14 },
+	{ 0x12000b, 0xbb },
 	{ 0x12000c, 0x26 },
 	{ 0x12000d, 0x1a1 },
 	{ 0x12000e, 0x10 },
diff --git a/board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c b/board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c
index f845395ad9..ca14a47442 100644
--- a/board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c
+++ b/board/bsh/imx8mn_smm_s2/ddr3l_timing_512m.c
@@ -18,15 +18,15 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{ 0x3d400304, 0x1 },
 	{ 0x3d400030, 0x20 },
 	{ 0x3d400000, 0xa1040001 },
-	{ 0x3d400064, 0x610068 },
+	{ 0x3d400064, 0x300068 },
 	{ 0x3d4000d0, 0xc00200c5 },
 	{ 0x3d4000d4, 0x1000b },
 	{ 0x3d4000dc, 0x1d700004 },
-	{ 0x3d4000e0, 0x180000 },
+	{ 0x3d4000e0, 0x580000 },
 	{ 0x3d4000e4, 0x90000 },
-	{ 0x3d4000f0, 0x0 },
+	{ 0x3d4000f0, 0x2 },
 	{ 0x3d4000f4, 0xee5 },
-	{ 0x3d400100, 0xc101b0e },
+	{ 0x3d400100, 0xc100d0e },
 	{ 0x3d400104, 0x30314 },
 	{ 0x3d400108, 0x4060509 },
 	{ 0x3d40010c, 0x2006 },
@@ -700,11 +700,13 @@ struct dram_cfg_param ddr_fsp1_cfg[] = {
 	{ 0x54006, 0x140 },
 	{ 0x54007, 0x1000 },
 	{ 0x54008, 0x101 },
+	{ 0x54009, 0x200 },
 	{ 0x5400b, 0x21f },
 	{ 0x5400c, 0xc8 },
 	{ 0x54012, 0x1 },
 	{ 0x5402f, 0x1220 },
 	{ 0x54030, 0x4 },
+	{ 0x54031, 0x40 },
 	{ 0x5403a, 0x1323 },
 	{ 0xd0000, 0x1 },
 };
@@ -886,11 +888,11 @@ struct dram_cfg_param ddr_phy_pie[] = {
 	{ 0xd00e7, 0x400 },
 	{ 0x90017, 0x0 },
 	{ 0x90026, 0x2b },
-	{ 0x2000b, 0x32 },
+	{ 0x2000b, 0x1c2 },
 	{ 0x2000c, 0x64 },
 	{ 0x2000d, 0x3e8 },
 	{ 0x2000e, 0x2c },
-	{ 0x12000b, 0x14 },
+	{ 0x12000b, 0xbb },
 	{ 0x12000c, 0x26 },
 	{ 0x12000d, 0x1a1 },
 	{ 0x12000e, 0x10 },
-- 
2.43.0

