Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61465C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 21:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFA1874D1;
	Thu,  2 Nov 2023 22:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ibQIyJrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6466A874D2; Thu,  2 Nov 2023 22:43:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350C686FAC
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 22:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698961372; x=1699566172; i=xypron.glpk@gmx.de;
 bh=r+JlrdYU057srRocNO/Dry43S2ZXVCGpvX3XxtlRpP0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ibQIyJrR1QuOnBmY92cC7q0xf7paP6qnajw3klvRLEySio0rsatXL+FM9zs6EYhj
 3tBwZLKr6VfRiepSD+WvYJBTCqGOkC9GAJNqK0bMiWot29Ljdz2pgzbCSNYIOCnBj
 G+z5GtkQ6xp/St2Jdp65ZbuBpoODbHs0iw9YRdiJQztegFmxlkiBf4dG1RPRZfW3B
 FAwXx6edGLDhbFa2MS2KwjAVO98ljOI+nZY3ukFI+H57YXt0JiryVxek8yTJOpGYp
 7u0Gj69fMu253Fj76eXqsPRdUUzPICx5lq60c95IrdNWaIuJU8MM4ndP+sSbCJj+F
 r0zeeB0Q3oZm0sF16Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1r3b8o2QBG-0050AC; Thu, 02
 Nov 2023 22:42:52 +0100
Message-ID: <9ecedef4-9a16-47f8-a7c7-000f72d428c4@gmx.de>
Date: Thu, 2 Nov 2023 23:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rng: move platform_get_rng_device() to rng-uclass.c
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, sughosh.ganu@linaro.org,
 ilias.apalodimas@linaro.org, trini@konsulko.com
References: <20231102091648.40520-1-avromanov@salutedevices.com>
 <20231102091648.40520-2-avromanov@salutedevices.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231102091648.40520-2-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aFj5Xwc8JeyJV8oM9ek7SF9mYaBND6ZBjDVIyFN8ETpqHJQiAzA
 BEezr9sM2+EsnoFhMcyAmCDNQcTOHSTdVOHkRzxfYwlylOLKaOLe1vImCUnGia9Zbc3m9gG
 WN4qk+xwy9uQi+IPcRZ83ums0EraTQvS+5DzIKmTC5SDljQWKDKE7pcOG8yJ2Xeoi1rTRg/
 dNJHTP4eaw+aVN7L3in7g==
UI-OutboundReport: notjunk:1;M01:P0:RYSALyupQsw=;IfknC8uKgiHyE2H7Bi+F1Q7ocNs
 Z9nfC+YQ5rmgJv/BxrR9WhwenvJ2Fbcwhwn7nQAloOZSmYRSFxE/ZcLEKEPBAD6DByU2cn0gi
 x5FcmbJgKlFFTBCBMI3qYo/QRw8kqc9hFY7JtlHMCwwtAIkT9QTrMBnicc+M5YEVYrJmnywy4
 sKUs8Fa+vGABYAnxd1sIaJ8ywbSxoGS87OuYa2IJ9pvWxjg1qB8Rqao78RmnmK0wWGKWrf7m6
 +cdEUOPIkizEFCV1nwutUma6cRrw730QMYLTlt+JzSU0Egf6zmZH3fPq/bvsQXJb/qHCzboTt
 WnokHlndx9dFLetCu8Byin5sJY4DeamBPN4K2Mu68a7B6bnXqbE4b2G+K8lbF5v6pTaQYRuBL
 ViMJoJuzClNjzSzy3iOyVJ4dhm1BjTylTqDRBTLT+YDbhZhCNhPFAMQJ57WB4FlMOyQw2KV5C
 Zz48p3bKTA55LCIASULu5FoDmztEBIofPR1C/W4iit94SaaEotnKhkCA7DGQJ2Tr6qd5LHAhV
 7HDDLLixwUe8wBBTNxjbo1D5+E1yfJkVDjD1FkLztqDeUQ0XZDLV3FJ6da/6WwwY7juf6gI0M
 64c2ByE6ztiQl5nvDB9n0DSu6xjSsr1l5kq89IwqDAeH6wNs6j8hMkcDbhsdpTe7VCXdk1wfc
 JScc0qMcNUXNL5cuF+PaKqtLM4VHzVw/4tHH4sQEY1jlsbK5eEzsNUhDZrmbC6CrjHKSTr/fJ
 dVqo6ZbpCUVbx1gOe10iSTD1J7JOha5X2PpisKBU+6UxBJsClcQDC2+dpRjhpJlt/JLm19sEl
 vLMqYcHa6tcQqbtFvpF+M6tkC24z8LEmwCeOMQcinc7ZtmF0Iso1iVeX25Ynwu5qwmAUNGeAr
 gLnDC9hTPpcjVvaRoIKKPH5k9skEkLh+uEilP98/A3YWGHmnTHRk3nEsHNJKc8VPskuQXoWwt
 RUEZbOeXdhSVndRilflouHLAr0o=
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

