Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8864DC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6C582BAA;
	Sun, 25 May 2025 12:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uHR92Twn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E2082BDA; Sun, 25 May 2025 12:53:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDBB82B53
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748170380; x=1748775180; i=xypron.glpk@gmx.de;
 bh=g85+z07bKLsDeWxk3LtbGbUYiT3i1pfUDgBeKfvQhWM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uHR92TwnQpSBmUR/eMAqmTSYR1fWHWpK9a6lfwCZVe0ROxHinh4UiTKxmVdqC2UY
 MX8X19XLP6Rvh7R0VXLBV2k2f2AYCkF4ypjN+/P/olBLcw041nLr6pTFMcBCPkBBw
 NtiFpAL7qrjG/9IUIdS/maNzNtSauf83eW4K1Aa0w60aLCb9zFDA36p8UZ6P9pOx8
 iQV+18jGvoBVe5urC0zRalLK+NexligB4J6MRCtAAP7jmvzcEdt1hXnVkLIKrFDXw
 VV/Pu3x8s0aoHq/i8bFCYFCF867M8ksnSo9B7GWQeA7IL8c2h/KET4hpbsGQrOfo8
 3PF+P4Ao1c99BNnahw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.142]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1uZpyr0LfR-00Nt4m; Sun, 25
 May 2025 12:53:00 +0200
Message-ID: <7c08e63f-3008-46dd-9a7c-bd1d4bb376b3@gmx.de>
Date: Sun, 25 May 2025 12:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-07-rc3-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kaiVzaozzv/ufeMCnEOTWEL+/Bs12M8K6xhj6yU9VUSmuMHxmBg
 x6IDlE8a+E170cBw1EE/H/q2/qgNh0QEChV3cT266n4l/yp4AuMZ0vF23qxIXiwuf1TvDeM
 DrgwpYj/hxVYyyMLELjWIen/F8obOZV/9O5MOl6ZfBAoSPFGVjr3pn3/KT1NNgUoiQUH2Ad
 Nrk3as5qZ6GDNvoGKJtTg==
UI-OutboundReport: notjunk:1;M01:P0:ILi2M36jF3k=;ZBB4azX1ok2+2XWCs0JYXCt01jL
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

The following changes since commit df2ed552f0b05591090369a7fe7ddc92439dea5=
c:

   ext4fs: Fix: Read outside partition error (2025-05-23 10:42:49 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-07-rc3-3

for you to fetch changes up to f8949b1d1d0d4dc4d5abb458c59e831b9e2a0dca:

   efi_loader: Run dhcp if an http boot option is selected (2025-05-25=20
11:40:15 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/26313

=2D---------------------------------------------------------------
Pull request efi-2025-07-rc3-3

UEFI:

* run dhcp if an http boot option is selected
* separate device path into its own header and add it to the API docs
* rename END to EFI_DP_END
* make x86 SMBIOS tables usable in the EFI context

=2D---------------------------------------------------------------
Ilias Apalodimas (1):
       efi_loader: Run dhcp if an http boot option is selected

Simon Glass (4):
       efi_loader: Separate device path into its own header
       efi: Include device-path functions in the EFI API docs
       efi: Rename END to EFI_DP_END
       x86: efi_loader: Ensure the SMBIOS tables are sent via EFI

  arch/x86/lib/tables.c                      |   2 +
  board/emulation/qemu-x86/Kconfig           |   1 +
  cmd/bootefi.c                              |   1 +
  cmd/eficonfig.c                            |   5 +-
  cmd/efidebug.c                             |   7 +-
  doc/api/efi.rst                            |   6 +
  include/efi_device_path.h                  | 421=20
+++++++++++++++++++++++++++++
  include/efi_loader.h                       |  57 +---
  lib/efi_driver/efi_uclass.c                |   1 +
  lib/efi_loader/efi_bootbin.c               |   1 +
  lib/efi_loader/efi_bootmgr.c               |  13 +-
  lib/efi_loader/efi_boottime.c              |   1 +
  lib/efi_loader/efi_capsule.c               |   1 +
  lib/efi_loader/efi_console.c               |   1 +
  lib/efi_loader/efi_device_path.c           | 175 +++---------
  lib/efi_loader/efi_device_path_utilities.c |   3 +-
  lib/efi_loader/efi_disk.c                  |   1 +
  lib/efi_loader/efi_fdt.c                   |   1 +
  lib/efi_loader/efi_helper.c                |   7 +-
  lib/efi_loader/efi_net.c                   |   1 +
  lib/efi_loader/efi_tcg2.c                  |   1 +
  test/lib/efi_device_path.c                 |   1 +
  22 files changed, 510 insertions(+), 198 deletions(-)
  create mode 100644 include/efi_device_path.h
