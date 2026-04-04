Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6AE88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B199383B8F;
	Sat,  4 Apr 2026 16:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c7JTk7PA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1523783B48; Sat,  4 Apr 2026 16:03:52 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926DB80325
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-47018d34159so717924b6e.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311427; x=1775916227; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=42FxQj2TKMGniHmxtZFTWufm/LIfUCfBUHzwtEvIZfI=;
 b=c7JTk7PAChsDCBZ/YpqrQ7PmPOBY+bLAQ/eeIULiUltCcZBGgZ+PAqY7Erj+vBijp1
 LAAanqzUiOrhqfS+RmQFf5J8soX8P+HMCCbJJJZgmTJoCJa5YZURV6mp00xbFOGk4KIi
 wMKuuxipkrXPPHyGSsf3FfjRwDfgRNuWKiz3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311427; x=1775916227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42FxQj2TKMGniHmxtZFTWufm/LIfUCfBUHzwtEvIZfI=;
 b=bPnz8/BT095Gojipib9RRBqYWPLYmaqJBnEeR4gLEiXJPbFQbZTh2ak9LWSp8s6gbl
 BzOkj7NebwbueYGmSS5mI/Xau+HS7wtwcEVmp9R6aVGqVqCI4tUpDlgWbsET0zzWVF5l
 Y3K2SVwkW0Is/wGMRc1byDf3xf9tVUJ7g1H19MvTHFGHKYa9iluChUHAbVU+g00oofBd
 FMskV3Oh5NLLf4zAnf3Eyn/PswYr9tr64xUTj8eUwXGw594fMR4xihla17cLEix3/yX4
 bgW0oChkeMIqZlFoHiviHfLLq9A6nQjue9u5AIqac5ZmyAKrFyzX6d4jOnt8AFfqBvHV
 xsHw==
X-Gm-Message-State: AOJu0Yw8rLr7tLte3koji0KnNUbmaHDVWWT0qgtgMgHL2ePutELFjUuq
 jb/JSSzkfTRODCzfzvSI/Cmd4WJ9Ebi5yWHM9mpGPals0ugwqaoEELmK+Iznkfrly0XEaEZsKtZ
 fY8M=
X-Gm-Gg: AeBDievnBhoDavxQm5zpLl9PHdR2hri6eUivi0/X4q0yTyV3uDisDAOYTFOrYGxHj/p
 rNDKCGVxTvp4s7uYy8aQu8Rvdbgo8MqpbObMit9sHqM03Nt1lWot4m7qlofpfrLCwaywMiSURsa
 FF4d7A3dUZuKu4qDCQa/H30pgD05PMEooxxt6yLSHaQvR1VLFU8DESoELadudAlvyi094HpntpG
 NMz8zmGlOZJPXZ8KGfkaH5Wn3fHN4RGaoMMdjVdFy659ggS1kVOfji00F2C2WHvpuSf4+9Jt4Dn
 1ZnVSeVokw3LJwuM58zzSX9oTqse/jZFg7sGGrJFfuqvOsR2wOzncIxAH2yMXp5JvvhVYvH7+tW
 HyZ/3f/x7fT/0e6XBZnI3wWvm3heu/FJZjEfa+EovqOl3OOCWjmBH5q77bjIbebEzYXt7d9Wz6/
 k66kp0FSkrhUq/AI3stv5izN8faB5x
X-Received: by 2002:a05:6870:1616:b0:41c:9eb4:cec5 with SMTP id
 586e51a60fabf-4230ffb8ebcmr3576695fac.29.1775311427060; 
 Sat, 04 Apr 2026 07:03:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/14] test: Convert tests to use FsHelper and DiskHelper
Date: Sat,  4 Apr 2026 08:03:04 -0600
Message-ID: <20260404140328.3724864-1-sjg@chromium.org>
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

This series adds a DiskHelper class and converts most test code to use
FsHelper and DiskHelper instead of calling mk_fs() and setup_image()
directly.

The FsHelper class (already upstream) provides a cleaner interface for
creating filesystem images, handling temporary directories and cleanup
automatically. The new DiskHelper class builds on this, creating
partitioned disk images from one or more FsHelper filesystems.

DiskHelper includes a cur_dir flag to place the disk image in the
current directory rather than the persistent-data directory. This
matches the behaviour of setup_image() which places disk images in
source_dir where sandbox expects to find them. This flag is needed for
now and should be removed in a follow-up once all tests are migrated to
use the persistent-data directory instead.

With these helpers, test-setup code becomes shorter, more consistent and
easier to follow. Manual sfdisk/dd/cleanup sequences are replaced by a
few method calls.

The series also fixes a broken fs_obj_fat fixture where a stale
size_gran argument is silently causing the test to be skipped.

A few EFI test fixtures (efi_capsule, efi_secboot, eficonfig) still use
mk_fs() directly; these are left for a follow-up series since they would
benefit from a full DiskHelper conversion.


Simon Glass (14):
  test: Add a helper class to create disk images
  test: fs_helper: Skip empty srcdir when creating a filesystem
  test: Fix broken fs_obj_fat fixture
  test: Convert test_cat to use FsHelper
  test: Convert test_xxd to use FsHelper
  test: Convert test_efi_bootmgr to use FsHelper
  test: Convert setup_bootmenu_image() to use FsHelper
  test: Split out core of Fedora image into a new function
  test: Convert setup_bootflow_image() to use FsHelper
  test: Convert setup_efi_image() to use FsHelper
  test: Convert test_ut_dm_init() to use FsHelper
  test: Rename setup_bootflow_image()
  test: Convert setup_rauc_image() to use FsHelper
  test: Convert test_fs fixtures to use FsHelper

 test/py/tests/fs_helper.py        |  95 +++++++++++++-
 test/py/tests/test_cat.py         |  27 ++--
 test/py/tests/test_efi_bootmgr.py |  38 +++---
 test/py/tests/test_fs/conftest.py | 198 ++++++++++--------------------
 test/py/tests/test_ut.py          | 190 +++++++++++++++-------------
 test/py/tests/test_xxd.py         |  28 ++---
 6 files changed, 288 insertions(+), 288 deletions(-)

-- 
2.43.0

base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: testfsa
