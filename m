Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C8EC54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 12:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531D482A59;
	Sun,  1 Jun 2025 14:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YiuR489d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6402282A76; Sun,  1 Jun 2025 14:04:15 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA0682A46
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 14:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3dc729471e3so9984475ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748779452; x=1749384252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R4qWYvx7lfl6osCdTLB6G006LJIHBilFtoJbYWU6978=;
 b=YiuR489dw4QmcdVA1jrBUpBJPe4g61x8/MXemXO1ijs5N7WknROLx9aPr4eJO2N+X+
 z4zdA0AVVDYL9rpfSDpurkhrwvyah/auL0+oMeopTdhj3KLoF3cSSgrrV3MGNTCP/f81
 BYiptM2xJNOZxGqwQWwSAPiUXwwavUuGFrYVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748779452; x=1749384252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4qWYvx7lfl6osCdTLB6G006LJIHBilFtoJbYWU6978=;
 b=e+554vNKocUr6tBuv2QaYFuz68QylAeErsV8tvB+AEZKpY1dNoSN2JuP72Te/VTf5T
 G4a+5odJ/psumK5TDEdpI2WLCc//ASG5S7YETbfIigSaBzgXUbFeZ7LaNVgoII9VKK5B
 kUxzoEIDc4dAKVrKTkgpKunpUnfovknBubtxtqmoyoKwfycqFIHyqKaw6xIDylfEESp1
 2PZddb+/HaD8nvbql5UWvMEUjZWR1TlBwTt83cFxZdA7+KQaxk/GKaODglwS5fPpGuHN
 MpjO5txQfYj6YOyyE8MHVtUzxVu/QpIi6uF9+4zcxq4i2xWGPE6hgkuEt7KxNW68DcWx
 8Gbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlauLImq/pXoIplwRRgUgD4tAUABQr5y/TrSDWa7eZtaIIFWyW9+e7LaYs+vVeroogy+UtSEY=@lists.denx.de
X-Gm-Message-State: AOJu0YwuD0BQz7l8RAW11OM3VPN5vNsutcPIiNBt909a9kDNE1b6Vanh
 XKrPkqEuaKcfX2K49/tOP0cedSMYGNte6tNHqdPzd4qQ0K8x8Rr96ekYlyZ3nLypqQ==
X-Gm-Gg: ASbGncuZjbYR4BSUzYa2ZCUhbsC2Uw1xWBQfWL/Hkt90JW7oV3ETdGC2kcLef4XtazA
 qgM2P8G/iRnonHGSAQYPnvL6SSOgJfEyoP51jjtkhGCOdQlvYTZoxBMDSZOBW+UXbXay6edk3I+
 G9+lYXrcHSJcw94B/jWxGkxAock+LxW+cx7X6cJTpnFLFSw69ZYYasyedFYENHuSyrqf9US89kr
 u8vpO1GswyD4gDnD819D0BBaKFGiU7pVEJ7CVbj+si4t1Th7njLL2dMT+MTu3eJETa04z2JSe3f
 3DC20pyckfpUieml9lW/vO6q34iYLrOU7Y10HkV3jmL0yShs87SFafRBlLZwQbOSWdMZRFMNsjS
 4yQrCPaud5DyT
X-Google-Smtp-Source: AGHT+IHPYPZ17Amnw0HqnhsbWOvGLr9Y4nqkSKXkbTvLFuXtelKxRUeHHoCQF7vFf49JseUCqCwgJw==
X-Received: by 2002:a92:cd87:0:b0:3dd:8663:d182 with SMTP id
 e9e14a558f8ab-3dd99bf7148mr88273855ab.13.1748779451837; 
 Sun, 01 Jun 2025 05:04:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdd7dfe53dsm1310139173.15.2025.06.01.05.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 05:04:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] doc: efi_loader: Tidy up the bootefi-command docs
Date: Sun,  1 Jun 2025 06:04:01 -0600
Message-ID: <20250601120406.2106-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

There are backslashes in some of the tags which seems to be unnecessary.
Remove then.

Change the word 'either' to 'any' since there are three options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/cmd/bootefi.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 3efe9e9df57..d6e4e62e383 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -20,19 +20,19 @@ Synopsis
 Description
 -----------
 
-The *bootefi* command is used to launch a UEFI binary which can be either of
+The *bootefi* command is used to launch a UEFI binary which can be any of
 
 * UEFI application
 * UEFI boot services driver
 * UEFI run-time services driver
 
 An operating system requires a hardware description which can either be
-presented as ACPI table (CONFIG\_GENERATE\_ACPI\_TABLE=y) or as device-tree.
-The load address of the device-tree may be provided as parameter *fdt\_addr*. If
+presented as ACPI table (CONFIG_GENERATE_ACPI_TABLE=y) or as device-tree.
+The load address of the device-tree may be provided as parameter *fdt_addr*. If
 this address is not specified, the bootefi command will try to fall back in
 sequence to:
 
-* the device-tree specified by environment variable *fdt\_addr*
+* the device-tree specified by environment variable *fdt_addr*
 * the device-tree specified by environment variable *fdtcontroladdr*
 
 The load address of the binary is specified by parameter *image_address*. A
@@ -110,7 +110,7 @@ U-Boot can be compiled with UEFI unit tests. These unit tests are invoked using
 the *bootefi selftest* sub-command.
 
 Which unit test is executed is controlled by the environment variable
-*efi\_selftest*. If this variable is not set, all unit tests that are not marked
+*efi_selftest*. If this variable is not set, all unit tests that are not marked
 as 'on request' are executed.
 
 To show a list of the available unit tests the value *list* can be used
@@ -126,7 +126,7 @@ To show a list of the available unit tests the value *list* can be used
     'configuration tables'
     ...
 
-A single test is selected for execution by setting the *efi\_selftest*
+A single test is selected for execution by setting the *efi_selftest*
 environment variable to match one of the listed identifiers
 
 ::
@@ -140,10 +140,10 @@ return to the command line but require a board reset.
 Configuration
 -------------
 
-To use the *bootefi* command you must specify CONFIG\_CMD\_BOOTEFI=y.
-The *bootefi bootmgr* sub-command requries CMD\_BOOTEFI\_BOOTMGR=y.
-The *bootefi hello* sub-command requries CMD\_BOOTEFI\_HELLO=y.
-The *bootefi selftest* sub-command depends on CMD\_BOOTEFI\_SELFTEST=y.
+To use the *bootefi* command you must specify CONFIG_CMD_BOOTEFI=y.
+The *bootefi bootmgr* sub-command requries CMD_BOOTEFI_BOOTMGR=y.
+The *bootefi hello* sub-command requries CMD_BOOTEFI_HELLO=y.
+The *bootefi selftest* sub-command depends on CMD_BOOTEFI_SELFTEST=y.
 
 See also
 --------
-- 
2.43.0

base-commit: 71e41b261c510a6b64715d7268e10015725c8759
branch: appd
