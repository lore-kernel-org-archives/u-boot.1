Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC4AC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196B687C37;
	Wed, 24 Jan 2024 12:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nUOHEoJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B965987C40; Wed, 24 Jan 2024 12:23:00 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE3B8786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-559edcee47eso4606570a12.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 03:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706095377; x=1706700177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vm16ZwWmfXY4rOrkYLztvWuqzw9EFTADr3SwjewrIKM=;
 b=nUOHEoJ2h2Zkw8XYRTRhfLaUnl+TryRBfkHEpHYyaPWfXDg3qDsDU9MRARE0OuIH7T
 Me39NPhsh3rsZ9sDYpCRs53jBRXvS8QSJLcQKPD9GGfLusHDjY5LEb+P/cC9uCrBLxpj
 fR8F5lxHPzAPC0nOx5sCyw8dv0vPnDTT4SjjDeLqhUGeByTiD662Sl7xIVsMhu5PcFk/
 92DyrvbyzZ8zqzTRte9CQIgxJ/hud8I7dpx/lXXSOsfb2+UyV9Dpmmx9jlx2p+QyZoYE
 yXyonZj/lutfYjlDHhgW3LBLkchfEbc6SM7iL8bT7pWjhqUfrPOv1oYYmgnPkbg/UuFc
 jbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706095377; x=1706700177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vm16ZwWmfXY4rOrkYLztvWuqzw9EFTADr3SwjewrIKM=;
 b=oj9/mz0ywqJgBeYSk2R5RlxT4ZmzC818Y2kQD3/lYiO4KtPUx8bBc3lLYAG+xhrfV+
 T/fnLnrdUdbjtu+ONMhMQR9b/gUdoHFoMmqs4BNQ2wlR2rO31gN8M66z57SF4EbFfam9
 tY3LYWygMQF5pMOp3aPs6cPvibNaePs296BLaLOg/4GJUUuKTlfyL5UORbj4qUEBVb0D
 GbrrDCAtYYm31YHxPVEHDe+O8Afcp8eBge7Fj43xOQ2eb0hBlG5UHDJbOYGvHubwG9KP
 /72pry5ssH/CjsXin6+Etlb6PuuT3yApJ8LLAFt+8NK9iv3XUiLUaTREXJF6AAEPPprv
 c8iQ==
X-Gm-Message-State: AOJu0Yx1RueGrzDmeWh9F2OX1XvfTpJHuPkFQUN63IlDVQcKIpzc/ofK
 SfhjXPj3/t0vmGsE1UREnIFaFMOPM0IeyAwf7iHqcnom7ntxrC6y+wPtSEN/3SHIQVlGJY2yQ1L
 w
X-Google-Smtp-Source: AGHT+IFlsMdzh7swGUWqfIBdOOH7l82G6vALI+qOwwxEe8BDpB2EfhFEaPItXQ7ZqhqzM+uxCr3t3g==
X-Received: by 2002:a17:906:bf4c:b0:a28:d1f9:976 with SMTP id
 ps12-20020a170906bf4c00b00a28d1f90976mr926406ejb.65.1706095376971; 
 Wed, 24 Jan 2024 03:22:56 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a170906289a00b00a2bd8953af2sm15247891ejd.55.2024.01.24.03.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 03:22:56 -0800 (PST)
Date: Wed, 24 Jan 2024 13:22:54 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 02/18] fwu: metadata: Migrate to version 2 of the structure
Message-ID: <ZbDzDv932QYnLsC2@hera>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
 <20240122115439.653871-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122115439.653871-3-sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, Jan 22, 2024 at 05:24:23PM +0530, Sughosh Ganu wrote:
