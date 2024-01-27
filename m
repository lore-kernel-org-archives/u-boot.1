Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52587C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 08:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8445F87F11;
	Sat, 27 Jan 2024 09:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gr/0kZ5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB2087F12; Sat, 27 Jan 2024 09:55:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E0F587EB7
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 09:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706345707; x=1706950507; i=xypron.glpk@gmx.de;
 bh=HIQMVhvufuV8WsfpQpS6FuUk2WgDWw1Ccz43zeMNpFw=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=gr/0kZ5viw9PX9naOi4I6QOh7LAPAA/7oDMEkzNO47tiPEEUw6JlvtJ1ZaL4tdGm
 SApUQ9XzBvW3dwp9yUEYMww0m81uGusU/nQmPry9WXTz8VGptsXeL45qUar8YmeF1
 eSPpJ29UD6uQLSCyXkxl/ZH/9jrwA4amXpufVZP7lDgCINxc5Bj6MD39EoLk+t1VR
 iO2azFoKUUq4NsOQzfqBdmZKOYnYoxceJO1IPM3OP5kYGFnBAgYOa18/djcKkreci
 naOhmBthGkYcpd4mVJClHeklovHJfwOlmbFr3I1eTRrF8G0LRlQQjpwcyXVZkXGfV
 Rgs2QI4bq1JBFtDuxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUj2-1rCOjJ26eA-00rYDn; Sat, 27
 Jan 2024 09:55:07 +0100
Message-ID: <a52b7ce1-1737-47e2-a2ca-aaa36cc6db7d@gmx.de>
Date: Sat, 27 Jan 2024 09:55:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request smbios-2024-04-rc1-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5oeF0hI7zh0EZkwKaRFRtOwwNFd7wIBNU9oFI214Cz1KGNi7HUn
 gP/PNZwwGpXyOHgVOlwl8Rhs9iIr08dbUCshsNceOYVuOTJDIaBFcG42a8UiCgKC8Y0r0gP
 jeoXZIGlMXNxiG/P8IKN8Ae4N5+DIAoONUJ20N305TrBYe1p6wIYayOe4yhsKQgInYEqhsi
 OXUmFbJZqhr3joGaGk11g==
UI-OutboundReport: notjunk:1;M01:P0:LjYzjg/FYnY=;uFzEq44pm2ZFSnlC6JelgpcP3Yw
 fQgsKnGAIqWiYt1KJUrsAGIVtjjChWORYGAvMQQBNv8BeYJs02Fc9mlTMgUKHYS0pVZHWUoUN
 rCNYSajyJWR0JXtMhOryIhbumAl7tIUMRmI1gL+n5UbcU+La7T99oSIcK7dwoxC3wuyJJF798
 6SKXugkuSQuWLO7yDz6W0rPtcSHq9IalU6Bd/OXPiKekp/CaCTfiskH0MU+o+ZWiPi3HTRUKp
 NHTrBWuNHZOmqb5+A57JK2MFCkQG1wrnNoMdUGJ3MtvtgyTCxk4PAdpJyFNQAs18dQi8iFjj1
 7MKnV/7J6n1RZstSL8rREF/446o/hPn3IPofMN2AT9+hYSPAFIqAUcl1Wdj7e4eGXN6sORwpF
 yyk8dS7jsaC9Ld75eVmliPON0w3yDO+MvQVZYfDAs8Oo7M2/YM8W6gfl/DFJRfsDpAi74tv3S
 JKdkIwBdgnKoQnAGj/53dhunMemXx3towFfroaVSnj/iUOOb4GGTuOsGsoqf8QcMzrfJmIsx6
 hllp4OGAj8Co5hZodidtOTrudC0CAVR41toOW9nUkh97vJQv5sNtbRN/NdpfTBaKruDo+8TMP
 Vr+Z7XQTsZ6Ws7UGSSVth5BkdLf6om8Ute6HrMLBYWv2MF6BUiKsb3bOWvluNqGv2VYtX2CYC
 50dkr4k+1jkF+6CDaNFI6w/QdX2WstHE73gEYPY2hj8PFpUOhvSKzwbwDYqVRAHrMokkmu4q7
 gnZ/NC9yVFQgqs84Fh1d8lQ+62dMO2G9MEfh7SqF4u8jDrepuycd9n+RSUnY/mNQZSVVXrSAN
 Zg11OoUQ1GzBMgxU9OCqGGvaoIHLP8GeWftRpumwXMKhTwtoleAoaYi2+9njhvaMJ+1I19FzE
 sHeXWbtp+b1D5OF075HfvZXGQWsBv/paIY7NAbMV1POAkih5jHf0rGyRmheAjOzsG8Z7GOn7Q
 CF+gAmjt4vScBl/dmLByIGJ8R00=
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

The following changes since commit e7f9e5eb584dd0b5d1b1ff82fe607d6da9940cc=
6:

   Merge branch '2024-01-24-assorted-fixes-and-updates' (2024-01-25
11:01:38 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/smbios-2024-04-rc1-2

for you to fetch changes up to 91cc06bcab76dd4b9d07c221b4962283f0984c8e:

   lib: support SMBIOS3 table in uuid_guid_get_str() (2024-01-26
14:17:55 +0100)

Gitlab CI did not report any issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19447

=2D---------------------------------------------------------------
Pull request smbios-2024-04-rc1-2

* Add missing field to SMBIOS type 2 structure definition
* Provide smbios command to display smbios table
* Enable the command on sandbox and qemu_arm64_defconfig
* Provide a python test for the smbios command
* Fix copying SMBIOS 2.1 table from QEMU
* Correct EFI TCG measurement to assume SMBIOS 3 table

=2D---------------------------------------------------------------
Heinrich Schuchardt (7):
       smbios: type2: contained object handles
       cmd: provide command to display SMBIOS information
       doc: man-page for smbios command
       test: unit test for smbios command
       configs: enable smbios command on sandbox
       configs: enable smbios command on qemu_arm64_defconfig
       lib: support SMBIOS3 table in uuid_guid_get_str()

Masahisa Kojima (2):
       efi_loader: migrate SMBIOS 3.0 entry point structure for measuremen=
t
       smbios: use struct_table_length to get SMBIOS 2.1 total table lengt=
h

  cmd/Kconfig                          |   6 ++
  cmd/Makefile                         |   1 +
  cmd/smbios.c                         | 191
+++++++++++++++++++++++++++++++++++
  configs/qemu_arm64_defconfig         |   1 +
  configs/sandbox_defconfig            |   1 +
  doc/usage/cmd/smbios.rst             |  93 +++++++++++++++++
  doc/usage/index.rst                  |   1 +
  drivers/misc/qfw_smbios.c            |   2 +-
  include/efi_loader.h                 |   1 +
  include/smbios.h                     |   5 +-
  lib/efi_loader/efi_tcg2.c            |  19 ++--
  lib/efi_selftest/efi_selftest_tcg2.c |  97 +++++++++---------
  lib/smbios-parser.c                  |   9 +-
  lib/uuid.c                           |   4 +
  test/py/tests/test_smbios.py         |  41 ++++++++
  15 files changed, 407 insertions(+), 65 deletions(-)
  create mode 100644 cmd/smbios.c
  create mode 100644 doc/usage/cmd/smbios.rst
  create mode 100644 test/py/tests/test_smbios.py
