Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDAEC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9898D8277D;
	Fri, 16 May 2025 01:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZQF2T4K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB6D82A1C; Fri, 16 May 2025 01:42:12 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603B682AA8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7302a769534so1339687a34.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352529; x=1747957329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SgPBd4359PIGgGGKq/sA/Gy3Ako/vk+3uIcfHwMf9c=;
 b=ZQF2T4K5e5EU0SQYw2Hrcp+mt8PXKpqWQOxPEvBa8mFXmid7qLdSndILcnnbc975J0
 Uhpcg3mP51UUVn0oDVifJ6L3mW4jouctokJnRyNfxwKB8w8l2QZRQfebUBYqwVz9Ehoo
 n6yUE9pns5psZZEDtk6KkppKsuxpW6ocxi/NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352529; x=1747957329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SgPBd4359PIGgGGKq/sA/Gy3Ako/vk+3uIcfHwMf9c=;
 b=T5KEdHKaLhAK5CO8/01733vVJHn5faMH0fLoOTNUh/tPIfthKV/PFuMUu7haSXRj7M
 vaMVVuWccWtF4/eD7tsxYl38LnJroZLEY9g/ypqbHP0sc7Dot+EUhdIzkJYbE4xscpJX
 I9GIjlMhrcGCQvP6r81E8/4M1IqZ5i9HqB0qwNqqAOn97RmEvD1sfTjN4LRjPH+bJu0n
 KJ4J/tf7WehhPz/aWxCWzKzvW2yWA9tm13S/LlM9k8M5tN5f+OBpn39K9dx6/9/y1s+z
 Bgv3bSayGFuCONTUkVPzhH1xhAxLD1jHZfS2y1LCyzEdGhX46XTRLgwE+XIeMZUwgGo6
 Z0yQ==
X-Gm-Message-State: AOJu0YwC2q/17F+aFqt6ZxM7e5IEPTHflEUXAwsuyLMDWuWA8BWD3Lo2
 o15pbaXOz70SDXMWbzJsH68PNyv+Y/MRxTEs9ZuXKtgi+UzV8iHLGfm7EjhSZM4gAKhnz2mAhcO
 STDCsb58=
X-Gm-Gg: ASbGncs49CZFG4vPrMnayE5w3skuH6tmSxG+NuE7VT7O5yI8JzKoZtL2Qv8tOcjtQoI
 vKCiCCVeKKjn0W4zAP3Wftw3JQ90x70s9Pgm83CBKYwmI99c6hRZb35Keq5zi61JKOt+9iIREE4
 2Q3uocVxXuTGSd6G54yt8ScpQlemcUjp1qjZIX53pYpV4sTPyeInUzxvs4Nw84Az0GXCHvj5sXI
 dl0HZkWSleIa7xlgeGvuwEJMXdtA/J66Nn+qY5rrkdddHafOvClhoim1bawuyvQ/SBVPqvG+Ci7
 rEhOlIL7D4QCht/FpRxFf84mVT0I7g1VYQYqgO3SZ/Bb4uitHgo4d5EK+CpUuoKX6o73/XgdUbj
 jZqVaZqT31PuKTLR/kY1IBikq7A==
X-Google-Smtp-Source: AGHT+IGdH/A4x0Ot3n2hIKOYqWnTZBFOFb6Pr3/9GtEWPJ0MtcGgAu1x4KJyEsaPqpT6OFHXkpnQmg==
X-Received: by 2002:a05:6830:d08:b0:72b:9b8e:434b with SMTP id
 46e09a7af769-734f6b61b0bmr1093068a34.22.1747352529133; 
 Thu, 15 May 2025 16:42:09 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 09/22] toradex: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:38 -0600
Message-ID: <20250515234154.1859366-10-trini@konsulko.com>
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

Two files read from the environment but don't not include the correct
header. Update them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/toradex/colibri_imx7/colibri_imx7.c   | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 7de29e3abfb6..69a8a18d3a75 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -4,6 +4,7 @@
  */
 
 #include <cpu_func.h>
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 9359e0ac6bff..066e8db678fb 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -3,7 +3,7 @@
  * Copyright 2020-2021 Toradex
  */
 
-#include <config.h>
+#include <env.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-- 
2.43.0

