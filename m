Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDB8C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2C3867E2;
	Tue, 15 Aug 2023 21:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mRALY8yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F8A8692F; Tue, 15 Aug 2023 21:58:00 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1330486785
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so3850520b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129476; x=1692734276;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xMtplFwz8fglQt+ZAxNrx7Y2jVU4SaFtYsZineT5UeI=;
 b=mRALY8yryYY/snB6nSqghdXE2EhXLywxFCMY7ase9z/g79fIvlF5z45WXXAO5WoH/H
 A8bwdxwLmRNkgginLY7VAyqIgrYjYnv3OEJhIB3rfa5uYaFrnsYptUCP1bV5Pcy1Sk1s
 RTPmoZiHBHXnXvms+Nxff9bhtaskLUEJ5r/6bp8BCaMEA/eOiJ8spEmDGoLAN0OPGiTa
 L/R0Kxf1sh0VOxEdZG7UHOGHBd8FoP2xTfL0fTODu/CqvZPpBCM+ia6VWwivuARhlvFS
 Z7J8atBQsp45NRBnPFLw3j3jdbEAjHgjbK1hk2s2qankDipYz9v9ElEwvcodLIOuH1i7
 um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129476; x=1692734276;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xMtplFwz8fglQt+ZAxNrx7Y2jVU4SaFtYsZineT5UeI=;
 b=WzDj5kA1D/qmpWeySyEwBXuLpc5nEFLO/508jjykPu2PGdHx9h1kkPuo1g7R1CEPaO
 qffdNJGc1Jjz6RfKgqvpuzccpJscyR+D/upIXdeD4aQeU9LtaSqOFK6PLTokr1pEwCgf
 RkXsoByFa6kQO3sztDpVOsla6y0ovpNU1Gji8dWfirBTfd3SguWfbZWy+aOsln5ZLgP5
 s2SJ9hH/X/uMkqvVdmRcPSP9qSNsyep5L6TTwQ8gRRk1aNz/W1sweAu7lsKv4y9pE+9l
 1kg9hOKuLobxLCxfG7HNpNqN5jGkP9TOpVqNtPPlVNOzKcYn3xC0teduY5+I6rDBEpgM
 GVoA==
X-Gm-Message-State: AOJu0YzvSa9XpqcTBKT7K4Q0civKEPWF80UGVBgFDPFNfdxTm0NexiLb
 GzeZML0tbXm+YRlzxlLgprkXP4oYcBFlraPaYx8=
X-Google-Smtp-Source: AGHT+IHocH0thFubzAWgeSX2kSIgW4eeWG2IlCh25JVCjkJ1NlZe4FUfpTkWFQnD782q1L6UXgWEUg==
X-Received: by 2002:a05:6a21:3e0b:b0:137:3eba:b7fb with SMTP id
 bk11-20020a056a213e0b00b001373ebab7fbmr10839839pzc.2.1692129476454; 
 Tue, 15 Aug 2023 12:57:56 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:6581:8508:2ecb:b5dd?
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 x42-20020a056a000bea00b00684b64da08bsm9716017pfu.132.2023.08.15.12.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 12:57:56 -0700 (PDT)
Message-ID: <d2e3f423-0110-6980-baa9-d3a4ea1391af@linaro.org>
Date: Wed, 16 Aug 2023 01:27:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/6] ufs: Pass hba pointer to ufshcd_prepare_req_desc_hdr()
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-4-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230813235231.591454-4-marek.vasut+renesas@mailbox.org>
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

On 8/14/23 5:22 AM, Marek Vasut wrote:
> Pass the hba pointer itself to ufshcd_prepare_req_desc_hdr()
> instead of duplicating utp_transfer_req_desc access at each
> call site. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Faiz Abbas <faiz_abbas@ti.com>
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
>   

Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
