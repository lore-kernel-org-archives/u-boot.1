Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A290CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A75288DA3;
	Wed, 24 Apr 2024 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bmIYD7FP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F3288D9A; Wed, 24 Apr 2024 09:26:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9FE88D81
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713943559; x=1714548359; i=xypron.glpk@gmx.de;
 bh=9IvisswrtlBN1ozCJzXVQ6M45UDnmZ0LInoj+1IRGuU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bmIYD7FPgQv3HzS4FE5LZeN2AadM/4G9Ml2/SqJT5IxM51x1gZWfh+liyxAC84zM
 GKlyNgMFk9yqfbeTRc0sWNC4nMnZII5RvePoPTQ7w3uO+A8u2KiCyVmHqDGubHiqz
 LdxcXZOr+eyoVcv8jT3sNowSGVFeFl2NSYMztVL6oW7XIDwtEjrwtUBw5ob96yeUs
 gZMZNGZS7bjqCNGc+ipAyTdUlv768MVbVZAST+Y51uJjTNMU9C2xFkx/w00j/hSmi
 vjrVU8BypcledBeDqtgOIzHaVdOHgeKHEe0BjeN6O1FbKCfS9xNr/86IiG4jx2PE9
 t/ZdDDzsIhmVPWiWsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1ryzJh09vS-003tIf; Wed, 24
 Apr 2024 09:25:59 +0200
Message-ID: <81eb4c85-fd83-43ab-ad23-849bf61f7f8e@gmx.de>
Date: Wed, 24 Apr 2024 09:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi_selftest: add tests for QueryVariableInfo at
 runtime
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240424050351.318724-1-ilias.apalodimas@linaro.org>
 <20240424050351.318724-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240424050351.318724-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kfN6zzpSw/PAxk9WjwtEc7VOiWWBrWzwVVGlnexq7RVxbeb4p2J
 V5Rd5Hus7CeR/6ET5vxLXjVC3dL6qjiHodsYh1MUvVCPSXbWE9p37Wp9PuM9T18YaoW62+A
 lutloQ+YxPVuLaahkJqylTTqpIW2hydxPzPle0cfn/LOgaZqwF4Ku3BwQBprpMpPa9BJrmn
 n7mqnKGO+B2eYyF2rPj7w==
UI-OutboundReport: notjunk:1;M01:P0:sUuqrnllCzE=;HEcP65LIhu5K2ryBe7W001yjpjY
 baRdQTIKyLvWc4/A6WXBE0mFRFSoaRH6LVlmHyVrn/lomRGbUpqDdt3JGv9/0vcqXDvZMxVuB
 ueX+chvE/EvzATOhlZru0Q0mMHAQ/5HiaJMKhI1aKi8sl5SPzPmK+fUpitvCCyp5V/vGGd0ej
 HNE4nx0q4QIMuiKX6vCPYsxgcVBlAUBcuHpFALFIZhMv4Jf9UtzDbSLThBwZXqx0entqKCjKy
 uocOLyb763cc+cGdUfRVK54c4rb5+P52fy0rwbQxUME2LvL3L6uAp+M/BnvilWdrL9ClbKrQO
 OSBlXrxmpCxO4soqnXWA1pBQBmSR4frMWWZwa8kaL2nVx1tS4Zxw1V4iE8JntllihJMvYfp1W
 YfuzwBILfNbU+zEIFVryw6tDt5xCTWX9UqjC9d0K/4ISBLVD/PIsdjXeV6yBxWZmoCv5DAsGo
 XbU9y/FJw83B/47713m320jGEyhvC/F/bPlWShxp95whthspHi0N7KyPa9y9J0KA4wzRkIWhf
 vIm3g9A1dTospO2hMiGkZwioSQKj8hfb9qsQ5ddqmLZuqgc6bLvkrZMH6sS86MmQNs0kmLThT
 0Ouad3MLLrnYtPW2C83rnXmE8KZ+eJ0ty0v6lmgciaF1Fk0cK7OG9KFToKrqLGZeiYbTxfall
 FdUqxVxgPf4aNBEh1Z7l6t5p5UiEqlKVKAiYPMtUad17Z75Pn6hG54SrQHYHfCikUW8QseAYj
 CHeE11gTGlAvLDd8OLa9q1+CVaHMPy0me4m0Z0b4cn+kOhJ1GVVbWe3qpl/wBTSoT2Ju28Yqj
 DYgYRALLxQQp4pqPI8pOanpRcuLEQrR/XFbZ3+2uDSJGs=
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

