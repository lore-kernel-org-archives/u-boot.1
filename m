Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36634CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA43386FBB;
	Sun, 15 Oct 2023 09:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="di1CBlPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B952C86F2E; Sun, 15 Oct 2023 09:16:57 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E721886F48
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so28868521fa.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354200; x=1697959000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/Op//AG85Ch0blX7e+pS6juTpXV1W8I5S7ep6beW30=;
 b=di1CBlPdBz/o3NlVJY1XCllsvLj/E1pvKj5m3RlFOQ9WPIxoTkTW8KwZ7FbCuN3GsM
 5jejYgiAa9zj2G0lOUP9YC+pzNLZNagJMr685sTvXDhx4S+3lEDjtPLbISLa2Sq3zVS9
 iuGQHujbsCqFKNAyDARKhj2PADflP8/8vBDFHiDcpqvngGkN+f9sheqvVJJ/iuFycfFr
 fH8hDQEJ4+2vcGmhX9usgdcb6QYVjoOnUQxqqo/q6GxJySirZ9wxBprQaU3nGSPmaKow
 e6KoYRW1UW3XGmY02/Al00cngCuccwAJ/kuZ1IXcVilprpGSeEW0sDCz5qgTJ7w7kX3v
 /BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354200; x=1697959000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/Op//AG85Ch0blX7e+pS6juTpXV1W8I5S7ep6beW30=;
 b=q4B1Lnmb+t/eb+MLnc5YFPXbl6d5zKo3EzEW616Bl76XiXNfwX9aUcrP2DFLiTUXZa
 To2Bpl2DR7ahqyqZpZqyWcQfGOcQTFKkUzaHc/loaPKP+frmy5b3SsAtEZnoI9cwCMI3
 TI4ksb3iIaXUxLRMvMKvybOLA+5Du9JdZrRmTZWvatowOz/49V7HscMQRHBl/FUwgFL1
 l+S+LbQ1o3OyPJdlAFoykNJ8tKJLbhf87Ks1pn6tcWyWuAQPGkAzze4JkfTyp/XHL0q5
 o3SXCqK//Z2d36zAmopIp31qSIPqWyLjUWudL6UxYa6rr6paXspDfiz0Z/9QYdtEfxt5
 jCtg==
X-Gm-Message-State: AOJu0YyQyrtwnuv8/X6n4vhfiym3zHP1p+1gFGETjD8ExNL4I7XgqDm1
 s8YAdIL+ajGa04p8bbOMQAgGF1KyBC+r9A==
X-Google-Smtp-Source: AGHT+IGPMbBM3y5aewgC/w9Hw3n+PQK0flTi59sbJbbFZvMTCeJDMJqKMBQ1p7wcfzBLyubCl4Stmw==
X-Received: by 2002:a05:600c:2a4e:b0:406:3f62:e591 with SMTP id
 x14-20020a05600c2a4e00b004063f62e591mr26753316wme.41.1697304259318; 
 Sat, 14 Oct 2023 10:24:19 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 bd10-20020a05600c1f0a00b004077219aed5sm2510350wmb.6.2023.10.14.10.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 10:24:18 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] sunxi: H616: DRAM: refactor mctl_phy_configure_odt()
Date: Sat, 14 Oct 2023 19:24:18 +0200
Message-ID: <1965763.usQuhbGJ8B@jernej-laptop>
In-Reply-To: <20231014170236.16211-1-andre.przywara@arm.com>
References: <20231014170236.16211-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Dne sobota, 14. oktober 2023 ob 19:02:36 CEST je Andre Przywara napisal(a):
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

This looks much nicer.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/mach-sunxi/dram_sun50i_h616.c | 84 ++++++++++----------------
>  1 file changed, 31 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 7e580b62dca..ba5659d4094 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -241,61 +241,39 @@ static const u8 phy_init[] = {
>  #endif
>  };
>  
> +#define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
>  static void mctl_phy_configure_odt(const struct dram_para *para)
>  {
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
>  	dmb();
>  }
> 




