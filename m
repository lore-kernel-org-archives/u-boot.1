Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E55C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36D19836AB;
	Thu, 24 Jul 2025 11:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yn+zG5dJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2455836B4; Thu, 24 Jul 2025 11:00:14 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC24783666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so654658f8f.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347611; x=1753952411; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uEBufnVT8f3BO1SCZ40YN62EaE6Ybthtvelhko5hjZA=;
 b=yn+zG5dJr+QNWrkDkxcFcSwnYNAf+/bcWPHj/b2iXqEHDGv4JjbuE0cayePLD7pwo4
 G8X523JoJ3Yy4W6WqqPTbpmu/08iY0XaGO7x09L3lHzMML2DVXzD//TeWdvW56g/JWLo
 lrTEVULzwHYR6pSCjsSTTMeTHN5Pi5KpnycKLEca9NN0sszTKLm/ry1yhHFWz6j/iNRe
 SSxWoo5mcxsD5xrs9+ARhJrH9sEqWj0QNj/QXr9ysd1tO25tQfQkpbxFbQeWd4xhZWVg
 SgQrOZ1ktXACIT6enjrsSsEOdhxLALEXoBdxuv4ZwO+azzYILU+ElyIeQQpuXzDLDXKI
 jCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347611; x=1753952411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEBufnVT8f3BO1SCZ40YN62EaE6Ybthtvelhko5hjZA=;
 b=joZea0wCdu3NmruhfYMhHrDUL8ZMkPZyYkOcrLKRytNn/iFs5qgahoiDoC7h5dChrV
 lbPzRu4TGzZGIsiyvjhmBQx1dajhsfRHOhQGcXIVta3hHsuBeOh1+kJwtmTRtUyUMHGt
 +fWIyTagjqWj95DubA6Iu/ejKFIKrD8dV5S1QLDD/I23c0snWuLjKpzK55I9u5BZVyCN
 4myUnSJSxnnuXqZDwdKHATyM9fmRSzQgeY/ZjFCyTlsKEFc67kD8IYWY+ONddTBt9UsN
 zZmhDXBLrKAhbUSgcJDBbKJSKexc9V5nupEAfzSTKYk3LM4LUnvJjlTXCn1cHQ48BfDV
 WJOg==
X-Gm-Message-State: AOJu0YwvMSnKI24oUH4E8YsCWj0uhpCWTB+x/bDc41OxuA02plSnk7qg
 JgQ5ZTap0AbFuKZm5QJC1maopYw+624VEYJRpWqlxnkJTLbu+SRGZGi9RXABmwpsIWk=
X-Gm-Gg: ASbGncu5ax5SVW+yoZUyi3qah5KuNlKZ2KpGyQkefDznrfA9c/xEW9LlOiKBH6BYPx4
 S4weXAhInHq4Dd0DgrBTNWWrJL+0LhCkBVO2K2rg40I01s4knImlch5msx1IDwlZiL50ziGMEaW
 OXHO+acDegPC0+41mkRuz741nxkGbB6IhqANSzKtn7xXMHquVMW9x+KMuQ5IEQOwLvcjiHJdZ75
 xhbOAM3Ei5Zch6ZgjPabTmPfQeDEFyrf3qqf/PKqtW2H3/9QqSNoL8lZXeo2IQaavY6r2EUPfoL
 eJkDHIIhmGoKc2v5i8dABirq1gk4HlKeB2AmPsSeXNvbd2m5ogbFkNgDWbbyJQ1opzrYf3Jg3X6
 BPNfMFSQi6t8uvN7YiEao9AMC6GxlTdrJUzRC8bgYipmtJvbB0z/OcGonwZkKHVLGWyFaH2IR5k
 ahgw==
X-Google-Smtp-Source: AGHT+IE3GhcWc3xns5ocm13lkmiDEEx59+CsOaSZJcySLkAs++uOLXL7gjk87CJnd77iwI3stGmNpg==
X-Received: by 2002:a05:6000:1789:b0:3b5:e084:283b with SMTP id
 ffacd0b85a97d-3b768cafed2mr4903918f8f.17.1753347611521; 
 Thu, 24 Jul 2025 02:00:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce?
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6d085sm1492062f8f.21.2025.07.24.02.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:00:10 -0700 (PDT)
Message-ID: <ffa1e7cb-7785-4bcd-91b9-2227442407fe@linaro.org>
Date: Thu, 24 Jul 2025 10:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pfuze100: Ensure loop index is incremented
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250703-pfuze100_fix-v1-1-5f838e29d122@linaro.org>
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

ping?

On 03/07/2025 12:31, Andrew Goodbody wrote:
> The for loop in se_desc uses i as the loop index and also to cause the
> loop to end if the passed in name is not found. However i is not
> incremented which could cause the loop to continue indefinitely and
> access out of bounds memory.
> Add an increment of i to ensure that the loop terminates correctly in
> the case where name is not found.
> 
> This issue found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/power/regulator/pfuze100.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
> index bf3a7019411..eff166b368b 100644
> --- a/drivers/power/regulator/pfuze100.c
> +++ b/drivers/power/regulator/pfuze100.c
> @@ -247,7 +247,7 @@ static struct pfuze100_regulator_desc *se_desc(struct pfuze100_regulator_desc *d
>   {
>   	int i;
>   
> -	for (i = 0; i < size; desc++) {
> +	for (i = 0; i < size; i++, desc++) {
>   		if (!strcmp(desc->name, name))
>   			return desc;
>   		continue;
> 
> ---
> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
> change-id: 20250703-pfuze100_fix-4a0a1c3084cf
> 
> Best regards,

