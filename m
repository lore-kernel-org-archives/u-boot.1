Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629ADE95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6943886F82;
	Sun,  8 Oct 2023 01:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iDVF8QI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC3C86EDB; Sun,  8 Oct 2023 01:14:47 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 137D286F28
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a26fbfcf8eso138924239f.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720403; x=1697325203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c5GXe/IapfLR/XcwmMUH9fUDCn72qO95akcuGcm8OvM=;
 b=iDVF8QI4Y8ZRR7CWepJzZOGnzGIF8jB6I0Zj24cec8WmUyGpGZDyffSmMXzCAK8LmG
 FF3TdRbi4Hj7lj8lAY0CRmmQ338+W9ZPp5UBB5/YB1D44YNSIJMSQVIN5RPgNjnubXb4
 X1onwt1qbZThuyNsM/P5+FTn6KWpDpH6rwQAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720403; x=1697325203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c5GXe/IapfLR/XcwmMUH9fUDCn72qO95akcuGcm8OvM=;
 b=OhC2RkWjoX+bUBgYEJI8wEwHWJlLzAtvut1EhM0jF4bIJ7MdE7cVQLaBfQqW/mSiJO
 V+f9bQy+h+wmSYVn4ExmvBPcTyHYQ4oyG5TyECFbMgN+iVWSYIk6O8BHvbM/pd5WCbE1
 OqPM6p4Gqmysmb45+3xdNADhYLBiDXAjEYa3Mgx39a1bPAsnNNgiKu6i+Qy+t20jAi4P
 O7QBpMlu6Oe/S3o6DJyP6i7WNUqymeLJOHVZbgLlQaQD0qgCnaXO3eAK1snEbheUuxBV
 2HaHC9cLbxwi7PsNlhpgUeGeWbZwPnrkSEVo8AOcd/6+EJNGo5OBwmjWGMBnRaglX82f
 zhyg==
X-Gm-Message-State: AOJu0YyTgjs8Yw7jqc+0L9aWCeLnFNlF9l2aFU7H5E1M3Wbt7Xjc1eCg
 4AVmwqS+7aOrElS7njgC2rjAXl4cqhXE/deamto=
X-Google-Smtp-Source: AGHT+IGewAxpigYYUchsj0shqYVjHrxn7oplYFFxz/fKBeseADsagri+Ms5xxi9alwkXQi6wOu6gdA==
X-Received: by 2002:a05:6e02:1bcc:b0:34d:ee49:5114 with SMTP id
 x12-20020a056e021bcc00b0034dee495114mr14045954ilv.23.1696720403646; 
 Sat, 07 Oct 2023 16:13:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/27] sandbox: Avoid requiring cmdline
Date: Sat,  7 Oct 2023 17:12:43 -0600
Message-ID: <20231007231255.277623-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

(no changes since v1)

 arch/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 19f2891ba1c5..789be7a9f1e8 100644
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
@@ -167,6 +164,7 @@ config SANDBOX
 	imply CMD_IO
 	imply CMD_IOTRACE
 	imply CMD_LZMADEC
+	imply CMD_POWEROFF
 	imply CMD_SF
 	imply CMD_SF_TEST
 	imply CRC32_VERIFY
@@ -208,6 +206,8 @@ config SANDBOX
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
+	imply SYSRESET_CMD_POWEROFF
+	imply SUPPORT_EXTENSION_SCAN
 
 config SH
 	bool "SuperH architecture"
-- 
2.42.0.609.gbb76f46606-goog

