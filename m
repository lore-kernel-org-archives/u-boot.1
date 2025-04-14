Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D20C369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 15:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B248F81F54;
	Mon, 14 Apr 2025 17:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qfvKGTII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F1D82006; Mon, 14 Apr 2025 17:47:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44ACA81F45
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 17:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744645633; x=1745250433; i=xypron.glpk@gmx.de;
 bh=7iHSKHKenSmtRQD/p4lT3CFoliWRrgQ/1SsnsBYRm3c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qfvKGTIIoiA1ZEZoA54I5SnPEvaUxKZ25MWBbUpRE2GbxnvsSvUf0aJ1vqGV3qQU
 10Rjo5bba5xzFYUi22gRT7qLiJPChF2RAZUd4JMda11m8WJYCP5iasVBee3L68tQT
 gdQtQpnsjPRjL4Pg/XY4XpJ8FuLF8E3/CxcnnW3j3Q+aSEOgW8x8rm4vPStj+V7r1
 4fwAD4XxT7FZE7cwHKik0YKfs83Dqcbi6+LYlMWHwgM01QV6k/8TJ2DdYoW/PFJ+Y
 52v5al6udZ5h8Z5l1qe9gKvVnPE9Oz6pTZaNjLvVjv8Zmc5RJ5Au1wYxU5BrkO5MG
 YXOpvcSRjrtnYORm4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUUm-1tElXZ2wvM-00mxxE; Mon, 14
 Apr 2025 17:47:13 +0200
Message-ID: <80461a04-156e-4744-a677-ed36e4ccbb15@gmx.de>
Date: Mon, 14 Apr 2025 17:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] efi_driver: efi_net: UCLASS_ETH driver for EFI net
 devices
To: Adriano Cordova <adrianox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Adriano Cordova <adriano.cordova@canonical.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-9-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-9-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3dJ6TQ0vXQxU6n5/LDzEXJf79BUX2jtWjMzOskwvTQ7QAdTJbTk
 QGCR5X8GcPvakr6Uwrh6gJWFr+LT8QqQyxNzC4NKOfGgXzG64iE/E7TRW0P9EsafEnvVtF0
 B0koTsydZ4dzdv0wzNq0//dCXfPGASf2Zn/GIxVtAczHYxPXwCGevFDNjqObw2HhW9hVPUi
 DrsFVQ802XUDRFuH5e9EQ==
