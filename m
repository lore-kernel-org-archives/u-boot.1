Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8817C28B28
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 06:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E9080E94;
	Sat,  8 Mar 2025 07:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pjM76rEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06A68003E; Sat,  8 Mar 2025 07:09:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77928003E
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 07:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741414137; x=1742018937; i=xypron.glpk@gmx.de;
 bh=uEeXE4iiyrkANvZZakpHK3ZweDvo8BlC9UhQlxm753Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pjM76rEmV+nHB9nnBfLFiEEUX0uImTlyxFL8kOxhoLEcVBFcxNpMG2cogJxUuYRX
 qWa1/BY5mhYm+lvdlg6AexHnchprSBPntct5M/fL7rAJ56k140gfvzv58jSRizvSG
 SI9Ym2/zvFWkCfbHODOUk0407tk/UEamHXXJ5S5yBXBkME9r3gi7FYrl4DRcWN4Hf
 ZUU/jumAzZyI0REAWQhHCdhzFxhla567qNPqA+JjqV5BYvqwOIDmKa1cwjYcXRlIO
 BQzBdZUkcAuXjf2O/0lqo1NfX6uEVnC+aDxC3nz00IjGAx7/ZkdXG7Ihc4GpP5fFj
 eZSY05W3gHwXfyk/Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.115]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1t18iI1obb-012jhI; Sat, 08
 Mar 2025 07:08:57 +0100
Message-ID: <a264575d-41e2-4e73-a800-900c5309aea2@gmx.de>
Date: Sat, 8 Mar 2025 07:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/29] boot: arm: riscv: sandbox: Add a format for the
 booti file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Albert Aribaud
 <albert.u.boot@aribaud.net>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Korsgaard <peter@korsgaard.com>, Rick Chen <rick@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-16-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250306002533.2380866-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4jvS/F9mNGvvPMBVzgSa1d6i98YXxJsDVGEcDJtG2BDe8I/qz9
 U44e4hhWV4gKiVzWAeUa1I2+IY9oh+CfzOb1yuqSvmJnav0ROc0ovBmbh5wIF9taCbjxvkK
 UluTpMB/iosLsuHqgJl+rEklOPpNtVbvbt5aA73UcaN8MBzif4kF0HutcHZt/3zcqIo1J1n
 8WnLYir1d00Xjibu1u70A==
UI-OutboundReport: notjunk:1;M01:P0:CYoAvkbw3fc=;kkP/g933DoSWgE5S8LAErjpo/jM
 V6aca4b7R450Q50VggsYqLAYHxwbYNnpSa+Jr+LawwwXc+ptmzcgrOX2CdlVM7Zm8EnKPsGu1
 OE5Tr9uMw6RG0BQiCBcYbGoex62Mxurhge4lyd6+qZN68tN1d+qLDYvfjsRUfqDCV7OP6mTuT
 zWoAOt0c2kdy2KbWf/gzVT7vKNQMclCfMXehlRzIQ4RNX2gSa3Tcq7DQnCYVtxS3oQ07hqU56
 dPABLKyI0tNyrE36ij1hBRcATgxV0udPPX3SUvy0t8R8E4USAhS8Buakce3thRnmqhP78ymFA
 cBcbc79MlkxgPLoyEcOr4zZMH0EIX8Do5bLZCi9bwqFrdcLuUHNGCxYfrGuCIBB8dyOKOxS43
 o46oQAqmX6kJCtViZEJ+pO/7zytjabhlYuSuE+5wEERuawNwkTXRKcza70yK9evPMoQRueoZH
 NJk8By0cjKiy06V9v0ApcWxTqBLG0IPvZkOa41w/r0hViGRNN/9C4g64mtTqC/CcSpsPkhs+Y
 1nZIK2aCbL++gZdRu3qp29I6xgGuNLSbW9uNNudIyefY9QIrY7zWLfiZ2xu0RMrSrAuI+6dKM
 8t6mlySyEMQruje/W3dOCtrqD99e8nKtKzvPzLj80sZbUJvuXS8K7UKKh0smzSEuAMUbLwX5K
 5dnP0NPy9vrUyEnbGlUulBBOAVHmk4iGGO1JyrdZ/1Bl4LtTycSB30AYhIkA8T/ZnE6SWBCzH
 W+VlhxPfb79U3B6DtqaQT3b7Odo7pciGqP3Jcc4M7ptyvgnb+5QfBfL+NUmvECSJYoZcenpxl
 UOnI0hTgscFaYDlTLLP/9b8ZdXCFkHhmhxEkYNgG79oNZDuidhYZNeZf1/20YP6ZHXfj/gxws
 a2A1K+yZxpQIcSFtvcOMWQhEANFeqIKPtuydM66t0Bhy6qrH0vEbK8SJV++M4ZpAnlriYDBwJ
 LEBalqOjjSr4YlAHVgCNQYrv6wctA0ROcSymdICjiy+b3LLKB567bap8cFYkm7agd6CARZNFJ
 FleRiaxjAkOaOf9/WUqoSInagoSyXijP7GAZAQO2/mVIXJcx0dCXIcYuTK7i6LQykgjPCUqkP
 VklFId/p9tu10WKEfiHfwbm53SRSB7lIdFPMBOmcXOEiU8ELk5D2GV6b5g0Q2mJfO0n1mlaDh
 Ff7rztl5nKQOCcW44/06qiJY8iwWQMkjg3wvkISaF0mO8Oqmg0kaguYFRh1Pey/KSPiY+cc6d
 iI2rIjfAjiWjBcR2cnjsyNCbVi1eufbps5QUalBIixvy/5WKLq+V1Wq6/IxZlmZhM7kavKmzj
 Q+Kx7Jy9X6kyFu9mbxk2M7lf6zQtobzis8FEWge4otveeiZbYx52Xclcupy4XEi32dcDacAmC
 2Kg/SJiST9bL2sPdsgMDiLK+pAPKL+yHVMh5e2Yrcxx5eyNFDgLn2f1g4iiLTfi2sI8D4whfL
 KebnzDA==
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

