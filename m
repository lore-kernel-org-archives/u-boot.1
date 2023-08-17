Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF65C3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2462886B9C;
	Thu, 17 Aug 2023 19:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nEMmUKvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18D486BAC; Thu, 17 Aug 2023 19:41:33 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C7A86BA2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d733844772eso117135276.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692294089; x=1692898889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DHKboCp3v5H58JmWNvgJfoaa/M57xPqef5954XnYW6g=;
 b=nEMmUKvfEHwAM8H9EWS/JpZ8rqmCxv2s46aLTXWhqygpDDVTVgLP+PKc9N9dt8wvgd
 HBS45ikMg4w6aYtdX2ciNLO6XjTM1XMsFMx8UYiFhc+mDA87YjOt2FscA5ItOezPXgPt
 +0zWAuKAA229fJ2RKXdN895lZIWAhXoqCLjIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692294089; x=1692898889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHKboCp3v5H58JmWNvgJfoaa/M57xPqef5954XnYW6g=;
 b=IZAKIPVc95DhKg7XPo9lU8LV98fJU7jtwoN16H9fgTvQtdx0bDny2GnG6hECJN7ArR
 2iXfWhfKpQYgH2Bu4qWRCl2lQPo9jVh7Ut5N/SlsM94BwPa8UFvsUpB/3y00bCjjARap
 VaKxj5W4iSbqF4BkhKPSBs6I35DRxxwZL1w8Or0m3KZ7JYFh0/0B0uT9MnRe8MfE9YMh
 RYhupiXBFoFqaGUfVh3mapHmir2CCPKFd8V5f03izDuOafWEo09vsptbrCvKB3UNAf6p
 1HOp7EhKQqhcuCBQEP5hJJLIl0InY3rpvuzFvSUH9v3gsxqEyqs1JoCPoe3wUUQubSgU
 bXQg==
X-Gm-Message-State: AOJu0YxHd+C1iFOssc79F/JbC6IwzmoNQIXndH/kXDAZk674nDRDzA2U
 3CEKWXWgf7yOGWKbY+gOqZS+QxDZAPb13hwrEEkqxQ==
X-Google-Smtp-Source: AGHT+IHNFGHVe8KwTfzCeNHwuXt/zJZWM3VKtQaMgPyQu9dOcMoOYthgkq6+Ymw5zQ/sjPi1AA9thQ==
X-Received: by 2002:a25:d38c:0:b0:d0c:3be2:b626 with SMTP id
 e134-20020a25d38c000000b00d0c3be2b626mr204771ybf.30.1692294089131; 
 Thu, 17 Aug 2023 10:41:29 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250d51000000b00d1b86efc0ffsm4099005ybn.6.2023.08.17.10.41.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:41:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/4] ti: mach-k3: Move dfu.h include to be with the code
Date: Thu, 17 Aug 2023 13:41:25 -0400
Message-Id: <20230817174125.369849-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817174125.369849-1-trini@konsulko.com>
References: <20230817174125.369849-1-trini@konsulko.com>
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

Move where we include <dfu.h> to be guarded by a DFU-related Kconfig
option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This becomes an issue with
https://patchwork.ozlabs.org/project/uboot/patch/20220620111354.448512-1-jh80.chung@samsung.com/
applied as now we can't include <dfu.h> without CONFIG_DFU_NAME_MAX_SIZE
set (or we have a dummy value for ifndef).
---
 arch/arm/mach-k3/sysfw-loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/sysfw-loader.c b/arch/arm/mach-k3/sysfw-loader.c
index 9be2d9eaea26..a8edc4a92d11 100644
--- a/arch/arm/mach-k3/sysfw-loader.c
+++ b/arch/arm/mach-k3/sysfw-loader.c
@@ -18,7 +18,6 @@
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <g_dnl.h>
 #include <usb.h>
-#include <dfu.h>
 #include <dm/uclass-internal.h>
 #include <spi_flash.h>
 
@@ -297,6 +296,8 @@ static void k3_sysfw_configure_using_fit(void *fit,
 }
 
 #if CONFIG_IS_ENABLED(DFU)
+#include <dfu.h>
+
 static int k3_sysfw_dfu_download(void *addr)
 {
 	char dfu_str[50];
-- 
2.34.1

