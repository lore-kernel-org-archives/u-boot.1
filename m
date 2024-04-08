Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB60C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 06:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5812E87F13;
	Mon,  8 Apr 2024 08:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QAuXfAnB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6878587D8F; Mon,  8 Apr 2024 08:18:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F64787D8F
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 08:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712557103; x=1713161903; i=xypron.glpk@gmx.de;
 bh=I931s2PDxNwu4zop/Fdvtmh2yREYetkILaAmJHw5JJI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QAuXfAnBerHvGyK9dQYfyxu2Uw9gelImRqRrMjyiEthMbH01gVPHCtEWjnco5kUd
 swtlS2r/F3MX3wKuowKWtxXtdRet3r+VgnmWqp8l9AqjmL21QofpBC3w9La7g1baZ
 elbC3OycpZSjR1IdO8O3w4gHFyv/g7MJbJ6Twtwg8mI1u9vvyVQi1DBnAYh8EUhdU
 s8jc7XtHO4gG4z92D2I9JmZjSn4lsjbIgjFcrSLG+agPKZfkWqF4Tc22PrdSdyaBr
 32mCxpgVHdzs24quW1MwokkO85Zm2bu8nupUkmLMvkuL2+dTPbL4gLcmwEb197rxM
 hxMrKnUqOpxw/x65BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1sotUE3gtE-014DwA; Mon, 08
 Apr 2024 08:18:23 +0200
Message-ID: <641bf875-ea16-4dd3-9859-4eb0b029efde@gmx.de>
Date: Mon, 8 Apr 2024 08:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] efi_loader: Add OS notifications for SetVariableRT
 in RAM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Weizhao Ouyang
 <o451686892@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, kettenis@openbsd.org
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
 <20240406140203.248211-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240406140203.248211-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2uW1f9RkFXHRm+wNaSh6jbIFCZ10ECzerw2IIyuQAZIfV/C7X47
 8q24kVXcPMwPB4LDSRD84NHQoTrBrD2KuNI3JAaqeOQoAZTYCbVDI0UZSUwkVKer4QJVoG0
 TV7CYMEeoLwRSqPyHHlUlF8sd4JyZFFOCZ3ghdtcfEnxZ0Fxb8IW5m73NFQB7Rc/B0ILyD5
 JC+KI7XNdCRdjEk+PHAFw==
UI-OutboundReport: notjunk:1;M01:P0:Q0IFFDeBIeo=;eh5mXiyxtqaEWPZgE7SnrLPcylu
 ppfm5bSq2zQfixpNmEB+FoxmpbCvFoWuOXloE7wNthyv5vxpWkanMCoxMu9C12qtJzk0tmHlQ
 +DoE2JLl4a5AwSjG4fVH9CNzhVGRCm5f+w4go4bXmlOo0X1Gchg47r9AfKS+3JcH7UAVnhPiy
 jEYqSOTEgwWC4+nes+4V2/k0dA0ijqU4GHczXN8lqXwvSf6KRilnaIXO59I5fOBNvzfA/AtYN
 CbR0jnZUoVkE/uSHUiZmg+S2xb1TeeeDPXPvbn83Q1cDnw4pj2m+d5maWYGzqUsg0tOVxik9M
 TZREFGlBI1QAxQb/ctOfxVJ3MTfCIAe/YLFYPoNYuZcQdhucvsQ9OWzB9kH5aRclrCqcHiWny
 LzDvDwYlGYbEY+7ejFfOsLgzTvBJLsbhW0+cZWEuQB/TZgcz3EwEmYaN53kptuskZyEQ7XZk3
 cy6xNAjqSeSiJU1ULryuxqTUS74ocIZ6C2wCTV9wqjQ//SUYazwPXW98mxt2hHku5Wki5XaOk
 46Y9lRM3SBYEFOb0XDlou+0rIXS28dscUey6im+ttWtLwuaU+nqO74GF3l5YOCJQhySGrZOyV
 lbXRzmPClecg1bolGbuHbOJFsC6nDWaxjT10WIVhwC5Sm44p0xUkbuuepkYtnMZB2plHqJxnr
 hnzFi5DrKrUh13MW2gflMJ6RIUOItrJe2oDW90D5/RF/UGsWc+VYt53buR1Zh4WQJjgtKFtS3
 eeUMtfgr+mLgE3JFxGHrt9nKW7a/frmcivKrFJyahTvg11Otm5/2yFzLsz/p2NdXBSfBUEngD
 zm0X7Hurh4yXBsc3Nr8c/miAXJ1y9aBjkzgHl/NZaPjds=
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

