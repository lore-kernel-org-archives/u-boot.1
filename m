Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0FDC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78EA87D3F;
	Wed,  1 Nov 2023 15:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WIDQvEeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34A587D30; Wed,  1 Nov 2023 15:31:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4085A876B1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 15:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698849081; x=1699453881; i=xypron.glpk@gmx.de;
 bh=VKNm2IX00Er3cdvQ2Z1iEN37Exc25QuqixRqVpXqw2c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=WIDQvEeVLfg+yZV6Tcbvb+/DJTFQ53xAyo8x0ID0tN5uGv5OKxkDMtw9RXHzmoge
 QGf30fJmkr1O6DkSgUeatMJeQqQjuNCO3rtZLbJ+f9l0D/46x1xD1mlFKDsVHQO/q
 CLu9Ftg2hKhB7nsM1erWK9jCbsf92pV9cotg/sQsPKiiPMCKbQunN/4MCwzB39pA5
 qg0wxrFqWoi9CjeKf7EBbzncBESrhn7I03MRZlI8nmXer2xVgZG6yGl15s402+5vf
 /HNw4cD/BcY+MgfgHYsPrzFl3eRthrbWGe6+EPUHsZxa/fxJlyCc9AU2/NSNWcdGx
 qW543CMbCd0ak3Uu7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1r3RZm0nHr-006NN9; Wed, 01
 Nov 2023 15:31:21 +0100
Message-ID: <4e28a388-f5b1-4cf7-b0e3-b12a876d0567@gmx.de>
Date: Wed, 1 Nov 2023 16:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rng: add dm_rng_read_default() helper
Content-Language: en-US, de-DE
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
 trini@konsulko.com
References: <20231101134907.8405-1-avromanov@salutedevices.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231101134907.8405-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCll+idffeRe4186Ytd15OR/HMG+XZl1JmRqQvngVBsnzlFtKF5
 9m57SldmpDl4m3/+GKtZ4ep1vqPicdInriW9AMoc2iZsHPWQFPhw363AiORcUDNKVn33STe
 KMnFNfLn0SXQxukCLfviqt03kxqzMPxKBNu3hHXmC6xUnrlEj7LS911cA+Wwzwaek/KHe6l
 JQ8sywxRUYyGjkbyfPP0Q==
UI-OutboundReport: notjunk:1;M01:P0:54wMgjNrb8Q=;fnAfmjpXbxp256dkTORLK6JBVm2
 5MkibWgEDj1/cpVOjjkzx9O4/6FNPHP16WksG2H2rRMSJJ4TiiR+tq/YsadZT5nk5QC3mGkwk
 rdmWeAUGQ3W73jV+l6wsnp/OnbThwd1oWq8Thne6rxe/iTKPYZYjICECJw1LZTRdTAhnSwnkH
 VpMCy1GySueesmicZg5oc6A6vkCQ7O+DPH6Ij7GRlQZXMb2V59sgauT6bGT4fJKhs7d6+2gG6
 ZpmdkbMrRkf2pvrO9DHIEh/+QmJ42E4ddq6NwYptOeG9DY2VU/5uhlYQeKFHdZ68azA2vO6K5
 APULqT0Cz6Osrg8w9hhqEHENtnep/v5VFxIeWM872u0jAIHgC5t/1vtrZxHtyx+Vb9SViWdbW
 M0kNnc+e/4HPi9OubmnbLdG7f+r0WDsKjORo1sc5Mx+O8nXVppZbhUzC7XZvDVuTZjzFg9ftb
 Zqv0iDUcdIptoRCsT886m5DRpwtua1pJuHCE3g2hIBcJYiyYEkFl16whmnc84PHZ+2ztJxsao
 LdQFhmegpp4q8408Q8gaO0Yt5VVZ1lu11mifAHM6oeQ5CpOSGaFyvxkCm4zp4Lwo4l0UeBAm1
 3/f30FXbvdvOjEyvjjnMZPU+mgUpAEI++XbB4ESZ4Wh4XfN+qV5DD2SyTHbBK4rVa12AAQCyY
 +9HKn6DAZDLxEV0Wa5F4BvIlcevRy2LihQv9wqKeK+c9sahEtwKxCq4T6W+o7siNYbOb87tww
 Q8TrvYjREI9x4lPW6Cgj8ls6+bXlSjRdQ2UyBsM68sFYvLtKCXV+Ty9b4dCFqMIbk/wwmgLJe
 ZKmeXJKoZYlEUZ/MUK3tejEL21ZE99PXTaRxJBPWPHtVaag0CgSELkoF+oRDxH2YR60yhrMb1
 tXwLN8nvOIWRipjLEaEiGl7EXCNRIl/SChE5wLEBphRrfpL0k8K10bJwe96dg6DHsdCQgnZvr
 SRVXvfBmFzby/qtl0dnhEvFRVBo=
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

On 11/1/23 15:49, Alexey Romanov wrote:
> Add dm_rng_read_default() function, which obtain a series
> of random bytes. In some cases, such function would be
> useful because it allows the caller to abstract away from
> RNG device.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/rng/rng-uclass.c | 20 ++++++++++++++++++++
>   include/rng.h            | 10 ++++++++++
>   2 files changed, 30 insertions(+)
>
> diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
> index 53108e1b31..3a8fb7d276 100644
> --- a/drivers/rng/rng-uclass.c
> +++ b/drivers/rng/rng-uclass.c
> @@ -19,6 +19,26 @@ int dm_rng_read(struct udevice *dev, void *buffer, si=
ze_t size)
>   	return ops->read(dev, buffer, size);
>   }
>
> +int dm_rng_read_default(void *buffer, size_t size)
> +{
> +	struct udevice *rng;
> +	int ret;
> +
> +	ret =3D uclass_get_device(UCLASS_RNG, 0, &rng);

This function will give you the first RNG device and not the first
successfully probed RNG device.

We already have a weak function platform_get_rng_device() which allows a
board to provide a different device. I think we should move
platform_get_rng_device() to rng-uclass.c and use it here.

platform_get_rng_device should be re-implemented to provide the first
successfully probed RNG device.

> +	if (ret) {
> +		pr_err("Can't get RNG device (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D dm_rng_read(rng, buffer, size);

Here you are using a device which may not have been probed yet.

Best regards

Heinrich

> +	if (ret) {
> +		pr_err("Can't read from RNG device (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   UCLASS_DRIVER(rng) =3D {
>   	.name =3D "rng",
>   	.id =3D UCLASS_RNG,
> diff --git a/include/rng.h b/include/rng.h
> index 37af554363..5537daae88 100644
> --- a/include/rng.h
> +++ b/include/rng.h
> @@ -20,6 +20,16 @@ struct udevice;
>    */
>   int dm_rng_read(struct udevice *dev, void *buffer, size_t size);
>
> +/**
> + * dm_rng_read_default() - same as dm_rng_read(), except that caller
> + * don't need to pass an argument with RNG udevice.
> + * @buffer:	input buffer to put the read random seed into
> + * @size:	number of bytes of random seed read
> + *
> + * Return: 0 if OK, -ve on error
> + */
> +int dm_rng_read_default(void *buffer, size_t size);
> +
>   /**
>    * struct dm_rng_ops - operations for the hwrng uclass
>    *

