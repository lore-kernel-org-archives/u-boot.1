Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B617FA3757
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C57688D61;
	Fri, 13 Sep 2024 15:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TVAjwip1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EFE88D69; Fri, 13 Sep 2024 15:48:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7256888A5F
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 15:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726235291; x=1726840091; i=xypron.glpk@gmx.de;
 bh=2cynt1wrHcglpMeiqUgRbG4uY9rPUze39e0ibL1e+EA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TVAjwip1lFII9m+uv74MKDvKWW9HPYI+TSQPtu+sFYyZ8Jw7t1D4uBIwPPIaXag3
 cqa2YYfSOiWApNRaqVqZ+fCXwBYBJTqyxHI+rvDdL+T11jaDtA/XKmuJ6eVmjdBPj
 K+0jHV5jmQ96G+ncBVu5ie31ZGJZDpofkcKf12TS2VwiqdTPL+fKZh4gYyhvpXvzM
 nrRU0KnmEIvhxhnWJRZ/viKOsIRf5KNdhZyZvLq/V8y+RzDRQzd0CdHzwEmXfzYhF
 WqVE/dJEjlA/kJ+O9riaJesUyIX4MGY8zl73+bcqcXhTstrYBKr8Qguqc2T9Hg/o2
 HfPl2w5/Z40KP4GR6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1sJ4t62Vfn-00cQdH; Fri, 13
 Sep 2024 15:48:11 +0200
Message-ID: <a472f57d-a67b-4590-8b4c-334e998e992e@gmx.de>
Date: Fri, 13 Sep 2024 15:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [NEXT] Pull request efi-next-20241024
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TSCQO1f/YVcJ0zNrs8UxZbO3ri1nbCP5T9VxcUrU/2P3v8xNiVW
 x3ezl1sUFl/95FqB+ziRgiVHTo74KmljRwzdOEjNJmDNHnXlgsPav5y23BaU/19DjxR8EoY
 YVcgi7JHWF8L6n7VhQRj2zfs0TmENPfe8lmpIjrheGztHtqS2U+aGcHN106mckzbtSBQhQh
 4OHv9NgUf9oEw/KftAtQw==
UI-OutboundReport: notjunk:1;M01:P0:aEIJgZQ7BDI=;vpSjLCeszcwfbpCcK6Y2HfDwpMN
 L2X6ohsR6Aut+YqdhnAfkBi75Kx9OObRLgTnUdXQLqf9wVv6vPLThn03aPk3ECXfVhoCVgCEE
 IU3idXAqi9BzMBrwvtN0AmjapbCCgePKmoWzdww1CVgy/GOYd3xIzBUMfd8bYZC88RSCQQ9yZ
 PKunewgCkxbg+QrVOaeIlxp2VSmk38DQACT1KeN8YQLA11T0b7DrAmn94WT6FTd4KKuX9taBd
 fpoe7H4Bn/kFYrqFBjT/BnC/YG1lkf6fLWT4CkUWzVnoOVmko1ZQvrwlvqpFtr5I7j5qeMsgO
 AUIGCIjMGdwjc4C5SSmDImeZE9Qi6Qkt10Rz/WSxGhq6q5jCzropERAU1ZbhIisNxAsCQ+Kxf
 mAO598Dqpp4dZ+Ygu+n/EOq+wLebMv8hGfTRmSLNYyh8AU0xqkd47oyZIPDEFnyz7TnyKARAi
 xpCKEhkeXQUSVF5L+lWUsY1PaJV8wqx0h5yK3gJz6d+WtyJ3sCGMIe8jWoosFvZSGfmvIDK+7
 4ZuWJjLyTCQ/xTK2OYLfQh8C04i9Bppf4GHZrg3uc74HIDxBYU04GjEsm+mOolgfIKTzBhp1N
 LhvP24uCuaMknxBHq8FhcY8KNovjqtf/ugBDVJGAxyFl7ASx5LMftDiMJcCEUCWCOfiAQZyTB
 Gk/VF+4fdhIt2+7zFUhMlYfWXtiYYuK53YJ+gViiVcU8+1hasNJIagFJnBPVZnfyuQt0NGEBW
 tZLVWSu9aDWabxs+nSUxj6SKgI5RLr4BAb9zSQ1M4Vk3EqRFzsUh5b0pQlMsnEpswuQhvfshh
 O0+MmeLZ4g0kvQuCarQSp85A==
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

The following changes since commit 78d898eec080b02059c8dc09318b8761044fea8=
5:

   Merge patch series "phycore-am62/4: Add more boot sources"
