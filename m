Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCDBCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6E686940;
	Tue, 17 Oct 2023 00:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWXqT8Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBC986F72; Tue, 17 Oct 2023 00:33:47 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944B986F52
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77409065623so291629885a.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495572; x=1698100372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mczZej4UF/QBH9KgYkCrATlbVmMqixT05dVI2GDeY0=;
 b=MWXqT8Xe8ua3blU1vKTpj0Zj6rweheJrFOseSqRy7ZbZIbCQxOup7k+bE1r4pU5UZr
 eDoaVV/ewU90X3f0nIG7XvPfJV788Kxg6GIRvHxGY0N7y3V7BX2OMvbw9mi18w2qlcNz
 HEBycfuZQWwY0s4u3ZbawtS/mqdSNVvvGWHPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495572; x=1698100372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mczZej4UF/QBH9KgYkCrATlbVmMqixT05dVI2GDeY0=;
 b=IvzohvpbD6K32ld2dLd4mvtzJlPM+reONfEUZQ7Pk8YeCSF4BfQAU7BnXx/eSHhzqU
 uHV+4OUps2XbpRvf3D3qjiwJjwIPvx2dRNHMvelvsvaxjDM/iPyu16rxQyXGSA8MXab2
 ceZwKWbSvkjCOU3WTi06nb+BluxeNSoymD/jX2B59dlDnfMjzoeRU2Ma1yjst7ubnsma
 pYl0H7pyN8g+jXh0VJBkzhZ3KYTYuxcSjjb7UG95KFBMHSFaUqDwJZ31p7cMhesqy6fg
 URMgQuhXyuUXE8ey9lP7z6NtjYxjgfWL02+drQuJiG9X2+9w4aqS5CybnMdUaNwZMhxl
 9FxA==
X-Gm-Message-State: AOJu0Yyit17w3g0Bx324tcYbwctR1MyNyB72N4Y1IcVaX4maQIrvAuzi
 TNd6W/yxfv71vngr5OK8emiMWC20u/WOhLWXFIJNNg==
X-Google-Smtp-Source: AGHT+IFTmg9b7nt5vSyHjlb1e2fo9G+pB13O9TBs4ajkZ9DuJB5VtSELdfj5r8STgDUqnr10LQqjTA==
X-Received: by 2002:a05:620a:44c4:b0:76c:e7b7:1d9d with SMTP id
 y4-20020a05620a44c400b0076ce7b71d9dmr616455qkp.27.1697495571881; 
 Mon, 16 Oct 2023 15:32:51 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 28/32] sandbox: Avoid requiring cmdline
Date: Mon, 16 Oct 2023 16:28:19 -0600
Message-ID: <20231016222835.596572-29-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Use 'imply' rather than 'select' for command-related options, so that
it is possible to build sandbox without CONFIG_CMDLINE enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Reorder the Kconfig options a little

 arch/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 64d0a5548942..e85134e9346c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -134,7 +134,6 @@ config SANDBOX
 	select ARCH_SUPPORTS_LTO
 	select BOARD_LATE_INIT
 	select BZIP2
-	select CMD_POWEROFF
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
@@ -152,10 +151,8 @@ config SANDBOX
 	select PCI_ENDPOINT
 	select SPI
 	select SUPPORT_OF_CONTROL
-	select SYSRESET_CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_EXTENSION_SCAN
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
@@ -167,6 +164,9 @@ config SANDBOX
 	imply CMD_IO
 	imply CMD_IOTRACE
 	imply CMD_LZMADEC
+	imply CMD_POWEROFF
+	imply SYSRESET_CMD_POWEROFF
+	imply SUPPORT_EXTENSION_SCAN
 	imply CMD_SF
 	imply CMD_SF_TEST
 	imply CRC32_VERIFY
-- 
2.42.0.655.g421f12c284-goog

