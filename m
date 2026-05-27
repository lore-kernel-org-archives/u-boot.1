Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5D8CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 985608469D;
	Wed, 27 May 2026 18:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kGtGoAv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19A0E8470E; Wed, 27 May 2026 18:10:42 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97951844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e615efd7d7so4014318a34.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898238; x=1780503038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jfycmj9rGq9s0Nnj1RV23OzxTRhw+G0V7bcTIKvKRwk=;
 b=kGtGoAv+7NF+g84Ydjx8Wgxw/A6aQPncq5/RUqwEYiGuhB990xc9l0LQm9HgSDCbhW
 sUlAcwYNk+Q36mfK+AN7Nv2xYWSlROdHLDow/XOT4b7f0x538ROCr2uGzkOpUjxsAb6/
 8ILuULd7G6XAP/4TwsyqueGyw+nvKh3re0cPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898238; x=1780503038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfycmj9rGq9s0Nnj1RV23OzxTRhw+G0V7bcTIKvKRwk=;
 b=UJqULaUTnkz049Zea6sevPZzAYocN8yv8efE7kBry43l9QBseIQOpQFXrU7dRfOFdu
 uulUt92spc4LrEuDjRZ932UskloRkcp7HQ6HeRTByhLqNOl1NONqNp44FDspcjNV42+b
 DBmAcZiodFWSLZSaDg7Z203itTCrCls2D3/mrTUfvrhRVjWoFBJRFwmlnEtI919HwtrM
 pG5Cftnb+HvFIaSXgKAT1Kb4OHKadXZ5gsgiutMW67VZvmAkRkZqgfwGlgyFH/lbqxFA
 D8LN6Yb152iB7u5rYRWbGEMDrLeWHTtuLSiyxCzWL+Xu7hsZTkMLzRlwf00n9k1SAQOw
 qgdA==
X-Gm-Message-State: AOJu0YyLie8kmMNvGHrWKis2hqqH1KN7nvVM+1y1lPyX9tEPOtEGhkVK
 /zT1haoLFhqcCuEjy/tut825FeRueehsWl/LB0BLgo21kjgeslKDQ0xRCwA9fFafe6QyfqtKJpA
 0yYcPKK2llcYxwQ==
X-Gm-Gg: Acq92OFn8GiGEvbBtJGqsTybcNVIxhIP+qWx3TwB1NzVEk0IgncLPiwDP8MtCmpProL
 IIik5Ix91yCzBLmZ1meGiLpGIfT7/vQgxxnQr4+HL1LN+/dQQskS1YIAVozitbEsx/8VFDN1wzS
 k9mNCgDE6uo/ZoQn581f2kEkN3X+8wUJw3UGyOfG9d1tcU8rnw7Ij16mr/yi6KQf1F/fRROjT6W
 IEyBkwjdp6Qf34FdgHfEdqkIsdnGzfDbMtkdkJ+vjX855dJocMfh6bZFeraGGbI7In7+uFx0FIG
 iwR/f08C6tohe+b/Gh3GV3IKVYxLyHTSIVH9FjyXm0LT2rn6f3iiA+6QHSToV+npzXPYEFS9B8A
 IrNrBWcS7G0ZdznhCDC/k/SiOqIxNNBe4+0MZ+IISh/+Xp2vjuo9ld3EDzMuLkU0+B5m1MG8Ati
 xmk48PZwtcvRbLA5AXKobV8Rx0EbPZSWUubjQl/R8=
X-Received: by 2002:a05:6830:2404:b0:7e4:230:96ca with SMTP id
 46e09a7af769-7e5fef2efe7mr14737274a34.21.1779898238292; 
 Wed, 27 May 2026 09:10:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:10:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Christian Speich <c.speich@avm.de>, Daniel Palmer <daniel@thingy.jp>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Kavin Gunasekara <kavin.gunasekara@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Meet Patel <meet.patel2@arm.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/13] virtio: Sandbox emulator plus an assortment of fixes
Date: Wed, 27 May 2026 10:10:10 -0600
Message-ID: <20260527161033.3273795-1-sjg@chromium.org>
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

At present sandbox testing of virtio is fairly limited. This series
expands this. It provides a small MMIO helper along with a virtio
emulator that sits in front of the existing MMIO driver. Then a
block-device emulator is added on top. With this in place, sandbox can
exercise virtio end-to-end.

The series also includes various small clean-ups and fixes that pair
naturally with the emulator work: hex blk indices, a probe-ordering fix
for acknowledge, a legacy-PCI rename, log-category for the remaining
drivers, and three resource-cleanup fixes on device removal that the new
emulator makes easy to verify.


Simon Glass (13):
  sandbox: Move memory-related functions to a separate file
  alist: Allow inclusion from OS headers
  sandbox: Support memory-mapped I/O
  blk: Use hex indices for the device name
  virtio: Export a few things from virtio_mmio.c
  virtio: Implement a proper sandbox emulator
  virtio: Implement a simple block-device emulator
  virtio: Acknowledge devices only when probed
  virtio: Rename a few legacy-PCI functions
  virtio: Set the log-category for all drivers
  virtio: emul_blk: Free disk data on remove
  virtio: Delete vqs when removing a device
  virtio: Free mmio base when removing sandbox virtio emul

 arch/Kconfig                       |   1 +
 arch/sandbox/cpu/Makefile          |   2 +-
 arch/sandbox/cpu/cpu.c             | 274 +----------------------
 arch/sandbox/cpu/mem.c             | 337 +++++++++++++++++++++++++++++
 arch/sandbox/cpu/state.c           |   2 +
 arch/sandbox/include/asm/io.h      |  15 ++
 arch/sandbox/include/asm/state.h   |  67 ++++++
 configs/sandbox_defconfig          |   1 +
 configs/tools-only_defconfig       |   1 +
 drivers/block/blk-uclass.c         |   2 +-
 drivers/virtio/Kconfig             |   8 +
 drivers/virtio/Makefile            |   1 +
 drivers/virtio/emul_blk.c          | 186 ++++++++++++++++
 drivers/virtio/sandbox_emul.c      | 328 ++++++++++++++++++++++++++++
 drivers/virtio/sandbox_emul.h      | 160 ++++++++++++++
 drivers/virtio/virtio-uclass.c     |  21 +-
 drivers/virtio/virtio_blk.c        |   2 +-
 drivers/virtio/virtio_blk.h        |   3 +
 drivers/virtio/virtio_internal.h   |  19 ++
 drivers/virtio/virtio_mmio.c       |   9 +-
 drivers/virtio/virtio_net.c        |   4 +-
 drivers/virtio/virtio_pci_legacy.c |  10 +-
 drivers/virtio/virtio_pci_modern.c |   2 +
 drivers/virtio/virtio_ring.c       |   2 +
 drivers/virtio/virtio_rng.c        |   2 +-
 drivers/virtio/virtio_sandbox.c    |   2 +
 include/alist.h                    |  16 +-
 include/dm/uclass-id.h             |   1 +
 include/virtio.h                   |   8 +
 lib/alist.c                        |   1 +
 test/dm/virtio_device.c            |   2 +-
 31 files changed, 1188 insertions(+), 301 deletions(-)
 create mode 100644 arch/sandbox/cpu/mem.c
 create mode 100644 drivers/virtio/emul_blk.c
 create mode 100644 drivers/virtio/sandbox_emul.c
 create mode 100644 drivers/virtio/sandbox_emul.h
 create mode 100644 drivers/virtio/virtio_internal.h

---
base-commit: 8d5f30b52f7c800c2177188fc4d331fb7af2c46a
branch: qema-us

-- 
2.43.0

