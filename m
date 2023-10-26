Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12893C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F00487ADA;
	Thu, 26 Oct 2023 07:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KpIgqTUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00F987AE3; Thu, 26 Oct 2023 07:31:18 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 028C38755E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6bb744262caso113093b3a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298272; x=1698903072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3kwsvL4rKbgWqOLjp2zBIkwHCyoilydeGcjvJoEOjhw=;
 b=KpIgqTUJNyA3ifO0R1nyDQaSE3yNAKUkZ8iLQc5RbZCNa+993pfdVAa+QxOZ1hIbJZ
 yE7t5v8XI7gaDhb5aPWb2ASWedFfwk7lytYFLcOpiGNEuPwF7sqdfzo6IeEH3k6LIzRr
 jO0RO6XTo5PKDlyqgJQp5Z6b33LOQNbWr3x+fOkU02X9XT/eiJ/kx6Jf6jPYg4q5fBLz
 mN7R85QTduVafQH/C/sc64wwxxoFDmtQmcf++P0HS8w30dZEGOw+9NPfIFktwWkGp9ih
 47ptLU0BpvHuUotCM6yihfXAbTwjtctf8KsJpYqPKgGSpCJUSMmNNCAWv1T8HcmtJcR4
 VF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298272; x=1698903072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3kwsvL4rKbgWqOLjp2zBIkwHCyoilydeGcjvJoEOjhw=;
 b=Aoo23j0E1tOxtp4S/Z+aP3w5IrWRS0pBO3ZS6l5JwAd17uR+4NAIivkcHDGq/mIzVU
 CXnJoHMfiFMgpsTgf3FWGGxkwybU1MXY6vG8bTsV52kvmdxJDcnYaLovabW1uvWc+DAx
 7dcdcskqGqm20EiQ9Z4n40kEkxBvCAPyUzVvg4Y2rD56Hw/IJtqirkPKz0b+YOPqoN+v
 O9Muu5cgYSOkPjQGrHS58jU0ukEgjEc5UrgvVd/w97He6v6rtBpvgpfCerv2f7gHcz23
 0FyDAjYwWgVnvbTalIjFdUEBgUJKMrhM2Ff2GgKNiHxk0+6fDr1AaZIoY2W7KjWmmo6c
 Lv2A==
X-Gm-Message-State: AOJu0YzAg8Q6/2IagN1a+l/vCGJgToQZ0YZY/OFEV4WPHAHyvcWAZT+Z
 TV1AWLA+1buiBljxYLAJMNYrfg==
X-Google-Smtp-Source: AGHT+IEPOXyHN0GV9V5XHktC5r5qSrZjgFGkEvwOBlIqsIkSqLBAp1hjfrbLlkeg/nu7vRJ7y4hDMw==
X-Received: by 2002:a62:b518:0:b0:690:c79c:1912 with SMTP id
 y24-20020a62b518000000b00690c79c1912mr17004732pfe.0.1698298272072; 
 Wed, 25 Oct 2023 22:31:12 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:11 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 00/13] cmd: bootefi: refactor the code for bootmgr
Date: Thu, 26 Oct 2023 14:30:39 +0900
Message-Id: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

As such, We will no longer need CONFIG_BINARY_EXEC if we want to only
make use of the boot manger for booting a next stage OS.

Prerequisite
============
This patch set is based on top of Simon/Tom's [2].

Patches
=======
Patch#1-#11: I hope that those commits show step-by-step refactoring
    without introducing degradation.
Patch#12-#13: Those are not directly related to the patch's aim, but
    they are necessary to compile U-Boot on sandbox (sandbox_defconfig)
    without CONFIG_CMDLINE.

[1] https://lists.denx.de/pipermail/u-boot/2023-October/534598.html
[2] origin/TEST/v4.1-tidy-up-use-of-CONFIG_CMDLINE

AKASHI Takahiro (13):
  cmd: bootefi: unfold do_bootefi_image()
  cmd: bootefi: re-organize do_bootefi_image()
  cmd: bootefi: carve out EFI boot manager interface
  cmd: bootefi: carve out binary execution interface
  cmd: bootefi: move library interfaces under lib/efi_loader
  cmd: efidebug: ease efi configuration dependency
  bootmeth: use efi_loader interfaces instead of bootefi command
  efi_loader: split unrelated code from efi_bootmgr.c
  efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
  net: tftp: remove explicit efi configuration dependency
  fs: remove explicit efi configuration dependency
  lib: uuid: move CONFIG_RANDOM_UUID
  block: rkmtd: select CONFIG_RANDOM_UUID explicitly

 boot/Kconfig                     |   4 +-
 boot/Makefile                    |   2 +-
 boot/bootm_os.c                  |  31 +-
 boot/bootmeth_efi.c              |   8 +-
 boot/bootmeth_efi_mgr.c          |   3 +-
 cmd/Kconfig                      |  28 +-
 cmd/bootefi.c                    | 658 +++++--------------------------
 cmd/efidebug.c                   |   4 +-
 drivers/block/Kconfig            |   1 +
 fs/fs.c                          |   7 +-
 include/efi_loader.h             |  34 +-
 lib/Kconfig                      |   7 +
 lib/efi_loader/Kconfig           |  11 +-
 lib/efi_loader/Makefile          |   2 +-
 lib/efi_loader/efi_bootmgr.c     |  37 ++
 lib/efi_loader/efi_device_path.c |   3 +-
 lib/efi_loader/efi_helper.c      | 486 ++++++++++++++++++++++-
 net/tftp.c                       |  10 +-
 test/boot/bootflow.c             |   2 +-
 19 files changed, 697 insertions(+), 641 deletions(-)

-- 
2.34.1

