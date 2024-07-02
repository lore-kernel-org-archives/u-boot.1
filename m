Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A29C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4EA8871C;
	Tue,  2 Jul 2024 15:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gz7MxgaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8B088709; Tue,  2 Jul 2024 15:49:06 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE49C8852D
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cd80e55efso7490685e87.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719928142; x=1720532942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0bNj0jbfeBvts4IJB8rg3giULN/baXEKlLD4SoYQfLk=;
 b=gz7MxgaYYsIEmZxwxOR8bHOE9OqIf2D58zClNmgJALtXkEG35eiDhv7FvbEWfPNvuQ
 DOgxt/Vx/PEYOYuXx6tJS1q5cQCR0mY62StsKbv2VWyEK38i7nzjq5S6njGTwTzlXbMv
 Ooy6Wbo6UKftpAcBK+iAndld7/iAO7nXhpLwgj19cf2cbn123ljfQRcNhfBWu41oTf35
 HMxmk3E487KYDmY48m87Rs/e/0WlRZwRren81p1NHk4ZR0bUXtbM+IVeWwPNRFYEh+7W
 qtdX36GVhuOZaa32aAsmIaA+ejKPzK8IssbwB5lFn6HpmvmOD9JPNpU5Fhf9HT0zFia2
 L+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719928142; x=1720532942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0bNj0jbfeBvts4IJB8rg3giULN/baXEKlLD4SoYQfLk=;
 b=Pq0+7jOYNESQDREH0eQG5qN+1YUjL5pW+8x+2TWpn0WXuAdkn/ztEuwiRJBg6yISOD
 XXhqpxyM/uCjyH9+TzkvRuemT3rSv6jwY9G+CF8nJCGZUl5s5QTk21dmkazybk5WjZL1
 4syfhxz/yHatrkb2td7/TB4jOPaptfIWt9qKUkjhXieMYTLSQYzB413Hvs6AsvAXStM9
 DBlQKlsnaBJYc9MRlT0tN+So0UhFUaYEpyjJ0t0RL+RGXYUhrPSEw+1rH0zMpcA0WV9u
 BYc3oKJaGQak3EqYSOqhoCsZpwTpEqT7vD8kAMVJ/HcLvdo1KhLYjeVCll+ftwh/+bTz
 6lAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMbd4B03iNsiBcLRmN3qD9XtjBpDOjsGD+U9ojT+7Nd5ogAX9VfaUnvCZNqsWN3KHMoYbfojA51tiAb8sveDa/0VhHvA==
X-Gm-Message-State: AOJu0YwyEzQsEZaJmC28ojlMV+xF+tZDLiu2AhH8xzsY7qL37KT8+Jqe
 EQOP8HJaU+bjK+gIk1AGolOHVZSm/8skkwkpnou3yNAqZqoSuyrygpfNvR9cdHE=
X-Google-Smtp-Source: AGHT+IGovMbYQ8irP84WvA/pwv2EXX2iJPlxZWvwbrS5cGB/F1j454Izr9Ev0ghXQoOd5MfCwCZjJA==
X-Received: by 2002:a05:6512:220b:b0:52c:dba2:4f1 with SMTP id
 2adb3069b0e04-52e827042e6mr6461530e87.48.1719928142081; 
 Tue, 02 Jul 2024 06:49:02 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0652c6sm423395266b.109.2024.07.02.06.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:49:01 -0700 (PDT)
Message-ID: <eb891ba1-4b0d-4822-a10f-3632ce1716a7@linaro.org>
Date: Tue, 2 Jul 2024 15:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Proposed changes to dynamic UUIDs v3
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>
References: <ZnVEALsxt2b9s-cI@debian>
 <20240627095554.1785192-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240627095554.1785192-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Vincent,

