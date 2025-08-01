Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59742C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE7483A5B;
	Fri,  1 Aug 2025 13:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="a6yhKILA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEF283A62; Fri,  1 Aug 2025 13:26:58 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8F6839F1
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0df6f5758so144738766b.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1754047615; x=1754652415;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXDRGB+rhv8uLdIYNZ3Nq1sRTqkH3oH9PzymKXdA6DY=;
 b=a6yhKILAy+QI4RrLLTDgoV1hig8WSI7oo3TumJVVW+qh/BMO/gJ4gbkrAt7VNM6EvA
 udoUEot+DSopUwz0XNEmpTKRyQFHVsZYkcDpnpr93v/tquulgtNRzj1h2y+lHQXowluZ
 jba37y8AVCufYa1e+4hYUHtr0V+hk6oaU1Momt0j0tVUjQ3FALtqnzuEuPaR1QMBIY2b
 piC31JcmiZzJGzaoF9VNwNr9PcQ9/EmMzmeJ4mylDyaOfG77nc82mf0KWZTgPGNKmkX3
 ts0sH13/mrQEPgQb5AKfcv5X2rP9un7++xpMgGkviiFMHD5QHKvdgvvfLx9c8dPLmyvb
 dA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754047615; x=1754652415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXDRGB+rhv8uLdIYNZ3Nq1sRTqkH3oH9PzymKXdA6DY=;
 b=sKgPWQMCrxvVchuU1IUP7GV+h9F5XEd+F/mCk1DFfplpQOBLhkfKUbB5XPr9gtfll2
 aUhFHwp8EV0vgZeTL0l8JCZEfr+tnQXhlclkPfiKWJDoOopu8heOPA6S0+R+xxm6yGOF
 yfatfKMpUl0Z6nDw8sfmHeO++y/cTANfyp2PHsktRrSsLkO6Dz2jgS8sUnhtpHhBEea9
 Gv4jyYZigjWBPVMMiTrdmK4JzvS4YHR2S8Q0SnlLJDlYqpfAf40H4CLV5cbBWAtXFHW7
 /0ke1LqS+B118Pg1toWozQgDjfScYuH2qxB5YziVNhAyviALW0QgZkvRSddwukeQ0HLo
 1tmg==
X-Gm-Message-State: AOJu0YyJ1p5fMD2mihNs27+Ty2pg11CtWfpslNk9SE/CYEH032yhdFFt
 SGg6izM+zG9/aNPsFKUQ6a/nZtK2pVinA5GIWuL9EccysEX0Ww12N8SC3TYqrr9G1Q==
X-Gm-Gg: ASbGncvG6ofYpSglbZxeyL/JtwB6Zv6mIXIr1eVBCuW6gLzhuF8KLH2DceKyi4dhR8B
 LW2NH2qLBXLWMtUbQrABYBOs+1VE2iux4j+GX6sIWZlw87/GAqrY9RZmh+Hr4FM1FLqMOwjpkjB
 OMvoCgDfJSS9BeSsgiHi7ukB4w0vs5GuIR2PcaaR3a2QGns0YVAVUXV/+WgsOYsZMZp+Rk82DRR
 q7F6tk6SkOaFbCLnO7mQMZywfIfNZJogXlWSBGKLkmZt2FQxx4+X9qpajMMkrCmKWCun8pyOQ5g
 qZMsqKukHUyO/UwZOwGkJ09kwjoxpGsoIhAIMHjfLZHQmcpDb0ItaUkLNYWSMixJ3qqIWZkLYSO
 4RqOPMsJToegUvyPVxgNqDjMcydyYreFrCz0=
X-Google-Smtp-Source: AGHT+IH542bIctYR5OFlWEnepxYLvY36igaE7jVNUEsAShgRqxcW4D2BQxwYwv4JnS45zx6TBryVzA==
X-Received: by 2002:a17:907:3c8a:b0:ae0:c7b4:b797 with SMTP id
 a640c23a62f3a-af8fd9b1923mr1288603466b.45.1754047614807; 
 Fri, 01 Aug 2025 04:26:54 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a078bcbsm276229066b.13.2025.08.01.04.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 04:26:54 -0700 (PDT)
Message-ID: <e7ec8cf9-0faf-4b6b-87d5-8578679a33c7@monstr.eu>
Date: Fri, 1 Aug 2025 13:26:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: zynqmp: Fix off by 1 errors
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250728-zynqmp-ipi-v1-1-b2bd144a9521@linaro.org>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250728-zynqmp-ipi-v1-1-b2bd144a9521@linaro.org>
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



On 7/28/25 17:47, Andrew Goodbody wrote:
> Use resource_size to correctly calculate the size to pass to
> devm_ioremap and avoid the off by 1 errors previously present.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/mailbox/zynqmp-ipi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
> index 851aa737c03..f62277385fb 100644
> --- a/drivers/mailbox/zynqmp-ipi.c
> +++ b/drivers/mailbox/zynqmp-ipi.c
> @@ -188,7 +188,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
>   		return -EINVAL;
>   	};
>   	zynqmp->local_req_regs = devm_ioremap(dev, res.start,
> -					      (res.start - res.end));
> +					      resource_size(&res));
>   	if (!zynqmp->local_req_regs)
>   		return -EINVAL;
>   
> @@ -197,7 +197,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
>   		return -EINVAL;
>   	};
>   	zynqmp->local_res_regs = devm_ioremap(dev, res.start,
> -					      (res.start - res.end));
> +					      resource_size(&res));
>   	if (!zynqmp->local_res_regs)
>   		return -EINVAL;
>   
> @@ -206,7 +206,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
>   		return -EINVAL;
>   	};
>   	zynqmp->remote_req_regs = devm_ioremap(dev, res.start,
> -					       (res.start - res.end));
> +					       resource_size(&res));
>   	if (!zynqmp->remote_req_regs)
>   		return -EINVAL;
>   
> @@ -215,7 +215,7 @@ static int zynqmp_ipi_dest_probe(struct udevice *dev)
>   		return -EINVAL;
>   	};
>   	zynqmp->remote_res_regs = devm_ioremap(dev, res.start,
> -					       (res.start - res.end));
> +					       resource_size(&res));
>   	if (!zynqmp->remote_res_regs)
>   		return -EINVAL;
>   
> 
> ---
> base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
> change-id: 20250728-zynqmp-ipi-0b1791238085
> 
> Best regards,

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

