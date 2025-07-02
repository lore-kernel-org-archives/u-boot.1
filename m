Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A51C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC3581FEE;
	Wed,  2 Jul 2025 09:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AncY6tqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5A482103; Wed,  2 Jul 2025 09:08:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C2581E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751440114; x=1752044914; i=xypron.glpk@gmx.de;
 bh=W9hP8Wqm4jzNDXumKD/fZtZi2XM+49yGfYoRjgSH5S0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AncY6tqRpHs1wCaY0SMgJgD0va3M9TGIoNHhD3eCkEg4FTGclvQd25xYS/6U5HQ2
 q6GzdFhZpUsKBolyZ4ao05gxyZHLJU8wkVGmyQrzKAuOoowYpAD18cEN6uQwJwELR
 gb/Ckk0eFFA2WHpp+D1rqD5/bKyFwIR5sdmGD/pPsgTdaQiI+qBW0DmxfhhBTEmtZ
 koFqOp6oAHVb4lgNNj85Rfd2fJgxlvbR7Ngf/WxEeY84MFKoU5kvIzfGHAPYQ3N44
 vt09TOV61NRbI6P0jvze+obhazMOdA3nVWVHqzba96YzkNK/+FK0dfg1qTn2jG7P3
 uZ30fLTulAo9pg7jqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1ufUQs1XQO-00thsg; Wed, 02
 Jul 2025 09:08:34 +0200
Message-ID: <d56a6320-1007-41da-bb4d-640c8e9b5db8@gmx.de>
Date: Wed, 2 Jul 2025 09:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi_loader: Prevent dereference of uninitialised
 variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-2-f3c6e0b0ae43@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701-efiloader_fix-v1-2-f3c6e0b0ae43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QNRNh8oiQ1SEs9K+/8psWkR2Do8cGniwd9Mp66b1JC6P+H2JNb8
 4z6qO7mvmCafc9UGPgwvl9YoYI5xIXe/m715sv3+WmkfMe4s+jRHHXJz/93eatyCqzeyAvA
 Zb/KJ4H/FMcFMQObyPUwJLUxqrbNWuNYteHEWXtIspIH2jj4vgoCx1Hgm+tw5LtFVU8YVdh
 CF2KwfJBrz3PIpLcUTWNQ==
UI-OutboundReport: notjunk:1;M01:P0:UdwmjB7P4zc=;Ypqq3+wGCQew6i2M8hAx93D5nDy
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

On 01.07.25 15:38, Andrew Goodbody wrote:
> If phandler is returned as NULL from efi_search_protocol then
> protocol_interface is never assigned to. Add a check to prevent
> protocol_interface being dereferenced in this case. Small refactor to
> coalesce the two identical NULL checks of phandler.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   lib/efi_loader/efi_http.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 189317fe2d2..ce3a7a831ca 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -463,18 +463,18 @@ static efi_status_t EFIAPI efi_http_service_bindin=
g_destroy_child(
>  =20
>   	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
>  =20
> -	if (phandler)
> -		protocol_interface =3D phandler->protocol_interface;
> -

If ChildHandle does not support the protocol that is being removed, we=20
must return EFI_UNSUPPORTED and should not continue here.
See 11.6.3 EFI_SERVICE_BINDING_PROTOCOL.DestroyChild() in the UEFI=20
specification.


>   	ret =3D efi_delete_handle(child_handle);
>   	if (ret !=3D EFI_SUCCESS)
>   		return EFI_EXIT(ret);
>  =20
> -	http_instance =3D (struct efi_http_instance *)protocol_interface;
> -	efi_free_pool(http_instance->http_load_addr);
> -	http_instance->http_load_addr =3D NULL;
> +	if (phandler) {
> +		protocol_interface =3D phandler->protocol_interface;

We should eliminate the variable protocol_interface.

> +		http_instance =3D (struct efi_http_instance *)protocol_interface;

This is not C++ code. The conversion from (void *) is superfluous.

CCing  Adriano as author of the code.

Best regards

Heinrich

> +		efi_free_pool(http_instance->http_load_addr);
> +		http_instance->http_load_addr =3D NULL;
>  =20
> -	free(protocol_interface);
> +		free(protocol_interface);
> +	}
>  =20
>   	num_instances--;
>  =20
>=20

