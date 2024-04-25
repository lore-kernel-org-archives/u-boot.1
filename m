Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5D4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 08:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8A188F06;
	Thu, 25 Apr 2024 10:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V5+2bbYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FAC88F0E; Thu, 25 Apr 2024 10:32:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879FA88125
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 10:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714033968; x=1714638768; i=xypron.glpk@gmx.de;
 bh=klnfV7bA5d7t4xfNH7F6e3J+6M0zTGGG5eb6ybgtUMw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V5+2bbYDCkFHxS9ONemxbC1vw0uMsoEPbqYsprTryCWESaG/8hhzxP3LQHjKyvjU
 QRWRQwwFwgtCXHroFP5YGrMPiv8LGQ8Mc+prEL2vrFG/p7+ukrZUY9QNTogdz88Ep
 HtOBzAHPn3sNPZU48LuIv4R2V4mdGCZMZaHN9EJ2QcZH50JzzBDo8LNlywLM3lvKe
 9aWdQropnulgtwKPDsih9Lmecw2E0OJB3JHKcPJbOdlyq+lDpY4q1czoPIIy5tx8z
 Nk8rfmrMlNYJM8Xlsw3WIch36qRYw7HenCTpThG+203iIx9/n/rEjMZ4THhP4gKbo
 bLm/pPjiBDLejjdpkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1sZnJm34dS-00b1P6; Thu, 25
 Apr 2024 10:32:48 +0200
Message-ID: <334d2ff7-5012-40b9-8542-3d77427b5774@gmx.de>
Date: Thu, 25 Apr 2024 10:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] efi_loader: enable QueryVariableInfo at runtime
 for file backed variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240425051821.338842-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pW+z0CVFDVrqnQAemx2VLMsAe54jzaTXusDPNGIxGO8f8IqkNM5
 SPePbu2ezjvrPL86tnhmRWx7XP/NebAh1gwubyKADsAJ/6A6Cg2PyK4ZcVuHI7fwcqaKhK1
 jCvCcmoD2zb8DJ/pb1nKTjbd5YGIcYhsERp8jzOEXwSrtNs+mzV3TL0KhL9BCFtO6BM8E2n
 l0IM8l64m1zRgorPlzPrg==
UI-OutboundReport: notjunk:1;M01:P0:Bz+Pyg0a278=;4Vl37reV9qx03Qf90dOWvARFnS5
 /145bWTvwz8vObCfsPB+UUQmzv689Od00as19U1QsNK8VEIgZvIkgxWhLPtNGZGswErT5tlN/
 9IkUESwc7NFsLO7RREONziv8Q+KlpdEeVGHPlVCbQDFTtY19Zd+g/6WtymmwAGdwup24HLzD5
 irjphwFQ7Vn64JUE9jf5iMVn1mDo6h32/JBNq4U9iCCY2JIDaPY87Bgn11b7Cz8rsxvqhLOfS
 IrM33z7q5Lh1bZROfWW9vwuuJp/MQcpKcp7gr6IurLNnsOc4cjnwMwo/4jcSF01SKkvZ78WbR
 ItC/iKFcpp01qUwo4Q1ubuxq5HQkb047UfQXxEfwNkK5Op63mXkFIU1sNtHwKdrldeusOcx6K
 pO+Os413GaMDe6DnQI058cDyuqR4Tyi7aZlb4ogLwYzXAGEf4JCKOwcitLaTdo2zvwOoweNly
 s6Pqroa35FhR3IDJr2qjeDTSolVjMkuadc6er2hqdIQfuUU+Hc1AKENwd7Iy6Zh+QRoc+yypQ
 oAHuGFCJqBOE+3cpQFtu3cudz5M/mWja23httUg9U576wo1XnhcEC7A0qCQtcFEKYbTDWD5vJ
 2Vrk7FRO4LTEWl+71eks76v/Hz6pP7hvoykZmaQS1QoUVVVIjzmpx2PSFQRL5LcZp3pFleDks
 V/Ez496RQMl3bySVYsv0irlDTFZN9KIS/nGD3pwYHXi0biYDZsI3bKPXCTIrTL73qH3ZfM258
 UrIbl3cSqPtF7oFa/Q2ubfuCbmJ0V32FrfIdVLbgElFNdY8lNK/xcxvMQ8HtoCb1HqXesO3Yf
 /SoYPDrJkmG4YRNb9jsNqNzN3FMeUkKYUZi9VYSN3tiGo=
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

