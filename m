Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5591AC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F101880E06;
	Mon, 27 Jul 2026 13:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v62ULYp0bk5M; Mon, 27 Jul 2026 13:03:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D84E80DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785157428;
	bh=KnWrZfLlloaoXkj9/R9ccPdzzFRxSkUB7IFHiQr/tQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGoxEhhzP0XrbBR8NN8MrdtNrcXtLdEEQ5xRso2+viAEDbFtaYpckdEGaQanPqkLY
	 LdCCEzBMPwJdiUW+UvHOtAd7fa0QYL4JK98SOSaq6BZYs2ZxXDX5GQSHTA2UTOdrLA
	 8zUlxqSCbLZinX4P2gLMfraEb28f5Hun82kYQ4Ji9xEX5RVDVeEmX7jvyFsqOUnvSf
	 vhlkVGDAbsP6DKNDc731brmHcIln7pTwd9i+faW1OlTtHB9umw3OVjAH99HnOYHM8r
	 zWuCx00uknPzwP22VbziLo0Ed2IYgh9dQfA6ufZBsl5iFUnJ3v1ns/tUJGoImd9D+7
	 wUVN8pBwU416Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D84E80DF8;
	Mon, 27 Jul 2026 13:03:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67B65194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 561C080DEC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGvwRMQvsyxJ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:03:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 216DB80DEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 216DB80DEA
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 216DB80DEA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:03:44 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so4243547a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157423; x=1785762223;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KnWrZfLlloaoXkj9/R9ccPdzzFRxSkUB7IFHiQr/tQs=;
 b=sge+Z39Lo1UdxSZ16uYR+Ioa7stZA6AjEXvIgBiqCYypYWiCtD4Ozx2AIhND71UEsZ
 kX3Yzolcjlxyf3VPfvWQdrTyGIM2FVP10+ss7BA995jOi2i9zOa27+5uB9RkvpNGvJwS
 5DPBv3aNgoYzioLZhNKvo1QKHS2sZiuv2vwGH/XJQckYx8efIOMjFl1wAinFB+WAa9M9
 VxkWDMuCuYqijS5R1Hak8uyDdfWcbmgTXFGlnp0RoIpOIEQIS5Glm0WhQQMhbbFa13x4
 TyYgUIu8CRemzggsB6ztCclJ9soilf14Yr+gTEO1iS1hNBuXZCP2kWUNxn0fZ7PRShSo
 Tk0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTT6R97owOo3yPPZLZbYoDPQ/yEhrhWTk+PBcpQ/Iaj6yitHiExz//A+HN5r9VhdVwWNfMlR4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzGC2o7EhFAmYHnl1riQPWqw64CL9NxVj//EjuKRgF06oCX++M1
 MAfnnbY74zsnSzPvDDvtZCaEdhlHGMRyx1k/cYD0fZGPMZxPs6DiNgo0RK6F2OkNwB0=
X-Gm-Gg: AR+sD10eI7H938xYZqtC3rYwmKCjFCMV4T8nVTkUmfOYVGmSBiFBMVSaFp4UvJesbmj
 pmkSNzS8GpwhsEWDLe+zYMwGRZsB3H1/xzn2hIUe2OU5+fIfJ5fk4NON7OgKlTFzkKDC4KHBSnn
 Ijccsk5fxBbJ4A/VLHL1MwVGVgAp+Af8NQnX1t5pMpf88lm+VG26g6anutuXA1S3C7ZWHbe3f6G
 9q7xYAgi5vHjTnjit+9K5LNywPBYQ4Lhasb60huUvmaBP6Tztd1qS8sZL8Yg2d4PgLb0Q2t3ACx
 8aYY+KkzT537mOKKzi67uWMsC8D6+GKI4mPAPwcjOQN7UWQvFpKh68nc+kTbCD7f+wlCTfMXNyz
 OenDVm9RxO3crDmQWxt0ksSWhy7ofppAG2GYVg3nYRRKFW6McPyuM5eDuDnKEf9rXmLpqisUV2Y
 r79EYMFavfSqbiL0FYDFteZ/4JQ1nYNiQihKLPs64jYw==
X-Received: by 2002:a05:6402:24da:b0:69a:596f:ba0d with SMTP id
 4fb4d7f45d1cf-69fc116857dmr2518170a12.33.1785157422598; 
 Mon, 27 Jul 2026 06:03:42 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a0002fa679sm1018179a12.6.2026.07.27.06.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 06:03:38 -0700 (PDT)
