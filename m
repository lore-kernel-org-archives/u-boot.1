Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E147FCDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 20:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B5288DFD;
	Thu, 26 Sep 2024 22:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jRESXXsk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BC488E4C; Thu, 26 Sep 2024 22:52:20 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B5188DFD
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 22:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-84e8aa83898so458220241.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727383937; x=1727988737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AttoTWeENRWHU8jf/GDPZQZ/uC9UH2gSZ8vjsRTYq08=;
 b=jRESXXskDDV1Lh2roY2b6llJZL8sNusnc0qD7rFaJy0XKHerVnLwyfrjgY2MP7Pc4r
 yQ2AYFTNBhJNPQMmuM2zPH+xvH6dEZ3rhi34oV5AHJ+0a4nHLltRvYM1M+CwjJKbD64W
 5xTmOgNVdITuCXCLND4BnDx6NaOAaK2fQMDY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727383937; x=1727988737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AttoTWeENRWHU8jf/GDPZQZ/uC9UH2gSZ8vjsRTYq08=;
 b=GG7hw7bQDcPLkasxS0fQ72CjsiS9FSFPS9JEwteldQcrIF9OaoXdLs4bYEL2F9BTZk
 RDZWdJGDucIY3+srXZYd3n0sanXUW4p4bB/QOW7u0nnvUqfh0GeyPtPsakssUpAtSc3c
 loM+aii7A+gVKFSrKvZ+KxVkg3kKtgqmwYK7pfPLhkv8s0oxIZl8KtUtkVOPqCajk8yH
 CZk32yXaal3qM3TujEYYDWV7WhNrPMSdDjgGpZW37vF3NgYBVCY0cF9q6FspD0UgC/86
 WgEabITfhY2nhAUGicFcVAGL4pXaVL96U3quttSlEbFxSHUV5eK8bT9RoZ5+gpq1j6xp
 N0gQ==
X-Gm-Message-State: AOJu0YycBXLRSnAn7mpK3q0I8ishmjNUPiUYF75YSmbnDZY+YB62e9Fm
 AKXyLccjYf/TCceN063jKU4pgowxcuOYH8DIiqNgy4io9irMGcc7ayJA9nusdVIEuvGfJk91gOy
 CYUSO2HY=
X-Google-Smtp-Source: AGHT+IG+khMuBS5KluKgsE+zRO/h5jzQrhe9XCB0929hed2c9xDLZU1emCybmPzw2TQlEVuJiXoHRg==
X-Received: by 2002:a05:6102:942:b0:497:70dc:c with SMTP id
 ada2fe7eead31-4a2d7fffe0bmr1064520137.19.1727383936548; 
 Thu, 26 Sep 2024 13:52:16 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66cff5sm2538696d6.77.2024.09.26.13.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 13:52:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH 20/27] vining_fpga: Drop status-LED code
Date: Thu, 26 Sep 2024 22:44:40 +0200
Message-ID: <20240926204455.963584-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926204455.963584-1-sjg@chromium.org>
References: <20240926204455.963584-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/softing/vining_fpga/socfpga.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index 2483fbcf263..50f2ca7ec61 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -8,7 +8,6 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
-#include <status_led.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -26,9 +25,6 @@ int board_late_init(void)
 	const unsigned int usb_nrst_gpio = 35;
 	int ret;
 
-	status_led_set(1, CONFIG_LED_STATUS_ON);
-	status_led_set(2, CONFIG_LED_STATUS_ON);
-
 	/* Address of boot parameters for ATAG (if ATAG is used) */
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 
-- 
2.43.0

