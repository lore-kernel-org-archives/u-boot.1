Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C387C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F82788C29;
	Wed,  1 May 2024 04:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JM/eYXul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA9E88C46; Wed,  1 May 2024 04:45:21 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4776C88C36
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7f3a5ab6a18so58021241.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531518; x=1715136318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrEDE3NRdycIvbhWqVdn2/bjZgCrfoeiFHHa2+useG0=;
 b=JM/eYXulntMlUAZrPsCO7DQVkwCBOzqc0wczPUebCiXSnjLBgi6an0MWED8RPgspMT
 4ZZhpH5uXWntcPp4Jsxy1Bx4e2hOOkrhh73SSXIgRgJgkW+dUsWBhhUPNKYFMl38YoHz
 Esn6/V6udCCKhm3eQvMVFE+wTyneSVW1Ybj2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531518; x=1715136318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrEDE3NRdycIvbhWqVdn2/bjZgCrfoeiFHHa2+useG0=;
 b=Yj92gdYYFBRJsKsdv7wQXJ9T5htkOUyTFdg2Yp2Za9gdinkx/maHsyFIQi32SDf7/i
 IEWMN3adh15V+Td6HytqV+C8jjv2r4Pjh8HQ01o0Op+Z2Tm4uWZICxQSwryZbfgtGyas
 pWXEuUK+G21cxSp3ZW9PQDhF8zt58Z9asHNlH/0uxLwEf/UoI/mpwDzCQL9pd0IjBVMY
 M8GLvt/AF5szA0fvUfwddpAbNxVottrzM+gGso6yiOhIcIC3PtVsu6sCmt2kBBczFEw+
 O66dSQ1xCeQHe8UrPsGoEZp6M87UNvPxtTj7PtfMV+02qdtGz+8xf/8qwSK48PdBPeGs
 e1qQ==
X-Gm-Message-State: AOJu0Yy6ySuS6yXR18Ko54VHHY38JDClNrxUDULksnpfa9UWzxMv4orN
 npCOkKIswiPeVuh92HfErkcFXY9R6gYxPNq6UWtN2h+taQwrWXyNZ8ufXckVuNO+6Kxv9Yyadmc
 xKNP4zCTb
X-Google-Smtp-Source: AGHT+IFE8ei9tSvFLEReYDKgagcRoyCFeqSzrFo+hyUu22WtXE7IDTl86pxEZni/oAW/or6DBE2yVA==
X-Received: by 2002:a05:6102:3b8c:b0:47b:d5e6:c980 with SMTP id
 z12-20020a0561023b8c00b0047bd5e6c980mr1611719vsu.6.1714531518002; 
 Tue, 30 Apr 2024 19:45:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: liuhao <liuhao@phytium.com.cn>,
	shuyiqi <shuyiqi@phytium.com.cn>
Subject: [PATCH 104/149] board: phytium: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:31 -0600
Message-Id: <20240501024316.1767971-104-trini@konsulko.com>
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
Cc: liuhao <liuhao@phytium.com.cn>
Cc: shuyiqi <shuyiqi@phytium.com.cn>
---
 board/phytium/durian/durian.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/phytium/durian/durian.c b/board/phytium/durian/durian.c
index 0a4048d4982f..01e210fcdd15 100644
--- a/board/phytium/durian/durian.c
+++ b/board/phytium/durian/durian.c
@@ -5,7 +5,6 @@
  * liuhao  <liuhao@phytium.com.cn>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <event.h>
-- 
2.34.1

