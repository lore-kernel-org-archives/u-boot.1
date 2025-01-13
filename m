Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57ECE7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 07:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2097A80141;
	Mon, 13 Jan 2025 08:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VU+YEwfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCE1801CF; Mon, 13 Jan 2025 08:29:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 696108007D
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 08:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736753391; x=1737358191; i=xypron.glpk@gmx.de;
 bh=6maA+G7u4R9dzI0ENm0uoLF+uknclwTwXnZfNwXCx5Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VU+YEwfEU2GkbnCOa1TLsGBPxxrrj6XEM3CTmzM/3cOfelm8aJIODQrfhWkj2QHw
 0qiuxhFkLut0MvgGp+inN6Zo5Gi8GV2GFP0AxKqqEv6aQ/4HYbMsZSWnVSS8kQ+Me
 UfLM4r6tmorhIyqHPkXAICMqmVFLmGNwe/i8pwbhSzR03frK6SZ7qSehhspRugftW
 eVjMVEkxaR+ASFz1fqEYfDleOXieZLLi3XizvqTJ6pBMbKGYtzCvCJni2pFbhylJW
 IbXNqfPa3bwvrcSyEJuy5FjBQ5krR/0Mt9R/XgMlH95/bbzPA+C14hudYuuLooY9+
 1wt+iID1ieoLKJ0eXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1thBZa3w1U-008Qna; Mon, 13
 Jan 2025 08:29:51 +0100
Message-ID: <be394627-0cbd-4658-a45b-7cbd4d1b4db0@gmx.de>
Date: Mon, 13 Jan 2025 08:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] efi_loader: Call efi_init_early() even earlier
To: Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250112235843.25738-1-semen.protsenko@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250112235843.25738-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cn53vdUbLMAcHTxlqr/83suiJZUEc71IB7JySil6LGSFyCCZ70O
 pIYY3TqtfUcgOo92f8uNed8y5VSRybTcdcWQ3nPsdSEpoVBQTgEuzgWeKunCqmA9IawzgLd
 evJaDSU38QC61VbGpQFTdo9eXd9p8k+kwcY4qOr38z4wjwj+LpIIauvgnJfyUmAdP7h+TUa
 5jc23SpepOvR2REKfcW0g==
UI-OutboundReport: notjunk:1;M01:P0:cs3/n19J99o=;m8BRLGR1t/epBc2wjvqXpEFXmBZ
 Cv8DpaPECxSTASbqZLyxNQTNFtSlWrcHPsRjnM0sod6nvl89+Co7Ardsvcdab1vGXLH5S70nK
 pr4mRviCdPY+SOeiSK8QuIZZnVESfLv5ZeY08jsbRKucWf3thMMHpc/Tr9Iqtb4ZfFtLtOQ0I
 vG2Zs3f9b+YSOiVITE3vPdpM/+Pr+WIHY/yQaO3bOD5579Kwl6CDNONfp4C11GDGAerBNl5PE
 LeTyHVKwbXrb5hUqfSpsF0V0wMpm7VhhnGtDEVGSdDPVwUv+ZmjSzXjaKNmSEUaLKdkqB3vxt
 y2/4/4ENaRVyOh7lUZX5QlTMMj68dXkVFPsO18ArNKHzTvB8FvZ+wAmlv8DfuQjii/FesVvTy
 LkPK5c736I5GqltmH7DSBfN7gkJSUluo7HIvPmGwpWYc9rHuidy7A6uCvmdoZWgmpLmL+zmI9
 kKy/7av+p/u5+gKB5f7QBKus2esaruvDDAfVsjQFoHdSd1G+cn5KaWEsr9rMV+t3f3X8VBbYm
 Wq0ovFffrz32T9D2s7cP2M4IvCkC0UQtGVBqyceIigUTOi0OPOcpMsMtezsfX8KJX1TKhlC0L
 0w5/ypLDhIvpyW0nw9HttwDX8EPZ6WXtijRNOm1t0NBoGZVuiKuOtGtQMPAUOeK1DIyEm+gQ8
 1UREVrzNH5jPIUpTDlxCbMeJ2WD09Co3TglnER2laHkLcgOCBNxBZDPrmRQVsE4U4Zd3OkS25
 NQoDd6DHihSK4rPL2cOKG3lZG+Gr/rFVEP7ertSMb1NyZNf0gaVgVqiTqut05S3EYbh9+bvsk
 f5ezyk0DyL/3oyOtC1RwxBTr/uN5ZZJermsGBxJ7qTN1fk4OZcYosbvp7MtcymYqvVPZY6RR/
 WqPwQ1cc+86o0FEnMhbBw6a8sVLzLT1QVjWGV7SN0HP2YrKiB1iYvrZeQIGtepjRcW8emCnX6
 HVp0Ggg4hAjB3JB0UYjTXp9KpaeYzpabw3fltdhp/dkq+S7PNzkZ2N+lq0JdGrNygC2RMepNc
 3u/lysyyK23COG45aLn5zab0otEOCgTLGw/QobQvOiXjZFQ4Qr74GQiv696ozaqCdqR+DNCcB
 GsaTWSnG5qaDLlGK007Qk0POhc8ire
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

