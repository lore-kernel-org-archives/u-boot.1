Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C2BC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 14:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02AB87F51;
	Fri, 19 Jul 2024 16:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aH2zcAUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0216787DEA; Fri, 19 Jul 2024 16:27:04 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97928882FA
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 16:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721399217; x=1722004017; i=xypron.glpk@gmx.de;
 bh=sq8HnMiNA+DE4vXEFwO1dZAegk33gga5+OUaaJQWfGU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aH2zcAUVAIKtVskTa77hcXmNya6A4xKehbBti7WFZ08rLmisd+14cbCM/+fUiQf9
 ACtoP1j1tpHnLJjc//piMWJ8dKwIK78WNP3gCz0T9nsJQij39P6cO5/Xlna9fyL13
 UtrMUfQM/UY/knbhcRRJq/+6yJDaz6yz/3+U/E7QPYuMtDU3C1Hxc2NmsNRPOi2q5
 Y+EONMKkFXAhvFt5CgMx0i8QuAw/Z4AfSjbHaPrhrya1Wob6iWguCbCp5YaMW6ugS
 86iN7I8l0Rsna23zsI9AAEQJU2zFYQD6OFxRnVWbUBu9/8zuR2U9Pvh9qpUNcEWsf
 6dH11AnX5A9g5mV92g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1ss3wT3j3V-00TBwe; Fri, 19
 Jul 2024 16:26:56 +0200
Message-ID: <dec71b07-2360-444a-ba0d-19f09ae45a53@gmx.de>
Date: Fri, 19 Jul 2024 16:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Povilus <sam.povilus@amd.com>,
 Michal Simek <michal.simek@amd.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-10-rc1-3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NJSNvP3biKPHHj42Ah7SdtUUx0gLEhE51DvOVUxyiXKQ8dDO0mU
 WjsPYpZPCqEO8/NY27HRk4nqBQrBhwlZ2Sm5FnSfw5BqZlIt/Ti2dTNjJQm4b/dai9SZijE
 c54pfbMQwG78rvZVH+TeI3enspU3ISQP8rhagPh9UWjR2kyVfDXuJI62WugkmIhdo8Qb4P6
 1NIsXqLrdI5P/LrK7rstA==
UI-OutboundReport: notjunk:1;M01:P0:1BwchHUhGvo=;7NxflwXJRR/ZHKmmH/rxRnK9H6O
 xoCEq5NVbkQLTceTHWYE37thQtoTQJsR/ODO5BSyKljG49wZr65vSisjOBIPy5narnMnO8bEO
 6TDdo5NEkwa7widYBQe7v+UHTJEcqvz2IYgxDURzBOVDDK3MdzTJ3F1EW8hKIlxD5hO+OXqC4
 6WfiumS4vcOkc8hKNXgRO/7CJ0hRykYFHRNPKqhWx1GTViVXrYPKhtn+4ukVGOfgr9LnrrRkV
 sdGjVp/6Cgc43ktNjd7MO7XRnuDyVUaSBcmVgA/+OtR3cGwnvToPvzXoxygfHdQW61BDuIN0m
 +MzHjIa7sIxL3x+k0m3DyeuNyDveaK3ZjV2IrHZTJSUk4+qKjJvdwQLpvXreLZ5xcfJIrwLsh
 SprEWzGfmXgQp8v+l83dV0XBNdnMJfO2SHDxXxcw8qgMh+jBYcHvY2VL4wnhCXqRJ7Hjo07g+
 ZTu2xX16+cdZOF03ILQ7zF2XJjvMvwVC4uZjLVTC/8lo8L5bZ4XXdf4BuMyMBM5hRIxyFwJb5
 neaXq4ve295i3I09RKqzA354fLneAewkCkj2RXWYoJyQe/81Vb7kYtv3v+78Y3S3g53SeYDLX
 /vla5KTx6bvUJMjIVJyVE1tcTkFLEQkBB+UiInSv68wkvpw63XWWb311KGsZTHLHwvDi7Swt5
 1Mks0bhsOp/eg9DQbkzJtD0HzB0ddwZc0K/LyctSD6j0N3mxchJD3nuONUR87KTOAntMnXEXH
 dqFTzrs8Z1A5nc/cnlkkgGNfgqfiADfm+TiWYAK3tX8YnnJ5hFspSXeF/c59/dWO/L9iCQhtB
 dL+gXcmreDDGAESrs8grVc9g==
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

