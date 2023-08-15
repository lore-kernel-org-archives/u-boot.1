Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50502C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57AF8692F;
	Tue, 15 Aug 2023 22:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PeBwoXqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B96D8697B; Tue, 15 Aug 2023 22:04:37 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA96F867E2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686bc261111so4027614b3a.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129872; x=1692734672;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/y/vhsQiN5KOEpgmGXnp63tBJTDTzLr++AXmPVTW0Cw=;
 b=PeBwoXqnhJr7fsXVy+VXq4nukUKPaPErVsVM+I9e/93eoBw2r3Y+i34flW4IxpGmj1
 5kffauvgdTMO86Rte0whOlxl/H67RhLrgrEK4x9MmQ9q6j4q46BLG+QsW+cdc8WcZ5Pc
 T5d7qmExhGkvOZmhRNUbfMTuYtE1IGCTwcOq/in+0AsP6AhMskVqzVCotx8r7zGhgjuq
 L+8SQg7KvobY1cWoDCn3LHRF53J0wCr1R2TeupYuy940mOZ2zC0p/ezSpcOVbSX55Oot
 WqTVemFLE2KNuo7ouyty3hodawOEhttdeRqGB71MYSVUk1ic+gPH5f2sWHikQT8NTSb2
 +zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129872; x=1692734672;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/y/vhsQiN5KOEpgmGXnp63tBJTDTzLr++AXmPVTW0Cw=;
 b=doIEIzqyzE/txwN5WGEGtvgkplrkXmRoD/Zir0nRVjZT9IYxLKPW9tXjG5E0uRpEzf
 F5NYXckAuP4M/1KVtdz4a9mGj2CauOE1cVVv4sbq8nYCMo5EKyqp9vJUp0xLQuQ1+c9a
 fgIIjodOH4BxgsFF5Hm2cBtnqPktxFCRojL1W8TFzBMPfJYHzdG0XTXZ7OF7rc1cs27j
 VvZynF37kKSl2D738Jh5ZlSnvSgM7QuZxVMWWUTXiBHiL0aNLHkPMs0VmQvN0USpngK8
 XfX7glwYSARo6XPW0MToMYo6HwH+o/uQyZREBR4PQgqjZXr7fIAkJjhPEp43/90AYimO
 CrYQ==
X-Gm-Message-State: AOJu0Yyohgl7e8dCcVfM4l5XCcgZw6oNTHe1OSO383m0YiV+NbAd/xTq
 FxwUSLpr6s35Y3GHEF2lC3KMyYattfwmo5IgDT4=
X-Google-Smtp-Source: AGHT+IF23QGEMZxwy+rG1Rfs0Rs35M9g6hSBoRtoa8UQ0ScxO2YUWddpZzY1AvIou+m1RvngvXl7EA==
X-Received: by 2002:a17:90b:1117:b0:268:ee6:6bdf with SMTP id
 gi23-20020a17090b111700b002680ee66bdfmr10333801pjb.47.1692129871930; 
 Tue, 15 Aug 2023 13:04:31 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:6581:8508:2ecb:b5dd?
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a17090a950e00b0026b4d215627sm4643424pjo.21.2023.08.15.13.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 13:04:31 -0700 (PDT)
Message-ID: <0dc7875e-ecdb-27e3-4234-1e09a9e27a20@linaro.org>
Date: Wed, 16 Aug 2023 01:34:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/6] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Marek,

On 8/14/23 5:22 AM, Marek Vasut wrote:
> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
> support 64-bit addressing.
> 
> Ported from Linux kernel commit
> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   drivers/ufs/ufs.c | 26 ++++++++++++++++++++++++++
>   drivers/ufs/ufs.h |  6 ++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 3bf1a95e7f2..da0550d98c6 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -8,6 +8,7 @@
>    * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>    */
>   
> +#include <bouncebuf.h>
>   #include <charset.h>
>   #include <common.h>
>   #include <dm.h>
> @@ -1889,6 +1890,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   
>   	/* Read capabilties registers */
>   	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
> +	if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
> +		hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
>   
>   	/* Get UFS version supported by the controller */
>   	hba->version = ufshcd_get_ufs_version(hba);
> @@ -1942,8 +1945,31 @@ int ufs_scsi_bind(struct udevice *ufs_dev, struct udevice **scsi_devp)
>   	return ret;
>   }
>   
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +static int ufs_scsi_buffer_aligned(struct udevice *scsi_dev, struct bounce_buffer *state)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> +	uintptr_t ubuf = (uintptr_t)state->user_buffer;
> +	size_t len = state->len_aligned;
> +
> +	/* Check if below 32bit boundary */
> +	if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
> +	    ((ubuf >> 32) || (ubuf + len) >> 32)) {
> +		dev_dbg(scsi_dev, "Buffer above 32bit boundary %lx-%lx\n",
> +			ubuf, ubuf + len);
> +		return 0;
> +	}
> +#endif
> +	return 1;
> +}
> +#endif	/* CONFIG_BOUNCE_BUFFER */
> +
>   static struct scsi_ops ufs_ops = {
>   	.exec		= ufs_scsi_exec,
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +	.buffer_aligned	= ufs_scsi_buffer_aligned,
> +#endif	/* CONFIG_BOUNCE_BUFFER */
>   };
>   
>   int ufs_probe_dev(int index)
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 8a38832b05f..070db0dce68 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -719,6 +719,12 @@ struct ufs_hba {
>    */
>   #define UFSHCD_QUIRK_BROKEN_LCC				0x1
>   
> +/*
> + * This quirk needs to be enabled if the host controller has
> + * 64-bit addressing supported capability but it doesn't work.
> + */
> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
> +
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;
>   	struct utp_transfer_req_desc *utrdl;

For this and the follow-up patch, I think implementing or at least 
supporting all the quirks currently supported by the Linux UFS driver 
makes sense as newer controllers do support these quirks.

Accordingly I had sent: 
https://lists.denx.de/pipermail/u-boot/2023-August/527217.html

So, I would suggest that we pick these two patches and then I can send 
my patches rebased on the same, but change the .h to support all the
possible UFS quirks currently supported in Linux so that subsequent 
patches can utilize them in u-boot - which I plan to post next.

Thanks,
Bhupesh
