Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8202AE674AA
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 07:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCD4088D9A;
	Fri,  1 Nov 2024 08:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q9rma3Rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD9E88E26; Fri,  1 Nov 2024 08:12:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A586388D13
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 08:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730445123; x=1731049923; i=xypron.glpk@gmx.de;
 bh=n74IVT+vdN0WdF2RHnVGQ3G1Ioz1qmRfYQqUCV9Naqk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=q9rma3RbdVlJ1SIGKPVRIzFO9tFS7AJa/EHYwodEzdEiISusjgA87KCBLxE+ePEv
 jnGvAm7893olnDJ3Y2E4kbrqjbOyYXZnbTA7yMww7r2jbdnD2DSApiEAs7uhP9b76
 gNV2+vITkOPI7yq+1zMTDStGsxImdl9fedrLM1BgJv+vk084m//HWk8uEEPGhb1DH
 MNCG8X0uacCPl8gZz9JmxNPWsK5qu92pR0HybPmjF6Ttw0LwQM6fuKqTvUNao5HVL
 hzAXCSnTyhQ4QMufk/RKvg5eRes1mUFedVmTIzVgJDeT4qEEEed/TvyQa9A2N+Di8
 0HujyfyMOjFBmxdzxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1tO1A41nIl-00PCvo; Fri, 01
 Nov 2024 08:12:03 +0100
Message-ID: <5adc20f8-b363-40a5-89c2-047ac7cc2959@gmx.de>
Date: Fri, 1 Nov 2024 08:12:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: apple: Mark device with DM_FLAG_VITAL
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N1xeKoR64793t3Nif17mjk27dyNp9kQhtkB3Ac9RhgO/dgghEut
 bcOvzEXwgsTJ9o/XaB/Ozai88wCCwNs9Pp6KRCmA/x04SeCg+FEOBcoWgWWJc99KG3qc4WV
 40qU8kRV4VAzCkZIPQlJE7VJf4wcDkTz1VQX5y8OXewP1rXZnEVcyKmoA9/nmCZHIoGkIej
 oFGejFk8VjCI19Vp3pQzQ==
UI-OutboundReport: notjunk:1;M01:P0:G4y8DQwMfSI=;NQi7riptzpjicNFII96SvuyXLV2
 M7Qs2Cs3x4knToa0J/f5OfcMzSuqNH4onF7W3US0+yVrzPBsjB3oVISZfkULCWlRota4ekzLw
 3Xi8C6f2d5Zgru5fEdXvokP5Q7dbWCYDmk9gI/OShjDquxPJpeVfttGBbol5QKDcdSnVlXovd
 TumKlrCYV/ARe3yaK7lhJYoKEcUdroIyHRXr6Xj4odzY1TS1XJy8/8Z8iv0aQwKgle2nwKMO9
 gXT9Me/dgB3JZxPJfowVGiyzPxA0kfgH3FphhfkwNRIm5oExpr+tugdx4oY9dOWRtqR5/4bEN
 eGj6PfqKZgkvmFJJoSAUZNPZjFr+ApQDnfZCWN+ibg63HzOrycBmcSG5BeNdBsMFY8mBATqxW
 oinzKGOyYBC/rqxM38MMF/7piZlkOmmSazOcK/Rn3gP2zicOO2umpSeNcxfdhTEeyKiJkRo2B
 H6PYxAN8j6HxAlPb3VgskClKKey7vCCeYqG3a8ja6kOk4B62lCLYswwXANrXtfN8XZUPWVsAI
 XwBZJQRTPtSEDnIApNQY5Oc2U7b8W+jVl9JBjp/5cqXB09xfbOiszDNTAdiS/G3HxqJVrVSAw
 kxFoRLHVIKcnv0Z5Zaek4YP3sNfIb3C8ERoeiLS+v+7kBroU7AUW2M8rcZpswHJxaTgB+dXSK
 sEIQeYNqwyFX2aaN88b5LoNMhKayZMrYBpZkuC18oydL4HWb9EuIU9dYS8kxE9Eefct181fbX
 kljVB72iDrsiXHvNXFlpl0+IgvGOZWqOyimgg2K9EVKLRmbiWr0qeBZiNwR6al7Q3CjDTdxK8
 jY+Pn23Ds1oUQ0iE7lRzgVZg==
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

On 10/31/24 23:48, Janne Grunau wrote:
> Avoids NULL pointer dereferences in apple_dart_unmap when the iommu
> device is removed before its user. U-boot's device model does not track
> dependencies between devices.
> Observed on a M1 Ultra Mac Studio with v2024.10.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Hello Simon,

could you, please, review this patch.

Best regards

Heinrich

> ---
>   drivers/iommu/apple_dart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..9df174f32d721c39079e6573=
6c91e3e27a72ace2 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -312,5 +312,5 @@ U_BOOT_DRIVER(apple_dart) =3D {
>   	.ops =3D &apple_dart_ops,
>   	.probe =3D apple_dart_probe,
>   	.remove =3D apple_dart_remove,
> -	.flags	=3D DM_FLAG_OS_PREPARE
> +	.flags	=3D DM_FLAG_OS_PREPARE | DM_FLAG_VITAL
>   };
>

