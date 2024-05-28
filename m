Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06513C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449FC88494;
	Tue, 28 May 2024 12:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZ+asYfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E774087C75; Tue, 28 May 2024 12:00:02 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B178843D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso73360366b.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890400; x=1717495200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EvEiVOFrs4z6rXpWhwzsENvMSMZyz0DyRz34qm8nD4=;
 b=aZ+asYfHPz+8ItCjUap8HKLM7MgVkl8HdZhtPSsrlNWHeFvra83AnYrxL/TX8pWiGk
 Y24hh28Qh73Is/LIMwLmbTH0+gbQXSkYp8WZ1h3oFpUE73bSO9NyobNk6twGZJZhxhys
 8gr93Fh6lBNXIppsWU4cqkoG4KIIspzg5NmrRhYX+CBxDYRObqnZspfYmjF5/IU/xRty
 5f2sGs8NUImDtV4rXNza7lUq1WtKbZwwljzizDABmecoPZKgdnsk2gm/5AqRp/rUZX3s
 jSfnp9xFmaCNutTk5VWx1HRPc4AevEL//cJZpLVvwYzROy0iqVHjczAAWVvVO/vBv3Up
 Cc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890400; x=1717495200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EvEiVOFrs4z6rXpWhwzsENvMSMZyz0DyRz34qm8nD4=;
 b=AfFF4wLit+8vlxrugJypCHlokpC1bmerJFuUaIebzP8iRbeeNzqRl7DOzrJwehzQ6Z
 a/Xxn0tZl0p9qI8vkLNXKK1OtCG0EDtJJkNJVNLxUmEEFfwicLfW52dC1qIV2fQa151E
 Scoywuln/uArltE5vztm9JlHxnZAshR8TgBwaIH5DPlUT3+Az9u0FZLRRiPjzHPozWbg
 WBJKqgg6qf0n8Xk4yZL5wBZRlQV+R25vHbXnNxYfofdSt7AeK96qH7nABgNtvoWMKbQQ
 /yGlnCGH8HiaJsuqYSWHIB4PCS2O+wHKt5NZxNhtp2C6JF0t2ok+q5Xh8kkz3FpU2LR1
 W1Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgkCs3mHrTDaFZRJV+BDTSwoQ8JkeBCLcYNF4Lk1mKvlZg16vMYt6iqyOxnyy6hnmp6g+Rvz2JdX6PjOcdtDEfWSCykQ==
X-Gm-Message-State: AOJu0YymiUsqQY+Y3HQPj27nXSjMLFwPSxdIM0zV70jf4p1pWXJFYmSA
 fews8HXQ7exI+CSZVTCZb1AxG7oMBacsmqgHsYtGCy0YupnNsDVI
X-Google-Smtp-Source: AGHT+IFRUhc3AT6v8unG1G6bJC6rPLH2nm/Mvw5NbJ5IJkpSuQWDNVIv9GsJunSWTiir5BR36A55Bw==
X-Received: by 2002:a17:906:c113:b0:a62:a9ca:2111 with SMTP id
 a640c23a62f3a-a62a9ca25admr715510566b.11.1716890400213; 
 Tue, 28 May 2024 03:00:00 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.02.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:59:59 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 1/5] board: toradex: verdin-imx8mm: add 4 GB lpddr4 memory
 support
Date: Tue, 28 May 2024 11:59:37 +0200
Message-Id: <20240528095941.872693-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support for MT53E512M32D1ZW-046 IT:C memory.
This 4 GB memory has 17 row bits instead of 16 and requires 380 ns of
tRFC (tRFCab) instead of 280 ns due to increased channel density to 16 Gb.
Both modifications are retro-compatible with previous memories.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/verdin-imx8mm/lpddr4_timing.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/toradex/verdin-imx8mm/lpddr4_timing.c b/board/toradex/verdin-imx8mm/lpddr4_timing.c
index 4dfec679b116..eece226b5131 100644
--- a/board/toradex/verdin-imx8mm/lpddr4_timing.c
+++ b/board/toradex/verdin-imx8mm/lpddr4_timing.c
@@ -18,7 +18,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d400000, 0xa1080020},
 	{0x3d400020, 0x202},
 	{0x3d400024, 0x3a980},
-	{0x3d400064, 0x2d00d2},
+	{0x3d400064, 0x2d011d},
 	{0x3d4000d0, 0xc00305ba},
 	{0x3d4000d4, 0x940000},
 	{0x3d4000dc, 0xd4002d},
@@ -34,7 +34,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d40011c, 0x402},
 	{0x3d400130, 0x20600},
 	{0x3d400134, 0xc100002},
-	{0x3d400138, 0xd8},
+	{0x3d400138, 0x123},
 	{0x3d400144, 0x96004b},
 	{0x3d400180, 0x2ee0017},
 	{0x3d400184, 0x2605b8e},
@@ -56,7 +56,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d400204, 0x80808},
 	{0x3d400214, 0x7070707},
 	{0x3d400218, 0x7070707},
-	{0x3d40021c, 0xf0f},
+	{0x3d40021c, 0xf07},
 	{0x3d400250, 0x29001701},
 	{0x3d400254, 0x2c},
 	{0x3d40025c, 0x4000030},
@@ -71,7 +71,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d402020, 0x0},
 	{0x3d402024, 0x7d00},
 	{0x3d402050, 0x20d040},
-	{0x3d402064, 0x6001c},
+	{0x3d402064, 0x60026},
 	{0x3d4020dc, 0x840000},
 	{0x3d4020e0, 0x310000},
 	{0x3d4020e8, 0x66004d},
@@ -86,7 +86,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d40211c, 0x302},
 	{0x3d402130, 0x20300},
 	{0x3d402134, 0xa100002},
-	{0x3d402138, 0x1d},
+	{0x3d402138, 0x27},
 	{0x3d402144, 0x14000a},
 	{0x3d402180, 0x640004},
 	{0x3d402190, 0x3818200},
@@ -96,7 +96,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d403020, 0x0},
 	{0x3d403024, 0x1f40},
 	{0x3d403050, 0x20d040},
-	{0x3d403064, 0x30007},
+	{0x3d403064, 0x3000A},
 	{0x3d4030dc, 0x840000},
 	{0x3d4030e0, 0x310000},
 	{0x3d4030e8, 0x66004d},
@@ -111,7 +111,7 @@ struct dram_cfg_param ddr_ddrc_cfg[] = {
 	{0x3d40311c, 0x302},
 	{0x3d403130, 0x20300},
 	{0x3d403134, 0xa100002},
-	{0x3d403138, 0x8},
+	{0x3d403138, 0xA},
 	{0x3d403144, 0x50003},
 	{0x3d403180, 0x190004},
 	{0x3d403190, 0x3818200},
-- 
2.34.1

