Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD9EC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37D58206E;
	Thu,  3 Jul 2025 13:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cjfC6ipk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8AF82103; Thu,  3 Jul 2025 13:07:01 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F14A680E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso13054340a12.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540818; x=1752145618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gbYuZlDliKnSpgG9WzpcvqTplx8kSeMp/yKEjxHikQE=;
 b=cjfC6ipkrenlO0IahB0ZTG14hCjRgntiP7G3h9KpltOZBxkB0LwFXezJWfUXMn4sFW
 Id4JSmp2veTKQw4ur5UJAqRLEGYjLaLF8YK3TbLDblif+vMRfHGlLsM6LGqtfxmV/P2m
 ow8omHAMltd+k6AuiENh00Jxm0YYA9TIxx4kyMUBk34Iee+538f+HUT6KMOjComsd3R6
 iXa1aDPm+rYgEmMFXcVEFmiiOG0Uc1wxScoCptpU9r3M2wCwHe2kW/O2nQFEpyPghzFU
 ejZaUGZJvh9NagUnD+mZIFXyGTCi/z0697TOzc+izDJuEJX+OhyAwb8QUcqB0LSETYiu
 KLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540818; x=1752145618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbYuZlDliKnSpgG9WzpcvqTplx8kSeMp/yKEjxHikQE=;
 b=jg0lfAElwmoNG8HzfbZDHeJAL++oAg2H2slGxpnGPuEZnGEDwloTDoYfTRH3CHdWvs
 +cS4kcUWCZJFwISzsjM0HQlWrQTzNs6vvG6ab6bzyg3t755Ixtth7tjZrVg1GdTtrZ22
 9OLACKvfTNfrG8tjoNPyzymv8DfF9knK9XRBLUwC7+/1H1pHFpI1ONH0a0QFrDIFV57/
 2TdyBzost2h57KhRDMDExyekBsIxY2WrfGwS30z9d9Rcln6pkg2OzYhluDpG8zk9PNdZ
 9OSGqBaau48MJqMBJqlDFxtlVN4xf+TbMerz6gQMv6Fn2VmwkaD7B6BS5yD/IqnA8Gt2
 McdQ==
X-Gm-Message-State: AOJu0Yyok5dQGtM7p2AxjRAsYRL0Ou/KSvKWePyXTvaR8tk1eJ02txJQ
 J9cJ3sKiw9JZIfSsHxOAgP2OpnmmJm71Ni3Jfwaz/YoukgUeISDunrzgk2qEI9s5mackxPtkXhW
 eHOlFNvBaJQ==
X-Gm-Gg: ASbGncuqyQBPLkiZXr1yOBpTcc2Arow0iMIdksGIgYN5A861QAm211ku99T02yvcBwO
 zB9reUx5jFbA+vJBNFw80ZsyqzdcXrGVGp1aEQYyaFAlP1DSUsMnHTpodslmWJcn1j+xwlnaVLR
 vUb/cuU+aHps4PuvHKoBURyYWqTG0CunPBimT9RiU3c/F3FNOent5d1xm8Qdk2phpwU4PrAFg3G
 FQAiUlI9SrjWMdz0EEb5R44svPcuv7qMO7QvDVcP6QdgdoWDuCFYCustJ9LBuTgRae8qAmuanpH
 09URmWK3MgbTXb0kOWdkvnxxC0L+2hzJ36vKLEnItvwz56JOiUbIFL2i/w6ftoAbC3fE2X4GNxQ
 tlQlZ59iI2mQVDhRTOKhk
X-Google-Smtp-Source: AGHT+IFsmlZ0WfqZlNDvglpmiZ4dT5ga9mKP6bk4UDL7p0HgZFGgybtJHKlFnmTbmnmu6JqyS0AFwQ==
X-Received: by 2002:a05:6402:d0b:b0:608:2e97:4399 with SMTP id
 4fb4d7f45d1cf-60e52ce9057mr6182929a12.4.1751540818268; 
 Thu, 03 Jul 2025 04:06:58 -0700 (PDT)
Received: from hera.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c828bbb0fsm10548538a12.14.2025.07.03.04.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 04:06:57 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, paul.liu@linaro.org,
 sughosh.ganu@linaro.org, javierm@redhat.com
Subject: Pull request for efi-next-03072025
Date: Thu,  3 Jul 2025 14:06:55 +0300
Message-ID: <20250703110655.482467-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Hi Tom
A pull request for EFI coming from the TPM tree.
New protocols are added to the EFI subsystem
- Android Generic Bootloader (an EFI app loading Android) needs
  EFI Debug Support Table for hardware assisting debugging.
- EFI_PARTITION_INFO_PROTOCOL is needed by a new OS Loader Redhat is
  working on that natively supports A/B filesystems via EFI.

