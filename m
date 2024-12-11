Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA733E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E63B801E7;
	Wed, 11 Dec 2024 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M+N9YXz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F02801B0; Wed, 11 Dec 2024 23:38:32 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6C0801B0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a8c7b02d68so141585ab.3
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956709; x=1734561509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BqauQY1jyXbtRJKPRWpiTmyDyKuXco05pci4hsBn0no=;
 b=M+N9YXz03nRG12STNBEFDqL1AAWMfNljUIfGFR9m8aJWG5VcH9Mf8AeeERxINA8AoC
 pLTEVCWPJw6Tazs9eW71aI50ZatfGDQGmC6T8qktvSgxC9urT3K+XOcC0076kUyRAvC7
 ZYsJfeBs3R+eENgg7PWNfpC8/Gd7EpSG3xroU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956709; x=1734561509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqauQY1jyXbtRJKPRWpiTmyDyKuXco05pci4hsBn0no=;
 b=g/dpbvyvh9fx8blet9LxQs4OuAorm0nG+nQqJOdt0Hte2zz6eKfYzXwY8dY13pdCYh
 FVabwxm+e5+JKPFELy6WVFJZMVmoIYbxqy/lB/zQ2ujsBDb30KUJ8yJod6MNppo08fS7
 IwhHm+CTYoY5YiU3j/krtph/b+cQeWKxpuApC9bvogQyW7VEg/6OSI7ZwtSiptKwBwF4
 c/Rs6F/sbC3FVj0BefxFP2Rjk6JUzPT1mEFuzFrMLnSAE1+gP3MWXo88JhirHlA9JERi
 RELGKYaiuFNVfHS96wgmpDCqzWcad/+k0753vEO+wJVhZneShzOZRkiVpipA2Mi8Jrxb
 J4Qg==
X-Gm-Message-State: AOJu0Yx5psbsq28TCog85we3ARsQ/F5tiHhwdmUphvrwWgwMupFNOFpp
 TlELs6zZ8MfagMuiwwFJk3W6rw9MP7V9BX8cpTk5bKfiC5GCAG1CtGaib+OAy10JpDsLUKfbcY8
 =
X-Gm-Gg: ASbGncu8Se3Cp4N9fci/Fpqyc3o8pkrJyeWOj6PhIXYD2AFCaGvJgve8GI/fm33Ko6e
 ZjFG3S3FxeMDsy0nobGEHOgV1OxrPBe9VEnxStCQo78utiTJDsBwlZ3qkFkRGCZ/Sm52V16jXeb
 VBqv8nNXgi3TkTnYXC1iJ6RWzm8a3S5ukCV4R4UszAr7n8NEhnjz8sZ5lVfcJZ95MatBaJYcaRB
 7iNjwuDu0bfpuZAWnUzB1p48mpLW0ad0ETwImUzs12UlkLRBBmiA7/cOvSJb/RD4pbWy0us7Zoc
 7eNUF65qkzVs478=
X-Google-Smtp-Source: AGHT+IGmZwO9Js8qO49hJ0OqDI4B3n9zYrMffL5PxPJ2EGM+w7PhH2OMpCZ9llQw9cGcU2HJgTJ3gQ==
X-Received: by 2002:a05:6e02:1c02:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3ac48bb347cmr13039255ab.10.1733956708843; 
 Wed, 11 Dec 2024 14:38:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 0/7] efi: Start to chip away at the EFI workaround
Date: Wed, 11 Dec 2024 15:38:15 -0700
Message-Id: <20241211223822.2446254-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

At present there is a function, efi_set_bootdev(), which is used in
various places to tell the EFI loader which device a file came from.

With bootstd, this information is available in the bootflow.

This little series provides a way for bootstd to provide the bootflow to
the EFI loader, so that it is able to select the correct paths.

For now only the EFI bootmeth is updated.

Changes in v2:
- Adjust argument ordering for efi_run_image()
- Use efi_loader tag instead of efi
- Drop unnecessary path removal
- Fix 'require' typo
- Move calculation of dev-name into a separate function
- Add new patch to support PXE booting

Simon Glass (7):
  efi_loader: Refactor device and image paths into a function
  efi_loader: Make efi_run_image() static
  efi_loader: Update efi_run_image() to accept image and device path
  efi_loader: Add a version of efi_binary_run() with more parameters
  efi_loader: Move the fallback code from efi_run_image()
  efi_loader: Pass in the required parameters from EFI bootmeth
  bootmeth_efi: Support PXE booting

 boot/bootmeth_efi.c          |  64 +---------
 include/efi_loader.h         |  10 ++
 lib/efi_loader/efi_bootbin.c | 239 ++++++++++++++++++++++++++---------
 3 files changed, 189 insertions(+), 124 deletions(-)

-- 
2.34.1

