Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B17E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 07:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26479801DE;
	Mon,  6 Jan 2025 08:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLkM689t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCBD801E8; Mon,  6 Jan 2025 08:51:00 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33D180137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 08:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so145438585e9.2
 for <u-boot@lists.denx.de>; Sun, 05 Jan 2025 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736149858; x=1736754658; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjELmn3T04IuDqzEs0W19G5JUmHGfndxXj2vrIpkxG4=;
 b=eLkM689th+eQgQxTPlEK6KtzNPVMHbXhzqjHj4ytFTpBdBSTBB/bEQZYl9080DzzFo
 Kk6HfPahXLnj86UvyG3CffP4LhHcWg9r6kSLyBLXbNQyspxcJxUxV3Lb9uiiy5LVz+ce
 nLoVIZQpoXB/N2l6ZUT0J+/J+xdOU3HQX9q2KDmapsBVAd+0bZARJzOOUnleFJ5dq308
 ZAEkJieVmRPdvA3bUhymVnuCvcxBlXqCzg2MxxZXr9lMQfIWz0gEEcaqjvkzUoMf0MzF
 O5fqqHD7x4FzBiOyVdJSbHAEo6nb+yuIALWMvP1HZp+1/ADQXtEvmd3HKic0TYpVctwC
 UDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736149858; x=1736754658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjELmn3T04IuDqzEs0W19G5JUmHGfndxXj2vrIpkxG4=;
 b=VpeqlkD+/KzcYsgFENBqMjThKcqihMzR6OwJRvJ3F6xnNLgzJ9pGNnYudwEbF+KXsQ
 vfaWUTnqWNvA9xoh/fSKkZT1R19dKcfkAd8Kedxskl6i+lFckwtpV8G13eGvX9I534n+
 gGCt1mDFnTfyEGPzsbXuAasyGpF7hHRBOXD4A1lRbbbHhJT95D2H6cRnz4JnGlLRP8L+
 GOECoOyRpSVn7VLmpE3UcIF4LhByyYNfipSg5f9J6jOA1B2yeE3Pcb0MjMiz7Pg5RZj7
 Akc7brTyxAOdMRrFqG1hDuPkWActuB5DOLvEwc2uyH7v/hfBHTEUJ9/tRmTJLKAkZpAe
 17YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf8jYJKcLRhkP0/vZlpVmkdDkYYqCdtuMT/KR87DOEvOmOGsh/rKsf5Ofaqeb7ZoKB3pI7hV4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd0/sbKsgXsZIIctmIfr75G6GyJT8LC6bIUy5L7AnTo176kB4G
 cp7J3DmhDEAKBnyYmddUucAr4s6SKHgMb9Ui8E51+doMAyF4CrYaB5VMGsRiWbM=
X-Gm-Gg: ASbGncv6wR92Uo8XZ7lbI+T0knfF/zBnE+oGf2GgqJnB1Ngu9CEqq1ts2W8w+AOaqwo
 7WIXDYgxYMlpCpxLMd3MQ9oxrBxc2H+5X5+tYXgX7P9Sik12FclhrA/1d58W/bUSG4yUXkkAP4A
 XdBp60REsSmdcxyXw66b/CGLzm2B9ByU0HSDx/zpRqllcC2wbF1LsxRKYE5UnJCxmpggrf+PdaE
 B22F0Q0y4GTUJ+gNYpnSIfN0FasIDAtDmydDh8H/WGIx50FYoVWex2cmJ5B7nxZeaNjVNpS2Oec
 YJcxCr4faxJcQNkOlN1/I3hjnT6Gy2lgZGew
X-Google-Smtp-Source: AGHT+IEWP04rzEt1eSOumLP4GiTGyMGQcXzTL+M5+vZg9zIANvycClmNKrkfarQ/gvisL22P/Xhv7g==
X-Received: by 2002:a5d:5f4f:0:b0:386:375a:8322 with SMTP id
 ffacd0b85a97d-38a221ea68cmr49256860f8f.13.1736149858327; 
 Sun, 05 Jan 2025 23:50:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc?
 ([2a01:e0a:3cb:7bb0:1e93:37a4:3ea2:6dcc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acabbsm46877336f8f.93.2025.01.05.23.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 23:50:57 -0800 (PST)
Message-ID: <9ee6f786-ecc8-4b39-a504-fc13821005d5@linaro.org>
Date: Mon, 6 Jan 2025 08:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: use strnstr() for lwip_strnstr()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250103232118.711135-4-heinrich.schuchardt@canonical.com>
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



On 1/4/25 00:21, Heinrich Schuchardt wrote:
> Using strstr() instead of strnstr() creates a security concern.
> 
> Fixes: 1c41a7afaa15 ("net: lwip: build lwIP")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/lwip/u-boot/arch/cc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
> index de138846358..6104c296f6f 100644
> --- a/lib/lwip/u-boot/arch/cc.h
> +++ b/lib/lwip/u-boot/arch/cc.h
> @@ -34,7 +34,7 @@
>  	       x, __LINE__, __FILE__); } while (0)
>  
>  #define atoi(str) (int)dectoul(str, NULL)
> -#define lwip_strnstr(a, b, c)  strstr(a, b)
> +#define lwip_strnstr(a, b, c)  strnstr(a, b, c)
>  
>  #define LWIP_ERR_T int
>  #define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
