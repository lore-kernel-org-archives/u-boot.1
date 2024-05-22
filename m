Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B96C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B52888B5;
	Wed, 22 May 2024 18:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="awGf1uhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3068883C; Wed, 22 May 2024 18:23:42 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6158A888B5
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-520f9d559f6so8080537e87.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716395020; x=1716999820; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ojHLs+JhhpOF5zw26lpVT1WqCNiKD8AtsKULKH8XD8=;
 b=awGf1uhKQATD2dRIisfWqhL8lea2NrGwMnoCQp2hcEAA56X0uefoo7DM+bUSnx9XL4
 cerisD04ioW+CZa9qkwMMFXt8Jhe6+7URumejaFak2n4aSgOSGVOiSJZlkbdC+SQYoaD
 nR7fEaqjgAiyvfBW69YD+73mhVXqEQ/MnNPhRxIJEjDdHS2VhR7CbXdlO3DxNtV73Xlz
 VMDaZk+6AyJatq8aQWUtsYYh2LipAUmQFSowHYhhXavOfYVCSG9n7rafr8q7awVkx5yy
 XTOr4BBhmXMtoLfDvqkOEZ4fAkWZkaKm3H8Gcf6d0WKDCYGoeAYl37QnENo+JM8HbM7P
 Lmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716395020; x=1716999820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ojHLs+JhhpOF5zw26lpVT1WqCNiKD8AtsKULKH8XD8=;
 b=xUl90bN9KTpAKzvzJtwEVgqI+IVS1Nl7l8gt62aVWqeOG0sYsgRwFy8hnAUiydBdTs
 u7KNDC0cIJFAH7TrvkJesqgQSDaOT0sEm01lXMQDh4G7AjDA+y/DGvLTYfJjenizi/8X
 aJjSGET8atvLpDkwqqfrvBpfFWs2HI5SAPY0HTkFlJJtRV2MQOkG2xVtlpEMbC9uh2/7
 wPjr9GDVffG+K3HgmQ5GXwPF+i5b3QeDx2W4ZFkDrRJEWZgO3YrRr4GK7zc82N8l6wZn
 wyVbNV0MUTVx2kCwNIiYYNRAT5yFGslQOjBEXgYJHVOn70PuN300oK4PNfELGsyhgAq4
 1NYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRTvaj1gMpbLwwuHkdKDfm1E0hSA4HjqWdl4JfhmgTm1XuuRIoPwG/1t71+aOou82/bg4pwK3N57LMOaUtmVZ7IUKvxA==
X-Gm-Message-State: AOJu0Yy1i1RUjOXl5clQToDc4aa/As+djEu8bqdYBvUQ9SouuezUqKRs
 m8Cip4++x6Fj+4oEynCTSeLQIAZZ1FRRQm4D5mwgB4hLjo/B/e/E6QpbHwcyT48=
X-Google-Smtp-Source: AGHT+IGAzKoB0+GZVa6M+5Dn5rZkuijn8sFa7FElvaIFmfeA9D9MJNVxyl+uzzPgNsm74oZzsQf8kA==
X-Received: by 2002:ac2:5e22:0:b0:51a:b933:b297 with SMTP id
 2adb3069b0e04-526bd694d3cmr1490770e87.2.1716395019736; 
 Wed, 22 May 2024 09:23:39 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5ceb46c33fsm885795666b.142.2024.05.22.09.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 09:23:39 -0700 (PDT)
Message-ID: <a3350841-09f1-4c89-acc4-a1e5b7d9d494@linaro.org>
Date: Wed, 22 May 2024 18:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clock: qcom: ipq4019: add ESS clock
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 j4g8y7@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240522101437.225880-1-robert.marko@sartura.hr>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240522101437.225880-1-robert.marko@sartura.hr>
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
> ESS clock is the Ethernet Subsystem clock, so lets add it as its
> already configured by SBL1.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-ipq4019.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index 0492e536e7..e416c9cdb0 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -125,6 +125,9 @@ static int ipq4019_clk_enable(struct clk *clk)
>   	case GCC_USB2_MOCK_UTMI_CLK:
>   		/* These clocks is already initialized by SBL1 */
>   		return 0;
> +	case GCC_ESS_CLK:
> +		/* This clock is already initialized by SBL1 */
> +		return 0;
>   	default:
>   		return -EINVAL;
>   	}

-- 
// Caleb (they/them)
