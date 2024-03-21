Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38D6C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 07:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BCA787FA1;
	Thu, 21 Mar 2024 08:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tqtTZ0gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A5887FA1; Thu, 21 Mar 2024 08:48:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4754D87D6C
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 08:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1711007275; x=1711612075; i=xypron.glpk@gmx.de;
 bh=luOakRPk72uzoNs6CrOuQUTA9X4HGdwTQ76ZLrgCN9s=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=tqtTZ0gxdhyrW9Jxez9HXKRh7HaQs3G4Sw4aeo6MEgZ6SrK3UT9D5/TwdLwHjrau
 xJzjmWjnlvT+b+MoVSsWP6B6uElVsxU5CUhwXMMrjcxT5Gds/Cj//Rzlipwu4gr6Y
 14q37F/rVAYp3cDTzTGrYm21A22KCLEADJQcPClz03RGZW45hmzaAARNxXmVSs6Zu
 I2qbAuZpv7FGdvtdBX776Om8Dx/res6JRRePAbvhr9jmP9y7+WZHoVVIP34MdQFvZ
 6x4kJiz6lH/Anor2niGuCyKlwoL89Gah3vXaDEcvZmvrzLw93kr5m5NuGvvoFHVSH
 QsA9PhxXQ2FV5kYMJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1r3fmg0Zo5-00loTx; Thu, 21
 Mar 2024 08:47:55 +0100
Message-ID: <38662008-a812-4fe4-aeee-b160c4e59c12@gmx.de>
Date: Thu, 21 Mar 2024 08:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Janne Grunau <j@jannau.net>,
 Sumit Garg <sumit.garg@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request efi-next-20240321
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7E+1/iqkoVWyX9vVQu8+he+hghT5zyQkPcP8PrWGvqM4KsZlQEf
 39p9WwQeJtyHfxZcGjhuk2x/zIuczolP0JeOfCf3crrRw56E563vW3Tg8h2efazvKevPNaj
 fbNtxTn8GruGAQeZCGqJqHsC1C9MLmfrg+rO5dOiFCjGE1TxiAaACJXHG9fB0iBBxxfFtsm
 6Daqg92wjZEm21k0LpWEQ==
UI-OutboundReport: notjunk:1;M01:P0:rXOMj+3sufo=;MgvXr+MpoUk0IBidSxCvmRDcx7o
 kHglv5WUC/sjaONuATO6+ZVN5mAMSef6eu3+GU3EXzwNHiT5ZtaWBqD8+1zP+Iu4teYRPKiP7
 EKET6M+O2Fi5pp3jKjajnUHXXUvWlAfaMlQM5VW9gSwgb6j/GMEf20acPFIiE3/x/trpurjQl
 9MypRwc6G9f7vzyf3TgAGNLN72njQzdJC1LKxrKs5F/lO4H2gNJP3SXLF2zMQ5RDVAmzVwmrf
 LEcBX9+PhWyIMTUFPLAwKqZwYF8hjlZPrwfImrKFXHbjNhDjNFOqyRBuyf8sCM5gdJ9eVcjbl
 ctbkT5laeRIc3Prxa7ZW82kvKIJsoAot44XKwdSgnbl2V4RsZY7npYxHHk+En7cDVtL/0fdDQ
 285hqLyONZuHaY21/ZrMFhU5iMquYLherLrbvvzMhqKsTMpt3Z9yy1dw6uWDClxWojOH+K0qK
 nDRxgHpbSYyxD+cFlD/LRrJ4cC7QYz6TTfWImN8Xh6L9bqqdHKJipKmuzPso229QNtC1zfVJ4
 zs3BE1HjGGFtIgE4u8IwxHx6BYNLZ2vjsBhZ88ClM5CIuEYGk2hkDgZwJtrSad6eY0f+jg10Z
 oL/d2wQRrDgM0Gp7fFn2CIJyBRX/6IuFItNzVgKM9vQZQH9g9s40fjke4d1z0pXYsVw8RbK9y
 lg36ezp9BNo1k16lu4kyzZBI+pna7XjNC279pTkuFZb3bRekSZzyUxPCpQPP13qzDBHODlXUi
 vz/nwXf9tBHUmZh++pydYrEl+F0fv9AIxYX08hASRLVHpCD0MOvNOkNyvZj/H8qe3OtCLiKk5
 h/yxMdtLCfEboSgVw9VUbqD/x2RWEhP/W2GorsSbVqy2w=
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

