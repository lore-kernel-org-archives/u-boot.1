Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100D3EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC0D871FF;
	Tue, 22 Aug 2023 06:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="byeW7iTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BBE871D5; Tue, 22 Aug 2023 06:09:24 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 109038687F
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:09:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so32031295ad.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692677360; x=1693282160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PZAjI7KHN/EwNiLfKGbcZWJYD7IewslrGpD7qEzJKvg=;
 b=byeW7iTqOp8wuPHsKWvoSqpiqPEwy7zv+86peTebJZO/dbZvYWe42iQtBFzUU9mfXJ
 WXWgpjxBWqx0NrEYDERvaNuSiq9sHmaA298l3CxXvHxle/TkHl8DAVLehTwnpGjosDIb
 BRgthG8HLdg2nkPkpsew4ipQpsdLZP3lUUu8rWpaPn/Smxls13sTkDT5u+PTe13dAodk
 SpV2/1gNd27q+/T5amgQ31jv1+BIAAR9nudiHB59nQ8QcnRJ+tIcSStfvIYQCuc0HXr+
 ++NSv9T5FJi0NCcoCJ00N/XK0P5uskiR98YmfV1fRpOHw/7ejYqy/WXZqQrWNkoThKLp
 vMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692677360; x=1693282160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZAjI7KHN/EwNiLfKGbcZWJYD7IewslrGpD7qEzJKvg=;
 b=jBZhBAGUUBT374tedsk1wXqbVWyUyix6iPq0WxtSilo/YyYDF8pbEU/igY6VJ6UZhM
 5Pe4xpog8oaaKfF2p4hQ/SqB0uvnoKQ/ppfrfZiSeMXDD76yl/Bdi5jlYIycDeLkXre3
 vM1MqajjQ/UK3Dr9Vw5HMMRE2rYZVWYLjKWRbdv/XpMNW20HNWMbnXjz4pHqcgmhgmxa
 yHnxT8l8AcchiIliAoum+M/nMLHB3xZV0RHsbGIT/jqkr9i6XdDG6aGu/VHx2jdrkOCI
 7Yial4q1yFnUeNDWujPxEKwgQ43p3GZNJODSqVxEJq0JuJqy78qToE/zMSZKC4S4pIoF
 U64w==
X-Gm-Message-State: AOJu0Yz1aUMrKnQ7yGyVcS+yPuCSG8C8gRSnZdA2yutg6yNYkw/KSq6u
 jGl7q8NZny9pbc2aze+tZQAohkU/eeNWLSsQcLk=
X-Google-Smtp-Source: AGHT+IHwefh2dBjfZlfM/qiBGVpKlIcb3BnAjz1vniLcaTqxxAilTnd92nZOUAjWN0eNH8fe2yTpiw==
X-Received: by 2002:a17:90b:1e02:b0:261:219b:13b3 with SMTP id
 pg2-20020a17090b1e0200b00261219b13b3mr12546993pjb.16.1692677360195; 
 Mon, 21 Aug 2023 21:09:20 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 n14-20020a17090ac68e00b002636dfcc6f5sm6847438pjt.3.2023.08.21.21.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:09:19 -0700 (PDT)
Message-ID: <be817bd9-21b7-ab27-e35b-dafcb1a284de@linaro.org>
Date: Tue, 22 Aug 2023 09:39:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 6/7] ufs: Use utp_transfer_req_desc pointer in
 ufshcd_get_tr_ocs
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
 <20230816150555.245028-6-marek.vasut+renesas@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-6-marek.vasut+renesas@mailbox.org>
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
> Use utp_transfer_req_desc pointer to reference to utrdl queue
> instead of referencing the queue directly. This makes the code
> more consistent. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: No change
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

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
