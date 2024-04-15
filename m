Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93AEC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4B0881E7;
	Mon, 15 Apr 2024 14:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="khvpMCqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53EAE88193; Mon, 15 Apr 2024 08:53:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644D688173
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4186cdae96fso1466015e9.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713164033; x=1713768833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPD/dPkJnoOhLVlF8J4Exi1O2HrGLuI3Rc9MheEd+oo=;
 b=khvpMCqbStle4cp1O7p/CopMRoDK8yFZ6kgvDD5u40/LNrccsQNqXJ9qKNSLCCUJiQ
 sE7yH8h2AtY2ZZvmvJ8FUyzfP7dOQpCzwhxfx0AuCbgF5PAVN960Weo9bMhbZp+Pi5I2
 woymRqV2L+ntnTjeMtQ4Dop9d8Vdhv7f8KAszanUNi7lY6+o6P/qqc3D8gR9RoCMldzu
 1hIyif4PFuBOldEaYLFcW7yz55YtCaAm/7NakskATAUUE+XlnZM6g8WbjDMLUcwv22CN
 P1QDImumWux6/VhfdgECab4RKukqkcV7RJNgDpgJHipaz5inKp9JF1m7dIceG3xhyy5X
 2InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713164033; x=1713768833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zPD/dPkJnoOhLVlF8J4Exi1O2HrGLuI3Rc9MheEd+oo=;
 b=PNUhV5KW1QwRqI0LaJ6TeDQy6t/EE3JIxKVH2BgIjJ+kDR9SK6y0DDlHMzT+PVQeVs
 +0CHrraen+W1CqdqAFuOxpLMcpBXlhe8MhaPp15/nyRKzbdLY+bFQ27C6wIPdumOP5BT
 TBEGE4Ui5qUNSrjsBBkRcxSv5xZvoxckbRGj6d0m8kYCxjsWb64ImgzW+GOnOKBAXlq7
 5rsdKW3ZFsiemvDzqjJjreGnsJePMOU3RlTSQhBl5MfU/qq94sXifIn7dHySoGeEbSQB
 BpGxNVNyJiDCfabTYCYITOWfHxI/QYzmRcm0HnheZevuAqsR+OX6/R3hgZYxV0dFPYG2
 McOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSwFZiVWBu9RPPl02VSKivMrVtalA6g1um22A//r+hCXjekXH/UYvejdyqdlXrJGLdHJSHYOt4U394gA9t1bMuTADIxw==
X-Gm-Message-State: AOJu0YwOSoC87bJjyTEtBeJYpBH6Rck+UA1dce8Hur6NvcyFMVOJVF6Z
 wNDAxGFN5iURkCg3Qp1ga5eiiyV2qxHbc+0z0iX8Sgh8/UbkqxbKt7unkq8igm8=
X-Google-Smtp-Source: AGHT+IE3qlkMdfTFYbL2i/DIpd7rm8LsEiM8QpzCYmFtolLStHtTp9YrRvTs6zm79lGGQWh5rOqjMw==
X-Received: by 2002:a05:600c:4708:b0:418:3b9a:62cc with SMTP id
 v8-20020a05600c470800b004183b9a62ccmr3318140wmo.15.1713164032860; 
 Sun, 14 Apr 2024 23:53:52 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 ay8-20020a05600c1e0800b004181c91d1dcsm8792404wmb.18.2024.04.14.23.53.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 23:53:52 -0700 (PDT)
Message-ID: <7e46daa1-9824-4cbe-94a8-f2654c2b46f6@linaro.org>
Date: Mon, 15 Apr 2024 07:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: spi-nor: Set ECC unit size to MTD writesize in
 Infineon SEMPER flashes
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <45f73124ace6e2110cbda2eee9ba44b1320feeae.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <45f73124ace6e2110cbda2eee9ba44b1320feeae.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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



On 4/15/24 05:33, tkuw584924@gmail.com wrote:
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 8f371a5213..773afd4040 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3459,6 +3459,13 @@ static void s25_default_init(struct spi_nor *nor,
>  			     struct spi_nor_flash_parameter *params)
>  {
>  	nor->setup = s25_s28_setup;
> +
> +	/*
> +	 * Programming is supported only in 16-byte ECC data unit granularity.
> +	 * Byte-programming, bit-walking, or multiple program operations to the
> +	 * same ECC data unit without an erase are not allowed.
> +	 */
> +	params->writesize = 16;
>  }


Use late_init() please. Looks good.

ta
