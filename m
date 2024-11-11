Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BEDD12D7C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29AC589171;
	Mon, 11 Nov 2024 09:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kb++okVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0DE8921A; Mon, 11 Nov 2024 09:00:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F49789070
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731312021; x=1731916821; i=xypron.glpk@gmx.de;
 bh=fPDdmjOC4/lW0n5Bzv7CunRFs8eXwqh0U2k2bz5uYe4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Kb++okVevOy0IQo+y1B5FSkB9nLQBYbW01bCgTPogChxv9wAeHw/kh/DycFmA8YZ
 O6XC67652muYX0dzTZDKHZfVWbp8IOFXdJxu7hGyfCEDfKJnuJwOS7JlmGllstypt
 xliyerrrP/pvUnrehR+Px2Z+LkRn2S4ooNyJVbjaUEaW0Gpb/BpXjvVAnXTRcrfSX
 VLyG3eaiGBq50hvSMvg1B4VlfTUDuDQVu5c0tqFyUflIrLoHi/14Jv8SQ7ND49fGc
 Q/Gwb7poM0b42VCvfyfvIXN06wPxI4PBpbu/yuR517kna9J7AE6P1YGBfM2YTmn7W
 28SJag72laz+rayZhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2Jt-1tem4y31JB-00iEbv; Mon, 11
 Nov 2024 09:00:21 +0100
Message-ID: <35b2ecd1-5d92-4bbe-886a-82c567f0e20d@gmx.de>
Date: Mon, 11 Nov 2024 09:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] efi_loader: preserve installer images in pmem
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241025111411.165904-4-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFgvk+jn3xF2rki8nWymMCq6kOjpoumOTZucpfRGlVie8qhrJ0T
 x+tkVbPrlt49REBayMbeQW08d8jmjPRiz79+RuT9F12JYmxkEmHoiJSUkWY1vKJK5YOlY3Z
 pMjgFINkNT+mLZt9TPSvJBU1ISpHdUg5xbVEq/k4kipN0CUReh2AYl3YDQRsQu8xGVkk4aY
 tBRNKjMAE5Rcs12IEPe4Q==
UI-OutboundReport: notjunk:1;M01:P0:lbdADfDZzkA=;4ZYCf0ebFWXiZEPV7i4Ho32fsgz
 hbhcipSjApDn3BD2jMDZKBmkl/tvOgPRRBRLbXGSzpah87b+sXf25EyXHXYvs52OQhwcCHa0S
 9u3gs3kujrSkgkGHW8HTC7Ld4d7FNpvk/MGaGeoV8yYXjen/w8/jonFmlE3bPL+Mu94YY0h/t
 nro0/qyEHPd9kXQOLsQXLlY2ievSwoytcZd1EaNZkF+XGsJySc4Msi1NUOgxSKw9s2a649aSs
 g4QkpAkM8A1iNBvSlZ7DN7AoSPpMBwnhfZY0ppRg2D3cxpDlbLK/4ioWVMBVXjuo54aVRLkdD
 ls+zoguDDIXI6v42yxlON2RPknhiwQVNFLTcUz2Xk49ShXp3YErIUO2Ep4qrMJ8SmbBy1BdGG
 aMFQXou9HOetO8W8FoEHTCEWBIkDw2X28Mt2c8K6qO8SBfcS/vcZBQ9fIffAijunzl6AbKUuQ
 f3L5hkCQJ3P8C24WpaDXJerkcOcA7ZmC1f7peilTUmIyVfquXwCdCtf9sk/KJN8KQO18F+7D8
 xF1i3cJLx74qOUm5ea1/Dj3wdfV/N7KuC/3i81kPRx0I9ANg05UZMFUZxZxjHXT6KkZnm3KKa
 Ex69eyUXr4T9j0J9cWTfDey9GTozwk8OHD19TFLKJk+iuHdQihmGmAN7Z/sv8snDvbDhuDgK9
 7LsCp2h8h+7NzkTRxHx6jTKVzzJrvmBxrmeXekygU2Qwe44F/M0HmkkBGGrzw+xupqSok6YjX
 LMVibBmaxzSeuj/bW0k1Ke03wALKUlinaIq5/a3YmJ2p0xZBiz9Hjyukx48FGUZoylssaMBfb
 rUMFk4+hSpaiGHVjT4aCBiBw==
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

On 10/25/24 13:14, Sughosh Ganu wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].
>
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have suppor=
t
> for persistent memory devices.
>
> It's worth noting that for linux to instantiate the /dev/pmemX device,
> the memory described in the pmem node has to be omitted from the EFI
> memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
> enabled. With those enabled the pmem driver ends up calling
> devm_memremap_pages() instead of devm_memremap(). The latter works
> whether the memory is omitted or marked as reserved, but mapping pages
> only works if the memory is omitted.
>
> On top of that, depending on how the kernel is configured, that memory
> area must be page aligned or 2MB aligned. PowerPC is an exception here
> and requires 16MB alignment, but since we don't have EFI support for
> it, limit the alignment to 2MB.
>
> Ensure that the ISO image is 2MB aligned and remove the region
> occupied by the image from the EFI memory map.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a3aa2b8d1b..16f75555f6 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -18,6 +18,8 @@
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
>
>   static const struct efi_boot_services *bs;
>   static const struct efi_runtime_services *rs;
> @@ -358,13 +360,16 @@ static efi_status_t prepare_loaded_image(u16 *labe=
l, ulong addr, ulong size,
>   	}
>
>   	/*
> -	 * TODO: expose the ramdisk to OS.
> -	 * Need to pass the ramdisk information by the architecture-specific
> -	 * methods such as 'pmem' device-tree node.
> +	 * Linux supports 'pmem' which allows OS installers to find, reclaim
> +	 * the mounted images and continue the installation since the contents
> +	 * of the pmem region are treated as local media.
> +	 *
> +	 * The memory regions used for it needs to be carved out of the EFI
> +	 * memory map.
>   	 */
> -	ret =3D efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> +	ret =3D efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
>   	if (ret !=3D EFI_SUCCESS) {
> -		log_err("Memory reservation failed\n");
> +		log_err("Failed to reserve memory\n");
>   		goto err;
>   	}
>
> @@ -486,6 +491,13 @@ static efi_status_t try_load_from_uri_path(struct e=
fi_device_path_uri *uridp,
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto err;
>   	}
> +	/*
> +	 * Depending on the kernel configuration, pmem memory area must be pag=
e
> +	 * aligned or 2MB aligned. PowerPC is an exception here and requires
> +	 * 16MB alignment, but since we don't have EFI support for it, limit
> +	 * the alignment to 2MB.
> +	 */
> +	image_size =3D ALIGN(image_size, SZ_2M);

The code regarding .iso and .img handling seems to be misplaced. Why
should we treat a file loaded from a block device differently to a file
loaded from the network?

Best regards

Heinrich

>
>   	/*
>   	 * If the file extension is ".iso" or ".img", mount it and try to loa=
d

