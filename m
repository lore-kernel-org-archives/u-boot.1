Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8FAC3ABB2
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0ABB8312C;
	Fri, 30 May 2025 09:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z6h6PsG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80EF8319C; Fri, 30 May 2025 09:48:40 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C62C830EA
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-442ea341570so11487725e9.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748591318; x=1749196118; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+QzdhgPFsQfXlZkc2o7x6hRmzYQDcqbE3t+AkyQHqA=;
 b=Z6h6PsG5vxaq4DhxcPlLSlNF9R1t7h8Xow3WR4m2sYm6XZnp/NNzFAAnhxw+bJQazZ
 E7cGwdWzuwezSv88wbMaojg/JX3yGiemb3CWxLSeloXJc0zr/Fc8uUchqVkC0JMeGEUo
 HukuEU0LNtPSKX7cQxXryRROhClpBPFlPDeSjKMzDb/LLYhDN9pulFXZTBCtLkUfT/w+
 5Tx2CUOO3tdbZlZyWw3N/HhFLuwQFoEQrYVvyTle/IScf5cf6ty8bdM7tuBNFbUbzG4c
 MRe9ivulTEqJXIH60A2gbv4KvPn9hRncdq2oMjSM5zU4lEqNTdYn2ochBmjMYC2agPdx
 cCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748591318; x=1749196118;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+QzdhgPFsQfXlZkc2o7x6hRmzYQDcqbE3t+AkyQHqA=;
 b=X61eUObC5gGr1l6Efj+9Ab+DgMxhFMjZ99TE/DKW2wrVwbMiWwjiuoLhMprRIF1tAD
 nStOrJ+oDXffcRDoIfWKGXP4TPUdsC2BtqSbKSP/Jn0K70YY7nxn4MReDtyIMHmqhfqi
 HC7ayGDwdMO60LUpfNhW1ZdoAmsJbnvJa+FcOk8itiSoGobi9ECz97FV8TDgCKReZTiP
 WcB73JrTIYX9iMnvzO/MPEHtsIJovFolVKV2ovTlUu5Sc3SMwkiBGW8lILcA8TqhaNJF
 p+NE7SU8mjxNXYwq8VT6FWgIN/mIVFoQf9nKwMHfarV8k9R5LUunnL23EnrxmIlehU0y
 bneg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZRJXUkwxL7X8Kk+O+IwvAJ7ftCM12zOdgOKy/OHa8qaAhcILyunmNNNATf6+vbcR2Fp4XZU0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywffr3G1dKVKEq8qeS2NjVEd52YBDgrOFmWW6fj5vhOH8ETAij1
 ALQVXpv+KlVVsa8IbN2aN8LzpLBLzzBeRXwZSO0qvnfSSVQVBGvasIxURExI/JpnM0k=
X-Gm-Gg: ASbGnctE8QDEKxlcyNQcSFujTG4/4HhvlIbJFYnqxr3xasWgs5RrIeKOXDj6n9a+BRw
 mQiUT7VTMVfi+MuTCUFmBQtrT7Tg8bTFXftyYGOYQQ16163SaEG2M/MxHGOxi6A+BArER39VXZG
 jMW3JJBdwe1rINjS/Jdr8sGq+TrNIeszp+1XPBduyq2oDJQ+kMHlGxaxa1PfBQ3/Xs6mVXQ9zU/
 qSTXd3WIONsPP2XBucqwTXP5LCsLNuVOM9wVT0CE2VkPKEYJwUR8jO4ooMvYSOZQ2wGkQ755zGo
 tE/K1JWdPPnlZwwSin6/5gb589+dxofNR5VEI/tKVRhoqDeh+EkMEWtK5AKKk6iqPguTv4fPoHs
 5R9zzDM9sMt3hlgXl+3AX9dkJcHJGbS53JmsWLq3ctA==
X-Google-Smtp-Source: AGHT+IFRYrrO4ccfZclS0WarZu6GImZeR+7kZgezw5pqAX+aRlfFNNz90RBKwDXb3grQ+qfeLaHduA==
X-Received: by 2002:a05:6000:1a89:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a4f89e0035mr886020f8f.50.1748591317956; 
 Fri, 30 May 2025 00:48:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm4108659f8f.90.2025.05.30.00.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 00:48:37 -0700 (PDT)
Message-ID: <91b770c4-7243-4635-9107-9e46cb729410@linaro.org>
Date: Fri, 30 May 2025 09:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] net: lwip: tftp: add support for setting blocksize at
 runtime
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-3-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-3-tharvey@gateworks.com>
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
> Add support for setting the blocksize at runtime via the tftpblocksize env
> variable as such is done with the legacy stack (CONFIG_NET).
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  net/lwip/tftp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index fae701bad2eb..6cdb0642536c 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -156,8 +156,10 @@ static void no_response(void *arg)
>  static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  		     ip_addr_t srvip, uint16_t srvport)
>  {
> +	int blksize = CONFIG_TFTP_BLOCKSIZE;
>  	struct netif *netif;
>  	struct tftp_ctx ctx;
> +	const char *ep;
>  	err_t err;
>  
>  	if (!fname || addr == 0)
> @@ -186,7 +188,10 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	if (!(err == ERR_OK || err == ERR_USE))
>  		log_err("tftp_init_client err: %d\n", err);
>  
> -	tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
> +	ep = env_get("tftpblocksize");
> +	if (ep)
> +		blksize = simple_strtol(ep, NULL, 10);
> +	tftp_client_set_blksize(blksize);
>  
>  	ctx.start_time = get_timer(0);
>  	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
