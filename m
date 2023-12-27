Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0FDC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 581EE8775F;
	Wed, 27 Dec 2023 16:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tMx2m7HR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C921D87823; Wed, 27 Dec 2023 16:14:31 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C44678761B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e7f58c5fbso1841283e87.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703690069; x=1704294869; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x6BOym9+Rrn79rtYcj8PE5RSdS6+MTSdJ9OflheT5X4=;
 b=tMx2m7HR7pMhxsdVeB8eGs+9Cs+7CzP2aU//c7pqyQAYyJ7pqIN9AuMNFQTdT1Fh5D
 WCGdSp3xyMVrGs3wt+BOwHF1CzX3a649SPV6wWQF0JaXBfA6OEJQFwWIdnHGXw3mn7Is
 4RyrceD6Z901wd4hGfttvTM+RI+eBp8eHQTqWkNeTFvaDJ9XNDXFb4Z8oZW7bzh6e71R
 rXzRYcc8xVn5nnIO7c+dek7bTBeVeu7/5uOJnV2nyQLnh/b2UWrD/YbPMRExVWeECt0e
 8k/G4x0Z+WitN7nlXwV7M3K1pfoGjV34PGXxT+9ZLBCr9Q9Yy84+9xL/g3CkBtYB3J/Z
 XXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703690069; x=1704294869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6BOym9+Rrn79rtYcj8PE5RSdS6+MTSdJ9OflheT5X4=;
 b=FvgAqlnYN1TVf6ncHJvBhSDGL7sd6yEb+SNtOIx3v6RNR0ZH/aNfHbc5+cpPnzvKqi
 ojtggqRPM5ET0mBgNBfmuInubMgy3rI+gSuSKPlTp2pocMh7y8S5WKtmAJ+pLwwjFsgk
 2d66uPYgaPpt9faXO7wq71MaulNHvb4JOT1oZ4E2gOrv+3lr6Cq/LHkPqtEm2OLB3pp5
 RvBQR8Tt2jBBVYRXIfbNslOPo/ykBeve8hQ7UmXUEcjzXY/0itP8+IjDsIuY0BBdHJc+
 v50ttM4RnywrOszguGb5NVw6HZyv/qwkIwGqxhrjqj1ZwUHyLK0Nj+UATMrw+ysNcJ5F
 AvyA==
X-Gm-Message-State: AOJu0Yw0lnI7uS1jqRB74i4uWLOT/1yrTUH2lmPX1rTp0cth80AYmMpG
 nwMXN+4Ua6KUQCJw+T/6f+hHXoEodqeb9w==
X-Google-Smtp-Source: AGHT+IFXgCLgPQum9a7qfHARH6J1xXvpX+v2tbYdO1TJ24RB1fBT+Z9iuRGsumgw6PdAcvh8WbWovQ==
X-Received: by 2002:a05:6512:360e:b0:50e:7b7c:8593 with SMTP id
 f14-20020a056512360e00b0050e7b7c8593mr1569032lfs.10.1703690069000; 
 Wed, 27 Dec 2023 07:14:29 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 z27-20020a17090674db00b00a26aa045d48sm6208669ejl.117.2023.12.27.07.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 07:14:28 -0800 (PST)
Date: Wed, 27 Dec 2023 17:14:26 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 2/2] efi_loader: support fmp versioning for multi bank
 update
Message-ID: <ZYw_UqZ_wj-htZvI@hera>
References: <20231221095258.592275-1-masahisa.kojima@linaro.org>
 <20231221095258.592275-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221095258.592275-3-masahisa.kojima@linaro.org>
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

Kojima-san

On Thu, Dec 21, 2023 at 06:52:58PM +0900, Masahisa Kojima wrote:
> This commit stores the firmware version into the array
> of fmp_state structure to support the fmp versioning
> for multi bank update. The index of the array is identified
> by the bank index.

Why do we all of them? Can't we just always store/use the version of the active
bank?

>
> This modification keeps the backward compatibility with
> the existing versioning feature.
>

