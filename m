Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C505C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FF688C97;
	Wed,  1 May 2024 04:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8GnyI7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D482688C95; Wed,  1 May 2024 04:45:44 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D129D88C4B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-790f699eb2cso258669385a.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531541; x=1715136341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmgqgGdC28kSHjBKnMQeJ1A1lnySfPX30R8KvfAugaM=;
 b=n8GnyI7h9acPZOfqYhB6tZdD3eGbHKZcU6A2SBsgZ4wJzRPnMmCacG9bTL23i7Ish9
 ziATsFzAOUGxR0BR8rboz9mJQsu0km5+aNp0EXkoiSVfSIKXYYHmUmJhmsrGCgHlQDux
 5az9W/3ee/yPOX/ZbWPpko7rtn4Puc8+o8Rnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531541; x=1715136341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmgqgGdC28kSHjBKnMQeJ1A1lnySfPX30R8KvfAugaM=;
 b=w01NlHiNOBd7mLKeDXBHksxyEsEhmEA7c7YJZaLWqUl0VJLDRkMwDqrmtEB9+AMxof
 c4x44PimXhWqaFuOrvTzkC6okx34woYWXEP2hjAlTLjaPennEC1na0Vn7q+88rKTvo5b
 PaxlxUFNpdJnbxpX3UvOIff3v2edAFPqQy2pbCWwwEtC/SMgYoeJKlG6SvhQFL4bs6tW
 uEwVetxwyuUSVZKG8ItuQ1mfPXHz1dZxsa9OgPZbtvDAQOnCrD8ATBizz9y+shuy77aW
 dGE1tR7rfuktSGg31J0CghO15qKVoc98NsoRRS/QkQ0cKq5W38V6p+oOmAfpMP+AA+6p
 XEEA==
X-Gm-Message-State: AOJu0YwZH5juZ5EUV1sv46k8+jDQ4ogCR7gPOE1U9C76MYhZoTBsWtMD
 SjHH5syytnEVT1FsfbXNS0MuaBnHfs6yolIhxvyWQ33ch/dyh8EMUlBnMnJslaopyNUwEoFTqBo
 JwpsmM437
X-Google-Smtp-Source: AGHT+IHvE0+GtYnx+zss6iXmaMIrtIbS8eYmhopBtDiAZ3L38p1b0HRVSMQsbj27rmEFvaOLVeK2SQ==
X-Received: by 2002:a05:6214:260b:b0:6a0:cef7:c54d with SMTP id
 gu11-20020a056214260b00b006a0cef7c54dmr1480492qvb.56.1714531541327; 
 Tue, 30 Apr 2024 19:45:41 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 125/149] board: sr1500: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:52 -0600
Message-Id: <20240501024316.1767971-125-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
---
 board/sr1500/socfpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/sr1500/socfpga.c b/board/sr1500/socfpga.c
index d9125a76bf7f..5603ef24da80 100644
--- a/board/sr1500/socfpga.c
+++ b/board/sr1500/socfpga.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/gpio.h>
-- 
2.34.1

