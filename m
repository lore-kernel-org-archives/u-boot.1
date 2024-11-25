Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0E6D58D40
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3375899C1;
	Mon, 25 Nov 2024 14:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U8v2Hj7p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E6388DB6; Mon, 25 Nov 2024 08:29:00 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C64088C9C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 08:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a1833367so574755e9.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732519738; x=1733124538; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37TVcGEi/mbFLVDGyAErFbEr6tFxVSPAbOv4VKh3dQ4=;
 b=U8v2Hj7pqf+ZdlNckdKKDXeHCqyXXFnHepeANNcusMzfZUzuEQS/1UxJGH3ZmMJktH
 RZbvtVukLCeCiCi4L7C1dSVpA+nLKf2Xak2sUtVhcHnDmVZsD40jzjylEEGHTALeBhIb
 NqrBtFC3Vb1CWfaJlbFCZdwL6hyZS7sER9yM6ceAoP6U+D3GZ8LzASy5kixWM7ztqfOi
 rP3+WCyjmxCA3GMTtO73oCuYdiPQJuJqYcU0HNkMo09aqCNET3wMmg7wAonf0e4DRl3K
 pj5lDxUCZsDQXP/A+WtKEPwWhsT3tYHHX8Hd8Hj5jvtfviv13uMz7ZUvaZQv0A7SbxhV
 sm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732519738; x=1733124538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37TVcGEi/mbFLVDGyAErFbEr6tFxVSPAbOv4VKh3dQ4=;
 b=Ip13+hLBXGz+gF2jvMImmvegrgLPW0uXiNEIlcjUObEBUkKmPAH9AMgfyISnM6WCT3
 BCOr2mnlAwee0Rl20Ou83o1AkHs/IcqJ/QPF4vpLNEMEnc7ffc1DeQC5Jji8Z9acqg4L
 VAzqWLknifoOHrIKK+wlXZNgGjexPIG/AI0amY+T4sH8bu5Az9p1/ZUtYwbHhhy7ZFZe
 72LpPCCS/j2IzMuuQkjh0HrTORsQO+CaoufhHiTQRt/N2jMe78WhqmCED7kaf9+MXLlz
 MDeObInc2zpAO5SU5Fo/G27VioU4rJBJz4EiYQR4Viswx+DpPi7lGoK4ZJLr9wRjCwJk
 +xQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/rU78rg2GGKYntlOZMjaIBl8LHiJxddiyDdMiYqxNW1sWFFSQ3d9+DWOTKIfr3eXRQf83/6I=@lists.denx.de
X-Gm-Message-State: AOJu0YwhJ9SCyac33Za7ufzcBecnHNvfxvN8V607VKGcmvVjYgt3N+iE
 Uv/X5i5IFInvUOARltl6h93d+D3/2hQYjpq9me/3XuVCn7BJwyQUeHGlL93WnKg=
X-Gm-Gg: ASbGncvsZ7JhRkcEpeVHZ2tQAqIXZepxxzPAZ0HwRAgREcdeVfiawR/vlSWj3Q0duoO
 eNM+TbbZDYpT8FRhydPPenysq3Lb03ySMJIAboW/VeDIYW3kBRELt+70ZkL8in7A8Zh41k6OGEb
 Sl3wMn4EoG5xASebmf6nWeNymtyh30rC26TdRwaty/b2QuAC57NtpG8qFk5AzxYeU51OxSLbPph
 6zFO+6MJEfrzS9aZ7NT/2zX/ejU0NxIhpfk3X+jCXeAP978cpa8aQv0rA==
X-Google-Smtp-Source: AGHT+IGfA8qqqID4f8PEZPZ+SKG8LExfECl+nK28ZBC05U6a/X6xLhTpyLhrOdPdJyWOLiH8Gpnvdg==
X-Received: by 2002:a05:600c:3b27:b0:431:9340:77e0 with SMTP id
 5b1f17b1804b1-433cdb0b3b6mr90328465e9.9.1732519737728; 
 Sun, 24 Nov 2024 23:28:57 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb53858sm9478298f8f.62.2024.11.24.23.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 23:28:57 -0800 (PST)
Message-ID: <a81b811f-3ab2-4399-be07-1231d485d12e@linaro.org>
Date: Mon, 25 Nov 2024 07:28:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix flash part
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Dragan Simic <dsimic@manjaro.org>
References: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Nov 2024 14:06:45 +0100
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

Hi,

On 11/22/24 9:47 AM, Venkatesh Yadav Abbarapu wrote:
> Added support for Macronix OSPI flash parts MX25UM51345G
> and MX66UM2G45G, with initial testing conducted on the
> Tenzing-se1 board using STR mode for basic erase, write,
> and readback operations.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 91ae49c948..a130845d41 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -275,6 +275,8 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
>  	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
> +	{ INFO("mx25um51345g",   0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES) },
> +	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_4B_OPCODES) },

Do these flashes support SFDP? If yes, are the SECT_4K |
SPI_NOR_4B_OPCODES flags really needed?

Cheers,
ta

>  	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
>  	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
