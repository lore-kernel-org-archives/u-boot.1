Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC31E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CF389221;
	Wed,  4 Dec 2024 13:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ezsSeALj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C601F8926D; Wed,  4 Dec 2024 13:10:35 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B8C88C98
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733314226; x=1733919026; i=xypron.glpk@gmx.de;
 bh=gnUOcsYaI4G5egFQ1XdC3qaRUiXebLiqxNP0FMiB5v8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ezsSeALjnwJ/iPiAqjzEkwbIk3q8IqvGu9Q5r8ARsj7NodWTJc5xhjuN/jUxNAAh
 Dt09J+qp5M1WSRA5Pe6uBp+qU0blAp4F43DX2FG2fe84KnBSy/yAx3biyfHIEbWGi
 RCCJxFEl6a4kRjMmfvttz4gFfGIu0RQhFdZawwDRWDIlM2Bj/tqTLQXVvWBYjkRFs
 hiScWKXzD1FQdswhFVg0Eeu592+UjhDowhoO3+JvTxOzjSwunoBaFqTOrW0fqMq1H
 2UGCWwEzdZtRfS8DQH3jjsPw2CJdcmj5uemYbyE00hHxXsdg4bjQEMzAz6lHioQF5
 GO+rp22VVKHZRVNm4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6Zq-1trc3o2BdG-00mn3o; Wed, 04
 Dec 2024 13:10:26 +0100
Message-ID: <8910d434-2d77-425f-aa81-8eb803078aef@gmx.de>
Date: Wed, 4 Dec 2024 13:10:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andy Yan <andyshrk@163.com>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [MASTER] Pull-request efi-2025-01-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eLgojZNERYo6HxL80fRBwd6aTt816/UAOrEs7zQd8ElcFyZdk11
 BMyRS6sGKPn8LuMyJUNqswFr4/RioPYBPfwPGNIF9CC1E0QG7HvP2sDvH1+8gMIZ3QiiiQs
 QvlwA8sVPlZ4P3L/GpD1HkMwEfg0eOsdjU99GGnWYEngBgakgStUobKOhS4Zwqa5SHpmXZl
 ZMVqHo/z1GDfdBXVn406Q==
UI-OutboundReport: notjunk:1;M01:P0:isDTeEC2cZw=;ldwjqTSVeLJSnWQwXiETJbl/OhA
 Cr9Mh4c7Li8eCr8r+aCiBRDe0pPXitoyGXZHkMRg/c9OZVoY1jvjVpWZLW6J7kUrRPgtsXy3W
 VaElHqUJAXGXXM3d/ve8cakwlA8C5FJhlMCTFlcBXCPwyw5QQhqpj7oj8PvmUtRwPG2wT8fDg
 A7Mwz71gV80Bq9VkhG7WVs/P5X02zWbFuoAXAmVx0CQjG86kwSfLsrL1NFpgkDrzv5MivRcyL
 5UXhgj0J5QFjpC3hUlNMdVPncqJZCLVt6YLQX77HL9OnZKrqUxvzxQyMv0iiHVFzUcKkzp3ys
 wIDXEIjZ5HUAn/LrThcMwV1ubPrJGUberLfvFbj7KSv9Jv79JslwvacpAmZ3O22lqpb1rPiZB
 sBHD3DD6sp5qm8GVbp7hNC/LOaiVkjRMqbNKdY6NyqbDgWByrunpD85TI+BnHnyGACLZPLOEw
 UbuerW3VxFJ4cpenjlwB3wOhQ9sF4vPjcswKgp2ylesp8znIl8dzOlN6TqZaYSioL6CSwArZA
 3u67S8BMIF9S6CWeOEjE/LECyokZX+X40TCsqKV7WBhZAhg9/0xZGajTToFhJB85HdI/3zm0O
 UUefbzVPRRpd5CV9ZmXH+wN9NcTSiIvGrXNbpkCicAS+7015k09rlm4PRt7yLGO2rEAdZyK5V
 7G0gjIbFGGlptAe8REsUks4AClgaiORCcYxrRVMhl9wejbWvckQEKWnzFrCh1y41c2BZeWQFS
 cRTzodKcB5xD7wO825xODzeBiF2xo4y6NoDazqJ2u5nJK8XqpHHuP2G1qMz2v8z6hnkDceNBu
 rcYOtAumYgbuK8d+xUf7LseUwTyxD3NqokcEGtJs44EPZtX6zcYXiBTSioss0uEUhmbjZ40hJ
 on7Gap5sI041+rTOO5Ec0XYtPkJBuvRR5HAHzSToGFF2vjqPwjglsFgUukmnO7umOILha7CCX
 Nb/+EE+bJDkwxiUs/pDBHaHhecpsyHmoSByf632CDfaGSE1Ul2jx9CE4gHjokcuhjtz8pLYEa
 Nl4kp3I/9WZc/zd+8+5y9S3CBLNPFaaQOYLRaRX8HFyLsOT4SEbXtMWL+NEozDgL8IyzLBE0W
 0c/sWFyy/3e1KwVW66Q9AK1rfB9Sao
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

