Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6787C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE2E83837;
	Wed,  9 Apr 2025 16:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rgN1DVYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F31083839; Wed,  9 Apr 2025 16:20:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD27E8382E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso967479566b.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744208438; x=1744813238; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WDV/Yx586sRhen9PnaQU+QIk3twKHGxQYE0wMJcN0+k=;
 b=rgN1DVYySaqT772gz1xnHuKjU2eiPTYB7M32ANXHjcyRhNIgFvJd/jcNT8DO/GFyfY
 apmofhfURybX3VGdkYV/6Ne0f9tz8GgreABD6Suj+bnKESWScWMXXLpEC2d6xDYyBXUV
 MIn2kdVNjz9oT/RO7F41FSSOoZDB/EMRnLv3wyDPdUa4IWsymEVy230zO911sFXoqUUu
 U0Lq/YeYw/EwqsH3YP8/X4aj5ofme8x3D52ib1XpRujUeKyOHRhjmh5979V6hUi1V6wp
 GcFN1Hck1QUPUHGHqlVb70+ds+nqQ5I7uqMgBkYzq+mTa0x7QqB+VhwTEC4enYpEw1Fc
 MXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744208438; x=1744813238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WDV/Yx586sRhen9PnaQU+QIk3twKHGxQYE0wMJcN0+k=;
 b=dSJcGMmVgx44nnY6/iEItRmibWq5owGUJtW2OlsgkRkl6+B+ET52j3aC2ADaBcg2Nb
 Tu4w49u+m097ibme00f5s4TiZCrv0lFCRJT0bbQ2buu9RPDWTsJqxU3ak2U/E5Li5kiw
 baTjWu03RfkzsefQ+XmVGPr96JnmyuU5foydTUjDAEXvxPhOzU23ncG8U9++mcFez5Ew
 4iTYthldhUkyEklTRTYqWZhnbXABg/KkAIEk/0mxbNXSgIyvV4h/0lYN1b0ztgHim8tv
 8nKLm+0k8VJddU1Cz0IQ9y6uwcAHpTaTbrUgtXGUmxIECoGCasKZkSY0nzMbDyI8WS9l
 BY0A==
X-Gm-Message-State: AOJu0YyZbwsnMB4Nd2DmeKAG0sdWAa2XVNiUHzW63WBQrlPfF3GG02ID
 D2CKa1u4FU1EO0k9v8OWYInDcWAM817RhFiY6FaymIJNp1hSMRS57lNQH18iyE4=
X-Gm-Gg: ASbGnctpsJh0KTTe7VZNRoG6J9MsC+CfhphUMxep4MlKZbD/w+bJcVon7siDyjZ3Cvs
 CJS81Pwdwdwq0GJ8p6Kufb0wdaQRc0RJwQ/Wivi0Bpu1WEBTxgOrejWu8O19nhPHdZ7/1xEWHHF
 mNgqk9BQh1ThDvMbJ9Jae33yuOnYBnkHgNP5c4G+O4pN+WW/hhRYZy53yTRmWCLkDleTNcGQU5H
 0tT9rqPf3fTmzp81ViY8ryR563OQYrg+JuctfSCeMRxeDlH2tfmYbMAmB14WVvjtheSSBBDBkMm
 5zOGpbURBeTokqSra0GPoHk6XZ1yBq2NmMyTUvHGvhIho6EHIf+Ih/f3clXQPQnCc9g67s3+68k
 yh5UJ1Xjz+7ApFkDbEw==
X-Google-Smtp-Source: AGHT+IGatzDX98FgxXgj2mQHYCHAIRqB/WNnVqr9NhDgmfqeVU4kV8WjVCnIAuS5R6Kkhb2otwN1+Q==
X-Received: by 2002:a17:907:9403:b0:ac3:cc0e:90e5 with SMTP id
 a640c23a62f3a-aca9b6bb76fmr283346166b.30.1744208438063; 
 Wed, 09 Apr 2025 07:20:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79?
 ([2a01:e0a:3cb:7bb0:7cd9:8fac:d1e:8d79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1bb35c0sm104455566b.31.2025.04.09.07.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 07:20:37 -0700 (PDT)
Message-ID: <2a860185-d0df-429a-8f1a-17c0d065253e@linaro.org>
Date: Wed, 9 Apr 2025 16:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dhcpv6: remove excluded middle expression
To: Bryan Brattlof <bb@ti.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250408-excluded-middle-fixes-v1-1-38233f18a554@ti.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250408-excluded-middle-fixes-v1-1-38233f18a554@ti.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Bryan,

On 4/8/25 23:57, Bryan Brattlof wrote:
>  !A || (A && B) is equivalent to !A || B
> 
> Drop the middle expression from the statement
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  net/dhcpv6.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 54619ee698362..65ec48ef665e5 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -473,8 +473,7 @@ static int dhcp6_check_advertise_packet(uchar *rx_pkt, unsigned int len)
>  		 * server UID, save the new server UID and preference
>  		 */
>  		if (!sm_params.server_uid.uid_ptr ||
> -		    (sm_params.server_uid.uid_ptr &&
> -		    sm_params.server_uid.preference < sm_params.rx_status.preference)) {
> +		    sm_params.server_uid.preference < sm_params.rx_status.preference) {
>  			rx_uid_size = sm_params.rx_status.server_uid_size;
>  			if (sm_params.server_uid.uid_ptr)
>  				free(sm_params.server_uid.uid_ptr);

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
