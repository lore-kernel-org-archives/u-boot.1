Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFCECFB422
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 08:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDEE887FA;
	Mon,  4 Nov 2024 09:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hPPZPjDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C648880F; Mon,  4 Nov 2024 09:52:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99728862E
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 09:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730710361; x=1731315161; i=xypron.glpk@gmx.de;
 bh=KXXN0GndOxtVhEmGAAtI8x6gSlM18ciNvlXbXRpAESs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hPPZPjDgFF62wPXpKNki0weUQNchFom6uymCXRCRIGHjbHhsbuHanjSETBjwclqK
 sWRMNzKIV+/cwO+ShHaa/wKRAxIVkqcnnHLIUDudwSwBWfpTLJBLBK7+VXlhPX5rE
 7/iDyznwTTJtbnFGFN/ktY1HGx6Yc8rrb52R3MF4raq2+F6CZJYX4DzfhkusFlj98
 Ae/etxLFJjx3DofsAhvcSz/EYMkgJ6m7IM3jh+Ys69o8vp4/yugUi2fRaK4ThL85r
 yYerE2+JUynzBrvFYAqvCZBZU2ABDuc71CU19hPpVuA3RQ/JMCEG5ncaiPahI3Vnp
 0dLpv+O37n1pHGJshw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4axg-1t9XFn1FaQ-005IZF; Mon, 04
 Nov 2024 09:52:41 +0100
Message-ID: <4acd02a1-3c37-42a4-a1d8-a1bcec07ac66@gmx.de>
Date: Mon, 4 Nov 2024 09:52:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please pull u-boot-dm
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
Content-Language: en-US
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikLAAHvlM1hrs1/UNDbL9CE8qF1m1KaOkCrS1MzJTJWzUWcoUnu
 pQv8QJkuRZm/8SWgSNh/b1DXGzzUPGdkf9fvKZRUYdGn8YmyZMsj8sxavz1oSaWBqhIwfpS
 q6UQAzjew+CDuxoUDR6IC9Z8hX5vW7Feu14oZaLwYZbRFnnq57Nk2yeSbnu1f2fitEXp15B
 /+M4WKtOVf2+ysKliLrYA==
UI-OutboundReport: notjunk:1;M01:P0:SLzj7GPjIbc=;KlA6nbt5b1gcFkZ0p1fzDwfZd3W
 YP50GnSGwOZF47k9betRr/xTDhqFz8Tc84m1kp8PSSzQkezHEuz3njn+xm0vVIemTDcpsnd9x
 5SO1TSwazkzVQs0gnuZ0ewCYtDydJ4wmH46jc2NIibSIp8cTN6vMuE7Cxx0MTSpTPGqcT7JLt
 udvRkI03yQczhbkH7m9huVusnOzKaUFcsuJfK3fV7vMNfxJjxmFrF0yVIubG1nSddvlw5Z5iG
 gL7slh3s9Zzslp15sw7cz5kVx2cPX8LBu5CGSS2YmtdqodwnGdsQ13Bq/3kEqluRduRIDX/BG
 u/EAW9Eo5uhVx3hCOOayQx7eDJAsjOMqOet0hEp8V8URxJJDLKkFR4Rr8s7fNwzCdfDI6TJxU
 Iw5K8p3z+UG7mxII17TmUfXOvaLj8gIm1g0GoiNc4fE0JEQqardMkZ7BhG8MDKQUy3IBqotfc
 YXWPk33FNf1TZmP+ZgnUoBnwUqN7qol2UgrB9xekpF46ThF0KRFSJnrN/IJmzGncgztNExAPF
 CJD1uZzkMLNfgYMjz/wff5qdLu90lzQfthY3bWViZTr350Y/LYsrYUsLVIKirM758pjsPg8we
 nIN0lgMbE9oAH3r+Prrm/j5M+/IBjPh35W29W2ap1/Uham1RvBR/HIauILRl7qedOOwiKN2rd
 fHUFJakiiC2mmGgiB8y8TzxCSzH5gH5+YfTR5J2nq2XwzOrPjD9HhtNg8XLoKSg987C/kL8Q1
 +7kpj6Cgc6X+S//m50woE7eWmXIIYAi3ljdPpT9SvzkKtmBIEXANWFJeJrc8pN6D5YfV/zpSm
 vJBcvbiWBUZuLHq35Pt4yMDw==
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

On 11/3/24 15:47, Simon Glass wrote:
> Hi Tom,
>
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23152
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D71&view=
=3Dresults
>
> The following changes since commit e61ea9f2e5d2967826c2c6e3edba961064fbb=
aa1:
>
>    mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
> (2024-10-31 13:34:29 -0600)
>
> are available in the Git repository at:
>
>    git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov24
>
> for you to fetch changes up to 572b7b0255f9f33002ce7d2a8b2bac30ab49a48e:
>
>    sandbox: Fix comment for nomap_sysmem() function (2024-11-02 16:14:55=
 -0600)
