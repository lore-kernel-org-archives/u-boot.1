Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620C9C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FB882A33;
	Sun, 11 May 2025 16:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lo2T7BKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F79A82A2F; Sun, 11 May 2025 16:18:40 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3318295C
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5fbed53b421so5547648a12.0
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973117; x=1747577917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PdRj9qsUYcWvgYzJf0Ln8PSZpRpNtKjl9uwVimepmQ=;
 b=lo2T7BKOBKlbHzxH1ueAAsW1oezmnwCh6/eKFFuqIFbekJfhHxNJYq+zUjf2dQAZ9D
 Psux9KS56+pRb7ZVBQcd5YvdFsJAY8YnDW8yr6xeMC6AjMiHON9T0+peZiILlOFpEPSz
 /W59r9JMtLBYK4Imnkht8ewEXnW3M2cKXwNv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973117; x=1747577917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PdRj9qsUYcWvgYzJf0Ln8PSZpRpNtKjl9uwVimepmQ=;
 b=LaR/B32+gyf30q7UV+ZRQSVqMHpcfgk7bADVXER4pWquM0UCfnnCn4fiWnUuClkEgG
 dMlkPcLY+bSVtMlxqj9B5A63TisR1A3R4ND/wNWQNOoAhgtGzd5FluQv1iy0FoH0DtBj
 Agc02uKmkUv2C+5kklxnWoWnU7R42jyaTAik14ftCCoIATwxHTMWoCguB81o1OfMpW0D
 sRdx/fl/Ed9TLDvAUhnGjet2z/VEm6sL5cm/eBnUYol7Z3TOQ3KzkYTpbtylAbdBiuTp
 iWf8fbWINYaOGMP/TvxAadcYMTM9f7k8E3qC8W83Tg50p54fQUjOeupRYWba17pajCz2
 uSBQ==
X-Gm-Message-State: AOJu0YzXDAK0zlhM/nT/Zu7/95j4x8DW5khYAK9pukjnXrkuND3RwNzn
 4JtCmSs2eJjwu0lUST3o+mxTpwMannwaqScqFPpSkQFWLetQ2H5Vg2yGXnw5z4O1ByPvj4fQ6y2
 jxkQA6qJ0RQ==
X-Gm-Gg: ASbGnctMd3SCafAi7jfWLT6Rsk3GYNgTtrJhKWusGza3hl7kEEmSSI2HBW8/nLFmQH4
 qMNs8A2WFSgDe3x9E6ePn1weSBw6pB+9xJk1QM3wZTeKvQxV+9lMXM7HPMm4ivcAsyAoG2uXYI8
 /HL9xNQmZ8MR74hhyVBN9RZQsyD6UIxax+QLAYL7ndbGQko6x6TGeSYtXOFdb3OzAcE6pQUMWT1
 NH+WHO5c+nWiN5yBmDQEaBfWw3b9yP1uAlWK1g35B+tRDEHk2otJmECI9PYXzI5kIFFpLjW4UME
 GfStsuYzccNEll+MhJunaN+5alOiTkTpu3J2LqcGxMhQO9U=
X-Google-Smtp-Source: AGHT+IFqzIaTrgxTcr8t0E3abRHsw9VTprBz6MwYr/wjysHZQJlkvWEJ+zMxLqujlqzcYfP88cxpkw==
X-Received: by 2002:a17:907:c243:b0:ad2:5198:d711 with SMTP id
 a640c23a62f3a-ad25198d88amr117814566b.10.1746973117270; 
 Sun, 11 May 2025 07:18:37 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] scripts: Rename build-efi.py to drop the file extension
Date: Sun, 11 May 2025 16:18:17 +0200
Message-ID: <20250511141828.2367318-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
References: <20250511141828.2367318-1-sjg@chromium.org>
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

The .py extension isn't very useful. Drop it and update the shebang to
specify Python 3

Update the docs for this and also drop the old reference to 2021 images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                         | 2 +-
 doc/develop/uefi/u-boot_on_efi.rst  | 7 +++----
 scripts/{build-efi.py => build-efi} | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)
 rename scripts/{build-efi.py => build-efi} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d7ef23f476..939c46ef23a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1074,7 +1074,7 @@ F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
 F:	lib/efi/
-F:	scripts/build-efi.py
+F:	scripts/build-efi
 F:	test/dm/efi_media.c
 
 EFI LOGGING
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index b1d5faa3463..e9f8e9c297c 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -97,9 +97,8 @@ that EFI does not support booting a 64-bit application from a 32-bit
 EFI (or vice versa). Also it will often fail to print an error message if
 you get this wrong.
 
-You may find the script `scripts/build-efi.py` helpful for building and testing
-U-Boot on UEFI on QEMU. It also includes links to UEFI binaries dating from
-2021.
+You may find the script `scripts/build-efi` helpful for building and testing
+U-Boot on UEFI on QEMU.
 
 See `Example run`_ for an example run.
 
@@ -202,7 +201,7 @@ Example run
 
 This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
 
-   $ scripts/build-efi.py -wsPr
+   $ scripts/build-efi -wsPr
    Packaging efi-x86_app32
    Running qemu-system-i386
 
diff --git a/scripts/build-efi.py b/scripts/build-efi
similarity index 99%
rename from scripts/build-efi.py
rename to scripts/build-efi
index d2587a51376..e71028baa6d 100755
--- a/scripts/build-efi.py
+++ b/scripts/build-efi
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
 """
 Script to build an EFI thing suitable for booting with QEMU, possibly running
-- 
2.43.0