Message-ID: <8ce66d77-96d6-4574-a1a5-d3442d2233c6@linaro.org>
Date: Mon, 27 Jul 2026 15:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] mach-snapdragon: spl: Add support for MMC
 booting in SPL
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>, Anshul Dalal <anshuld@ti.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>, Jens Reidel
 <adrian@mainlining.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-5-cbfa79e85a9d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260722-spl-v8-v8-5-cbfa79e85a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785157423; x=1785762223;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KnWrZfLlloaoXkj9/R9ccPdzzFRxSkUB7IFHiQr/tQs=;
 b=VXCIgrPu/aD5GOqFlQ2t1wisrxZ6i8JoHB9LHSjWAMqI8IQ5ouY31uP+ppPA0mp/xd
 a2WwmSb9DkRIzNOcuka7NUfyFEr/Hg4qjDpeqEKwSvmcT0rGlHxrvwK1e8PDcBKd7ZAn
 4sz1ae1S+BuHYIGu6ZXASsbWT30YtIFKU/JpJKDofdvuBCnMJ//c4kQzvKlqe1TBZtjH
 tPjOPmh2/wn4gz09HQNxOCTl/NhyokV7fLVzuidUef2phTGC2iJAQUp5CIwvMkEtNIJa
 nBEFNx4IBRmLIBaMHETvglmYcFt+wJMpT0dOoRtEXydx7ln7adKmwCsKVWF2PhIwS+aP
 WZWQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VXCIgrPu
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 22/07/2026 09:41, Varadarajan Narayanan wrote:
> Add routines to enable U-Boot SPL to be able to proceed with the boot from
> MMC partitions.
> 
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c | 107 +++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
> index 69a32e5d8cf..c5e86458616 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -131,3 +131,110 @@ static int qcom_spl_populate_smem(void *ctx)
>  	return -ENOENT;
>  }
>  #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
> +
> +#if CONFIG_IS_ENABLED(MMC)
> +
> +#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
> +
> +/**
> + * spl_find_partition_info() - Find partition information by name
> + * @uclass_id: Device class ID (UCLASS_MMC)
> + * @device_num: Device number within the class
> + * @part_name: Name of the partition to find
> + * @info: Pointer to store partition information
> + *
> + * This function provides partition lookup logic for MMC.
> + * Return: Partition number on success, negative error code on failure

What's missing in the mmc/part framework for this? This "helper" is
called once and doesn't really seem to justify itself, please elaborate.
> + */
> +static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
> +				   const char *part_name,
> +				   struct disk_partition *info)
> +{
> +	int ret;
> +	struct blk_desc *desc;
> +
> +	if (!part_name || !info) {
> +		printf("Invalid parameters for partition lookup\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Get block device descriptor
> +	 */
> +	desc = blk_get_devnum_by_uclass_id(uclass_id, device_num);
> +	if (!desc) {
> +		printf("Block device not found for class %d, device %d\n",
> +		       uclass_id, device_num);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Initialize partition table if needed
> +	 */
> +	if (desc->part_type == PART_TYPE_UNKNOWN) {
> +		printf("Initializing partition table\n");

Not sure if I even want to know what this is a workaround for, why can't
this be fixed in the proper place?

> +		/*
> +		 * Prefer EFI/GPT
> +		 */
> +		desc->part_type = PART_TYPE_EFI;
> +	}
> +
> +	/*
> +	 * Find partition by name
> +	 */
> +	ret = part_get_info_by_name(desc, part_name, info);
> +	if (ret < 0) {
> +		printf("Partition '%s' not found\n", part_name);
> +		return -ENOENT;
> +	}
> +
> +	printf("Found partition '%s' at partition number %d\n", part_name, ret);

debug()
> +	return ret;
> +}
> +
> +/**
> + * spl_mmc_boot_mode() - Determine the boot mode for MMC
> + * @mmc:	Pointer to the MMC device
> + * @boot_device:	Boot device ID
> + *
> + * Return: MMCSD_MODE_RAW to use raw partition access
> + */
> +u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> +{
> +	return MMCSD_MODE_RAW;
> +}
> +
> +/**
> + * spl_mmc_boot_partition() - Determine which partition to boot from
> + * @boot_device:	Boot device ID
> + *
> + * Return: Partition number to boot from, or default partition on error
> + */
> +int spl_mmc_boot_partition(const u32 boot_device)
> +{
> +	int ret;

this can have a better name than "ret"

> +	struct disk_partition info;
> +
> +	ret = spl_find_partition_info(UCLASS_MMC, 0, QCOM_SPL_FIT_IMG_PARTITION, &info);
> +#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)

This entire function isn't even called unless this config option is
enabled, so you can drop this. compile time conditional error checking
here is incomprehensible

> +	if (ret < 0) {
> +		printf("Using default MMC partition %d\n",
> +		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
> +		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
> +	}
> +#endif
> +	return ret;
> +}
> +
> +/**
> + * spl_mmc_get_uboot_raw_sector() - Find the raw sector offset
> + * @mmc:	Pointer to the MMC device
> + * @raw_sect:	Sector
> + *
> + * Return: 0 if the image is at the starting of the partition without any offset.

this function API is already documented in the header (same for the
others in this file), if you want a comment (definitely nice!) then
write a normal one not a doc comment that just rewords the existing API.
This is noise.

> + */
> +unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IS_ENABLED(MMC) */
> 

-- 
// Casey (she/her)

