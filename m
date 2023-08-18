Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F28FC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B0886C67;
	Fri, 18 Aug 2023 02:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VOqdfn01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B4D86C03; Fri, 18 Aug 2023 02:27:33 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E3186C1F
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34ac2e3064cso1353495ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318448; x=1692923248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXs1VkkDWKgWjzcUYCrC3rGNzFi8ZsxfSu4TS/L9Csk=;
 b=VOqdfn01Tvp5yfjR2OJAr1qZ1fsm/980n4VhNCkWIUE4OY+cHW+P7YkibPTIoGlnHM
 MRjlC5amxpp4HLIyRStgk3ELyffRukFuC/ManSb3PYG9c3dQYcpKWACMUaiSstFhIWmG
 vxQfmT079mGUTDiAHqFicTEqWSU/xDoNhv+zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318448; x=1692923248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXs1VkkDWKgWjzcUYCrC3rGNzFi8ZsxfSu4TS/L9Csk=;
 b=cCGBLUlt8Gbxgg0xqjqYISopgiBpOTPg4TgquYTc+HNn5XmyJ+kfZ8y4tVAF/E9HoS
 vzNbLPlenf07XReFVpHLJf5o7TitF+fJnaXqRUI75jqCH60cUc5vaK4e1szKzXOY2P3Y
 RTtHsHGxcVcrQFsZBShc+USlUfvpodjzX0Rd3MRoAV2n/GeFy6FPFvaaqvBoGjcbSUVf
 NoCRPhlCiwV/yMZvm2QhbU19nXexgD5FAxHrDqVi5RL5Vri4gygEYHzt+2XPG+jLLtSR
 5P24g3rJ3VxrtfcgEU8S56IvMnYUHFe0F53lo8aIZpsglp5u9fsiR15XHk4MHyrloBlU
 BOMg==
X-Gm-Message-State: AOJu0YyPojuOA9qyv3ubBOhrmUYo8dlqKZl/Dy2EvoNiYCiWRCSvKib2
 xErKcMI2OzcANnNORp6gW/oxxNqwgNeC8THEeRM=
X-Google-Smtp-Source: AGHT+IF9xd1+HSSgqgxZzg9nGtZ4TxxI/rz28/BY69uswdrh2cF+ax8+Flyo577J9MPH0Q/CZUTY3Q==
X-Received: by 2002:a05:6e02:1523:b0:345:a6c5:1ce8 with SMTP id
 i3-20020a056e02152300b00345a6c51ce8mr1786415ilu.14.1692318448138; 
 Thu, 17 Aug 2023 17:27:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/20] x86: doc: Update summaries and add links
Date: Thu, 17 Aug 2023 18:26:57 -0600
Message-ID: <20230818002706.853550-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

