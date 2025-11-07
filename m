Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CF6CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 06:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0A883C64;
	Fri,  7 Nov 2025 07:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="asBtVi1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D01DD83C6C; Fri,  7 Nov 2025 07:40:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAAF83C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 07:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762497594; x=1763102394; i=xypron.glpk@gmx.de;
 bh=qwfZFwjrAzELYANz5ls5NKC9VIWvj7/j/L63RFl7xto=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=asBtVi1K9/mcxKcocLA2yxyNpy7MvLpVoDhcPHVE0kh5wE8GzMqePKFftAwVOJ2p
 TQ4mD6ChDJ05kunRURNVF0VI/6oDYJyZ9FbKScXUCAldXgNgcjHONf2kIRAgcr0H9
 9yqFw3BFnjxHXcN3Yx6+1eV+EE5bl8IauXjWXuJXct/yKKGAm9Pwxtm2c+5AX9vIW
 eIxxZQCw4wIcCpq8QRQ5W58ulq8Ljy9Yp3doZZ6UXc4cy7A2gSYBts03FeacHqvEr
 JXe72fbGJVRbOADOvmEXMmmVc2RsS5oZjHyMhnjn7XupkuBsVwx/ljAVwD8KzV5Mh
 /mOrXGlSciWuA6LahQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.26.194.12] ([93.94.208.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1w2i5t2uet-00dSDg; Fri, 07
 Nov 2025 07:39:54 +0100
Message-ID: <66686bf7-f7a0-45f0-8fc0-ef3693039b7e@gmx.de>
Date: Fri, 7 Nov 2025 07:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UYAtrJZoI3HAMc239Jwg3ocxHPB+qZekFg/D1WNLcZbx3f47N1y
 M/PPkK0xtBlzH+/oTtl/J3DMzx+gZBD8ojb5Z/V7kgJh92QrUjefvQEtKvu7NtVjpcBjjyw
 2bj90T83CZMfnl1HZJRYRaVI8rn0DEJYp7xRFpKJZvX3hNhOxdaIj8AkHbvt7LTgMQ1hrOh
 9tKh/9shvlWTGQZB4qq8Q==
UI-OutboundReport: notjunk:1;M01:P0:u7cr9xbCGlI=;N/GbcQ6P569+9bOWQqfbSdFVe46
 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
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

The following changes since commit ddc916334a7a7e180b532dbb2cf1b778466d2b9=
b:

   Gitlab CI: Rework our tag usage again (2025-11-06 15:16:51 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc2

for you to fetch changes up to 6bb374b1a1226b964db8476b2939a280c7477e4a:

   efi_loader: typo 'mange' in efi_net.c (2025-11-06 23:26:28 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28208

@Tom, Rick, Leo

I have included the patches that fix ACPI pass-through on QEMU for ARM=20
and RISC-V and provide a matching unit test.

Some other tests in test/cmd/ currently fail on=20
qemu-riscv64_smode_acpi_defconfig. So I left out the CI and defconfig=20
changes that would lead to running these tests in this pull request. I=20
have started the necessary clean-up work, but there is still more to do. C=
f.

[PATCH 1/1] test: fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
https://lore.kernel.org/u-boot/20251105233217.124892-1-heinrich.schuchardt=
@canonical.com/

[PATCH] test: do not write to 0x0 except on sandbox
https://lore.kernel.org/u-boot/20251105180748.115441-1-heinrich.schuchardt=
@canonical.com/
(to be reworked)

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc2

Documentation:

* bootstd: Describe environment variable extension_overlay_addr
   environment and remove extension support from TODO list

EFI:

* Correct the detection of the video mode in the EFI payload app:
   - Use struct efi_gop_mode_info in the definition of struct
     efi_entry_gopmode.
   - In function get_mode_from_entry() use the correct type for the video
     mode structure.
* Use a valid error code as return value in efi_store_memory_map().
* Avoid a memory leak for the variable name in efi_bl_create_block_device(=
).
* Correct the code indentation in efi_uc_stop().
* Correct the description of struct efi_priv.
* Fix typos in code comments.

Other:

* qfw: Add more fields and a heading to qfw list
* Fix the support for ACPI pass-through on ARM and RISC-V:
   Avoid zeroing out the XSDT address
* test: provide unit test for 'acpi list' command

=2D---------------------------------------------------------------
Ben Wolsieffer (1):
       efi: video: fix mode info in payload mode

Heinrich Schuchardt (9):
       qfw/acpi: do not zero out XSDT address
       test: provide test for 'acpi list' command
       efi: Use struct efi_gop_mode_info in struct efi_entry_gopmode
       efi_loader: correct struct efi_priv description
       efi_client: efi_store_memory_map() must return int
       efi_driver: correct formatting in efi_uc_stop()
       efi_driver: typo 'to be write'
       efi_driver: don't leak name in efi_bl_create_block_device()
       efi_loader: typo 'mange' in efi_net.c

Kory Maincent (TI.com) (2):
       doc: bootstd: Remove extension support from TODO list
       doc: bootstd: Describe the optional extension_overlay_addr=20
environment

Simon Glass (1):
       qfw: Add more fields and a heading to qfw list

  cmd/qfw.c                         |  6 ++++-
  doc/develop/bootstd/overview.rst  |  4 ++-
  doc/usage/cmd/qfw.rst             | 27 +++++++++++---------
  drivers/misc/qfw_acpi.c           |  1 -
  drivers/video/efi.c               |  2 +-
  include/efi.h                     | 38 +++++++++++++++++-----------
  include/efi_api.h                 |  9 -------
  lib/efi_client/efi.c              |  6 ++---
  lib/efi_driver/efi_block_device.c |  8 ++----
  lib/efi_driver/efi_uclass.c       |  2 +-
  lib/efi_loader/efi_net.c          |  2 +-
  test/cmd/Makefile                 |  4 +++
  test/cmd/acpi.c                   | 52=20
+++++++++++++++++++++++++++++++++++++++
  test/cmd/qfw.c                    | 40 ++++++++++++++++++++++++++++++
  14 files changed, 151 insertions(+), 50 deletions(-)
  create mode 100644 test/cmd/acpi.c
  create mode 100644 test/cmd/qfw.c
