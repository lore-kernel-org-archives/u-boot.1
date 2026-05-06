Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764AACD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66EF8468B;
	Wed,  6 May 2026 17:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xb94GYvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D9D846F4; Wed,  6 May 2026 17:56:56 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32C238466D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dea20cf21aso6077909a34.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778083011; x=1778687811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G8t3JhDUaAU+6u+il0PMb+WMzcfmx8s5f1QvaqlYGkc=;
 b=Xb94GYvqXduE9lxXAlmrTMGPZho8nE/KlLIjQbQtBhXBT3h0KBWk+aW+kqIAOgIxwD
 7f8LKtZNXf78WjTDGLLRfhXyR++1KYYkTEPjRvs/rdmE/tGCwLhcN+Shr+5beI4Q3gmT
 dNPNZyfqWibfC6X5tZk60/k5Mx/BHPA4Aio94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778083011; x=1778687811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8t3JhDUaAU+6u+il0PMb+WMzcfmx8s5f1QvaqlYGkc=;
 b=SGK6HZrMKnU/yDm+24FNqsH+7xdj1ACM7feA+N+dEPMCSh4AGGq2sLyx0oW8bDfoJD
 HfxhOJYd27jLmCxxPNCd2oFj/qxdYWXRbhMmzlH1xW15xC+ru3gPtYIB4NEGc/HPAZWF
 ZGnQrI8aNobFNW+4QhygBd97RYfLCDUOuwy/SmCsoZb1OJ+ZocAm0aaw4a7Ema1OqheD
 2LDGTRhAPMPMkCrJKwJKwEuuGVNzf2/rhXu6Gz4XhL1EGdP0kFI0N1kjmlX/cISm1jfa
 2K707FA+G5SAMzVWNmjP5qiGYtGwAzXzT3lIOskZefAbD8V5Gb6HgO7kMp2we7SIggRq
 h+0A==
X-Gm-Message-State: AOJu0YxDmD/oZwciFXVaVkddIxU/ZOqyxZWL3IQKvF7+0jei7e0XY/Lf
 cuAKyTgb/HGjIpWNeekYuLFdn9eq7OLisBpDg3ffM05IphcDyB0eGEyYlE2sJLFlSp/n5ih1M6B
 KxqJr/BDF
X-Gm-Gg: AeBDievkfNekfdeK80iu0x3ekczQWmcnfJ+mzU1P5W4JsdpSBCDl3mYg94o4wo+BCQt
 ss+5lx8PkYM+aqcqHNMQEW4GYRiLmlDKhBPtq8HKQOIvG8nJWwciwdUzlmR2sHO3YOJJUUccqvt
 oniq7SDpdJ7v/9G310QzqAZbp6Bn/dzwvHzCMI8DNB5TPENod/bmUiWLFv19J7vNT8ZtoNbZOXQ
 pytk9O0JYb/Z+72nlznI7V4IDIHueeKhCjCC2fIWxlRaWWGzbeBvRYM70wvyCsu0EL7MeRVGTb5
 RTKhnc9M6fcwtr2qVpsOlcK0ANYVs16BmqNvYimarK2H4Hxu1SZzQDolVqSpy65dbfX6lHQYZbY
 dkOaUHX7+xtzuJOj+nUmEH4HMM/sI0cw/dFAKww82xKrYI7MFV1q88ZpaQqhXbNB1x6yw1E0Frb
 Ffv9vUNRTttmyrQXI03rFi4IfjngZvMuHV8gO8IZM=
X-Received: by 2002:a05:6830:240b:b0:7d7:4aa5:5210 with SMTP id
 46e09a7af769-7e1df1703afmr2049775a34.19.1778083010671; 
 Wed, 06 May 2026 08:56:50 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decadc2906sm12309095a34.23.2026.05.06.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:56:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/10] test: Convert remaining mk_fs() callers and tidy
 fs_helper
Date: Wed,  6 May 2026 09:56:14 -0600
Message-ID: <20260506155639.1191640-1-sjg@chromium.org>
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

Convert the three test fixtures that still use the procedural
fs_helper.mk_fs() / setup_image() entry points to use FsHelper and
DiskHelper as context managers, matching test_efi_bootmgr()

With those gone, drop setup_image() and inline the module-level mk_fs()
into FsHelper.mk_fs()

A handful of small cleanups follow:

- extend mkfs -d to all ext variants and pass it unconditionally
- move /sbin PATH fix and pre-existing-image cleanup into __init__()
- drop a dead size-rounding step and the try/except wrapper
- use Python's file.truncate() instead of shell
- let callers override fsh.fs_img if they wish

This paves the way to move generated test images out of the source tree.


Simon Glass (10):
  test: Convert test_eficonfig to FsHelper
  test: Convert test_efi_secboot fixtures to FsHelper
  test: Convert test_efi_capsule fixture to FsHelper
  test: Drop unused setup_image() helper
  test: Inline mk_fs() into FsHelper.mk_fs()
  test: Factor mkfs args into _get_fs_args() helper
  test: Pass mkfs -d unconditionally for ext filesystems
  test: Tidy up the mk_fs() logic a little
  test: Use Python truncate() for image file
  test: Set the default fs_img in the constructor

 test/py/tests/fs_helper.py                 | 196 ++++------
 test/py/tests/test_efi_capsule/conftest.py | 156 ++++----
 test/py/tests/test_efi_secboot/conftest.py | 402 ++++++++++-----------
 test/py/tests/test_eficonfig.py            |  46 ++-
 4 files changed, 375 insertions(+), 425 deletions(-)

---
base-commit: ae8987f4e690f397f507c4b1efabd68b3ed08db6
branch: testb-us

-- 
2.43.0

