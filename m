Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9805FC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 22:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19D488765;
	Tue, 16 Jul 2024 00:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OuZoyTpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FF5887E6; Tue, 16 Jul 2024 00:30:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAE3F886F5
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721082623; x=1721687423; i=xypron.glpk@gmx.de;
 bh=ysOLR2/KOEXTjo4lZ7oe+Km3VF0mgUV/wW2lclq9m0M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OuZoyTpksycoApwMy1Qhp3+IZgoRS2hUfB5lfLONYnVmro7SIG8npFYzZ0w6DZnN
 2KAZkJ0W38xZYgvXcLGcfIkAimj9ZWmDF7lbtcdVJ86alyoUK1AWrJKhrL693aBTS
 2QGAtfa/3tHiQxnSTsj+wSNCp47gNvxHYjZh+0vFcsfdvB1KiFuTK3s2oc6VOC1H+
 b5t89ratmjHougCYpSAwjyqOCXe67QEH9Uwo5kF2qN4cNxy1sGHVxj3vxvnpdsUIK
 mLMqG8avxPq/5eaxyFOuIfnM03DUmi4LeOQqf00CbK/SYkRgNBW4NdwoKUB/m5JkC
 UMhzv0MetUv/U7CHMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1s4Zm51L9q-00dQej; Tue, 16
 Jul 2024 00:30:23 +0200
Message-ID: <b89a7250-3453-4580-8ee6-eddfe83ad10a@gmx.de>
Date: Tue, 16 Jul 2024 00:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] doc: Add a description for bootmeth_extlinux
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-4-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V7EhriTKtYkRVOPo8aJdnmjxMGUZdz5kDLKxRJHQWcQOKVhfCa3
 gYNu2uV+XpSntkUJUiCJpRqzytyYu1gBKBnJiIfmaSytfh1oP0xX0amRdmcpsgsGaRkY0zC
 yAt/tcz/4p64bPKwCoH7UkNpVGuqHwa6TugpP20B+kSic4QRxa8eUeR6lvbmQbtIjBD43kO
 0kWohqu0HYWB4NCrAiKsQ==
UI-OutboundReport: notjunk:1;M01:P0:yvYyJhwIcyE=;w38fmzNnKI8q3fB6jMPD2rZcA2d
 sVA1UODla7Rku/M6y37LWeWA4XPl+wBo6sBbvyYsQx17VaBnN4fTmB25q3HRvawMsNPWZey0Q
 lOjLU7OPy7eJj7ZL0Ppc7XJo7mBUvrGeg2ALqoGI//iEmst8DtkXJq5BUxO52dNYL20wfwI09
 wFlLjn2/v/cBHcG7X/J10rQt2oXxBzPg3DuYZd6OEOtKCjSSjsWTr9Iy2aHuZGqW7vgwOEE3H
 XdA83mBo+zl+tEr8NcWLbn4tZm4ZIVRKMyvHi3bTJ9WRrgEFQR0G3YKzh5ZHoniHL5/dqplMA
 DsbQHxxNirAb0WiBq89qH9WOiGKtA954Lo4zbhgMOHfi+OBzMNauHKgCf+7bAUJll2zagrgfn
 9yz6lU5MfOaR5ucdRNOpG7Mk1xC8Ja5V6G54ufYhGRt6R78ovI3j4OfApMGoyjMxFlxuFxoVp
 mQ71mRayH+rdHTWMrKk04zzbs7pR79d6QUa85C8Z8/f+sE4KPJezjg8ZkFBH2JZS0Je4V+QOb
 gDT+KsQLsQJcIAZhD91ZAqxb3nPVWLPUQrSMp4K1gaH8++YccGBcOZY+h0MXHmfyZK4ICsLi3
 0CrkKBkfn14JndsXyyNODne/PRm+FEiN3aYf6ja3vLpVsSuGL4xh9Ud3WcsA2dbXaWr+kGQG/
 FgosxbjPY0r3MUDJGpko9sM8YwvC4FmcYszjJ3VFV1ASS6mI4d8HXWUvfPgfP/y6slm1T266t
 YugY9vbCAtNXY4xtCo3B3iafL86Acs+Mb9G0qhBGr+oKpwq+EqYXGBtQT0CNVBheHa+x8TB5R
 jkJvz68I382mqlQ2FURXWSvA==
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
> Add documentation for the extlinux bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/develop/bootstd/extlinux.rst | 27 +++++++++++++++++++++++++++
>   doc/develop/bootstd/index.rst    |  1 +
>   doc/develop/bootstd/overview.rst |  2 +-
>   3 files changed, 29 insertions(+), 1 deletion(-)
>   create mode 100644 doc/develop/bootstd/extlinux.rst
>
> diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extl=
inux.rst
> new file mode 100644
> index 00000000000..28490f38899
> --- /dev/null
> +++ b/doc/develop/bootstd/extlinux.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Extlinux Bootmeth
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_spec=
ification>`_
> +(sometimes called syslinux) allows U-Boot to provide a menu of possible

%s/possible/available/

> +Operating Systems from which the user can choose.

%s/Operating Systems/operating systems/

> +
> +U-Boot includes a parser for the `extlinux.conf` file. It consists prim=
arily of
> +a list of named OSes along with the kernel, initial ramdisk and other s=
ettings.

Please, avoid abbreviations.

%s/OSes/operating systems/

> +The file is stored in the `extlinux/` subdirectory, possibly under the =
`boot/`
> +subdirectory. This list of prefixes ({"/", "/boot"} by default) can be =
selected
> +with the `filename-prefixes` property in the bootstd device.

%s/bootstd/boot standard/

> +
> +Note that PXE (Preboot eXecution-Environment) uses the same file format=
, but in
> +a network context.
> +
> +When invoked on a bootdev, this bootmeth searches for the file and crea=
tes a

Please, replace throughout the text:

%s/bootdev/boot device/
%s/bootmeth/boot method/


> +bootflow if found.

%s/bootflow/bootflow/

> +
> +When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set =
up the
> +context, then pxe_process() to process the file. Depending on the conte=
nts, this
> +may boot an OS or provide a list of options to the user, perhaps with a=
 timeout.

%/OS/operating system/

> +
> +The compatible string "u-boot,extlinux" is used for the driver. The dri=
ver is
> +automatically instantiated if there are no bootmeth drivers in the devi=
cetree.

Device-tree never contain boot method drivers. Do you mean:

If no boot method driver is selected by a compatible string in the
device-tree and CONFIG_BOOTMETH_EXTLINUX=3Dy, the extlinux boot method
driver is enabled by default.

Please, mention that the driver is only available if
CONFIG_BOOTMETH_EXTLINUX=3Dy.

> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.r=
st
> index f4f87c7787c..5bbb3d633a3 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -7,3 +7,4 @@ Standard Boot
>      :maxdepth: 2
>
>      overview
> +   extlinux
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index 761f61a573b..086a0b1281d 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -412,7 +412,7 @@ Available bootmeth drivers
>
>   Bootmeth drivers are provided for:

%s/Bootmeth/Boot method/

>
> -   - extlinux / syslinux boot from a disk
 > +   - :doc:`extlinux / syslinux <extlinux>` boot from a disk

After "provided for:" I would expect "booting from a storage device".

You can't use the infinitive here. The days of disks are counted.

Best regards

Heinrich

>      - extlinux boot from a network (PXE)
>      - U-Boot scripts from disk, network or SPI flash
>      - EFI boot using bootefi from disk

