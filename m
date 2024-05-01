Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32848C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CC788CE7;
	Wed,  1 May 2024 04:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Chyz4Ke5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A5488CDA; Wed,  1 May 2024 04:46:00 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A329388C1B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a073f10e25so33847366d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531557; x=1715136357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scdy+S71GtnjkEvRTHWsYtypzdjMB72YrG+d1cr1wWA=;
 b=Chyz4Ke5HGPivBmCWhfQH8FB/G9VaYlBIEmoXEaRiOE8lIbuFOjIsOasqL+ETlkbo+
 kJrOilzWyMELiFRxRSHqS7LyTfKgqMRBhcrASgkOv4wWVNX5rvQBNkPC/6xzVMoMG8Di
 MdLJNsAV/DB1aGbtGppIEAEkeYjhG7cUUfw/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531557; x=1715136357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Scdy+S71GtnjkEvRTHWsYtypzdjMB72YrG+d1cr1wWA=;
 b=Oq+IQvHj2CMZRiMLB3kH+gpc+Np5MSmFOF+/WJSucDzE4/3XGrn4OfN55qrJFK4E13
 ces8eS21wm9g2BlxB40OmZPhB8c5szMQ3K/YRjTNNdDNRve4a8U6d2EFk7+oHco5MfQg
 GiS2z1rloSNrrD3qYy/lXjLS2WGLOnWnWpnS6zzJ9LtQvki9SdJEnvu5jq5nrOO2BZTM
 tpu3zo+Vb9xTSv18QzGCrDrmLDm3xif9PbOAocPiDlz1uewmquc3dV3uDorW73AmYgrD
 Uh3nD1cYJM/aP7phwULvE9j3K+j2YjnlnkiLAJ/eBd3qviomfIKhThkmyHdMU6ksFp1y
 TDjg==
X-Gm-Message-State: AOJu0YztEgLGJKK0mMjwJiMkglcs2JC4QakanSw9fVhohJY2ZjuyAEj7
 B9wFXuJ0Bnl9JCOhDOjBzHKkO/Bqjlz1nFLEFbsVsiivt5bPRHofQQVUV6TM6U8Ioimef84yKnH
 5upDAPqty
X-Google-Smtp-Source: AGHT+IEZzvikQ83wmyYANBLw44HbCSuG2OyIKzOpuSb3RrwujfT7dGVqE158zNSuR6rHwnW7RlMdtg==
X-Received: by 2002:a05:6214:40e:b0:6a0:d220:861f with SMTP id
 z14-20020a056214040e00b006a0d220861fmr1106055qvx.59.1714531557352; 
 Tue, 30 Apr 2024 19:45:57 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
Subject: [PATCH 140/149] board: traverse: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:07 -0600
Message-Id: <20240501024316.1767971-140-trini@konsulko.com>
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
Cc: Mathew McBride <matt@traverse.com.au>
---
 board/traverse/common/ten64_controller.c | 1 -
 board/traverse/ten64/eth_ten64.c         | 1 -
 board/traverse/ten64/ten64.c             | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/traverse/common/ten64_controller.c b/board/traverse/common/ten64_controller.c
index d6ef8a8d0df9..63b72c4df7b9 100644
--- a/board/traverse/common/ten64_controller.c
+++ b/board/traverse/common/ten64_controller.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <misc.h>
 #include <i2c.h>
diff --git a/board/traverse/ten64/eth_ten64.c b/board/traverse/ten64/eth_ten64.c
index 3f96e572b75a..c5f7acecc146 100644
--- a/board/traverse/ten64/eth_ten64.c
+++ b/board/traverse/ten64/eth_ten64.c
@@ -3,7 +3,6 @@
  * Copyright 2017 NXP
  * Copyright 2019-2021 Traverse Technologies Australia
  */
-#include <common.h>
 #include <command.h>
 #include <netdev.h>
 #include <malloc.h>
diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index 6ff5312d6d79..d41bd2e9deeb 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -4,7 +4,7 @@
  * Copyright 2017-2018 NXP
  * Copyright 2019-2021 Traverse Technologies
  */
-#include <common.h>
+#include <config.h>
 #include <display_options.h>
 #include <dm/uclass.h>
 #include <env.h>
-- 
2.34.1

