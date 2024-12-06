Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6A8E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D868914F;
	Fri,  6 Dec 2024 15:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fuEZDNT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBA386DBD; Fri,  6 Dec 2024 15:59:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F099588F92
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733497183; x=1734101983; i=xypron.glpk@gmx.de;
 bh=VMDrCCUTTxNwpWVsoU8V9N5UMtmpkrNhXKb0do94sJk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fuEZDNT4AL+Xv1C6mjGQaZ1rX429vES0Gf+fo64IVgUadSCWof31DWRu4Hxs1FO4
 gqtPtvI1Px+PwrvP7ndJYnQGiEkJEkduyW6DP75VDeh/so9t9fVa5xzGTR6yrEwEw
 8FdcCH7k3oi3TKIXM1/45O9AR8LetUTtjIMXewMZmyaVLesD0Uo19pglAX37pz8Dk
 1rT5kyfNmGni0Ydae+wQPcr2YuaJsKRpz5B+IRYzS0mqWF+9MZD8HqYMRxH/4TCdv
 JxzqNTLTPMuACZOstRtuH4T2aAbwONQMIYEK2uJb1t3ACy9qufABEB7z2wLCNDojn
 tyXevjXF0H4cjM/ULw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1u3PHh19pq-00fqMt; Fri, 06
 Dec 2024 15:59:43 +0100
Message-ID: <2d449f38-9e3b-4b09-82d3-4c9457290564@gmx.de>
Date: Fri, 6 Dec 2024 15:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
References: <20241206122714.2365114-1-adriano.cordova@canonical.com>
 <20241206122714.2365114-3-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206122714.2365114-3-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2QxpkJeRrgp19C0efkPzQofya/MI8Yk7mDqfOAvg1UWpHJ3i+TB
 y8xACIE5djs9dKT+Hs1/mwQ43rmWSROioTg1Up6GeXhyGWnJ8aWU4jnTF1v2RMNduOyBXDz
 4wzcMIkBxr6Nmjw28RXlvFX32MLkN4Ho1yj4MOini+X8pXvACm457hZe30+wTipNppHXi3H
 NySi14MJdfViN1qXWYJgQ==
UI-OutboundReport: notjunk:1;M01:P0:9Jd/BlwrNdw=;1VFUmCjJVOJOKihZLpfZ/aCLkrk
 xsagqQn8I8BIHibOJ12SaAK0aLwE5hC3gIgri2SOSTwhLfxY6lE+dGxCX4GjRGi24OLyqZ+h5
 gXoSox1djOWlZ1JPuutIMP0P5isDaUYNjkRcel7u+TXx3pZh6QFm8Iru3lkVMvuS455YykEuH
 nm9VGLCEK8Y7ocwMd8TLiPXdp+gnP9bCfYhqh9BjXzIbNQSJkdNy99FqUdvQCU92Y0dqlwQVL
 LJbO50gqGYHZYz+6nDaWGrOdiIzIwPK3Sa5z7bFhTAIcmdBKEavayyp85A3i9zYYzkNhADHh8
 1Uol9eEc6jshuRha4vtkHHNKyj6q0hhxXCO4fC/6L1ENXP/fJTqJ9z2JQR4AKt2o7mvl/IOla
 nLBRR0H6warAh9TJAv8AK43FMv+MaUh0gO8QxEvM+YKz1BojiLhmItC/LMHWYZPBeuIS3QVwD
 t5TNCzKspKuinOPj8gIt0h10XfR26TCnEum5bpIbfwZAYl+y33rPFOc1CK4KyfJZoic/6BNG9
 tm34l6geoAr1TQFA5i5yD4Xe/Oz69FaO50HZnytqCgxgDXj3B+f63IjeagJAS7aXgxOgZIjtq
 HWt02xBhryz3TZCRiTwa0F96mxmFdhrzW43/dvMy+98wfQtv+Du4v6dbG1vMXKHmFN/67doUi
 h/nCKb2UUcvSV6mqXO4DkZyoHMjJAQdyXcEsQGL/GNlIhTksD9YOKvd5ei7pc7jDWO+C2Vp0h
 2kyrGU2tgOrl+ZR0v0AMvaX6KXz12Hv8zyJUDtbzfj6KgqIpNXTkU5wIbXfF/sFa3rAps5VAr
 i7ei2J/fZSed7Sf0wWwGDt+a+QKiFFYZ4xzqqPHKU1PSrtyXINz6C7bmKtuFBXPJWOk61lXEp
 Y77iXcW+cSJMXlZctrloLFvBUopWy9ZdgQUUXydbJhTtAXNJM+KHgcy2xYx874PruVRHtLSee
 2gTxNnvKn0qRYErOuZnD4Mqgw02MLiAFPzxfHpSYx6Z0QGcjNrM1kGZJObYRDDw42cHU1OZaL
 dN1cOhtKYf8JokE+Yqv66QpadORUgzbcx6DgzVMkn1JGyQHDs2K3847DmAxMBORLa4S9Mv8G6
 VrMogZjncwucYx0FQ3Xnocwuk7AXzO
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

