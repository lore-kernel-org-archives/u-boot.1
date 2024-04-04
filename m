Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA295CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 11:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B8888442;
	Thu,  4 Apr 2024 13:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lyqF32pB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E59F883D6; Thu,  4 Apr 2024 13:48:23 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4628843D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3FAE642497
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712231276;
 bh=zK/VfUikrhy0YcMRAaduPdm6anR6ZRrN+eoxOO2hMFM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lyqF32pBcDFqpaCgeUMhFzTh5dE/19iyOdh3YNvUsVpvgl7LIsKFPQWt1XaO3/7R5
 5sKoAlp5L7L5kfa5yXbFX757IfGcu1pSK4JlKWkWiRdbiOU/uGKnUmsRKB/nvmeXL8
 zZl+bKiXr9jH46Flfn3jFfXVFJ9ypFAqzrCwNtg6ZuBhtcf7EzmuhNU8/GNk6xUHjh
 I+DKSsIcJ4H31avXkQCuSPmvlkzby330s6udM7o2QoKPKkIzx3nQifB+SOKhkYoEA2
 hYcmlkHSp52/KJuOtbl5rNcmTBoN3XpWwB/jjeGfLF0+qNkvidhPFhVbYcAqLU5bQc
 hB5Yc8JI5pP+A==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4140bf38378so6425725e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 04:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712231274; x=1712836074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK/VfUikrhy0YcMRAaduPdm6anR6ZRrN+eoxOO2hMFM=;
 b=cA1yEKsOrtpS5fLOu0MS94w7fPCCZJsMx2AxiqG5wQBFEp+YMI+DsbVG/8USXtjvuf
 zgYo9cscIVZhO+/uzb6FGd5opC8A92nv+bj4wNvbk30pZJF5SjgPBBJy62OUt8r4uCby
 gVvuzrTOAc3MHOU+h2+kL4WZiMnXo3TeaAbuz/XwjZOO87un+xH4mGSdw0JUy70tEGug
 pzMalbvEr4WoMfvys7GuDbe4cwfPB+/cmQcRCyjNoboaEff5zzi24m1zp6ryfn8qtEek
 l91vyUAKGqPPIPWX+YRokmmYGefDeIHN5tPqHH9a+M3F8BkCyHmhj8bs/bTfQKKIVvj4
 GXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB7CY1h0vDs0YzZZ0+HGvzRWIyicsvb/+aG+sl7OohokkZpzWsPihSVlTlKytAy2q6oNGeiUo2qV/Et/5YltXWLrZ3Yg==
X-Gm-Message-State: AOJu0YzmbaAcxAKB8L5RceFB/VKxa4dqqhJ+pRCaOzgtPTsyZbzqooyx
 h0DV+CDICmZ8i//amtPOAJ7jBfKGXYbqk6UjbJ/c2W2qPBbn/qHCAobE89poUWlsLeqdvuzCij0
 IK4k2IKFCLHa2a44faNA53+IDnJPo9lJaQ11ZqlIuzB23ktRONnY3KNWgZbxsSDGrD5E=
X-Received: by 2002:a05:600c:3410:b0:414:8e87:306d with SMTP id
 y16-20020a05600c341000b004148e87306dmr2326846wmp.29.1712231274092; 
 Thu, 04 Apr 2024 04:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnk9+CGEIjTNPBKEoYsY2/VfIW/cR0vrm2A6SzDY4y1GdHuvQye2w+bf+z5xJXBBe+7MjUlA==
X-Received: by 2002:a05:600c:3410:b0:414:8e87:306d with SMTP id
 y16-20020a05600c341000b004148e87306dmr2326828wmp.29.1712231273820; 
 Thu, 04 Apr 2024 04:47:53 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00414906f1ea1sm2422134wmq.17.2024.04.04.04.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 04:47:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Bin Meng <bmeng@tinylab.org>,
 Shantur Rathore <i@shantur.com>, Mark Kettenis <kettenis@openbsd.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] boot: correct the default sequence of boot methods
Date: Thu,  4 Apr 2024 13:47:39 +0200
Message-ID: <20240404114742.81187-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
References: <20240404114742.81187-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
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

