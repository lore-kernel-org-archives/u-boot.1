Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04868C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4784382103;
	Wed,  2 Jul 2025 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ke6hUgNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEA382ADA; Wed,  2 Jul 2025 12:34:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4126F80E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751452483; x=1752057283; i=xypron.glpk@gmx.de;
 bh=UkyKR7NG107IWkSE/Ka0SuWZObjJ/iR/Oi9/VgZ5Je4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ke6hUgNx3httA0XHUmg+TqqYOJDt9roXLoPGBE97iE9MFk6npC4oMefoIrqaV2Oy
 zFHP86VGU5x1ePpv91ViONv09SLRRGy5sSShMVWR3nkfGGosQTRSzK8xSchlKSYDe
 H2MPcvl6vQEsrOBnxkRV3G04cd31NjjSYaBxdKR8GZX7fz1Pg6sIrjNZM5VmVtqVU
 1UWcXpM9g79cjBKGNqPoJgv62Kiieq4P4ZqvJ2ka09+X0g2O12D75Js5mbBzO4ThM
 kmAcRMSSyiVPVE6nyZzofppMzeweRAnq3zV/p127nZ+9MeafYerLjrXNc/22t6d2p
 F7cMuPCb6HvnNHAMyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1uqMd22a9W-00s5Uv; Wed, 02
 Jul 2025 12:34:42 +0200
Message-ID: <4bbac8af-bd23-4b5d-943c-ba6dc87f516d@gmx.de>
Date: Wed, 2 Jul 2025 12:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] efi_loader: Prevent dereference of uninitialised
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
 <20250701-efiloader_fix-v2-2-eb6db16bbe4e@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701-efiloader_fix-v2-2-eb6db16bbe4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uz2LO2FV99ENnR988Mmgb5BBC/0Fx31sx92VQtr7yJUOe1oyMCH
 gVuO4Onbr283+bW3+RwPgQHNz0ha5Onop2u8NQiXScDnNEQJPE02DRL7+eQhI+EowNiEwlu
 cETFrH5l/dRcRnm3QQJDNORCYhe5jrP8n24fqlS+v7JsjUbDtYnwBPesp20PiAbeD+7tHJe
 VDl8VEW3pLd8U/nPCREcQ==
UI-OutboundReport: notjunk:1;M01:P0:DtPEb7wq4ss=;zB9/xg8BTKseic1FgawXtrmUy3T
 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
 huzQBj8dy2k2/z0esS0Q==
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

On 02.07.25 12:01, Andrew Goodbody wrote:
> If phandler is returned as NULL from efi_search_protocol then
> protocol_interface is never assigned to. Instead return
> EFI_UNSUPPORTED as per the spec.
>=20
> This issue found by Smatch.
>=20
> Also eliminate the use of the variable protocol_interface as it is not
> needed.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Thanks a lot for fixing this.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_http.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 189317fe2d2..9a0f2675132 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -453,7 +453,6 @@ static efi_status_t EFIAPI efi_http_service_binding_=
destroy_child(
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	struct efi_http_instance *http_instance;
>   	struct efi_handler *phandler;
> -	void *protocol_interface;
>  =20
>   	if (num_instances =3D=3D 0)
>   		return EFI_EXIT(EFI_NOT_FOUND);
> @@ -463,18 +462,18 @@ static efi_status_t EFIAPI efi_http_service_bindin=
g_destroy_child(
>  =20
>   	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
>  =20
> -	if (phandler)
> -		protocol_interface =3D phandler->protocol_interface;
> +	if (!phandler)
> +		return EFI_EXIT(EFI_UNSUPPORTED);
>  =20
>   	ret =3D efi_delete_handle(child_handle);
>   	if (ret !=3D EFI_SUCCESS)
>   		return EFI_EXIT(ret);
>  =20
> -	http_instance =3D (struct efi_http_instance *)protocol_interface;
> +	http_instance =3D phandler->protocol_interface;
>   	efi_free_pool(http_instance->http_load_addr);
>   	http_instance->http_load_addr =3D NULL;
>  =20
> -	free(protocol_interface);
> +	free(phandler->protocol_interface);
>  =20
>   	num_instances--;
>  =20
>=20

