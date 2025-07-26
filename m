Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D948C87FCA
	for <u-boot@archiver.kernel.org>; Sat, 26 Jul 2025 07:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB5AE835A2;
	Sat, 26 Jul 2025 09:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FnX23qxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5BE83689; Sat, 26 Jul 2025 09:15:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B2DD8343B
 for <u-boot@lists.denx.de>; Sat, 26 Jul 2025 09:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753514149; x=1754118949; i=xypron.glpk@gmx.de;
 bh=qwYlLe7n4iV5GPhQyh756EMAn4tkxkV7zpEximPDrPE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FnX23qxHhuTzcSNW3WNjiA/Gyr9sbrXeWDdOaWN87HmKrXkhq3WOX12zIyAwsTuJ
 LuuiMGHE4CnuZi9YDrEZiwZ+Wv7PImwsnwwHl3upskxgK2QTUN5nsXJ8cxoosZkTc
 NtdT8VcAm+3GQ7Q+0K6AjKakV3XFPIzl75hTrP8QCV203jahxs4G0daSySVr7Alcs
 nKnqlDoUrnXpYkRu7Ri7cKhr9u4q+arFSxyDizeub8E0+bomXKh7rrKxHv3ErKx8Y
 4fqoGn2Fvo+0d89mF0yVFroPrvY6I1EjaUWxFbgyTZnxURn5TRexxIDC71CGN6GDQ
 VADQ5NbEHSE2E2Qyjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.109.128]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1uBTVv3jWt-00ZnPd; Sat, 26
 Jul 2025 09:15:48 +0200
Message-ID: <da13de7f-da68-4185-8c5a-65e6767d2cfd@gmx.de>
Date: Sat, 26 Jul 2025 09:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2025-10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mqm9D5fYdEiB03Ud29cset8BCVgoTW2r7IlZWPYbFuuQb/Ew9o7
 UFOREQWNOHzRCJV5aTEK9cztusfCJ/PG6ClpqdeDtnBfvGfyoQjZN+ynxpeMZOffxoYn5nU
 G/CpzwX6lSDc94c3zHHcom90AQTW8ltQTxxSvofqe/vBy8W74RstnjD97e0rtRe0a5wDv1S
 +FvoYFYLuyXsa5ncmzo4A==
UI-OutboundReport: notjunk:1;M01:P0:FLsolOG/Tis=;FhQ0In/IYHy4/zJLMsaejolmJOV
 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
 /NAVq+xxMB1EuzYi+pHqF52bW2Z0WmPM=
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

The following changes since commit 088d24eb96fb8ba64e3afee310a9f32ee36c22b=
0:

   Merge branch 'master' of=20
https://source.denx.de/u-boot/custodians/u-boot-samsung (2025-07-25=20
07:50:44 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2025-10-rc1

for you to fetch changes up to afd5426043b3ef6aa57f2a731f94125ae983395c:

   docs: Update FIT signature testing instructions (2025-07-26 07:37:03=20
+0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/27176

=2D---------------------------------------------------------------
Pull request efi-2025-10-rc1

Documentation:

* update FIT signature testing instructions
* describe defconfigs for AM69-SK

UEFI:

* provide unit test for system table pointer
* efi_realloc() must check efi_alloc() return value
* correct EFI_DEBUG_TABLE_ENTRY_SIZE
* avoid NULL dereference in ESRT creation tests
* add missing check in FMP.GetImageInfo()
* rename lib/efi to lib/efi_client
* rename CONFIG_EFI to CONFIG_EFI_CLIENT
* create a new CONFIG_EFI
* update maintainers for EFI_CLIENT

=2D---------------------------------------------------------------
Enric Balletbo i Serra (1):
       docs: Update FIT signature testing instructions

Heinrich Schuchardt (5):
       efi_selftest: check system table pointer
       efi_loader: efi_realloc() must check efi_alloc() return value
       efi_loader: correct EFI_DEBUG_TABLE_ENTRY_SIZE
       efi_selftest: fix ESRT creation tests
       efi_loader: add missing check in FMP.GetImageInfo()

Mattijs Korpershoek (1):
       doc: board: ti: Add defconfigs for AM69-SK

Simon Glass (4):
       efi: Rename the lib/efi directory
       efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
       efi: Create a new CONFIG_EFI
       efi: Update maintainers for EFI_CLIENT

  MAINTAINERS                                   |  6 +-
  Makefile                                      |  2 +-
  arch/x86/Kconfig                              |  6 +-
  arch/x86/cpu/Makefile                         |  2 +-
  arch/x86/cpu/efi/Kconfig                      |  2 +-
  arch/x86/cpu/x86_64/Makefile                  |  2 +-
  cmd/Makefile                                  |  2 +-
  configs/efi-x86_app32_defconfig               |  2 +-
  configs/efi-x86_app64_defconfig               |  2 +-
  configs/efi-x86_payload32_defconfig           |  2 +-
  configs/efi-x86_payload64_defconfig           |  2 +-
  doc/board/ti/j784s4_evm.rst                   |  9 +++
  doc/develop/uefi/u-boot_on_efi.rst            | 18 +++---
  doc/usage/fit/signature.rst                   |  8 +--
  drivers/block/Kconfig                         |  2 +-
  include/init.h                                |  2 +-
  lib/Kconfig                                   |  2 +-
  lib/Makefile                                  |  2 +-
  lib/efi/Kconfig                               | 83=20
+++------------------------
  lib/efi_client/Kconfig                        | 80=20
++++++++++++++++++++++++++
  lib/{efi =3D> efi_client}/Makefile              |  0
  lib/{efi =3D> efi_client}/efi.c                 |  0
  lib/{efi =3D> efi_client}/efi_app.c             |  0
  lib/{efi =3D> efi_client}/efi_app_init.c        |  0
  lib/{efi =3D> efi_client}/efi_info.c            |  0
  lib/{efi =3D> efi_client}/efi_stub.c            |  0
  lib/efi_loader/Kconfig                        |  3 +
  lib/efi_loader/efi_debug_support.c            |  2 +-
  lib/efi_loader/efi_firmware.c                 |  2 +
  lib/efi_loader/efi_memory.c                   |  2 +
  lib/efi_selftest/efi_selftest_debug_support.c | 68 +++++++++++++++++++++=
-
  lib/efi_selftest/efi_selftest_esrt.c          |  6 +-
  lib/uuid.c                                    |  4 +-
  33 files changed, 209 insertions(+), 114 deletions(-)
  create mode 100644 lib/efi_client/Kconfig
  rename lib/{efi =3D> efi_client}/Makefile (100%)
  rename lib/{efi =3D> efi_client}/efi.c (100%)
  rename lib/{efi =3D> efi_client}/efi_app.c (100%)
  rename lib/{efi =3D> efi_client}/efi_app_init.c (100%)
  rename lib/{efi =3D> efi_client}/efi_info.c (100%)
  rename lib/{efi =3D> efi_client}/efi_stub.c (100%)
