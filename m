Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD8CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 00:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDAB88307;
	Sat, 27 Apr 2024 02:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714178954;
	bh=Z0s7HaBk/7Z0yWrk14sSo6jy2ys8a2QTCWqFqA4UOTM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T17AUP15rDyncdI9G8uobQegp2vWqL4eUPpVp+aY2XkbdVbEbCppLIi+DZEvMgrwz
	 f4mz/4MH5dO04CrhUNby/cIh12/v6vnPYKGEfNeJIDSbYNp2/xC2RbLMV0KB2H3RCD
	 jyMlAcJLA74xGNQ45dSdKkIwwGNcDdeRmxyPLGsvGpFeLfeLYx/lQIWoBTlOvZNkxS
	 R34MEX8P0LXuyuw4GC4pnwYG0n6Dmi2cs0g5OAg4ElKC1ZaTUyrW1PCk64mA2yyPcy
	 yHHD0VV8pgazudEohDepqCExCNg0xr+XbavbKWpecswvSqsYnSg/eoC5YjdLs8Z0Kt
	 RqUS1+OL2HicA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 55D04882FB;
 Sat, 27 Apr 2024 02:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714178953;
 bh=Z0s7HaBk/7Z0yWrk14sSo6jy2ys8a2QTCWqFqA4UOTM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lU0fUL94JAynqsKF28Cqr9o0YTG14EPd1m5Z6weTYWLjjQVBVzdCvzozFSnfLNxiY
 YfUe9eYF9Vh9quuVNzXk+3uNEwYTxFvu3vdDvbBpjRcrAe7lU586QRuZhkIvl9pXxF
 CCjHUiflUJXu8T3ut4JlrtH0Tqy52tXLzR8GlrDhOm/Ahfd6q4JGRScCEapj9e31lB
 QMjwiphSWeVVN5ZsQ4kY1ZDRLgGp3Nvqpvysbt3qVoKlciytZrdArv+5GOyvi82epL
 21vvUhiZhTGSDhvUq1Mtt9tHiuyJ3PyI7lxUv2nKtSjLAWj23r2kFS64Cd9LHeNDg9
 Q6dda9lSq0Gpw==
Message-ID: <52d7d87e-19b0-4474-bf75-33dbbc150c31@denx.de>
Date: Sat, 27 Apr 2024 02:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240427001157.1460302-1-tharvey@gateworks.com>
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

[...]

> diff --git a/include/mmc.h b/include/mmc.h
> index 4b8327f1f93b..7243bd761202 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -381,6 +381,21 @@ enum mmc_voltage {
>   #define MMC_TIMING_MMC_HS200	9
>   #define MMC_TIMING_MMC_HS400	10
>   
> +/* emmc hardware partition values */
> +enum emmc_hwpart {
> +	EMMC_HWPART_DEFAULT = 0,
> +	EMMC_HWPART_BOOT0 = 1,
> +	EMMC_HWPART_BOOT1 = 2,
> +	EMMC_HWPART_GP1 = 3,
> +	EMMC_HWPART_GP2 = 4,
> +	EMMC_HWPART_GP3 = 5,
> +	EMMC_HWPART_GP4 = 6,
> +	EMMC_HWPART_USER = 7,
> +};
> +
> +/* emmc hardware partition names */
> +extern const char *emmc_hwpart_names[];

Maybe the array should have fixed size here, i.e. 8 ?
