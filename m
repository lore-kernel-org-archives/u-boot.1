Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32914C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7447D830EA;
	Fri, 30 May 2025 09:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="flMGrXPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F848318F; Fri, 30 May 2025 09:47:17 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC59830D9
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ea341570so11476695e9.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748591235; x=1749196035; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qcc/obqeArgDmsg7H32qm8bgtYgAH64jUaF78FmfDfU=;
 b=flMGrXPnaHp0P12LoaNWMgG/qbdB5gSfVj9Bo0/3dFqIRGL/wWhoulwbH0vEdhO0Pc
 OiETfBjtJ1mjvuhbMoNCfkxOjoQ7NzpaTDPQHW4VFPhF3ief5YiFzHaYm2Q7A2jEdOQX
 TvM2hEMKpryM/Dmyi8No6ZL3D5CLiLPp6LpGt61l95fLAop287PooJ0eSP1aR/c4Nh/H
 S2zV+DdHy086PSEFtiBLUQBUPm6x5yNrve/outGyJiAQi+5m2ArllL75YbJn+SgWHcfp
 q8jFGikZ4Wp7tTluDOP2vX7tpPM8kE5kb6NMXwEpdTCG/pfD1sDI0QFz6mERK/piyDpY
 ipgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748591235; x=1749196035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qcc/obqeArgDmsg7H32qm8bgtYgAH64jUaF78FmfDfU=;
 b=kQwPHo6dVOW8DB8233rVRUVNCdZ9un7G9oIDEPghSN+5t9Tfi3hZfMWHWyQdkb5eQj
 DFho+WSYH0jDgbtzbBDzR35HMOt/eWN1lJo/Mm2g8/Bh0lzaXmQLlDGUibDFh1WSIjKc
 PMYI2hKCraWEskfxthbXBlrNLugY1M/M631H5Pci0x5D7srzBx7yOOA8i3qGYNf0ecur
 nNV+p50dvn8tA2THpRac+0tDn7m12Lu1faX9oH3EyBqsrGYigKZRJJp336MaVBW67oHO
 En5w+HwluIw4BUODPe6vlevJ25uHmY8p8P+979fcrwhoCJaypFE8/yNFRmeyZFiO1i99
 KSrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkltWjaMy11UrVD7UDqupVy2sJzZVEZxtAwE6QfOSMRBa+5SRcnrTYre7dqK4LkTZWxxRBGXI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyh3JVL+mPuVAjWIHceFhUKjeMVywihQ9BF/XFL0NmaAuGZzPOV
 +eJGQLykGDX/2oMqd3gw7tQarwng22HUkN4PozJ6vixkE0e2z7YPMYWAxVg6+e9COOw=
X-Gm-Gg: ASbGncsDLZ1XIqp4yliT+Kf+VbR04k6dLj1drWSKgpL8xDUVIfgDrDveDbtlobFbH9I
 xh/qIPQP/YWBoD+ELbnA0ripLvouks/mogvh1KjhYtF/X+i1o4ecdb/dZkeCud4ZfghGpwQbrkD
 o7XIQiGCn0qOQRbTdxOSBFGxbUkyE/HdHUSKMfbydCtUfkVYm5aXafcx7TAwHki58riz6eH1jMF
 IiYF/Q2Hnq93/dWqtXPQTeHqMzYYjR+kc3uGxVZluL8KHFUSjrEODLhuUA+UxoSv1/fKKtNeNJp
 xWzqeZwmMr1uzCxbM07sFM9wTkUnnZYTOh/Dus4lwwiDJZWGnDRANamTTrL+0BtGrZZtsGfymAe
 IpAwSH4/3A77sImhH8BNM2neDGU4gxyw=
X-Google-Smtp-Source: AGHT+IG+4ejC6BFcLEz8qclSmwf79OC49S3lJaT00TmRRPmOudHtXvGC3a9w8nG2uo0rq/JR3wW7Bg==
X-Received: by 2002:a05:6000:40c7:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3a4f89ab616mr991703f8f.24.1748591235286; 
 Fri, 30 May 2025 00:47:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a13fasm4097170f8f.98.2025.05.30.00.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 00:47:14 -0700 (PDT)
Message-ID: <e9f4cad1-81f1-4cd6-8689-a343635fe9cc@linaro.org>
Date: Fri, 30 May 2025 09:47:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: lwip: call sys_check_timeouts and schedule on rx
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-1-tharvey@gateworks.com>
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

Hi Tim,

On 5/29/25 23:49, Tim Harvey wrote:
> Call sys_check_timeouts to service lwIP timers and schedule to service
> U-Boot tasks and actions during packet rx.
> 
> This resolves the issue of an active watchdog resetting the board on
> long network activities.
> 
> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/net-lwip.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index f05c4cd3f64f..e8d4cc542ed8 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -13,8 +13,10 @@
>  #include <lwip/etharp.h>
>  #include <lwip/init.h>
>  #include <lwip/prot/etharp.h>
> +#include <lwip/timeouts.h>
>  #include <net.h>
>  #include <timer.h>
> +#include <u-boot/schedule.h>
>  
>  /* xx:xx:xx:xx:xx:xx\0 */
>  #define MAC_ADDR_STRLEN 18
> @@ -284,6 +286,11 @@ int net_lwip_rx(struct udevice *udev, struct netif *netif)
>  	int len;
>  	int i;
>  
> +	/* lwIP timers */
> +	sys_check_timeouts();
> +	/* Other tasks and actions */
> +	schedule();
> +
>  	if (!eth_is_active(udev))
>  		return -EINVAL;
>  

With that, there is no need for calling sys_check_timeouts() in the
callers of net_lwip_rx(). Please simplify the dhcp/dns/ping/tftp/wget
loops.

Thanks, 		
-- 
Jerome
