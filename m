Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412BCC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 01:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E3F83013;
	Mon, 28 Jul 2025 03:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEDk1AXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C46F83045; Mon, 28 Jul 2025 03:13:31 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEFB982F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 03:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-75b5be236deso3095340b3a.0
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753665207; x=1754270007; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kD5MD6RKDA7co1+snM/qTYC+dhNA7NqOkQAv610Uc1g=;
 b=BEDk1AXGpr8vwz2ROjKwynIBCMO8dRT8Y8lwLoTvDoKVOnBe/zD08EZzSef5UbYYPA
 hFl41TadszY5yTwh9UNbMd833Nq60K92v6D72rLkdAsKcOlMDmD9cRAq3k6yDhy0mrFr
 d2ycNnVILK2tpN0e8fUUcUPhHNJ4kQ8fGJ2qtTi15UPi1sC/CN/YztLNYlHiRfRnF4H8
 nkmrMPK3pnjuChbQyItlhEGEiBcL0OJNVqnjAD34rRrFVDqdMiBa02TXIv/SARUMTP/X
 YPuv+qhdI5PW4frcFOxk7DSlIhQfmDBgvhbgP2iDK8bxhXY5VeXnDNkjBxdmXNPnpMah
 2U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753665207; x=1754270007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kD5MD6RKDA7co1+snM/qTYC+dhNA7NqOkQAv610Uc1g=;
 b=SAP86C4y4b+mb9wplRdFhATfzNvsoF1hNdkkX0XkPpA/wmgG/U37gg2bYA1hxP+2Os
 fBbOuGdCa6CUHItLn5/ws1nugHkmFfP0SOHL2u6cfg3NdQr/zoJUdalxSP8Glx6sxagJ
 XuXKASmuFNbMS8qjnFjdaKpavqw8aovm/KxRmmVaOf8HiNDtJAzvyxwco2eWZRdSRUS7
 QNEsXy26i90Yaj+8Gp6A+DDnI9RiA/Ppiu76HwYRsrevtcTtfVAfGDXg72Mw/55DMJMy
 VmP/GWuzujk61+6soATWDhNN3/Dso4Yoe2pvcjSDthkXZRjlBZzSwr4yvoOMr7WE8lNR
 sxag==
X-Gm-Message-State: AOJu0Yz6EsfuQaWQoDDOmzeHn/Ci1/bFuFZL13sUKOqVQXzRWqQ68FeV
 i772Tb6kqMoBWZOWSEBn3Bo1ll57odPh+IZvJGeEcbKlSUcvvw8cL8sfk1kh+Q==
X-Gm-Gg: ASbGncsQuC2BitSPz4HEO+SDbVgtpgNSHrMLlO5KWmYvjrLu4hpcOht8/ykeTvGYO+J
 orSSGL9sFPZPsM5JemL6FAHVI8pmsJMe8WPPBYMeAJwrAko9/cdcOT34v9E4kxgCpU1yP4oELGs
 55S/mXcbfXSS90wqDHURwOo6i1ign2o+PYl+Ns4Zr46JTJBwI9LpFxNlPNZ7r0uDqSq2TUF1B+l
 kLHtsIpTEgpCKNbIAQDbiSWaJGy+LSWVJaCpB6weIBf3FuFLjjJcvTR0C4q09n2ofvBIETKyJ5s
 bRvfcG/vqbo/S4mCKYT5P3cJztEyUg6JjWgwkYpcSyRt7CBhjq8eRQOC5cfR19euYg5qMVZQzn+
 JXdd7qsfUDIC9ALEwOyf/x3PgdbwUy1M0RNX33SCsKU7lT3keBmAW277br8/dqwq9/LssA8xH+A
 ==
X-Google-Smtp-Source: AGHT+IG26mY08lJz8BeOXbA5ZZg61Ix1yUJOHgjEoRE43U/nBzSKktiGByJIxEstZIESUEI+ebD84g==
X-Received: by 2002:a05:6a00:1395:b0:75f:9622:4ec4 with SMTP id
 d2e1a72fcca58-76334fac30amr14466450b3a.20.1753665207107; 
 Sun, 27 Jul 2025 18:13:27 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640baa8173sm4167051b3a.146.2025.07.27.18.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 18:13:26 -0700 (PDT)
Message-ID: <10a37d2e-87cf-4a48-a430-1efa09dd213f@gmail.com>
Date: Mon, 28 Jul 2025 10:13:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Fix return value of s25_s28_mdp_read()
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
References: <20250728010446.29087-1-Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20250728010446.29087-1-Takahiro.Kuwano@infineon.com>
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

On 7/28/2025 10:04 AM, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> s25_s28_mdp_ready() returns 1 when spansion_sr_ready() returns negative
> value (error code). Fix this problem by following Linux implementation.
> 
> Fixes: 1c3dd193b5b ("mtd: spi-nor-core: Add fixups for Cypress s25hl-t/s25hs-t")
> Reported-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 655bf3aaf81..76c33b24368 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3784,8 +3784,10 @@ static int s25_s28_mdp_ready(struct spi_nor *nor)
>  
>  	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
>  		ret = spansion_sr_ready(nor, addr, nor->rdsr_dummy);
> -		if (!ret)
> +		if (ret < 0)
>  			return ret;
> +		else if (ret == 0)
> +			return 0;
>  	}
>  
>  	return 1;
Please discard this.
I will resend with correct title.
s25_s28_mdp_read() -> s25_s28_mdp_ready()

Thanks,
Takahiro

