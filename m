Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5B6CF6BE0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCC88404A;
	Wed,  7 Jan 2026 01:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e3AE7JjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85D08404A; Wed,  7 Jan 2026 01:32:51 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B3983A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65b3d3ac90fso544285eaf.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745967; x=1768350767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iK+Jv/WJKKh9XYXmIqugIrNMSdqMzhnQMc0bTA0sId4=;
 b=e3AE7JjIR2+HQshb4IvagrrxSYLAGpofFfTCTLq77hC0LPiYzvUCRKg9H6flbwQBmb
 A8hPQWmgpb7mB6VIkpRVr/qhV6CG13YLeO/EcBeZ4XRjDSoBvDt6oz3R9V0vx/uQ4afW
 8zwfb/mW5V1vtq04F/LaQEbFsnf44pbkDqol0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745967; x=1768350767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iK+Jv/WJKKh9XYXmIqugIrNMSdqMzhnQMc0bTA0sId4=;
 b=df4bQgo17fjaHH5uWaNO6pDX3C5eQmckQX7/5w46pwcq9C7gqTHVn9U18YVroIbXJy
 YbidVfNCFyPDrCCEZcXKkqDrw5Se7CBSz7QVMCZHUMusHLMrYsqwOzzfE3P5Fldzj9Hs
 9uWi4S4aAvtYrX41VkFsGytD2MPJqCojjoQNTafwhrqebthD5yG+BnM4609vYG8BIl8e
 j6g0GNo3OeMLsO21lEjdJiFQqb/B+lAWx+tU+wpisp+4+EdycuHUFI/F+A85vXoK5MVR
 hCBdFGLDoTsmcqpWYVBHTmQ5zIoMIEYe2dqxzaniPxbMp1FriJ93xpCWw8SNxlhVcVLv
 IJww==
X-Gm-Message-State: AOJu0Yxo0y63e32v/s6qqAzTa4iRSk5yMbwoGiEW20CWp+Go/q7WYaul
 X0j4RCXGqnLWBtqmoOdri4vrYIgZEpwMStRzsDQ264+HWqeD0bSzg1Az1NlsqNKlbzy/XyFmYh7
 BLZg=
X-Gm-Gg: AY/fxX4Wq6OmGRBlFYHKF3fwSG9yuMxS12PBijlzh6/6b3DBrIoMNVfnqCfGexKiZ9J
 KW1iSGK/iIEe6Ea5cosMqtMPjAW8rFsdiyyYxKUIXPcPQ2NkqGLEMrZEiB3LH5I83rje4hcBAkW
 mFHmFqTbx0elh9CVxtajy+m4GnfUbj6FMsaj783aNApBJoYi0UPAzLx/1qePlqsgB3J9MX9Izft
 kMAEugIz3kTEaIvIEpGx295rzpnprI/ZY9aIpPPV48oXkLHuQadLl7skpIDuI/Hi2HApaYDPTlS
 A73K2G8Do3QIcFdIbpsK/bXYVpsnHIH8e1KaHzG2uYZ40KKXQyllo83AIRRgJdql2KiG4nXzFQi
 M0G2RPeLCtnD3wS9eEEAt+V8NZAHkVfZGFenT4N0nzTYUa0MSs4GnzeFMmYhFHtTEMV5XedA3hO
 LN9bXcVflM/WZE2dKP
X-Google-Smtp-Source: AGHT+IGjQIXtrFxx15PyD+FA02Sh/6p6ysH1/34gPtBeP8+FoDYqyEpn7+6aKjKm3F6yt1OI5/IE/w==
X-Received: by 2002:a4a:cb10:0:b0:65b:38e2:33b5 with SMTP id
 006d021491bc7-65f54f7b279mr228185eaf.49.1767745967133; 
 Tue, 06 Jan 2026 16:32:47 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Raymond Mao <raymondmaoca@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 09/10] efi: Drop EFI_GRUB_ARM32_WORKAROUND
Date: Tue,  6 Jan 2026 17:31:26 -0700
Message-ID: <20260107003131.3064800-10-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

This work-around dates from 2019 and grub 2.04 which is quite old. New
builds of grub don't have the problem and old boards presumably use an
older U-Boot, so don't need this.

Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 configs/mt7623n_bpir2_defconfig |  1 -
 lib/efi_loader/Kconfig          | 10 ----------
 lib/efi_loader/efi_boottime.c   | 26 --------------------------
 3 files changed, 37 deletions(-)

diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index 404380558f2..d75168a72ed 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -13,7 +13,6 @@ CONFIG_DEFAULT_DEVICE_TREE="mt7623n-bananapi-bpi-r2"
 CONFIG_TARGET_MT7623=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x84000000
-# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 13e44be1d06..5585c841c27 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -505,16 +505,6 @@ config EFI_LOADER_BOUNCE_BUFFER
 	  hardware we can create a bounce buffer so that payloads don't have to
 	  worry about platform details.
 
-config EFI_GRUB_ARM32_WORKAROUND
-	bool "Workaround for GRUB on 32bit ARM"
-	default n if ARCH_BCM283X || ARCH_SUNXI || ARCH_QEMU
-	default y
-	depends on ARM && !ARM64
-	help
-	  GRUB prior to version 2.04 requires U-Boot to disable caches. This
-	  workaround currently is also needed on systems with caches that
-	  cannot be managed via CP15.
-
 config EFI_ESRT
 	bool "Enable the UEFI ESRT generation"
 	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0bc66ee61a8..c31ee53cde6 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2139,29 +2139,6 @@ error:
 	return EFI_EXIT(ret);
 }
 
-/**
- * efi_exit_caches() - fix up caches for EFI payloads if necessary
- */
-static void efi_exit_caches(void)
-{
-#if defined(CONFIG_EFI_GRUB_ARM32_WORKAROUND)
-	/*
-	 * Boooting Linux via GRUB prior to version 2.04 fails on 32bit ARM if
-	 * caches are enabled.
-	 *
-	 * TODO:
-	 * According to the UEFI spec caches that can be managed via CP15
-	 * operations should be enabled. Caches requiring platform information
-	 * to manage should be disabled. This should not happen in
-	 * ExitBootServices() but before invoking any UEFI binary is invoked.
-	 *
-	 * We want to keep the current workaround while GRUB prior to version
-	 * 2.04 is still in use.
-	 */
-	cleanup_before_linux();
-#endif
-}
-
 /**
  * efi_exit_boot_services() - stop all boot services
  * @image_handle: handle of the loaded image
@@ -2245,9 +2222,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 	/* Patch out unsupported runtime function */
 	efi_runtime_detach();
 
-	/* Fix up caches for EFI payloads if necessary */
-	efi_exit_caches();
-
 	/* Disable boot time services */
 	systab.con_in_handle = NULL;
 	systab.con_in = NULL;
-- 
2.43.0

