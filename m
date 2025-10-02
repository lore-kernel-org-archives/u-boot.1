Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3572DCAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 09:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B499A828A2;
	Thu,  2 Oct 2025 11:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Gmixttn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD80C834D4; Thu,  2 Oct 2025 11:52:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD7180107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 11:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CCEFE3F17B
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759398723;
 bh=ZRee7V6AwYkVrFzmKzCzCkVAioi7KDeiC8jW327pE+0=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=Gmixttn/XQGfBRbrNTS3z9Y3oAuEwHd92nvoBU3xBxlGhMxuB+sqzPvKOn/U5Eowq
 j15M8phZrHPYsXAFYnmIpNfiH0i7HkPP6oFi85N/zCsy3VvJ6jBnCLtGeuPB4Lnz33
 Spo27sdG4fRXpnLX0Td0QIhpa7Oy3E2PypXeoL3/+6QxKyGTDZZwtt/yTvLzFjFXjo
 zg2JoKPHdeG3v5mU3v8fzHVHgzCTroBAdrpW0GD33BSoBSzhsh/oU8E5t3ml1iSmIR
 X1nFBrJh6mDFRCqqyEGz7zmAT4ssEJiHl/6PfGu9TPczek6Q3vAp4xabXF97RpCQTJ
 aZ7ILPXe+sXnA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e377d8c80so2659405e9.3
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 02:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759398723; x=1760003523;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRee7V6AwYkVrFzmKzCzCkVAioi7KDeiC8jW327pE+0=;
 b=b9rG2OghxS6NALYBbZYLxwoETbxV66ghVZY02pP3x9ftKoR4MjUqSLb5z1dEccROLk
 z3zrOAJOqYKiOQYE4OkPSys5RLjDoHGyZdVVyM/+i0zl+pUn81gqcfSsvE177AQV3jC6
 4OCrWm8xXy8dkOVL8ccYa+M8+BXt+XX3RuqmXnIHr6CAv3UoBkmn8U99ESO9WnanQ3SI
 7917L7Bs+LLARq5KXim3e4JwxP0cyWFpQW4yDwUTZDz/RiSGT4R0ynqPWKp2EXb2fFn1
 Nbhm/gk420AW9ALla350NEkmMqT4gxoP7Kw9VFw8Ia9CIKrV/hsu++gsZh6bDCIivMVf
 gOCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWStUBgVzpY7SC6FYaGdmZC57y9Y7EddxnyFZRfm2mvfHKQChQx0gitJYEOYNBppMcqQdWe450=@lists.denx.de
X-Gm-Message-State: AOJu0Yzxh7faFxpp2dvW0qE38NuqsTCWbRaVhzxZjmScd75587SIuQ9n
 yCTBgStCED7inHL1duBT5/Y8qtqrenbHQ241iTSSb6gv1MSis6inAOdDn9SGdXEIFKDNtMLFsSf
 wQRZxdy1+Sqk1nTju2Yu/Kmab4sHueNdttnNp1rTl1XaWDgjGtRLyteLS7tWgEWxmCP+J3vc=
X-Gm-Gg: ASbGncsIoXkOObY6U/fgLQzm4vgghpl6E0JWNQ0/bDqaTwCj0Wsq/wC7zg1dBAUWggk
 fMXaU0Z60amFrAG87hVYiVOa5Vlgrnz7cf7ffu6oasJxTouH9ZHgO0DZQX/U+Rleeq33I5Dov3X
 2gZyHSUFNuhk4VHGgyCcQACqMVc8C2jOvgfmrIHZ2+qMXvO/l1UDFnKUZ3wQpKAg9ExILpAPN/2
 OPqaaJzZTEFpgMdj3Zkpn4wdBlY9H4+X3APdenelm6+HaRAkHFLqde49YhvKdmjMrMoCa1Fd8GW
 kt/IM7llFvD+Rn8AUGh4u7gitDeooKDcQDZrxdtaperCR3yObsAXcbLez/MlUOxfqXsPw4wetcV
 Cb5wulm4rugsBfm0ZsFoVgHH9GA==
X-Received: by 2002:a05:600c:1388:b0:46e:43ee:3809 with SMTP id
 5b1f17b1804b1-46e61263ef8mr47955135e9.7.1759398723261; 
 Thu, 02 Oct 2025 02:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVs6ivnK5aFdaiFLLHUh7NoDjx+8Gr23gvyMhZxyTDNutg6IsWEy8IAt+KwgPktCh7B3zgPA==
X-Received: by 2002:a05:600c:1388:b0:46e:43ee:3809 with SMTP id
 5b1f17b1804b1-46e61263ef8mr47955015e9.7.1759398722828; 
 Thu, 02 Oct 2025 02:52:02 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3a58sm74538775e9.6.2025.10.02.02.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 02:52:01 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
Date: Thu, 2 Oct 2025 11:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
Content-Language: en-US
In-Reply-To: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
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

On 10/2/25 11:39, Andrew Goodbody wrote:
> After calling a function that can return an error, the test to detect
> that error should use the return value not a different variable. Fix it.
> 
> This issue was found by Smatch.
> 

Fixes: f676b45151c3 ("fs: Add semihosting filesystem")

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   fs/semihostingfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>   	}
>   	if (!maxsize) {
>   		size = smh_flen(fd);
> -		if (ret < 0) {
> +		if (size < 0) {

The ARM specification 
(https://developer.arm.com/documentation/dui0203/j/semihosting/semihosting-operations/sys-flen--0x0c-) 
has:

SYS_FLEN (0x0C)

Returns the length of a specified file.
On exit, R0 contains:
     the current length of the file object, if the call is successful
     -1 if an error occurs.

Please, consider that the file length on 32bit systems may exceed 2^31 
You must not consider this as an error.

%s/if (size < 0)/if (size == -1L)/

Best regards

Heinrich

>   			smh_close(fd);
>   			return size;
>   		}
> 
> ---
> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
> change-id: 20251002-fs_semihosting-85d697fbfcad
> 
> Best regards,