On 11/2/23 11:16, Alexey Romanov wrote:
> The correct declaration place for platform_get_rng_device()
> function is here. Also, this function is re-implemented to provide
> the first successfully probed RNG device.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/rng/rng-uclass.c | 16 ++++++++++++++++
>   include/efi_rng.h        |  2 --
>   include/rng.h            | 11 +++++++++++
>   lib/efi_loader/efi_rng.c | 27 ---------------------------
>   4 files changed, 27 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
> index 53108e1b31..d7236b9335 100644
> --- a/drivers/rng/rng-uclass.c
> +++ b/drivers/rng/rng-uclass.c
> @@ -9,6 +9,22 @@
>   #include <dm.h>
>   #include <rng.h>
>
> +int platform_get_rng_device(struct udevice **dev)

You are dropping __weak here. The rationale behind this change should be
provided in the commit message.

Best regards

Heinrich

> +{
> +	int ret;
> +	struct udevice *devp;
> +
> +	ret =3D uclass_first_device_check(UCLASS_RNG, &devp);
> +	if (ret) {
> +		pr_err("Unable to get RNG device (%d)\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	*dev =3D devp;
> +
> +	return 0;
> +}
> +
>   int dm_rng_read(struct udevice *dev, void *buffer, size_t size)
>   {
>   	const struct dm_rng_ops *ops =3D device_get_ops(dev);
> diff --git a/include/efi_rng.h b/include/efi_rng.h
> index 3c622381cb..f22e54adb0 100644
> --- a/include/efi_rng.h
> +++ b/include/efi_rng.h
> @@ -23,6 +23,4 @@ struct efi_rng_protocol {
>   				       efi_uintn_t rng_value_length, uint8_t *rng_value);
>   };
>
> -efi_status_t platform_get_rng_device(struct udevice **dev);
> -
>   #endif /* _EFI_RNG_H_ */
> diff --git a/include/rng.h b/include/rng.h
> index 37af554363..255c85d3e8 100644
> --- a/include/rng.h
> +++ b/include/rng.h
> @@ -20,6 +20,17 @@ struct udevice;
>    */
>   int dm_rng_read(struct udevice *dev, void *buffer, size_t size);
>
> +/**
> + * platform_get_rng_device() - retrieve random number generator
> + *
> + * This function retrieves the first udevice implementing a hardware
> + * random number generator. Device is already probed.
> + *
> + * @dev:	udevice
> + * Return:	status code
> + */
> +int platform_get_rng_device(struct udevice **dev);
> +
>   /**
>    * struct dm_rng_ops - operations for the hwrng uclass
>    *
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index bb11d8d0e0..0d8bf770f5 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -17,33 +17,6 @@ DECLARE_GLOBAL_DATA_PTR;
>
>   const efi_guid_t efi_guid_rng_protocol =3D EFI_RNG_PROTOCOL_GUID;
>
> -/**
> - * platform_get_rng_device() - retrieve random number generator
> - *
> - * This function retrieves the udevice implementing a hardware random
> - * number generator.
> - *
> - * This function may be overridden if special initialization is needed.
> - *
> - * @dev:	udevice
> - * Return:	status code
> - */
> -__weak efi_status_t platform_get_rng_device(struct udevice **dev)
> -{
> -	int ret;
> -	struct udevice *devp;
> -
> -	ret =3D uclass_get_device(UCLASS_RNG, 0, &devp);
> -	if (ret) {
> -		debug("Unable to get rng device\n");
> -		return EFI_DEVICE_ERROR;
> -	}
> -
> -	*dev =3D devp;
> -
> -	return EFI_SUCCESS;
> -}
> -
>   /**
>    * rng_getinfo() - get information about random number generation
>    *

