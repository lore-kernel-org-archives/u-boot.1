Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90A0EF586C
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 07:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C80B80FA1;
	Sun, 15 Feb 2026 08:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DaXkP6tg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF09383C32; Sun, 15 Feb 2026 08:30:33 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB9980B98
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 08:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771140631; x=1771745431; i=xypron.glpk@gmx.de;
 bh=OMASGP6GTJ8FyEu0alSzDQmvx9mQ2BH1dNqLyvBX9+Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DaXkP6tgw/+HNbyG0+cwx3tFphRF/TkcWD85K3pFrRMGQl2fCeijVM0so8rW2dWc
 nGu1M1NUrukz3gkb+5tGSS0OtmIjhVXoIKtbCyD2wD6Sl3HJIDTs9nErfwxzOXuTO
 zSz24TsHZZC/n+slNtrkP6r1uRTP1ZTOxDDg0Ni+H67qUrgk04q2Ycq8XJSV+lMjv
 Ij2fYurNpJ6mIeV6xS/4T+nb/FlbdEDhmWZ2b6B5++2dn26cNofFdpGMpa47hdyhp
 BFYlNWQxIz4sjBplnbakRSMeGCHmeCl/5XzyT0Iz93kAmdewdVqr5+Tf25MMr1tME
 mfH9mGv1CVIXgyer1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1vv6QD3Pyx-00AfbZ; Sun, 15
 Feb 2026 08:30:31 +0100
Message-ID: <74858c3f-f944-44c9-9407-9e099a36f453@gmx.de>
Date: Sun, 15 Feb 2026 08:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: fix ecpt size computation
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
 <20260212144015.3898750-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260212144015.3898750-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Bfd5qLnO1zGWJRHbvh9IsjUfmF2lAIQs8f9xiwjk5PwtcOamAI
 INK1KWLXWQkBCC9fDj/XZDpe1gfamXw2sqV684xuYb/hegZARnhOYA9thvn3jkN05Qox6PX
 N7QYTL3tFTh8Fn6Fu7Ky5hEQ2T8SJ9oC1XYlNCBMNedtep+0hGD7R65h8WNHK0DpHUuaxcX
 Hhp7/sbZCj8+Ud+tUaXnA==
UI-OutboundReport: notjunk:1;M01:P0:+BHdvTo+H4A=;W7xnWl4lc1JUXb7vUCrQEs97yom
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

On 2/12/26 15:40, Vincent Stehl=C3=A9 wrote:
> The size of the memory allocated for the EFI Conformance Profiles Table =
is
> computed with `num_entries' always equal to zero, which is incorrect whe=
n
> CONFIG_EFI_EBBR_2_1_CONFORMANCE is enabled.
>=20
> This can be verified by allocating the ECPT memory with malloc() instead=
 of
> efi_allocate_pool(), building u-boot with sandbox_defconfig and
> CONFIG_VALGRIND=3Dy, and by finally running the following command:
>=20
>    valgrind --suppressions=3Dscripts/u-boot.supp \
>      ./u-boot -T -c 'efidebug tables'
>=20
> Fix this by using an array of the supported profiles GUIDs instead, whic=
h
> should also be easier to extend in the future as U-Boot should publish t=
he
> GUIDs for all supported EBBR revisions.
>=20
> Fixes: 6b92c1735205 ("efi: Create ECPT table")
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>0
> Cc: Jose Marinho <jose.marinho@arm.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
>=20
> Changes for v2:
> - Mention in the commit message that U-Boot should publish all supported
>    EBBR GUIDs (suggested by Heinrich)
> - Move the array declaration into the function (suggested by Heinrich)
>=20
>=20
>   lib/efi_loader/efi_conformance.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_confo=
rmance.c
> index 2bae93a94bd..2d31800ccb8 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -13,8 +13,6 @@
>   #include <malloc.h>
>  =20
>   static const efi_guid_t efi_ecpt_guid =3D EFI_CONFORMANCE_PROFILES_TAB=
LE_GUID;
> -static const efi_guid_t efi_ebbr_2_1_guid =3D
> -	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
>  =20
>   /**
>    * efi_ecpt_register() - Install the ECPT system table.
> @@ -23,12 +21,17 @@ static const efi_guid_t efi_ebbr_2_1_guid =3D
>    */
>   efi_status_t efi_ecpt_register(void)
>   {
> -	u16 num_entries =3D 0;
>   	struct efi_conformance_profiles_table *ecpt;
>   	efi_status_t ret;
>   	size_t ecpt_size;
>  =20
> -	ecpt_size =3D num_entries * sizeof(efi_guid_t)
> +	static const efi_guid_t profiles[] =3D {
> +	#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
> +		EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> +	#endif
> +	};
> +
> +	ecpt_size =3D sizeof(profiles)
>   		+ sizeof(struct efi_conformance_profiles_table);
>   	ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA, ecpt_size,
>   				(void **)&ecpt);
> @@ -39,12 +42,9 @@ efi_status_t efi_ecpt_register(void)
>   		return ret;
>   	}
>  =20
> -	if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE))
> -		guidcpy(&ecpt->conformance_profiles[num_entries++],
> -			&efi_ebbr_2_1_guid);
> -
> +	memcpy(ecpt->conformance_profiles, profiles, sizeof(profiles));
>   	ecpt->version =3D EFI_CONFORMANCE_PROFILES_TABLE_VERSION;
> -	ecpt->number_of_profiles =3D num_entries;
> +	ecpt->number_of_profiles =3D ARRAY_SIZE(profiles);
>  =20
>   	/* Install the ECPT in the system configuration table. */
>   	ret =3D efi_install_configuration_table(&efi_ecpt_guid, (void *)ecpt)=
;

