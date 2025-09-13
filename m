Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28C8CAC582
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 00:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20123830A0;
	Sat, 13 Sep 2025 02:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t7jFHiWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5EB5833EB; Sat, 13 Sep 2025 02:32:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C4382ADA
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 02:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757723552; x=1758328352; i=xypron.glpk@gmx.de;
 bh=n6eFhd/HSFglf1a1GPxWGVCJYMhKoZDhHWgx5bXwBkc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t7jFHiWw+5kpSYgj8bX2d7YiS44l0ugGD21OltDPP7sMqqxZ1DJwnQh0kkP602xe
 wAn+9SU6TE7o3zHmU7SHdIpavuqro5LKHl2K/Tc081NHV++Quk+rpnLqKdE2QZI6j
 ti9rSWJZhcJii350kr2ZEQXpPclXhfkJ+QBrSMaS+dGNv4DzuW8qnnBXboAGAeXD3
 W5jhxFWDHcb38gFrXfwuhxAmz4dnnzIiC+5JBsm1XTgunOb8/nsfP3b7O/BkOgN8S
 baiHU4gVl5PGWxq/YxIHpf+CZSx9Z0P4hwKrZnAi9HEXOBZzJoXrQMtJxXOudqWjv
 XMnL8mM1rwHmcD/6sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1uuDOv0rJF-00UkMI; Sat, 13
 Sep 2025 02:32:32 +0200
Message-ID: <19c6abe0-c71e-4542-bf61-0e9f57c74c58@gmx.de>
Date: Sat, 13 Sep 2025 02:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Convert README.commands.spl to rST
To: Tom Rini <trini@konsulko.com>
References: <20250912230257.4145026-1-trini@konsulko.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250912230257.4145026-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sT62Wsx2HIYzbhNDkJt7j7g06MCwpXGj0TeZcSJgkuDilHWp9Iu
 jQokDDJOO8oRs75KsZTuJn7sXqgKz9yIDaSaZv+EsP6Qd+/qlwI7cBQM6lU7kfLUqV9Qtjm
 TV/SbrKvdx0olhwQJvjHMjoiTIeIjFYmvteMtdPmk6ChG+wYw5QW11Fzr1Epax0621UluN/
 6Aw3yxc8GO0N1yu8sHmvA==
UI-OutboundReport: notjunk:1;M01:P0:qeFHkASvIjg=;qajzsokDfPHhBubiOpldQWC+9kz
 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
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

On 9/13/25 01:02, Tom Rini wrote:
> This converts the existing README.commands.spl file to rST as
> doc/usage/cmd/spl.rst and adds it to the command index. Minimal
> rewording is done to the previous contents, to make it fit better with
> the overall style of documentation now.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/README.commands.spl | 31 --------------------------
>   doc/usage/cmd/spl.rst   | 48 +++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst     |  1 +
>   3 files changed, 49 insertions(+), 31 deletions(-)
>   delete mode 100644 doc/README.commands.spl
>   create mode 100644 doc/usage/cmd/spl.rst
>=20
> diff --git a/doc/README.commands.spl b/doc/README.commands.spl
> deleted file mode 100644
> index ecfd3ca9ee58..000000000000
> --- a/doc/README.commands.spl
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -The spl command is used to export a boot parameter image to RAM. Later
> -it may implement more functions connected to the SPL.
> -
> -SUBCOMMAND EXPORT
> -To execute the command everything has to be in place as if bootm should=
 be
> -used. (kernel image, initrd-image, fdt-image etc.)
> -
> -export has two subcommands:
> -	atags: exports the ATAGS
> -	fdt: exports the FDT
> -
> -Call is:
> -spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt]
> -
> -
> -TYPICAL CALL
> -
> -on OMAP3:
> -nandecc hw
> -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
> -spl export atags			/* export ATAGS */
> -nand erase 0x680000 0x20000		/* erase - one page */
> -nand write 0x80000100 0x680000 0x20000	/* write the image - one page */
> -
> -call with FDT:
> -nandecc hw
> -nand read 0x82000000 0x280000 0x400000	/* Read kernel image from NAND*/
> -tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
> -spl export fdt 0x82000000 - 0x80000100	/* export FDT */
> -nand erase 0x680000 0x20000		/* erase - one page */
> -nand write <adress shown by spl export> 0x680000 0x20000
> diff --git a/doc/usage/cmd/spl.rst b/doc/usage/cmd/spl.rst
> new file mode 100644
> index 000000000000..59471c65a623
> --- /dev/null
> +++ b/doc/usage/cmd/spl.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0+:

