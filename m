Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E89BC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 08:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F0880756;
	Wed, 26 Mar 2025 09:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mcXSAnpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98924808B6; Wed, 26 Mar 2025 09:54:21 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4688070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-476b89782c3so73908731cf.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742979258; x=1743584058; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flRtELbcMtH/GaCxIDftbXfHU5cyzCtjqzV3lbrY8cg=;
 b=mcXSAnpGxoVVmVarylD/9s/6dhhDsIOnCTsAAIXvWvjNbZNT7hU8692caOHBg5LPDz
 xbDwuG4pq8dQ4XhgT0uF1XaEZg0WflevsZiS4jinFY3Gmcsq6VozvHW0TSUaXiB14RxC
 IkfQaG52uOQ0AZwWZdDbILQeYKw7IWUtOstynPq7jYDlQ9msvuxFWc681hm3kZWoPrRT
 v+3LzFL17LbRxwDQVZEPjpwXpTN1WHWLkj8Y+wiU8kjLYIMHcpT1RIHjuPN9DBoty1+m
 5SLqVPUFjzXsTZ+BsQkmKot3BiKfjTLMf7ZI2/rlK+dvD/P60Hk1H/efCZY6v/E2svQZ
 KlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742979258; x=1743584058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flRtELbcMtH/GaCxIDftbXfHU5cyzCtjqzV3lbrY8cg=;
 b=Qsd/NYBHiRIJXyKwZW+Z2mg1yPZrlZnLhiXzAu5dGcXjR1kiVW/y07xnTNHubCYfZY
 1KYQvukH+5RZr1qRLzM7jeJ2Hk802NdwAmNiNlP+gi4d9CGuN7DDPSSa+BJ8NDCIlKLg
 ShQrp552ZggxAct9VsZbgOsOtaGM7fwRGbYPQjJIBx/ZhM+Xnb5nHtNmN8fp/RtfguyA
 oHHnNZ0EdxA3w4SwTXnWSfnC5tct5Diq1vGGq/JXR25jlsiR6+mKPEYFi9UbJcP31Ghh
 Qs22yMrFxkwhL51/f7bn6Y+RQl0IkA9/J68+X100typU+a/XFXC4T2mh5X5LQSPiTNNP
 /lSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVMv5RHsHaRlZ5nc0HgxK/mgrvRUujWgiL4Hlynu2/FsTpgw1plsZh1Mjw5bFf1kZdAGH68hs=@lists.denx.de
X-Gm-Message-State: AOJu0YwcO9wrrJX+jUCdDmcX6Rhe0680RRDK7AeGAlqjNA3JdyygVvhE
 fgqcb3ONhwVRizf80HPoMtd2Ymt1Sha/7YHrt2SJJjDC6Lfo7CETgrCRzj5LQVU=
X-Gm-Gg: ASbGncsIggkhKLAzrdjx4ub/Cx4Bi+fcpGwyKEygId8z2FG9NrOdbmQjIlf8yd1IwOR
 OPRHsDDIIbK4kPeZyeoVSSHYDZy8eQ98x3VBMPPj9w7OUbjbaJoKnv2ZGhZ75sUWWp8nc0Ku+eu
 P5WRRRzTU+jXoFmjpIDXPF06m+qcohV/r0+8ABKJrR03LSWsBJCokyMLtBomfQIYyjRVFUYVZmw
 WjLTTYFXp+zEBiFiE2zSG8mSF3unVQNsthaa39RvmPcvk8TcrQOVtQx/Fq+me1lXnGKtYIoKiHI
 +rIYj4yq8JTingR7t8o6t2GOdMRKdys3M6x/zGTgEwMgnpd3YoDDDxoazuZjQdoanepxrvJLhUX
 KRqzUnZB2ydgGx3AbhXAMng==
X-Google-Smtp-Source: AGHT+IE+idy2qKdGL0KZLJzJkagCM3fWLsixfbbZuw4kPHeVUiqmK1PcjhSDbwWmf35SJEjWQK0HYQ==
X-Received: by 2002:a05:622a:40ce:b0:467:5da6:8096 with SMTP id
 d75a77b69052e-4771de618b9mr356568181cf.44.1742979258162; 
 Wed, 26 Mar 2025 01:54:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:244:f9f4:b12b:6d40?
 ([2a01:e0a:3cb:7bb0:244:f9f4:b12b:6d40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d64d5f6sm70041991cf.81.2025.03.26.01.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 01:54:17 -0700 (PDT)
Message-ID: <4f090797-d999-4409-a0c7-beb0143fa70f@linaro.org>
Date: Wed, 26 Mar 2025 09:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: Remove error print on failed tx
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250326082900.870861-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250326082900.870861-1-ilias.apalodimas@linaro.org>
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



On 3/26/25 09:28, Ilias Apalodimas wrote:
> When an ethernet driver fails to send a frame we print an error in lwIP.
> But depending on how often that error is it might significantly delay
> transmissions.
> 
> For example downloading a big file with the rpi4 spams the console with
> 'send error: -101', but removing the print makes the file download with
> an average speed of ~8.5MiB/s since the packets are retransmitted.
> 
> So let's move it to a 'debug' in lwIP and expect ethernet drivers to handle
> the failure if it's severe.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  net/lwip/net-lwip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index c00a7fe97cd6..6b7b696dbf0f 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -57,7 +57,7 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
>  	err = eth_get_ops(udev)->send(udev, pp ? pp : p->payload, p->len);
>  	free(pp);
>  	if (err) {
> -		log_err("send error %d\n", err);
> +		debug("send error %d\n", err);
>  		return ERR_ABRT;
>  	}
> 
> --
> 2.47.2
> 
