Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3625AEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 232278705A;
	Sat, 19 Aug 2023 23:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BlUC8Fk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AF286F9B; Sat, 19 Aug 2023 23:23:35 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D73286D9C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7911dfc9824so80268939f.2
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480211; x=1693085011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiLbhu71KGzNH8kfAVe/OuHFtd41DSBv1j046t19W3I=;
 b=BlUC8Fk6+V0WoHXKEnEiB+O+XcwQe2rutwpzbBRRcyYFf5uO4PFDG3ulds+KCuCbwe
 9xivR+ZJnW9XTqmGFloKuSv1O4v+D55nxUMAE7eyIQmokvkLRU9sMiRVestrxzznHFXa
 fEOrMITlkbH2+aI+OnHDmQoY7m5BaSdc2qzXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480211; x=1693085011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiLbhu71KGzNH8kfAVe/OuHFtd41DSBv1j046t19W3I=;
 b=TAOcLnqA9/SkClL0J9xyzwfhFIDp3Bg+8AdB00mfAV2qxlXQy08/QURL/ta92Gms96
 moFi7Ub6k4kpnzKdUaPpUQYHT5QM5UrM7d1buctgoP82Rp/WoYx1FIKrDsdE5dFLrnk+
 8EmqHc84R3d1TQsf5ZLgl1/mKaHiV2MUV8FTyMD+fWvVU50uaB3+4+cEqmSIbtl07et8
 JMa77mvcF5thquLQybMbtegwFZS79OS1UJ1rqJKypMSlhHeWjIAfZpVHoejvfNSgTbpH
 hz3Mobz2AzaJ93uKxgfaW/TZCK+0ymwjOHn1Ynn+4UUzCZsXy5Ql5+kKSRZc71WXoXFJ
 q0/g==
X-Gm-Message-State: AOJu0Yxx/roasz9rKtlUTHVe1H7lK3houRdPMh5jYIJswLbUL7T+pORQ
 8RTIBzgrlvxNJX6i6gHeU6nmmH4oYeF3D1UQKGo=
X-Google-Smtp-Source: AGHT+IF37KO+FErN0HvKvXzevlU7pqF/w3gulYu7ca1IHlR+pz4MbVPIOAJV20BEEN6lNH4GaQE2+g==
X-Received: by 2002:a5e:9508:0:b0:791:276c:727f with SMTP id
 r8-20020a5e9508000000b00791276c727fmr3756607ioj.14.1692480211032; 
 Sat, 19 Aug 2023 14:23:31 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 17/19] x86: doc: Update summaries and add links
Date: Sat, 19 Aug 2023 15:22:55 -0600
Message-ID: <20230819212309.1094440-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Refresh the summary information so it is more up-to-date. Add links to
the coreboot and slimbootloader docs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/arch/x86/x86.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index ef6970b88a59..e75b5a73ffc0 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -11,9 +11,9 @@ including supported boards, build instructions, todo list, etc.
 Status
 ------
 U-Boot supports running as a `coreboot`_ payload on x86. So far only Link
-(Chromebook Pixel) and `QEMU`_ x86 targets have been tested, but it should
-work with minimal adjustments on other x86 boards since coreboot deals with
-most of the low-level details.
+(Chromebook Pixel), Brya (Alder Lake Chromebook) and `QEMU`_ x86 targets have
+been tested, but it should work with minimal adjustments on other x86 boards
+since coreboot deals with most of the low-level details.
 
 U-Boot is a main bootloader on Intel Edison board.
 
@@ -31,12 +31,14 @@ are supported:
    - Link (Chromebook Pixel)
    - Minnowboard MAX
    - Samus (Chromebook Pixel 2015)
+   - Coral (Apollo Lake Chromebooks circa 2017)
    - QEMU x86 (32-bit & 64-bit)
 
 As for loading an OS, U-Boot supports directly booting a 32-bit or 64-bit
 Linux kernel as part of a FIT image. It also supports a compressed zImage.
 U-Boot supports loading an x86 VxWorks kernel. Please check README.vxworks
-for more details.
+for more details. Finally, U-Boot can boot Linux distributions with a UEFI
+interface.
 
 Build Instructions for U-Boot as BIOS replacement (bare mode)
 -------------------------------------------------------------
@@ -700,9 +702,10 @@ for details of EFI support in U-Boot.
 
 Chain-loading
 -------------
-U-Boot can be chain-loaded from another bootloader, such as coreboot or
-Slim Bootloader. Typically this is done by building for targets 'coreboot' or
-'slimbootloader'.
+U-Boot can be chain-loaded from another bootloader, such as
+:doc:`../../board/coreboot/index` coreboot or
+:doc:`../../board/intel/slimbootloader`. Typically this is done by building for
+targets 'coreboot' or 'slimbootloader'.
 
 For example, at present we have a 'coreboot' target but this runs very
 different code from the bare-metal targets, such as coral. There is very little
-- 
2.42.0.rc1.204.g551eb34607-goog

