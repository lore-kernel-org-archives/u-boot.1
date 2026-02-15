Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3A7EF586F
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 10:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7680383AA9;
	Sun, 15 Feb 2026 11:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BS2GVBEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AEE83AB7; Sun, 15 Feb 2026 11:07:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370B980FA1
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 11:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771150074; x=1771754874; i=xypron.glpk@gmx.de;
 bh=SObYlxWsQlvmaB6xN3H8zjnm0j9+n2dWM4ntX8rbesg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BS2GVBEIRNkYjln5jedwLNkQeQhqnso3MAWYXIbtlkop0C6CzRUdo6mVpZKGQt6e
 kVjq+C2zh667qy7jvNkoEqmiKDBi6yic6iMAdVLnBP4/E6D6/yRMTsS7arrzb7yQk
 q1AV5Xe1suZ7ObOuL75QAg65VzjKFniY57r9h0yvIhxtcEGiPDbMxRod+YTc4/XqX
 +hII7RxUT9nEbrtFtGRgGjJ45//sapEEcff90U9it5jyHt+5NlDtN+H+u+qJGhQrB
 1KMMAVY2fDY1Iu9owiDekTMCrInV+pOsJCqEQv51zgCF7iOZl8dPkVqlYmgJmKxlM
 xLjSf3qmwXwWG69Huw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1wCFkq3K0L-00OVwa; Sun, 15
 Feb 2026 11:07:54 +0100
Message-ID: <201ac11f-a236-4c9a-8a44-fa9403c90ef9@gmx.de>
Date: Sun, 15 Feb 2026 11:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-next-2026-02-15
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a1Z5j4oTrSiH6aiz9+x3SrQiX+/IHbtidZZmHIrUjU2YZdbg50t
 TiIhDAIEEy3KqW5LrHMMjctWHxL0WfHK+oWWBGUuPrQJHxyBjbhuEvAZbgo/itPRSdLupZg
 xYxlNzgxKRVwP26DIvTD/HRXBYHfxUEqADwE5868FrE6IAl8CfzURpbreO+20Nn6b8zOSeu
 vD1pW/cQ/ZnQ3V1mdpc2g==
UI-OutboundReport: notjunk:1;M01:P0:JuCQV3s+7Do=;NlVagRyeSttY+ezLcUNcrhksvFf
 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
 xfYw1tqA=
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

The following changes since commit 136faf7b0cc92af1d38b0db1bfaa5405e884ee2=
d:

   Merge tag 'u-boot-socfpga-next-20260213' of=20
https://source.denx.de/u-boot/custodians/u-boot-socfpga into next=20
(2026-02-14 11:12:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-next-2026-02-15

for you to fetch changes up to e54fbb2f901e897b2a2fb2a718a1ef1607b20ce5:

   efi_loader: Setup default location for UEFI Variables storing=20
(2026-02-15 09:15:45 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/1380382

=2D---------------------------------------------------------------
Pull request efi-next-2026-02-15

UEFI:

* Add MBR support to EFI_PARTITION_INFO_PROTOCOL
   * disk: part_dos: Move header to the main include directory
   * disk: part_dos: Align dos_partition_t with struct partition
   * disk: part_efi: Remove redundant struct partition definition
   * disk: part_dos: Document part_get_info_extended() helper function
   * disk: part_dos: Refactor to allow retrieving raw MBR partition data
   * efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL to support MBR
   * efi_selftest: Enhance MBR test for PARTITION_INFO_PROTOCOL

* Prepare for supporting more stores (e.g. SPI-flash) for EFI variables.
   * efi_var: Unify read/write access helper function
   * efi_loader: Setup default location for UEFI Variables storing
   * efi_var_file: refactor to move buffer functions

=2D---------------------------------------------------------------
Javier Martinez Canillas (7):
       disk: part_dos: Move header to the main include directory
       disk: part_dos: Align dos_partition_t with struct partition
       disk: part_efi: Remove redundant struct partition definition
       disk: part_dos: Document part_get_info_extended() helper function
       disk: part_dos: Refactor to allow retrieving raw MBR partition data
       efi_loader: disk: Extend EFI_PARTITION_INFO_PROTOCOL to support MBR
       efi_selftest: Enhance MBR test for PARTITION_INFO_PROTOCOL

Michal Simek (2):
       efi_var: Unify read/write access helper function
       efi_loader: Setup default location for UEFI Variables storing

Shantur Rathore (1):
       efi_var_file: refactor to move buffer functions

  disk/part_dos.c                              | 91=20
++++++++++++++++++----------
  disk/part_efi.c                              |  4 +-
  include/efi_variable.h                       | 18 +++---
  include/part.h                               | 14 +++++
  {disk =3D> include}/part_dos.h                 |  6 +-
  include/part_efi.h                           | 19 +-----
  lib/efi_loader/Kconfig                       |  3 +-
  lib/efi_loader/Makefile                      |  2 +-
  lib/efi_loader/efi_disk.c                    |  9 ++-
  lib/efi_loader/efi_var_common.c              | 42 +++++++++++++
  lib/efi_loader/efi_var_file.c                | 65 ++------------------
  lib/efi_loader/efi_variable.c                | 19 ++++--
  lib/efi_selftest/efi_selftest_block_device.c | 26 ++++++++
  13 files changed, 184 insertions(+), 134 deletions(-)
  rename {disk =3D> include}/part_dos.h (87%)
