Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84421CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC9C88140;
	Thu, 11 Apr 2024 05:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AEsrVRpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279B7881B7; Thu, 11 Apr 2024 05:13:57 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0933888140
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-69b16b614d7so21609666d6.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805234; x=1713410034; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y6IDY9r28jy4PpAwCg3WwRrFg02N35q2BKDf/EdKr0c=;
 b=AEsrVRpP19LwFxlPhcyeWU5Xr1l/65oGPrwSgagXgGwlJWXib6SLK5K3x22OR0hC9n
 Rro0snsz44renPZhuR6GH+8Y8zqgk4NSsAc19T+ICIF5f/Sz7A34047Dbr3X/IdcJi/1
 PES2+Ysulqevlr+xGZ1Fi5diO8zWVBSkdh+WHVfQgjBewlGWuj4D3DyrK/rpenDq2uSy
 z31W7TkRv0mtkBih/3BZXGWeZFr/ZpG0Kx3NEsY3VyzFdz6+28lAH5GN17nVt6T3nTUp
 vZyMON7TDRZdik9wVX3oGff15Dn80CM4lYIDhAN0kvccqEcApwaxl/dg5B+4sFEQ/DFu
 NGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805234; x=1713410034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y6IDY9r28jy4PpAwCg3WwRrFg02N35q2BKDf/EdKr0c=;
 b=sLY8lqJ5HWGR115pWorzjAkUSQxl0J/FbGPKYc5AEe3eQrALol4096dkX6Gn7vM8va
 fq03CmUvzVb7ebR679yCN7pVRaXNzokqOCCMM9iSd51j0/hVGB0/yevIM5kMZ+GxGZfd
 QwBjN2plzjEzewGo7qRybxjohhDOyHauzM9Rl44OVL2Zmq7Q/rw4P/FHIx9gqK8/69qq
 Q6/hLIMJpQiw9Zi+5sRHy/N9ec68gVJ7HmZkX4zNoKxU1pA+HB/sQ0sGB4GQ7pzepsvP
 pbsYQvJ539wVSUXa+5nSNDyA6Gsp3KcKG0AywRqlIDGqiHaUn9MWXKEBzf+V2+b/OHP6
 DD/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsVadiv60gC2xjuroetrwPwz70/KhsgxLErExzaYnWIzDCMkJkG2Ix4yk8X9Sv0JBvokrw4B9D8lVD6mk2xVPq0MVUIw==
X-Gm-Message-State: AOJu0Yxpz8AtK+2xvdpAlAR3HdTdbx+qpGUXi9Ox4zjim9wlQ54SijrJ
 waSbS4e/WqKgn5AX4aZoN17R42+S2Ts9eJq4UclzCvgap2SQjNre
X-Google-Smtp-Source: AGHT+IEHohgv4DsC72v2l2GKolEXuwU4M4ayRTLA8OvYQLT+zWi6g/Vr80Y2TcEabanoSpP1ALZPJQ==
X-Received: by 2002:a05:6214:c67:b0:699:3922:4739 with SMTP id
 t7-20020a0562140c6700b0069939224739mr3209782qvj.44.1712805233906; 
 Wed, 10 Apr 2024 20:13:53 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fb12-20020ad44f0c000000b0069b424437casm369941qvb.84.2024.04.10.20.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:13:53 -0700 (PDT)
Message-ID: <21383552-6c1a-861e-3f33-ac0a2f4acaa4@gmail.com>
Date: Wed, 10 Apr 2024 23:13:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: sifive: check wrpll_configure_for_rate() return value
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Lukasz Majewski <lukma@denx.de>
Cc: Green Wan <green.wan@sifive.com>, u-boot@lists.denx.de
References: <20240216170601.277015-1-heinrich.schuchardt@canonical.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240216170601.277015-1-heinrich.schuchardt@canonical.com>
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

On 2/16/24 12:06, Heinrich Schuchardt wrote:
> wrpll_configure_for_rate() might fail. We should check the return value.
> 
> Fixes: d56d79ed27c6 ("drivers: clk: add fu740 support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/clk/sifive/sifive-prci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> index c8fb6002907..a950736f11b 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -209,7 +209,9 @@ unsigned long sifive_prci_wrpll_round_rate(struct __prci_clock *pc,
>   
>   	memcpy(&c, &pwd->c, sizeof(c));
>   
> -	wrpll_configure_for_rate(&c, rate, *parent_rate);
> +	r = wrpll_configure_for_rate(&c, rate, *parent_rate);
> +	if (r)
> +		return r;
>   
>   	return wrpll_calc_output_rate(&c, *parent_rate);
>   }

Reviewed-by: Sean Anderson <seanga2@gmail.com>