Thanks
/Ilias
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_firmware.c | 69 +++++++++++++++++++++++++++--------
>  1 file changed, 54 insertions(+), 15 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 9b8630625f..5459f3d38d 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -207,18 +207,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>  {
>  	u16 varname[13]; /* u"FmpStateXXXX" */
>  	efi_status_t ret;
> -	efi_uintn_t size;
> -	struct fmp_state var_state = { 0 };
> -
> -	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> -				fw_array->image_index);
> -	size = sizeof(var_state);
> -	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> -				   NULL, &size, &var_state, NULL);
> -	if (ret == EFI_SUCCESS)
> -		image_info->version = var_state.fw_version;
> -	else
> -		image_info->version = 0;
> +	efi_uintn_t size, expected_size;
> +	uint num_banks = 1;
> +	uint active_index = 0;
> +	struct fmp_state *var_state;
>
>  	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
>  				      &fw_array->image_type_id,
> @@ -227,6 +219,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
>  	image_info->version_name = NULL; /* not supported */
>  	image_info->last_attempt_version = 0;
>  	image_info->last_attempt_status = LAST_ATTEMPT_STATUS_SUCCESS;
> +	image_info->version = 0;
> +
> +	/* get the fw_version */
> +	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> +				fw_array->image_index);
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		ret = fwu_get_active_index(&active_index);
> +		if (ret)
> +			return;
> +
> +		num_banks = CONFIG_FWU_NUM_BANKS;
> +	}
> +
> +	size = num_banks * sizeof(*var_state);
> +	expected_size = size;
> +	var_state = calloc(1, size);
> +	if (!var_state)
> +		return;
> +
> +	ret = efi_get_variable_int(varname, &fw_array->image_type_id,
> +				   NULL, &size, var_state, NULL);
> +	if (ret == EFI_SUCCESS && expected_size == size)
> +		image_info->version = var_state[active_index].fw_version;
> +
> +	free(var_state);
>  }
>
>  /**
> @@ -362,8 +379,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
>  {
>  	u16 varname[13]; /* u"FmpStateXXXX" */
>  	efi_status_t ret;
> +	uint num_banks = 1;
> +	uint update_bank = 0;
> +	efi_uintn_t size;
>  	efi_guid_t *image_type_id;
> -	struct fmp_state var_state = { 0 };
> +	struct fmp_state *var_state;
>
>  	image_type_id = efi_firmware_get_image_type_id(image_index);
>  	if (!image_type_id)
> @@ -372,19 +392,38 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
>  	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
>  				image_index);
>
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		ret = fwu_plat_get_update_index(&update_bank);
> +		if (ret)
> +			return EFI_INVALID_PARAMETER;
> +
> +		num_banks = CONFIG_FWU_NUM_BANKS;
> +	}
> +
> +	size = num_banks * sizeof(*var_state);
> +	var_state = calloc(1, size);
> +	if (!var_state)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	ret = efi_get_variable_int(varname, image_type_id, NULL, &size,
> +				   var_state, NULL);
> +
>  	/*
>  	 * Only the fw_version is set here.
>  	 * lowest_supported_version in FmpState variable is ignored since
>  	 * it can be tampered if the file based EFI variable storage is used.
>  	 */
> -	var_state.fw_version = state->fw_version;
> +	var_state[update_bank].fw_version = state->fw_version;
>
> +	size = num_banks * sizeof(*var_state);
>  	ret = efi_set_variable_int(varname, image_type_id,
>  				   EFI_VARIABLE_READ_ONLY |
>  				   EFI_VARIABLE_NON_VOLATILE |
>  				   EFI_VARIABLE_BOOTSERVICE_ACCESS |
>  				   EFI_VARIABLE_RUNTIME_ACCESS,
> -				   sizeof(var_state), &var_state, false);
> +				   size, var_state, false);
> +
> +	free(var_state);
>
>  	return ret;
>  }
> --
> 2.34.1
>
