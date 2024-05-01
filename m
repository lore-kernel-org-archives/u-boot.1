Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0587BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602B488A88;
	Wed,  1 May 2024 04:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VzW0JOBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E73F88AAF; Wed,  1 May 2024 04:43:31 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A77088A7B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4dac3cbc8fdso1902170e0c.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531408; x=1715136208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0Q7hJnhjd0O0hIemYSWbQEakAZNcJSVgoReNwJO0Bs=;
 b=VzW0JOBtXEFZphICWLD+1eSrUcmDnWrxuTTXW5Sm+4bl4aawpbJedfRLKxYiJJRh/y
 cwo1PAwDqySBzIKAOOrE7Dy0KV1+jBQajlMsgSlE7vQ0REa7Hs8z2R68VUJRrEOnPv7l
 eNKH/2qSf3Q8jKX+fWiSVma9JIjVru7TXARP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531408; x=1715136208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0Q7hJnhjd0O0hIemYSWbQEakAZNcJSVgoReNwJO0Bs=;
 b=OoWWenOM08LCw1UKlLf5CzIvUAmZevRaPxJf7BfE3Pc+EEnKccKJDK4lktBm+OdE2k
 c0YKaKvcn1viNBRs+cJm0jbY/HItUDsb8j2syd+msGNrUjNMdfIS7NDGJflux53VrwTf
 n2sTgDu0HzILenDCbk4n/oArEgZKDJo0kvrodsXVAMKVnPHek+6STNmXWgP/iyhsvrBk
 yaW7HvrcZFGYQezYPKNIj3YYdoH5ZwcrYm3/UpH8KY6oqy8mkOQfGNA3kfc94bs0TNkx
 P6zbPVZfA6MqCBBmp7QmbnOhZ+8AG9B3tThRpfRY8TJoIy6YvfwucU45l29w3UqK2aek
 JtGQ==
X-Gm-Message-State: AOJu0YwSjQMxckUqw++P4oit/5fBwAqe3MTgzNGBa3o5RZTPem5bXIHl
 LGHaIL4MXS36/LRPO9ajE8+nY7fTuZGiJToUpJGgUX41IxUpecn7481CuLnurnlkWyHIQbmhzWb
 +xt4s8A==
X-Google-Smtp-Source: AGHT+IGTLns1lj4Z8MBRPf+BlKtjfEt8dBYwhcUwFaLL4qwtCnwQ2FTcztBagP/SKk3RFr/kmVguVw==
X-Received: by 2002:a05:6122:c9c:b0:4da:ced8:b09a with SMTP id
 ba28-20020a0561220c9c00b004daced8b09amr1653178vkb.0.1714531407427; 
 Tue, 30 Apr 2024 19:43:27 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH 009/149] board: LaCie: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:40:56 -0600
Message-Id: <20240501024316.1767971-9-trini@konsulko.com>
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
Cc: Simon Guinot <simon.guinot@sequanux.org>
---
 board/LaCie/common/common.c           | 1 -
 board/LaCie/net2big_v2/net2big_v2.c   | 2 +-
 board/LaCie/netspace_v2/netspace_v2.c | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/LaCie/common/common.c b/board/LaCie/common/common.c
index 52880a16fad3..e8a7830fc056 100644
--- a/board/LaCie/common/common.c
+++ b/board/LaCie/common/common.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2011 Simon Guinot <sguinot@lacie.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <miiphy.h>
 
diff --git a/board/LaCie/net2big_v2/net2big_v2.c b/board/LaCie/net2big_v2/net2big_v2.c
index 917091340009..083d91b696a1 100644
--- a/board/LaCie/net2big_v2/net2big_v2.c
+++ b/board/LaCie/net2big_v2/net2big_v2.c
@@ -8,7 +8,7 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <env.h>
 #include <i2c.h>
diff --git a/board/LaCie/netspace_v2/netspace_v2.c b/board/LaCie/netspace_v2/netspace_v2.c
index 22bb008745e1..3a2fdb5c1546 100644
--- a/board/LaCie/netspace_v2/netspace_v2.c
+++ b/board/LaCie/netspace_v2/netspace_v2.c
@@ -8,7 +8,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

