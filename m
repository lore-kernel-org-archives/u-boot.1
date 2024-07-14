Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2543C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 10:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33475882B6;
	Sun, 14 Jul 2024 12:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HDul82wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E262882B7; Sun, 14 Jul 2024 12:53:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43C887CFE
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 12:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720954415; x=1721559215; i=xypron.glpk@gmx.de;
 bh=ofuop6Cecm/85oRf42M6Z7nD7AzwhC6xE+IhJ5MjmD8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=HDul82wxkqGXPj4asroCI91R0z2hkdun8hpNxT8IEgbFK8a+3uh1gyDMgEeA+gf7
 CeO7cpHg2l7tQuBccPA+nCzCMhtu3SPfO9o6GLI4uL8gdYCpJNqheV3CemT3as4Mz
 yR0tRq27Ceow6goKRhay+NM8mNrYw4nFg1T4MZP7xbmXmWp1diMSAsdgyZCIRPqlk
 UzACR+N8vmVsdCHI8kKWZjJ9sx9olmHahHtnZVhqb+G9bQ94oQrTsSULRfHUFVd4T
 1r8ODGYvHALdW2RJasys8gVnRRNf7ppD1H4BsapUGgeYQSEkCuSXbwcRZwsthqRCZ
 l+AIf3KqV+7zTqjbSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1rt3sL0VjW-00hOpj; Sun, 14
 Jul 2024 12:53:35 +0200
Message-ID: <21695e77-125b-4acc-b45a-d286624c1145@gmx.de>
Date: Sun, 14 Jul 2024 12:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-10-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZoNENyzFrBDQBIGLE8vnzMIRU4zfBeG49jn4v0/MHrhoQLB/tiU
 Rkl9JoQv/4IuzJIUDSILmc70n2RfgYDTPXxdR0ghxTROTSW5bkylYBprpbKZSaCRoXPjIeX
 JcgC88rwYcUvu+3ZB5SzJrsLMgZY3CRWqVLDzqjpXy2niRGEZcVcyXEF5JRby4SGORHPDPr
 kchIw6DYLOfgCbTaNsXzg==
UI-OutboundReport: notjunk:1;M01:P0:NRSLXIPPJiw=;BvlG/0BMSdI22Il00MPyNqoeew8
 Nc5puhmpLIrj1OvOSmFgr65tVcu7r3Vt6uk6Vghd1tUiI2qbgNZiNWX1U8LJMmyLd3suUPIyr
 BQ9BR/XuTT+CnutnRMrb8jsKj9PvRqI/ncs4iYSHEhFPv64yd6Xr8m4ClPd3bn/aQKmQVpC1/
 lwv/8osqqDRdSP0wGTs53HIS4WPvwXorL6OhTheTDjIq42SfOeGvbOr9cNQ+XOY81Qv9H/Ve8
 GXD3EBrRlnjLxdGGzG7y5Mdj+QVVJkxEiLmicG/hn0zrnLdPYx+GmCNYGxyveLWRbEMCf4s/V
 VP0osIfw1U8WrEPR5Gq/4CYRXlNVIRCf2LhNqMQihrGALVjlRYot7cHC/u+7X39vY+JTtoGW3
 FphDF5AWkXuX+4/T4aBD2Mi1+lMCYMzmnx5FOC4QOKo+Qw/b7sO+k7JkOB6P4RPlgpSlm60hH
 igP3K19Gw8RW/h3+Q+Qxyw6wN2EL0md+Z0/2gbCPAY007HwCOo6SPB100cTMgHiWEt+gs/WB/
 NcVmhys+yeRGZJRLDNGWB6SKbGMwqszOvSj3fLbCz6q29jqLzTCnDqUHZ71URaLSgp/o88Ey6
 6RLnv7L3kl2hCvv3RGRru5JxLCmkMpqX2TZ7a1qsr+pKAWRL3DB5VYti2r9b9Lh+/H2fM5zta
 MF/b8w6MFwi6ieXAhlShlcgEUjvodlEqX+3S013O5H5s8YrGBZABlaBmcqQOhFFlv+KWb0E5h
 TMbms5+2j91PCkxLe6xlDTSobIzwjO5ZjM1INEjl9PxvJT8jVyx8Au5/qGAkxUkGTlt+gwkYH
 aYjrnwZFcJAbJltGkiL+zDHsROyF6Qglzsq7QSRhWM+iQ=
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

The following changes since commit b182816c1fb436916661949213c543bf4d42250=
b:

   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc1-2

for you to fetch changes up to da909648e13fdfb5306123f4bc2a89bf2cbf682e:

   doc: add bootelf command documentation (2024-07-14 09:56:24 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21597

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc1-2

Documentation:

* use current versions of certifi and urllib3 for building documentation
* add bootelf command documentation
* correct the description of the Goldfish RTC driver
* correct heading level of itest examples

UEFI:

* print device-tree in dtbdump.efi
* consider CONFIG_EFI_IGNORE_OSINDICATIONS in TestEfiCapsuleFirmwareRaw
* correct cmd_capsule_esl_gen invocation in scripts/Makefile.lib
* use capsule CRT instead of ESL file when building capsules

Others:

* let ENV_IS_IN_EXT4 enable SYS_MMC_ENV_DEV
* check if CONFIG_SYS_MMC_ENV_DEV is defined in mmc_get_env_dev

=2D---------------------------------------------------------------
Heinrich Schuchardt (5):
       efi_loader: print device-tree in dtbdump.efi
       rtc: fix the description of the Goldfish RTC driver
       doc: fix heading level of itest examples
       env: ENV_IS_IN_EXT4 should enable SYS_MMC_ENV_DEV
       sunxi: CONFIG_SYS_MMC_ENV_DEV undeclared

Ilias Apalodimas (1):
       test: test for ignore OsIndications

Jonathan Humphreys (2):
       scripts/Makefile.lib: fixes: Embed capsule public key in
platform's dtb
       scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file

Maxim Moskalets (1):
       doc: add bootelf command documentation

Tom Rini (1):
       doc/sphinx/requirements.txt: Bump certifi and urllib3

  board/sandbox/capsule_pub_esl_good.esl             | Bin 831 -> 0 bytes
  board/sunxi/board.c                                |   2 +-
  configs/sandbox_defconfig                          |   2 +-
  configs/sandbox_flattree_defconfig                 |   2 +-
  doc/develop/uefi/uefi.rst                          |   8 +-
  doc/sphinx/requirements.txt                        |   4 +-
  doc/usage/cmd/bootelf.rst                          |  61 +++++
  doc/usage/cmd/itest.rst                            |   2 +-
  doc/usage/index.rst                                |   1 +
  drivers/rtc/goldfish_rtc.c                         |   4 +-
  env/Kconfig                                        |   2 +-
  lib/efi_loader/Kconfig                             |  12 +-
  lib/efi_loader/dtbdump.c                           | 261
+++++++++++++++++++++
  scripts/Makefile.lib                               |  24 +-
  .../test_efi_capsule/test_capsule_firmware_raw.py  |  21 +-
  15 files changed, 375 insertions(+), 31 deletions(-)
  delete mode 100644 board/sandbox/capsule_pub_esl_good.esl
  create mode 100644 doc/usage/cmd/bootelf.rst
