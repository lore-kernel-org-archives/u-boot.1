Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017921061B17
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA4883DBF;
	Mon, 30 Mar 2026 19:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="nY0Rg7M1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C3D83E7A; Mon, 30 Mar 2026 19:56:49 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 437A38352B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id E5A41240101
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1774893406; bh=mRdLv/TZlPfhY5OgASbF0liW/ZxGAbImcyWA4+rqVdQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=nY0Rg7M1Ff+4xSFPOzxSQ43dXWvwbJrEgthFRg6lbET9QFT2SXvfedPur+Noe20H8
 Sx4Hdd8Ypo/QAyXV6SH4SoRpM60HnKGqf1nYc0Z7nEMdG56C7Ck0yd7jQPDZskMrPA
 D2MqfNe1+x+pUMp+2l7M+bhoGW/V5dyvXCe8wAWGMQSLBMQEZO+Slm5CBpDnvJezBQ
 aD3amBRtcUax9aqf9Wv/tkBzwQnoFS9J3uf2BqZ6zZdr9fae3Ym5ONurLOAoh/Dp1D
 9YVNaLbolUlUKrOCCOl4bKYKCCovdtprRR7JgFfgEqK4ZWw3TnzKOE396wGSiL1BBi
 Mza9ewdlTCtSA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fkzTT1D7Fz6tsb;
 Mon, 30 Mar 2026 19:56:45 +0200 (CEST)
Message-ID: <6f7eca49-630b-5392-6b92-5ec7d50fca8c@posteo.net>
Date: Mon, 30 Mar 2026 17:56:46 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] board: nanopi2: fix bd_update_env() cmdline buffer
 overflow
Content-Language: en-US, de-DE
To: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260328051552.29343-1-S4210155@student.rmit.edu.au>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20260328051552.29343-1-S4210155@student.rmit.edu.au>
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

Hello Ngo,

thanks a lot for the detailed report and the patch. I will have a closer 
look at it the next days.

Regards
Stefan


On 28.03.26 06:15, Ngo Luong Thanh Tra wrote:
> Replace unbounded strcpy()/sprintf() calls with snprintf() and
> check the return value against remaining buffer capacity at each
> append step. The previous size guard did not account for
> subsequent dpi suffix, remaining bootargs tail, and bootdev
> token appends, allowing overflow when those later writes exceed
> the remaining space.
> 
> Fixes: d1611086e005 ("arm: add support for SoC s5p4418 (cpu) / nanopi2 board")
> To: u-boot@lists.denx.de
> 
> Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
> ---
> 
>   board/friendlyarm/nanopi2/board.c | 49 ++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index 4dff32e10d6..eb10cd5143d 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -328,6 +328,7 @@ static void bd_update_env(void)
>   #define CMDLINE_LCD		" lcd="
>   	char cmdline[CONFIG_SYS_CBSIZE];
>   	int n = 1;
> +	int ret;
>   
>   	if (rootdev != CONFIG_ROOT_DEV && !env_get("firstboot")) {
>   		env_set_ulong("rootdev", rootdev);
> @@ -347,49 +348,63 @@ static void bd_update_env(void)
>   	else
>   		cmdline[0] = '\0';
>   
> -	if ((n + strlen(name) + sizeof(CMDLINE_LCD)) > sizeof(cmdline)) {
> -		printf("Error: `bootargs' is too large (%d)\n", n);
> -		goto __exit;
> -	}
> -
>   	if (bootargs) {
>   		p = strstr(bootargs, CMDLINE_LCD);
>   		if (p) {
>   			n = (p - bootargs);
>   			p += strlen(CMDLINE_LCD);
>   		}
> -		strncpy(cmdline, bootargs, n);
> +		ret = snprintf(cmdline, sizeof(cmdline), "%.*s", n, bootargs);
> +		if (ret < 0 || ret >= (int)sizeof(cmdline))
> +			goto __exit;
>   	}
>   
>   	/* add `lcd=NAME,NUMdpi' */
> -	strncpy(cmdline + n, CMDLINE_LCD, strlen(CMDLINE_LCD));
> -	n += strlen(CMDLINE_LCD);
> +	ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", CMDLINE_LCD);
> +	if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +		goto __exit;
> +	n += ret;
>   
> -	strcpy(cmdline + n, name);
> -	n += strlen(name);
> +	ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", name);
> +	if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +		goto __exit;
> +	n += ret;
>   
>   	if (lcddpi) {
> -		n += sprintf(cmdline + n, ",%sdpi", lcddpi);
> +		ret = snprintf(cmdline + n, sizeof(cmdline) - n, ",%sdpi", lcddpi);
> +		if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +			goto __exit;
> +		n += ret;
>   	} else {
>   		int dpi = bd_get_lcd_density();
>   
> -		if (dpi > 0 && dpi < 600)
> -			n += sprintf(cmdline + n, ",%ddpi", dpi);
> +		if (dpi > 0 && dpi < 600) {
> +			ret = snprintf(cmdline + n, sizeof(cmdline) - n, ",%ddpi", dpi);
> +			if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +				goto __exit;
> +			n += ret;
> +		}
>   	}
>   
>   	/* copy remaining of bootargs */
>   	if (p) {
>   		p = strstr(p, " ");
>   		if (p) {
> -			strcpy(cmdline + n, p);
> -			n += strlen(p);
> +			ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s", p);
> +			if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +				goto __exit;
> +			n += ret;
>   		}
>   	}
>   
>   	/* append `bootdev=2' */
>   #define CMDLINE_BDEV	" bootdev="
> -	if (rootdev > 0 && !strstr(cmdline, CMDLINE_BDEV))
> -		n += sprintf(cmdline + n, "%s2", CMDLINE_BDEV);
> +	if (rootdev > 0 && !strstr(cmdline, CMDLINE_BDEV)) {
> +		ret = snprintf(cmdline + n, sizeof(cmdline) - n, "%s2", CMDLINE_BDEV);
> +		if (ret < 0 || ret >= (int)(sizeof(cmdline) - n))
> +			goto __exit;
> +		n += ret;
> +	}
>   
>   	/* finally, let's update uboot env & save it */
>   	if (bootargs && strncmp(cmdline, bootargs, sizeof(cmdline))) {
