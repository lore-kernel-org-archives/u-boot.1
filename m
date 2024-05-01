Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCCBC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142E688CA3;
	Wed,  1 May 2024 04:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SRB4H4Fw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31A688CCB; Wed,  1 May 2024 04:45:58 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BA088CCC
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78edc3e80e6so498634385a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531555; x=1715136355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J7Qg/QlN5CUUvFO/Zu3U9K7TnQanU+rtN340J0cVQVw=;
 b=SRB4H4FwSIAOzL8PqyKvVv0xkl/Y8MgiFXslaq4WiJVux7/as1OYjpjRl/Xbe2V2OG
 zNEgVI2fmKZQqIKNRPpjksZ/YG0WuFAsHeYNU2bxorbOOGqU070A02h3mMtCCv3vUS72
 fQWxfbTLaCv4eAbv3pYDxlrdsEBfV5BTZYiNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531555; x=1715136355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7Qg/QlN5CUUvFO/Zu3U9K7TnQanU+rtN340J0cVQVw=;
 b=Hh/dGVJMCUpeyzbWeHh3YRmeTwrEGMOvVrHBFeb0o1AHW0xV5n0UO2twJZpVmLmd7i
 cQ4HgNopo2UEkewcLAzYa0j4VubV94rtXD9jm33AmVZ4nD5QB8m3oLHjmzsYf1CQDl+x
 PcG8RqNi8o720eYJa9vg5aK7qWgf+LuDux1zFwi3UcB66YJU93tsXerxAnWPzQ5lQWtu
 TjLq24lCrCm1YdSHI+Ar7Qk0A2piSWObb107da6fh+XRujMWkipHuaBvQKw4H6uUtLYT
 xYrT645NUVnRqgriiH5eA5E0StI2WXTPeS769dIEQwJNqH0SEkKTFZ+6sr1ObwRbhK/b
 n+LQ==
X-Gm-Message-State: AOJu0YyHtVfLc8PhYxYS8hPB6HO7zPzGsNw91eSYnZ0Bxk0hMacQmac/
 rB5RY67Hde6LxloQPdt8GzAEYz6/9mOiQR9pv5DJPtx1EVEKf2EF6iQEIo5MxcJsYl5/br2OP5Q
 4zJgmgD68
X-Google-Smtp-Source: AGHT+IFHg2jxx+P/GW4sMN2JezhKKZtXAQC1l6x61HC17WJEUPg4zvShAZtKPWNCRN+0aaqkRSwBeA==
X-Received: by 2002:a05:6214:2489:b0:6a0:6843:b52c with SMTP id
 gi9-20020a056214248900b006a06843b52cmr1567154qvb.7.1714531555681; 
 Tue, 30 Apr 2024 19:45:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH 138/149] board: tplink: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:05 -0600
Message-Id: <20240501024316.1767971-138-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
---
 board/tplink/wdr4300/wdr4300.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/tplink/wdr4300/wdr4300.c b/board/tplink/wdr4300/wdr4300.c
index f2de039b6b47..3ae0dc4ecd73 100644
--- a/board/tplink/wdr4300/wdr4300.c
+++ b/board/tplink/wdr4300/wdr4300.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/addrspace.h>
-- 
2.34.1

