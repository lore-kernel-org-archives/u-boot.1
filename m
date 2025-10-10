Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A65CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337CC83FB0;
	Fri, 10 Oct 2025 13:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hedw5+eg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E675183FB0; Fri, 10 Oct 2025 13:46:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B924B83F91
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760096759; x=1760701559; i=xypron.glpk@gmx.de;
 bh=zWZp7JcKhUkAWAZQy7aBRsGny7nBu0tKEmPkd0nOU10=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Hedw5+eggpfd9skub5V798SRKFe6arkti9hOq9EvRHQLCr2B0veGUjRMUI6fePkW
 UvXJ6RoOEx3+0FY7+7ZDGd9idW55iKIyrha7ihxpYiCPJfYO6sDQIX72/cqKlSX5U
 1ctuyDg+5aHeYtZMQisaYuBIbUK7qT9BLYp8whYSWDz4X7WgAdkwGwSFgHFbFWh4w
 8/7mwGUCBYped/jAyWuLk4+wjc9tT/yUra0SZuT086+0cHFaMHxgfljy4VTNp0PtH
 CYSUuEJ/JjSzT1/c6gTutiRSu1e/UPkJqA5ezb+/+Kxj5xDtbcvOVE4CjUme1Rw9k
 BMtapIctOQjD5ckAcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1uK1tJ0HVO-00zwsy; Fri, 10
 Oct 2025 13:45:59 +0200
Message-ID: <f5da6554-6e58-4162-95a6-1e8a64b66d05@gmx.de>
Date: Fri, 10 Oct 2025 13:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Use ESRT_FW_TYPE_SYSTEMFIRMWARE instead of
 ESRT_FW_TYPE_UNKNOWN
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251010105933.25581-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251010105933.25581-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B3ThLiAi0MhN/BQnd+hGbp07k3kk1dV3/tz1h1Y71HSEQKN1HKg
 V8LuO7TIWPRHRM3kEecxQ6klI0xxS0ZEu5cTT5/zpchCqSa1wO4QIEqPdlPft6eTGfBLE9+
 l7yIArfopPHc77O3SRkYMQI880Z+kjX8PyCCvLwYeacJYqRW5nJNKvXDBFxhad7qmBUB5py
 43AFOQ+Bc8FNcX0Zo7+Jw==
UI-OutboundReport: notjunk:1;M01:P0:bFXCvWXe2gg=;rzi3qiI+nBfpsWLLULnopotBmcd
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

On 10/10/25 12:59, Ilias Apalodimas wrote:
> We currently set the firmware image type to ESRT_FW_TYPE_UNKNOWN.
>=20
> The spec defines the following:
> ESRT_FW_TYPE_UNKNOWN 0x00000000
> ESRT_FW_TYPE_SYSTEMFIRMWARE 0x00000001
> ESRT_FW_TYPE_DEVICEFIRMWARE 0x00000002
> ESRT_FW_TYPE_UEFIDRIVER 0x00000003
>=20
> Since we don't support updating DEVICEFIRMWARE or UEFIDRIVER types,
> let's switch over to SYSTEMFIRMWARE which seems more appropriate.
>=20
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_esrt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
> index e235c8fe91c6..3cc389eb11cd 100644
> --- a/lib/efi_loader/efi_esrt.c
> +++ b/lib/efi_loader/efi_esrt.c
> @@ -236,7 +236,7 @@ efi_status_t efi_esrt_add_from_fmp(struct efi_firmwa=
re_management_protocol *fmp)
>   	 * TODO: set the field image_type depending on the FW image type
>   	 * defined in a platform basis.
>   	 */
> -	u32 image_type =3D ESRT_FW_TYPE_UNKNOWN;
> +	u32 image_type =3D ESRT_FW_TYPE_SYSTEMFIRMWARE;
>  =20
>   	/* TODO: set the capsule flags as a function of the FW image type. */
>   	u32 flags =3D 0;

