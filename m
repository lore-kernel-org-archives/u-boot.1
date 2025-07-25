Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A140C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE43D8399D;
	Fri, 25 Jul 2025 15:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="VQAaVXb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62021839A5; Fri, 25 Jul 2025 15:26:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5532983993
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753449990; x=1754054790; i=xypron.glpk@gmx.de;
 bh=XWd6XMFqMdxyfghC3cy0shj+iWOTjaDA+7w8dEP3444=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=VQAaVXb5BrJEq6m+uAzj5k/lXEo0ZiVWvhQmdwEJmsa4pIeneuk1VSClK/QLrbW5
 sU42lT0em4G4AuXbj3ViFGQs031nvL9JupXiNbJv67mQGTkM5TIq9GXRhLj/IofyF
 3Y1wODKc2tCwMKvx9zbIUNbmI+/9/qP2RrjMr2mw0hCdR+BY+gEguixOnxAJ1LNmc
 nkFvh62RK2h2yq5LZxJSOxDmh7CGLvCd0pxX7/Mez3TaOf1k26rAj1LswLQ1Kt042
 cPoODDh2pPWsPd4lNwzkfLz7chmy9ey7aCrGp2OFXiFG5+ZYSEdCFQP6qj7RqQvIc
 /IJ8fUmxbEF5xNaLBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.110.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1uzAmD2Wr2-00OjaT; Fri, 25
 Jul 2025 15:26:29 +0200
Message-ID: <d387c730-9d9d-49b6-9775-da5e69023a87@gmx.de>
Date: Fri, 25 Jul 2025 15:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] efi_loader: Remove authentication header in efi
 variable data
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250725123653.513252-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, kettenis@openbsd.org,
 u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250725123653.513252-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHzaxAwBPAHasq+WoWSd6f4Cvcwn47bvsiuPFlwbXdxPIAP4MyX
 7noC/5/1vemMFMyFhTlO3RvoY8lsW79cSTTPW0h+rfhE2tS12AscC9vBkcbHXJjsiTSufIi
 qVAaUPB1ymvXsGa6DIujVDy7HPu82eof3JJKnceMn6+GhB4OZ0xWr07R7usmf3/K8/q7lkX
 eHIAtPliC4BUeRSDBjG6g==
UI-OutboundReport: notjunk:1;M01:P0:s6Nc0tD6tF0=;3wOxOISOtA67YYZN1MbDHCUeQ2A
 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
 xP7ltGUEJ0ctF8C0y7h0gZR+mDzKJrG4ka3
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

On 25.07.25 14:36, Aswin Murugan wrote:
> efi_get_variable_mem() returned auth header along with ESL data for
> authenticated variables like PK, KEK, and DB. This caused issues in
> later stages where the auth header was misinterpreted as ESL data,

Which later stages are you relating to?
How can the error be reproduced?

> leading to parsing failures, the efi_get_variable_mem() is expected
> to return esl data alone.
> Added a check to remove the auth header if the variable has the
> EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute. Now,
> only the ESL data is returned from the function.

Please, have a look at chapter 8.2.1 GetVariable in the UEFI spec.

When the attribute EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS is set,=20
the Data buffer shall be interpreted as follows:
// NOTE: =E2=80=9C||=E2=80=9D indicates concatenation.
// Example: EFI_VARIABLE_AUTHENTICATION_3_TIMESTAMP_TYPE
EFI_VARIABLE_AUTHENTICATION_3 || EFI_TIME ||=20
EFI_VARIABLE_AUTHENTICATION_3_CERT_ID || Data
// Example: EFI_VARIABLE_AUTHENTICATION_3_NONCE_TYPE
EFI_VARIABLE_AUTHENTICATION_3 || EFI_VARIABLE_AUTHENTICATION_3_NONCE ||=20
EFI_VARIABLE_AUTHENTICATION_3_CERT_ID || Data

Isn't removing the authentication header violating the EFI specification?

Is tests/test_efi_secboot/test_authvar.py still passing with your patch?

>=20
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   lib/efi_loader/efi_var_mem.c | 42 +++++++++++++++++++++++++++++-------
>   1 file changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index 31180df9e3a..f73daf8bdc9 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -309,9 +309,12 @@ efi_get_variable_mem(const u16 *variable_name, cons=
t efi_guid_t *vendor,
>   		     u32 *attributes, efi_uintn_t *data_size, void *data,
>   		     u64 *timep, u32 mask)
>   {
> -	efi_uintn_t old_size;
> +	efi_uintn_t old_size, var_data_size, auth_size;
>   	struct efi_var_entry *var;
>   	u16 *pdata;
> +	void *var_data;
> +	struct efi_time *timestamp;
> +	struct win_certificate_uefi_guid *cert;

Please, move variable definitions to the innermost code block where they=
=20
are used.

Best regards

Heinrich

>  =20
>   	if (!variable_name || !vendor || !data_size)
>   		return EFI_INVALID_PARAMETER;
> @@ -335,19 +338,42 @@ efi_get_variable_mem(const u16 *variable_name, con=
st efi_guid_t *vendor,
>   	if (!u16_strcmp(variable_name, vtf))
>   		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATIL=
E);
>  =20
> +	for (pdata =3D var->name; *pdata; ++pdata)
> +		;
> +	++pdata;
> +
> +	var_data =3D (void *)pdata;
> +	var_data_size =3D var->length;
> +
> +	/* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
> +	if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
> +		if (var_data_size > sizeof(struct efi_time)) {
> +			timestamp =3D (struct efi_time *)var_data;
> +			cert =3D (struct win_certificate_uefi_guid *)(timestamp + 1);
> +			auth_size =3D sizeof(struct efi_time) + cert->hdr.dwLength;
> +			if (var_data_size > auth_size) {
> +				var_data =3D (u8 *)var_data + auth_size;
> +				var_data_size -=3D auth_size;
> +			}
> +		}
> +	}
> +	/*
> +	 * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
> +	 * expected for auth variables
> +	 */
> +	else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
> +		return EFI_INVALID_PARAMETER;
> +
>   	old_size =3D *data_size;
> -	*data_size =3D var->length;
> -	if (old_size < var->length)
> +	*data_size =3D var_data_size;
> +
> +	if (old_size < var_data_size)
>   		return EFI_BUFFER_TOO_SMALL;
>  =20
>   	if (!data)
>   		return EFI_INVALID_PARAMETER;
>  =20
> -	for (pdata =3D var->name; *pdata; ++pdata)
> -		;
> -	++pdata;
> -
> -	efi_memcpy_runtime(data, pdata, var->length);
> +	efi_memcpy_runtime(data, var_data, var_data_size);
>  =20
>   	return EFI_SUCCESS;
>   }

