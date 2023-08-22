Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E7EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 04:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBF286993;
	Tue, 22 Aug 2023 06:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oR1qicdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9FE871C8; Tue, 22 Aug 2023 06:01:29 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0188F86986
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26f3e26e59cso1428621a91.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692676885; x=1693281685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eHTwR6vMgwGFqQy7CPmYT2JG6w8jiwetazFIj+f4NRA=;
 b=oR1qicdg7Uu9BWtxqhcuAW9HyN3kL1zZ5fOCfpdoYRtiV6yIUh03r0UIQoYiOgNc5d
 0YhH4bSnTxcusEReEqESiGdDoLspX4BU5Z68J7/S2ULM+0kRLbV+DT/rwTf4sri8zvhw
 M+8GtSyM6d9+xdzb+ew32jkLc8cSJ1gKa1vPu9zwKDY/L/JfRxw38XJWlTbwVjC7DN0G
 xf6uZ1aEmE4dknnzVZGOACVGM9nTS8vN0T5uLqjXmKUvTZa4HUteeFW3Gavxp2hgHIeh
 ixDBEFsPlNHT/su7Vk1OkQZgq1yDdhyOAUalkBydBKTURGRhATjMbUJpYUDROXeLjFnh
 ZkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692676885; x=1693281685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eHTwR6vMgwGFqQy7CPmYT2JG6w8jiwetazFIj+f4NRA=;
 b=L+7K7UjuKYwXedBOkJifkVCkiQnR55UdOtc2qkljU+aWYDnt4o/IoIW5MFjuouz2ab
 +pgIldspWCr0ov+1rMuDeDGSZLVadl9/tGyW6c6TSzbdc5Kw/GPvJijrsVHgAPDmCNZf
 DQMLcsnB24J4YqoHkNDUOfTJiMLoIC65bJdj54ed4m95PAJBCwD4qJAM2mqje7r+W2FH
 aS4ycMLNJXZnMc2yNlHvhBeulUH5cafQjyyhax4b8Tj5CZJtH2W4REo5hsVm0YnafBKy
 BP1oJe/fUHYuh2DzzHQgBsKTv8R5hvEX0E+308PmOR4GFdcNTp3toS4PZfexrHbaH8eg
 p3LA==
X-Gm-Message-State: AOJu0YyTYtc+2oeK+mN+hr0IjxF9gxCyUfm1ZlC9RNaFKf7e4SU7rca5
 mtjIe+5VZaesaiacWBBSFjVZjw==
X-Google-Smtp-Source: AGHT+IEuFnCJNlmzBBsRYJZDLkGHdsBG2aF9VgoLQKN/jdqqNf8yY0DHIFJpbHeFyr8jDQvY2tBWHw==
X-Received: by 2002:a17:90b:1c8f:b0:26b:455b:8d61 with SMTP id
 oo15-20020a17090b1c8f00b0026b455b8d61mr12070222pjb.22.1692676885214; 
 Mon, 21 Aug 2023 21:01:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:3924:9d49:2d2a:63e6:8974?
 ([2401:4900:1f3b:3924:9d49:2d2a:63e6:8974])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a17090a6e0300b0026596b8f33asm8532960pjk.40.2023.08.21.21.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 21:01:24 -0700 (PDT)
Message-ID: <1698468d-2980-6662-78ca-23da240b06f5@linaro.org>
Date: Tue, 22 Aug 2023 09:31:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/7] ufs: Convert quirks to BIT() macro
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: n-francis@ti.com
References: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230816150555.245028-1-marek.vasut+renesas@mailbox.org>
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
> Use BIT() macro for quirks, no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> ---
> V2: New patch
> ---
>   drivers/ufs/ufs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 8a38832b05f..5a5c13aefdf 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -717,7 +717,7 @@ struct ufs_hba {
>    * the LCC transmission on UFS device (by clearing TX_LCC_ENABLE
>    * attribute of device to 0).
>    */
> -#define UFSHCD_QUIRK_BROKEN_LCC				0x1
> +#define UFSHCD_QUIRK_BROKEN_LCC				BIT(0)
>   
>   	/* Virtual memory reference */
>   	struct utp_transfer_cmd_desc *ucdl;

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
