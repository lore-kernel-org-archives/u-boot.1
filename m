Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CFEC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B9E82103;
	Wed,  2 Jul 2025 09:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aOudZW5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E92182B18; Wed,  2 Jul 2025 09:13:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4513E81FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751440387; x=1752045187; i=xypron.glpk@gmx.de;
 bh=BvwWH+7tjZL7mU6GCnx8oakd3WuYbJlKub4M+ODm6tw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=aOudZW5vRE/VUadZ7kYCvD+qigddUeCTEqnYrtKVEvPDVStX2AZFNEcCI7hGy8vG
 S4zuaFdtauNPvlCmb/bxuLNNMYZTmwxF55K6zyQau7knfB8n4aYmS4nfK5KFgocCJ
 jlTU+Q76OINwoqwpK49PB2xuN/bk7vyWbc8EG46cF0OR0euvuTBmwmWKUdy5yRtsN
 lCl2089wav1SHrW27j3cp5+tXBDX1D/3E4HDdiR3JgJ5XpVdEpDziMFndPw9iY5xe
 kPJZ8loRfe1z/2R2NTKR+osPUwYktbT6OaX5q7hI6iZ/O4B7QCZ63BdcP80BtrWy2
 6QDe9Hndws613+x5AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1ur08X1Ykc-00znhp; Wed, 02
 Jul 2025 09:13:07 +0200
Message-ID: <70773eab-e2ca-4d40-8c9b-947a63fffe7d@gmx.de>
Date: Wed, 2 Jul 2025 09:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] efi_loader: Prevent free of uninitialised pointer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Adriano_C=C3=B3rdova?=
 <adrianox@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AaxbAfVGRo7QL4UpRwT6zc5V3NyDy//hWtRKkNNVjU1tmCpOi3w
 u8D8f04eCm7Crc6KUsj285dstiVW8RwHDvTm9TqVY9nOW5VnME/mXMYAYDibTAcfxGadP+l
 pBkQk9Uzjp2c84q4HmB/MyEqE35ya/lMKiLsUWGeU1zXIPbVD7YsD+8dsnxRBcHLN8uI3+R
 xh+fodUu6H3OzZDzHToDQ==
UI-OutboundReport: notjunk:1;M01:P0:73tw4CblI1Q=;ujaKkSq88hMtib8nau1m0NDnT1b
 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
 fTktDHWhKFEkntrZ49vQ==
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
> Taking a goto to out_of_resources before receive_lengths is assigned
> will result in an attempt to free an unitialised pointer. Instead
> initialise receive_lengths to NULL on declaration to prevent this from
> occurring.
>=20
> This issue was found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   lib/efi_loader/efi_net.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 8e708d8d350..3d092523dd5 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -1130,7 +1130,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	struct efi_net_obj *netobj;
>   	void *transmit_buffer =3D NULL;
>   	uchar **receive_buffer =3D NULL;
> -	size_t *receive_lengths;
> +	size_t *receive_lengths =3D NULL;

CCing Adriano as author of the code.
Did scripts/get_maintainer.pl not show him?

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	int i, j;
>  =20
>   	if (!dev) {
>=20

