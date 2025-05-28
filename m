Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE5FC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19D5839CF;
	Wed, 28 May 2025 10:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nzgSJsHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2608B839CB; Wed, 28 May 2025 10:26:22 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A563783966
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3dd24c86779so27446185ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420778; x=1749025578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCG6F6lfP/kd/WIlLUdvq94aM/w6NxD+9f3YT0ixgPk=;
 b=nzgSJsHtdB2BDZ85aVShNz7oufFJ581N415tvYE6rnV3srj+GD2/QfVt3HaJcBLMeO
 C/C5Df5Ia7tSB4CgFN2Lgi+JDs1SiIdcTk3etba4W9Vmu+5s/eoaHlQBNlmkByD++NOl
 lpMRAL6fZ43SJ2ZqdQYfernjq/eDH42mzv16A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420778; x=1749025578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCG6F6lfP/kd/WIlLUdvq94aM/w6NxD+9f3YT0ixgPk=;
 b=T/WWZ8pUl1iycWnOZgIHP2tHvVjfTvorucehA7Tw8qKat24YCrSA9ZaADZCsmefH8e
 +OkwurZRSO8YvP1b4YfhQU2RSysYhYnAWRgZlTBNRmIwetyAt1wQ2wA+h6laA0DT5xAx
 kLQDAPHMs/1yZzuyQDytionJ7ae7d8erdVpmO/6Hjn47p/GLs1qX/zmkds8l5XLLC73U
 RA1fy8vBnOAkimqTgH3ycmkvLJZs+k9VNUM1IWEaUyL7YUdFN+3qBAnn0XXHGEdLeShG
 0NB10sJtxaDJQKztiL8MkKvJGrZQtkC0Xb2YW3F4YIgfQRxXFaDZIzEOVTh3cYskCz5p
 a5gQ==
X-Gm-Message-State: AOJu0Yx5du9DSW6kqGb+SxRbk45Tgwz4oRuaV5QtP5+d04X5HVqZhnST
 LLljOCNxip+HWbJ4DRRUX1IrXZrtkODcKVI0+PvOgHDsR9LLoWclG0OHsnC4vHWnnCZgOCVjAqc
 CUUce9rHS5pU=
X-Gm-Gg: ASbGnctQVH3Jby15q8sD7AxBShB6UGGQhI14ZhFXmO0gMABhPXuEdslmVOXhnwljxiS
 +cSPHmAG3owhyAjNbjngC0yC7XZlU5KR83G7e/ZRXyq422ghjhsBwyJ2aKZec0hqXCFkoMKN03T
 35eV5n/plsGvIgoSOsT4vshEiXEjISYZGH/Uf2BWyJxee5IzmwVFKSQhyWuChZ9YrHmM5WW3o2V
 dFTy2d1qzUU4u/1Tpeq4L0K80tTFckF8HCpb93GUCXztghK6yfMrr1Zq5USUqW40r7n4zh+psQJ
 xaydy1PR7hU+aZDldZR7Wg+ALnDugfX2+ie9JzP2O7EweKwH8qr8zFETYh10WMpXSq64GCzyOot
 jjO/5WZgM+5Ew
X-Google-Smtp-Source: AGHT+IEiZacgzg2zN6ukLxc+bMRJ15pY2zE/7273hEp/4CUG1qOpp5Gg/bPSXlqwhMDKqsJAREXThg==
X-Received: by 2002:a05:6e02:2407:b0:3d9:3e8e:60ce with SMTP id
 e9e14a558f8ab-3dc9b74dbffmr153375985ab.19.1748420777841; 
 Wed, 28 May 2025 01:26:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/27] efi: doc: Use inline links for EFI app documentation
Date: Wed, 28 May 2025 02:24:42 -0600
Message-ID: <20250528082520.152391-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Update the links to an embedded style. Also drop the part about needing
to support ARM, as this is done now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/u-boot_on_efi.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 7a1713f7588..f1f9113b01f 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -44,7 +44,9 @@ Build Instructions
 ------------------
 First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
-opt for using QEMU [1] and the OVMF [2], as detailed below.
+opt for using `QEMU <http://www.qemu.org>`_ and the
+`OVMF <https://github.com/tianocore/tianocore.github.io/wiki/OVMF>`_, as
+detailed below.
 
 To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and
 CONFIG_EFI_APP. The efi-x86_app32 and efi-x86_app64 configs are set up for
@@ -341,8 +343,6 @@ Future work
 -----------
 This work could be extended in a number of ways:
 
-- Add ARM support
-
 - Figure out how to solve the interrupt problem
 
 - Add more drivers to the application side (e.g.USB, environment access).
@@ -372,6 +372,3 @@ common/cmd_efi.c
 Ben Stoltz, Simon Glass
 Google, Inc
 July 2015
-
-* [1] http://www.qemu.org
-* [2] https://github.com/tianocore/tianocore.github.io/wiki/OVMF
-- 
2.43.0