On 3/6/25 01:25, Simon Glass wrote:

There is no such thing as a booti file as booti takes pointers for three
different files: kernel, initrd, dtb. I guess you try to refer to the
Linux Image file format.

Please, rephrase the commit title.

> Arm invented a new format for arm64 and something similar is also used
> with RISC-V. Add this to the list of supported formats and provide a way
> for the format to be detected on both architectures.

In Linux `make help` provides this information:

Architecture-specific targets (arm64):
* Image.gz      - Compressed kernel image (arch/arm64/boot/Image.gz)
   Image         - Uncompressed kernel image (arch/arm64/boot/Image)
   image.fit     - Flat Image Tree (arch/arm64/boot/image.fit)
   install       - Install kernel (compressed if COMPRESSED_INSTALL set)
   zinstall      - Install compressed kernel
                   Install using (your) ~/bin/installkernel or
                   (distribution) /sbin/installkernel or
                   install to $(INSTALL_PATH) and run lilo

Architecture-specific targets (riscv):
   Image         - Uncompressed kernel image (arch/riscv/boot/Image)
   Image.gz      - Compressed kernel image (arch/riscv/boot/Image.gz)
   Image.bz2     - Compressed kernel image (arch/riscv/boot/Image.bz2)
   Image.lz4     - Compressed kernel image (arch/riscv/boot/Image.lz4)
   Image.lzma    - Compressed kernel image (arch/riscv/boot/Image.lzma)
   Image.lzo     - Compressed kernel image (arch/riscv/boot/Image.lzo)
   Image.zst     - Compressed kernel image (arch/riscv/boot/Image.zst)
   Image.xz      - Compressed kernel image (arch/riscv/boot/Image.xz)
   vmlinuz.efi   - Compressed EFI kernel image (arch/riscv/boot/vmlinuz.ef=
i)
                   Default when CONFIG_EFI_ZBOOT=3Dy
   xipImage      - Execute-in-place kernel image (arch/riscv/boot/xipImage=
)
                   Default when CONFIG_XIP_KERNEL=3Dy
   install       - Install kernel using (your) ~/bin/installkernel or
                   (distribution) /sbin/installkernel or install to
                   $(INSTALL_PATH)

How about:

"With the booti command we support the "Image" format of the Linux
kernel in compressed and uncompressed form."

>
> Update the genimg_get_format() function to support this.

%s/this/this file format/

>
> Fix up switch() statements which don't currently mention this format.
> Booti does not support a ramdisk, so this can be ignored.

