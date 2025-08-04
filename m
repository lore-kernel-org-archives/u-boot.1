Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC139C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B72D83D40;
	Mon,  4 Aug 2025 23:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cubf7sAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9683083DF7; Mon,  4 Aug 2025 23:51:16 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D45E83B1B
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-87c32f46253so109672439f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344273; x=1754949073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7JUFio1PkM3GtTdxFbtkLuEZXCsclMNrSbNYcN38qCw=;
 b=Cubf7sAyf5sjslaD55nxPp4DeOWppoIghVgC83g+Kf4CWU9vZnHPLGl9SxlThGQP21
 D5KHtT2sD/Zyewxra/5QWBZYdTLoVX6lwFcsmvlo84u0347MhYniexhVrPFgWGThbCza
 AtZ3wpU29TWFbExNEVINg6635N58tHyuHQPhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344273; x=1754949073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JUFio1PkM3GtTdxFbtkLuEZXCsclMNrSbNYcN38qCw=;
 b=H+cM8Ua3WZxKeJdctcswZzzd/Z0zUlHqoHlg3BTej69QQvWfQWYU3PVOd6X6k89oae
 42CbdkJFBVCF/xyX5mW/LionPNnlGIWHbLKO+7M9Rqcd0rsAnPaKb41mdOwCnr2ny4EI
 VJX//PB6KGZk/g8aZQRmGVBGWnwnyi4C32z/unmrFzf5BeW8oxk6ldeuBtK5ZSRYvkQm
 d18qDo4Hv4SdoOsVg8reYqtDMTWlFIzcoLI3eJUBiXKVtfNNRjlJ66e+lHemJjmu5JQK
 z9rb4pjDfVK0Beyq/2kLxP/k/eJ7FzJYntUTkTY8ie+Sd4DUtKm8s6dqJ9X5ErjhRenm
 sP5Q==
X-Gm-Message-State: AOJu0YylCUqF3QUZad4QoQCA+6jIjXQL9+J6Y4I/74Gjau3UZU8AZpou
 8VjMI6BS56VhNbGiXtMadT9/76RDtfMAz0cPJAKsHB3Y5P+UDaltuGhMcsOldBmFypaA6W58AOu
 mra09r3g=
X-Gm-Gg: ASbGncuRywz/cOCPHpj1mzN2ib3EIoAZZUnsdjMiyShews9V0zB9vYRhzAnHwMuWYKA
 NIHwjtKeHf8VcbxQ3XEQUi0b57WWg1KUibG52W0qVvwOnOhsm3izUKhbsKIqYlxYy3L6zME+WAY
 PXWZCkgD0i3ncABhyY7OjDvD029wHWX2AqDpVPR39vH8oSZMYarg+h7//UG1/2n1BSomFQ8zynY
 Urc7KQc+dtaDRKJsLw7W9hdGyrNdj+Yr3L44awOTPa35wtrbcQdVbqQHyJX+XaB0AXIDzLfuZr2
 icC1NWv2oFP0z1nGxlRq7pgxIAQ6gcqwRB0XkwFpG/qvK6U79carVUh9lMuct38uLjwcuXBoy1+
 ouni/irOdN2jXyqipUOq42AK3PvgJ0Xtii7o6UO7QjL4PE4OXFMXMCFZCGGpbsZ/fK05uHwXDWP
 iwfbQ=
X-Google-Smtp-Source: AGHT+IFpRno7ENBFs/yhZ3qpIrxsHfxWDITT18ephTxd1etdg7mNDxhmerxLlZZ+Y+uqoTonf0dk+g==
X-Received: by 2002:a05:6602:6d19:b0:881:739b:e575 with SMTP id
 ca18e2360f4ac-881739be8eamr1763369939f.14.1754344272852; 
 Mon, 04 Aug 2025 14:51:12 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50aa25a394csm942005173.105.2025.08.04.14.51.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:51:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sm: Rework the Kconfig logic here
Date: Mon,  4 Aug 2025 15:51:11 -0600
Message-ID: <20250804215111.1412197-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The symbol "SM" is a library symbol and should not be prompted for. It
should be selected by the drivers that use it. In this case we need to
add a SANDBOX_SM symbol for the sandbox driver. The meson SM driver
cannot build on other platforms, so add the appropriate dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/sandbox_defconfig |  2 +-
 drivers/sm/Kconfig        | 11 ++++++++++-
 drivers/sm/Makefile       |  4 ++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 0c030f4a7925..3ae198e448aa 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -320,7 +320,7 @@ CONFIG_RTC_RV8803=y
 CONFIG_RTC_HT1380=y
 CONFIG_SCSI=y
 CONFIG_SANDBOX_SERIAL=y
-CONFIG_SM=y
+CONFIG_SANDBOX_SM=y
 CONFIG_SMEM=y
 CONFIG_SANDBOX_SMEM=y
 CONFIG_SOUND=y
diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
index 926af2863308..8e500ed2ede5 100644
--- a/drivers/sm/Kconfig
+++ b/drivers/sm/Kconfig
@@ -1,8 +1,17 @@
 config SM
-	bool "Enable Secure Monitor driver support"
+	bool
 
 config MESON_SM
 	bool "Amlogic Secure Monitor driver"
+	depends on ARCH_MESON
 	select SM
 	help
 	  Say y here to enable the Amlogic secure monitor driver.
+
+config SANDBOX_SM
+	bool "Sandbox Secure Monitor driver"
+	depends on SANDBOX
+	select SM
+	help
+	  Say y here to enable the Sandbox driver for the secure monitor
+	  uclass.
diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
index da81ee898abf..5ac947350bde 100644
--- a/drivers/sm/Makefile
+++ b/drivers/sm/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y += sm-uclass.o
-obj-$(CONFIG_SANDBOX) += sandbox-sm.o
+obj-$(CONFIG_SM) += sm-uclass.o
+obj-$(CONFIG_SANDBOX_SM) += sandbox-sm.o
 obj-$(CONFIG_MESON_SM) += meson-sm.o
-- 
2.43.0

