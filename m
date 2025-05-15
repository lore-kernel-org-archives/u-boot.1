Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB92FC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF4E82A76;
	Fri, 16 May 2025 01:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bs6UWTos";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AB88277D; Fri, 16 May 2025 01:42:09 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1A082A9E
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so1099439a34.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352526; x=1747957326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2rK/zC4SBE0i2sgFJtZ03yoyBRuimmQl6ORcC+3254=;
 b=bs6UWTosL14iioGUgldKOoVNxAjSXMjW7g4EmlyFD9DdqKT3FnIGeJOznCTfKz0noH
 qNXhk8yEQLMsDVEVfAuzocejbWRS44WAosv0AVwXp26WB3t5zNGOQZvTl3msM9WPyjrl
 PdZ+OMoSGBfAaax9oMIFQOTOcQyiFxUwSMpX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352526; x=1747957326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2rK/zC4SBE0i2sgFJtZ03yoyBRuimmQl6ORcC+3254=;
 b=sed7HvHf95IIpyb+mpXfQlu8fslwNKkcVYTS5QRoE9zSDHJsdooz4L8BE8fkLekWgl
 m8BDrZu6qxW7W+ccHL1a/gM+ah/g4lF2WvaXcjqXE7kkbXOcMKPS0si5qogsJqTtLPzg
 TbdIpIsWS8ahbuFamO5nqrFzCM4lTxHYc2b47mWx0XdqRBZWwOvY1NuW/tW/PrrGnafO
 HNHust5o7svsDX9HpOeVQwfURCUqqcncH3PuWPCzmDhF/9mL5EsTLU3tKWnxyQlm0r8l
 1wiW5ou+5fTxQk1jdOHt63Fy562qbGu87XzkZtQ/i/h3bPWy9fwU3zXydq24NJjgKeRW
 HyYg==
X-Gm-Message-State: AOJu0YyaEbzrsDzTopGHalNXRakwqGAcYLwUPonkxI7VyqwJz00AJc5m
 SopuVItjUulyvpVYsDAXFUj2rRp+MvUUtnPQewq+dQAW6l3xOikC3N6fP/o5C8AqNbbdCReUSLD
 DIneJak0=
X-Gm-Gg: ASbGncv6luDO0rQEBAFCR44z5kXVxXjFI3mIhz9f6hXTe6oZqovkzSoHnbWBCeDXx6g
 4uzg04EUk/bxuyLU41w1LTKNLS2zgh1XHUawf9f14SwgcISmA/MWQ/96fMKEcQEtQZb+SK/apkZ
 z2t7UOrlI2p4qr/2aB/SMW15awZ8rdZyDCX+esEGWeoQev7MyOvPdiBs+iwtbvponIRlXcfpshS
 TZsng5dZpYPRWfnisHkkkAnUMUb2+UTec/HMyzV/KYokeY0TmYd3bg786+ryjiMrC1tvBsDOatW
 8lZnjVj0lkSe3xzcn2CDUEXT7w+XCK/A+ie7uSoQRpcUEIt+BNgtCu4o/Uetnk51gB4sjrQ+Jog
 yqlmMyBZsRrlnESA=
X-Google-Smtp-Source: AGHT+IHOL++K5XQ4ZcVSX3ppIpmS6OLhyhIlfzLA9RKAquKBgmp9nQbWW2k7ABH9EdVi4qfLm5jZZw==
X-Received: by 2002:a05:6830:18c2:b0:72a:b2a:476 with SMTP id
 46e09a7af769-734ec6a483dmr2933398a34.3.1747352525908; 
 Thu, 15 May 2025 16:42:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/22] venice: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:35 -0600
Message-ID: <20250515234154.1859366-7-trini@konsulko.com>
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
 board/gateworks/venice/venice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/gateworks/venice/venice.c b/board/gateworks/venice/venice.c
index 98b33624f041..f9bcdd8496ed 100644
--- a/board/gateworks/venice/venice.c
+++ b/board/gateworks/venice/venice.c
@@ -3,6 +3,7 @@
  * Copyright 2021 Gateworks Corporation
  */
 
+#include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <led.h>
-- 
2.43.0