The following changes since commit e50cb36cb5e772d5bbd30d070faedf732340636=
4:

   Merge branch '2024-03-19-assorted-updates' into next (2024-03-20
08:39:05 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/efi-next-20240321

for you to fetch changes up to 884785adc1dc5e7b91acb542ba83941951ff2b77:

   doc: typo Synopis (2024-03-21 07:00:12 +0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20011

=2D---------------------------------------------------------------
Pull request efi-next-20240321

Documentation:

* Avoid short reference link names in device-tree documentation.

UEFI/Video:

* Support code page 437 code points 1 - 31 used by GRUB

=2D---------------------------------------------------------------
Andre Przywara (2):
       efi_selftest: Add international characters test
       efi_selftest: Add box drawing character selftest

Heinrich Schuchardt (1):
       doc: typo Synopis

Janne Grunau (4):
       video: console: Parse UTF-8 character sequences
       lib/charset: Map Unicode code points to CP437 code points 1-31
       efi_selftest: Add geometric shapes character selftest
       efi_selftest: Update StrToFat() unit test after CP473 map extension

Sumit Garg (1):
       doc: devicetree: Lets avoid short reference link names

  doc/develop/devicetree/control.rst                | 24 +++++-----
  doc/usage/cmd/acpi.rst                            |  4 +-
  doc/usage/cmd/bootdev.rst                         |  4 +-
  doc/usage/cmd/bootflow.rst                        |  4 +-
  doc/usage/cmd/bootmeth.rst                        |  4 +-
  doc/usage/cmd/cbsysinfo.rst                       |  4 +-
  doc/usage/cmd/cedit.rst                           |  4 +-
  doc/usage/cmd/cli.rst                             |  4 +-
  doc/usage/cmd/dm.rst                              |  4 +-
  doc/usage/cmd/fdt.rst                             |  4 +-
  doc/usage/cmd/font.rst                            |  4 +-
  doc/usage/cmd/for.rst                             |  4 +-
  doc/usage/cmd/history.rst                         |  4 +-
  doc/usage/cmd/host.rst                            |  4 +-
  doc/usage/cmd/md.rst                              |  4 +-
  doc/usage/cmd/mtrr.rst                            |  4 +-
  doc/usage/cmd/panic.rst                           |  4 +-
  doc/usage/cmd/part.rst                            |  4 +-
  doc/usage/cmd/sf.rst                              |  4 +-
  doc/usage/cmd/sm.rst                              |  4 +-
  doc/usage/cmd/trace.rst                           |  4 +-
  doc/usage/cmd/ut.rst                              |  4 +-
  drivers/video/console_normal.c                    |  6 ++-
  drivers/video/console_rotate.c                    | 16 ++++---
  drivers/video/console_truetype.c                  |  8 ++--
  drivers/video/vidconsole-uclass.c                 | 18 +++++---
  drivers/video/vidconsole_internal.h               | 19 ++++++++
  include/charset.h                                 |  2 +-
  include/cp1250.h                                  | 12 ++++-
  include/cp437.h                                   | 12 ++++-
  include/video_console.h                           | 10 +++--
  lib/charset.c                                     |  9 ++--
  lib/efi_loader/efi_unicode_collation.c            |  2 +-
  lib/efi_selftest/efi_selftest_textoutput.c        | 54
+++++++++++++++++++++++
  lib/efi_selftest/efi_selftest_unicode_collation.c | 12 +++++
  35 files changed, 204 insertions(+), 84 deletions(-)