On 24.04.24 07:03, Ilias Apalodimas wrote:
> Since we support QueryVariableInfo at runtime now add the relevant
> tests. Since we want those to be reusable at bootime, add them
> in a separate file
>
> Add tests for
> - Test QueryVariableInfo returns EFI_SUCCESS
> - Test null pointers for the function arguments
> - Test invalid combination of attributes
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   include/efi_selftest.h                        |   9 ++
>   lib/efi_selftest/Makefile                     |   1 +
>   .../efi_selftest_variables_common.c           | 102 ++++++++++++++++++
>   .../efi_selftest_variables_runtime.c          |  10 +-
>   4 files changed, 118 insertions(+), 4 deletions(-)
>   create mode 100644 lib/efi_selftest/efi_selftest_variables_common.c
>
> diff --git a/include/efi_selftest.h b/include/efi_selftest.h
> index 5bcebb368287..ca7ae948663e 100644
> --- a/include/efi_selftest.h
> +++ b/include/efi_selftest.h
> @@ -147,6 +147,15 @@ void *efi_st_get_config_table(const efi_guid_t *gui=
d);
>    */
>   u16 efi_st_get_key(void);
>
> +/**
> + * efi_st_query_variable_common - Common variable tests for boottime/ru=
ntime
> + *
> + * @runtime:	Pointer to services table
> + *
> + * Return:	EFI_ST_SUCCESS/FAILURE
> + */
> +int efi_st_query_variable_common(struct efi_runtime_services *runtime);
> +
>   /**
>    * struct efi_unit_test - EFI unit test
>    *
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index e4d75420bff6..414701893f65 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -45,6 +45,7 @@ efi_selftest_textinputex.o \
>   efi_selftest_textoutput.o \
>   efi_selftest_tpl.o \
>   efi_selftest_util.o \
> +efi_selftest_variables_common.o \
>   efi_selftest_variables.o \
>   efi_selftest_variables_runtime.o \
>   efi_selftest_watchdog.o
> diff --git a/lib/efi_selftest/efi_selftest_variables_common.c b/lib/efi_=
selftest/efi_selftest_variables_common.c
> new file mode 100644
> index 000000000000..36bdfe6ff9c3
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_variables_common.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * efi_selftest_variables_runtime
> + *
> + * Copyright (c) 2024 Ilias Apalodimas <ilias.apalodimas@linaro.org>
> + *
> + * This unit test checks common service across boottime/runtime
> + */
> +
> +#include <efi_selftest.h>
> +
> +#define EFI_INVALID_ATTR BIT(30)
> +
> +int efi_st_query_variable_common(struct efi_runtime_services *runtime)
> +{

EDK2's VariableServiceQueryVariableInfo() in
MdeModulePkg/Universal/Variable/RuntimeDxe/Variable.c has different
attribute requirements at runtime than at boot services time.

I guess QueryVariables() should return EFI_INVALID_PARAMETER whenever
SetVariables() does.

Best regards

Heinrich

Best regards

Heinrich

> +	efi_status_t ret;
> +	u64 max_storage, rem_storage, max_size;
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> +					   &max_storage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_SUCCESS) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> +					   NULL, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> +					   &max_storage, NULL,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> +					   &max_storage, &rem_storage,
> +					   NULL);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(0, &max_storage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_AUTHENTICATED_WRITE_=
ACCESS |
> +					   EFI_VARIABLE_NON_VOLATILE,
> +					   &max_storage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_UNSUPPORTED) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	/* Use an attribute bit not described in the EFI spec */
> +	ret =3D runtime->query_variable_info(EFI_INVALID_ATTR, &max_storage,
> +					   &rem_storage, &max_size);
> +	if (ret !=3D EFI_UNSUPPORTED) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_RUNTIME_ACCESS, &max=
_storage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	ret =3D runtime->query_variable_info(EFI_VARIABLE_NON_VOLATILE, &max_s=
torage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	/*
> +	 * Use a mix existing/non-existing attribute bits from the
> +	 * UEFI spec
> +	 */
> +	ret =3D runtime->query_variable_info(EFI_INVALID_ATTR | EFI_VARIABLE_N=
ON_VOLATILE,
> +					   &max_storage, &rem_storage,
> +					   &max_size);
> +	if (ret !=3D EFI_INVALID_PARAMETER) {
> +		efi_st_error("QueryVariableInfo failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +
> +	return EFI_ST_SUCCESS;
> +}
> diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi=
_selftest/efi_selftest_variables_runtime.c
> index 5794a7b2d405..6cb86771fe78 100644
> --- a/lib/efi_selftest/efi_selftest_variables_runtime.c
> +++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
> @@ -55,18 +55,20 @@ static int execute(void)
>   	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
>   	efi_guid_t guid;
>   	u64 max_storage, rem_storage, max_size;
> +	int test_ret;
>
>   	memset(v2, 0x1, sizeof(v2));
> -	ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> -					   &max_storage, &rem_storage,
> -					   &max_size);
>
>   	if (IS_ENABLED(CONFIG_EFI_VARIABLE_FILE_STORE)) {
> -		if (ret !=3D EFI_SUCCESS) {
> +		test_ret =3D efi_st_query_variable_common(runtime);
> +		if (test_ret !=3D EFI_ST_SUCCESS) {
>   			efi_st_error("QueryVariableInfo failed\n");
>   			return EFI_ST_FAILURE;
>   		}
>   	} else {
> +		ret =3D runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
> +					   &max_storage, &rem_storage,
> +					   &max_size);
>   		if (ret !=3D EFI_UNSUPPORTED) {
>   			efi_st_error("QueryVariableInfo failed\n");
>   			return EFI_ST_FAILURE;

