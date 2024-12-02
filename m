Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E831FD4978E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 00:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B33F89138;
	Mon,  2 Dec 2024 01:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Njb3w90A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFD889137; Mon,  2 Dec 2024 01:12:54 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D137890DA
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 01:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2967af48248so2063040fac.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 16:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733098370; x=1733703170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J4zSCquRyE+UlRIE6pHXn3ImcsB6afYiKpo5U4QgO+4=;
 b=Njb3w90A15jscmwAo7eYFepGlIGCULKF4uvSLifrYy6rjRvzZIXiSyJy1AZr3Iclit
 j1700PggumnXon+kZ++b7UUdqGhINYuQy5GuynXvnu+ckU9XE5GJKSpAqe5jVt4nftWf
 BKoAd4YV9nQRQ6lRay2Y+r9WpN8THHYhF6Dtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733098370; x=1733703170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4zSCquRyE+UlRIE6pHXn3ImcsB6afYiKpo5U4QgO+4=;
 b=IsK0dCmS5Go/r3dwkQ0d4nQWqS6+c3r6oMp2Mx1TRaqsSwuWTwNe97puTclpWe1SMR
 E4c73Am71q0jBWJyrVwAUpCtDBPeO8XFQY0KminuLyw/a5m6ZuNKxmQN2QH4UVaAyndP
 Pi9haCriZKjwUq/tj52Q8vjNPC/De/temUIUqvQpe2zie++w6Asu53ujI7WfhsMkehJM
 kFS8ASVLYQmdYnylWeaF+8EzyN3fojNcF2KaAwDZt0k8P2PWh1Rrzd74UCrb0A7fG5fN
 uJ3ug7X0p1nUoZjG16/GpkLVz2QRaFuYUNwpEpUcX1vI9pdcqDOh4jbgQql/wbV3TYV5
 Vurg==
X-Gm-Message-State: AOJu0YyrUQzrQ+rEhT2L1HNGKMC6CxQDsUpoBeFvsoVDGbO6C1DwSTnt
 UH+K+biiAzZTh57PyBmR8LpeIvPCoLnQbjOm0iX2Zth4SqNxqdc3KXxhcI6E+YSR+EjpFwLdtSI
 =
X-Gm-Gg: ASbGncsQEuk7nqvC9wt6JbxSaPjHnnk5YaVrW0DM7Yuw+qJHIrO9aUlK+ey+etHQFIf
 Y/OVPJEaltZSiP13lbFIKdEfKkk6yTS6rgSGVxGKbWcFNZFbsfYMt6PmqqkLMcCNPtzGjFAWMa4
 QUjL//N+jc3iEs4Fso/4ZHS3fzT/3HxC67vhgVjcMz+dEBp/DpfdCuv7Vm5vAdcksbiXa3L88kc
 WXl8eWE3jnL1u4Gyezmz+nBvuiMLFF3qIdEuo31nHfvKw==
X-Google-Smtp-Source: AGHT+IHWtFJZV2lZqrPtblvv9r61eaeFcpWDMO9s+WULgKgqRMuQrZc+2xbNDKBRZobuHz3Ocq4f0w==
X-Received: by 2002:a05:6871:328a:b0:29e:6ae2:442 with SMTP id
 586e51a60fabf-29e6ae210f0mr264169fac.32.1733098370537; 
 Sun, 01 Dec 2024 16:12:50 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e6ef90f5dsm14615fac.51.2024.12.01.16.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 16:12:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
Date: Sun,  1 Dec 2024 17:12:36 -0700
Message-Id: <20241202001243.1283274-1-sjg@chromium.org>
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

It is a bit of a pain to log EFI boot-services calls at present. The
output goes to the console so cannot easily be inspected later. Also it
would be useful to be able to store the log and review it later, perhaps
after something has gone wrong.

This series makes a start on implementing a log-to-buffer feature. It
provides a simple 'efidebug log' command to inspect the buffer. For now,
only memory allocations are logged.

This feature makes it possible to add tests to check which EFI calls are
made by U-Boot itself. It may also make it easier to figure out what is
needed for booting Windows.

Some patches to help with debugging sandbox memory-mapping are included,
but for now EFI's use of mapping is not adjusted.

Changes in v2:
- Rebase on efil series (memory address/pointers)

Simon Glass (7):
  efi_loader: Fix free in ..._media_device_boot_option()
  efi_loader: Add support for logging EFI calls
  efi_loader: Create the log on startup
  efi_loader: Add a command to show the EFI log
  test: efi_loader: Add a simple test for the EFI log
  efi_loader: Use the log with memory-related functions
  efi_loader: Add documentation for the EFI log

 MAINTAINERS                  |   7 +
 cmd/efidebug.c               |  53 ++++-
 configs/sandbox_defconfig    |   3 +
 doc/develop/uefi/uefi.rst    |  22 ++
 doc/usage/cmd/efidebug.rst   | 109 +++++++++
 doc/usage/index.rst          |   1 +
 include/bloblist.h           |   1 +
 include/efi.h                |   1 +
 include/efi_log.h            | 316 +++++++++++++++++++++++++
 lib/efi_loader/Kconfig       |  19 ++
 lib/efi_loader/Makefile      |   1 +
 lib/efi_loader/efi_bootmgr.c |   3 +-
 lib/efi_loader/efi_log.c     | 444 +++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c  |  66 +++++-
 lib/efi_loader/efi_setup.c   |   7 +
 test/lib/Makefile            |   1 +
 test/lib/efi_log.c           |  93 ++++++++
 17 files changed, 1131 insertions(+), 16 deletions(-)
 create mode 100644 doc/usage/cmd/efidebug.rst
 create mode 100644 include/efi_log.h
 create mode 100644 lib/efi_loader/efi_log.c
 create mode 100644 test/lib/efi_log.c

-- 
2.34.1

