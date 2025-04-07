Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EABC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 19:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A280682B00;
	Mon,  7 Apr 2025 21:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7widC/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4E0482E76; Mon,  7 Apr 2025 21:55:40 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2D181F30
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 21:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1efc457bso2736678f8f.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744055738; x=1744660538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vCAv4M5/EL9WFmG8IjOTWlEz+k9begXj04pZzkD3nxg=;
 b=j7widC/ISRrHdlDbaFV09d8c8SCLAhHR2fhWUSw4mwMMSf2GRQeCh4bMspE2x1pt8r
 c51ejA2nORlgXjMGNCUO7eAcWuRlTpA8n9KBbI50mXz+C1gleZ6bhzIsfkAOLsE4qxk8
 2hz/TUdboTFSA8jR2PPR7kbrd8iGm/35EAzRJhfUqbTJlMchtfer56jPquK07kUQmlc+
 JBWxo7EfZKVo8wEDGB1nRdE8X37XDxlANwdZ4nB8JjFWdbvNARHCYOIAObkYj7uNVpe3
 Y/XbDrJ1NkdyhaOIrWa1Faw3U+E/t33MHUeTQ/1szy7eK35CLOylQL/fGdTHG80oTXv5
 yElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744055738; x=1744660538;
 h=in-reply-to:content-disposition:mime-version:references:subject:to
 :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCAv4M5/EL9WFmG8IjOTWlEz+k9begXj04pZzkD3nxg=;
 b=gGdTJQbQMelY3/3X8e4dSWxNfsU0rbZo3RPrtEqJL0s0rGLgJpDZgS2377Dt6qZ4f/
 Pi1sTvMBbxTBXmA2bHDNjoOQtD6Z0xDHOOKOYQzxO5N+8uCaSkNd9ITlsCP+FvGxZP6x
 dHsJcm7qo5oL6lsGeXmte5HQC4UCGECBkUa/JNCGiLoPSHpiS+xnhf7CtsRWn8BfsVyg
 EsLDQO2QVBRn6JlLQagK/W69dR++0KQg3XmgCa6fQqr0fQozJrwlojEfKaJgg9O7xGYc
 0/3tzJgcEfcvU5Gf9SSrdq8hYUYSqul/LN8ytn5vHYnG8N56vbM5zT2UcFweAwvGWRmb
 GOOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo2lSwBWyjno2tYbBxGhHhmNjHh5B2gN7uXEkoje1AEYsC68aZKQqOqfq2LTTuiPT+miy1gDI=@lists.denx.de
X-Gm-Message-State: AOJu0YxNf9sl2LHqRkAGoRGBNEA85KRzb6Qe0bJ2XHNWitC3pALvxkBX
 13hd+cZIpJLebvNkZ6HCPowFnVvUzzJTzAbHIcqskS/S2DiFwIgE
X-Gm-Gg: ASbGncvyMIf8rxMaZzV/GhOZeYLwxl0tp06Jt97f5qvNeZEFIWkkyNVbL2TC5V6lmD2
 sj6jaYIb/cZIkamPTyKMYQKKTsyfC3NxDLvS06lfJ2Q9IYZ2Rjk3YtUT7Xegk45NihUxI9dbPR9
 5mpn35EEQrrnYkS93ZrMLTyNnrCtNdm2eM1SXeQFOBW7lvENLc/I/CWmcRJkoWmMF7clC80ouNG
 07wjsFAN836/f4xj0CfLAcH8Ge91Cam4Cf4YVI6d+eEwdTiGVUuMBfuSup7yfxIbaHxiDD4PhBS
 oBqNzvLisnBeExMB3lHsdgMFBO+uMc1rz1J5yFOC6PdyXYOOXdtr64E/uyoQyOgw1DE/lsgvjD4
 x
X-Google-Smtp-Source: AGHT+IFLXFpOgQ2XDyPDn75rFomFDkjCXY5Yz8XQOr4FG+JgkC9xbqUlY+NpN9zAc0dtlQbvCyoCbQ==
X-Received: by 2002:a05:6000:1885:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-39cb35a87e5mr11527912f8f.29.1744055738073; 
 Mon, 07 Apr 2025 12:55:38 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30239813sm12785903f8f.101.2025.04.07.12.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:55:37 -0700 (PDT)
Message-ID: <67f42db9.050a0220.16b640.abd2@mx.google.com>
X-Google-Original-Message-ID: <Z_Qtt5QoMVxMugor@Ansuel-XPS.>
Date: Mon, 7 Apr 2025 21:55:35 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tero Kristo <t-kristo@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
References: <20250315092420.793-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315092420.793-1-ansuelsmth@gmail.com>
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

On Sat, Mar 15, 2025 at 10:24:14AM +0100, Christian Marangi wrote:
> It's currently possible to make the bootloader crash on calling
> clk_set_rate caused by the loop in clk_clean_rate_cache.
> 
> The loop assume that every child of the clock node are also clock
> device but this is not always the case. For example it's common for a
> clock to bind to a reset device or also expose a syscon if the clock
> register map is also used to apply special configuration.
> 
> In such case, on accessing a device as a clock, the bootloader crash. To
> correctly handle this, check if the child device is actually a clock and
> ignore otherwise.
> 
> Fixes: 6b7fd3128f71 ("clk: fix set_rate to clean up cached rates for the hierarchy")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> RESEND as there was a problem with email To:
> 
>  drivers/clk/clk-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 353ae476068..8f3309d9530 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -554,6 +554,9 @@ static void clk_clean_rate_cache(struct clk *clk)
>  	clk->rate = 0;
>  
>  	list_for_each_entry(child_dev, &clk->dev->child_head, sibling_node) {
> +		if (device_get_uclass_id(child_dev) != UCLASS_CLK)
> +			continue;
> +
>  		clkp = dev_get_clk_ptr(child_dev);
>  		clk_clean_rate_cache(clkp);
>  	}
> -- 
> 2.48.1
>

News for this trivial patch?

-- 
	Ansuel
