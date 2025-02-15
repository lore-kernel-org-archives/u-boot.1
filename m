Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C71C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 15:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1251B80C6F;
	Sat, 15 Feb 2025 16:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Tfn4G9Li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C9C80756; Sat, 15 Feb 2025 16:22:17 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4A180756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C61A33F27D
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739632933;
 bh=2ylV/wcE0NQAzZlJRtKmyveJ9JaFLrSU05STVmz2NXY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Tfn4G9LiyGxudL0kGapo5754tkaWlHcUi7Un2KO07RfKA9hQZr34LlASexWOO1qu1
 WeqyX0CCfl9zE23PLgfp8bvrhdiQxAG/sopoCRKiphwyEa3A7OsynX9DaPlwaAyyTc
 p0exXvGXFVbGBmQWVb4o6Pu53etHOB3wZyZdbRoWW8L1UEEEsGCjEOlhMXxlQcT4Il
 ZrUeXKi+BgsZBNJyXKveH1Sq7nlcQgzal75HqGI/pjszv3qB52+tzesZDoNOdMhJ3B
 KtCVdWVLoaayD5Xn5fFjhHymLnaUSfrDqRNM+rU14iE37LAhnRMpD1dP6HzpdAWeWw
 m1TUhPXMq64gQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dfede57feso1898858f8f.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 07:22:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739632933; x=1740237733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ylV/wcE0NQAzZlJRtKmyveJ9JaFLrSU05STVmz2NXY=;
 b=VW8qTo3P8CFXA1NX6Ob5ocG8q66ZO2eCA4OHdaZLSz8aKkkashniNur+emMbwiWjMR
 rubgjwR1DbH6/InVe3E/fzJ05npPSREl+mNOy/XhoJVcJVJFpUeWIW1m+rYWWFKBh26Y
 WhyiiWTcdbi8bfM/BKUk8uyJTejpfD/vrK2pVd4u7qcxTbp0t2KWlzRg+AEBtSO6M/mZ
 2qCeKrhteVtkz7aEy9UT62hnd1ZkhhXGMxRf5nmMCdr0nszBD/TnT3JFbHzNRFo3CxuY
 AakeawQW9fCmV0PdvZaGNEe7jNUE8LIBCteawfX7Zkb6PQ0hBE/QXtvb9UCd2alZR9pk
 Je4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFxTT3TjLyn7ylzugcAq6xACbWkXJf3ndZHjUJ9dGbNTMlAwC4ZKRRDCQ71UBfMZKQwEoAQNY=@lists.denx.de
X-Gm-Message-State: AOJu0YwzY1g9LL/uJ50wFf765yWUhmQtSjrMemxUaQkSZt3kLktpje9X
 zUZ1R+8pMg3OU3JaaNvekJ769mqEnHAsQknGkCUxiarmaY/J8cOFSYxGdO/YYLWeY6ocPky8yXR
 aUDUVCRLnphwjkVEhj0EKeWB2iTNflYFsyamatrdDH0MQ8ghIcQMAbw95z6habg9P7Ik=
X-Gm-Gg: ASbGncvB5+3AeQ2U+krFZcO9QBU1uMPkezeLxXcfUlY1C1Y1VObBiGgjlDbhn8wufbF
 BhsIo7fegEcOpS0PaqoR5qfF7Lq1qJU92A/Itc50FpOgKG1TB7aTi/jR7HC+xz55kik4WNJvYlz
 XKId4FmvlPbFtYoEAY1m89rXeh4PnnEARd2WM6SUYZ8pWSEcDCUJ6sZWPtSw4zrrJ18NT5AN+NK
 5AshEF+zIqmAoDHvJ1P9hID/uDCupc3Nj7mLQKRZQ6jsv55LCK9wFRYnr+cQwCLVuQSdMPgssNa
 uTOJxU+Gvkn4oAJPjo/sBTRkG3GAViOivVKNp9g=
