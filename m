Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90067C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D1A8214D;
	Tue, 15 Apr 2025 14:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JrxFp8jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C908294C; Tue, 15 Apr 2025 14:50:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F1D8214B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744721373; x=1745326173; i=xypron.glpk@gmx.de;
 bh=QmUW4D1/z5dwBeEtMT7lfQ6cTGv7Sz3eSxJ4OwQPJuk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JrxFp8joHgpVn8fDZ7gTwlWgIsBvVO1+r0K1Z1iJyDXSj5dZP/d/6k7VxhzhPEyG
 LIpXChJYFVcvrO5ZF590ZLS1rHirc/l+TJ4eFqOfxrv5WMUjgxQwRu7ghFrwC6ezW
 Uhwrpw9eGeeeT0owLcL3QQflBsmL+lFBVM/ZjjTCRlPVEpxAqfeXIbmQTCQZ5P3k1
 rVG6aVlVERH9xra/MJB9co8V47SzmKZ0z8X/9YrdeShuBKcorfZ97iCo9KMiOQo7U
 xuZPgDrIhJwbYn+yEKIyxS2o6bRkVdRoGVstqECQz8N8XufN/AhQeyNGQCm9x9oZ+
 0WDfM1XjEVOjDr7RIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1tg7cs299P-00RS75; Tue, 15
 Apr 2025 14:49:33 +0200
Message-ID: <12569b73-03e2-4365-bd98-55b341f7a1d8@gmx.de>
Date: Tue, 15 Apr 2025 14:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] efi_driver: efi_net: Add efi_net_unbind_drv method
 to efi_net driver
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 =trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-11-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-11-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sNmjdlO7tOtsd5go0COrkA26MaY5CJ+5/umS4gqwkaCxFSrT3x5
 w4uJmR3QWki637NAzt3VWqwQ8KNMptUaNjKFc5CUwURPbmXA+WdJt+zzvwBuY+RJ5v/A8sw
 RcsCtPGBsiOTEP1/6wLbiyGCSU+YrS0nAAIAgpnOFcZHZJkrIs3UdX6galmfxubh2pksX/G
 mYxT4JDGrO2DYLK9yAUBQ==
UI-OutboundReport: notjunk:1;M01:P0:BagNgVoxhrM=;/R8554zXD64NPlTFGwcZwS2dnpw
 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
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

On 11.03.25 17:47, Adriano Cordova wrote:
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_driver/efi_net_device.c | 44 +++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>=20
> diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_de=
vice.c
> index 3838cc47158..bc4edde19b0 100644
> --- a/lib/efi_driver/efi_net_device.c
> +++ b/lib/efi_driver/efi_net_device.c
> @@ -9,6 +9,7 @@
>   #include <malloc.h>
>   #include <net.h>
>   #include <dm/device-internal.h>
> +#include <dm/lists.h>
>   #include <dm/root.h>
>   #include <dm/tag.h>
>   #include <dm/uclass-internal.h>
> @@ -172,6 +173,48 @@ static efi_status_t efi_net_bind_drv(
>   	return EFI_SUCCESS;
>   }
>  =20
> +/**
> + * efi_net_unbind_drv() - TODO

TODO is not a valid description.

> + *
> + * @this:	driver binding protocol
> + * @handle:	handle
> + * Return:	status code
> + */
> +static efi_status_t efi_net_unbind_drv(
> +			struct efi_driver_binding_extended_protocol *this,
> +			efi_handle_t handle)
> +{
> +	EFI_PRINT("%s: handle %p\n", __func__, handle);
> +
> +	struct driver *drv;
> +	struct udevice *dev;
> +	int r;
> +
> +	if (!handle || !handle->dev)
> +		return EFI_DEVICE_ERROR;
> +
> +	drv =3D lists_driver_lookup_name("efi_netdev");
> +	if (!drv) {
> +		log_err("Cannot find driver 'efi_netdev'\n");
> +		return EFI_DEVICE_ERROR;
> +	}

Why do we have to check the driver? How could this unbind function be=20
invoked with the wrong driver?

Can we move unbind() up to the uclass?

Best regards

Heinrich

> +
> +	if (drv =3D=3D handle->dev->driver) {
> +		dev =3D handle->dev;
> +		r =3D efi_unlink_dev(handle);
> +		if (r)
> +			return EFI_DEVICE_ERROR;
> +		r =3D device_remove(dev, DM_REMOVE_NORMAL);
> +		if (r)
> +			return EFI_DEVICE_ERROR;
> +		r =3D device_unbind(dev);
> +		if (r)
> +			return EFI_DEVICE_ERROR;
> +	}
> +
> +	return EFI_SUCCESS;
> +}
> +
>   /**
>    * efi_net_init_drv() - initialize network device driver
>    *
> @@ -236,6 +279,7 @@ static const struct efi_driver_ops driver_ops =3D {
>   	.protocol	=3D &efi_net_guid,
>   	.init		=3D efi_net_init_drv,
>   	.bind		=3D efi_net_bind_drv,
> +	.unbind		=3D efi_net_unbind_drv,
>   };
>  =20
>   /* Identify as EFI driver */

