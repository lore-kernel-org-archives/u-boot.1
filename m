Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C7C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 22:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF17888266;
	Tue, 16 Jul 2024 00:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QF8han8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C66588908; Tue, 16 Jul 2024 00:42:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1C587FC8
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721083359; x=1721688159; i=xypron.glpk@gmx.de;
 bh=HXYOH8nAyIsYmEIp8mBKNebrg8tZ9sCUVXsK+zrXUsY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QF8han8y1x32hTlM/l2lImodXMoKQyWMPh1Trfyer5D0F6rw8lh2rQwL4DQny9PH
 mrbDM+Cgw+ovVyJiSGNnxYfU3C+PM1QDNWOEvKqbLvd7secBA9mwz8w6OHCXhTIVU
 FLNHHSsnWxQybVex+N9py0ALeHYs2KR1cLs0pKoPxrJoK+fZNhl/QhOAFnrf2cuyZ
 /SawLTUS8e1o6sY9fMWPcVJz8tiR+O7gJpjSJAm11q5J+hRk9cdyz2n6sU5Ko8j5t
 wa17iY3VNSteQkkiK1MgSwrW4CvzmPQm9FZydrYhi+ixX/UDUy+UKMeYjRRDIEsdk
 DscuGf755p5ymXO7jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1sTUP10o0u-009I94; Tue, 16
 Jul 2024 00:42:39 +0200
Message-ID: <846128e4-2833-43e6-8af9-9f57d9025475@gmx.de>
Date: Tue, 16 Jul 2024 00:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] doc: Add a description for bootmeth_pxe
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-5-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CNqnaQnRdRnHZtyuyKyE9zlx/8JbsIppMActkRBWebhjYaF/l2I
 KIGeZe9/5XvlzV+U0eDjGCFHwrkBdUd0IH3xlCGPNpaOFqEcvumfauBcbGV1rIIeHh67e/k
 wmt42SmfV9hZAHtICk66Br07E/IcIHMIvkIZZJLEJ7YCbbCo4yVpxJ3LrMOFGaQiJSRbVuL
 FuLlh2egPeaTc4mPSVL8g==
UI-OutboundReport: notjunk:1;M01:P0:F/269QX6+CY=;WcTTGHjcFXwenq0bCIsQQrIgu/Q
 LnkAy/qhPa1D5ZVTrDOb2T+lECKAzGOkwenxcCJYBDMS3WYsWgUugtx2d6HaBk9iqVyxocCNx
 gMkB9u86GEFNa2ZYEZm4d9PSDkZZb/FmClRd2Hxb9J5787Pz24A56PnqXYlC9erlguuo/gDid
 XEeI3koyMlPVVJ3qORhCGchXf7MmeZ3QzVMPb+EIn5VKllFHko8Cx/sZThREMVqIUH/qJhNKY
 O7KfMHSsj7U47fdszsmh5GDvla+VLrf43q8M7K4/vzAUf88/wJCdZHOD5G6BCJtOLY9wHNX8H
 LLnm7wZAnEZmxzxethBoAHZuKKdGyeHS1cQBXjUEAtKh6N4pRTnQMMVgYrcJWMSboLuxB2Cdt
 fF6MxJpkFIs9eCIgUcMVLEuxUYsHtBwpPYJa+BfqGuWrf7YeFbERA/SbNcHfPATSxWGouZjjM
 /yhQnpA1Emm5l6ZsfX9XgJQat5ghO3Mx/XF4ucwTif51RdzEHngHjXYS3HX9gGasQl4+ELK/S
 Y7CZfnhvlUdklslsh4d3n5D3/N2CewS1JmdwYJgpZcGoZ7Ycw3Shc4rv33afuuY1qxCL0ASzy
 RqrLWdgQbZ/cBCkjztTOkhJfoQ1Tfen5h3yaF0J0/FyLjq7vQLSFPOFq67aiTqeQV81D36RLf
 RX3RplMdn2pdqQId2g/T8FOd+GKm1Zb31j5Q/GG6BPbrqcVQKtRgK+z03CQwGEe+ynPVJrLzm
 WD2A28glCBk08EOOCrjkQwGp/SbOzFdWioQeM8LsiQ2MG6o4O+lBynaStEx4giLa2tbjGMg5+
 RG39X6vCJH8n9yirD/pBGQ8w==
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

On 7/15/24 12:13, Simon Glass wrote:
> Add documentation for the pxe bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/develop/bootstd/index.rst    |  1 +
>   doc/develop/bootstd/overview.rst |  2 +-
>   doc/develop/bootstd/pxelinux.rst | 27 +++++++++++++++++++++++++++
>   3 files changed, 29 insertions(+), 1 deletion(-)
>   create mode 100644 doc/develop/bootstd/pxelinux.rst
>
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.r=
st
> index 5bbb3d633a3..5052afe448f 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -8,3 +8,4 @@ Standard Boot
>
>      overview
>      extlinux
> +   pxelinux
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index 086a0b1281d..fd0692daf0d 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -413,7 +413,7 @@ Available bootmeth drivers
>   Bootmeth drivers are provided for:
>
>      - :doc:`extlinux / syslinux <extlinux>` boot from a disk
> -   - extlinux boot from a network (PXE)
> +   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
>      - U-Boot scripts from disk, network or SPI flash
>      - EFI boot using bootefi from disk
>      - VBE
> diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxel=
inux.rst
> new file mode 100644
> index 00000000000..08ba67e09c5
> --- /dev/null
> +++ b/doc/develop/bootstd/pxelinux.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +PXE Bootmeth
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +PXE (Preboot eXecution-Environment) provides a way to boot an Operating=
 System

%s/Operating System/operating system/

> +over a network interface. The PXE bootmeth supports PXELINUX and allows=
 U-Boot to

%s/bootmeth/boot method/

> +provide a menu of possible Operating Systems from which the user can ch=
oose.

PXELINUX is a binary. Does U-Boot really provide a menu when the
PXELINUX binary is downloaded and executed?

> +
> +U-Boot includes a parser for the `extlinux.conf` file described
> +`here <https://uapi-group.org/specifications/specs/boot_loader_specific=
ation>`_.
> +It consists primarily of a list of named OSes along with the kernel, in=
itial
> +ramdisk and other settings. The file is retrieved from a network server=
 using
> +tftpboot.

Does this paragraph relate to PXELINUX?

tftpboot is a command and not a protocol. Shouldn't boot methods work
when the command line interface is disabled? I guess you want to replace

%s/tftpboot/the TFTP protocol/

> +
> +When invoked on a bootdev, this bootmeth searches for the file and crea=
tes a

%s/bootdev/boot device/
%s/bootmeth/boot method/

> +bootflow if found. See

%s/bootflow/boot flow/

> +`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX>`_=
 for
> +a full description of the search procedure.
> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set =
up the
> +context, then pxe_process() to process the file. Depending on the conte=
nts, this
> +may boot an OS or provide a list of options to the user, perhaps with a=
 timeout.
> +
> +The compatible string "u-boot,extlinux-pxe" is used for the driver. The=
 driver
> +is automatically instantiated if there are no bootmeth drivers in the
> +devicetree.

Device-trees contain compatible strings for drivers, not the drivers
themselves.

If every configured boot method is enabled if there is no compatible
string for boot methods in the device-tree, why don't we mention this in
the overview instead of repeating ourselves?

Please, mention the relevant configuration option.

Best regards

Heinrich
