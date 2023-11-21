Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591ECC61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED80864F3;
	Tue, 21 Nov 2023 02:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N/ADTx+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21F1863FD; Tue, 21 Nov 2023 02:30:33 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B638787574
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc4d306fe9so11476045ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530225; x=1701135025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=76tZkttpQ59SBC1wgjh8PE00HYrKNFYQFT9iE1422CM=;
 b=N/ADTx+CEinXW337+tTLSPZ2FBurq1ztlnVYicCsACXVvush+TAxCors35onheQN8S
 KsB94utZF1k7y3Qntd83DVmcEIQy2vdy9V5Pv3KY8oEyhPVIipdjxlNwTwAk7GYu+TSa
 PuDp1fe7rupQXEB/tD7CSiQKSrmHhVowAUGCTpTN7eHgQrCXJ0GzNC3zHrso4iGcomto
 kCOy1E5Xb3p7OzQUNbzRbnpF5ON4nAyvhIXUyVzq0pN2n8Nxn7Ck1vXdqwsap+V6kU+J
 2TkV1oJifgRLi97fg951waEUDt7TMG4QOho01iROqFdS+vAWxQ3q+dzmiv1q1H0prNWI
 Rdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530225; x=1701135025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76tZkttpQ59SBC1wgjh8PE00HYrKNFYQFT9iE1422CM=;
 b=gBYnZfMXsJelqyPd5CeZGcOoD3SEZC84ie9xbWNbUjpgi3imVJkumm9ydoEqpBehJW
 HErLmK74xrNDe0ulQwqgESTp5LRYg+M84g4T54YAPskGSbP/kcRvDHkNTatTMUjY1kOI
 +SCll4bC4Y/DTAJHr2PCI5ApuNlBzjFw9MauPnmBtbAl0qoZiZeXXJ3W1aHScuNvmBUu
 X+pFm7SFWFNf5nVN67373o2027EqF2PUtUP+L16cYpNtxNopx/BlWYwb5JpbalDUaIgz
 +japXXvuRyepFdCd6VhHTsub8FQEgbh5bm/E9Uy/e9faW7VezCVioEjeahmwfFuGYseS
 VeDw==
X-Gm-Message-State: AOJu0YwBJNXcR48ww6VmXyjIrpLYdPpvWB06r85zh6fhZpS9V3kxTBea
 zIagjzkjGUbpCW7GX1tZZ6xibQ==
X-Google-Smtp-Source: AGHT+IGDvMETE8UTRIuP7Cjm27VJFn4lf++mhzRz/QjKw4IEhvUrX1PpxxByCt3JZL7tiuwrGdErMQ==
X-Received: by 2002:a17:902:f688:b0:1c3:a4f2:7c99 with SMTP id
 l8-20020a170902f68800b001c3a4f27c99mr11874422plg.4.1700530224663; 
 Mon, 20 Nov 2023 17:30:24 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:24 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 00/12] cmd: bootefi: refactor the code for bootmgr
Date: Tue, 21 Nov 2023 10:29:38 +0900
Message-Id: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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
This patch set is based on top of Tom's "next" branch.

Patches
=======
Patch#1-#12: I hope that those commits show step-by-step refactoring
    without introducing degradation.

Tests
=====
* run UT efi_selftest on sandbox locally
* run test_efi_bootmgr on sandbox locally

Unfortunately, I could not submit a pull request for CI test.

Changes
=======
v2 (Nov 21, 2023)
* rebased onto Tom's next branch
* remove already merged commits
* revise commit messages
* add patch #5 which was split from ex-patch#5
RFC (Oct 26, 2023)

[1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html

AKASHI Takahiro (12):
  cmd: bootefi: unfold do_bootefi_image()
  cmd: bootefi: re-organize do_bootefi()
  cmd: bootefi: carve out EFI boot manager interface
  cmd: bootefi: carve out binary execution interface
  cmd: bootefi: localize global device paths for efi_selftest
  cmd: bootefi: move library interfaces under lib/efi_loader
  cmd: efidebug: ease efi configuration dependency
  bootmeth: use efi_loader interfaces instead of bootefi command
  efi_loader: split unrelated code from efi_bootmgr.c
  efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
  net: tftp: remove explicit efi configuration dependency
  fs: remove explicit efi configuration dependency

 boot/Kconfig                     |   4 +-
 boot/Makefile                    |   2 +-
 boot/bootm_os.c                  |  31 +-
 boot/bootmeth_efi.c              |   8 +-
 boot/bootmeth_efi_mgr.c          |   2 +-
 cmd/Kconfig                      |  21 +-
 cmd/bootefi.c                    | 670 +++++--------------------------
 cmd/efidebug.c                   |   4 +-
 fs/fs.c                          |   7 +-
 include/efi_loader.h             |  34 +-
 lib/efi_loader/Kconfig           |  11 +-
 lib/efi_loader/Makefile          |   2 +-
 lib/efi_loader/efi_bootmgr.c     |  37 ++
 lib/efi_loader/efi_device_path.c |   3 +-
 lib/efi_loader/efi_helper.c      | 498 ++++++++++++++++++++++-
 net/tftp.c                       |  10 +-
 test/boot/bootflow.c             |   2 +-
 17 files changed, 700 insertions(+), 646 deletions(-)

-- 
2.34.1

