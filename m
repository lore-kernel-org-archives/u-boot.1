Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7CCC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB358811A;
	Tue, 11 Jun 2024 11:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HbX+BRZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B06882F6; Tue, 11 Jun 2024 11:12:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88D6880A3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718097121; x=1718701921; i=xypron.glpk@gmx.de;
 bh=tIlFm5ysI+xFDrKhMMy90d3Dv3V7VozYU0aJGgyT6w4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HbX+BRZkrKOZcqBoOy1fTdrlg0gUNBM6Q/rFJy6nP8Y68+y645QwzJvwSVZOGavH
 C6+pBur+O4QE6y53v3x0XhKtm8P8FfzRuxg0oOJEvpG9GdfEM4BelVw0Iw4uys4KP
 o6BUbEJCwA74tzpEsJL7tNh6ahUiu0pyg7y9bm0o/41/Qy30Wiereq/neKCCt9VR4
 8qOutZNdwsz/7sZRG2600NF5a+T8BhQBCrSY/Cbcy487IpwXdJawDjyNkcpMgD4b1
 ztym4Y/rhnMA7S+nc/Csg6617vRaUgI6H77EjVmMFnioo1gdZY18Etlx/7tDDaD2d
 gkXNiWarDbgSAQFn6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1sXOu21WQ7-014Vlj; Tue, 11
 Jun 2024 11:12:01 +0200
Message-ID: <11990152-63d9-4625-be0b-2fc278a8d27c@gmx.de>
Date: Tue, 11 Jun 2024 11:11:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/31] lmb: remove call to efi_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-18-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240607185240.1892031-18-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G9oI0N3a4B62JttJNKSUM4umBECv3/P0+q3Vl4b7eU8qUxHvVDE
 KlBeaga8rO7tgs1Y8BXZ1FigPf8YZ6uBifi0+29z245Bx1Xa4imIfuVqdhDoT0LiSu1dW8V
 mxrKNz/RKw0XA+xP/p87ppdrbbtWEHX8/r/+wGgm3GxX616zlCfOq4t8O1AbEVX7Fg2l6FA
 l2j99vuL9G5oyPhNdeVpA==
UI-OutboundReport: notjunk:1;M01:P0:4D8s54olbLQ=;GkNf7KZMc6yiCcyVrSpPXZLfNws
 nPPWTiI0oIIytuPiFUt5TuSrRealVLIK2IJ+CT1i/feHiffBJj2EMfhEmhJrKOSJj78yFs36B
 g5fL2SlN/RiQ9Pv+PtSDT0cvD/hF4yKdz7fUk8N2/P3RArCjywC3PlwoSrJM2fOxDt+XwQM+2
 ZdKpAlbWpcHNq0koIub22BF7X3OnfyVVt7UvWvU8VjfIdRierSu1XXkilRp1SMRa8ulgvVq3o
 RT09mFvBpnMphM8aQC+FRN91U6aiBETAguVRrcZXKl6suXSAExGKe00w7DRMRPZrM7K0eDdOJ
 n6wyPpxQ/sYQFxHH5vC8uWIbVbEedUNdD5eR6ph/8D7OHwkAqm8wtj94nRLAG0wzemVh/E/FQ
 LsWOzInoGqPDosjzKc2RZLth82RE+odyVmbatbXF/IvGSnPo9yDCgv1ACUSlvOdGNNHmeInOG
 1BaXvVh9bZZ7ahsWgqYKrff5nKQCZsDabPBxSRo+Ewdn3r7Q/Jkho9ddO4w2B+7w5dH9KmGLb
 JkVw1fcOSHiIZt1qCJOL6KdBIFCaeju1ztNDeGGjbKBYdA+0LNCNsWcTKatQC8IediM5l0Bv4
 zhCU1yee+5F+xmTV1AghfLMRPfgCacccmOLjUxyM28P0EnCiJbAPAb1X3Kpe8/e7mZd92Tbyi
 NvdEseAvUAgP4rmxey5tlRGZXJf5DROzagLjgilSyDqQAOhQ07mEL7UtXvbtwVU2DLJxv5sv5
 e4vrki3Vy4LoZzcfH3OpEnC6VjKryPbVvKEVg1Q6HXxWE9RjdjKQ8IulymoJ8TfcZCl9iv41Y
 ywtThjoqRmnDFJ7oQOtQa/j9kPgQxWCmE1jPAAaU2Kywc=
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

On 07.06.24 20:52, Sughosh Ganu wrote:
> The changes in the EFI memory map are now notified to the LMB
> module. There is therefore no need to explicitly get the efi memory
> map and set aside the EFI allocated memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/lmb.c | 35 -----------------------------------
>   1 file changed, 35 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 3059609aea..c9f6ca692e 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -204,38 +204,6 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, =
ulong align)
>   	}
>   }
>
> -/**
> - * efi_lmb_reserve() - add reservations for EFI memory
> - *
> - * Add reservations for all EFI memory areas that are not
> - * EFI_CONVENTIONAL_MEMORY.
> - *
> - * Return:	0 on success, 1 on failure
> - */
> -static __maybe_unused int efi_lmb_reserve(void)
> -{
> -	struct efi_mem_desc *memmap =3D NULL, *map;
> -	efi_uintn_t i, map_size =3D 0;
> -	efi_status_t ret;
> -
> -	ret =3D efi_get_memory_map_alloc(&map_size, &memmap);
> -	if (ret !=3D EFI_SUCCESS)
> -		return 1;
> -
> -	for (i =3D 0, map =3D memmap; i < map_size / sizeof(*map); ++map, ++i)=
 {
> -		if (map->type !=3D EFI_CONVENTIONAL_MEMORY) {
> -			lmb_reserve_flags(map_to_sysmem((void *)(uintptr_t)
> -							map->physical_start),
> -					  map->num_pages * EFI_PAGE_SIZE,
> -					  map->type =3D=3D EFI_RESERVED_MEMORY_TYPE
> -					      ? LMB_NOMAP : LMB_NONE);


Now that you have removed the last usage of LMB_NOMAP, please, remove it
from enum lmb_flags.

Best regards

Heinrich

> -		}
> -	}
> -	efi_free_pool(memmap);
> -
> -	return 0;
> -}
> -
>   /**
>    * lmb_reserve_common() - Reserve memory region occupied by U-Boot ima=
ge
>    * @fdt_blob: pointer to the FDT blob
> @@ -255,9 +223,6 @@ void lmb_reserve_common(void *fdt_blob)
>
>   	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
>   		boot_fdt_add_mem_rsv_regions(fdt_blob);
> -
> -	if (CONFIG_IS_ENABLED(EFI_LOADER))
> -		efi_lmb_reserve();
>   }
>
>   /**

