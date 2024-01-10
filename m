Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83FFC4706C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 01:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141D287509;
	Wed, 10 Jan 2024 02:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZ8mCxhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003D88786F; Wed, 10 Jan 2024 02:16:58 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F11C87463
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-204b216e4easo681757fac.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704849410; x=1705454210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VbG+ORVvbU8fQwPNRXPUk+KEJ4F8z6N1qWm6ZMIQkMQ=;
 b=dZ8mCxhvqPUfGKMl7ydYupK+3geohJTFRxxLkZXxnt3xN9P8fYZiUIZpEpoZMqmR+S
 nTYBhD2ki7cSRAk9JH+pLtMLt0CEfgWjL37/u6PUpxsAQ+8y2nqK97JKLyLLyalYb6r9
 K9fk8Dgc4AWI6pz2swZxciCuvlMlcXuWwIxap+xeb/+RORn1cd2SlKLpRmI4a02xgCST
 glJcY+oy8qnUhpApPPPHDARxMxPY24i89UuKV9F4ehD+IPOGsQOtq610fmI7l00os7Oq
 SFJ8pR97UXIOHC4rEL4GLdl6D+6cGpHkF0yrmz/vptIyqown+aGoeMdHLVESQSbK5v6x
 Y5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704849410; x=1705454210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbG+ORVvbU8fQwPNRXPUk+KEJ4F8z6N1qWm6ZMIQkMQ=;
 b=TTIDNKy2Jto0UTX0dYUAgZQDKDR6xSuYYuLnYZby8kX85iHtRD8OyvmrelI78m6Xwk
 vNJL4KfgXu/9L/ooBHMVvrOh3nWyFfffMd1itZTgDo9jF3XoeOciyGkFgAu8AHfXzZcm
 FLuYJjRqrlsxLRWOGG1OSHVrwqmF1Mkko9dp+tHn8lSEr4SSbB/hvqEB22e3H0ZCjjLj
 OgYEGExrNkdCmq2yBNnkrNhm8wH44yE2wvkB+zNwK4fsaJSrnsEpFVtdizuovgRsuAzg
 Ux6R7iatPNkPp3aBAwU0zqfcL+2nizWSxTdCX91iT2Z8WfA8cz9uaaAZSmel6xGHRUwE
 ngEg==
X-Gm-Message-State: AOJu0Yzzbq/OqjmxtFvJ5FWDFypUwegb/l2mZUgH4jOiKRx2YnBygCTy
 J9AwonBFy9ygKMI5YTNWBc5V9oCOfkHavw==
X-Google-Smtp-Source: AGHT+IHvKSLabCBxu6vUdqJBK1lxhjWAt7kIKaDyTKxM3kfyHgnT9LGDoyNzZrPphvxqUYubwx+heg==
X-Received: by 2002:a05:6870:7186:b0:205:d58c:aed8 with SMTP id
 d6-20020a056870718600b00205d58caed8mr807039oah.0.1704849410437; 
 Tue, 09 Jan 2024 17:16:50 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e32c:1ab8:3100:c37f])
 by smtp.gmail.com with ESMTPSA id
 a36-20020a634d24000000b005c2967852c5sm2166833pgb.30.2024.01.09.17.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 17:16:50 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v4 0/4] cmd: bootefi: refactor the code for bootmgr
Date: Wed, 10 Jan 2024 10:16:33 +0900
Message-Id: <20240110011637.174710-1-takahiro.akashi@linaro.org>
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

This patch set is motivated by the discussion[1] regarding
CONFIG_BOOTEFI_BOOTMGR option.

# This version (v4) contains only the remaining commits.

At the end, bootefi.c will be decomposed into two parts, one for
providing the command itself and one for implementing helper functions.
EFI_LOADER will now be available without CONFIG_CMDLINE or specifically
CONFIG_CMD_BOOTEFI if invoked via bootmeth/bootstd.

Then, EFI_LOADER library side will be further split into two options
for fine-grain control:
CONFIG_EFI_BINARY_EXEC: execute UEFI binaries which are to be explicitly
    loaded by U-Boot's load commands/functions or other methods
    (like a jtag debugger?)
    It supports bootmeth_efi as well as "bootefi <addr>|hello"(/"bootm"?).

CONFIG_EFI_BOOTMGR: provide EFI boot manger functionality
    It supports bootmeth_efi_mgr as well as "bootefi bootmgr".

As such, We will no longer need CONFIG_EFI_BINARY_EXEC if we want to only
make use of the UEFI boot manger for booting a next stage OS.

Prerequisite
============
This patch set is based on top of the latest "master" branch.

Tests
=====
* ran and passed py/efi_selftest on sandbox locally
  (I saw an error in tcg2 though)
* ran and passed py/test_efi_bootmgr on sandbox locally
* passed CI check (github pull request)

Changes
=======
v4 (Jan 10, 2024)
* rebased onto the latest master branch
* moved binary execution portion of code (EFI_BINARY_EXEC) to
  a new file, efi_bootbin.c, instead of efi_helper.c (patch#1)

v3 (Dec 18, 2023)
* rebased onto Tom's latest next branch
* remove already-merged commits

v2 (Nov 21, 2023)
* rebased onto Tom's next branch
* remove already merged commits
* revise commit messages
* add patch #5 which was split from ex-patch#5
RFC (Oct 26, 2023)

[1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html

AKASHI Takahiro (4):
  efi_loader: split unrelated code from efi_bootmgr.c
  efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
  net: tftp: remove explicit efi configuration dependency
  fs: remove explicit efi configuration dependency

 boot/Kconfig                     |   4 +-
 boot/Makefile                    |   2 +-
 cmd/Kconfig                      |  10 +-
 cmd/efidebug.c                   |   4 +-
 fs/fs.c                          |   7 +-
 include/efi_loader.h             |  28 +-
 lib/efi_loader/Kconfig           |  11 +-
 lib/efi_loader/Makefile          |   3 +-
 lib/efi_loader/efi_bootbin.c     | 211 +++++++++++++
 lib/efi_loader/efi_bootmgr.c     | 488 -------------------------------
 lib/efi_loader/efi_device_path.c |   3 +-
 lib/efi_loader/efi_helper.c      | 286 ++++++++++++++++++
 net/tftp.c                       |  10 +-
 test/boot/bootflow.c             |   2 +-
 14 files changed, 546 insertions(+), 523 deletions(-)
 create mode 100644 lib/efi_loader/efi_bootbin.c

-- 
2.34.1