Sughosh added EFI HTTP support to eficonfig and finally Andrew fixed
more issues reported by smatch.

The following changes since commit c405bab7661dd60420e97a4edeb3162e9d7e02c5:

  Merge tag 'mmc-next-2025-07-02' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2025-07-02 07:51:57 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/efi-next-03072025

for you to fetch changes up to 95732f2bf8700f9ec17983b419073b6a16b79aef:

  efi_loader: add dbginfodump.efi (2025-07-03 12:26:45 +0300)

The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/26935
seems happy

Please pull!
/Ilias

----------------------------------------------------------------
Sughosh added EFI HTTP(s) support into our eficonfig application. Up to
now we could only enable that via our efidebug command. Users now get that
option on the eficonfig menu.

Javier implemented support for the EFI_PARTITION_INFO_PROTOCOL,
to provide cached partition information for GPT partition types.
The protocol describes legacy MBR partition types, but that's for backward
compatibility and not implemented by this series.
The protocol is needed by [0], an implementation of a UEFI based A/B boot
mechanism for the root filesystem.

Paul added support for EFI Debug Support Table feature. This is part of the
EFI spec and is defining a hardware-assisted debug protocol which provides a
standardized mechanism for debuggers to discover and interact with system-level
resources. Google currently uses it to debug their Generic Bootloader
project [1][2], using EFI to load Android. Heinrich contributed a test EFI
application for it as well.
The efi_realloc() function he added will realloc any type of memory to
BootServicesData, but keeping in mind the new protocol is the only consumer
he will fix that on a followup patch. Also the protocol is enabled by default if
!HAS_BOARD_SIZE_LIMIT for a wider CI testing. We will disable it shortly
after and enable it only for QEMU arm and arm64.

Finally another round of smatch fixes from Andrew cleans up coding errors.

[0] https://gitlab.com/CentOS/automotive/src/ukiboot
[1] https://lpc.events/event/18/contributions/1704/attachments/1550/3231/Android%20Generic%20Boot%20Loader.pdf
[2] https://source.android.com/docs/core/architecture/bootloader/generic-bootloader

----------------------------------------------------------------
Andrew Goodbody (3):
      efi_loader: Prevent dereferencing NULL pointer
      efi_loader: Prevent dereference of uninitialised variable
      efi_loader: Prevent free of uninitialised pointer

Heinrich Schuchardt (1):
      efi_loader: add dbginfodump.efi

Javier Martinez Canillas (4):
      disk: efi: Move logic to get a GPT entry into a helper function
      disk: efi: expose the part_get_gpt_pte() helper function
      efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL support
      efi_selftest: Add basic partition info check to block io test

Sughosh Ganu (2):
      cmd: eficonfig: add support for URI device path based boot options
      test: wget: add a test case for validating URI

Ying-Chun Liu (PaulLiu) (5):
      efi: add EFI_SYSTEM_TABLE_POINTER for debug
      efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
      lib: efi_loader: efi_memory.c: add efi_realloc() for realloc memory
      efi: add EFI_DEBUG_IMAGE_INFO for debug
      efi: selftest: add selftest for EFI_DEBUG_SUPPORT

 cmd/eficonfig.c                               | 146 ++++++++++-
 disk/part_efi.c                               |  67 +++--
 include/efi_api.h                             |  71 +++++
 include/efi_config.h                          |   2 +
 include/efi_loader.h                          |  19 ++
 include/part.h                                |  14 +
 include/part_efi.h                            |  20 ++
 lib/efi_loader/Kconfig                        |   9 +
 lib/efi_loader/Makefile                       |   2 +
 lib/efi_loader/dbginfodump.c                  | 356 ++++++++++++++++++++++++++
 lib/efi_loader/efi_boottime.c                 |   7 +
 lib/efi_loader/efi_debug_support.c            | 183 +++++++++++++
 lib/efi_loader/efi_disk.c                     |  39 ++-
 lib/efi_loader/efi_file.c                     |   2 +-
 lib/efi_loader/efi_http.c                     |   9 +-
 lib/efi_loader/efi_memory.c                   |  58 +++++
 lib/efi_loader/efi_net.c                      |   2 +-
 lib/efi_loader/efi_setup.c                    |  18 ++
 lib/efi_selftest/Makefile                     |   2 +
 lib/efi_selftest/efi_selftest_block_device.c  |  30 +++
 lib/efi_selftest/efi_selftest_debug_support.c |  40 +++
 test/cmd/wget.c                               |  20 ++
 22 files changed, 1072 insertions(+), 44 deletions(-)
 create mode 100644 lib/efi_loader/dbginfodump.c
 create mode 100644 lib/efi_loader/efi_debug_support.c
 create mode 100644 lib/efi_selftest/efi_selftest_debug_support.c
