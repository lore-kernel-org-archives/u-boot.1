Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A83C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 21:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B664C86E42;
	Wed, 29 Nov 2023 22:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C2aVmWtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68FC8701D; Wed, 29 Nov 2023 22:47:42 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8408986D12
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 22:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bb92811c0so250342e87.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 13:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701294459; x=1701899259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wiW36ofnjzMieBAqC2S7+C6I5EkEfGGbNId1AMhaDDU=;
 b=C2aVmWtKkclnzkiiy+d/MX8cW/cUkBsNjmzqqlxV+RK5hO1JbpR7lo6IOnZPLyyBa9
 K56I2Aq5XrTwRP9AXh4SY3fzKycN2mLS5qqkhARLqSHg/z2XWZXM1DCV7cqYpyviHci+
 2YTW9scQU60CrawbIYuYex+2gryl4ghgQ17KC6VFs5SnIW08nfAJk5nAAMPDclqclzg+
 0hxsV/ST6aHf+gOIfYBfOmnEEIOXHWK1UooyXoaZk0iuJQVnn/KXrwLAkg/aHQlndsUi
 lVpG2T9ZbT9GUiF50x6e7VAv2xUibjStbtleeL/CB+myD+pnk1VaaTEJrm7tq68ltk2L
 EefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701294459; x=1701899259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wiW36ofnjzMieBAqC2S7+C6I5EkEfGGbNId1AMhaDDU=;
 b=stmt2yBiGP/VLSstIZwqg4iZHfWTHLw/gt5CFhPFo1+9+/vmJZAws3MDLnN7in9pT4
 /Eo9KtHdnsxNQNaR069kxDPIcHvdrA/IJSkv3mtdu4I3zL7yqwW2KIfEH6msM4i/lVSc
 rYTGoxWA8hpNHjlvIrO83KAdnt4fhkAAI/1AXWsTS8zpCNn4cCgZsmOnRvzFaFMpruC9
 fy5bqF59OTHhkvoie3QJlAEz+W6qG5iYLV71apnjO/6gBsjFJdrXDSCOJS9cFcBR/w3f
 rxApm3GbG8Ik7i3y8OFjx8NBQWkkSNg+qfstGKyOpSQ4DENZXO59gWD0nWygp8abvJQO
 eTyw==
X-Gm-Message-State: AOJu0YyB/a2/Th0xPnqKhyE3y6PuQ/FIXIgKweHfoFtO1PDDSOHwJ/g4
 NazIcYg36+h0YwTnEawVfkTswHileq4=
X-Google-Smtp-Source: AGHT+IFeM0DSpvWcrLwn97Dz3jGeThKZpIKIVPo7kPnmPc2TntCbVRVkDxDdpQbPWA88LMPF9D4dng==
X-Received: by 2002:a05:6512:1253:b0:50a:a8c1:28ef with SMTP id
 fb19-20020a056512125300b0050aa8c128efmr7363745lfb.18.1701294458760; 
 Wed, 29 Nov 2023 13:47:38 -0800 (PST)
Received: from user-PC.. ([178.134.170.122]) by smtp.gmail.com with ESMTPSA id
 s3-20020a056512314300b0050bc6317952sm2852lfi.274.2023.11.29.13.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 13:47:38 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Maksim Kiselev <bigunclemax@gmail.com>
Subject: [PATCH v1] gpio: dw: Drop unused headers
Date: Thu, 30 Nov 2023 00:47:31 +0300
Message-Id: <20231129214731.756321-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Drop headers which are not used or needed in this file.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/gpio/dwapb_gpio.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index e6e919444f..7a6eae9ba1 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -5,21 +5,15 @@
  * DesignWare APB GPIO driver
  */
 
-#include <common.h>
-#include <log.h>
-#include <malloc.h>
-#include <asm/arch/gpio.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <dm.h>
+#include <dm/device.h>
 #include <dm/device-internal.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
-#include <dm/lists.h>
-#include <dm/root.h>
+#include <dm/read.h>
 #include <errno.h>
 #include <reset.h>
-#include <linux/bitops.h>
 
 #define GPIO_SWPORT_DR(p)	(0x00 + (p) * 0xc)
 #define GPIO_SWPORT_DDR(p)	(0x04 + (p) * 0xc)
-- 
2.40.1