> The latest version of the FWU specification [1] has changes to the
> metadata structure. This is version 2 of the structure.
>
> Primary changes include
>  - bank_state field in the top level structure
>  - Total metadata size in the top level structure
>  - Image description structures now optional
>  - Number of banks and images per bank values part of the structure
>
> Migrate to the version 2 of the metadata structure.
>
> [1] - https://developer.arm.com/documentation/den0118/latest/
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/fwu_mdata.h | 56 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/include/fwu_mdata.h b/include/fwu_mdata.h
> index 56189e2f40..050ee969e3 100644
> --- a/include/fwu_mdata.h
> +++ b/include/fwu_mdata.h
> @@ -11,7 +11,7 @@
>
>  /**
>   * struct fwu_image_bank_info - firmware image information
> - * @image_uuid: Guid value of the image in this bank
> + * @image_guid: Guid value of the image in this bank
>   * @accepted: Acceptance status of the image
>   * @reserved: Reserved
>   *
> @@ -20,15 +20,15 @@
>   * acceptance status
>   */
>  struct fwu_image_bank_info {
> -	efi_guid_t  image_uuid;
> +	efi_guid_t  image_guid;
>  	uint32_t accepted;
>  	uint32_t reserved;
>  } __packed;
>
>  /**
>   * struct fwu_image_entry - information for a particular type of image
> - * @image_type_uuid: Guid value for identifying the image type
> - * @location_uuid: Guid of the storage volume where the image is located
> + * @image_type_guid: Guid value for identifying the image type
> + * @location_guid: Guid of the storage volume where the image is located
>   * @img_bank_info: Array containing properties of images
>   *
>   * This structure contains information on various types of updatable
> @@ -36,9 +36,30 @@ struct fwu_image_bank_info {
>   * information per bank.
>   */
>  struct fwu_image_entry {
> -	efi_guid_t image_type_uuid;
> -	efi_guid_t location_uuid;
> -	struct fwu_image_bank_info img_bank_info[CONFIG_FWU_NUM_BANKS];
> +	efi_guid_t image_type_guid;
> +	efi_guid_t location_guid;
> +	struct fwu_image_bank_info img_bank_info[];
> +} __packed;
> +
> +/**
> + * struct fwu_fw_desc_store - FWU updatable image information
> + * @num_banks: Number of firmware banks
> + * num_images: Number of images per bank
> + * @img_entry_size: The size of the img_entry array
> + * @bank_info_entry_size: The size of the img_bank_info array
> + * @img_entry: Array of image entries each giving information on a image
> + *
> + * This image descriptor structure contains information on the number of
> + * updatable banks and images per bank. It also gives the total sizes of
> + * the fwu_image_entry and fwu_image_bank_info arrays.
> + */
> +struct fwu_fw_store_desc {
> +	uint8_t  num_banks;
> +	uint8_t  reserved;
> +	uint16_t num_images;
> +	uint16_t img_entry_size;
> +	uint16_t bank_info_entry_size;
> +	struct fwu_image_entry img_entry[];

This is a bit problematic. When a struct is defined using flexible array
members, you are not supposed to include it on other structs or arrays [0].
We need a way of working around this

>  } __packed;
>
>  /**
> @@ -48,21 +69,28 @@ struct fwu_image_entry {
>   * @active_index: Index of the bank currently used for booting images
>   * @previous_active_inde: Index of the bank used before the current bank
>   *                        being used for booting
> - * @img_entry: Array of information on various firmware images that can
> - *             be updated
> + * @metadata_size: Size of the entire metadata structure, including the
> + *                 image descriptors
> + * @desc_offset: The offset from the start of this structure where the
> + *               image descriptor structure starts. 0 if absent
> + * @bank_state: State of each bank, valid, invalid or accepted
> + * @fw_desc: The structure describing the FWU updatable images
>   *
> - * This structure is used to store all the needed information for performing
> + * This is the top level structure used to store all information for performing
>   * multi bank updates on the platform. This contains info on the bank being
> - * used to boot along with the information needed for identification of
> - * individual images
> + * used to boot along with the information on state of individual banks.
>   */
>  struct fwu_mdata {
>  	uint32_t crc32;
>  	uint32_t version;
>  	uint32_t active_index;
>  	uint32_t previous_active_index;
> -
> -	struct fwu_image_entry img_entry[CONFIG_FWU_NUM_IMAGES_PER_BANK];
> +	uint32_t metadata_size;
> +	uint16_t desc_offset;
> +	uint16_t reserved1;
> +	uint8_t  bank_state[4];
> +	uint32_t reserved2;
> +	struct fwu_fw_store_desc fw_desc[];

ditto

>  } __packed;
>
>  #endif /* _FWU_MDATA_H_ */
> --
> 2.34.1
>

[0] git show b10bfd0019f601