(2024-09-10 14:56:12 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20241024

for you to fetch changes up to 7de51622a2cf901e888d703a7bea33ad16645d3b:

   efi_loader: Put back copyright message (2024-09-12 17:36:27 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22326

=2D---------------------------------------------------------------
Pull request efi-next-20241024

UEFI:

* Use generated UUIDs in UEFI capsules:
   - efi: define struct efi_guid
   - lib: uuid: add UUID v5 support
   - efi: add a helper to generate dynamic UUIDs
   - doc: uefi: document dynamic UUID generation
   - sandbox: switch to dynamic UUIDs
   - lib: uuid: supporting building as part of host tools
   - include: export uuid.h
   - tools: mkeficapsule: use u-boot UUID library
   - tools: mkeficapsule: support generating dynamic GUIDs
   - test: lib/uuid: add unit tests for dynamic UUIDs
   - test: lib/uuid: add tests for UUID version/variant bits

* Minor code clean-up
   - shorten efi_bootmgr_release_uridp_resource()
   - rename efi_bootmgr_image_return_notify
   - return the correct error in efi_bootmgr_release_uridp()
   - Kconfig: clean up the efi configuration status
   - Use puts() in cout so that console recording works
   - Put back copyright message in helloworld.c

=2D---------------------------------------------------------------
Caleb Connolly (11):
       efi: define struct efi_guid
       lib: uuid: add UUID v5 support
       efi: add a helper to generate dynamic UUIDs
       doc: uefi: document dynamic UUID generation
       sandbox: switch to dynamic UUIDs
       lib: uuid: supporting building as part of host tools
       include: export uuid.h
       tools: mkeficapsule: use u-boot UUID library
       tools: mkeficapsule: support generating dynamic GUIDs
       test: lib/uuid: add unit tests for dynamic UUIDs
       test: lib/uuid: add tests for UUID version/variant bits

Ilias Apalodimas (4):
       efi_loader: shorten efi_bootmgr_release_uridp_resource()
       efi_loader: rename efi_bootmgr_image_return_notify
       efi_loader: return the correct error in efi_bootmgr_release_uridp()
       Kconfig: clean up the efi configuration status

Simon Glass (2):
       efi_loader: Use puts() in cout so that console recording works
       efi_loader: Put back copyright message

  arch/arm/mach-rockchip/board.c                     |   2 +-
  board/cobra5272/flash.c                            |   2 +-
  board/gardena/smart-gateway-mt7688/board.c         |   2 +-
  board/sandbox/sandbox.c                            |  16 --
  board/socrates/socrates.c                          |   2 +-
  board/xilinx/common/board.c                        |   2 +-
  boot/Kconfig                                       |   2 +
  cmd/efi.c                                          |   2 +-
  cmd/efi_common.c                                   |   2 +-
  cmd/flash.c                                        |   2 +-
  cmd/gpt.c                                          |   2 +-
  cmd/nvedit_efi.c                                   |   2 +-
  cmd/x86/hob.c                                      |   2 +-
  common/flash.c                                     |   2 +-
  disk/part_efi.c                                    |   2 +-
  doc/develop/uefi/uefi.rst                          |  27 +++
  doc/mkeficapsule.1                                 |  23 +++
  drivers/firmware/arm-ffa/arm-ffa-uclass.c          |   2 +-
  env/sf.c                                           |   2 +-
  fs/btrfs/btrfs.c                                   |   2 +-
  fs/btrfs/compat.h                                  |   2 +-
  fs/btrfs/disk-io.c                                 |   2 +-
  fs/ext4/ext4fs.c                                   |   2 +-
  include/efi.h                                      |   2 +-
  include/fwu.h                                      |   2 +-
  include/part.h                                     |   2 +-
  include/rkmtd.h                                    |   2 +-
  include/sandbox_efi_capsule.h                      |   6 +-
  include/{ =3D> u-boot}/uuid.h                        |  21 +-
  lib/Kconfig                                        |   3 +-
  lib/acpi/acpi_dp.c                                 |   2 +-
  lib/acpi/acpigen.c                                 |   2 +-
  lib/efi/Kconfig                                    |   5 +
  lib/efi/efi_app.c                                  |   2 +-
  lib/efi_loader/Kconfig                             | 215
++++++++++++---------
  lib/efi_loader/efi_bootmgr.c                       |  28 +--
  lib/efi_loader/efi_capsule.c                       |   1 +
  lib/efi_loader/efi_console.c                       |   2 +-
  lib/efi_loader/efi_device_path.c                   |   2 +-
  lib/efi_loader/efi_firmware.c                      |  55 +++++-
  lib/efi_loader/efi_variable.c                      |   2 +-
  lib/efi_loader/helloworld.c                        |   3 +
  lib/fwu_updates/fwu_mtd.c                          |   2 +-
  lib/uuid.c                                         | 103 ++++++++--
  lib/vsprintf.c                                     |   2 +-
  net/bootp.c                                        |   2 +-
  test/dm/acpi_dp.c                                  |   2 +-
  test/dm/acpigen.c                                  |   2 +-
  test/lib/uuid.c                                    | 124 +++++++++++-
  .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
  .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
  .../test_capsule_firmware_signed_fit.py            |   2 +-
  .../test_capsule_firmware_signed_raw.py            |   4 +-
  test/py/tests/test_efi_capsule/version.dtso        |   6 +-
  tools/Makefile                                     |   8 +-
  tools/binman/etype/efi_capsule.py                  |   2 +-
  tools/binman/ftest.py                              |   2 +-
  tools/eficapsule.h                                 |   2 +-
  tools/mkeficapsule.c                               | 208
+++++++++++++++-----
  59 files changed, 692 insertions(+), 252 deletions(-)
  rename include/{ =3D> u-boot}/uuid.h (90%)

