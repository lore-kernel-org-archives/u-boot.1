Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7063ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 13:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D102686689;
	Sun, 15 Oct 2023 15:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KpXRn2kT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EA68071F; Sun, 15 Oct 2023 09:15:51 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A002686FA7
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9ba081173a3so563001566b.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354113; x=1697958913; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU5gOTVF7zIwy0IiPCx5N3x2Sa8P8OPrCTYwmCDO+hk=;
 b=KpXRn2kT6Pqa1meH/RvcqWT6jJjBpEmZ7WpREvlSJhlgEesBet/yfi6UxeQLWjXSee
 XyDowyjZobKe/867xXU/HMK3sI2g71tyljZEDUh5Vqrwbyb8bm1voDkaAvTETce/QHPp
 ygMjg4EOubNCSnF83rCoKfQBDdaf7SWUSsVgUkkOv13Y1ROsIgWSfnYBpmHih3Wjk5iA
 DEKt7UPZ5qCSlKLk8943laI62QAuCtQSrAjc1uRaLveqVBC7Xz7d/+D9e0g/Vwwu2dGp
 e4qo3rVi6mE1Mgk1XeUR7XzcVYppFO4mp3uZf9zMVdTwu/jtb2iSTeC2MUD7+FznRR9v
 2kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354113; x=1697958913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU5gOTVF7zIwy0IiPCx5N3x2Sa8P8OPrCTYwmCDO+hk=;
 b=Samw2n5A6JOv2kVQXKCxW9YCrPVZ9hiq5yWl73fwMHhn+J5wOn0gPlXxST5DTHyLbL
 EuogPyNPwWTAT4ht4hQs5nKXf6U85QWk+Mb1vFZ+AgB/gaAB/4TRyVX7JEZ9p3/KMutP
 F1lmUDJXzRkI2rAsVRCTMTUHoHOciXNz7PYxj1JkwHzV8sUl92bAeHcW0tr0XISFdh8c
 iHR7SLYZCeGUiU4VvJ12KoO9VXgoZW9bGs8+i6wvWuUh+eVGGbxVfkEAU9n9zUX+Xf1+
 U2uAZklF790WyM75/lOWthjUe/LZ6e9uJZ8GEjSTJSRQ4RvEaHhGkRsrkN8RKxvEOIja
 teLg==
X-Gm-Message-State: AOJu0YwQRjdpSBdiTPXrIdduRhAIDE62NM48utOZU57GocdUd0FKhq1w
 kD+VQd2A6U9IVMnbW5I2j9yBTM1i31w=
X-Google-Smtp-Source: AGHT+IH8KGedVSbRbiTxY4wF4sUlQWBRjvmf6Oq0dBhQHentN2WibMAM9QgZR0R8BKgZYDNlBRFs1g==
X-Received: by 2002:a05:651c:2127:b0:2c5:56b:cbd1 with SMTP id
 a39-20020a05651c212700b002c5056bcbd1mr5449367ljq.10.1697312358680; 
 Sat, 14 Oct 2023 12:39:18 -0700 (PDT)
Received: from [192.168.100.248] ([46.251.195.245])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a2e9659000000b002bce77e4ddfsm481795ljh.97.2023.10.14.12.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 12:39:18 -0700 (PDT)
Message-ID: <8ce0f3f5-226f-44cb-bd09-ea5033761309@gmail.com>
Date: Sat, 14 Oct 2023 22:39:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunxi: H616: DRAM: refactor mctl_phy_configure_odt()
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20231014170236.16211-1-andre.przywara@arm.com>
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20231014170236.16211-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 15 Oct 2023 15:11:20 +0200
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

Yes, this patch allows to reduce code size and make it easier to read.

To further integrate the code for LPDDR4, will need to change two lines 
instead of adding 24 lines.

Reviewed-by: Mikhail Kalashnikov <iuncuim@gmail.com>

