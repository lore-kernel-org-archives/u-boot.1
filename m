Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D542C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5743B88AA8;
	Wed,  1 May 2024 11:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qCOxsd33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511E788A8D; Wed,  1 May 2024 11:14:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FE488AAF
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714554872; x=1715159672; i=xypron.glpk@gmx.de;
 bh=l5R4kyCL16868LmQJyG0pbzAX+5ZxxIU7gmP0vKbcvM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qCOxsd33M9VtvzCyDzQ3I6jUiiKyUsRb7ZYQql/89besxOXXaMjU/VVLOjY5CPbL
 tCo5zc65V/nHr5/ivyWJ9Ti9DJK0dIqx0Xqi9/cTlTY8AADorFrh03KnWzCSYU+NN
 zAF6tgU7c1tsOOshOxdwAJaLcQxZIsBYI+UzzS7l5/Mi+8y51o9b/cIdIfpgOuk5o
 kXjw+6esSxjiWzqygYItP9RnNgxI5GYappO4OPPKPdzaKouNuncqlqQjETXAkH1hX
 lENxoxa6vS6FBeKc4hPNOOGvTVq+eicH5TttBYK3f/NhholVtYVMM3M9eRr4AjwaE
 G/Sv5rwoWTqPM7xiWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMofc-1sKrLo1B8m-00IoB6; Wed, 01
 May 2024 11:14:32 +0200
Message-ID: <400218f9-d580-42fe-bb61-bc75c4e69cf1@gmx.de>
Date: Wed, 1 May 2024 11:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-07-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E1VJOvzEQf/A5A6qG926pFg631chkIANuN+kRw1IrwdfXqzUtEO
 scdGz59AHdixVjHmoxDEEcymIP6KuXgeCAMTpxRwvH2FCwKW/ljgjXSuDuHKSWOdtr/oKIs
 vKAsK/vY+AlODetGEdA4PmExAUYg8iQyu2ATY9Jp+XHSn+n4ovwTim2uqKQ2pAQhu8Q73hc
 Le2X71wmLl9FFWkbEo83Q==
UI-OutboundReport: notjunk:1;M01:P0:SIy7kC4v14s=;kmPV0tRwMSBsBFTNDquZ5KlmGQ3
 5pVyZjwRFnMWeOITHhub/w/6uauAX1PvjSRTJxea5gXyZI6PyuZ3Ki1beRapZAUyih/Hx1aHh
 Tut2se5U1lJB+gf2jC5hpVtKkAY2Gt5BMwHXKpLA39FK6nG/egCdUrnyKR4POjeoQkD19EKoV
 YbW1lYrkyKS1NIXLzowmMKgo/hhQJiqBa8z1AelaOxRJ0HOUowgvs8hXk8anCfITTBQj1iqOY
 hE7p5b85+sJMzd1ieDDu8BgHwpSCwYrOgceVVfd9TODyottVmDrzpRKvuxDISKA/jPQMTOTFl
 B+0WeLB8T4BYrxnvyOUh9nwPJiG8Bp7JaX1bK/OtqF1LVhjcatBGLRs8f17YQJoc9/aq4KK8S
 aWf1Jouvr5qi6cF9sIekaX7yKHm8jA+ucHNbX4886h0x/3mtyhTGHqQjcn6L42ptvSQIZx6z9
 vMUvpoxYzioxnCRNur0X2iife9j5GhAVuBwN4x8ulyV3afL8OoSI469D/V/ODhpS0G5SPc4Hm
 QaTtrh7hGmvizDwAQlF/L4emlJ4roQwV2zeplzbv6N6MQaUS4lbr1P6naQgvgDzkJCjMVnizu
 1IY5qNO0C7llQSs6TT1EcPNXAI+ZVwD5s9DU6lVy2XA1EvR1kVWJNa8WcIX2mBixd/7MhOlCn
 IPPsU5kYResC12xdchIrcbHbfG66E9BmoIyWBVUXSQyRQYXBnMsI48NIyLuZ6GmwfLCD417UY
 ZbEw13F8DacW42ksNCsk7a4WRD5z2Su5dDpj5agqPbNBRQle9v1STHiGFUOaIdlwHRtPq93nR
 Tb6xU1PtxEmu7psJz6E7nBvaLVpGQXExPbQDZQHRqEJ8o=
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

The following changes since commit ff0de1f0557ed7d2dab47ba976a37347a1fdc43=
2:

   Merge patch series "Update PHYTEC SOM Detection" (2024-04-29 10:56:05
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-07-rc2

for you to fetch changes up to 8745f13fe102968f58a9e2e5f69ad153a675b59c:

   efi_loader: pass GUID by address to efi_dp_from_lo (2024-05-01
08:40:42 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20590

=2D---------------------------------------------------------------
Pull request efi-2024-07-rc2

Documentation:

* correct description of 'env print -e'

UEFI:

* remove superfluous efi_restore_gd after EFI_CALL
* terminate efidebug test bootmgr early on error
* do not install device-tree if bootmgr fails
* pass GUID by address to efi_dp_from_lo
* remove dead code in efi_var_mem_init()
* enable QueryVariableInfo at runtime for file backed variables

=2D---------------------------------------------------------------
Heinrich Schuchardt (7):
       efi_loader: superfluous efi_restore_gd after EFI_CALL
       cmd: terminate efidebug test bootmgr early on error
       efi_loader: improve error handling in try_load_entry()
       efi_loader: do not install dtb if bootmgr fails
       doc: correct description of 'env print -e'
       efi_loader: fix description efi_dp_shorten
       efi_loader: pass GUID by address to efi_dp_from_lo

Ilias Apalodimas (4):
       efi_loader: address coverity report 492766 for dead code
       efi_loader: enable QueryVariableInfo at runtime for file backed
variables
       efi_selftest: add tests for QueryVariableInfo at runtime
       efi_selftest: add tests for QueryVariableInfo at boottime

  cmd/bootefi.c                                      |   1 -
  cmd/efidebug.c                                     |   4 +-
  doc/usage/cmd/env.rst                              |  10 +-
  include/efi_loader.h                               |   2 +-
  include/efi_selftest.h                             |  11 ++
  lib/efi_loader/efi_bootmgr.c                       | 111
+++++++++++----------
  lib/efi_loader/efi_device_path.c                   |   2 +-
  lib/efi_loader/efi_helper.c                        |   6 +-
  lib/efi_loader/efi_load_initrd.c                   |   2 +-
  lib/efi_loader/efi_runtime.c                       |   4 +
  lib/efi_loader/efi_var_common.c                    |   6 --
  lib/efi_loader/efi_var_mem.c                       |   2 -
  lib/efi_loader/efi_variable.c                      |  25 +++--
  lib/efi_loader/efi_variable_tee.c                  |   5 +
  lib/efi_selftest/Makefile                          |   1 +
  lib/efi_selftest/efi_selftest_variables.c          |  13 +--
  lib/efi_selftest/efi_selftest_variables_common.c   | 102
+++++++++++++++++++
  lib/efi_selftest/efi_selftest_variables_runtime.c  |  19 +++-
  test/py/tests/test_efi_secboot/test_signed.py      |  28 +++---
  .../py/tests/test_efi_secboot/test_signed_intca.py |  10 +-
  test/py/tests/test_efi_secboot/test_unsigned.py    |   6 +-
  21 files changed, 256 insertions(+), 114 deletions(-)
  create mode 100644 lib/efi_selftest/efi_selftest_variables_common.c
