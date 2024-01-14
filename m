Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CE6C47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF27086E05;
	Sun, 14 Jan 2024 15:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pgz2BVbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AED87707; Sun, 14 Jan 2024 15:14:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50888657F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:14:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705241654; x=1705846454; i=xypron.glpk@gmx.de;
 bh=2H8FQDwjIxI0euHojY+16WB24apFK2EKM1aDv0YGnnw=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=pgz2BVbRkNeQfDoIIdhrmzXEa6eq2tizXYI0svt5h7osZzmCXuAdSK8FDCI/m3aO
 gVgdyzgNHjTOFErh+NMorLanQWEuTOahHzBVibBZrmb7LVluAEE6pIFcm825luPoV
 Jwz4Yo+tbO0ite+uJnixZ6292x9uT3ZlhAx6/ZcnaHyY6MKtB3tsvvzGMYB4N0EPv
 Y3EM34wq9wIT5XL9hzTlMzbPlfShYE/nlakDJLMMA1I7ieF/oQvXJ5I4pQBymknPB
 4q1UwAvy8Z3wrDDc+qRctMNj2NebJm2ddp2/tlRJnhnApvhjNgAoFrUrYZ2r4fxrG
 1Jkndr4tdNoFgW518g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1r1OUF1JqH-013PJ0; Sun, 14
 Jan 2024 15:14:14 +0100
Message-ID: <61fbd4b8-8a06-4ade-882e-323a6d916adc@gmx.de>
Date: Sun, 14 Jan 2024 15:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, Masahisa Kojima <masahisa.kojima@linaro.org>,
 Simon Glass <sjg@chromium.org>, Grzegorz Szymaszek <gszymaszek@short.pl>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mWN63yJ71QiKdpRPXSQlx17TV/d7w5/3NZHBSokW8WhhxM6Y0dU
 Lr/6pngwy1s+fWO+iaN7+pm3ew7VAcZxox94rKBIzHBpiI+gjxw1sNiqraJMtW4Hl3+ofBP
 qEaU6hPV/pWzqpnStjftbaP+VIhWdrYDCgJhaPzN3UPQd7dreexHfu89tdFPybfNY827BZ2
 dcC9B1TJGttwIxRMVoUsw==
UI-OutboundReport: notjunk:1;M01:P0:e2m0zy96iGo=;beELzAaXC7BCeNrhisbHafesjlq
 MAjISdr6WOLxZCxlPuYAZSLBe4ZtxuCoqrxlF9goRxds8C8EsIil5e6p8tRhWTpIa9JkkHqWI
 5DpN+cratOIXY959JcwjU2XP4Vfd/1IkAqgjq1ln0G6NZW6x5MRhCNlKEMSIghfvj9C4joXtH
 mx4CXx6frl2v9ZLQdwPbAjM/vcNuMNDXnKNppq6SBMwS6aItXmYpAx4ViFCZh8VlNKqhKVn6U
 O3iqA8bGfycHcHyuphQIf48okO+qzbh/cg2NleEc5/RwP2sDqNxPE6ZjO08wLBMu/78YbgwDl
 F4WYI7PSemkmg7KZUyhtTrEFbXrZ2ZVj1H/kd0GkNrLVbE+K3HgzxWWhvdAacbQOyAKJGqe/6
 pmgQZpwuJb9CyjLNMjSRysb99HYUYtdbnR7izLvFZWausoK2pifyP4prNILAZb5L5t7qkWb9e
 TLMsnINuyJ+Ee7L/jgkoirwkuaGEWCRIsITBXRN7D+lQI5cnDEEkpjJx17GQXvtum229FQtwB
 +IWHRhYuvQviTQbrdY3AGB8yevH4OSU2iUHHqtnSw/Dg1X6MOd8aGUZNc1clUNXFztIxFJdnf
 j3JVH7Bn0AZ3UcWEE83wL5mASP94NRNdUixQvWXiE51W04+/SY7GsH3SWkufhuTsRIm/BzF6s
 Cj1nyLt7qV10xs3ysuGSv4lprfsYraY5qp01JhvElLQLKQJXAWHwczg03eKRYsSAvwFqwyqPS
 Nd0U78IDzpoOhvQiMRGNc1uYTQswgG3kr6jvYOWDyH+1dgKj8B1ZGjfltGbh9RC2gWQ/st25L
 jCfyTaAp1WdjWD6IcMwLp8ew37kr635QVBXJEdN/mkYdkZdxOfRNpIq7oVxJf6sEfqAxi4NxI
 Gz34tjuoCYYN+JCGDHDHioNUbjmH0MGHba5dOuYL0ovn1Q5+YtuLap1UGcfR+47AsHJqLN4ce
 kPgX/A==
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

The following changes since commit 547d3dd28a46a18d59e00a153c8becca8d4e8cf=
9:

   Merge branch '2024-01-12-assorted-fixes' (2024-01-12 08:34:50 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-04-rc1

for you to fetch changes up to 55125bbfb48cb1330a692059bc972810f77b984a:

   cmd: efidebug: check pointer after memory allocation (2024-01-13
18:17:47 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19306

=2D---------------------------------------------------------------
Pull request efi-2024-04-rc1

Documentation:

* update coreboot graphics documentation
* fix '---' rendering

UEFI:

* add missing pointer check after memory allocation in efidebug
* replace duplicate functions efi_dp_append and efi_dp_concat
* support fmp versioning for multi bank update
* avoid using dm_scan_other() in EFI app

=2D---------------------------------------------------------------
Bin Meng (1):
       doc: coreboot: Update stale graphics enabling instructions

Grzegorz Szymaszek (1):
       doc: fix three-dash references in reStructuredText

Heinrich Schuchardt (1):
       cmd: efidebug: check pointer after memory allocation

Ilias Apalodimas (1):
       efi_loader: Clean up efi_dp_append and efi_dp_concat

Masahisa Kojima (4):
       efi_loader: fix iteration of FMP protocols
       efi_loader: remove unused members from struct efi_disk_obj
       fwu: fix fwu_get_image_index interface
       efi_loader: support fmp versioning for multi bank update

Simon Glass (1):
       efi: Avoid using dm_scan_other()

  cmd/eficonfig.c                            |   7 +-
  cmd/efidebug.c                             |  10 +-
  configs/efi-x86_app64_defconfig            |   1 +
  doc/board/coreboot/coreboot.rst            |  13 +-
  doc/develop/sending_patches.rst            |   4 +-
  include/efi_loader.h                       |   5 +-
  include/fwu.h                              |  13 +-
  lib/efi/Makefile                           |   2 +-
  lib/efi/efi_app.c                          | 187
=2D-------------------------
  lib/efi/efi_app_init.c                     | 205
+++++++++++++++++++++++++++++
  lib/efi_loader/efi_bootmgr.c               |   6 +-
  lib/efi_loader/efi_boottime.c              |   2 +-
  lib/efi_loader/efi_device_path.c           |  70 +++-------
  lib/efi_loader/efi_device_path_utilities.c |   2 +-
  lib/efi_loader/efi_disk.c                  |  15 +--
  lib/efi_loader/efi_esrt.c                  |  18 ++-
  lib/efi_loader/efi_firmware.c              |  86 +++++++++---
  lib/fwu_updates/fwu.c                      |  32 ++---
  tools/patman/patman.rst                    |   2 +-
  19 files changed, 356 insertions(+), 324 deletions(-)
  create mode 100644 lib/efi/efi_app_init.c