The following changes since commit 459560000736ac7c9c8b04522789c20fb45ff95=
a:

   Merge patch series "bootstd: Add Android support" (2024-07-18
17:03:47 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-10-rc1-3

for you to fetch changes up to 38b000881ebc0a48b0a814fce9f52dfe62ac644b:

   doc: Describe the bootstd settings (2024-07-19 14:01:46 +0200)

No issues were reported on Gitlab:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21685

=2D---------------------------------------------------------------
Pull request efi-2024-10-rc1-3

Documentation:

* move out-of-tree building info to HTML
* enable ReadTheDocs addon management
* Remove FIT documentation that is elsewhere
* Update table of contents for FIT images
* Add description for more boot methods

UEFI:

* Correct finding distro device-path for media devices
* Fix typo in EFI_RT_VOLATILE_STORE description

Other:

* MAINTAINERS: Rename BOOTDEVICE

=2D---------------------------------------------------------------
Heinrich Schuchardt (3):
       efi_loader: find distro device-path for media devices
       doc: move out-of-tree building info to HTML
       doc: enable ReadTheDocs addon management

Michal Simek (1):
       efi_loader: Fix typo in EFI_RT_VOLATILE_STORE description

Sam Povilus (2):
       doc: Remove FIT documentation that is elsewhere
       doc: add missing table of content links

Simon Glass (14):
       MAINTAINERS: Rename BOOTDEVICE
       doc: Move bootstd into its own directory
       doc: Mention automatic binding of bootmeths
       doc: Add a description for bootmeth_extlinux
       doc: Add a description for bootmeth_pxe
       doc: Add a description for bootmeth_qfw
       doc: Add a description for bootmeth_cros
       doc: Add a description for bootmeth_sandbox
       bootstd: Tidy up comments on the boothmeth drivers
       bootstd: Correct handling of script from network
       doc: Add a description for bootmeth_script
       doc: Add a link to VBE from the bootstd docs
       boot: Correct indentation in efi bootmeth
       doc: Describe the bootstd settings

  MAINTAINERS                                       |   4 +-
  README                                            |  20 -
  boot/bootmeth_efi.c                               |   3 +-
  boot/bootmeth_extlinux.c                          |   2 +-
  boot/bootmeth_qfw.c                               |   2 +-
  boot/bootmeth_sandbox.c                           |   2 +-
  boot/bootmeth_script.c                            |  53 +-
  doc/board/starfive/milk-v_mars_cm.rst             |   2 +-
  doc/build/gcc.rst                                 |  28 +
  doc/conf.py                                       |   6 +
  doc/develop/board_best_practices.rst              |   2 +-
  doc/develop/bootstd/cros.rst                      |  33 ++
  doc/develop/bootstd/extlinux.rst                  |  29 +
  doc/develop/bootstd/index.rst                     |  15 +
  doc/develop/{bootstd.rst =3D> bootstd/overview.rst} |  45 +-
  doc/develop/bootstd/pxelinux.rst                  |  27 +
  doc/develop/bootstd/qfw.rst                       |  20 +
  doc/develop/bootstd/sandbox.rst                   |  17 +
  doc/develop/bootstd/script.rst                    |  52 ++
  doc/develop/index.rst                             |   2 +-
  doc/usage/cmd/bootdev.rst                         |   2 +-
  doc/usage/cmd/bootflow.rst                        |   2 +-
  doc/usage/cmd/bootmeth.rst                        |   2 +-
  doc/usage/environment.rst                         |   2 +-
  doc/usage/fit/index.rst                           |  25 +-
  doc/usage/fit/source_file_format.rst              | 684
+---------------------
  include/efi_loader.h                              |   2 +-
  lib/efi_loader/Kconfig                            |   2 +-
  lib/efi_loader/efi_bootmgr.c                      |   2 +-
  lib/efi_loader/efi_fdt.c                          |  33 +-
  30 files changed, 350 insertions(+), 770 deletions(-)
  create mode 100644 doc/develop/bootstd/cros.rst
  create mode 100644 doc/develop/bootstd/extlinux.rst
  create mode 100644 doc/develop/bootstd/index.rst
  rename doc/develop/{bootstd.rst =3D> bootstd/overview.rst} (95%)
  create mode 100644 doc/develop/bootstd/pxelinux.rst
  create mode 100644 doc/develop/bootstd/qfw.rst
  create mode 100644 doc/develop/bootstd/sandbox.rst
  create mode 100644 doc/develop/bootstd/script.rst

