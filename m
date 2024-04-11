Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9488ECD128A
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 10:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61D088261;
	Thu, 11 Apr 2024 12:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i0cHpEUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA0B88268; Thu, 11 Apr 2024 12:58:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 423CE8803E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 12:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712833071; x=1713437871; i=xypron.glpk@gmx.de;
 bh=yScjtKFYA+g8J/Wj8/wrLGP4KtvlrgKRJnpXmlVbiXo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=i0cHpEUpEIAt0pe9TNnSTLtg/iD9fwg8zVwuTFGsOvqKNijldP89D9m/Ahn1OIBH
 oY+K7hqvOlD35jnsRokBnWsNajmmn8H8FdtNznH9RXn+jkse3Aa0coWKwlDTtDukX
 PWp/qSUmHl9NPXC7q/ZBzrpof09Z+4mc1H6bCzwT/SyEelkMvXiCj128BuHnIX2wv
 lirrx02/8VirulfEZNAaEGvw61UM1+2/ULxQ7tts4nk7h6oW2sumTN9SX55dvNUDI
 O8k9MBy5TQ+FLQm9k6R47E1fBbZHrDyWoQRIaXUVNnpZ7zxnWq03C8sw35/j2V+qO
 qobLBGlj0f7LzLnWMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Ygz-1rwFpk22TD-0036fM; Thu, 11
 Apr 2024 12:57:51 +0200
Message-ID: <0d07390c-54e7-4e28-a5a3-48a6e72a9880@gmx.de>
Date: Thu, 11 Apr 2024 12:57:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: bootm: add ELF file support
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com, marek.vasut+renesas@mailbox.org,
 mkorpershoek@baylibre.com, ralph.siemsen@linaro.org, sean.anderson@seco.com,
 sjg@chromium.org, souajih@baylibre.com, takahiro.akashi@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de,
 quentin.schulz@theobroma-systems.com
References: <20240411085738.31779-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240411085738.31779-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDDRDjQtV67pawnh9B4Ld74m0pQA9zXzgQgMStXyuV2GQMO/mF8
 +Jb9NTo7Z6e0+DOGol4/z5TlRFboHdJdIcsdOe82PpKFXlgIH4fu/45RCcAzsuss95AnGrI
 4NUwqXu1CAMFOULjllYbU4dEHEPijan4s9XlQrqdvi5xV23t8vGL+VY8tx+6jo77lP8T4XA
 QM8si9t5hpIeniIYqmH6w==
UI-OutboundReport: notjunk:1;M01:P0:0EgnBJ/6ei8=;Ua0Dr0tpmYfTXDPfZproCTt7IFy
 qlcUz9M3WgG25HkwCTkbesRAil2cy/ZZ+UotsHVTCfQz7VcmLslxCPlnBDklYkF7ovJhyyNsk
 KL1PqJjlBgPQUOjUcZEbn+BOJxbtKion4X2HGUkRnEp4bDhTzj8m3ZsmL17ALexCtvzUu1C3P
 YLrQUCwBn086qZHP8nLQ/0NpcX4aaoa415dep6S4q6S/2y8CUVXbZSmXwv7m0U0iYoCcXxLD9
 YfpUEzzx10WGTZkRKBTHp9w0Z5h3s1aZ6aeiDDvg5g/3nGqz/eqy4RtlSCjSrrCxaoTzpa/a/
 G/Sm2UtLk6WaQdrSz3OvC9JnayC8hDbLdH5g6mYlPrbxr4oOhPA9chMqDvsr0QAXaDlWNiFDo
 Q1Fe5lrPRde2sVg8Jbf0T1wznMvQ66If13ijps8syMVkdoJDcsLacT1MvnoTfaratmHtv9XQl
 mE+vcZ6OFsvApGbAJZNxCKfa1X/4nNFU0MMMBw3L+FV6go2XCJbZaK1V/LNjLpNkprhtkXeVV
 Yx6VhsWeFlhpGbHVwvFh6l9ULDgxEbjo+YLIdQrkbfS7WRLfgh6BTNsaXkuPrGCShwChuVD2J
 n1zLeO6kP1Q4q1wN/inarD150zspS3+qyTXSuN1KQwapstMOMzabXxXcwLjCcf6BbK7bB90U+
 6nlGy8iE2v6boXwNP91l6tZ+0jaSblGyAa36Tx6PyU9fnEgGuuhERP4SEtdYLrDd9D+goYtAB
 RRzRivFgNGwXEQdn/1f8YwKAKJYRv5iO6nLgzO4fULb6lvSZ0131AC+wgACqU5SNBcpKugoLk
 GW9AQCdq5k4ZHTiOGws5xSHcFHluhTxfRHNqadg2V/QDw=
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

