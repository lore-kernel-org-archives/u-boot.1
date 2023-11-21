Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32040C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7478749C;
	Tue, 21 Nov 2023 18:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U/vi/Mis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6779E875B1; Tue, 21 Nov 2023 18:27:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762C78749C
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700587634; x=1701192434; i=xypron.glpk@gmx.de;
 bh=fGXFfMquk5ClOPbN2EmmYcwHfn28+xFZZTq3uBJId0Y=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=U/vi/Misd9vWvslxVhYRpXVDCxmkxwb3TltJE7Ef2cAxpo12GmhFNdzzit63Z4du
 ZQQpBAd6W2tTIMKZclyzo9EFp594lB2MjpnJRL6VHtO39I/kgg99++HTZRg0vjgtj
 m4/J7OlRRtMo6Q2Jx8xNmHsinMjmP7OPcspTcCOe30V0Aq/PGhxT6n34bDOQt7sdS
 IgJj/OVeEYQzFLHQM8SW08QW3mCkkAEePFuKJ2EgpHKO0YwHQzYP+DL8whskNiJn/
 P3RYfIOj8Qre83RxinWk+R9TBl8GG+45JvSyO9Oukp+Y36Syd41m+BPBSQZp6Lh/e
 +GViT8p4pC6VMD+trA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1rEoBU1DKU-009RkL; Tue, 21
 Nov 2023 18:27:14 +0100
Message-ID: <db7eeda1-5297-4331-8e5c-ec7e59a742f2@gmx.de>
Date: Tue, 21 Nov 2023 18:27:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] WIP: efi: Disable ANSI output
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-5-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231121113557.800353-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yU2pIOn66DFmbl4iC+b2EpuC4chgzJbGWY/7iltbmwaok11Hshd
 3nk2TVildH4Mn/3W6MVDeK2Q1Hr2D+xQoJrdabgfJ1C2uKdhuLwqooXpT2Pa4wCWMkeQP+X
 asmMV7Em3CYLC93nufWKSzDXT7R20ir7USUKOWNpKtmwZgXxhAgn1B+wLiiu84IfCWE+zOs
 dn8vw5or5+C4NjB4M6Z7A==
UI-OutboundReport: notjunk:1;M01:P0:E+r5E969f9g=;XI9zQyo1xjGZ2vCgnReyxzmjrYq
 Ffpf8kYHUHPhxZkW5sIDqAcnY2hlWKz96cquMgBc80A5fD0DYkO8Vi/IDV9LOrngrqZxwluSg
 XoNaeTvAj3Xu+R+HwXUe3E7Z2xMYDBTfVfKl0e0Fw5pdXcfifxN5FJXU7j5KOawZlJ/xPeYBY
 smpz2PWSgo2eC+TfcgtCepstdn1lS/a6r7ghl/JfykP6JPPTv4QWKGEqBiXr931G1N0fK3cq2
 jJNT90B4Tn/El4yaJMM2UcT0qSnt/tqn2YXpKMIv12olEfH5Mr30rLCJyjsXWsNSeLmkEgXp2
 MzEpdqxu1snZIHoQyBKw5m360CQyJeStpQm6mYGafLQoUhKs4dUZmo7+3Lhwe462Ibl5o+EBO
 ZdR2i/pQ2qv5D1pygxTgV8zv6plgiYxqwx5TOuB0kg3LPhMIsyUrIioFSMngH5aVwz8tZbibL
 6XgVP3VJaGHACitIV11BpQJqz/U9StxiUckkXks/6aqB67EaKgWItz0xB5EsvaKLfIiigbbXK
 BuUoTr9H+foiu3tqwQAbcaY6lIUALAnO5WmRZHU1vfKMu1nI+Hw7hpat2XbEUKPl+eNde60W7
 NGsVLrMcGicu6vIrcGRRmxcngTayYG2el3V1Q61JDjfJ0UdmrQDIAV5T5BypkwoTPVJZ7K9WG
 MtZTCNajwOkN9F/IJ0fDU+ODjkEUDYhdUV3FvFS5v09KX3SML3ypqNHPqYvbAv+tT/YhsveBd
 U6ycX0gh3FYZJ1xKCcRCkXcEVe2n1ORmtSTNufgxPD5WFOKmsdhl+b2C27XopjyaGil3B4ss1
 5A4GtiZQoaXUrFsLK4vO7nIyTEpXuxnxGIcwd+7rbgtL4z0l8LqfWl24PJIJl+jrfIKQJd2NO
 SpELS8SOPjEGyXNooGTHSiUu//2Aqw3xmrg+Pvgw09iLMOisvpwWdOCmuHlVbax4MbU7bXIeH
 69AkgIPWTve/H9XFFIm8L1/jdC4=
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

