Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF86CF3C24A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D008C8063E;
	Mon,  9 Mar 2026 14:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x8JbKDnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7CC83A8C; Mon,  9 Mar 2026 08:57:44 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F21F83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 08:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso3908265e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773043056; x=1773647856; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90aigoh5G0bigFS1z1ZbzHtYkuYgx3xJ218RPNt/y7c=;
 b=x8JbKDnSi+b65JtvVyGBDhJYkmsCxBhopCpwvZFgpAo28iy+PR21u+2UpDX7eM228c
 K6BJ+T24OD9giMTyQvaO7v2WIhXvdE59mmFeBgeB5N+CuP2ChnlcDvOEtEHOS6mldrap
 Srlj69vA7GBpWCSOJExh+FoAFbA1vikVG5obRx0jCKBLDygDD7iUb8wwqnDb0o4VqW8M
 VFLVB2dJE98VjYp13xGHu3l5sAa/5JDX6ccuQ0RSVg5rpN+80yXA6l9jDSXfagBVMefi
 gP7diZ2IULXs3K2ON+gt+0op0Li9gFr4WmqrrRBDEN0Ul/eNCHSz4XUf3KE+O86Qlsvi
 PByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773043056; x=1773647856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90aigoh5G0bigFS1z1ZbzHtYkuYgx3xJ218RPNt/y7c=;
 b=nO7tOp+u05GFk28JCjUN6cwpmzuo5aJNOD4Wr5gxlkiLX4jCYofC+TTeC4fSIgRww+
 8DvoEX0cyOH60cINSqQG/ZBkcZaW/HGEyeD9HSMzZx2ui5hDRQ0S6TyC/BN7aUJLe8yz
 K7COqgJpl8uPZpZ91OOOFJDL06IIc04Y7cvuuaDqQtl9GP9OPWRez7XoDxtmg5wYE9yf
 yfDozfmjIHgpxACNDP5L2NFb90y0zI/5TgIiU4p2QhVx2FQJn7fteJRyU4qJUz1fi7WP
 A7tSxIuj7u4F1tEweomUByfTuJj3PMs2FmEgUCv98NcOzqk7EkJ8jFrXvALgLDrGZzCP
 mWBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnlRI6BjHce+PQLDbuagtroI8nAaKxuHKGnNDPzE4f6cNPss8ltQuMs5uC0ho4tCvr6fBWS1U=@lists.denx.de
X-Gm-Message-State: AOJu0YyOAlhFiPAFHbUV63ERs9bk/kn/0rs9AG2AOnVmylNBL7m8S6fl
 0Jr+U8N0yFLOT512zxjXoxKvScA0+7MLnTkN2YtyIAXxWISxkG2ES6iLLwkCwBTMGnY=
X-Gm-Gg: ATEYQzyvS4hTET1jSqlNN7+/TpLIQCadjwS4tPc8hG0ucFIKSetootM6MDb/emBqjTd
 3HmfWe9NyO+ggaOhTVPUNwuCIna6b/+WZxp6+dO/jY+nO8cWDV0QiZUQ6CWiBVgl7QPiQCK8F+M
 3uNMC3dYVvNqpMCoBoQSjSVoCubylQPXKy+8NwshiE8U87q0vPrubR0WLDKKLr/Cn4n+qcKPesM
 d3PaPAWx5uSO4lYUeYwcXVMl+b2I9VzLvbhsmgrgqAsp2iTlvSdFMNIFpI1mp8lzh83oe51rect
 Ci+0nOEJ5cW8Ju5cDNZcxPodJRFJFqKiGoAzBKi/2cPTSKs7yoHX7DQQd8Y/cV5iqiIFCjJJsj6
 gbhggHTrkO1G+7JsjjSBVXZf87cftkWnoYrGfdArmvbkvdyuNyxOdPXVLROuYpWW4/4JfHdXMg1
 DaQugTqZ/AYSzQjPFdjrpAGPyFbJe8QZ0=
X-Received: by 2002:a05:600c:4445:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-4852690fffemr186663195e9.1.1773043056341; 
 Mon, 09 Mar 2026 00:57:36 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686bcesm392693905e9.7.2026.03.09.00.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 00:57:36 -0700 (PDT)
Message-ID: <cf08c88a-2152-4b55-a358-08b0597d86ea@linaro.org>
Date: Mon, 9 Mar 2026 09:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update SPI NOR reviewer
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, vigneshr@ti.com, miquel.raynal@bootlin.com,
 mwalle@kernel.org, pratyush@kernel.org, marek.vasut+renesas@mailbox.org,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <20260309011251.11462-1-Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260309011251.11462-1-Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Mar 2026 14:13:06 +0100
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



On 3/9/26 3:12 AM, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Tudor Ambarus will step down as SPI NOR reviewer.
> I would like to take this role.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 920da147e6c..d2040fee252 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1754,7 +1754,7 @@ F:	drivers/mtd/nand/spi/
>  
>  SPI-NOR
>  M:	Vignesh R <vigneshr@ti.com>
> -R:	Tudor Ambarus <tudor.ambarus@linaro.org>
> +R:	Takahiro Kuwano <takahiro.kuwano@infineon.com>
>  S:	Maintained
>  F:	drivers/mtd/spi/
>  F:	include/spi_flash.h

