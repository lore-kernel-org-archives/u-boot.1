Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B603CC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 497D08888B;
	Wed, 22 May 2024 18:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lrDN9Oz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCEC888AE; Wed, 22 May 2024 18:23:18 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238368883C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so11487959a12.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716394995; x=1716999795; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N4dIN9ClRqCvdtARPFO/gtO58Q90HGV6ZeRViVM+BnQ=;
 b=lrDN9Oz782PpB7zf04KClufDRVOt6EGdEKrvQFy9VGyRRkAzer1JxocIt8VmVeFvlP
 rC85QUzOr1flFXAWs80qOL/DpOjcQY7DDLp7DvqZlIvSVGsc7q0NevIoMqejash96HBk
 si+B2iWfqj+qLAYp1806+CArOGex1o3x2Mjo4XTKmWxK4WYATkxlvFQt+0mdj9jgQWo0
 J0mBZNTJOqR/zIfT3C0ohyhQMSiynKizkb6WkXpqeKGg0gV7uGOfpnOhtZTIVaxNeIHA
 UzY1aEe8LhbJowg+IRFZnWNTkzLclGl3QgTwPXSZBQv0jpmf20E/tj5zj77CPMqVRMql
 TfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716394995; x=1716999795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N4dIN9ClRqCvdtARPFO/gtO58Q90HGV6ZeRViVM+BnQ=;
 b=G/LbEyMGhCK6rVNwWfzwVijpjh/M77+txCoqid6o0fUg2EEkTs+iLfPcblXv0DBrvG
 RnVn0hnjY4xTWv8VsJuWCyVxvqgLZlw1400eWycdUNevbfXlPf44nExmL/s4deNYpiay
 EmKVeJETUMKE0+JOVWvFoceWw0fKqLNQxbeaDu8tuOTw0jDZLcnvu+tOah85STghIlrV
 rIzDnqmebuvUqVhdz+F116A21PlxWKwVBGl4HVVpYrTaDMr6cC65HI3ITCHxvrW+tYfW
 LFt+GwHCFQcEXbyeoS+95DCRphpKKCivULH48m7y1wnVRs7C7bpRSSqFFj/7Z3Q5K4Lm
 iL6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAlFch6a4CRZWHGgMNoQcnv0GmUeuuvCzaxB9VIYoZVV+cRFA0iYH5vpIHB5pfwNXHCf82UJ1y03Df4/yHK7rgtJsVQw==
X-Gm-Message-State: AOJu0YyO3wee0bOv7hSlv4uTUt4+BbMoCa4KIBgcRU6jmnLESSGnKyGp
 H2agt+A5zrxO7HyD8h1bhb96WY8AXiURAB9VWiQDQMy+QZqI+E9PFhNwe3eXWD0=
X-Google-Smtp-Source: AGHT+IEPsvjINPFKGVhTBZn5Xzjii2iNdqjUduYmWSSHDe2LKtF/9i/Oz2g6Y5BAxoDoF//LsD1SqA==
X-Received: by 2002:a50:d74e:0:b0:56e:99e:1fac with SMTP id
 4fb4d7f45d1cf-57832c4b0a0mr1734135a12.39.1716394995603; 
 Wed, 22 May 2024 09:23:15 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c322c85sm18642278a12.84.2024.05.22.09.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 09:23:15 -0700 (PDT)
Message-ID: <6045b81b-6fe2-4435-89fa-04a535c1d25d@linaro.org>
Date: Wed, 22 May 2024 18:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] clock: qcom: ipq4019: add missing networking resets
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 j4g8y7@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240522101437.225880-1-robert.marko@sartura.hr>
 <20240522101437.225880-3-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240522101437.225880-3-robert.marko@sartura.hr>
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



On 22/05/2024 12:13, Robert Marko wrote:
> IPQ4019 has more networking related resets that will be required for future
> wired networking support, so lets add them.
> 
> This syncs the driver with Linux.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-ipq4019.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index e416c9cdb0..2773bbc2d4 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -205,6 +205,12 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
>   	[GCC_TCSR_BCR] = {0x22000, 0},
>   	[GCC_MPM_BCR] = {0x24000, 0},
>   	[GCC_SPDM_BCR] = {0x25000, 0},
> +	[ESS_MAC1_ARES] = {0x1200C, 0},
> +	[ESS_MAC2_ARES] = {0x1200C, 1},
> +	[ESS_MAC3_ARES] = {0x1200C, 2},
> +	[ESS_MAC4_ARES] = {0x1200C, 3},
> +	[ESS_MAC5_ARES] = {0x1200C, 4},
> +	[ESS_PSGMII_ARES] = {0x1200C, 5},
>   };
>   
>   static struct msm_clk_data ipq4019_clk_data = {

-- 
// Caleb (they/them)
