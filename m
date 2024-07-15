Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E957C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 22:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732928851E;
	Tue, 16 Jul 2024 00:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UpAzLubY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253B988633; Tue, 16 Jul 2024 00:56:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4DCF87D74
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721084202; x=1721689002; i=xypron.glpk@gmx.de;
 bh=l+PqHsP7Nrx9Wb1zW9hGJmJzai8D5G4XjnRlOBvDYho=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UpAzLubY3QZ+eCFozNrADtUxQ8fu6G5OnM21QyPm3pGbjxuJiVkd0rW7pO71KEZi
 HYNMKgABzvoHWVAQKhRy8IE8D0IqvCkfkgP0CafjGe8ObPTfZajBP2bmmVl1zKb/c
 Bo9mNH8HI4NoSUpWsfH8TxuQxhsoek5/ITqzoB/jlMYnu42lZX4yZMk1gFdNPKwUJ
 Fs9h1pDRMoqfZb2FTUPys9eg07rB3sBv/NRbE4yzz1VI3CqhbIapRzW8lLTuRKjJM
 LmHfTkWN33QFe7ueUJTh9oA8Skgvm3e2Cx5rl5jZPYMB+hGnxi8NUDBSarkC+l+Yg
 U4dxQJA+jsQmPUaXPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1sw7JS2CU4-00KGHf; Tue, 16
 Jul 2024 00:56:42 +0200
Message-ID: <a3aad2bc-863a-493d-9446-a65f28fcc09a@gmx.de>
Date: Tue, 16 Jul 2024 00:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] doc: Add a description for bootmeth_qfw
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-6-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tc5AFWKf6CY61ukni2yAquWjEFT0PMjRrWpDByy9MN1v/CW75RN
 HLawCHHFzDoK9Xy33tfDr6fQU87joBc2RPGcRWnnnqKtNiNWWuCIOBeaR3ef5idwZT3gCtu
 9He1A5iSPLtgGh/gZZjvSc0HZqSpZW38IwDuEGIKNitTAP9jjIrxIO9aqq4C/+MpJYNOYaY
 LxYKJFCPLRj3Cb5bxI3Vg==
UI-OutboundReport: notjunk:1;M01:P0:KNC+k0S8GtM=;2pbY/86HTsWB945xnk8D9+xbboM
 P+vaFzSKDVuZGZAvAlCG6O1gHhTza/ogkW4T+o01gnz815SVKlR4/j3aXln3tHNtwH6s2s2ie
 QavUmotBQBrgAFf5lgdVRdes5zh4g/d34jnpKLzuHYkYTrSMEAJStofYMIW5F2sOoa1X2N3MD
 8Qiy+kqOeRV+x2OeOqTJg8L8MxTqbpip7TVyjZIvgGXs+29A4nXPyNMvbhW8AOr/3g1xVFz/X
 X2Dux3Ytrt81S4nvZ+o7nVF6XIP8vyChMZlaqv3u97tJpYhKUajguYWj0nA/gqHKKUVmpm6Yv
 ulUwL5lHM8fWLVER0TbvdR3Ckb0tO58wyrimmF0+TMXsbjerCeHLLvP+gQTWQkhkjN+IpbrcH
 8Jz2CuJHR8H6ibmv0ypWKqQnASnQcQkrOZTgHmJKoFyJShCj1Kdh87vJZ+OzDOGYc6XLnchPf
 p+Na4b3+sITnT9V9tdF3hMWsp1FCtA03sWgxtZ0qtOeB2q5lqvNmXFsiw3gIoFLd/KqYVUMdJ
 RYskkiWCb7SuKmNpZWFx/SnAtjTTJEa4PQ4kLb78nDoCUZ6EuHmXIQvW+upOipsqu4oo/ILdY
 QM3cwqAnu0fQc/DCnTYeBDVGkFkVu2OTZXK1Qo4EmRgNzvcg5DCCzY/F/LMfhckTE42Y1ktHD
 YXaTIc7mUPfQ1yjO/UQuC8Ks3Ey9HDyWcUhvsOh86rRcKHzBeJb08NWgzs8DG2sB0O0C8IRUS
 kwSV/Hp/tw0gD2Ry/1qkzNNxJ9T7OuFuKXG9n9NGcfpp8yKIpN+sn5j1HwlDmmA1SkU5BROk8
 elhgxjAnznMj1jgErxlRgf8A==
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
> Add documentation for the qfw bootmeth.
>

%s/bootmeth/boot method/


> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   boot/bootmeth_qfw.c              |  2 +-
>   doc/develop/bootstd/index.rst    |  1 +
>   doc/develop/bootstd/overview.rst |  1 +
>   doc/develop/bootstd/qfw.rst      | 21 +++++++++++++++++++++
>   4 files changed, 24 insertions(+), 1 deletion(-)
>   create mode 100644 doc/develop/bootstd/qfw.rst
>
> diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
> index dfaa944594e..2f8e00cf350 100644
> --- a/boot/bootmeth_qfw.c
> +++ b/boot/bootmeth_qfw.c
> @@ -88,7 +88,7 @@ static struct bootmeth_ops qfw_bootmeth_ops =3D {
>   };
>
>   static const struct udevice_id qfw_bootmeth_ids[] =3D {
> -	{ .compatible =3D "u-boot,qfw-extlinux" },
> +	{ .compatible =3D "u-boot,qfw-bootmeth" },
>   	{ }
>   };
>
> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.r=
st
> index 5052afe448f..f8fce7207ce 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -9,3 +9,4 @@ Standard Boot
>      overview
>      extlinux
>      pxelinux
> +   qfw
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index fd0692daf0d..bcc2c00c775 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -418,6 +418,7 @@ Bootmeth drivers are provided for:
>      - EFI boot using bootefi from disk
>      - VBE
>      - EFI boot using boot manager
> +   - :doc:`QFW <qfw>`: QEMU firmware interface
>
>
>   Command interface
> diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
> new file mode 100644
> index 00000000000..b0d47fd246a
> --- /dev/null
> +++ b/doc/develop/bootstd/qfw.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +QFW Bootmeth
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +`QEMU <hhttps://www.qemu.org/>`_ is a system emulator which is able to =
boot
> +Operating Systems. QEMU provides specific support for booting an OS ima=
ge
> +provided on the QEMU command line.
> +
> +When invoked on a bootdev for UCLASS_QFW, this bootmeth reads the kerne=
l
> +provided by the QEMU `-kernel` argument, the iniital ramdisk and provid=
ed by

%s/iniital/initial/

> +`-initrd` and the boot arguments (command line) provided by `-append` i=
nto
> +memory ready for booting.
> +
> +When the bootflow is booted, the bootmeth tries the `booti` command fir=
st, then

Boot methods should work if the command line is deactivated. We should
not use run_command() but extract the functionality into library code.

Why would you first try to run booti and then bootz irrespective of the
availability of the commands? Function qfw_boot() needs rework.

There should be a configuration symbol to disable the boot method when
CONFIG_QFW is enabled.

The bootmethod should no be built if booti and bootz are not available

> +falls back to the `bootz` command. U-Boot's 'control' devicetree is pas=
sed
> +through to the kernel.
> +
> +The compatible string "u-boot,qfw-bootmeth" is used for the driver. The=
 driver
> +is automatically instantiated if there are no bootmeth drivers in the
> +devicetree.

This paragraph should be moved to the overview.

Please, mention the configuration requirements.

Best regards

Heinrich

