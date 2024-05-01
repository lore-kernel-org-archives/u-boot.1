Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAADFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7992F88BCA;
	Wed,  1 May 2024 04:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j/5VahUo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2E388BD5; Wed,  1 May 2024 04:44:53 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C3C88B8B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-790f699eb2cso258624885a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531488; x=1715136288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSlHZGCgOJcp/1VoJ/9ZfkNZPIryF3sFtE9LvKIcYKg=;
 b=j/5VahUo6QuuiWO/9XM3LbHX15qGi4puA0hwGXy1iH+VDIoqXv4ke+LsxF9uQ73D+3
 IYMrtlJw5wepE6fUVQWzS7offLfoc0frX8eX0f1KLutu2iAVYUNBirLUiwIZevLgL6vl
 hYQ81ikuk0AOAQRNhzF7dN7ve61kij1Qt7/Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531488; x=1715136288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oSlHZGCgOJcp/1VoJ/9ZfkNZPIryF3sFtE9LvKIcYKg=;
 b=pvToBjOXx3VEmHdf4zSrXJatPqRvWKMyPN0EGIM1WDSWMjaIsUvTkbcoDMBTNC/c8j
 Z1JFqHRlTpg/4H6ViZ3IOCA9fv7EYTXPPanw9Aps/JwMBNXzNpeUTmHhdwTdxRQRWxUo
 OYIsKp8oZjUM/ySrxnLGzetCGHhuHwQDjhf9DVtYU2Y6dKPK75w2foDR0hXGXa9X5gwN
 Tx9ZCeRYnQXfN9x5boV4WUyCn7xBeUwixQ9uFOdX/P4wag3diS3fMu5G0+fZtDCueVBF
 9fcmOzbP2EOjgZfPikU4nUkzxsF7EuF1vaNNaCEovMx4R7P3YIYxbsR3fwXo4dPrRxgy
 Jmtg==
X-Gm-Message-State: AOJu0Ywq0dlWqjNK+VH0KeCGVACIKoHiUVH+ATrTbme2bjcVb6zbycvh
 cxd+xSOejBgKv3tH8B8bRV95uuxEf135xt1NI2l+X5a6VNkU9zj6npow5VDb4q7fJswG4uaRHO0
 INYlxWg==
X-Google-Smtp-Source: AGHT+IETFFILxaQkDB/fXT8ylFwVX72O4CH/cgn2upaoTlFiqWLiWO5i7yQzDwP/47OKMXXiE292ng==
X-Received: by 2002:ad4:5dcb:0:b0:6a0:c962:a2be with SMTP id
 m11-20020ad45dcb000000b006a0c962a2bemr1361149qvh.39.1714531487937; 
 Tue, 30 Apr 2024 19:44:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 076/149] board: isee: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:03 -0600
Message-Id: <20240501024316.1767971-76-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: "Javier Martínez Canillas" <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 board/isee/igep003x/board.c    | 2 +-
 board/isee/igep003x/mux.c      | 1 -
 board/isee/igep00x0/common.c   | 1 -
 board/isee/igep00x0/igep00x0.c | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/board/isee/igep003x/board.c b/board/isee/igep003x/board.c
index 7dbb08008927..7cd26ce3c34b 100644
--- a/board/isee/igep003x/board.c
+++ b/board/isee/igep003x/board.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2013-2017, ISEE 2007 SL - http://www.isee.biz/
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/isee/igep003x/mux.c b/board/isee/igep003x/mux.c
index 550e3b3197dd..1a40c0077627 100644
--- a/board/isee/igep003x/mux.c
+++ b/board/isee/igep003x/mux.c
@@ -11,7 +11,6 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/isee/igep00x0/common.c b/board/isee/igep00x0/common.c
index 3fdf83e845c9..2584d2e5ddfd 100644
--- a/board/isee/igep00x0/common.c
+++ b/board/isee/igep00x0/common.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <twl4030.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index 0f0a9c592fcc..8a3f290f678f 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2010
  * ISEE 2007 SL, <www.iseebcn.com>
  */
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <init.h>
 #include <malloc.h>
-- 
2.34.1

