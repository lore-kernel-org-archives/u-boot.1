Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73282C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 09:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5C28797B;
	Fri, 12 Jan 2024 10:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JMYL6Rl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DDE87980; Fri, 12 Jan 2024 10:17:27 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FBE887976
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 10:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so6716714a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705051045; x=1705655845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jdtdz+UWkvPD2YH5OM39BXoliaXp0vTkzh/9uYe7qf4=;
 b=JMYL6Rl73I+IB8ncl7cN93DEdd9vUyWsNIxV46YIRaQEhJ0f3bvw8bhMjD32YkD3aN
 whMgxbkc6exODRBBdBVOVj70ymdZ9H+GEBrXR84ll+BWpmbjf5yTkdWbx8S/uhdv5RnX
 o9B2By1HWhOI6rvOaxqpdpoIjEOWLku6FxE3m9Dg2xORZbrHJG9pd51yUCLWkD4Wi//s
 xkX9dY6jvcYrHZFfIAYRbKhTigMF/Atx6nPChTNr6upFmQIeDsiLKpLqYReIwXsW61wb
 c8yxRCijvQu3UG+W+Qht65my8dnb+0Qxkv4+7P0gj2k0zonCvpD4Y6Brxx3s1onGOjw8
 uF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705051045; x=1705655845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jdtdz+UWkvPD2YH5OM39BXoliaXp0vTkzh/9uYe7qf4=;
 b=UioEJYbPvVIkBLJBpji6fDIuRR9QD37WCvjsPhFc3TfOevTGRqgRjRg1KPuuTyP/+Y
 Vl5WMp/Oi0L78oGoO7a0W812+GhrVNPDL0UkG82ANxSiDmcEEtQDiywhz3SQTYt0iONN
 IhMilc+3t+shMwSOL9xSxZKg/TasAD5nnvJfr00R0mDLJxFqCfGTYyjUaaadjH/8RPbu
 3j1HXdtu581ldkb3bDCKpuYYHzGecCeLI6zW7stl2O6Oe6b4v6mBJ0a3yCB/eBNErPFJ
 enQOAAd9QL/sTgUGUbnGjChMdOmS8dkuHihAkHMFT45DTVhamw28F8Lmd+gFZYSKv3JB
 Ma1w==
X-Gm-Message-State: AOJu0YzLy/dcP7nXH2x0xvDQ+RdujE3dzdxrqp/sMR+jpGEx9eHPOhDr
 aBXA9pqUe7dyYfmYdEKJiwIjb5Mo+as+Iw==
X-Google-Smtp-Source: AGHT+IFF80BIHELU7s3qUfHWdXvQadaA2eAPlQtemFYWbUJF7GDButVgF9afDKFvbdxqXXonOQKIAA==
X-Received: by 2002:a05:6402:2069:b0:557:83a8:5840 with SMTP id
 bd9-20020a056402206900b0055783a85840mr474691edb.49.1705051044747; 
 Fri, 12 Jan 2024 01:17:24 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 w1-20020aa7da41000000b00557463cdc76sm1558101eds.69.2024.01.12.01.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 01:17:24 -0800 (PST)
Date: Fri, 12 Jan 2024 11:17:22 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v3 2/2] efi_loader: support fmp versioning for multi bank
 update
Message-ID: <ZaEDotSg2-duPipD@hera>
References: <20240111053540.899997-1-masahisa.kojima@linaro.org>
 <20240111053540.899997-3-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111053540.899997-3-masahisa.kojima@linaro.org>
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

On Thu, Jan 11, 2024 at 02:35:40PM +0900, Masahisa Kojima wrote:
> This commit stores the firmware version into the array
> of fmp_state structure to support the fmp versioning
> for multi bank update. The index of the array is identified
> by the bank index.
>
> This modification keeps the backward compatibility with
> the existing versioning feature.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  lib/efi_loader/efi_firmware.c | 75 ++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 15 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index e558336bc1..9fd13297a6 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -206,18 +206,10 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
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
> @@ -226,6 +218,31 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
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
> @@ -361,8 +378,11 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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
> @@ -371,19 +391,44 @@ efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u8 image_in
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
> +	/*
> +	 * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
> +	 * variable has not been set yet.
> +	 * Ignore the error here since the correct FmpState variable
> +	 * is set later.
> +	 */
> +	efi_get_variable_int(varname, image_type_id, NULL, &size, var_state,
> +			     NULL);
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