On 11/21/23 12:35, Simon Glass wrote:
> We don't want ANSI characters written in tests since it is a pain to
> check the output.

I never experienced such pain. The Gitlab output just renders things as
expected.

>
> For now, don't bother checking the console size.
>
> A better solution is need, which allows ANSI output to be controlled
> within EFI.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi_loader.h         | 14 ++++++++++++--
>   lib/efi_loader/efi_console.c | 17 +++++++----------
>   lib/efi_loader/efi_setup.c   |  2 +-
>   3 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 247be060e1c0..ebe951922791 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -527,8 +527,18 @@ efi_status_t efi_bootmgr_update_media_device_boot_o=
ption(void);
>   efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
>   /* search the boot option index in BootOrder */
>   bool efi_search_bootorder(u16 *bootorder, efi_uintn_t num, u32 target,=
 u32 *index);
> -/* Set up console modes */
> -void efi_setup_console_size(void);
> +
> +/**
> + * efi_setup_console_size() - update the mode table.
> + *
> + * @allow_ansi: Allow emitting ANSI characters
> + *
> + * By default the only mode available is 80x25. If the console has at l=
east 50
> + * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> + * 80x25 nor 80x50, set it as an additional mode.
> + */
> +void efi_setup_console_size(bool allow_ansi);
> +
>   /* Install device tree */
>   efi_status_t efi_install_fdt(void *fdt);
>   /* Run loaded UEFI image */
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 28087582e8d6..ea1608f8e6ec 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -349,22 +349,19 @@ static int __maybe_unused query_vidconsole(int *ro=
ws, int *cols)
>   	return 0;
>   }
>
> -/**
> - * efi_setup_console_size() - update the mode table.
> - *
> - * By default the only mode available is 80x25. If the console has at l=
east 50
> - * lines, enable mode 80x50. If we can query the console size and it is=
 neither
> - * 80x25 nor 80x50, set it as an additional mode.
> - */
> -void efi_setup_console_size(void)
> +void efi_setup_console_size(bool allow_ansi)
>   {
>   	int rows =3D 25, cols =3D 80;
>   	int ret =3D -ENODEV;
>
>   	if (IS_ENABLED(CONFIG_VIDEO))
>   		ret =3D query_vidconsole(&rows, &cols);
> -	if (ret)
> -		ret =3D query_console_serial(&rows, &cols);
> +	if (ret) {
> +		if (allow_ansi)
> +			ret =3D query_console_serial(&rows, &cols);
> +		else
> +			ret =3D 0;
> +	}
>   	if (ret)
>   		return;
>
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index e6de685e8795..d4226a3011ac 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -230,7 +230,7 @@ efi_status_t efi_init_obj_list(void)
>   		return efi_obj_list_initialized;
>
>   	/* Set up console modes */
> -	efi_setup_console_size();
> +	efi_setup_console_size(false);

This would render our console non-compliant. Please, keep it as is.

Testing is not the primary task of U-Boot. If you need to filter test
output, please, add a filter method to your test setup.

Best regards

Heinrich

>
>   	/*
>   	 * Probe block devices to find the ESP.

