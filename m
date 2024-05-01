Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1535C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0754E88BE5;
	Wed,  1 May 2024 04:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P01/W/H+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CD388C60; Wed,  1 May 2024 04:45:34 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C57588C6F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b9365e584so3646166d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531530; x=1715136330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdqbL60HeR3JIeHJ1fwisYh58e5/h7L/kFyvp4otJjY=;
 b=P01/W/H+u6WlYU7B5UOfJmgJlpD8VIKyvBBtvZFOPMK9rzkhDlKMAUSvEp6PKQZdZp
 EORq3I9MfG8yyWplL50FwYrf4oYyw5+2lQQH0XsND8J2qmotRrjIGAaBiqC0RiBh2Kfb
 finSiGJ9FAg9I1bwc7Akn5dHpalfsO6DpYMvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531530; x=1715136330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdqbL60HeR3JIeHJ1fwisYh58e5/h7L/kFyvp4otJjY=;
 b=qexNppcw6Pyt5ren1DLej42wvzWVg6MdJsv4qzP2vZDjkDyAlBkmafMX4fCOpe2c9y
 fMfYCYHLR6HVXkhlxon/EjONd/f5csWpXzNeEOmeotBJ0STSe3LsTxm3/O3cwIP554qa
 d9KeALLESIk0qxK2xZVi98BpN9eCHK69TzfhB9Gamrh5fEPYx410o6QoJy+TGexlMIB/
 BIfHi+Vy3Ry/gxfz+FulyC5hei4e+x7v8CDzb7fxyyfLpzOBJgY4ZDMXuJTwpQVdNazL
 WezWcPRuVycadCvrQ74qdi7LhT7VmYWhGSNPrVw6Cb+Oven2YKD5+Yfdh7to/I7FeS00
 x1JQ==
X-Gm-Message-State: AOJu0YzQqGPdzEdpQ7u4aKtEipy+qBA24DHnLTAAV6fEQeqQ4S5yhu29
 x+SuLcqJsDeddRoPM4Th0SdOwJh/p9uhuMTd2iAxoeeFkTWvSByYVKwa/lq8ayrqlj7D+MEDYUP
 Bre3k6z3e
X-Google-Smtp-Source: AGHT+IGJkeN87ZxPuTS7aVN1uSjlj/5JWVlkYgcEHfdseTLUTkQf8ZL2/jVtZ7czp/P77iVMNGKqoA==
X-Received: by 2002:a05:6214:e8d:b0:6a0:91ee:244 with SMTP id
 hf13-20020a0562140e8d00b006a091ee0244mr2883244qvb.19.1714531529839; 
 Tue, 30 Apr 2024 19:45:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
	Navin Sankar Velliangiri <navin@linumiz.com>
Subject: [PATCH 115/149] board: seeed: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:42 -0600
Message-Id: <20240501024316.1767971-115-trini@konsulko.com>
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
Cc: Navin Sankar Velliangiri <navin@linumiz.com>
---
 board/seeed/linkit-smart-7688/board.c | 1 -
 board/seeed/npi_imx6ull/spl.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/seeed/linkit-smart-7688/board.c b/board/seeed/linkit-smart-7688/board.c
index bf7c69ea8389..91fa08fd9ec2 100644
--- a/board/seeed/linkit-smart-7688/board.c
+++ b/board/seeed/linkit-smart-7688/board.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
diff --git a/board/seeed/npi_imx6ull/spl.c b/board/seeed/npi_imx6ull/spl.c
index b29da2c1fc1e..2312d8fac693 100644
--- a/board/seeed/npi_imx6ull/spl.c
+++ b/board/seeed/npi_imx6ull/spl.c
@@ -4,7 +4,7 @@
  * Author: Navin Sankar Velliangiri <navin@linumiz.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