The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee5=
6:

   Merge branch 'master' of
https://gitlab.denx.de/u-boot/custodians/u-boot-samsung (2024-12-03
12:37:20 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2025-01-rc4

for you to fetch changes up to 657310322e5893d0b1bbba002fbe59b318062192:

   doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayipN
(2024-12-04 11:26:34 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/23706

=2D---------------------------------------------------------------
Pull-request efi-2025-01-rc4

With the move to bootstd booting via the EFI boot manager stopped to
consider all block devices due to missing probing.

With this pull request probing of all bootdevs before running the boot
manager is achieved. Prerequisite changes are needed to pass the CI.

       efi_loader: simplify efi_disk_rw_blocks()
       test: fix test_extension.py
       configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
       CI: xilinx_versal_virt: disable USB_DWC3
       net: eth_bootdev_hunt() should not run DHCP
       cmd: bootmenu: add parameter -e for UEFI boot options
       efi_loader: run bootdev_hunt() to find ESP

Further UEFI changes:

       Avoid writing message in Exit() boot service
       Update startimage_exit self-test to check error
       Don't warn if the TCG2 FinalEvents table is not installed

Documentation changes:

       cmd: bootmenu typo 'read'
       clk: mpc83xx: Fix typo in "Coherent System Bus"
       efi_loader: Fix typos in enum efi_allocate_type
       doc: sending_patches: Fix spelling of "its"
       doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayi=
pN
       doc: board: theobroma-systems: fix feature list in introductions

=2D---------------------------------------------------------------
Andy Yan (1):
       doc: coolpi: Fix document style

Heinrich Schuchardt (9):
       efi_loader: simplify efi_disk_rw_blocks()
       test: fix test_extension.py
       configs: sandbox_deconfig: remove CONFIG_AMIGA_PARTITION
       CI: xilinx_versal_virt: disable USB_DWC3
       net: eth_bootdev_hunt() should not run DHCP
       cmd: bootmenu: add parameter -e for UEFI boot options
       efi_loader: run bootdev_hunt() to find ESP
       cmd: bootmenu typo 'read'
       efi_loader: avoid writing message in Exit() boot service

Ilias Apalodimas (1):
       efi_loader: Don't warn if the TCG2 FinalEvents table is not install=
ed

J. Neusch=C3=A4fer (2):
       clk: mpc83xx: Fix typo in "Coherent System Bus"
       doc: sending_patches: Fix spelling of "its"

Jerome Forissier (1):
       doc: environment: NET_LWIP dhcp sets ipaddrN, netmaskN and gatewayi=
pN

Quentin Schulz (1):
       doc: board: theobroma-systems: fix feature list in introductions

Simon Glass (2):
       efi_loader: Fix typos in enum efi_allocate_type
       efi_loader: Update startimage_exit self-test to check error

  .azure-pipelines.yml                            |  1 +
  .gitlab-ci.yml                                  |  1 +
  cmd/bootmenu.c                                  | 41
+++++++++++++++++++------
  configs/sandbox_defconfig                       |  1 -
  doc/board/coolpi/genbook_cm5_rk3588.rst         | 11 ++++---
  doc/board/theobroma-systems/puma_rk3399.rst     |  1 +
  doc/board/theobroma-systems/tiger_rk3588.rst    |  7 +++++
  doc/develop/sending_patches.rst                 |  2 +-
  doc/usage/cmd/bootmenu.rst                      | 13 ++++++--
  doc/usage/environment.rst                       | 31 ++++++++++---------
  drivers/clk/mpc83xx_clk.h                       |  2 +-
  include/efi.h                                   |  2 +-
  lib/efi_loader/efi_boottime.c                   |  7 ++---
  lib/efi_loader/efi_disk.c                       |  8 ++---
  lib/efi_loader/efi_setup.c                      |  8 +++++
  lib/efi_loader/efi_tcg2.c                       |  2 +-
  lib/efi_selftest/efi_selftest_startimage_exit.c |  6 ++--
  net/eth_bootdev.c                               | 30 ++++++++++--------
  test/py/tests/test_extension.py                 |  4 ++-
  19 files changed, 116 insertions(+), 62 deletions(-)