On 1/13/25 00:58, Sam Protsenko wrote:
> At least in case of the E850-96 board all DM devices are probed in
> initr_dm(), before efi_init_early() call. Eventually efi_bl_init()
> registers the EVT_DM_POST_PROBE_EVENT event, but all DM devices
> (including eMMC) are already probed by then, so no events are caught.
> Because of that efi_disk_probe() is never called, so EFI disk objects
> are not created and EFI subsystem can't function correctly, showing the
> next symptoms:
>    - 'efidebug dh' output shows nothing
>    - attempt to add boot devices in 'eficonfig' shows this message:
>      "No block device found!"
>    - 'bootefi selftest $fdtcontroladdr' shows this warning:
>      "Cannot persist EFI variables without system partition"
>    - booting GRUB with 'bootefi' runs minimal GRUB shell which doesn't
>      see any block devices as well, probably because EFI vars weren't
>      passed
>
> Move efi_init_early() call before initr_dm() in init_sequence_r[] so
> that EVT_DM_POST_PROBE_EVENT in efi_bl_init() can actually catch all DM
> probe events and create corresponding EFI objects. That fixes the
> described problem and makes it possible to run EFI apps like GRUB
> correctly, add entries in 'eficonfig', and makes 'efivar --list' command
> in Linux rootfs actually show EFI variables.
>
> This patch doubles down on the approach taken in commit 5e847f7729b3
> ("efi_loader: call efi_init_early() earlier"), taking a different path
> than another fix proposed earlier in "Pull-request efi-2025-01-rc4" [1].
> There was also a related discussion in the "efi_loader: more tightly
> integrate UEFI disks to driver model" patch series [2].

There are two DM functions:

- dm_initr
- dm_initr_dm_devices

Before dm_initr() gd->dm_root points to the pre-relocation tree. So I
guess we should not register the DM events for EFI before that point.

Shouldn't the DM devices only be scanned in initr_dm_devices? Why is
E850-96 doing so in dm_initr?

@Simon
We really need to document the dm_initr* functions. Could you, please,
suggest code comments to be added common/board_r.c.

Please, also describe enum bootstage_id including
BOOTSTAGE_ID_ACCUM_DM_R. I am clueless why the value exists.

Do you have an idea why dm_init_and_scan() would cause probing? Why is
this function called in dm_initr() and not in initr_dm_devices()?

Best regards

Heinrich

>
> [1] https://lore.kernel.org/u-boot/8910d434-2d77-425f-aa81-8eb803078aef@=
gmx.de/
> [2] https://lists.denx.de/pipermail/u-boot/2022-April/481753.html
>
> Fixes: 5e847f7729b3 ("efi_loader: call efi_init_early() earlier")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   common/board_r.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index f63c6aed4d5d..323a56c2018c 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -617,6 +617,11 @@ static init_fnc_t init_sequence_r[] =3D {
>   #endif
>   #ifdef CONFIG_SYS_NONCACHED_MEMORY
>   	noncached_init,
> +#endif
> +	initr_lmb,
> +#ifdef CONFIG_EFI_LOADER
> +	efi_memory_init,
> +	efi_init_early,
>   #endif
>   	initr_of_live,
>   #ifdef CONFIG_DM
> @@ -636,10 +641,6 @@ static init_fnc_t init_sequence_r[] =3D {
>   	 */
>   #ifdef CONFIG_CLOCKS
>   	set_cpu_clk_info, /* Setup clock information */
> -#endif
> -	initr_lmb,
> -#ifdef CONFIG_EFI_LOADER
> -	efi_memory_init,
>   #endif
>   #ifdef CONFIG_BINMAN_FDT
>   	initr_binman,
> @@ -684,9 +685,6 @@ static init_fnc_t init_sequence_r[] =3D {
>   	/* initialize higher level parts of CPU like time base and timers */
>   	cpu_init_r,
>   #endif
> -#ifdef CONFIG_EFI_LOADER
> -	efi_init_early,
> -#endif
>   #ifdef CONFIG_CMD_NAND
>   	initr_nand,
>   #endif

