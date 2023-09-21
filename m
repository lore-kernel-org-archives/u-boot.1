Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF02E7106C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 13:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0744868D1;
	Thu, 21 Sep 2023 15:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fpqwJevP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C15E86457; Thu, 21 Sep 2023 15:38:00 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E891386457
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79f7e7342e3so34932139f.1
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695303476; x=1695908276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpCOEvUtnHBA/wF1y5ux8xD3tEj9UO8ivDAThAFnjqQ=;
 b=fpqwJevPchepVV1hAJ/RRFFK81edsL9PN3QT5M97UQ94WaC28XzpWNUPgU6ejWtvLr
 mS/+P5xCiddUWyxhAP0k/Mg8R1MxbMD9hkLq3v0Jzw4u0qdeBSqgtH+IKnDZtKX++oKE
 VoRpU6no2q+v9rShkxEk+3xEtleJS+BwsSfK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303476; x=1695908276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpCOEvUtnHBA/wF1y5ux8xD3tEj9UO8ivDAThAFnjqQ=;
 b=dqzugNiEH/234kge711biuxZgE3BrzrUTLnuVYkFDkTyej9xm5rVsmWIez4Fkcsgc7
 apqqMloMW1pAwg761XFyzHokmxeYYtOpMGbbh5+ZE36g/zW/cS8++Rugmb3d8CUUPtvy
 FAwUrdU+Qzf2jf8qB1LJRo8hwopsKKSWQGp64pxzrdr/D1/vcsNvlhsr6DLXxJmrGiX8
 tKScWLOt1JYqXDo7QObELoF+LIbPioarCttx9W2Y6qnwY1dnF5mwaXSb0djdwHm+8UTI
 JLj8aL/OKeHZkcFqUeOgLDQ1anH9dvcXcQXtL8t24Jp8OhQlAQmQaHNJt3m7N8H9I/fV
 lpMw==
X-Gm-Message-State: AOJu0YxYbPLs9zi7si0JFUBz2F33LlzAZTz+nokscAe95GM8vl50TqmT
 RnImubSgNBAx2GHzA8FYB5iq8Kptikcdnt2ZUMM=
X-Google-Smtp-Source: AGHT+IHR/Hz8jwjPHvuRiai8kJvH1g/yVfN3qTVoAGxLzroOR0ZPNAGTaPRwWUbMBEIZOG3m/mnsiw==
X-Received: by 2002:a5e:850c:0:b0:791:60c:4b4f with SMTP id
 i12-20020a5e850c000000b00791060c4b4fmr6284871ioj.17.1695303476530; 
 Thu, 21 Sep 2023 06:37:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5ed611000000b007835686237asm389786iom.27.2023.09.21.06.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:37:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 3/3] x86: doc: Update summaries and add links
Date: Thu, 21 Sep 2023 07:37:45 -0600
Message-ID: <20230921133748.1543007-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921133748.1543007-1-sjg@chromium.org>
References: <20230921133748.1543007-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v7:
- Drop patches previously applied
- Rebase to x86/next

Changes in v2:
- Add new patch
- Add new patch

 doc/arch/x86/x86.rst | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 3525ae8e27af..f67216d6ce02 100644
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
 
@@ -32,12 +32,14 @@ are supported:
    - Link (Ivy Bridge - Chromebook Pixel)
    - Minnowboard MAX
    - Samus (Broadwell - Chromebook Pixel 2015)
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
@@ -438,9 +440,10 @@ for details of EFI support in U-Boot.
 
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
2.42.0.515.g380fc7ccd1-goog

