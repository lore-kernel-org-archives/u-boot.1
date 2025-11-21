Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3D6CFC50A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 21:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C63839D7;
	Fri, 21 Nov 2025 22:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rLq3eObF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D18E83AAE; Fri, 21 Nov 2025 22:11:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40F45839A8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 22:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763759479; x=1764364279; i=xypron.glpk@gmx.de;
 bh=570VFMb+N93W2xRRTchrQU0g8XN1TMTVAr4lAYrNM0E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rLq3eObFclDNgFW9qZhhJR/bJVzdJhW/gy7PL065728DHjXjB5CU3N+7ANOi+vtT
 wNHKCBDnmObeShJut177IgGKIXhB23TsFo97W04U2L2fl2TJEmj9OiWbNHSWC9piP
 oErJ4rfWzE3TiNEt6cISC8cbAJkgDk40BwHvl8Yz9/WwXkKkC+lQZF1fKw5ULr+TF
 QERPOM0ByaNo0JFjgLOeFM9uC+wsQN3j4Z8weiuAQevAIgHpIS7lqL0IwkTiyKcpO
 EmdVn8fqXG17vI9hVXb9gXepzy6ho6jCK/s18gMOadDnYcGEKXP4XyOCrkqUZqrJt
 UVT1QLxA2cO54q6JbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1wBFD41uo5-014ECn; Fri, 21
 Nov 2025 22:11:19 +0100
Message-ID: <74b3bbd3-c1c4-4711-ba4d-42424dd378a6@gmx.de>
Date: Fri, 21 Nov 2025 22:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2026-01-rc3-2 for master branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0UmsorgKRkWuel6GMe3siKYk/Zb9qY4q4wX9PfwfnKwQvG5kzdW
 wcJNImhyx5cEHDc4CXJOuMO9fz3b2oeBzg5bInMOqH1UdoHNLOUHeuX2qMkYArtFoGaS3Sj
 zH17nUlZPRCSMjGnR4hw0lFi00Yd0ceMYg4a5aW8vQgzhgDgmTQdnVuoCwY2W+OAbcSvv2c
 mkm925nwtk4HEDQ2oVdVQ==
UI-OutboundReport: notjunk:1;M01:P0:ZmILuG4vEqc=;YWv+ISkS2VX1QBV/e/LV315tSkJ
 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
 3XAXYGDA=
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

The following changes since commit 2bc0715b558fa1ac5c88b11e250740b16a90583=
7:

   Merge tag 'u-boot-ufs-20251119' of=20
https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-11-19 09:04:32=
=20
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git=20
tags/efi-2026-01-rc3-2

for you to fetch changes up to fff78d3bb25dc0c4b20b4ab9908cb355f5808178:

   doc: pytest: fix u-boot-test-flash typo (2025-11-21 19:29:23 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/28454

=2D---------------------------------------------------------------
Pull request efi-2026-01-rc3-2

Documentation:

* board: ti: am6254atl_sk: correct value of PRELOADED_BL33_BASE
* pytest: fix u-boot-test-flash typo
* samsung: Fix PXE description for the E850-96 board
* board: ti: k3: Update TI firmware repository URL to GitHub
* add missing macro descriptions to include/test/ut.h and add it to
   the API documenation
* rearrange the description of DM tests and describe return values

Testing:

* Enable CI testing ACPI on qemu-riscv64_smode_acpi_defconfig
* Add qemu-riscv64_smode_defconfig to the CI tests
* Generalize tests such that they can run on RISC-V QEMU
   - fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
   - cmd/fdt: do not assume RNG device exists
   - cmd/bdinfo: make no flash assumption
   - cmd/bdinfo: consider arch_print_bdinfo() output
   - common/print: do not use fixed buffer addresses
   - cmd/fdt: do not use fixed buffer addresses
   - raise CONFIG_CONSOLE_RECORD_OUT_SIZE default to 0x6000
* enable CONFIG_CONSOLE_RECORD=3Dy on qemu-riscv64_smode_acpi

=2D---------------------------------------------------------------
Anshul Dalal (1):
       doc: board: ti: am6254atl_sk: fix PRELOADED_BL33_BASE

David Lechner (1):
       doc: pytest: fix u-boot-test-flash typo

Heinrich Schuchardt (13):
       test: fdt_test_apply requires CONFIG_OF_LIBFDT_OVERLAY
       test: cmd/fdt: do not assume RNG device exists
       test: cmd/bdinfo: make no flash assumption
       test: cmd/bdinfo: consider arch_print_bdinfo() output
       test: common/print: do not use fixed buffer addresses
       test: cmd/fdt: do not use fixed buffer addresses
       common: default CONFIG_CONSOLE_RECORD_OUT_SIZE=3D0x6000
       configs: CONFIG_CONSOLE_RECORD=3Dy on qemu-riscv64_smode_acpi
       CI: test qemu-riscv64_smode[_acpi]
       doc: make writing DM test subsection of writing C test
       test: document ut.h
       doc: add include/test/ut.h to HTML documentation
       doc: describe return values of C tests

Sam Protsenko (1):
       doc: samsung: Fix PXE doc for E850-96 board

Vignesh Raghavendra (1):
       doc: board: ti: k3: Update TI firmware repository URL to GitHub

  .azure-pipelines.yml                      |   6 ++
  .gitlab-ci.yml                            |  12 +++
  common/Kconfig                            |   2 +-
  configs/qemu-riscv64_smode_acpi_defconfig |   1 +
  doc/api/index.rst                         |   1 +
  doc/api/test.rst                          |  11 +++
  doc/board/samsung/e850-96.rst             |  15 ++-
  doc/board/ti/am6254atl_sk.rst             |   2 +-
  doc/board/ti/k3.rst                       |   2 +-
  doc/develop/pytest/usage.rst              |   2 +-
  doc/develop/tests_writing.rst             |  63 +++++++-----
  include/test/ut.h                         | 159=20
+++++++++++++++++++++++++-----
  test/cmd/bdinfo.c                         |  15 ++-
  test/cmd/fdt.c                            |  31 ++++--
  test/common/print.c                       |  71 +++++++------
  15 files changed, 285 insertions(+), 108 deletions(-)
  create mode 100644 doc/api/test.rst
