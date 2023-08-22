Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51413EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8101866D0;
	Tue, 22 Aug 2023 06:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cgpIonUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7BA85F9F; Tue, 22 Aug 2023 06:05:50 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C60D871C3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26d60f27491so1502873a91.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677146; x=1693281946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P4adaoUVxKH4RjkTaMa9cunVsAN73Awv9XzotUjr2ZA=;
 b=cgpIonUSePWovuPK/6YwKUvVlCRxr8NbdM4Ju7SRYSdSn72H9SYlr+4qXAaxYEt4tS
 RmbuD0kooXPrfxrgKDfJ8LBXBzzRA+19rQKVyU80k2CgGDpyMNWyGbr7X7eIUTTLteSE
 L3x7qEd34OsNdJqMWbtMrkUN+0GXa3kq0UmcUxt3YmXP5w4XMfvxjMzMm7jmk7xlwoG/
 26JedWx1RjsS3M/GRBSpp7bIAtOO2CWfi8baB4QmPK/7B2YlbteaPk2DWIqzIZ3QahrP
 rZ103qV2WEBE2MPFHNZ5cQ8kFxl3ssZsQqoL3I06UGadGayAaXK+YHoqVJZZaa+bUpkg
 64RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677146; x=1693281946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4adaoUVxKH4RjkTaMa9cunVsAN73Awv9XzotUjr2ZA=;
 b=ZfiKRBIw2UA4D4Hwvqf56yrOE4etZbabIweLU61Xy05mX8SMVH4+Pstj3C3pOZV7VN
 H6V003hb1rbX91ITZNclX+etYOB1X1cG6+1W+y60x3uzhyyW3iR3Rhu4IXGdszhTDM4L
 3XDfm91+6Ln30gZtShJdWtDbVjyRfuRewidaXIj0/YE7njMklJr2ako5e4Umst6T9SRg
 2LfCHPhuPpTZOPijhRzmJKWz6sG/9fcSoqwmtensfC4Jl1HvxrFLduNmkN4uiYXBc+pg
 PzQXbAbKwxPkCI3ZnreBtu784Ht1cMdeoJP15vha8enKA9/bI7M8lI2C5BezOnTee37q
 YjMA==
X-Gm-Message-State: AOJu0YweNwov2q9qUMw0Thwo5D/e0tTpXPcAvin/tkz4aAW9JAw2X+e9
 h+6fA/pvTmrkm5jkiHb/hlBuKA==
X-Google-Smtp-Source: AGHT+IHcRELFc3OBtac8vWo8sIpRFnHam+NYg0eqvqqeJFGrCvGwvxqRLi1F/gaOQQCLfGj8pY0CUg==
X-Received: by 2002:a17:90a:a002:b0:269:3498:3bad with SMTP id
 q2-20020a17090aa00200b0026934983badmr5141353pjp.14.1692677146263; 
 Mon, 21 Aug 2023 21:05:46 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00264040322desm7437072pje.40.2023.08.21.21.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:05:45 -0700 (PDT)
Message-ID: <adcabbd0-5d5d-1bb9-8a53-576866965b42@linaro.org>
Date: Tue, 22 Aug 2023 09:35:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 4/7] ufs: Handle UFS 3.0 controllers
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-4-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-4-marek.vasut+renesas@mailbox.org>
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
> Extend the version check to handle UFS 3.0 controllers as well.
> Tested on R-Car S4 UFS 3.0 controller.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: No change
> ---
>   drivers/ufs/ufs.c | 3 ++-
>   drivers/ufs/ufs.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 261ae2843c2..58830c8ddca 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>   	if (hba->version != UFSHCI_VERSION_10 &&
>   	    hba->version != UFSHCI_VERSION_11 &&
>   	    hba->version != UFSHCI_VERSION_20 &&
> -	    hba->version != UFSHCI_VERSION_21)
> +	    hba->version != UFSHCI_VERSION_21 &&
> +	    hba->version != UFSHCI_VERSION_30)
>   		dev_err(hba->dev, "invalid UFS version 0x%x\n",
>   			hba->version);
>   
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 638c10b5503..9daaf03d222 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -781,6 +781,7 @@ enum {
>   	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
>   	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>   	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
> +	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
>   };
>   
>   /* Interrupt disable masks */

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
