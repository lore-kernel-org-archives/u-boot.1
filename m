Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5FECD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 19:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAD98839A;
	Wed,  3 Apr 2024 21:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wSAOUtBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2D08838F; Wed,  3 Apr 2024 21:07:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91096881D0
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 21:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46172424A0
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712171247;
 bh=96bWx8K0fRxfw+q6u4fC+kym8eZ/mRY7xCjInrKG3sU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wSAOUtBnaChky3pJoyhoiSomLHJCbxZVatLYNtq3b6Cjn0qpNLDzkMKsbwjgYZN49
 z+xkjtkWuXP+Ccg/65r4upfyNoOpE9uXlJINtOHQm9oVTtNOcE1kPa7pfNoaD98zfv
 cn4F2JbXWneglF1sx0Kit/s9eH2kXYNOQxr43y6eOTF2QCUgBEnY02r8wbxOhhxtiM
 xQiZBHaeP/xqHpz8oyMnXprTtir4z0hp+78A2ibUYuIeZvDzOgdWGfleUfMr6FXctO
 RJshmMboOQJRvrplTi905fZjU6NqHgOXMfc4DTwm+Hb5LeGlQCoimgf2qzqKeFnsPj
 t1gqus2/E530Q==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3436714e286so81503f8f.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 12:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712171247; x=1712776047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96bWx8K0fRxfw+q6u4fC+kym8eZ/mRY7xCjInrKG3sU=;
 b=l92tC1TyJkROg4U5hnIFqdsIigGHm38rd09MA6zGjEbR4Yz42KPV+Iwk+Db48wZIWY
 OESHLjlUcEVBCVkGQqTNkDrUFJv97CKtn3yRL1tnzg5NKV+tnOEHtwDhxYoeNcIXZKWH
 piqUeiPWhNAz91BNhUN1tEG/8VBNuxyZdqoi+s5FtJhUQR6j+aE8b8FuA19mouxw8P8R
 2Fqq4Xah8ESThbMbT9++7fkP5jZl6rrhENOJNOjNOr2MmQBuX/bkh0BNqLnhDQZb//yt
 krgEiOUS92NHjxoOnduFeqKqO6QXUgWYkO1MDYnqnIYWk7WObDEagUN9iei8VpjmWLAJ
 Mojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMjyPOS10ivkF9XylEofvDh3CmloYn7YjcZx+PURl46C2/koVwGGSHbLAg7tDySDK/lwYccYsRfaOCP5AHnjEfMvBhJw==
X-Gm-Message-State: AOJu0Yx+tBwoV8nQWa7syS8xcBgvsKrAijeSNmroK7ECM2Rq7oEM2p+k
 86RpG96yT5wFqMIKfq3ZEFN6IDXyyFlOPeAqlO87NDLe81OHF2ISbp1uA06k3sULts10PP4VSDW
 aLhwsaTHIFkwo796902iAsC15CW7RDJsz5JE+UDSemdBAIdXi+/6j4iqBsoWwISbJFuI=
X-Received: by 2002:adf:f045:0:b0:341:cf94:3fdf with SMTP id
 t5-20020adff045000000b00341cf943fdfmr276878wro.13.1712171246755; 
 Wed, 03 Apr 2024 12:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGesQ4D0kr2jx0lmrzPpZ+vC6dio6Jj4MpoHX+Re2MbrJyJcq7sssEQSzAbeo21s/pvQ2hibA==
X-Received: by 2002:adf:f045:0:b0:341:cf94:3fdf with SMTP id
 t5-20020adff045000000b00341cf943fdfmr276867wro.13.1712171246445; 
 Wed, 03 Apr 2024 12:07:26 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfef81000000b00341d84f641asm18042610wro.8.2024.04.03.12.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 12:07:26 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Shantur Rathore <i@shantur.com>, Mathew McBride <matt@traverse.com.au>,
 Mark Kettenis <kettenis@openbsd.org>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] boot: correct the default sequence of boot methods
Date: Wed,  3 Apr 2024 21:07:15 +0200
Message-ID: <20240403190715.144725-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403190715.144725-1-heinrich.schuchardt@canonical.com>
References: <20240403190715.144725-1-heinrich.schuchardt@canonical.com>
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

The default sequence of boot methods is determined by alphabetical sorting
during linkage.

* efi_mgr must run before efi to be UEFI compliant
* pxe should run as last resort

Adjust the bootflow test to match the changed method identifiers.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootmeth_efi.c     | 2 +-
 boot/bootmeth_efi_mgr.c | 2 +-
 boot/bootmeth_pxe.c     | 2 +-
 test/boot/bootflow.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index c4eb331d69e..a46b6c9c805 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -489,7 +489,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_efi) = {
+U_BOOT_DRIVER(bootmeth_4efi) = {
 	.name		= "bootmeth_efi",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= distro_efi_bootmeth_ids,
diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index ed29d7ef021..b7d429f2c3d 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -114,7 +114,7 @@ static const struct udevice_id efi_mgr_bootmeth_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_efi_mgr) = {
+U_BOOT_DRIVER(bootmeth_3efi_mgr) = {
 	.name		= "bootmeth_efi_mgr",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= efi_mgr_bootmeth_ids,
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 8d489a11aa4..70f693aa239 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -184,7 +184,7 @@ static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootmeth_pxe) = {
+U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.name		= "bootmeth_pxe",
 	.id		= UCLASS_BOOTMETH,
 	.of_match	= extlinux_bootmeth_pxe_ids,
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 4845b7121c8..e60e9309fa9 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -377,7 +377,7 @@ static int bootflow_system(struct unit_test_state *uts)
 	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
 		return -EAGAIN;
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
-	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_efi_mgr),
+	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
 				"efi_mgr", 0, ofnode_null(), &dev));
 	ut_assertok(device_probe(dev));
 	sandbox_set_fake_efi_mgr_dev(dev, true);
-- 
2.43.0

