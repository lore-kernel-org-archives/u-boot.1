Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A4DCD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 08:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528658056B;
	Sat, 13 Jun 2026 10:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vf7/Shnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C875F8063E; Sat, 13 Jun 2026 10:22:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA75A80287
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 10:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781338964; x=1781943764; i=xypron.glpk@gmx.de;
 bh=Mn43rCLGKRtpZ7vGYpF5WAfDu0qoMGlO2KFa70Mq3kA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Vf7/ShnmrQ2Z6RWzQJXUwXUz3cYyj1KAH4m8QxR9ti4XKSvdYPM9uWpEH/fMX39r
 dThP+nzCnTNW3QeFNkmnH+LcO+Zn5v/OA3TdnYMlBR4af3Kf1hmquZSaRQYbYtwxU
 31FXg54dYSG6BurAyyyfUEP3+NC3Q43r+XA9BVIP89HggOIGEFiZkg1pZ/hQDaqFH
 x5CzY4Qa1khQw7Vee8QD396rWq1IUMtskxbyYR4eA7j1JEoFaeaccDukpXLmV4nvQ
 5GIebYKg8bYlEbc8sqTSK7MGim0gqe1YzpOpWxuwWgqce8+/c5IlTe/VPKPyTFrRv
 Y4D/cVTeADLg+zjazw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1xCa8M2y2s-00hqll; Sat, 13
 Jun 2026 10:22:44 +0200
Message-ID: <377d6138-c90f-4da2-98a7-7507003ba91f@gmx.de>
Date: Sat, 13 Jun 2026 10:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_selftest: fix guid comparison
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>,
 u-boot@lists.denx.de
References: <20260611092926.578977-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260611092926.578977-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8aMGdAsBU0bKmusSyJU1KnfyaWfKaE2Fj+8dkvMWbiVrDuz7I0Q
 nbxDREJSTIWLl9zf8NwZy1hLRhpghNqsbmpZFcV5evDrGjDIbslnt4OwcDJEsHzhHyv2VJL
 Hr6XGt6v9z9s7osY+JOOmraQM9BlmhbgC/zVxyJDz1sVYabRFBeLLEAQRJU2sAxSiWvfBEp
 zFyuWqqDRPNG4Gv9hAAXA==
UI-OutboundReport: notjunk:1;M01:P0:FRB8QPFkMJw=;KwgoKO2/GSXM6Jby1HiW4bOFSpF
 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
 byyN1QBf9Bz+IbCg/YlytdC85nI=
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

On 6/11/26 11:29, Vincent Stehl=C3=A9 wrote:
> The `loaded image' efi selftest is comparing protocol GUIDs with the wro=
ng
> polarity.
> This can be verified on the sandbox, where two protocols GUIDs are
> retrieved by the test from the image handle in the following order:
>=20
> 1. Loaded Image Device Path Protocol GUID
> 2. Loaded Image Protocol GUID
>=20
> The test matches on the first GUID, while it is in fact looking for the
> second one; fix the comparison polarity.
>=20
> While at it, use guidcmp() instead of memcmp() to spare the size paramet=
er,
> and use the Loaded Image Protocol GUID definition from efi_api.h instead=
 or
> redefining it locally.

Hello Vincent,

Thank you for catching the issue with the incorrect checkout for the=20
Loaded Image Protocol.

We never use U-Boot library functions in efi_selftest to allow=20
converting it into a standalone EFI application.

>=20
> Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Alexander Graf <agraf@suse.de>
> ---
>   lib/efi_selftest/efi_selftest_loaded_image.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_self=
test/efi_selftest_loaded_image.c
> index 5889ab12617..48890a66db7 100644
> --- a/lib/efi_selftest/efi_selftest_loaded_image.c
> +++ b/lib/efi_selftest/efi_selftest_loaded_image.c
> @@ -9,9 +9,7 @@
>  =20
>   #include <efi_selftest.h>
>  =20
> -static efi_guid_t loaded_image_protocol_guid =3D
> -	EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,
> -		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b);
> +static efi_guid_t loaded_image_protocol_guid =3D EFI_LOADED_IMAGE_PROTO=
COL_GUID;

This change is not described in the commit message. With the change we=20
no longer test if efi_api.h has the correct value of the GUID. Why would=
=20
you prefer this?

>   static struct efi_boot_services *boottime;
>   efi_handle_t image_handle;
>  =20
> @@ -60,8 +58,7 @@ static int execute(void)
>   	efi_st_printf("%u protocols installed on image handle\n",
>   		      (unsigned int)protocol_buffer_count);
>   	for (i =3D 0; i < protocol_buffer_count; ++i) {
> -		if (memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
> -			   sizeof(efi_guid_t)))
> +		if (!guidcmp(protocol_buffer[i], &loaded_image_protocol_guid))
>   			found =3D true;

Changing the polarity is correct.

Best regards

Heinrich

>   	}
>   	if (!found) {
