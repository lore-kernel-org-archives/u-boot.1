Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E6EC54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 11:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3353987593;
	Tue, 21 Nov 2023 12:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J9JQRcs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0039A87563; Tue, 21 Nov 2023 12:36:07 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0166870BC
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7afff3ea94dso196026339f.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700566563; x=1701171363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WzdIZHDW3HYtz8r0kjoEFMkxcB+rmqZEqk+bXR5hOv0=;
 b=J9JQRcs9WesY8kUNIgsvmQ4vPqC42aQxmhoBVfq3q5GSbMKLlt6QrDoGolRW1nT/Rj
 2tqu5DWVDVMmcobxvSZS//g8PvO1Q+O1u27/O/W9LoTm+AuZwwtepcchgq5lamCjHowO
 YrCSLcUEy5KmBBY0Dg0u14h0M5xjRLtj+6mL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700566563; x=1701171363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WzdIZHDW3HYtz8r0kjoEFMkxcB+rmqZEqk+bXR5hOv0=;
 b=btsh+Z+xWcCOe0dBCLeUs7ZLnHzWcbXBy+KdMQocJHsSlksXa8IP02dI2/wRO52dMh
 chUkiGg8nIg55RxqyUTJNXXGPX7/uDHdwXAEs2li7v98OzkgbPrgGdsP0tGnPud8Yu8d
 /W2sqis/Vk2K5pPMrdqTB4KV6Q3gJfWLkmUKLUB08FX6+fwSAogNP8UOm3MkiwLFlwmK
 2RZW4W360Syu2X2jk22cPuPe/g3RDbzfxVNUr9Jay/Ztt7LUnCZ7TGwytBLw//w5rk/L
 6Qnzq/p4CkuHEGnjLmwJf/u3eJoDKVh5fShk6SQpajfGvIwHY19czRqzCXfA4BGWEgyZ
 OmUw==
X-Gm-Message-State: AOJu0YzIh2YnmXi1hTRrtMNYNMGwwfYcfHbq/wVgYuoGtS3wrVNfsVNh
 mPLtoDRI8AeASwp26co1rvs47PFKi7wDPQOJ6jY+CQ==
X-Google-Smtp-Source: AGHT+IFeSm9aAFjeVBG4rIk9MRIMyprAr6b8tiXHbqnRaZ/Wl3IIwmaIb1XkpIhYIAYHGCONF4+c6A==
X-Received: by 2002:a05:6602:2358:b0:7ab:ec1f:f486 with SMTP id
 r24-20020a056602235800b007abec1ff486mr12768383iot.4.1700566563263; 
 Tue, 21 Nov 2023 03:36:03 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a0566380f8a00b0045bb982a3d2sm2559190jal.60.2023.11.21.03.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 03:36:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/7] efi: Partial attempt at a test for EFI bootmeth
Date: Tue, 21 Nov 2023 04:35:46 -0700
Message-ID: <20231121113557.800353-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
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

The test coverage for the EFI bootmeth is incomplete since it does not
actually boot the application.

This series makes an attempt at this.

However there are at least two problems:
1. The test does not set up the loaded image properly, so it isn't
found by the app.
2. The test needs to use USB instead of mmc, so that usb_stop() is
called


Simon Glass (7):
  efi: Use puts() in cout so that console recording works
  efi: Show the vendor in helloworld
  efi: test: Create a disk image with and EFI app in it
  WIP: efi: Disable ANSI output
  WIP: efi: Add a test for the EFI bootmeth
  WIP: efi: Allow helloworld to exit boot services
  WIP: efi: debugging

 arch/sandbox/dts/test.dts     | 10 ++++++-
 boot/bootflow.c               |  2 ++
 boot/bootmeth_efi.c           |  1 +
 cmd/bootefi.c                 |  1 +
 include/efi_loader.h          | 14 +++++++--
 lib/efi_loader/efi_boottime.c |  5 ++++
 lib/efi_loader/efi_console.c  | 19 +++++-------
 lib/efi_loader/efi_setup.c    |  2 +-
 lib/efi_loader/helloworld.c   | 39 ++++++++++++++++++++++++-
 test/boot/bootflow.c          | 55 ++++++++++++++++++++++++++++++++++-
 test/py/tests/test_ut.py      | 32 ++++++++++++++++++++
 11 files changed, 163 insertions(+), 17 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog

