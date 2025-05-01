Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DB3C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081618070C;
	Thu,  1 May 2025 15:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vnx1zuUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BAA80BAD; Thu,  1 May 2025 15:37:35 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF848059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85e751cffbeso88402639f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106651; x=1746711451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TIuBQP084TPo0ax1HZZQPEbIKSqzOZKKITS8u8uU8kE=;
 b=Vnx1zuUDQMXDs/0iEerXlyZJr1ebhW2YcExu0c8zvjCx1FHbaJTPEt3Z05UmQWjzbz
 CTniMupXE857i4xrRveiQ7jU6/ecbI1tqI8rtecI0lhVeUstPdH881p4KaYSr4ggOSLu
 ye3YHpAqRsnf5EwzY0YyLZNODIiYXqD7+gSoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106651; x=1746711451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TIuBQP084TPo0ax1HZZQPEbIKSqzOZKKITS8u8uU8kE=;
 b=lfsiAhb6a3CIahypUo6navs3BVEk6/BR/Wd7Hi+2X+cp62NrF8EZc2pUD5xJ13R+8s
 1H01J8TlXDTTh94o8iIjiSBbMzqdracDGg0KsMEWohuBaS2wvKZcjZ+d6NYt5on5FKch
 19PUJSw20Urt4vdL5Xt6ygLshuXmSoYnPNHD8yVRwWy8s+uKhGuia0d/kEjWBK/NfB3z
 pWUcBrCwrLGH439zGJSF1TWEHL1rdb8GPQhbPWMsR1Devu7/7fF7Jalhg6vZ29Hbk5gw
 tSFp0kotlFPATOuM7Gb1Icuxc4qn/pU8+1q5UapyQRJlZlfbxB59UH9tGMpyF6xJBeR5
 kPTw==
X-Gm-Message-State: AOJu0YybyqRWJ3JlLIcea1QnTsq/B3h0fA/TAlM1KvfwXrqXcE1svxqT
 MsuOKIoY6HiZpHs6QGom8dlIAOlA3f2nz+1ebuGY++lJMX7wWqT8UJriFhlTZkHyK/ElFa1hlUY
 =
X-Gm-Gg: ASbGncsPmSKft0A8Rno1YH53aOhcFlLce9CIKJ4mOgcFCHKe+pRcirpapwY9fjO6yf/
 t/hSflQ1+X7F6uFP6G7UEVD8K6fXXD+4696nWTN8UPl+3UJpicm16+J0yMGjvU9Hv9AjONA1l0W
 PTr0RyENeoc48ROhKYeVFGc9XrVUPfJ1jMLELL3ptcByGvrle0AVrBtm5ulEMmQjaCG2DNsd+XY
 easwgFZebF6MQdS9auHSkAsF4VQVyQQQHbozX7A2uHlGRU2Tw+CSy2ih4YDhdZ9ABC4/1mPxsEy
 V2mgqcdRIGnlLngJyLRbZlIflpIL2Zaq35StWN0Qib2fb6FLUcNopX/LZLeI/k2zepxuDosv9C7
 GvHuHmSORnTjv
X-Google-Smtp-Source: AGHT+IEkOjIlYZFSQyuze39UkhE031iBAEQdJv3pUAYOKNWNLXXkdvTlf8fNgq4uRvRWQr4cqq0fpw==
X-Received: by 2002:a05:6602:381b:b0:864:4a1b:dfc5 with SMTP id
 ca18e2360f4ac-86498032053mr794154439f.9.1746106651539; 
 Thu, 01 May 2025 06:37:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Richard Weinberger <richard@nod.at>,
 Roger Knecht <rknecht@pm.me>, Stefan Roese <sr@denx.de>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/18] bootstd: Useability improvements
Date: Thu,  1 May 2025 07:37:00 -0600
Message-ID: <20250501133726.2627373-1-sjg@chromium.org>
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

This series collects together some bootstd improvements:

- Improve iteration when there are a lot of devices
- Add a test image for Ubuntu (to compliment Fedora)
- Improve the naming of USB devices and bootdevs
- Add a new command to set the bootdev order
- Add a little more debugging
- Use an abuf when dealing with allocate files
- A few other minor things in bootstd

Most of these issues were found when adding the new test image and more
USB devices to sandbox.

Changes in v2:
- Add new patch with a helper for initing and allocating a buffer
- Update to use abuf_init_size()
- Update commit message to make it clear this is not actually an image
- Drop use of LOGR()
- Rebase on top of recent FS changes

Simon Glass (18):
  abuf: Add a helper for initing and allocating a buffer
  fs: boot: Update fs_read_alloc() to use abuf
  fs: boot: Update fs_load_alloc() to use abuf
  fs: boot: Update bootmeth_alloc_other() to use abuf
  bootstd: Add more debugging to bootmeth_efi
  bootstd: Add more debugging to bootmeth_extlinux
  bootstd: Try all bootmeths on the final partition
  bootstd: Fully complete iteration of a uclass
  test/py: Split out core of Fedora image into a new function
  test/py: Add an extlinux file similar to Ubuntu
  usb: Use more useful names for block devices
  sandbox: Use a unique name for each USB controller
  bootstd: Tweak scanning with labels
  bootstd: Tidy up a nested CONFIG_IS_ENABLED(BOOTSTD)
  bootstd: Provide a command to select the bootdev order
  bootstd: Correct the comment for bootmeth_set_order()
  bootstd: Expand debugging in bootdev_find_in_blk()
  bootstd: Mention FS state in bootmeth_read_bootflow()

 arch/sandbox/dts/test.dts      |  13 +++-
 boot/bootdev-uclass.c          | 114 +++++++++++++++++++++++----------
 boot/bootflow.c                |  37 ++++++-----
 boot/bootmeth-uclass.c         |  17 ++---
 boot/bootmeth_efi.c            |   5 +-
 boot/bootmeth_extlinux.c       |  14 +++-
 boot/bootmeth_script.c         |   6 +-
 boot/bootstd-uclass.c          |  18 ++++++
 boot/cedit.c                   |   3 +-
 boot/scene.c                   |   3 +-
 boot/scene_textline.c          |   3 +-
 cmd/bootdev.c                  |  37 +++++++++++
 cmd/bootflow.c                 |   2 +-
 cmd/cat.c                      |  13 ++--
 cmd/cedit.c                    |  18 +++---
 doc/usage/cmd/bootdev.rst      |  36 +++++++++++
 drivers/usb/emul/sandbox_hub.c |   2 +-
 drivers/usb/host/usb-uclass.c  |  14 +++-
 fs/fs.c                        |  27 +++-----
 include/abuf.h                 |  11 ++++
 include/bootdev.h              |  60 +++++++++--------
 include/bootflow.h             |   2 +-
 include/bootmeth.h             |  12 ++--
 include/bootstd.h              |  10 +++
 include/fs.h                   |  18 +++---
 lib/abuf.c                     |   9 +++
 lib/of_live.c                  |   3 +-
 test/boot/bootdev.c            |  83 ++++++++++++++++++------
 test/boot/bootflow.c           |  10 +--
 test/dm/blk.c                  |   4 +-
 test/dm/usb.c                  |   8 +--
 test/lib/abuf.c                |  22 +++++++
 test/py/tests/test_ut.py       | 111 +++++++++++++++++++++++++-------
 33 files changed, 534 insertions(+), 211 deletions(-)

-- 
2.43.0

base-commit: 37e1b5b09b6ad0a8dd15c580b4f915ea46de8935
branch: schc2