UI-OutboundReport: notjunk:1;M01:P0:fHGCteuLUPs=;a2AShN2L9o1U7Cj6KOaHzSiO3Ch
 L4WP0c9nj8z4wg9eBgxm+kuBSIsfORdnMQTfszaEGN+6AJVGsTbhN4+0hT4PbqWiJuWsZKhwV
 ZY8aHA9OSi1+wTpeFjW7b7op/G1886TFOXsxY7GkvIRsX0SFQ0RSeIa1Gtji8Objc9xppG3/A
 dPX7jSr1zwCNsspwS/d9yuzYJ/IjZCFxafmQOvpaM3aieZrfkTSuHiXndq8EAG7JnNGBJl7O2
 shBc1Lk/k7WhAN2QvVxoHxHb95c2dcycgBTILOmAj1yyuIJ3oRjP/ULqKICb5phC0SibFBsDr
 SAuRuLliFoG7Tuebs1JOIBTw2a9F/MOf64YGoIkjtH2ilcCmsQfyfvvCUA3C6s9FUfCISPP2F
 4iW/yD88We98qBA6jMVZkYRFvb+idaYfI0jvN6urjnSRdCSDfPn9LF/W4GMHzEHOEO0ttpZkX
 ZgL5fF6OomHIP1cyhyWA1zNNA3/btHzVwPGSKLZ/dECWUTdlWBvGNwIM/N7FGNoUagicKro03
 lDIXn+CIi2snOlAheYb6EnCyVfZLz9dZqyegssaD7z36wACWua2KnwNFWPXDsbaVsJTdNpAtk
 Jh2iL6YclTOuJNpj4M/UbbICP5iAwDe/elOB52KmwhIe8+ZqYLvyMlzyA8wwXFxy4bud9F93F
 daUIwusUmNbRogAhUMUEPBXrmZjHZBNXv52Pi7/a8FYi5MX59uHhcI98MKYM2KOYxWcfQ9Bs6
 2Nl24vTnhQG+KMwtGUisNGLbTNUNATO3mSVNKmvf0RMboDMPqnBJEfGxNJ0aQfjIXh32J/2p/
 oDsyFLmekGQ4C/9csYjNOYPieMbijJ/JSigDEc/pLjIrQVI2pngBTkEGvmnGxlvNeQWZ4MdG9
 yo/92/ZjcjSohRKvvKW3RixY5tTNB048SBKjWnA9VjQTyt+zg4yvVBhsDSFLeOMXQvNmSsXK5
 7pb/mLl7ewLABrz+EAGFZ03l7kT6SNbXoUASdOT5m31ZTmL3wa+Mlkyu2ydSpDIYyVnduoQmw
 wCMNIqHopGhTiJWclC5lFtUmEWKmww8g5YuRAJJX50/9Dkp/edjIQnZ5cAn3P1h+4TIUSFm56
 fYScs1iS1EXBUa5oV2cxy2wJsYZCLOQFMFddgH5PCMmIi/ciqJBvaRpWanQFcD7DCjQP/nRnh
 e4aaqMwLeCkbJsO1axqkM69xnVDuujlTN/Rd1LFNLRwtnPLPyk18AEHyPKofD7qhsYzNdnce8
 ZO1G0Hz2m8C8O+CK7iGBrkNJJjnW9uLC37V8+5f6NQVXtWTGMTsIWQelm902jyoVwuWZIUPTO
 Yp/HCTvARSJ8ZBbRL2Ji3Ws2kUSf/zqKAzehlBAHs/U8v3L0j2Gn1y6haV5wmVDbcZH9NXSlS
 6Pscs48XebJY6JCTKBOrSXdxKopRGZ8omi9P459ih39D3ms1gshR+xEhUi0Fhm7L0mWoV8FaV
 4sF1Rkujn4xx93Ni6kH97do5HXYs=
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
> Ethernet driver that uses an underlying efi_simple_network_protocol
> to send packages.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h            |  12 +++
>   lib/efi_driver/efi_net_device.c | 159 ++++++++++++++++++++++++++++++++
>   2 files changed, 171 insertions(+)
>=20
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 38ea0c5c672..35f500fd97d 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -656,6 +656,18 @@ int efi_disk_create_partitions(efi_handle_t parent,=
 struct blk_desc *desc,
>   			       const char *pdevname);
>   /* Called by bootefi to make GOP (graphical) interface available */
>   efi_status_t efi_gop_register(void);
> +
> +/**
> + * struct efi_netdev_plat - attributes of a network device
> + *
> + * @handle:	handle of the controller on which this driver is installed
> + * @snp:		simple network protocol proxied by this driver
> + */
> +struct efi_netdev_plat {
> +	efi_handle_t handle;
> +	struct efi_simple_network *snp;
> +	void *buffer;
> +};
>   /* Called to register an EFI network device */
>   int efi_net_register(void *ctx, struct event *event);
>   /* Called to unregister an EFI network device */
> diff --git a/lib/efi_driver/efi_net_device.c b/lib/efi_driver/efi_net_de=
vice.c
> index 90d695da2b1..3838cc47158 100644
> --- a/lib/efi_driver/efi_net_device.c
> +++ b/lib/efi_driver/efi_net_device.c
> @@ -7,11 +7,146 @@
>   #include <dm.h>
>   #include <efi_driver.h>
>   #include <malloc.h>
> +#include <net.h>
>   #include <dm/device-internal.h>
>   #include <dm/root.h>
>   #include <dm/tag.h>
>   #include <dm/uclass-internal.h>
>  =20
> +#define DEFAULT_EFI_NET_BUFFER_SIZE 1024
> +
> +int efi_net_start(struct udevice *dev)

This function should be static.
The function description is missing.

For debugging it is preferable that function names are unique. That way=20
we can more easily set break points.

