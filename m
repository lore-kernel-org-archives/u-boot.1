Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9360FEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB79871DB;
	Tue, 22 Aug 2023 06:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c5ibPi1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C477F871E0; Tue, 22 Aug 2023 06:03:29 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED5E86993
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a56401c12so1026821b3a.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677005; x=1693281805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l6fY/SH26F4JRTMHj9eSURXJ18P8rEyYf9tE9OboNHc=;
 b=c5ibPi1S7jReSOH4+IwZPVabxbZDE5TeWZWXDsoTcW78KdbgximQrg2JMXQ8HsYySy
 ICD0miuQeeCiYOd553Vf+ajjgikguWWjPHhfNIXcfrDF8R62DYMil6EemFrkxYLtKWsd
 KyIbu92m+BfDnU+sx0nG7ic8X3JrZGV5xh8yZOHtSKlz0OJzNxjMIFMcOXnmmU6Hl0BN
 bTtTNsza7l26AEEY7NeQ/f5bZnm0NP5WyCDVD4Y5xB0NQWw3rbM4+EGzMj2JMNFkOclk
 RwXnonU3NGK5fhOOrMVO3zb5vUrNDV3tsiKS4unu20WyJMZpYcXSDNWa/0w1tYCMAnCK
 GoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677005; x=1693281805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l6fY/SH26F4JRTMHj9eSURXJ18P8rEyYf9tE9OboNHc=;
 b=RAzlEip0z3f2saTvhLdvpnZsc9WjfRpmPpEtt5JMNIO75q16kdcjIkfbo1r3K72uUF
 MqjeW/r+nvf59Xok9lHgveH6TrkcvpUhgBSJzWkxJJfLlHSaXlkFUwdQkz8ttXsfs1x+
 iyp3E1ph512TqyOfP4AzttmWPDJxF2CoaetOYIQ5Af18LxSt0PBpuE2NvGqQttcVpecF
 SmSfRUvcbPubZTejEG/vnAQFjgT5wdSCBbUQu3WiZtlASFK1bC0XSsiGwssMOzt4OTA/
 11ec6AbakjkAVBiMWPuR27I3O8QC1OJ6yKBOnxIDkUUkUDwr1qECtTvT+KgB7CIHNcEK
 ENYw==
X-Gm-Message-State: AOJu0YxzSPTDTK36WtsLfQUHS9Meps7jxwW6EJQN51SvSGev1nkAvy1i
 Hx7EOeWbgyZw015VgczuMojFhw==
X-Google-Smtp-Source: AGHT+IGahwOz7CfXfwgFvF0cUt4iQa0eAZRzAgYBC98Cje+Gey+StCrILXb/t0GtAtyrPQ3m99p5YQ==
X-Received: by 2002:a05:6a00:124b:b0:68a:582b:44c4 with SMTP id
 u11-20020a056a00124b00b0068a582b44c4mr3086056pfi.3.1692677004820; 
 Mon, 21 Aug 2023 21:03:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 a2-20020aa780c2000000b00688214cff65sm6856263pfn.44.2023.08.21.21.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:03:24 -0700 (PDT)
Message-ID: <694338e6-8b1e-6346-84c3-041921c462b1@linaro.org>
Date: Tue, 22 Aug 2023 09:33:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/7] ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-2-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-2-marek.vasut+renesas@mailbox.org>
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



On 8/16/23 8:35 PM, Marek Vasut wrote:
> Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS for host controllers which do not
> support 64-bit addressing.
> 
> Ported from Linux kernel commit
> 6554400d6f66 ("scsi: ufs: core: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS")
> with ufs_scsi_buffer_aligned() based on U-Boot generic bounce buffer.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: Use BIT() macro
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
> index 5a5c13aefdf..e5ddb6f64a9 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -719,6 +719,12 @@ struct ufs_hba {
>    */
>   #define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
>   
> +/*
> + * This quirk needs to be enabled if the host controller has
> + * 64-bit addressing supported capability but it doesn't work.
> + */
> +#define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
> +
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;
>   	struct utp_transfer_req_desc *utrdl;

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
