Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21AFC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 04:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F290A87559;
	Wed, 17 Jan 2024 05:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lFuDSQSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B120387559; Wed, 17 Jan 2024 05:39:55 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321A6875FE
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d5ea64bbc1so2509005ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 20:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705466391; x=1706071191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oW+x737jbjprx57Gkuw2tAmswLyQqi/9DFWlxBXABes=;
 b=lFuDSQStyzGP3DEbM0c9M6erEUZ9BpaDRerbzHEbw1STTlTK5spO+Cnc/8iN7kgXT7
 WR11xnFLRnIDZl8CvtKcUX6Wkb+BSMhKy/XOnpnX37Gw0ZHevPEEBmNnTHBk6XjAQ0Qs
 Q1CQXQ4kyN6RGSr/mwDaAawP2S5QrY3ZmgTrL2WJOm2gF5tFUeP2nCr1J/GT54G7PSEI
 we4bQhX78UNjDn4a2zn1tYYj4RfOQ8z3Q4W3jCZGzgkoV0ctbXxB9xHCFnEou/DdWhT5
 v5V9Lh67DeiEvDZ/K2I4xd9L31sOoWCaNJ1UQHZV8de4ug4cfXGOkv55JKkFzBFY5Xv8
 NeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705466391; x=1706071191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oW+x737jbjprx57Gkuw2tAmswLyQqi/9DFWlxBXABes=;
 b=a0nHzT4tYMutxELCY1hUk6arrwLqAeSGl2f+b/WctgSzyndBda183D0w7E2bCJeybk
 eWTQQphM4CyWBt0GsuO/hgqDsc+T9lNgh+MwqjlU3kJ7JGUhhug5Zo2dNnFF8P65YQwo
 q/vO5/kJCydLoDJYZWboEqddjUYesZURNHOgrKBb1KNtkbRqUZBvPav8FhLqg6bIF1dL
 N0E+wODW+hTAYLokBCRG5XJHkAK/LX+eabR6N7BUSKhqpufHjr87fbccrRxdsVGCqVln
 zQL7Ws/8xiHEl2Q6CprNKuNsYpXTK9g3FXwv8Io7E7BYQ1plp9yhRdjHZuHBoC4bYptY
 xtwg==
X-Gm-Message-State: AOJu0YzR94Ui8ZFRLymtMQzRrzTtYTLk0Xo3VmIJj81Jc9OFUDiFUKz2
 dYiGs2l7nVzYGhJRt4fEL1qt4y+EBkp4MA==
X-Google-Smtp-Source: AGHT+IFbc2IPVgvdSqdPB0VPU1yQAN3OxeggMQ4jeEAQ1Ayj2+MWGq74w7zjTNhkxbZPB+yl/rQy3A==
X-Received: by 2002:a17:902:a50b:b0:1d5:bcc2:2bac with SMTP id
 s11-20020a170902a50b00b001d5bcc22bacmr11757074plq.1.1705466391340; 
 Tue, 16 Jan 2024 20:39:51 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:e481:26af:1a49:433a])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a170902ea1100b001d403969bf4sm10048668plg.309.2024.01.16.20.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 20:39:51 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 0/4] cmd: bootefi: refactor the code for bootmgr
Date: Wed, 17 Jan 2024 13:39:40 +0900
Message-Id: <20240117043944.477358-1-takahiro.akashi@linaro.org>
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

# This version (v5) contains only the remaining commits.

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
* ran and passed py/test_efi_bootmgr on sandbox locally
* passed CI check (github pull request[2])

Changes
=======
v4 (Jan 17, 2024)
* rebased onto the latest master branch again

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
[2] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7760&view=results

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