On 14.10.2023 20:02, Andre Przywara wrote:
> The original H616 DDR3 ODT configuration code wrote board specific values
> into a sequence of paired registers.
> For LPDDR3 support we needed to special-case one group of registers,
> because for that DRAM type we need to write 0 into the lower register of
> each pair. That already made the code less readable.
>
> LPDDR4 support will make things even messier, so let's refactor that
> code now: We allow to write different values into the lower and upper
> half of each pair. The masking is moved into a macro, and used in each
> write statement.
>
> The effect is not as obvious yet, as we don't need the full flexibility at
> the moment, but the motivation will become clearer with LPDDR4 support.
>
> The generated binary is identical with and without the patch.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm/mach-sunxi/dram_sun50i_h616.c | 84 ++++++++++----------------
>   1 file changed, 31 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 7e580b62dca..ba5659d4094 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -241,61 +241,39 @@ static const u8 phy_init[] = {
>   #endif
>   };
>   
> +#define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
>   static void mctl_phy_configure_odt(const struct dram_para *para)
>   {
> -	unsigned int val;
> -
> -	val = para->dx_dri & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x388);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x38c);
> -
> -	val = (para->dx_dri >> 8) & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c8);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3cc);
> -
> -	val = (para->dx_dri >> 16) & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x408);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x40c);
> -
> -	val = (para->dx_dri >> 24) & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x448);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x44c);
> -
> -	val = para->ca_dri & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x340);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x344);
> -
> -	val = (para->ca_dri >> 8) & 0x1f;
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x348);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x34c);
> -
> -	val = para->dx_odt & 0x1f;
> -	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
> -		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x380);
> -	else
> -		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x380);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x384);
> -
> -	val = (para->dx_odt >> 8) & 0x1f;
> -	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
> -		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x3c0);
> -	else
> -		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c0);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x3c4);
> -
> -	val = (para->dx_odt >> 16) & 0x1f;
> -	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
> -		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x400);
> -	else
> -		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x400);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x404);
> -
> -	val = (para->dx_odt >> 24) & 0x1f;
> -	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
> -		writel_relaxed(0, SUNXI_DRAM_PHY0_BASE + 0x440);
> -	else
> -		writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x440);
> -	writel_relaxed(val, SUNXI_DRAM_PHY0_BASE + 0x444);
> +	uint32_t val_lo, val_hi;
> +
> +	val_lo = para->dx_dri;
> +	val_hi = para->dx_dri;
> +	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x388);
> +	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x38c);
> +	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c8);
> +	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x3cc);
> +	writel_relaxed(MASK_BYTE(val_lo, 2), SUNXI_DRAM_PHY0_BASE + 0x408);
> +	writel_relaxed(MASK_BYTE(val_hi, 2), SUNXI_DRAM_PHY0_BASE + 0x40c);
> +	writel_relaxed(MASK_BYTE(val_lo, 3), SUNXI_DRAM_PHY0_BASE + 0x448);
> +	writel_relaxed(MASK_BYTE(val_hi, 3), SUNXI_DRAM_PHY0_BASE + 0x44c);
> +
> +	val_lo = para->ca_dri;
> +	val_hi = para->ca_dri;
> +	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x340);
> +	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x344);
> +	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x348);
> +	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x34c);
> +
> +	val_lo = (para->type == SUNXI_DRAM_TYPE_LPDDR3) ? 0 : para->dx_odt;
> +	val_hi = para->dx_odt;
> +	writel_relaxed(MASK_BYTE(val_lo, 0), SUNXI_DRAM_PHY0_BASE + 0x380);
> +	writel_relaxed(MASK_BYTE(val_hi, 0), SUNXI_DRAM_PHY0_BASE + 0x384);
> +	writel_relaxed(MASK_BYTE(val_lo, 1), SUNXI_DRAM_PHY0_BASE + 0x3c0);
> +	writel_relaxed(MASK_BYTE(val_hi, 1), SUNXI_DRAM_PHY0_BASE + 0x3c4);
> +	writel_relaxed(MASK_BYTE(val_lo, 2), SUNXI_DRAM_PHY0_BASE + 0x400);
> +	writel_relaxed(MASK_BYTE(val_hi, 2), SUNXI_DRAM_PHY0_BASE + 0x404);
> +	writel_relaxed(MASK_BYTE(val_lo, 3), SUNXI_DRAM_PHY0_BASE + 0x440);
> +	writel_relaxed(MASK_BYTE(val_hi, 3), SUNXI_DRAM_PHY0_BASE + 0x444);
>   
>   	dmb();
>   }
