Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F3C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220E082998;
	Fri, 16 May 2025 01:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lbfLGWdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6380F82A1C; Fri, 16 May 2025 01:42:06 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603E68059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1874378a34.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352523; x=1747957323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9WX+6mgXgC0/QRZtep+w8rBvN187N1/PeM+nKiXZjE=;
 b=lbfLGWdC6kk8BXSm/1tRBm5g3LiO5bj4JZsEJ5HwaubLVnqpeo/8Wj46AcsBxy+4jK
 AKuSqH2s+nBFSt5QmWG5KHtMiOwGQQC30hMhOPCTqxmi+T1H87uzITqr6xa5arRgrQPu
 /egrzX9ePmrK6k8acu0DLWsmk3j28BQyR2X5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352523; x=1747957323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9WX+6mgXgC0/QRZtep+w8rBvN187N1/PeM+nKiXZjE=;
 b=m5SkP1wkNJnbSnRLfaIU3TC9dWjG5a9QtpUUIoS6bxWOdpwaAdCbvs9MXJMtUM0ISH
 WkktQDdT99qzECZMohB6LbyHD75Y4FcrtD9d4yU2Cav3yrAAosuP13HDlYFE2BftKW9z
 tuOTtOk6p5EXshn78q/Dn+eee1wmDoKBU0fK7PKGfdAtbA5fvnYL9o0X/ndMIlKC1tiT
 d2ADdW0UTv9hyPvTMNGDBLyseNjoekIn3VmKM4aBWmqcupb7SbTOGeLLXhCOfS0ghgNL
 zdtNZbreaDgDpi4+pMtM1ro6ss6LZDHvjDkcg6DiHah5ZmWWXsPrk3arpyu/I9VzvfKw
 /s0g==
X-Gm-Message-State: AOJu0YxsSUH6xme1/m0yX+qh+aoqztWcR4qc4CGhFCroFlEZ0+knsted
 pJmeNblE8CepX6W5vYqUQu/J74RKdMiRBGzP2EK2HyvOSMIzAx3g70PIn4LadALia3R0Q7ITVCn
 48/szXGw=
X-Gm-Gg: ASbGncsrkscJatQyNFa+dYJqY/W8C5uCv8K1eBSFcrDlA9sLroartrLv7hmrS1QJEWR
 yVmExOU/nuskpC54SGXm0V7s57grSpnkEDF0uts7tJMu++3EB7HNp9MJ8l6tSZ0hxh8pAs1TJA8
 9ID+1lmeqJkyuiV/Owxkr5t8OdZ+tLwKy9n1DKPCouLWbNCceDbbR2HPRU+yrxWAoyzFeAFKcBd
 z21rlke12ba11q2FsegPouVnp9iwwM7FHmZ3PlOe8jaz2hRRzzDv3i4gSjWg/JKX5QJkUdQ4fEU
 5omzqLChigDtxZhcie7RwSgF55oLfg9YKaIaB6TvQVNDNWtrBVIO6ViQgey2YqITsnh/GJLDvb4
 bFK/RVm6W7aVMdjc=
X-Google-Smtp-Source: AGHT+IGzgUQCOLJXqyqA4CaGidglwJ+N5ueIv4qFGG6G07o39+VmK9YbQh+e4p5WIznQ65GMYXL2iw==
X-Received: by 2002:a05:6830:370b:b0:72b:872f:efca with SMTP id
 46e09a7af769-734f6b76262mr971765a34.27.1747352523122; 
 Thu, 15 May 2025 16:42:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/22] imx8ulp_evk: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:33 -0600
Message-ID: <20250515234154.1859366-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/freescale/imx8ulp_evk/imx8ulp_evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index 0af610672637..4bf77a488ccd 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2020 NXP
  */
 
+#include <env.h>
 #include <miiphy.h>
 #include <netdev.h>
 #include <asm/arch/imx8ulp-pins.h>
-- 
2.43.0