>
> ----------------------------------------------------------------
> alist enhancements and fixes
> minor test and sandbox fixes
> some more x86/coreboot patches
>
> ----------------------------------------------------------------
> Jonas Karlman (1):
>        bootstage: Do not sort records
>
> Simon Glass (27):
>        alist: Mention the error condition in alist_add_placeholder()
>        alist: Add a comment for alist_init_struct()
>        alist: Expand the comment for alist_get()
>        alist: Add a way to get the next element
>        alist: Add for-loop helpers
>        alist: Add a function to empty the list
>        alist: Add a way to efficiently filter an alist
>        alist: Add maintainer
>        dm: core: Add a function to see if a device exists
>        test: boot: Use a consistent name for the script bootmeth
>        test: Expand implementation of ut_list_has_dm_tests()
>        test: Drop the duplicate line in setup_bootmenu_image()
>        test: boot: Update bootflow_iter() for console checking
>        bootstd: cros: Correct the x86-setup address
>        bootstd: Avoid showing an invalid buffer address
>        x86: coreboot: Add a test for cbsysinfo command
>        x86: coreboot: Show the option table
>        x86: coreboot: Enable support for the configuration editor
>        x86: coreboot: Add a command to check and update CMOS RAM
>        x86: coreboot: Allow building an expo for editing CMOS config
>        log: Add a new category for tests
>        test: Allow saving and restoring the bloblist
>        bloblist: test: Mark tests with UTF_BLOBLIST
>        sandbox: Convert sb command to use new macro
>        doc: sandbox: Add docs for the sb command

Hello Simon,

as described in
https://lore.kernel.org/u-boot/47ada0aa-97fe-4c0a-a662-4b184175a17f@gmx.de=
/T/#u
sent after the pull request there are some issues with the documentation.

Will you send a follow up patch?

Best regards

Heinrich


>        sandbox: Add a way to show the sandbox memory-mapping
>        sandbox: Fix comment for nomap_sysmem() function
>
>   MAINTAINERS                       |   7 ++
>   arch/sandbox/cpu/cpu.c            |  13 +++
>   arch/sandbox/include/asm/cpu.h    |   3 +
>   arch/sandbox/include/asm/io.h     |   2 +-
>   arch/x86/dts/coreboot.dts         |   7 ++
>   boot/Makefile                     |   3 +
>   boot/expo_build_cb.c              | 245
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   cmd/Kconfig                       |  11 +++
>   cmd/bootflow.c                    |   9 +-
>   cmd/cedit.c                       |  28 ++++++
>   cmd/sb.c                          |  42 ++++-----
>   cmd/x86/Makefile                  |   1 +
>   cmd/x86/cbcmos.c                  | 139 ++++++++++++++++++++++++++++++
>   cmd/x86/cbsysinfo.c               |  73 +++++++++++++++-
>   common/bootstage.c                |  12 +--
>   common/log.c                      |   1 +
>   configs/coreboot64_defconfig      |   2 +
>   configs/coreboot_defconfig        |   2 +
>   doc/board/coreboot/coreboot.rst   |   6 ++
>   doc/develop/cedit.rst             |   2 +-
>   doc/usage/cmd/cbcmos.rst          |  45 ++++++++++
>   doc/usage/cmd/cbsysinfo.rst       |  99 +++++++++++++++++++++
>   doc/usage/cmd/cedit.rst           |  76 ++++++++++++++++
>   doc/usage/cmd/sb.rst              |  79 +++++++++++++++++
>   doc/usage/index.rst               |   2 +
>   drivers/core/uclass.c             |  11 +++
>   include/alist.h                   | 139 +++++++++++++++++++++++++++++-
>   include/asm-generic/global_data.h |   2 +
>   include/dm/uclass.h               |  11 +++
>   include/expo.h                    |   8 ++
>   include/log.h                     |   2 +
>   include/test/test.h               |   3 +
>   lib/alist.c                       |  41 +++++++++
>   test/bloblist.c                   |  28 +++---
>   test/boot/bootflow.c              |   4 +-
>   test/cmd/Makefile                 |   1 +
>   test/cmd/coreboot.c               | 119 +++++++++++++++++++++++++
>   test/dm/core.c                    |  22 +++++
>   test/lib/alist.c                  | 253
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   test/py/tests/test_ut.py          |   2 -
>   test/test-main.c                  |  31 ++++++-
>   41 files changed, 1521 insertions(+), 65 deletions(-)
>   create mode 100644 boot/expo_build_cb.c
>   create mode 100644 cmd/x86/cbcmos.c
>   create mode 100644 doc/usage/cmd/cbcmos.rst
>   create mode 100644 doc/usage/cmd/sb.rst
>   create mode 100644 test/cmd/coreboot.c
>
> Regards,
> Simon

