Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EFAC47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923CC87A34;
	Mon,  8 Jan 2024 01:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LkFdebgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDA087A34; Mon,  8 Jan 2024 01:22:13 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4633787955
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f8d9fe99fso13448226d6.2
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704673328; x=1705278128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bhi1noj4chDUEfvvxguKntYP0bLt/vV3ewRKtJlz3ao=;
 b=LkFdebgja/ZSt7+nJThK2qC2R1uzpatw7FJ+gHrCdcgwj9e4MaAtc6YW/SsYYaR3k/
 EJGVTqNqmyPhV4h7+h/h89piCuOFZkP8qTiFkGpG3khQhfOrunOibT9wIA0lKvOEIQlZ
 FIvqrqkwIPArw+4KPXjamNxELdHxP0tsi26qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704673328; x=1705278128;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bhi1noj4chDUEfvvxguKntYP0bLt/vV3ewRKtJlz3ao=;
 b=nktlpNvzlF6sDl2Zgm6e5U/Eb+K2LcMT8LOhRiYy5DupTUYbT5nlbsUfUdjaYLqrig
 CV4pH3Yj2EeVZtC46sfUMCmKqoiphtnN1pkf4hk1j0DrjQeYrzInIpgqEnX/yIZPeLpU
 KhUBHe872ESej8IInS7NwG61XG6Io5tRj7MbA0X22B++dp10Fwn4J/ntUeYJvqqhSW9z
 3JeJit7MzJF9XbktHIeTLXcA6OpCg3MfcrRmEqoTgCflreFOPmv8dpO13Z6lQYCMhsNM
 LFYWI2JqZ66GIzt6gUTZg/J+1z1/4L/ehMjOPX2K3ZZD1PmGyJaootoi6fb6huH6hVF6
 MGUQ==
X-Gm-Message-State: AOJu0YxHKntqXrD5TYctAgNBhj+bNYh7dES2X61mXUV/MV3Cyg2jArN4
 dDvOiaJyVPyIpj3d5tqgF76IwgURHvM+q6ro1IKGkdp5y6FQ0QrTFqJXg0Amog==
X-Google-Smtp-Source: AGHT+IFztczR6B17QQMANcMvAoew4z2qiEuk19vAwPFzQw0Yu242FvXjF5/icsVFiKF+0H6YFcuMkxiWxSEsozeTpg0=
X-Received: by 2002:ad4:4ea4:0:b0:67a:cdb1:d0f3 with SMTP id
 ed4-20020ad44ea4000000b0067acdb1d0f3mr4292072qvb.35.1704673328021; Sun, 07
 Jan 2024 16:22:08 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jan 2024 17:21:57 -0700
Message-ID: <CAFLszThp=VqYAR7FB0i4Ni3yd9wJvD63_QP7_pb2+2fRhXxBAg@mail.gmail.com>
Subject: Please pull u-boot-dm/next
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

This is for -next


https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/19216

https://dev.azure.com/simon0972/u-boot/_build/results?buildId=58&view=results


The following changes since commit c2c598e87cfe56f5991730762c00733c5aa9a994:

  Merge branch 'staging' of
https://source.denx.de/u-boot/custodians/u-boot-tegra into next
(2024-01-06 09:57:56 -0500)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-next-7jan23

for you to fetch changes up to 8c4b37ce97c27ad4e7f83b028d4cd1396a51a36f:

  arm: enable support for QEMU firmware tables (2024-01-07 13:49:15 -0700)

----------------------------------------------------------------
switch to SMBIOS3 tables
allow devicetree from bloblist
ACPI support for ARM and RISC-V

----------------------------------------------------------------
Heinrich Schuchardt (14):
      smbios: SMBIOS 3.0 (64-bit) Entry Point structure
      acpi: use 64-bit addresses in FADT table
      cmd: acpi: fix listing DSDT and FACS
      cmd: acpi: check HW reduced flag in acpi list
      acpi: support 64bit in acpi_find_table for DSDT and FACS
      acpi: Kconfig symbol CONFIG_QFW_ACPI
      acpi: carve out qfw_acpi.c
      arm: add ACPI fields to global data
      riscv: add ACPI fields to global data
      acpi: enable writing ACPI tables on QEMU
      riscv: add support for QEMU firmware tables
      riscv: allow usage of ACPI
      configs: qemu: add config fragment for ACPI
      arm: enable support for QEMU firmware tables

Simon Glass (12):
      smbios: Refactor 32-bit code into an else statement
      smbios: Move the rest of the SMBIOS2 code
      smbios: Use SMBIOS 3.0 to support an address above 4GB
      smbios: Correct gd_smbios_start()
      efi: Use the correct GUID for the SMBIOS table
      smbios: Require the caller to align the SMBIOS table
      smbios: Drop support for SMBIOS2 tables
      efi: smbios: Drop support for SMBIOS2 tables
      acpi: Rename test dm_test_setup_ctx_and_base_tables()
      acpi: Write pointers to tables instead of addresses
      efi: Correct smbios-table installation
      fdt: Allow the devicetree to come from a bloblist

 MAINTAINERS                          |   1 +
 arch/Kconfig                         |   1 +
 arch/arm/include/asm/global_data.h   |   7 ++-
 arch/riscv/include/asm/global_data.h |   6 ++
 arch/sandbox/include/asm/io.h        |  16 ++++++
 arch/x86/cpu/baytrail/acpi.c         |   9 +--
 arch/x86/cpu/quark/acpi.c            |   9 +--
 arch/x86/cpu/tangier/acpi.c          |   9 +--
 arch/x86/lib/acpi_table.c            |  15 ++---
 board/emulation/configs/acpi.config  |   3 +
 board/emulation/qemu-arm/Kconfig     |   1 +
 board/emulation/qemu-riscv/Kconfig   |   2 +
 cmd/acpi.c                           |  24 +++++---
 doc/board/emulation/acpi.rst         |  23 ++++++++
 doc/board/emulation/index.rst        |   1 +
 doc/develop/devicetree/control.rst   |   3 +
 drivers/misc/Kconfig                 |   7 +++
 drivers/misc/Makefile                |   1 +
 drivers/misc/qfw.c                   | 240
------------------------------------------------------------------------------
 drivers/misc/qfw_acpi.c              | 281
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_table.h            |   6 +-
 include/asm-generic/global_data.h    |   2 +-
 include/efi_api.h                    |   4 ++
 include/fdtdec.h                     |   6 +-
 include/mapmem.h                     |  18 ++++++
 include/smbios.h                     |  41 ++++++++++++--
 lib/acpi/Makefile                    |   2 +-
 lib/acpi/acpi.c                      |  37 +++++++++---
 lib/acpi/acpi_table.c                |   4 +-
 lib/acpi/acpi_writer.c               |   4 +-
 lib/acpi/base.c                      |   4 +-
 lib/efi_loader/efi_smbios.c          |  28 ++++++----
 lib/fdtdec.c                         |  44 +++++++++++----
 lib/smbios.c                         |  55 ++++++------------
 test/dm/acpi.c                       |  14 ++---
 35 files changed, 556 insertions(+), 372 deletions(-)
 create mode 100644 board/emulation/configs/acpi.config
 create mode 100644 doc/board/emulation/acpi.rst
 create mode 100644 drivers/misc/qfw_acpi.c

Regards,
Simon