On 4/6/24 16:01, Ilias Apalodimas wrote:
> Previous patches enable SetVariableRT using a volatile storage backend
> using EFI_RUNTIME_SERVICES_DATA allocared memory. Since there's no
> recommendation from the spec on how to notify the OS, add a volatile
> EFI variable that contains the filename relative to the ESP. OS'es
> can use that file and update it at runtime
>
> $~ efivar -p -n b2ac5fc9-92b7-4acd-aeac-11e818c3130c-RTStorageVolatile
> GUID: b2ac5fc9-92b7-4acd-aeac-11e818c3130c
> Name: "RTStorageVolatile"
> Attributes:
> 	Boot Service Access
> 	Runtime Service Access
> Value:
> 00000000  75 62 6f 6f 74 65 66 69  2e 76 61 72 00           |ubootefi.va=
r.   |
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_loader.h          |  4 ++++
>   lib/efi_loader/efi_runtime.c  |  4 ----
>   lib/efi_loader/efi_variable.c | 20 ++++++++++++++++++++
>   3 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 7daca0afba2b..25551fe18948 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -159,6 +159,10 @@ static inline void efi_set_bootdev(const char *dev,=
 const char *devnr,
>   #define EFICONFIG_AUTO_GENERATED_ENTRY_GUID \
>   	EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
>   		 0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
> +#define U_BOOT_EFI_RT_VAR_FILE_GUID \
> +	EFI_GUID(0xb2ac5fc9, 0x92b7, 0x4acd, \
> +		 0xae, 0xac, 0x11, 0xe8, 0x18, 0xc3, 0x13, 0x0c)
> +
>
>   /* Use internal device tree when starting UEFI application */
>   #define EFI_FDT_USE_INTERNAL NULL
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 8ebbea7e5c69..d898ba6c268f 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -127,10 +127,6 @@ efi_status_t efi_init_runtime_supported(void)
>   				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
>   				EFI_RT_SUPPORTED_CONVERT_POINTER;
>
> -	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
> -		rt_table->runtime_services_supported |=3D
> -			EFI_RT_SUPPORTED_SET_VARIABLE;
> -

Why do you want to remove this flag?

Best regards

Heinrich

>   	/*
>   	 * This value must be synced with efi_runtime_detach_list
>   	 * as well as efi_runtime_services.
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable=
.c
> index f79041e6bedd..f97c8c57f75c 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -554,6 +554,26 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
>    */
>   void efi_variables_boot_exit_notify(void)
>   {
> +	const efi_guid_t efi_guid_efi_rt_var_file =3D U_BOOT_EFI_RT_VAR_FILE_G=
UID;
> +	const efi_guid_t rt_prop_guid =3D EFI_RT_PROPERTIES_TABLE_GUID;
> +	efi_status_t ret;
> +
> +	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
> +		struct efi_rt_properties_table *rt_prop =3D
> +			efi_get_configuration_table(&rt_prop_guid);
> +
> +		ret =3D efi_set_variable_int(u"RTStorageVolatile",
> +					   &efi_guid_efi_rt_var_file,
> +					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +					   EFI_VARIABLE_RUNTIME_ACCESS |
> +					   EFI_VARIABLE_READ_ONLY,
> +					   sizeof(EFI_VAR_FILE_NAME),
> +					   EFI_VAR_FILE_NAME, false);
> +		if (ret !=3D EFI_SUCCESS)
> +			rt_prop->runtime_services_supported |=3D ~EFI_RT_SUPPORTED_SET_VARIA=
BLE;
> +		else
> +			log_err("Can't RTStorage. SetVariableRT won't be available\n");
> +	}
>   	/* Switch variable services functions to runtime version */
>   	efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>   	efi_runtime_services.get_next_variable_name =3D