On 12/6/24 13:27, Adriano Cordova wrote:
> This commit fixes an use after free introduced in Commit e55a4acb54
> (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> from wget"). The logic in efi_net_set_dp is reworked so that when the
> function is invoked it not only changes the value of the static variable
> net_dp (this is how the function was implemented in e55a4acb54) but also
> updates the protocol interface of the device path protocol in case efi
> has started.
>
> Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to=
 HTTP when loaded from wget")
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/efi_net.c | 53 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 67593ef50c..1e87cd7be6 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
>   			     &netobj->net);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> -	if (!net_dp)
> -		efi_net_set_dp("Net", NULL);
> -	r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -			     net_dp);
> +
> +	if (net_dp)
> +		r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +			       net_dp);
> +	else
> +		r =3D efi_net_set_dp("Net", NULL);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> +
>   	r =3D efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_g=
uid,
>   			     &netobj->pxe);
>   	if (r !=3D EFI_SUCCESS)
> @@ -1055,18 +1058,56 @@ out_of_resources:
>    */
>   efi_status_t efi_net_set_dp(const char *dev, const char *server)
>   {
> -	efi_free_pool(net_dp);
> +	efi_status_t ret;
> +	struct efi_handler *phandler;
> +	struct efi_device_path *old_net_dp;
>
> +	old_net_dp =3D net_dp;
>   	net_dp =3D NULL;
>   	if (!strcmp(dev, "Net"))
>   		net_dp =3D efi_dp_from_eth();
>   	else if (!strcmp(dev, "Http"))
>   		net_dp =3D efi_dp_from_http(server);
>
> -	if (!net_dp)
> +	if (!net_dp) {
> +		net_dp =3D old_net_dp;
>   		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	if (!netobj)
> +		return EFI_SUCCESS;
> +
> +	phandler =3D NULL;
> +	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler)=
;
> +
> +	if (!phandler)
> +		goto add;
> +
> +	if (phandler->protocol_interface !=3D old_net_dp) {
> +		ret =3D EFI_DEVICE_ERROR;
> +		goto error;
> +	}

This is not an error condition. Some other code may have changed the
device-path. We must not free what we haven't allocated. But we should
still try to replace it.

So can we have a logic like:

old_dp =3D net_dp;

new_dp =3D ...

OpenProtocol(handle, GUID, &old_dp, NULL, NULL,
EFI_OPEN_PROTOCOL_GET_PROTOCOL);

if (!efi_dp_match(old_dp, new_dp) {
	FreePool(new_dp);
	return EFI_SUCCESS;
}

ret =3D ReinstallProtocolInterface(handle, GUID, old_dp, new_dp);

if (ret =3D=3D EFI_SUCCESS) {
	FreePool(net_dp)
} else {
      FreePool(new_dp);
}

return ret;

Best regards

Heinrich


> +
> +	ret =3D efi_reinstall_protocol_interface(&netobj->header, &efi_guid_de=
vice_path,
> +					       old_net_dp, net_dp);
> +	if (ret !=3D EFI_SUCCESS)

Can net_dp be freed if an error occurred?

> +		return ret;
> +
> +	efi_free_pool(old_net_dp);
>
>   	return EFI_SUCCESS;
> +add:
> +	ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +			       net_dp);
> +	if (ret =3D=3D EFI_SUCCESS) {
> +		efi_free_pool(old_net_dp);
> +		return ret;
> +	}
> +error:
> +	// Failed, restore
> +	efi_free_pool(net_dp);
> +	net_dp =3D old_net_dp;
> +	return ret;
>   }
>
>   /**