X-Received: by 2002:a05:6000:1542:b0:38f:31fe:6d1e with SMTP id
 ffacd0b85a97d-38f33f550f4mr3921852f8f.53.1739632933354; 
 Sat, 15 Feb 2025 07:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzUuqMmbFHVwt1NOHCZhEKgTHbbZmgzN+t51pMAS7AklDA1rc5r+pqu78iJ+Oq609umt983A==
X-Received: by 2002:a05:6000:1542:b0:38f:31fe:6d1e with SMTP id
 ffacd0b85a97d-38f33f550f4mr3921836f8f.53.1739632933031; 
 Sat, 15 Feb 2025 07:22:13 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:4a31:7c7b:42f9:c221:d8ea])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4158sm7402474f8f.3.2025.02.15.07.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 07:22:12 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_driver: create a parent device for all EFI block
 devices
Date: Sat, 15 Feb 2025 16:22:06 +0100
Message-ID: <20250215152206.135147-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Up to now root has been the parent device for all block devices created via
calling ConnectController(). This does not work well together with the
implementation of bootstd.

Add a dummy parent device for all EFI block devices.

With this change EFI block devices are also accessible via commands like
'cat', 'load', and 'ls'.

    => dm tree
     Class     Seq    Probed  Driver                Name
    -----------------------------------------------------------
     efi           0  [ + ]   EFI block driver      `-- efi
     blk           3  [ + ]   efi_blk                   `-- efi.efiblk#0
     partition     0  [ + ]   blk_partition                 `-- efi.efiblk#0:1

    => ls efiloader 0:1
           13   hello.txt
            7   u-boot.txt
    2 file(s), 0 dir(s)

    => cat efiloader 0:1 hello.txt
    Hello world!

    => efidebug dh
    0000000018df1700 (efi.efiblk#0:1)
      /VenHw(dbca4c98-6cb0-694d-0872-819c650cb7b8)/HD(1,MBR,0xd1535d21,0x1,0x7f)
      Block IO
      Simple File System

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/efi_block_device.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index d3c668dc183..070747de515 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -35,8 +35,10 @@
 #include <efi_driver.h>
 #include <malloc.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/tag.h>
+#include <dm/uclass-internal.h>
 
 /**
  * struct efi_blk_plat - attributes of a block device
@@ -118,13 +120,18 @@ static ulong efi_bl_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 static efi_status_t
 efi_bl_create_block_device(efi_handle_t handle, void *interface)
 {
-	struct udevice *bdev = NULL, *parent = dm_root();
+	struct udevice *bdev = NULL, *parent;
 	efi_status_t ret;
+	int r;
 	int devnum;
 	char *name;
 	struct efi_block_io *io = interface;
 	struct efi_blk_plat *plat;
 
+	r = uclass_find_first_device(UCLASS_EFI_LOADER, &parent);
+	if (r)
+		return EFI_OUT_OF_RESOURCES;
+
 	devnum = blk_next_free_devnum(UCLASS_EFI_LOADER);
 	if (devnum < 0)
 		return EFI_OUT_OF_RESOURCES;
@@ -221,6 +228,24 @@ efi_bl_init(struct efi_driver_binding_extended_protocol *this)
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_block_device_create() - create parent for EFI block devices
+ *
+ * Create a device that serves as parent for all block devices created via
+ * ConnectController().
+ *
+ * Return:	0 for success
+ */
+static int efi_block_device_create(void)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = device_bind_driver(gd->dm_root, "EFI block driver", "efi", &dev);
+
+	return ret;
+}
+
 /* Block device driver operators */
 static const struct blk_ops efi_blk_ops = {
 	.read	= efi_bl_read,
@@ -249,3 +274,5 @@ U_BOOT_DRIVER(efi_block) = {
 	.id		= UCLASS_EFI_LOADER,
 	.ops		= &driver_ops,
 };
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, efi_block_device_create);
-- 
2.47.1

