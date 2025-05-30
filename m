Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DD9C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 08:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C3698319C;
	Fri, 30 May 2025 10:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x8mNmt2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38E3831C6; Fri, 30 May 2025 10:03:07 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EB68312C
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 10:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a0ac853894so1591823f8f.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748592185; x=1749196985; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p/Ir+bnSWUibRpoaz5cwGWoe1LUVVrUh0xpmKxC4DHw=;
 b=x8mNmt2lv4T/5mAMvsJ/0XbeXThO0LneQ82L/TUJAJGsDA2RTu6YZSx6aJGI8NCtNb
 tX7n4O4htb48ZxwSOmp+b56sf4D75YROz5HnSe0xxxzl9B3kAyeJL0aa/0yCRw2Juisk
 DPM3hU9WaF6K3PIOX9UaSyg7QuloLgY22KnLqDxFkYD35wI5CyAuboQk3trZ7vsOdI4d
 mM6hqVEk8SbAEp1ZL1T6xOu5eS1j0gzJPTF47XQjDfVhS2FEDbvDBTQej3KvtBXP7v0o
 fhf+nJXCI7/JoQ2Hfqspz7dLctWTJD/84hAaUFYvwO7TREBjLaBpyEv7zWn7PFquyxzq
 dJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592185; x=1749196985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p/Ir+bnSWUibRpoaz5cwGWoe1LUVVrUh0xpmKxC4DHw=;
 b=O+MKwQrYx+lsAnhQLZXRf1cHf3f8Xq/3IqBYAIjUZjnM2QFzpYvzoNsqMoKjj6mcar
 etsfs1/tth6WQBq0Z8+rsMNzr3S2kDV1vHX4vu4IkkZsz5YJEp+pPfJi8de9l2XIlJQB
 9mOaHVHwL/t4iCVqYdnt3zkrvbRWP/I01yFZz1DfnOypv6zF5DVBLcLtXWiydwE78I3D
 ebG9ENMPpOLqdpOFmDUbqbvmyIbPSaN9rplu0JwVaYKfwicJAnhCK4K4FQk3XHZAQYM4
 vGYV7LmQvKZAeJSYpsHHy+ea0omqb7qKS1KdENVs2BwS73s9vZK1gGgpRc3nTbbjdGlO
 ZcPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8M9QlhGhGO7V/X9VvdCxXrk4Lmqxg9BAw0vFbcu8PsAJstAKlAyCt2FuRFiqgKJgyfWv3M5k=@lists.denx.de
X-Gm-Message-State: AOJu0YzxVNdag2jBBscHSJyu55KQ186pF1sFhssmaX6kLhMHzrDpUA8H
 hJ/d8XVlCrE7aL98WGP0RRLQ/a5GqkvTTrJ9aXUhiWCeEXMUVwwY3bTefAmej3GmYRE=
X-Gm-Gg: ASbGnctCxbToMWfkZMuzXFdsmiyZ4MbchweAwlqSoh2Rzo4+BUPNre5hAt2etALf37X
 ENFJ+zSHdbDX8Q3nFEWkAJ0SiPk5B+vEUnS2PJgtOSMq7G1K/jJ+A45Cj6702Q8/eD99P4m8pnB
 jc6/2BkOxLNbFXpcY/u1n3xJF7wUgkn49FOT2AKM7B+RjVkKXhAnNE2yyIhn0EtZoV8F/NvFUkf
 q6iKsG2PrWN5jwiPHSPbrbTcwwz/qjD5q/LpV+EGV93ktbr8zG0obpjVbTtd5jhcg94B7g+/+ji
 RRhT/uXco88JoRBRcZwr47DfdWmtRA4AAhPtMIeCwOs2ed9AJ5Vg0iCoXkxvaG/dW3WyXiuh1Ow
 3D+SnJIvpXniPjek181Ax7IvsKTb6H0Y=
X-Google-Smtp-Source: AGHT+IHdaGKPGuQTJLJ5Y0nrahoxEsU94bSDg5vqvNTphPzc6ODELDPuggx0wG8rwS9d7DAGv7ej1A==
X-Received: by 2002:a05:6000:2004:b0:3a4:e945:980a with SMTP id
 ffacd0b85a97d-3a4f7a63d24mr1511314f8f.29.1748592184612; 
 Fri, 30 May 2025 01:03:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009748fsm4071108f8f.80.2025.05.30.01.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 01:03:03 -0700 (PDT)
Message-ID: <b19493e1-b79a-494c-a150-300969eaee5d@linaro.org>
Date: Fri, 30 May 2025 10:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] net: lwip: wget: use loadaddr env var for default
 address
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-6-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-6-tharvey@gateworks.com>
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



On 5/29/25 23:49, Tim Harvey wrote:
> The loadAddress is optional and defaults to image_load_address
> which should be initialized to the 'loadaddr' env variable like the
> legacy stack (CONFIG_NET) does.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/wget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 76401991bde6..ff8dbdc08d9b 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -579,7 +579,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
>  			return CMD_RET_USAGE;
>  		url = argv[2];
>  	} else {
> -		dst_addr = image_load_addr;
> +		dst_addr = env_get_ulong("loadaddr", 16, image_load_addr);
>  		url = argv[1];
>  	}
>  

image_load_addr is initialized in initr_env() (common/board_r.c) so this
should not be necessary.

Thanks,
-- 
Jerome