Booti takes three arguments the second one is for the RAM disk.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to add a format for the booti file
>
>   arch/arm/lib/image.c     | 9 ++++++++-
>   arch/riscv/lib/image.c   | 9 ++++++++-
>   arch/sandbox/lib/bootm.c | 5 +++++
>   boot/image-board.c       | 5 +++++
>   include/image.h          | 9 +++++++++
>   5 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
> index 1f672eee2c8..d78d704cb58 100644
> --- a/arch/arm/lib/image.c
> +++ b/arch/arm/lib/image.c
> @@ -28,6 +28,13 @@ struct Image_header {
>   	uint32_t	res5;
>   };
>
> +bool booti_is_valid(const void *img)
> +{
> +	const struct Image_header *ih =3D img;
> +
> +	return ih->magic =3D=3D le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC);
> +}
> +
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
>   		bool force_reloc)
>   {
> @@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ul=
ong *size,
>
>   	ih =3D (struct Image_header *)map_sysmem(image, 0);
>
> -	if (ih->magic !=3D le32_to_cpu(LINUX_ARM64_IMAGE_MAGIC)) {
> +	if (!booti_is_valid(ih)) {
>   		puts("Bad Linux ARM64 Image magic!\n");
>   		return 1;
>   	}
> diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
> index a82f48e9a50..859326cbac8 100644
> --- a/arch/riscv/lib/image.c
> +++ b/arch/riscv/lib/image.c
> @@ -32,6 +32,13 @@ struct linux_image_h {
>   	uint32_t	res4;		/* reserved */
>   };
>
> +bool booti_is_valid(const void *img)
> +{
> +	const struct linux_image_h *lhdr =3D img;
> +
> +	return lhdr->magic =3D=3D LINUX_RISCV_IMAGE_MAGIC;

The Linux header has more fields that we should check, cf.
arch/riscv/kernel/head.S

#if __riscv_xlen =3D=3D 64
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Image load offset(2MB)=
 from start of RAM */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dword 0x200000
#else
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Image load offset(4MB)=
 from start of RAM */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dword 0x400000
#endif

Please, check that the bitness matches the U-Boot architecture.

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ascii RISCV_IMAGE_MAGIC
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.balign 4
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ascii RISCV_IMAGE_MAGIC2

#define RISCV_IMAGE_MAGIC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"RISCV\=
0\0\0"
#define RISCV_IMAGE_MAGIC2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"RSC\x05"

Consider checking both magic fields.

> +}
> +
>   int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
>   		bool force_reloc)
>   {
> @@ -39,7 +46,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ul=
ong *size,
>
>   	lhdr =3D (struct linux_image_h *)map_sysmem(image, 0);
>
> -	if (lhdr->magic !=3D LINUX_RISCV_IMAGE_MAGIC) {
> +	if (!booti_is_valid(lhdr)) {
>   		puts("Bad Linux RISCV Image magic!\n");

As described above we should check more than the magic.

>   		return -EINVAL;
>   	}
> diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
> index 44ba8b52e13..8ed923750f4 100644
> --- a/arch/sandbox/lib/bootm.c
> +++ b/arch/sandbox/lib/bootm.c
> @@ -89,3 +89,8 @@ int booti_setup(ulong image, ulong *relocated_addr, ul=
ong *size,
>
>   	return 1;
>   }
> +
> +bool booti_is_valid(const void *img)
> +{
> +	return false;
> +}
> diff --git a/boot/image-board.c b/boot/image-board.c
> index addccf87c80..07931c64198 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -250,6 +250,9 @@ enum image_fmt_t genimg_get_format(const void *img_a=
ddr)
>   	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE) &&
>   	    is_android_boot_image_header(img_addr))
>   		return IMAGE_FORMAT_ANDROID;
> +	if (IS_ENABLED(CONFIG_CMD_BOOTI) &&
> +	    booti_is_valid(img_addr))
> +		return IMAGE_FORMAT_BOOTI;
>
>   	return IMAGE_FORMAT_INVALID;
>   }
> @@ -420,6 +423,8 @@ static int select_ramdisk(struct bootm_headers *imag=
es, const char *select, u8 a
>   			done =3D true;
>   		}
>   		break;
> +	case IMAGE_FORMAT_BOOTI:
> +		break;
>   	case IMAGE_FORMAT_INVALID:
>   		break;
>   	}
> diff --git a/include/image.h b/include/image.h
> index dc1a7c307cc..f8f2c887a4b 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -603,6 +603,7 @@ enum image_fmt_t {
>   	IMAGE_FORMAT_LEGACY,		/* legacy image_header based format */
>   	IMAGE_FORMAT_FIT,		/* new, libfdt based format */
>   	IMAGE_FORMAT_ANDROID,		/* Android boot image */
> +	IMAGE_FORMAT_BOOTI,		/* Arm64/RISC-V boot image */

Please, describe the enum in Sphinx style, see
https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enum=
eration-documentation

Please, avoid self-referential naming (booti supports the booti format):

%s/IMAGE_FORMAT_BOOTI/IMAGE_FORMAT_LINUX_IMAGE/

>   };
>
>   /**
> @@ -649,6 +650,14 @@ enum image_fmt_t genimg_get_format(const void *img_=
addr);
>
>   int genimg_has_config(struct bootm_headers *images);
>
> +/**
> + * booti_is_valid() - Check if an image appears to be an Arm64 image

Above you implement the function for RISC-V.

"Check if an image is in a compatible Linux Image format"

> + *
> + * @img: Pointer to image
> + * Return: true if the image has the Arm64 magic

For RISC-V we should be checking more than the magic. See above.

Best regards

Heinrich

> + */
> +bool booti_is_valid(const void *img);
> +
>   /**
>    * boot_get_fpga() - Locate the FPGA image
>    *

