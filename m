Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94706CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307BE88E66;
	Thu, 26 Sep 2024 22:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gPgXdKFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE1BF88E36; Thu, 26 Sep 2024 22:53:38 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525DB88E46
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a99fdf2e1aso145484585a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727384015; x=1727988815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y/McoADJt6DT+PfH7q2ldc4JciEHJAcic24Ums1KeA=;
 b=gPgXdKFXO4chaIjn2lqmQTKm8lzPF1USNZDcD0Lp2vsNodDaPceGPh+0ekflEr+Tpv
 myPw71VfmUtySC6QxPkpOLJ7tSz/WGYmytQ+5u7OD02rgwnsFUFzlxhfxRBiJvSHlEtQ
 dGlHlEJ+7F3nKErXy9TSBznA+HUkDZre62BtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727384015; x=1727988815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Y/McoADJt6DT+PfH7q2ldc4JciEHJAcic24Ums1KeA=;
 b=fRr8d5WuiMTkXQOMx6RsdbtUAfft8wGNfhiRyxvWs6cK2E7dUDxLkF9ONAaVn6UUdE
 udSVDUnahxNz3TQkWwDYKSoSoQBfAov49+DezzH87Gidb+46U3TiJ8ipH4xMZkj/wIuv
 qA29uqXApstUWFy6Fl8Y4z7tIGe38EfRg6pMiZIREG5UrBFIGXxtGXiZEAw4uE+WUBtU
 2/sQw2wXE7pmQgsbYXoEnlBO90F6BqkC3dzigZlrFkRDiFbia+XBhCFFdBSYvSNgUFIX
 zG//BOoy6f3rB0n2GP3xymKW7W7s1dOToLrhuLhHrxKFwaUNWF6cOSGiLNVIw3PDjgY9
 ptIw==
X-Gm-Message-State: AOJu0YzVdZ5dHWbSZga+oGPStJHPvZWi8jxYmd6wfxVSr+tk88POpB4X
 QN5G6OK1iRBslto23X/MCaRAby263sIhtSn4vOqQzoL+rLH8bLq1oEOYn1ybdFDap1gPEg39rmJ
 2dz/Zqf4=
X-Google-Smtp-Source: AGHT+IFuF54wSZTSAYGm4V3ZE85iZ0epoF25PiGDom4yGKGbbigpBdln1XbLL69lMv6LnGuRv/jBxQ==
X-Received: by 2002:a05:6214:3102:b0:6c3:643d:3b with SMTP id
 6a1803df08f44-6cb3b66c68fmr11507066d6.42.1727384015082; 
 Thu, 26 Sep 2024 13:53:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:53:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 24/27] ide: Drop unused status_led.h header file
Date: Thu, 26 Sep 2024 22:44:44 +0200
Message-ID: <20240926204455.963584-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/ide.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cmd/ide.c b/cmd/ide.c
index 036489fda97..be3078ae88b 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -22,10 +22,6 @@
 #include <ide.h>
 #include <ata.h>
 
-#ifdef CONFIG_LED_STATUS
-# include <status_led.h>
-#endif
-
 /* Current I/O Device	*/
 static int curr_device;
 
-- 
2.43.0

