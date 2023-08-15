Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A996C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82885867E2;
	Tue, 15 Aug 2023 21:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uyrk0ve7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD168697E; Tue, 15 Aug 2023 21:56:49 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2D386785
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so3896761b3a.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129405; x=1692734205;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S2U5fhtGR+uIQ1AHFJHDDQNrH9XcMsxDIyAGsZkIuMA=;
 b=uyrk0ve7byTDRKUFWuVob9WALZPPHXd9oddnemXM5ojwbvdsrhnUjflSHLNYQsD8CQ
 92fqn2ENjHcd13/ofN4jOs8ZyQyS9cvQMBjej6y3186rbXXk8bpW9ldCivUeEOJ5U7eZ
 PcWG18q0/h6Wm2oh8n8Od8bOtRrd6t/dRiWrtDPXNHIq9tSIejndXskq8PCofOcyJkTh
 9tdo9eCu1qhGOxr4r7JuVlGZTtKgs/zS7POvcuD+cK+kn2WLi0fDFlgO6Dr1czsZFVPV
 2Kbv0LKC5gbTwn7IXSYutfWIY/mcsxylqgXhGZ1GcWjrf6e78WE3EKwTODY0Hybq0I/6
 cUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129405; x=1692734205;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S2U5fhtGR+uIQ1AHFJHDDQNrH9XcMsxDIyAGsZkIuMA=;
 b=jIPTHCPYEWA6ZS4FLrKxRe1gpRwJwr5JC8u4XZUCk47C8A4Ej+4QiIaTUY8gIu4Cg3
 O6NW4UWvHPc0mYQb3lM/wGjzPbSrohehwTUF3SDZmFKe+PyFWS4pWSU9v6smsEed2n9h
 qd23H0edoBHUQjvCYMP4IkyeZ9f1g95GXOXE/U7w1zR442vZ6fi6n6sAcqmBMU3hpRJF
 bPJGzDsFvC8+XKRYm8W+Gv3RymQk6UOTYYxFxzh1JWUhjoIsWVo1QLuCiUgA1a1wm/Gh
 WofLasMRy8sIR0iiwZgrOsqekTU3fqIWhTr4Spwe89/hoprc4SXMr/exCym3D+J/FI3a
 HdFw==
X-Gm-Message-State: AOJu0Ywzaa2GAmNw/5SkJIeoBUnUZConCOhbF3N27adD5r9ALEFyl2JL
 ovLi1Iy1TssGrJEPb4+jFkfWTXXwnyIABm5oXi4=
X-Google-Smtp-Source: AGHT+IEkFKxzWNMUjXF/QvOyrF4WXwbNNH9vDWsByBqqePzO1IXGkwhnodAf8FrZYRIXfutT5+ZCbQ==
X-Received: by 2002:a05:6a00:2e96:b0:666:c1ab:d6e5 with SMTP id
 fd22-20020a056a002e9600b00666c1abd6e5mr3485013pfb.16.1692129405243; 
 Tue, 15 Aug 2023 12:56:45 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:6581:8508:2ecb:b5dd?
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa78096000000b00684ca1b45b9sm10090129pff.149.2023.08.15.12.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 12:56:44 -0700 (PDT)
Message-ID: <3df0704e-0dce-fd50-4f96-852542e59a0f@linaro.org>
Date: Wed, 16 Aug 2023 01:26:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/6] ufs: Use utp_transfer_req_desc pointer in
 ufshcd_get_tr_ocs
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-5-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230813235231.591454-5-marek.vasut+renesas@mailbox.org>
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
> Use utp_transfer_req_desc pointer to reference to utrdl queue
> instead of referencing the queue directly. This makes the code
> more consistent. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   drivers/ufs/ufs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index da1009e2c14..041caee714f 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -858,7 +858,9 @@ static inline int ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
>    */
>   static inline int ufshcd_get_tr_ocs(struct ufs_hba *hba)
>   {
> -	return le32_to_cpu(hba->utrdl->header.dword_2) & MASK_OCS;
> +	struct utp_transfer_req_desc *req_desc = hba->utrdl;
> +
> +	return le32_to_cpu(req_desc->header.dword_2) & MASK_OCS;
>   }
>   
>   static inline int ufshcd_get_rsp_upiu_result(struct utp_upiu_rsp *ucd_rsp_ptr)

LGTM, so:
Reviewed-and-Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