On 27/06/2024 11:55, Vincent Stehlé wrote:
> Here are the changes that I would like to suggest for the "efi:
> CapsuleUpdate: support for dynamic UUIDs" v3 patch series:
> 
> - Convert from big-endian UUID to little-endian GUID in
>    efi_capsule_update_info_gen_ids().
> 
> - Fix tmp size and masking in gen_uuid_v5().
> 
> - Use UUID_STR_FORMAT_STD in all places where we are dealing with a
>    big-endian UUID.
> 
> - Update all GUIDs constants in the code and in the tests accordingly. This
>    gets rid of the following broken UUIDs:
> 
>      5af91295-5a99-f62b-80d7-e9574de87170
>      8ee418dc-7e00-e156-80a7-274fbbc05ba8
>      935fe837-fac8-4394-c008-737d8852c60d
>      fd5db83c-12f3-a46b-80a9-e3007c7ff56e
>      ffd97379-0956-fa94-c003-8bfcf5cc097b
> 
> - Also, a few minor modifications here and there.

Thanks, this was really helpful for prepping v4. I decided to go with a 
slightly different approach and just make the the v5 generator produce a 
little endian GUID rather than a BE UUID.

V4 is here: 
https://lore.kernel.org/u-boot/20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org

Kind regards,
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Richard Hughes <hughsient@gmail.com>
> ---
>   include/sandbox_efi_capsule.h                      |  6 +++---
>   lib/efi_loader/efi_firmware.c                      | 14 +++++++++++---
>   lib/uuid.c                                         |  8 ++++----
>   test/lib/uuid.c                                    | 12 ++++++------
>   .../test_efi_capsule/test_capsule_firmware_fit.py  |  4 ++--
>   .../test_efi_capsule/test_capsule_firmware_raw.py  |  8 ++++----
>   .../test_capsule_firmware_signed_fit.py            |  2 +-
>   .../test_capsule_firmware_signed_raw.py            |  4 ++--
>   test/py/tests/test_efi_capsule/version.dts         |  6 +++---
>   tools/.gitignore                                   |  1 +
>   tools/binman/etype/efi_capsule.py                  |  2 +-
>   tools/binman/ftest.py                              |  2 +-
>   tools/genguid.c                                    |  7 +++----
>   13 files changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
> index 25ac496ea24..6f0de5a1e25 100644
> --- a/include/sandbox_efi_capsule.h
> +++ b/include/sandbox_efi_capsule.h
> @@ -6,9 +6,9 @@
>   #if !defined(_SANDBOX_EFI_CAPSULE_H_)
>   #define _SANDBOX_EFI_CAPSULE_H_
>   
> -#define SANDBOX_UBOOT_IMAGE_GUID	"fd5db83c-12f3-a46b-80a9-e3007c7ff56e"
> -#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"935fe837-fac8-4394-c008-737d8852c60d"
> -#define SANDBOX_FIT_IMAGE_GUID		"ffd97379-0956-fa94-c003-8bfcf5cc097b"
> +#define SANDBOX_UBOOT_IMAGE_GUID	"50980990-5af9-5522-86e2-8f05f4d7313c"
> +#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"3554b655-b9f0-5240-ace2-6f34c2f7fcca"
> +#define SANDBOX_FIT_IMAGE_GUID		"8b38adc7-df0c-5769-8b89-c090ca3d07a7"
>   #define SANDBOX_INCORRECT_GUID		"058b7d83-50d5-4c47-a195-60d86ad341c4"
>   
>   #define UBOOT_FIT_IMAGE			"u-boot_bin_env.itb"
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index a8dafe4f01a..f0d0c3fa972 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -258,7 +258,7 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>   static efi_status_t efi_capsule_update_info_gen_ids(void)
>   {
>   	int ret, i;
> -	struct uuid namespace;
> +	struct uuid namespace, type;
>   	const char *compatible; /* Full array including null bytes */
>   	struct efi_fw_image *fw_array;
>   
> @@ -269,7 +269,7 @@ static efi_status_t efi_capsule_update_info_gen_ids(void)
>   		return EFI_SUCCESS;
>   
>   	ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
> -			(unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
> +			(unsigned char *)&namespace, UUID_STR_FORMAT_STD);
>   	if (ret) {
>   		log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", __func__, ret);
>   		return EFI_UNSUPPORTED;
> @@ -289,12 +289,20 @@ static efi_status_t efi_capsule_update_info_gen_ids(void)
>   
>   	for (i = 0; i < update_info.num_images; i++) {
>   		gen_uuid_v5(&namespace,
> -			    (struct uuid *)&fw_array[i].image_type_id,
> +			    &type,
>   			    compatible, strlen(compatible),
>   			    fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
>   				- sizeof(uint16_t),
>   			    NULL);
>   
> +		/* Convert to little-endian GUID. */
> +		fw_array[i].image_type_id = (efi_guid_t)EFI_GUID(
> +			be32_to_cpu(type.time_low), be16_to_cpu(type.time_mid),
> +			be16_to_cpu(type.time_hi_and_version),
> +			type.clock_seq_hi_and_reserved, type.clock_seq_low,
> +			type.node[0], type.node[1], type.node[2], type.node[3],
> +			type.node[4], type.node[5]);
> +
>   		log_debug("Image %ls UUID %pUs\n", fw_array[i].fw_name,
>   			  &fw_array[i].image_type_id);
>   	}
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 89911b06ccc..a8c3a504090 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -391,7 +391,7 @@ void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
>   	va_list args;
>   	const uint8_t *data;
>   	uint8_t hash[SHA1_SUM_LEN];
> -	uint32_t tmp;
> +	uint16_t tmp;
>   
>   	sha1_starts(&ctx);
>   	/* Hash the namespace UUID as salt */
> @@ -411,11 +411,11 @@ void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
>   	memcpy(uuid, hash, sizeof(*uuid));
>   
>   	/* Configure variant/version bits */
> -	tmp = be32_to_cpu(uuid->time_hi_and_version);
> +	tmp = be16_to_cpu(uuid->time_hi_and_version);
>   	tmp = (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT);
> -	uuid->time_hi_and_version = cpu_to_be32(tmp);
> +	uuid->time_hi_and_version = cpu_to_be16(tmp);
>   
> -	uuid->clock_seq_hi_and_reserved &= UUID_VARIANT_MASK;
> +	uuid->clock_seq_hi_and_reserved &= ~UUID_VARIANT_MASK;
>   	uuid->clock_seq_hi_and_reserved |= UUID_VARIANT << UUID_VARIANT_SHIFT;
>   }
>   #endif
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index 0bcb332e534..b5940fa855c 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -60,7 +60,7 @@ static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
>   	int j;
>   
>   	ut_assertok(uuid_str_to_bin(data->namespace, (unsigned char *)&namespace,
> -				    UUID_STR_FORMAT_GUID));
> +				    UUID_STR_FORMAT_STD));
>   
>   	for (j = 0; data->images[j]; j++) {
>   		const char *expected_uuid = data->expected_uuids[j];
> @@ -72,7 +72,7 @@ static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
>   			    data->compatible, strlen(data->compatible),
>   			    image, u16_strsize(image) - sizeof(uint16_t),
>   			    NULL);
> -		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
> +		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_STD);
>   
>   		ut_asserteq_str(expected_uuid, uuid_str);
>   	}
> @@ -94,9 +94,9 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
>   				NULL,
>   			},
>   			.expected_uuids = {
> -				"fd5db83c-12f3-a46b-80a9-e3007c7ff56e",
> -				"935fe837-fac8-4394-c008-737d8852c60d",
> -				"ffd97379-0956-fa94-c003-8bfcf5cc097b",
> +				"50980990-5af9-5522-86e2-8f05f4d7313c",
> +				"3554b655-b9f0-5240-ace2-6f34c2f7fcca",
> +				"8b38adc7-df0c-5769-8b89-c090ca3d07a7",
>   				NULL,
>   			}
>   		},
> @@ -108,7 +108,7 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
>   				NULL,
>   			},
>   			.expected_uuids = {
> -				"8ee418dc-7e00-e156-80a7-274fbbc05ba8",
> +				"14c399c8-4e16-5ba4-b720-44426d3a0bb9",
>   				NULL,
>   			}
>   		},
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> index 746da460208..9701acebbe3 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
> @@ -146,8 +146,8 @@ class TestEfiCapsuleFirmwareFit():
>                   verify_content(u_boot_console, '100000', 'u-boot:Old')
>                   verify_content(u_boot_console, '150000', 'u-boot-env:Old')
>               else:
> -                # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -                assert '5AF91295-5A99-F62B-80D7-E9574DE87170' in ''.join(output)
> +                # ensure that SANDBOX_FIT_IMAGE_GUID is in the ESRT.
> +                assert '8B38ADC7-DF0C-5769-8B89-C090CA3D07A7' in ''.join(output)
>                   assert 'ESRT: fw_version=5' in ''.join(output)
>                   assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>   
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> index 1866b808657..cedb3a43591 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
> @@ -134,10 +134,10 @@ class TestEfiCapsuleFirmwareRaw:
>                   'efidebug capsule esrt'])
>   
>               # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -            assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
> +            assert '3554B655-B9F0-5240-ACE2-6F34C2F7FCCA' in ''.join(output)
>   
>               # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
> +            assert '50980990-5AF9-5522-86E2-8F05F4D7313C' in ''.join(output)
>   
>               check_file_removed(u_boot_console, disk_img, capsule_files)
>   
> @@ -188,12 +188,12 @@ class TestEfiCapsuleFirmwareRaw:
>                   verify_content(u_boot_console, '150000', 'u-boot-env:Old')
>               else:
>                   # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -                assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
> +                assert '50980990-5AF9-5522-86E2-8F05F4D7313C' in ''.join(output)
>                   assert 'ESRT: fw_version=5' in ''.join(output)
>                   assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>   
>                   # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -                assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
> +                assert '3554B655-B9F0-5240-ACE2-6F34C2F7FCCA' in ''.join(output)
>                   assert 'ESRT: fw_version=10' in ''.join(output)
>                   assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
>   
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> index a4e0a3bc73f..10eb8281457 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
> @@ -157,7 +157,7 @@ class TestEfiCapsuleFirmwareSignedFit():
>                   'efidebug capsule esrt'])
>   
>               # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
> +            assert '8B38ADC7-DF0C-5769-8B89-C090CA3D07A7' in ''.join(output)
>               assert 'ESRT: fw_version=5' in ''.join(output)
>               assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>   
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> index 260c7186063..01e5f3b3405 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> @@ -151,12 +151,12 @@ class TestEfiCapsuleFirmwareSignedRaw():
>                   'efidebug capsule esrt'])
>   
>               # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
> -            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
> +            assert '50980990-5AF9-5522-86E2-8F05F4D7313C' in ''.join(output)
>               assert 'ESRT: fw_version=5' in ''.join(output)
>               assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
>   
>               # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
> -            assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
> +            assert '3554B655-B9F0-5240-ACE2-6F34C2F7FCCA' in ''.join(output)
>               assert 'ESRT: fw_version=10' in ''.join(output)
>               assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
>   
> diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dts
> index 3f0698bf728..c447a3d8199 100644
> --- a/test/py/tests/test_efi_capsule/version.dts
> +++ b/test/py/tests/test_efi_capsule/version.dts
> @@ -8,17 +8,17 @@
>   		image1 {
>   			lowest-supported-version = <3>;
>   			image-index = <1>;
> -			image-type-id = "FD5DB83C-12F3-A46B-80A9-E3007C7FF56E";
> +			image-type-id = "50980990-5AF9-5522-86E2-8F05F4D7313C";
>   		};
>   		image2 {
>   			lowest-supported-version = <7>;
>   			image-index = <2>;
> -			image-type-id = "935FE837-FAC8-4394-C008-737D8852C60D";
> +			image-type-id = "3554B655-B9F0-5240-ACE2-6F34C2F7FCCA";
>   		};
>   		image3 {
>   			lowest-supported-version = <3>;
>   			image-index = <1>;
> -			image-type-id = "FFD97379-0956-FA94-C003-8BFCF5CC097B";
> +			image-type-id = "8B38ADC7-DF0C-5769-8B89-C090CA3D07A7";
>   		};
>   	};
>   };
> diff --git a/tools/.gitignore b/tools/.gitignore
> index 0108c567309..6b7d7b89c39 100644
> --- a/tools/.gitignore
> +++ b/tools/.gitignore
> @@ -15,6 +15,7 @@
>   /gdb/gdbsend
>   /gen_eth_addr
>   /gen_ethaddr_crc
> +/genguid
>   /ifdtool
>   /ifwitool
>   /img2srec
> diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> index da1f9b0a381..f9f4fda5f71 100644
> --- a/tools/binman/etype/efi_capsule.py
> +++ b/tools/binman/etype/efi_capsule.py
> @@ -24,7 +24,7 @@ def get_binman_test_guid(type_str):
>           The actual GUID value (str)
>       """
>       TYPE_TO_GUID = {
> -        'binman-test' : 'fd5db83c-12f3-a46b-80a9-e3007c7ff56e'
> +        'binman-test' : '50980990-5af9-5522-86e2-8f05f4d7313c'
>       }
>   
>       return TYPE_TO_GUID[type_str]
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index dc602b95ecd..5610afc26de 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -124,7 +124,7 @@ TEE_ADDR = 0x5678
>   # Firmware Management Protocol(FMP) GUID
>   FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
>   # Image GUID specified in the DTS
> -CAPSULE_IMAGE_GUID = 'fd5db83c-12f3-a46b-80a9-e3007c7ff56e'
> +CAPSULE_IMAGE_GUID = '50980990-5af9-5522-86e2-8f05f4d7313c'
>   # Windows cert GUID
>   WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
>   # Empty capsule GUIDs
> diff --git a/tools/genguid.c b/tools/genguid.c
> index e71bc1d48f9..1e365399721 100644
> --- a/tools/genguid.c
> +++ b/tools/genguid.c
> @@ -15,7 +15,6 @@
>   #include <uuid.h>
>   
>   static struct option options[] = {
> -	{"dtb", required_argument, NULL, 'd'},
>   	{"compat", required_argument, NULL, 'c'},
>   	{"help", no_argument, NULL, 'h'},
>   	{"verbose", no_argument, NULL, 'v'},
> @@ -99,7 +98,7 @@ int main(int argc, char **argv)
>   		return 1;
>   	}
>   
> -	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR_FORMAT_GUID)) {
> +	if (uuid_str_to_bin(namespace_str, (unsigned char *)&namespace, UUID_STR_FORMAT_STD)) {
>   		fprintf(stderr, "ERROR: Check that your UUID is formatted correctly.\n");
>   		exit(EXIT_FAILURE);
>   	}
> @@ -116,7 +115,7 @@ int main(int argc, char **argv)
>   
>   	if (debug) {
>   		fprintf(stderr, "GUID:         ");
> -		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_GUID);
> +		uuid_bin_to_str((uint8_t *)&namespace, uuid_str, UUID_STR_FORMAT_STD);
>   		fprintf(stderr, "%s\n", uuid_str);
>   		fprintf(stderr, "Compatible:  \"%s\"\n", compatible);
>   		fprintf(stderr, "Images:      ");
> @@ -134,7 +133,7 @@ int main(int argc, char **argv)
>   			    images_u16[i], u16_strsize(images_u16[i]) - sizeof(uint16_t),
>   			    NULL);
>   
> -		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_GUID);
> +		uuid_bin_to_str((uint8_t *)&image_type_id, uuid_str, UUID_STR_FORMAT_STD);
>   		image_uuids[i] = strdup(uuid_str);
>   	}
>   

-- 
// Caleb (they/them)
