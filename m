Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6A2D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 13:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FFD83C28;
	Tue,  9 Dec 2025 14:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpIMOuLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAFDB83B8B; Tue,  9 Dec 2025 11:16:38 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2201D83885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 11:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b728a43e410so725147166b.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765275395; x=1765880195; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0L7AF9WaJJl7kh7e3ugNXPsZIy48Vebx+ZpG5vvUCc=;
 b=IpIMOuLYPnLVpL1sxuuw+0NOBooEl3DeHFQ4jr0D/PUk6tvQ/XMZfPynG1kyrkcGhD
 3wcytPR99j9EkL8K3r7kKwHCwo2xPoMv/c5NkRTtOQaTojPbZau7tub4MNwOW4ODueS+
 ocnXF4DazqW10Qv1EaAa5bdlIcEJPlTew8hNB+XKdlmd5SVXVSQuZ/scTAc58nqTeAen
 KERM6lEUbNiNnklqRyU5xjsMr2Bae8YY8I/+SGwlXFSi1tK0bE7Br5I9QOh4UMsV6yBK
 kFd5+7iu5JLSKjknSjb8dsXohY7Yip5KHNVvOFrSYFfYN+d9mfS/f16mvEJK1R9ism6n
 Aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765275395; x=1765880195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0L7AF9WaJJl7kh7e3ugNXPsZIy48Vebx+ZpG5vvUCc=;
 b=gq1cf1OBICZY0//3Mki22E01BF9KMybaJWgZRJgEUgjJQNWlhjLroO4NwAgF9JcWxZ
 0btYizeMB23EXtGPhMQNH1q6fKlOcEVGYu9pBHJS18RcooEB7NcClAoiZ8enFBboEvfE
 axJDzXV2rZctpB7DXbUXaAc2jz7FvE8nGnSoB7s4Rk4WmL+I+0eHYYyJCiy1h/lGFVSd
 X1YejXe+iAtCt4+HdhHukyw8Fukvvp7cAQB/NF+tDdba+8TFuDtN3dAiTbFzSCIGVI30
 0hG1fZqBrlQsoeixr6Ys7k9ff7jsGft6VBS4kAK4pvtRNiNNAlb2mC61as/QoUmddSKI
 Z/oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN36NWC9gyifO3BNXxSrrUFa4hJWQxwBNZ0VlYcidJXHYJMNXuPmbSpbUzGfBq/5a6sBI2ME4=@lists.denx.de
X-Gm-Message-State: AOJu0YwWn8X307mxIqAs1WAC/zpyqh7x7a2wkMxuHjgxrEPga4VezjxU
 NG509l4giC9Kwv5Ot+SEfgZ4JTOj/NK9YBDiIpO2EjafVDd9anla5sg5Ux0HMY0RaaY=
X-Gm-Gg: ASbGncuZ0qBh7nlIDeoAi0rpOOALFIQqWPGZQ1dmGA3TAnsz6T5nUJrhdub4WzMdWZS
 Kv74+qEolVWTDGv9e62vsxtUu9q/kM5Scl9GyXcKESxkqxPu7ZJR62qty0rRU1lVSkJBOmW4L8x
 YiXAbP/SHf2eeVpnKtgk90/FToH44M6EqUqnnyrM8FqCqheS9djgloKcfbTRXbSj6+6SBUJwncY
 YeWUmt3V0sVrtD03iO7QwtGx4JRxDzokqc9ioHbqal9TbH6+QRZF1wZVZlHl2vmqukGaDppStn+
 ORMs2ZU+mwo2Xuiu4pTqnsgTH6P8XJKTHC4EkLLMRMcZXtoSPa7S7taVmOcxKhp2jb7jdO4F8Hm
 WCsSchATIDsYUl4O7jzUusFhTAhD0fWmcsM1fSPEIKIU3qNHQkToc6t2IoHZ48ikppVq5LAzDoB
 +ckT/6NnJH0qj1xKY6
X-Google-Smtp-Source: AGHT+IE49R0se4yYQRR2aJ2uSEsGd8SmkWDnPimQ/dfk41CZQSCIvfoeOG79ruFg7YMRrGqrnTCU2Q==
X-Received: by 2002:a17:907:a08:b0:b7a:32:3d60 with SMTP id
 a640c23a62f3a-b7a242d4a74mr1022461366b.11.1765275395421; 
 Tue, 09 Dec 2025 02:16:35 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4498797sm1335577666b.19.2025.12.09.02.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 02:16:34 -0800 (PST)
Message-ID: <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
Date: Tue, 9 Dec 2025 12:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 09 Dec 2025 14:28:33 +0100
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



On 12/9/25 11:56 AM, Francois Berder wrote:
> Free buf if spi_flash_read_dm fails.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  drivers/mtd/spi/sf_bootdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> index 017a74a3016..720faf51a1f 100644
> --- a/drivers/mtd/spi/sf_bootdev.c
> +++ b/drivers/mtd/spi/sf_bootdev.c
> @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
>  
>  	ret = spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
>  				size, buf);
> -	if (ret)
> +	if (ret) {
> +		free(buf);
>  		return log_msg_ret("cmd", -EINVAL);
> +	}


can we use a devm alloc method to get rid of the extra free handling?

>  	bflow->state = BOOTFLOWST_MEDIA;
>  
>  	ret = bootmeth_set_bootflow(bflow->method, bflow, buf, size);

