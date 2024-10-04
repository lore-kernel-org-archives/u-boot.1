Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C811CF8842
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 14:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939E6889E9;
	Fri,  4 Oct 2024 16:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="llEuEPjN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FEF9889EF; Fri,  4 Oct 2024 16:33:38 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9848E889C5
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 16:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42e748f78d6so20143745e9.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728052415; x=1728657215; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ItnNQHnhoU1rlx6sspqSM+/nHjfAl6OYCsqekYSpxI=;
 b=llEuEPjNsWW+Enu7UPRb4MYiFbuGNYQZRsZg5UefOegmt2PACTx9OrE/DIxlPc9k5X
 osZRI3OtFjpk6fPcjMjdQFtvj0TJY82NI8JWIfEXiGeoK0YbxA347UhkhJ6ECOy2Bxpy
 tcb9Wy/0y3y63NQnbFzluCIZrVrV1QTekmjXk8ykEb5Bu1KeTbzY4TvPSpNRLUkcfsht
 nVsWtcSdjDpoA9CPLdQGvOrQ0pSO62bCYGvSqTWIRKTjlkmPzg/USbEgC/JK6UBVg/hs
 LR08sI7crXyywfDTBChbtH+dqkVd0vFERsrt7joGAADg7FPX+E/fTPkWu6lfXaU1CtFU
 vnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728052415; x=1728657215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ItnNQHnhoU1rlx6sspqSM+/nHjfAl6OYCsqekYSpxI=;
 b=Ih4Lych6A4W8sNEhvJAs+zrLZjoe8IaTc1YoSA7rottpO9xURNu5vi1CFojE8whaWU
 4DH9quRfj7Fk2n7rPV6TMNs4OePqV4lDalwvFyUjZX/FWT+EsWWIHSQTlygpl9oPihCi
 U4cEBHOJECek8u+uzyJKkknGawIS+ZYRZefr455vTN5A7dy8SIPNHYBkgsa9ziIde2xY
 +T3rKtpBRYMXqyjgiG6DSzF0yW36baRLcR81gIPIZphPO7ZkL/tyROp5HZ++OECtLFHM
 bUwedIQcLiwwhvvrpdb3RJW5mXdJzkCrA0mdaxDn5k/UYtnH61PV0LIEWGFPgDfFs/Sj
 zPzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHleMq0quoQ08URsii+W+XS9q98EOKkLwVIPAZqCcRiovQLz9sPCWmDWYEBS+rEI7U54B/lLQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwsC+/w9PVBN2R0kNPhc4B4wJNQvobn0+G52u85MPTND5JvaVBT
 yKNWxde+AOKlOOJpKOLfSyZ7xRRQbuvUcIxc/zbuq4+AV9cfdgYKl2QPWOuSWp8=
X-Google-Smtp-Source: AGHT+IFGQsx22+LHLndcqmHiSk+vwVlO+ff4swHrvvtp4s4xyN7Ff7diNQl+Bcv9s4xsVUVXqIeYsg==
X-Received: by 2002:a05:600c:1e22:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42f85ac08d3mr22761925e9.17.1728052414912; 
 Fri, 04 Oct 2024 07:33:34 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b444f1sm16869445e9.38.2024.10.04.07.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 07:33:34 -0700 (PDT)
Message-ID: <3f1dfd9d-93cb-46ac-abe3-ff2254bbb6cf@linaro.org>
Date: Fri, 4 Oct 2024 16:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wget: rework the logic to validate the load address
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Vaishnav Achath <vaishnav.a@ti.com>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <20240916152025.75789-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240916152025.75789-3-sughosh.ganu@linaro.org>
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



On 16/09/2024 17:20, Sughosh Ganu wrote:
> Use the lmb_read_check() function to verify if it is safe to use a
> region of memory to load data from the wget command. The current logic
> checks the amount of free memory available, starting from the 'load
> address'. This call fails if the same region of memory has been used
> earlier. This used to work earlier as the LMB memory map had a local
> scope and was not persistent. Fix this issue by using the
> lmb_read_check() call instead which only returns an error in case the
> memory region has been marked for not allowing re-use.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

This fixes Qualcomm platforms which use LMB to allocate $loaddaddr and 
friends.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> Note: To be applied on next, on top of
> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
> 
>   net/wget.c | 36 +-----------------------------------
>   1 file changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 4a168641c6..a88c31f236 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -64,26 +64,6 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
>   static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
>   static int retry_len;			/* TCP retry length */
>   
> -static ulong wget_load_size;
> -
> -/**
> - * wget_init_max_size() - initialize maximum load size
> - *
> - * Return:	0 if success, -1 if fails
> - */
> -static int wget_init_load_size(void)
> -{
> -	phys_size_t max_size;
> -
> -	max_size = lmb_get_free_size(image_load_addr);
> -	if (!max_size)
> -		return -1;
> -
> -	wget_load_size = max_size;
> -
> -	return 0;
> -}
> -
>   /**
>    * store_block() - store block in memory
>    * @src: source of data
> @@ -97,13 +77,8 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>   	uchar *ptr;
>   
>   	if (CONFIG_IS_ENABLED(LMB)) {
> -		ulong end_addr = image_load_addr + wget_load_size;
> -
> -		if (!end_addr)
> -			end_addr = ULONG_MAX;
> -
>   		if (store_addr < image_load_addr ||
> -		    store_addr + len > end_addr) {
> +		    lmb_read_check(store_addr, len)) {
>   			printf("\nwget error: ");
>   			printf("trying to overwrite reserved memory...\n");
>   			return -1;
> @@ -493,15 +468,6 @@ void wget_start(void)
>   	debug_cond(DEBUG_WGET,
>   		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
>   
> -	if (CONFIG_IS_ENABLED(LMB)) {
> -		if (wget_init_load_size()) {
> -			printf("\nwget error: ");
> -			printf("trying to overwrite reserved memory...\n");
> -			net_set_state(NETLOOP_FAIL);
> -			return;
> -		}
> -	}
> -
>   	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>   	tcp_set_tcp_handler(wget_handler);
>   

-- 
// Caleb (they/them)

