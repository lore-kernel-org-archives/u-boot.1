Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42068C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 18:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A1D80C65;
	Thu,  6 Feb 2025 19:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ntmzz9wM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A7880A29; Thu,  6 Feb 2025 14:48:16 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CF980944
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 14:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-543cc81ddebso1109925e87.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 05:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738849692; x=1739454492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t19zkm30D9iOuRYBiKE8YHHuQ6WgSfbYhjELdTog/fY=;
 b=Ntmzz9wMIsqqyZmpKt05rsr2eFIfovhXXOFK7gF5Izzl/WQ2HE6W0e2bpcv6KAcSss
 mmRogey1LeEHativ1xluzrVvdzC3lAQMmAoUXJTOSS7+PbOlGsLLubEXJrXsDq/8CjRG
 Sa+l6V4F4+aJGIe7NxiHPArNaDZRJmaZKzXCibhLjBW8HoJfMlZXuVuyktqX6ghrs+gJ
 wOE+pitUr8wK6IbSg7KFooAweisTsh2BL1vWY6qoNmCF5OFYenCkPgNWFSjJXvB3ECg+
 W7RfpHLYmrL8RXabrT8MSf0rOhuZoFIF9RIO7GA/t7+K0EK7YUTdf7F6ATCSO3EeBStY
 KJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738849692; x=1739454492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t19zkm30D9iOuRYBiKE8YHHuQ6WgSfbYhjELdTog/fY=;
 b=uqSuHWA5eCKhOIWC+8gO+bJWY6jO1jhxFb9rxLJFvgkCVlaqvBVmgUXMrb5nRxx5xB
 16E9bP1ido1o/kkw3vYFrpj6Ti8btopsrbdHLLhpPWgLSwYwf97EJbd6EvDEE/EnppQP
 gelPO7hBcwbD5JszlCVbOM6aI6WpDlFxSUsFbijsGQMls676Qc3hMK5z18PdufmAP0B+
 +1Y6GGC6WhOH2HSRDfrwinMomwbPnduiuEHD0a8NcdlOkl68iWs5AQnNkztByUqTff/u
 +ErnGY8IjQUl1p1/RE6kmpeNvtec9RGjl+himsVWd0QtEECd9HpM87dsWo926GDOwLP5
 9vAQ==
X-Gm-Message-State: AOJu0YywUu/wHIZ0g+2ImNj/90aJprZ1KugEhYXTIW5n0cR749e0ySAM
 Xo1MwRP1S8mQhiDllD894VKcM0nQe954ZVTm3QMDrwZNIeWKxPu/O9BbUA==
X-Gm-Gg: ASbGncvMdhWFSZ9YggPHo+qNpqcqY0LBHYRUABlQoO6vdmHAtH3Vygal7XUC9g36spL
 unn0xdXl/Jinz8j1XN2vfyh36tf1pKarwFaT+rGgZZxZEPGo+tEbjGsMmgVBoiqLKPRgSexJ3er
 OjQZMgK1/dNgrW/ecPiwzV6qlMr7mJ5NkkpNAgOuGXGJSzF4H3E/jriYsfTu3Fcgi4XroOJqAq8
 clT8Lz5NbEHPsmCexv3szdpmBSmhPbv23Kb6O+fXJBasUNC473RPKZCp+1bIX7G+rd6IGycp/s5
 wVSdYDHZgHMC2dQPlKg6mMc=
X-Google-Smtp-Source: AGHT+IFkcSToldSKehGSzOVqpE44XlQ/egwSbgV3rDiQekzLm7w9KpvKjgrkUQKGQr5GklNhtvkWsA==
X-Received: by 2002:a05:6512:2396:b0:542:2137:3a31 with SMTP id
 2adb3069b0e04-54405a34de1mr2282858e87.21.1738849691713; 
 Thu, 06 Feb 2025 05:48:11 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544105bf5cdsm136135e87.122.2025.02.06.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 05:48:11 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] common: Fix memory leak and incorrect comparison
Date: Thu,  6 Feb 2025 16:48:09 +0300
Message-Id: <20250206134809.3048114-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Feb 2025 19:58:54 +0100
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

Changing the order of actions: the input argument is checked before 
memory is allocated. 

The input argument `n` is of type `size_t` and cannot take 
negative values, so the comparison has been fixed.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 common/dlmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index cc4d3a0a02..2f4cabda4a 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -2093,6 +2093,8 @@ Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
   mchunkptr p;
   INTERNAL_SIZE_T csz;
 
+  if ((long)n <= 0) return NULL;
+
   INTERNAL_SIZE_T sz = n * elem_size;
 
   /* check if expand_top called, in which case don't need to clear */
@@ -2104,8 +2106,6 @@ Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
 #endif
   Void_t* mem = mALLOc_impl (sz);
 
-  if ((long)n < 0) return NULL;
-
   if (mem == NULL)
     return NULL;
   else
-- 
2.34.1

