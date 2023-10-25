Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C04C25B6D
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 02:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC77879A6;
	Wed, 25 Oct 2023 04:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VjKjztwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47541879A6; Wed, 25 Oct 2023 04:20:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4228D8799C
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 04:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698200404; x=1698805204; i=xypron.glpk@gmx.de;
 bh=GMli6kE5vOH3uHDpR+mCs+Qboo4dEtwv21/S3twJ/70=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=VjKjztwY4G78BUnxntTh/yQ+3K20UcUf+W5KTgWCnLh3qoniPptpLesJpe1jMLUF
 qqvNMax+Nl88KwO6LjRJNrw/tvWk4DSQCicta1cPHP1kBPwLLVN83XAgyZHiTVaP8
 1wI3kSUvgIkCyIa8HX8F/SbB+mJpc3vyIYuYvHZH2LIMjjVSZQJJ+CPgXeOpM11R1
 RHn50BT9jvUAMr5yi7eTIR1dEWB3jIXu4xdupElyoHQ96pm2Uo/vWgaxN+yErBCq9
 fcBC5BUyZgY4egswQWnqzZd7nQAOV4EvkTLVGdfyfzpSZxxLwtiLDZDpZAfUoSOgz
 KCLJSOsDJmxlRCkWLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1rjIlF0xOP-00wni5; Wed, 25
 Oct 2023 04:20:04 +0200
Message-ID: <d61eb00b-baa8-4804-801a-045eb56ed617@gmx.de>
Date: Wed, 25 Oct 2023 04:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dylan Corrales <deathcamel58@gmail.com>, =?UTF-8?Q?Milan_P=2E_Stani=C4=87?=
 <mps@arvanta.net>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-2024-01-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:My9isvuzDvhpH2LW2b04baaTEj8ALtcj+v17R4T2bWjvNBq52xS
 GR9fgKplwoymGZc5S/qUqcbnhcAcaNt5ykG1z8O4DFFu800ieYB7SYyxhegccMRL7u6i0L5
 b3u+XEJXn6HgE9yJRs0eyHiAIn7g9JnPDom/KkntsNViCex70kyn1n8ZuA6eWQ0/GwTXev5
 WN9d50WRuEHO1E2VJW8VA==
UI-OutboundReport: notjunk:1;M01:P0:aLxzzf/DIHk=;o174eeojj4nG0CsQTRdcqbql7sN
 LGvEwg9Es5Mgd3vztNzDlqcfxeJn1zYinIxpsZC2oLpCdpcq1KwxFz7nnn0DSKRYngwCij07/
 3Cgsp9iueyPehYNq6eyjA2Z10HH2r2tG0yxEdGwEVf873O4iYZZrhpgEgw+SOK7ijXRAdWQrb
 onrP1m+ZsJvJfnnELw/TUo8VkjEX9nw+/LWdIgqww9EHagTBDvxT4gfe6b+R3FagqdqFBSybZ
 8jKwkBsUpXvL46OX3qqP8myjMI9fd8wsZoxp2dOs4M7ExD+LtcVXRUpiQ6iBa9u+bUK0bo/tN
 6KAPRMQrS3YhZ/EGqgzRzzsikkwgeOb/cfNmKMgeMQthN52MN3zmFN/JXOGunMUJXY0CVQOUP
 juL9bQoEEF0+m736XAOiJctkzuoST1e1ivHz6VTjpODHnDfq43OQ6mKLt15tEJ0ix/IUV8xn+
 GnJdTZcSvNtM7ersq5yNGz+qmX3E8/Ea8+RmIPo7RNPj2DNYqtLNKfi2OULHpF9oy9jtNL/vP
 yywAdoKCNoBWsewxy8YKu6HVPBA7XwcZ5hkg77mWQCuHjoSqINdDfL0nEvHLBgr7UxyflKsM5
 7D4X0hUb6uB8XrGBTW6wHNsL+cQEOruyrY+H9s22oAlXuBA1is30EjRdplbiqDCMnlDP4DHBc
 ZfiO5cGZZZL9MJi88PnKt34LV4kUHvvMny/Bh7s4Kckw9NNyme6juYEA5Kts5RSWMbVFSO3eE
 qa4/giqrw3outxP1NLtvulXQF4rRZrFWoaINclSdT0SqEl6D2nYfiEt3wIPrnOnPmt/nns/qG
 vD6YwmGoR7k07DlfK4EqW62raD1L6ZNVCknweDUN7S8X2gSXUSlK0UrjEmeFeeHUy7doZi/Uz
 kyVJgd2Fj1Wr2igqdZtZbpx7jdYOPhZBuEpN5EVdnVbpxh/sr3elYUvZec2uDhPpvp994sVry
 ECZuWA==
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

The following changes since commit 5cab3515f8c9796015739c1750b8933291c816b=
e:

   Merge tag 'u-boot-rockchip-20231024' of
https://source.denx.de/u-boot/custodians/u-boot-rockchip (2023-10-24
09:39:52 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-2024-01-rc2

for you to fetch changes up to 916dad34af0e53181dfe21f5764d3a787cb24bdc:

   efi_loader: fix EFI_ENTRY point on get_active_pcr_banks (2023-10-24
23:56:43 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18293

=2D---------------------------------------------------------------
Pull request efi-2024-01-rc2

Documentation:

* Bump urllib3 version
* Replace references to dm_dump_all() with dm_dump_tree()
* Update description of build dependencies for Alpine Linux
* Fix typo in gpt example
* Fix ordering of shell commands

UEFI:

* Fix build failure without network
* Expose the device-tree file name as UEFI variable
* Move misplace EFI_ENTRY macro.

=2D---------------------------------------------------------------
Dylan Corrales (1):
       doc: Replace dm_dump_all() with dm_dump_tree()

Heinrich Schuchardt (2):
       efi_loader: fix efi_dp_from_eth
       efi_loader: expose the device-tree file name

Ilias Apalodimas (1):
       efi_loader: fix EFI_ENTRY point on get_active_pcr_banks

Milan P. Stani=C4=87 (1):
       doc: build: update description of build dependencies for Alpine Lin=
ux

Tom Fitzhenry (2):
       doc: gpt: fix example of echoing variable
       doc: usage: fix ordering of shell commands

Tom Rini (1):
       sphinx: Bump urllib3 version

  doc/build/gcc.rst                      | 10 ++++++++--
  doc/develop/driver-model/debugging.rst |  2 +-
  doc/develop/uefi/uefi.rst              | 14 ++++++++++++++
  doc/sphinx/requirements.txt            |  2 +-
  doc/usage/cmd/gpt.rst                  |  5 +++--
  doc/usage/index.rst                    |  8 ++++----
  include/efi_loader.h                   |  5 +++++
  lib/efi_loader/efi_device_path.c       |  5 ++++-
  lib/efi_loader/efi_setup.c             | 30 ++++++++++++++++++++++++++++=
++
  lib/efi_loader/efi_tcg2.c              |  3 ++-
  10 files changed, 72 insertions(+), 12 deletions(-)
