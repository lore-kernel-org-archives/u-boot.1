Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EEEC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 549BE88385;
	Tue, 16 Jul 2024 01:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KzoLf5lE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DDF8851E; Tue, 16 Jul 2024 01:02:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB92882B6
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721084524; x=1721689324; i=xypron.glpk@gmx.de;
 bh=zJiTT8UYkSt218LN8vdZON523eB4TkeNqknZz5xorZk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KzoLf5lEehmB7PtH1mzLXEBPgsPPmL1o8OywO4g0dvZ4ef1yafkBROyR8oDjk+PO
 G/KEmnliQ05Hj7Xwep/fQtg9NF95h+9N2ALAEMIRSark4ImPPWY0zaXds2OZRgV3b
 0EBNu/vhGs9RQEkSyJsPr2mRXK7ixBTQ0YqPGvfm8TBjDA7CfVyb+alqIukHLOfwe
 W8qAZcn96cRJvQ11EF6t5uTkzRfaYHXsioHNoWSvRnpljhr77DXe+9kVY0FyABTS7
 MEYdffeq0bhNqTCsWTPALJTHaKXLYwp6jqI9y0YMJhIYEP8X3qlBVhY0na7zAQ1KY
 iRVwXkwxTjd97RT3iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1stNXe2lNe-00Jh9b; Tue, 16
 Jul 2024 01:02:04 +0200
Message-ID: <50172cea-e2f1-4190-8491-04defa171d6c@gmx.de>
Date: Tue, 16 Jul 2024 01:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] doc: Add a description for bootmeth_cros
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nam Cao <namcao@linutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240715101354.97895-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cRMy7Lk5cEK9Yv7bgQlhHvlCm6uxHL11yhS3XSEx1+9RqaBrr6+
 jyVC+QkCosUDEE5ilnEXpG1INiZPRQsqopQ95Lx282TOUEdJOgxRg9SER7MZ6gdA6QmgCys
 JrcCzHTKTQEJ1xTo9ztLdLWdz5PfenElTbXLvMJZzBb8WgGsCtQvHcVTIAyZbppDcVY1ZkT
 O00JXTPCzNWzgdcnDGJMQ==
UI-OutboundReport: notjunk:1;M01:P0:PGUUHB59Hjs=;69LT5uegYR1hvl2ssZw8JlUPr+q
 TmSfUcE9UaEle88QXKnH3DI0eA04XvbGy3k/Sofz0N82KN0CQZb3WeXJa33xSzYEyBVpxQieu
 zluge0t8tdAIzZ372J9A51r06A5TreM1zAAWU+e6tltHnL0tZHq4QyLczBVqWvG95YRADLvwl
 va3NolJYhjvRYmhh/tOEITZymAj8d1017LYvBlrkJyqyC++9/Esyo6K1o8h0TyPB7NlUPkrJ8
 a0uZg9JZ6oiWd2ykNOLsECZXmwcLrV+JoZmgeQZEOpaWCV0X44iZPKruJLwP1uufqxKMykH9q
 +XX/8luuh87zCoRHZcd8t3G7s+g5eiPU/KrC4FiSzqGEh8fS6Ob153cFJmiExh1lumMDoRiWt
 EgQhnQ9fHAiuekm0uis0itmBcjLu67VypGzb8p9CsxqFHm3l9gPT8P6n9J/N9akwHZYiqxQaW
 cED/94I45WTMocMxd22XNQ36p74N19CNWVeyuY9meclN+s6TY9COrgKUjfwBk9BOe6tp2aKn0
 APSeMzA4Wig/hAH8B3wLKb9mFDTiwJ5oLAD8A78GAnq2Az1ymFLY5c+NZxWztvIOO4rxjeW07
 ih6ypus6MuNNkNOenIkyhom7fszlz4IY7SZ5tT3L432uhjazv+ZqcE6BOdr9ySBqzwhRBh78f
 H4FuumzjQJPUZnjpaj7shjHLQvk9LBgY+VYCQ36VvA0NVXN4upcIA9DjbOzdICQ6MCYaqZkFN
 c1Ay9YnhjpbxdoKKC+H3I/Hnuvfv9EoN5JcDNJSb/JYOkTGtvs+Gp2EfJ2+G8mo5ZWmfjnFtH
 lr+/Fi49ZcjA/k+TMXNgdWHw==
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
> Add documentation for the cros bootmeth.

%s/bootmeth/boot method/

throughout the patch.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
>   doc/develop/bootstd/index.rst    |  1 +
>   doc/develop/bootstd/overview.rst |  1 +
>   3 files changed, 35 insertions(+)
>   create mode 100644 doc/develop/bootstd/cros.rst
>
> diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
> new file mode 100644
> index 00000000000..96f148837ac
> --- /dev/null
> +++ b/doc/develop/bootstd/cros.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +ChromiumOS Bootmeth
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ChromiumOS provides a mechanism for booting its Operating System from a=
 block
> +device, described
> +`here <https://www.chromium.org/chromium-os/chromiumos-design-docs/veri=
fied-boot/>`_.
> +
> +U-Boot includes support for reading the associated data structures from=
 the
> +device and identifying a bootable ChromiumOS image. This structure incl=
udes the
> +kernel itself, boot arguments (kernel command line), as well as the x86=
 setup
> +block (for x86 only).
> +
> +When invoked on a bootdev, this bootmeth searches for kernel partitions=
 with

What does 'invoked on a boot device' mean? Do you mean "if ChromimumOS
selects a boot device"?

> +the appropriate GUID (Globally Unique Identifier). When found, the info=
rmation
> +is loaded and a bootflow is created.
> +
> +When the bootflow is booted, the bootmeth reads the kernel and boot arg=
uments.
> +It then boots the kernel using zboot (on x86) or bootm (on ARM). The bo=
ot
> +arguments are adjusted to replace %U with the UUID of the selected kern=
el
> +partition. This results in the correct root disk being used, which is t=
he next
> +partition after the kernel partition.
> +
> +For ARM, a :doc:`/usage/fit/index` is used. The `CONFIG_FIT_BEST_MATCH`=
 option
> +must be enabled for U-Boot to select the correct devicetree to boot wit=
h.
> +
> +Note that a ChromiumOS image typically has two copies of the OS, each w=
ith its

%s/OS/operating system/

> +own kernel and root disk. There is no initial ramdisk (initrd). This me=
ans that
> +this bootmeth typically locates two separate images.
> +
> +The compatible string "u-boot,cros" is used for the driver. The driver =
is
> +automatically instantiated if there are no bootmeth drivers in the devi=
cetree.

The last sentence should be moved to the overview.

Please, mention the relevant configuration option for the boot method
driver.

Best regards

Heinrich


> diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.r=
st
> index f8fce7207ce..69fd3c2d2eb 100644
> --- a/doc/develop/bootstd/index.rst
> +++ b/doc/develop/bootstd/index.rst
> @@ -10,3 +10,4 @@ Standard Boot
>      extlinux
>      pxelinux
>      qfw
> +   cros
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/over=
view.rst
> index bcc2c00c775..f12e93236a7 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -417,6 +417,7 @@ Bootmeth drivers are provided for:
>      - U-Boot scripts from disk, network or SPI flash
>      - EFI boot using bootefi from disk
>      - VBE
> +   - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>      - EFI boot using boot manager
>      - :doc:`QFW <qfw>`: QEMU firmware interface
>

