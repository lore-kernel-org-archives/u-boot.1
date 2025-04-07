Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E436C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 081F28215B;
	Mon,  7 Apr 2025 16:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AlsnUnCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D07810EA; Mon,  7 Apr 2025 16:25:45 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C6B82EA3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so23340015e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744035943; x=1744640743; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5EC3Kw9z5tzNA05t+/y2ZUYgYZduX/DBuKlY5yJwpk=;
 b=AlsnUnCarTGfAB+nbtm8L3a3QXQgYl7AMHd+pGPrysVruo7TRz0C4o3pSdmivfs+aQ
 XMlABL9xXRKko7YVUms25aYF0XcNtM+axbv+e3iEoeoeJ2rpzAAKFdlTm6vboVFXuS0c
 YFYQi8uLo7Leu4ZYo04HRCpKtgjtCI/Tr3ud2X3jn/aBi4mpQ487yoqYJrdq39SUt0Vj
 EGgBW04re+dq3bfYMZzbZHEvm7KhuS9XD0KHrAXcYqXpVPYAc1O25UadWkFpr6kAZINx
 T7k9cmO5AMa632g/0OumhP++suKFPdvjdIPfZYqqfTLQikvv2U+I+F+QcIqjxZNyLZbd
 eetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035943; x=1744640743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c5EC3Kw9z5tzNA05t+/y2ZUYgYZduX/DBuKlY5yJwpk=;
 b=FiQy6QTL+C21dTPRFcEPOpPAkxaAlpHlXrN7D4uN2istXPs9pwfhJRMKWNJYwHZ9My
 0fc5cRZxpyOUkh9FWjYvdMOMbltyy+3z5Gm4a6I3uGa1G1aELdparid2cnQuvnPNWum0
 HgRq6l3mVRfooIYvPyZWzxDeKkc7Oivuevz29Ajy2F/Ue3iMBy5o6Kd2OxK18/BcgTny
 8weCC3/yRougCeTztosADPUDLxRvHXNTc7NoqV46bijy6I4EGT94PSxoa80wKRPFq1JM
 CM1tRqUuR3+A2+mFPiz6Ny/EEQ4lyHYFi1UvuXODQm9ziGbIYLLLebGxNvGm9QivgCfz
 wQ0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3UixNXdGWm0NAP2NBNh2dKiCuJ8Tfk+ZLQK/4f/o5cLWE4QkEojusRdspXEB5WmCib/MlvQU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzc15ZtzoYCnRocHn5mchk+8JYUaAFmkXZNEuQfngAlFNof5rzf
 I2nS828Ydw7Clp/aH4aAzXRz8rxiFalblWNtiZSqKjdgP8FC1mXw4/kXPmwIllM=
X-Gm-Gg: ASbGncukOq7j55sTO+D6SCt30W0om3nJi3HKuS0RqSMHoTOIxXwiDa3Fe/rKOnEMO31
 9otLzDdHyGkz0mPmxXDc4Niym+kl0WdR8OOKnsBsA3m59pFKCAql4BNdvMN2mzmjf8hMmocJbQM
 Dx18ug2Rv3ve7U4duHNuIdGweA10IJrC1CpRR7p+F2ygWU856UXziCLwTN1IKQ2X6mx6uMFG9Ut
 7huUeNomzBzo+UXKru3AtrWuraqk43w7vNkIwxF4VlOKFX2T/wE0rPq7MQSRy4GX8sRzx4SQuMB
 xtbeDLw4wRW6RYc8Kq4Kn/slutBDQhFEK3cIqZ7Ga/873uVVlpK4oWPtODpwTRiQbXhBH8YM0lJ
 5GEXmCRfZ5uY=
X-Google-Smtp-Source: AGHT+IFUw/6c3byZ4U388RYYCkMpMOXYY4Z7Gw++JVM6H2GNqpun70hIvHTG3RFGbDthOyKgRaBt9w==
X-Received: by 2002:a05:600c:1c02:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43ecf9c3318mr102060205e9.26.1744035942772; 
 Mon, 07 Apr 2025 07:25:42 -0700 (PDT)
Received: from [192.168.1.47] (212-60-142-46.pool.kielnet.net. [46.142.60.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm134629995e9.9.2025.04.07.07.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 07:25:42 -0700 (PDT)
Message-ID: <d635b965-7365-4589-8ad6-5521c032ab46@linaro.org>
Date: Mon, 7 Apr 2025 16:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk/qcom: apq8096: fix set rate for the uart clock
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-2-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407120536.236003-2-jorge.ramirez@oss.qualcomm.com>
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



On 4/7/25 14:05, Jorge Ramirez-Ortiz wrote:
> The function should return a valid rate.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
>   drivers/clk/qcom/clock-apq8096.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index c77d69128b0..bc00826a5e8 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -87,7 +87,8 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>   		return clk_init_sdc(priv, rate);
>   		break;
>   	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
> -		return clk_init_uart(priv);
> +		clk_init_uart(priv);
> +		return 7372800;
>   	default:
>   		return 0;
>   	}

-- 
Caleb (they/them)

