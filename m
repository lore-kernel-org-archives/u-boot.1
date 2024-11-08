Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E2DD64070
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 17:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D2488E00;
	Fri,  8 Nov 2024 18:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nc76/Doe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3858F890CE; Fri,  8 Nov 2024 18:32:46 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C8088C66
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 18:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731087160; x=1731691960; i=xypron.glpk@gmx.de;
 bh=Sb7j9dzO9UBZ1YjMhtPPFHxI1fL6KljIEJaf4sBVfxY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nc76/DoeLmJJ8j7WFrnycYlx+YxlKLEIGy3gi6Errp6XKi7ouRQXao/GvqiZ5/Hn
 XRX+2CE7vYGzDHyBs01V4hs0uvtzbcDtrhk1XLYoa4or5NymQatU5tpciDgAXMblC
 5d8UYNCgD8/TY5JYqz9D36Wlz9JK2F4js9qZoYtVAzcPbMvfsaQdYCf6pb71uLc7j
 L5ZekALzZIPXpKXgj8eCU31xjQQrFfQWAda4eCdY1kGJAK1b/jsqXJ6Jo/YPOU/Ge
 Spd9ir/dQUOPoHoiH4YqdV9kiZSAMcbWwc+sjKLIuutBS4x7jeiCX5dTTIWVd8vsT
 PpSp6m1rM47IYRxzIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8ygY-1tCEX80zbi-008YRB; Fri, 08
 Nov 2024 18:32:40 +0100
Message-ID: <642b2f5c-063b-4de9-9c0c-f5a0be323c7c@gmx.de>
Date: Fri, 8 Nov 2024 18:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] net: wget: make wget_with_dns return value compatible
 with its lwip version
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241106130411.211160-1-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241106130411.211160-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AJF3H/VhIvFf/TI+6HFb8Y5WNvz0Bd6IDrB4b8NfCeYGyegyuS1
 fbiVkDnaqiDignI6K2R5+m1UMB6BV9vnuKGjeTh2XnjqjCUiLBbVgCwFE4eu5cyzydHYq4U
 T0iv2SteqQ1IU24bDjKqMfq6DxP11RGC4XrA6QOVyf6tVdYXkTRZxDvADikVoGDaXJ2Ni0x
 A57ROWSws7J6BvVZdcDHQ==
UI-OutboundReport: notjunk:1;M01:P0:/4rOJW5fjOw=;Q/rmiTHNbMiNItHID3YwPuD2Zbm
 R0KgaBK5h4+Bf/QhoXCWAlMcoL9nHJ5ScZbb0I7Ga6AkVCHEAZxiT75Z+TcdDYdbzpw6t4xsH
 Ah2/P8Qa/4U8hYoOtpJhbBmhOrAW/qIJc2HGDZLvmEEhwQb794HOXBhIXEPjYD4nxxj8S5ns9
 q82VUJS93ytXJzDxh3GWEP/OZtv9ceh51j+/1n8xeSQj8cqSlxXqcdBe91neg2OeyLTl66Cx3
 XUJ15fy7BmUd6+OBCz8/7ZVSuVDaEetVTzejdGs0knHB2BnTpHNVPITxfRrFTtz1ipYwxkasH
 xYBjvBVZ/BXLsSuu3D98iQlXdeLtQdjhdt7huabVJ/Bu0yR/VOOOxTs+yBwu93V71Z7oYHx4C
 LKtHBidjVMv1TGwph92Um5Gzu6YApBBJtKB8wX7Rc4AF1NGed73hu8Lbp4nGr+UZRj+n2DfG8
 zeff9BuIZ2LeTKwTaNvXSISVtn29fMlElhKYm+ZHseQubJ4x45x6+OuwnrCa1N4pBI3xHZdNR
 3MRUDNOhK7BXB8hsRrJiyLeQB0w8Dtxn/plHvuXJyiSTYZhWwcEi45R+dCbB8zcqKO4a9m32V
 vBFsUv4wbQacngQZM2h8ZyRpFuoQBxa0En+TPE0d5i7HMz7ai0h0ubl5WmTYDtt54+vMuJE3q
 /wKe3OMHrGtURXoLOlhgzrRBCwwvUAW5ZjsBXIdYHJXO0PxZEibjAAMSJj987qj3OkDX3O8CZ
 vDXr9SH1cBuKE2g11z95CCWd3sC82x1ZjoiSlrnqSDTg6AtuioKdNvZNQcwXM6M89HEH52Wop
 DTkB0EDqowLMXAndqL2zlOTBnICAUEHbyDes/46EWS0sSm4FUtObweBcgbfK0OVJoUmiSOLp4
 YtoUMLlrkf1i5/7XiT3pu67Hyy0bPFsqPXY/C1GMT5f3D3b/wvqv2B5Df
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

On 11/6/24 14:04, Adriano Cordova wrote:
> There are two wget_with_dns functions, one in the legacy network
> stack and one in lwip, but the return values are not compatible.
> This commit modifies the legacy version of wget_with_dns so that
> the return values are compatible: 0 on success, otherwise a negative
> error. This way wget_with_dns can be called in a network stack
> agnostic way.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>   net/wget.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/wget.c b/net/wget.c
> index 24be0a4932..6cf721070b 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -576,7 +576,7 @@ int wget_with_dns(ulong dst_addr, char *uri)
>   out:
>   	free(str_copy);
>
> -	return ret;
> +	return ret < 0 ? ret : 0;

include/net-lwip.h descibes wget with dns() as

   Return:  downloaded file size, negative if failed

There is a second definition in net/common.h with

   Return:  downloaded file size, negative if failed

Your change does not match the declaration in the includes.

The function should only be defined in one include, i.e. net_common.h.

Function try_load_from_uri_path() uses

   env_get_hex("filesize", 0)

to retrieve the file size. Isn't it be preferable to use the return
value of wget with dns() instead?

There is ongoing work to load installation images via http and boot from
these. If we return the filesize, the return type should be ssize_t to
avoid a 2 GiB limit on the filesize.

Best regards

Heinrich

>   }
>   #endif
>