> +{
> +	struct efi_netdev_plat *plat;
> +	efi_status_t ret;
> +
> +	plat =3D dev_get_plat(dev);
> +	if (!plat || !plat->snp)
> +		return -1;

We would never arrive here if probing failed.

> +
> +	ret =3D plat->snp->start(plat->snp);
> +	if (ret !=3D EFI_SUCCESS)
> +		return -1;
> +	ret =3D plat->snp->initialize(plat->snp, 0, 0);

Shouldn't efi_net_start() in lib/efi_loader/efi_net.c take care of this?

> +	if (ret !=3D EFI_SUCCESS)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int efi_net_send(struct udevice *dev, void *packet, int length)
> +{

This function should be static.
The function description is missing.

> +	struct efi_netdev_plat *plat;
> +	efi_status_t ret;
> +
> +	plat =3D dev_get_plat(dev);
> +	if (!plat || !plat->snp)
> +		return -1;

We would never arrive here if probing failed.

> +
> +	ret =3D plat->snp->transmit(plat->snp, 0, length, packet, NULL, NULL, =
NULL);
> +	if (ret !=3D EFI_SUCCESS)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int efi_net_recv(struct udevice *dev, int flags, uchar **packetp)
> +{
> +	struct efi_netdev_plat *plat;
> +	efi_status_t ret;
> +	size_t buffer_size;
> +
> +	plat =3D dev_get_plat(dev);
> +	if (!plat || !plat->snp)
> +		return -1;
> +
> +	if (plat->buffer)
> +		free(plat->buffer);
> +
> +	buffer_size =3D DEFAULT_EFI_NET_BUFFER_SIZE;
> +	plat->buffer =3D calloc(1, buffer_size);

You are allocating new memory on every call to efi_net_recv() but not=20
freeing it.

calloc() may return NULL.

> +	ret =3D plat->snp->receive(plat->snp, NULL, &buffer_size, plat->buffer=
,
> +				 NULL, NULL, NULL);

efi_net_recv is time critical. We should avoid allocating it during=20
transfers. Please, try to allocate it when probing the device and free=20
it when removing it.

> +
> +	if (ret =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		free(plat->buffer);
> +		plat->buffer =3D calloc(1, buffer_size);

calloc() may return NULL.

> +		ret =3D plat->snp->receive(plat->snp, NULL, &buffer_size, plat->buffe=
r,
> +					 NULL, NULL, NULL);
> +	}
> +
> +	if (ret !=3D EFI_SUCCESS || ret !=3D EFI_NOT_READY)
> +		return -1;
> +
> +	*packetp =3D plat->buffer;
> +	return buffer_size;
> +}
> +
> +void efi_net_stop(struct udevice *dev)
> +{
> +	struct efi_netdev_plat *plat;
> +
> +	plat =3D dev_get_plat(dev);
> +	if (!plat || !plat->snp)
> +		return;

We would never arrive here if probing failed.

> +
> +	plat->snp->stop(plat->snp);
> +}
> +
> +/**
> + * efi_netdev_create() - create a net udevice for a handle
> + *
> + * @handle:	handle
> + * @interface:	simple network protocol
> + * Return:	status code
> + */
> +static efi_status_t
> +efi_netdev_create(efi_handle_t handle, void *interface)
> +{
> +	struct udevice *dev =3D NULL, *parent =3D dm_root();
> +	efi_status_t ret;
> +	char *name;
> +	struct efi_netdev_plat *plat;
> +	static int devnum;
> +
> +	name =3D calloc(1, 18); /* strlen("efinet#2147483648") + 1 */
> +	if (!name)
> +		return EFI_OUT_OF_RESOURCES;
> +	sprintf(name, "efinet#%d", devnum);
> +	devnum++;
> +
> +	/* Create driver model udevice for the EFI block io device */

"block io"?

> +	if (eth_create_device(parent, "efi_netdev", name, &dev)) {
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		free(name);
> +		goto err;
> +	}
> +
> +	plat =3D dev_get_plat(dev);
> +	plat->handle =3D handle;
> +	plat->snp =3D interface;
> +
> +	if (efi_link_dev(handle, dev)) {
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		goto err;
> +	}
> +
> +	if (device_probe(dev)) {
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto err;
> +	}

CCing Simon due to his interest in the driver model.

Best regards

Heinrich

> +	EFI_PRINT("%s: net udevice '%s' created\n", __func__, dev->name);
> +
> +	return EFI_SUCCESS;
> +
> +err:
> +	efi_unlink_dev(handle);
> +	if (dev)
> +		device_unbind(dev);
> +
> +	return ret;
> +}
> +
>   /**
>    * efi_net_bind_drv() - TODO
>    *
> @@ -26,6 +161,14 @@ static efi_status_t efi_net_bind_drv(
>   {
>   	EFI_PRINT("%s: handle %p, interface %p\n", __func__, handle, interfac=
e);
>  =20
> +	efi_status_t ret;
> +
> +	if (!handle->dev) {
> +		ret =3D efi_netdev_create(handle, interface);
> +		if (ret !=3D EFI_SUCCESS)
> +			return ret;
> +	}
> +
>   	return EFI_SUCCESS;
>   }
>  =20
> @@ -72,6 +215,22 @@ efi_net_init_drv(struct efi_driver_binding_extended_=
protocol *this)
>   	return EFI_SUCCESS;
>   }
>  =20
> +/* Net device driver operators */
> +static const struct eth_ops efi_eth_ops =3D {
> +	.start	=3D efi_net_start,
> +	.send	=3D efi_net_send,
> +	.recv	=3D efi_net_recv,
> +	.stop	=3D efi_net_stop,
> +};
> +
> +/* Identify as net device driver */
> +U_BOOT_DRIVER(efi_netdev) =3D {
> +	.name		=3D "efi_netdev",
> +	.id		=3D UCLASS_ETH,
> +	.ops		=3D &efi_eth_ops,
> +	.plat_auto	=3D sizeof(struct efi_netdev_plat),
> +};
> +
>   /* EFI driver operators */
>   static const struct efi_driver_ops driver_ops =3D {
>   	.protocol	=3D &efi_net_guid,