On 25.04.24 07:18, Ilias Apalodimas wrote:
> Since commit c28d32f946f0 ("efi_loader: conditionally enable Setvariable=
RT")
> we are enabling the last bits of missing runtime services.
> Add support for QueryVariableInfo which we already support at boottime
> and we just need to mark some fucntions available at runtime and move
> some checks around.
>
> It's worth noting that pointer checks for maxmimum and remaining
> variable storage aren't when we store variables on the RPMB, since the
> Secure World backend is already performing them.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - require EFI_VARIABLE_RUNTIME_ACCESS to be set at runtime
> - return EFI_UNSUPPORTED for auth variables
>   lib/efi_loader/efi_runtime.c                  |  4 +++
>   lib/efi_loader/efi_var_common.c               |  6 -----
>   lib/efi_loader/efi_variable.c                 | 25 ++++++++++++++-----
>   lib/efi_loader/efi_variable_tee.c             |  5 ++++
>   .../efi_selftest_variables_runtime.c          | 14 ++++++++---
>   5 files changed, 39 insertions(+), 15 deletions(-)
>
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 73831c527e00..011bcd04836d 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -129,6 +129,10 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>
> +	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE))
> +		rt_table->runtime_services_supported |=3D
> +			EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO;
> +
>   	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>   		u8 s =3D 0;
>
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_co=
mmon.c
> index 961139f005af..ea8d2a4cf98c 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -1,4 +1,3 @@
> -// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * UEFI runtime variable services
>    *
> @@ -163,11 +162,6 @@ efi_status_t EFIAPI efi_query_variable_info(
>   	EFI_ENTRY("%x %p %p %p", attributes, maximum_variable_storage_size,
>   		  remaining_variable_storage_size, maximum_variable_size);
>
> -	if (!maximum_variable_storage_size ||
> -	    !remaining_variable_storage_size ||
> -	    !maximum_variable_size)
> -		return EFI_EXIT(EFI_INVALID_PARAMETER);
> -
>   	ret =3D efi_query_variable_info_int(attributes,
>   					  maximum_variable_storage_size,
>   					  remaining_variable_storage_size,
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index 0cbed53d1dbf..1cc02acb3b26 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -406,12 +406,15 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
>   	return EFI_SUCCESS;
>   }
>
> -efi_status_t efi_query_variable_info_int(u32 attributes,
> -					 u64 *maximum_variable_storage_size,
> -					 u64 *remaining_variable_storage_size,
> -					 u64 *maximum_variable_size)
> +efi_status_t __efi_runtime
> +efi_query_variable_info_int(u32 attributes,
> +			    u64 *maximum_variable_storage_size,
> +			    u64 *remaining_variable_storage_size,
> +			    u64 *maximum_variable_size)
>   {
> -	if (attributes =3D=3D 0)
> +	if (!maximum_variable_storage_size ||
> +	    !remaining_variable_storage_size ||
> +	    !maximum_variable_size || !attributes)
>   		return EFI_INVALID_PARAMETER;
>
>   	/* EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated */
> @@ -460,7 +463,17 @@ static efi_status_t __efi_runtime EFIAPI efi_query_=
variable_info_runtime(
>   			u64 *remaining_variable_storage_size,
>   			u64 *maximum_variable_size)
>   {
> -	return EFI_UNSUPPORTED;

According to the UEFI 2.10 specification EFI_UNSUPPORTED must be returned =
if

"The attribute is not supported on this platform, and the
MaximumVariableStorageSize, RemainingVariableStorageSize,
MaximumVariableSize are undefined."

I wonder if in the spec the 'and' should be replaced by 'or'.

I guess we should return EFI_UNSUPPORTED if
CONFIG_EFI_VARIABLE_RUNTIME_ACCESS=3Dn and change the corresponding test
accordingly. This check should be placed first.

Best regards

Heinrich

> +	if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
> +		return EFI_INVALID_PARAMETER;
> +	if ((attributes & (EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS |
> +			   EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS |
> +			   EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)))
> +		return EFI_UNSUPPORTED;
> +
> +	return efi_query_variable_info_int(attributes,
> +					   maximum_variable_storage_size,
> +					   remaining_variable_storage_size,
> +					   maximum_variable_size);
>   }
>
>   /**
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_vari=
able_tee.c
> index 4f1aa298da13..8b6b0a390869 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -873,6 +873,11 @@ efi_status_t efi_query_variable_info_int(u32 attrib=
utes,
>   	efi_status_t ret;
>   	u8 *comm_buf;
>
> +	if (!max_variable_storage_size ||
> +	    !remain_variable_storage_size ||
> +	    !max_variable_size || !attributes)
> +		return EFI_INVALID_PARAMETER;
> +
>   	payload_size =3D sizeof(*mm_query_info);
>   	comm_buf =3D setup_mm_hdr((void **)&mm_query_info, payload_size,
>   				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index afa91be62c85..5794a7b2d405 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -60,9 +60,17 @@ static int execute(void)
>   	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
>   					   &max_storage, &rem_storage,
>   					   &max_size);
> -	if (ret !=3D EFI_UNSUPPORTED) {
> -		efi_st_error("QueryVariableInfo failed\n");
> -		return EFI_ST_FAILURE;
> +
> +	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> +		if (ret !=3D EFI_SUCCESS) {
> +			efi_st_error("QueryVariableInfo failed\n");
> +			return EFI_ST_FAILURE;
> +		}
> +	} else {
> +		if (ret !=3D EFI_UNSUPPORTED) {
> +			efi_st_error("QueryVariableInfo failed\n");
> +			return EFI_ST_FAILURE;
> +		}
>   	}
>
>   	ret =3D runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> --
> 2.40.1
>

