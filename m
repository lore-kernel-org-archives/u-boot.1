Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A893DC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644188651F;
	Wed, 23 Aug 2023 23:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MSYE19pH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 018F8864EE; Wed, 23 Aug 2023 23:11:26 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0DD855CE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso15563139f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825082; x=1693429882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9X4lgXM2JdtRw5Iqsuat3dzIVkkmpWgcAR+78cxZi2g=;
 b=MSYE19pH0yOT/Stz9kZeTeaMVUs9dhEpO2g0co+rzR3YyemKj10j6HZRxwo+wI18CD
 GbecX6Eeb2GSd56PwklVlT/sbTz39qw+vB+NUK9uxlmnhY6kFWSc5hks29nHYEz05RFE
 yAc8oOvBFrOi/OBEruKrlr0ybXI0i/HC59Jwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825082; x=1693429882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9X4lgXM2JdtRw5Iqsuat3dzIVkkmpWgcAR+78cxZi2g=;
 b=FfAXh1gpMEIIfoFKSa2DbYRalq4dTlw2dkjK5ztf3+RGDA7SO8fo2BGuY5pry1+nVG
 KLRVIrSnNt+Wy2dVDu+6ron0JK9Cg01c3h4JHCgQS/rw/W9domF3p3pUDxSO7FPNzKZp
 w1uQF6pMBhNDY3jz1BwD+H6pB9z4uR/kGVz/I0tmN2RMuOSaJ2deY9UQCLA0ZJsyTCw8
 +OhYK2AnlqKgXI+D2SQZLe50boWQGCTeUCgm8LHTv2Snj0lC1cItrzJRL2CaJfHLYJkx
 r+RvysrTOB9Yii9C1DJfeWaQQWzjFZIuxMXARwYIEaswmPQVNOxHDAdQypaxDEH+kRgL
 w+fw==
X-Gm-Message-State: AOJu0YyVnvNoEhHirmc854ID2BG2dUqe/Jzgrt19OzMI84xMJejrOlau
 in3GBg8tCIntaUXQMz9dA6mscDQ+SBaYdak0woM=
X-Google-Smtp-Source: AGHT+IHyRYyz2bfX3qDQ898WEmui5tCfQhBst1d9I4o3PDjoiIxneznoyUTxHNowMHz7zY/bQP0wPw==
X-Received: by 2002:a6b:7f08:0:b0:790:e61c:60f2 with SMTP id
 l8-20020a6b7f08000000b00790e61c60f2mr4071617ioq.10.1692825082539; 
 Wed, 23 Aug 2023 14:11:22 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/20] x86: doc: Update summaries and add links
Date: Wed, 23 Aug 2023 15:10:35 -0600
Message-ID: <20230823211059.1235147-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index ef6970b88a5..e75b5a73ffc 100644
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