%s/GPL-2.0+/GPL-2.0-OR-LATER/

Cf. https://spdx.org/licenses/GPL-2.0-or-later.html

> +
> +.. index::
> +   single: spl (command)
> +
> +spl command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    spl export <fdt|atags> [kernel_addr] [initrd_addr] [fdt_addr if fdt=
]

Those brackets cannot be correct. I definitively cannot remove the=20
kernel_addr and provide an initrd_addr instead. Do you mean:

spl export <fdt|atags> [kernel_addr [initrd_addr [fdt_addr if fdt]]]

> +
> +Description
> +-----------
> +
> +The *spl* command is used to export a boot parameter image to RAM. Late=
r

In the current state the man-page is not very helpful. Please, move the=20
more extensive description from doc/develop/falcon.rst here.

* I would not know what a "boot parameter image" might be. Please,=20
explain it for a novice user.
* Please, describe what each parameter is used for.
* Please, explain what atags refers to. I would assume you mean what is=20
described in=20
https://developer.arm.com/documentation/den0013/0400/Boot-Code/Booting-Lin=
ux/Kernel-parameters-using-ATAGs.=20
But don't expect a novice user to know.
* What does the command do if "fdt" is used?

> +it may implement more functions connected to the SPL.
> +
> +spl export
> +~~~~~~~~~~

This heading makes no sense.

> +
> +To execute the command everything has to be in place as if bootm should=
 be

Bootm can for instance boot a FIT image with an EFI binary.
I wouldn't expect this to work when booting in Falcon mode where EFI is=20
not available.

This sentence should be replaced by a meaningful description.

> +used. (kernel image, initrd-image, fdt-image if used). The first argume=
nt
> +passed to the export subcommand must be either atags or fdt, which sign=
ifies if

%s/signifies/indicates/

> +we are preparing an ATAGS or device tree for export.

Isn't ATAGs the plural form of ATAG?
Why would you write 'an ATAGS' if there are multiple tags?

Please, describe under which circumstances and with which values these=20
environment variables are filled and what they are used for.

* fdtargsaddr
* fdtargslen

> +
> +Example
> +-------
> +
> +On an OMAP3 platform with ATAGS::
> +
> +    =3D> nandecc hw
> +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image fr=
om NAND*/

What format must the image have to be used for booting? A FIT image?

> +    =3D> spl export atags			/* export ATAGS */

Is spl export atags never used with kernel_addr, initrd_addr, fdt_addr?

Does `spl export atags` without further arguments create any ATAGs?
Where would it take the values from?

> +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
> +    =3D> nand write 0x80000100 0x680000 0x20000	/* write the image - on=
e page */

What is written to nand here?
What relevance have these magic addresses?
How would a user know which address to use?

> +
> +On an OMAP3 platform with device tree::
> +
> +    =3D> nandecc hw
> +    =3D> nand read 0x82000000 0x280000 0x400000	/* Read kernel image fr=
om NAND*/
> +    =3D> tftpboot 0x80000100 devkit8000.dtb /* Read fdt */
> +    =3D> spl export fdt 0x82000000 - 0x80000100	/* export FDT */

Why would anybody use a device-tree from a TFTP server in conjunction=20
with a kernel from nand?

> +    =3D> nand erase 0x680000 0x20000		/* erase - one page */
> +    =3D> nand write <adress shown by spl export> 0x680000 0x20000

The address seems to be gd->bd->bi_boot_params which is hard coded in=20
board files and not visible to the user. This is just gruesome. The=20
address should be exported to a variable to be usable in scripts.

Which customizing is needed to use the spl command? These settings seem=20
to be relevant and should be described in sufficient detail:

CONFIG_CMD_SPL
CONFIG_OF_LIBFDT
CONFIG_CMD_SPL_WRITE_SIZE
CONFIG_SUPPORT_PASSING_ATAGS
CONFIG_SYS_BOOT_RAMDISK_HIGH

Which return values does the command provide?

Best regards

Heinrich

> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 3a48521d5d56..a34db5cb627b 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -124,6 +124,7 @@ Shell commands
>      cmd/sntp
>      cmd/sound
>      cmd/source
> +   cmd/spl
>      cmd/tcpm
>      cmd/temperature
>      cmd/test

