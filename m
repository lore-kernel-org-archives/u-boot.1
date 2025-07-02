Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EB4C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C846F81FEE;
	Wed,  2 Jul 2025 08:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="b8zS//Ro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBE482ADA; Wed,  2 Jul 2025 08:53:48 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 465DB8003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751439225; x=1752044025; i=xypron.glpk@gmx.de;
 bh=OiKWF38HQBhIbmpz2h2crVuJi2t/w1lwq5F1r9Yi9A4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b8zS//RoOxJgdecQ+unWc6X+0ODvebhUs/N6A5Qp+64tiiFlpsDI6YOq3LGVY8eb
 6YBjB37w514bO0p+mLadhvNp+ChGgftXZYM1mcmAdmN2QVewb34cFuGD3vSNVKwWw
 OJrTjyNn0o81zlPQKm+1Nb8ZTl+xM4hrJkvHLxV6WfZb8Eae4R9iYc99lmomrcGM9
 Dq+RJ09n8hVCDzjflvGs7iMGr7O/oHHpWRgiEP38R9r2YZJ5VyfZcQjVLPx0jREPt
 cyqBnSnnn73J0fXjWpSbAllWqOIhLPccliMdZVVjrHp5/1zWnj2NsgjGmnLS+wJGV
 8pt1bPXL5Mw3p254pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1usLuR3yfH-017kKQ; Wed, 02
 Jul 2025 08:53:45 +0200
Message-ID: <b07aca56-9fde-4660-91b2-0a8b4448fe44@gmx.de>
Date: Wed, 2 Jul 2025 08:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] efi_loader: Prevent dereferencing NULL pointer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-1-f3c6e0b0ae43@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250701-efiloader_fix-v1-1-f3c6e0b0ae43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sEcGy1k9/a4trTRQkHBzoXn4oWQRcCAzitk72L5AEztytTtu6b0
 +DhVnBCFdXVnmNw6xRBYZWQqEdN5g1DNp0o37VxsyQaWEYdNrBmWaH1DMQYDFncG7j7FiXF
 ipG0gK/xYmU/g6Y7xBqdgcvhLy2Gajm2FwonrS25ekK2Fh6mn+51tH2vMkagonR5LC0mZb7
 JyW0cj7S/Ycub+X9sCf3Q==
UI-OutboundReport: notjunk:1;M01:P0:vl2aBp53hcM=;hdJB25AOIz4/fJdmnNwWO3a98LZ
 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
 3qC1OUR2ZTSHa7+zCLjw==
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
> Taking the first goto error: in file_open could either result in an
> attempt to dereference fh when NULL or else free fh->path which has
> not been assigned to and so will be unknown. Avoid both of these
> problems by passing path to free instead of fh->path.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   lib/efi_loader/efi_file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 7d81da8f2d8..19b43c4a625 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -248,7 +248,7 @@ static struct efi_file_handle *file_open(struct file=
_system *fs,
>   	return &fh->base;
>  =20
>   error:
> -	free(fh->path);
> +	free(path);

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	free(fh);
>   	return NULL;
>   }
>=20

