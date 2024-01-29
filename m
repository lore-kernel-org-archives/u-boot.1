Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF85FC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 21:18:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BABC87C20;
	Mon, 29 Jan 2024 22:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g8M1dAWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E05587C5B; Mon, 29 Jan 2024 22:18:35 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A5F87BEE
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 22:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0BB223F27B; 
 Mon, 29 Jan 2024 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706563111;
 bh=Loye6XihssZQe0dunjZfLiWFSoF+MwTKEhR0P9AFnN4=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=g8M1dAWutlSdhg6SXBEwEC+CHCaVExocg6G/hOukNXV5wx5lf+/RuFK5fPKpEOJsM
 GkvYD3LvkXaH6/16rwXG5QVc5llLrz+UNb+ZS+YT+VaHSSSIAysnZM6rm4F8QL3zZt
 yfjzyg8jp03sKYZJF+VFT+nzieP1Hk3h4anOpFttTQUCgp0ORpEP99XXoCHcpGUGnM
 NFUUffjqU6j/xujgaaKCVCe0yDi/trm52TFi1//n78DpG1RVeV5C9H8Iln5OXjFQ/Z
 PK0a2kG6wzT+hHF6aExbKZ7aJ4dLXMAuNzrAef+hngGdxebhcpM7Nfe3WxzzX0pXsC
 QNi6OlG0nDBvQ==
Message-ID: <4c82ae6a-c70b-4997-b023-8261ef6a1604@canonical.com>
Date: Mon, 29 Jan 2024 22:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>, Alexander Dahl <ada@thorsis.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request efi-2024-04-rc1-4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97fdd:

   Merge branch 'master-cleanup' of 
https://source.denx.de/u-boot/custodians/u-boot-sh (2024-01-27 20:43:20 
-0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/efi-2024-04-rc1-4

for you to fetch changes up to 21489b4478a72d6c682f24dea80d5ac7790e2692:

   efi_loader: check efi_get_variable_int return value (2024-01-29 
11:31:44 +0100)

Gitlab CI reported no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19460

----------------------------------------------------------------
Pull request efi-2024-04-rc1-4

Documentation:

* uefi: remove ".py" suffix for pytest.py command
* correct date in migration plan for CONFIG_DM

UEFI:

* fix conflicting SPDX license in RISC-V EFI linker scripts
* page align EFI binary section in RISC-V EFI binaries
* separate .data and .text sections of RISC-V EFI binaries
* use common function to get EFI configuration table

----------------------------------------------------------------
Alexander Dahl (1):
       doc: dm: Fix typo

Heinrich Schuchardt (7):
       efi_selftest: add missing line feed in efi_selftest_miniapp_exit
       riscv: conflicting SPDX license linker scripts
       riscv: page align EFI binary section
       riscv: separate .data and .text sections of EFI binaries
       efi_loader: export efi_get_configuration_table
       cmd: in do_efi_capsule_esrt use efi_get_configuration_table
       efi_loader: replace find_smbios_table by library function

Masahisa Kojima (1):
       efi_loader: check efi_get_variable_int return value

Wei Ming Chen (1):
       doc: uefi: remove ".py" suffix for pytest.py command

  arch/riscv/lib/crt0_riscv_efi.S              | 39 
+++++++++++++++++++++-------
  arch/riscv/lib/elf_riscv32_efi.lds           | 26 ++++++++++++-------
  arch/riscv/lib/elf_riscv64_efi.lds           | 26 ++++++++++++-------
  cmd/efidebug.c                               |  7 ++---
  doc/develop/driver-model/migration.rst       |  2 +-
  doc/develop/uefi/uefi.rst                    |  2 +-
  include/efi_loader.h                         |  2 ++
  lib/efi_loader/efi_firmware.c                | 10 +++----
  lib/efi_loader/efi_helper.c                  |  6 ++---
  lib/efi_loader/efi_tcg2.c                    | 19 +-------------
  lib/efi_selftest/efi_selftest_miniapp_exit.c |  2 +-
  11 files changed, 77 insertions(+), 64 deletions(-)
