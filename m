Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52549C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 02:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590DA87CD4;
	Mon, 18 Dec 2023 03:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vHUPq0F7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D922987CE6; Mon, 18 Dec 2023 03:39:02 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 163B887CB2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d3b84173feso1328705ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702867138; x=1703471938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sNrJrXKjkpK+OKpLFB+1wnXI02qAudN/5Q+vKHOIFTk=;
 b=vHUPq0F7Q70+ukgiYG8XEFvUhZJzaSjUkduwmvGyIHvenPKg1YVLjECZZpSUR+xXgY
 rKvm3hSVkKq+6aBIKplIo/yLc2Ndp3aKMM6gysGVSrMlCxfoyRij4L1L3VYou4HKLIyN
 +0JrhgqPVSDlvp0uIGirsKexrjm3c4i+xzQh9W5FFak8mrsm1HChbVCCzB3nw88mlkIu
 x2kVCc44gcUsgvWgCDNIgMQn2uZJvzfU0bArY4hPNEAgV3/wC4aohwM6ZSd4I+mLxxXh
 N9MepR57epBcghsbbbXdlwUhj95p3FkVB0y2uGXcrq8M2uwDPPKqJ+VykHxfUxxlRh9I
 1hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702867138; x=1703471938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNrJrXKjkpK+OKpLFB+1wnXI02qAudN/5Q+vKHOIFTk=;
 b=ll6Vhd34D5vd51Vc+Y4+WdI6Qeq1sbX1V1D4Qf9b5BycjKG4wA6DwzC0Dzn47hSGxn
 fBq/EUg0aLmFlPZnJx+09Ah9g5ylWUZh7qjgnfDJeSImCzEhM++Xjj5a+RwP4l8USP0P
 dSRzKjljEPGRNYqHrAJ/yDGXtlV0N3zGNsy6ULhb1uOi4i3MoIxyMRfKAnjjgmo7xGQg
 FCDv/Q0eVFC8imvQYiZEisgKi1Nlj6AIySBIxGi/ge2m7DTib3Mgq4QEbN3XAhEb0KqS
 E7o5fh75+O1W9smWphPqjLcOAzWsAPPR88MZTgtWYucAARDPoc+t+HTHZCOZx39w67F7
 3DrQ==
X-Gm-Message-State: AOJu0Yy9MerbQa/6W9FsrNrvMK81Pg1EM4cEN8qConP9koryzQkIphZy
 joPJXGgfoJMnbwOSJHBgq5ATNQ==
X-Google-Smtp-Source: AGHT+IGM4pPc5IoojSf88JUw3C17n3PGmPJj9w7g77BqW90roRB9H9wG1QHkdqoZs32OR9HcnDT8Rg==
X-Received: by 2002:a17:902:d48b:b0:1d0:73ca:660 with SMTP id
 c11-20020a170902d48b00b001d073ca0660mr31776140plg.4.1702867138261; 
 Sun, 17 Dec 2023 18:38:58 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:a448:a260:721d:a9f0])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a1709029a9800b001d316770044sm13754305plp.56.2023.12.17.18.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 18:38:57 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 0/4] cmd: bootefi: refactor the code for bootmgr
Date: Mon, 18 Dec 2023 11:38:38 +0900
Message-Id: <20231218023842.281336-1-takahiro.akashi@linaro.org>
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

# It has been partially merged in -next branch. So this version (v3)
# contains only the remaining commits.

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
This patch set is based on top of Tom's latest "next" branch.

Tests
=====
* run UT efi_selftest on sandbox locally
* run test_efi_bootmgr on sandbox locally

Unfortunately, I could not submit a pull request for CI test.

Changes
=======
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
 lib/efi_loader/Makefile          |   2 +-
 lib/efi_loader/efi_bootmgr.c     | 493 ------------------------------
 lib/efi_loader/efi_device_path.c |   3 +-
 lib/efi_loader/efi_helper.c      | 499 ++++++++++++++++++++++++++++++-
 net/tftp.c                       |  10 +-
 test/boot/bootflow.c             |   2 +-
 13 files changed, 544 insertions(+), 531 deletions(-)

-- 
2.34.1

