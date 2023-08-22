Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FA0EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60838870CD;
	Tue, 22 Aug 2023 06:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tBW0Ou/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61C587111; Tue, 22 Aug 2023 06:04:44 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F59485F9F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-56a55c0f8b1so1240139a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677080; x=1693281880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKxaSceDKLHKv/Ckn8n2h/IMowM7RW4MvNqzr3f5wuM=;
 b=tBW0Ou/3ezohmdyegSw8uMUX5mgYjWZ6mKlfXJ5PQO4utTtHcRjMkL78Rp1wD9xN4g
 G10Fbd0JlMdpNmaVLQQCPJVASaZ5KQw9EjssZaaufD8A3YzRu6XwnLHZLPVfiytRqD3+
 rUNalonHbfV14sXk3Ao97f6IYkh8SST+p3sq/dIbJO8PuyoQuCFYjqdbpuZxbEg5xUQi
 GkzpB4rFg9lL896AwkTHY7SXqeLjo+t2osQ8AGPMia0WWhD2Qw27c1HLrzprgOX580Dy
 2D4cwKxPXQUefSBXg/T3B0rErzSsHerouSioTUgsnIom3e5sMBPpq6jh9Ec7sIXV2A2M
 U3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677080; x=1693281880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKxaSceDKLHKv/Ckn8n2h/IMowM7RW4MvNqzr3f5wuM=;
 b=j4IY3W98F/Jd2PS+zFexwEDspmiVtuKKcgqVXYzBUdBFFq2PY4gdLIRtGA/boSpN8I
 fxAJ70VNKu1ZXJ9nTaHLdynJ8gnQJpu8mr0pjNNZx+5ebcYIJVLvUAhie+3xpDMZvFmW
 bqvFT+eN/e2X2ROprzvXZUVOASHcIpCSqhEo3EoxwV2KpqmKwOWcUS5vdmINPFzALch4
 vDD05fyj/dyOK+wjtGsbODmNSTl1BBDMomOaYPw3Us3IpEYXC2qmevSaauke/cE/tHFR
 hIb25mPJZwDv1idHGf8YOznOosntjBHPLGSAGYOTktw7+RY55SM4epOLbQcwq1/M2NOy
 jquw==
X-Gm-Message-State: AOJu0YxkF/NqaZTlZbq6Vrr8sJmlOdlQHttjkcFX50NdErc6DGau7t+U
 eHNIivs55iXoa2IdOT9T9Io49w==
X-Google-Smtp-Source: AGHT+IHNg/RJ8LHYNI6AuITZHY9oZfnSByvf5pCmBq2ayi2NXkk/yqUJkKLXwZWXy+WYM0XwHGVHcA==
X-Received: by 2002:a05:6a20:296:b0:147:d592:491 with SMTP id
 22-20020a056a20029600b00147d5920491mr5940826pza.33.1692677080309; 
 Mon, 21 Aug 2023 21:04:40 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 az2-20020a170902a58200b001b893b689a0sm7819851plb.84.2023.08.21.21.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:04:40 -0700 (PDT)
Message-ID: <2402409b-db99-3b8a-9e0f-7cfed76f04d8@linaro.org>
Date: Tue, 22 Aug 2023 09:34:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 3/7] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-3-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-3-marek.vasut+renesas@mailbox.org>
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
> Add UFSHCD_QUIRK_HIBERN_FASTAUTO quirk for host controllers which supports
> auto-hibernate the capability but only FASTAUTO mode.
> 
> Ported from Linux kernel commit
> 2f11bbc2c7f3 ("scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO")
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: Use BIT() macro
> ---
>   drivers/ufs/ufs.c | 9 +++++++--
>   drivers/ufs/ufs.h | 6 ++++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index da0550d98c6..261ae2843c2 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1631,8 +1631,13 @@ static int ufshcd_get_max_pwr_mode(struct ufs_hba *hba)
>   	if (hba->max_pwr_info.is_valid)
>   		return 0;
>   
> -	pwr_info->pwr_tx = FAST_MODE;
> -	pwr_info->pwr_rx = FAST_MODE;
> +	if (hba->quirks & UFSHCD_QUIRK_HIBERN_FASTAUTO) {
> +		pwr_info->pwr_tx = FASTAUTO_MODE;
> +		pwr_info->pwr_rx = FASTAUTO_MODE;
> +	} else {
> +		pwr_info->pwr_tx = FAST_MODE;
> +		pwr_info->pwr_rx = FAST_MODE;
> +	}
>   	pwr_info->hs_rate = PA_HS_MODE_B;
>   
>   	/* Get the connected lane count */
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index e5ddb6f64a9..638c10b5503 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -725,6 +725,12 @@ struct ufs_hba {
>    */
>   #define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		BIT(1)
>   
> +/*
> + * This quirk needs to be enabled if the host controller has
> + * auto-hibernate capability but it's FASTAUTO only.
> + */
> +#define UFSHCD_QUIRK_HIBERN_FASTAUTO			BIT(2)
> +
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;
>   	struct utp_transfer_req_desc *utrdl;

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
