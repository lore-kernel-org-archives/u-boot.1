Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7081EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6AA866D0;
	Tue, 22 Aug 2023 06:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y2MOEbmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C1C85F9F; Tue, 22 Aug 2023 06:07:56 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BFD871DC
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-570deae2594so792679eaf.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677271; x=1693282071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+dFHqdXG5kCw/p/axLSU2rJ6f+i0R8z9xBSc7b9umt8=;
 b=Y2MOEbmtX+p/kvA5G6Gki8bAtDMxItbYWsPeROx0pSllI2cIfV7+XdN3TxeRNFjWvO
 92pomRaLNILwUakqyGg3tQsTLjSLU6wiW0qvrLjSIP2uumKugIKLyO55GanmB8P4NCmj
 yZPnKDU4OtgfxfehBRgVew9s/uizKVp189UFQ7JW8q7q0lEQJGuYloOe+FbtL6jriHwl
 2jj3yiIvuEz1gClg13cJvtUU3VmbZj8M+w7li41G0+Uszep7NzSwRCWYp9ybIXAq50eQ
 4Tj8dmlZlTBnpBoQdX2SE6feakvL6zIkP8IXsMzvdw40yaCy/BNZp11y3BwObIsr4HLA
 bxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677271; x=1693282071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dFHqdXG5kCw/p/axLSU2rJ6f+i0R8z9xBSc7b9umt8=;
 b=YTdj5qgXx83EJW1Go2u5GpxlAf+JeMiOI+BL5HBtkctTv6glRrpKNM+nC3t6vGvhG7
 XSacHmwSQcFrAGcCrUmeuy+pnxaFIQ+OyHUAmwN4QjRuMokzzJgBUMF937vEPAejHGvM
 1gdJOo3CWhHt/P3vyVFVbmr/zVohhk774Ju0YBCgIx3jkTXCYW3BrtKuNTPOP1vjTXcA
 llAzOM2eX69ubri2KXO2MRW0JdwfoovBHHWCqRflHa4pOBmHwXGBuCdvGKmdaSy67sg5
 44+MvCbfRVNZLgZEckJPWBS2kPFqPHQtPqd127Bwqc9p5NflCzyZGHBZqKQtIIIKyhDF
 CGUg==
X-Gm-Message-State: AOJu0YynXK1P93cDqZXhINq6fosE3Gy9uCNamy2AfIePez86iartWdM/
 A2OBEIrkJNlgbcL4OWfekWr6vQ==
X-Google-Smtp-Source: AGHT+IFmwKCi3qi1/IrldqEWIwnECBGapVusKg4NoWhFORSs5c4kQFBq70JNLbENssFdSio6RtTN6w==
X-Received: by 2002:a05:6358:2921:b0:134:cb1d:6737 with SMTP id
 y33-20020a056358292100b00134cb1d6737mr7533209rwb.7.1692677271467; 
 Mon, 21 Aug 2023 21:07:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a63af44000000b005641fadb844sm6935133pgo.49.2023.08.21.21.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:07:51 -0700 (PDT)
Message-ID: <a90fa754-b0b0-bce2-d517-53e82fb63661@linaro.org>
Date: Tue, 22 Aug 2023 09:37:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 5/7] ufs: Pass hba pointer to
 ufshcd_prepare_req_desc_hdr()
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-5-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-5-marek.vasut+renesas@mailbox.org>
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
> Pass the hba pointer itself to ufshcd_prepare_req_desc_hdr()
> instead of duplicating utp_transfer_req_desc access at each
> call site. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: No change
> ---
>   drivers/ufs/ufs.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 58830c8ddca..da1009e2c14 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -696,10 +696,11 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
>    * ufshcd_prepare_req_desc_hdr() - Fills the requests header
>    * descriptor according to request
>    */
> -static void ufshcd_prepare_req_desc_hdr(struct utp_transfer_req_desc *req_desc,
> +static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
>   					u32 *upiu_flags,
>   					enum dma_data_direction cmd_dir)
>   {
> +	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   	u32 data_direction;
>   	u32 dword_0;
>   
> @@ -793,11 +794,10 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba *hba,
>   {
>   	u32 upiu_flags;
>   	int ret = 0;
> -	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   
>   	hba->dev_cmd.type = cmd_type;
>   
> -	ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, DMA_NONE);
> +	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, DMA_NONE);
>   	switch (cmd_type) {
>   	case DEV_CMD_TYPE_QUERY:
>   		ufshcd_prepare_utp_query_req_upiu(hba, upiu_flags);
> @@ -1449,12 +1449,11 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   {
>   	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> -	struct utp_transfer_req_desc *req_desc = hba->utrdl;
>   	u32 upiu_flags;
>   	int ocs, result = 0;
>   	u8 scsi_status;
>   
> -	ufshcd_prepare_req_desc_hdr(req_desc, &upiu_flags, pccb->dma_dir);
> +	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>   	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>   	prepare_prdt_table(hba, pccb);

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
