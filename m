Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EEEEE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 22:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC06F86BEA;
	Sun, 20 Aug 2023 00:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TaNR/Euk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A4686BD2; Sun, 20 Aug 2023 00:49:45 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098E086C1E
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 00:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79210064604so51550239f.3
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 15:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692485381; x=1693090181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DXB6qnbXnigbpmPU6Rs7X/HLB8A8OIchZVLZn6q274Q=;
 b=TaNR/EukDXnRgGksomS9CNAh3J6fkNZB6BHZ00hk6ICXKp3855LA83ylsI9hCFX0+U
 Bh+mkZJ2HDSbnZhPDGtiSF+5IORkz8B+FUXpsLbaKJoqREZ4q/R0SO5Ghik/TwYOH7SX
 mIqfhB8jifplVqp6A6N65Z5NE+tPxyfK6dmFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692485381; x=1693090181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXB6qnbXnigbpmPU6Rs7X/HLB8A8OIchZVLZn6q274Q=;
 b=L598S7ILCxnjBPj2rDF4wWBan1U+b+p5THSu0buPb5MqqUKibCJNvmzXItlr4hb31v
 vX1A6Vx3LrAnjeoMiAEXnYso0K2kPDOcEUNvs3sNFkfSy0vhqEs4kIPSTQ1ixHm7/rjt
 zNIwhbsntoQHRz1+LhhdTbZQJWYWRdnuQDylUqagwS9aRdC/eNpLgp5z+jy584iM7A1h
 /NTluf/3xY5znDislyIHY/zful4oiJYw7mmsKyTMDxorfKKb68nHJLngZtByo5ONGo1P
 iPkYMO2IKmywhaziRcMK8V0PAiZVqmNPAT0RQTbVQdXuXln/XIT1qABNBfQr3v0cYjt6
 lH4A==
X-Gm-Message-State: AOJu0Yw9IZOhpMJ1RM4THhcGn/TdP/sqlm1yw6NgjGvw6KYyx4GQRKz1
 F/YI+Mp6zwKyZqygV8NN9FjoF3nIsDCFoa4VE60=
X-Google-Smtp-Source: AGHT+IFLuRczPz7llXXOMJOQZ2wVu5MKmM7NQyckal+B2xxhahwHk/KITPQ+aqO3eG0BvfzzWfBUXg==
X-Received: by 2002:a05:6602:2c87:b0:791:8856:a8e9 with SMTP id
 i7-20020a0566022c8700b007918856a8e9mr6319289iow.3.1692485381458; 
 Sat, 19 Aug 2023 15:49:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a02b909000000b0043167542399sm1431380jan.99.2023.08.19.15.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 15:49:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Da Xue <da@libre.computer>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstd: Adjust the default bootmeth order
Date: Sat, 19 Aug 2023 16:49:35 -0600
Message-ID: <20230819224937.1113614-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

The existing distro scripts check extlinux and scripts before EFI. Adjust
the default ordering to do the same, to avoid breaking existing flows.

Add some documentation, mentioning that this order will likely change in
future.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Da Xue <da@libre.computer>
---

 boot/bootmeth_extlinux.c | 3 ++-
 boot/bootmeth_script.c   | 3 ++-
 doc/develop/bootstd.rst  | 8 +++++++-
 test/boot/bootflow.c     | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 6b2b84003836..aa2a4591ebd7 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -184,7 +184,8 @@ static const struct udevice_id extlinux_bootmeth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_extlinux) = {
+/* Put an number before 'extlinux' to provide a default ordering */
+U_BOOT_DRIVER(bootmeth_1extlinux) = {
 	.name		= "bootmeth_extlinux",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= extlinux_bootmeth_ids,
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index a4050c384dfa..58c57a2d4b5b 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -243,7 +243,8 @@ static const struct udevice_id script_bootmeth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_script) = {
+/* Put an number before 'script' to provide a default ordering */
+U_BOOT_DRIVER(bootmeth_2script) = {
 	.name		= "bootmeth_script",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= script_bootmeth_ids,
diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index 7a2a69fdfcec..4000b950b600 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -132,6 +132,9 @@ above bootdev scanning.
 Controlling ordering
 --------------------
 
+By default, faster bootdevs (or those which are assumed to be faster) are used
+first, since they are more likely to be able to boot the device quickly.
+
 Several options are available to control the ordering of boot scanning:
 
 
@@ -151,6 +154,10 @@ bootdevs and their sequence numbers.
 bootmeths
 ~~~~~~~~~
 
+By default bootmeths are checked in name order. Use `bootmeth list` to see the
+ordering. Note that the `extlinux` and `script` bootmeth is first, to preserve the behaviour
+used by the old distro scripts.
+
 This environment variable can be used to control the list of bootmeths used and
 their ordering for example::
 
@@ -164,7 +171,6 @@ controlled by aliases.
 The :ref:`usage/cmd/bootmeth:bootmeth command` (`bootmeth order`) operates in
 the same way as setting this variable.
 
-
 Bootdev uclass
 --------------
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8a4e090e9bcf..1c91a942e989 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -27,7 +27,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-extern U_BOOT_DRIVER(bootmeth_script);
+extern U_BOOT_DRIVER(bootmeth_2script);
 
 static int inject_response(struct unit_test_state *uts)
 {
@@ -525,7 +525,7 @@ static int prep_mmc4_bootdev(struct unit_test_state *uts)
 
 	/* Enable the script bootmeth too */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
-	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_script),
+	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_2script),
 				"bootmeth_script", 0, ofnode_null(), &dev));
 
 	/* Change the order to include mmc4 */
-- 
2.42.0.rc1.204.g551eb34607-goog