On 11.04.24 10:57, Maxim Moskalets wrote:
> From: Maxim Moskalets <maximmosk4@gmail.com>
>
> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.
>
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   boot/bootm_os.c  | 23 +++++++++++++++++++++++
>   boot/image-fit.c |  3 ++-
>   boot/image.c     |  3 +++
>   include/image.h  |  1 +
>   4 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index ccde72d22c..f6b46cf57f 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -395,6 +395,26 @@ static int do_bootm_qnxelf(int flag, struct bootm_i=
nfo *bmi)
>   }
>   #endif
>
> +#if defined(CONFIG_CMD_ELF)
> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
> +{
> +	struct bootm_headers *images =3D bmi->images;
> +	char *local_args[2] =3D {NULL};
> +	char str[19] =3D ""; /* "0x" + 16 digits + "\0" */
> +
> +	if (flag !=3D BOOTM_STATE_OS_GO)
> +		return 0;
> +
> +	snprintf(str, ARRAY_SIZE(str), "0x%lx", images->ep); /* write entry-po=
int into string */
> +	local_args[0] =3D bmi->argv[0];
> +	local_args[1] =3D str;	/* and provide it via the arguments */
> +
> +	do_bootelf(NULL, 0, 2, local_args);

Booting should be possible without having a command line interface.
See commit 7c4647b8fb44 (Merge patch series "Complete decoupling of
bootm logic from commands")

The functionality to boot an ELF binary should be carved out into
library function. The interface should not use argv[], argc.

Best regards

Heinrich

> +
> +	return 1;
> +}
> +#endif
> +
>   #ifdef CONFIG_INTEGRITY
>   static int do_bootm_integrity(int flag, struct bootm_info *bmi)
>   {
> @@ -536,6 +556,9 @@ static boot_os_fn *boot_os[] =3D {
>   #ifdef CONFIG_BOOTM_EFI
>   	[IH_OS_EFI] =3D do_bootm_efi,
>   #endif
> +#if defined(CONFIG_CMD_ELF)
> +	[IH_OS_ELF] =3D do_bootm_elf,
> +#endif
>   };
>
>   /* Allow for arch specific config before we boot */
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 89e377563c..0419bef6d2 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2180,7 +2180,8 @@ int fit_image_load(struct bootm_headers *images, u=
long addr,
>   		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>   		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
>   		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
> -		fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
> +		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
> +		fit_image_check_os(fit, noffset, IH_OS_ELF);
>
>   	/*
>   	 * If either of the checks fail, we should report an error, but
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a..5b88d6808c 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -134,6 +134,9 @@ static const table_entry_t uimage_os[] =3D {
>   #endif
>   	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
>   	{	IH_OS_EFI,	"efi",		"EFI Firmware" },
> +#ifdef CONFIG_CMD_ELF
> +	{	IH_OS_ELF,	"elf",		"ELF Image" },
> +#endif
>
>   	{	-1,		"",		"",			},
>   };
> diff --git a/include/image.h b/include/image.h
> index 21de70f0c9..9a40bca22c 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -100,6 +100,7 @@ enum {
>   	IH_OS_TEE,			/* Trusted Execution Environment */
>   	IH_OS_OPENSBI,			/* RISC-V OpenSBI */
>   	IH_OS_EFI,			/* EFI Firmware (e.g. GRUB2) */
> +	IH_OS_ELF,			/* ELF Image (e.g. seL4) */
>
>   	IH_OS_COUNT,
>   };

