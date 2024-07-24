Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3DCC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 304D088937;
	Wed, 24 Jul 2024 17:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ifDLUvyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D2F88979; Wed, 24 Jul 2024 17:19:35 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38891888F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so51132245e9.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721834373; x=1722439173;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/PSG8SiyoMLkYB+Y5x8gnENoesZgTTR07MFyQQ/DrM=;
 b=ifDLUvywTQXCmjrMXviDgtTI2Fw/4l+k52gXObf4Ibx1l8Ipk4NjCxhw17/OOp4lUr
 Ke6c0S19Y8f/1mUG+qHArlJ/ZWSb3yymH492cJs7fNJ7e2pDz0FMIqjm08l+EmyLnc32
 bLpbqNtGIi7N/c9IREYt/lgLyS2VbiHxZQ5iBH2s6fbqMWbaW8cmwpntIE2BXP6c78+n
 cOGCmw+TEo97wgKyhjR2xjj9wiVZCZ3XrMlWcwbmEPHl0pEIhYxV7pz03jsOtx7ljhIf
 qGdEOYbMftG1ky7Lq1lonMv+3a8Va0M2SHHYQFb2WoZZ1B/EEBolG85HIG8ZkdZmUpKA
 wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721834373; x=1722439173;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/PSG8SiyoMLkYB+Y5x8gnENoesZgTTR07MFyQQ/DrM=;
 b=JpUxjead8SbNYEgDjxIyGlEt2/EQujQh1a58ruQl+c+y5Jd4ewtCjtJU2HRvNx9PYA
 22ztShqOwe4nvuOkugr/051kgpiDeEjakdax6DlLzN/Uoss57Xt9z/L6V6yWqirqJ3Yc
 4oucbhx4Wu383zm2BccZeei3fJhPei7vtWMsImU6GSq3fNphFuBm+mfQ5yKqnA43VBF/
 3/RgMEWqmeBllqjpsTBNNrJX2hMOJj80K3M73fhmnliESNo7yc02G9LNzOkog3PeBexA
 1IFOoELZZJGB8akTfHpTT/k8OqtvAJacQboe+YVNIpkmDabHJs/xFVzDUmNLPkaezgpN
 FEKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+H/KIKZ3Uofv9v2FRKlSH1+Y+Z39JsUyRDFlA/bro/CmuQWrlsk5ngaJhSd5NsOdxq/qtC2s5kTOgj99ZHgJPqWJddw==
X-Gm-Message-State: AOJu0Yyjgwe7tEYaUyTSQA25+TZcPKRRHkTffT1vmsZfIhc596AFXr8R
 tFyTDzYUQf+rfCZ/3UwTF2zm2AQS2FoLzbGBMX29wzdHT1dhpJ948YsuCY6CO50=
X-Google-Smtp-Source: AGHT+IFCtmze7GaNCluHBJ7vUKk8cNscbvdbj76J/PUeGDbtxkbWWAqbmXxLw602iT6SkzJ6M3cKCg==
X-Received: by 2002:a05:6000:2ca:b0:368:5ba0:622 with SMTP id
 ffacd0b85a97d-369f0a4c3eemr2592131f8f.44.1721834372261; 
 Wed, 24 Jul 2024 08:19:32 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868425esm14926262f8f.23.2024.07.24.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:19:31 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] usb: dwc3: fix dcache flush range calculation
In-Reply-To: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-2-58a5f026ea8e@linaro.org>
References: <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org>
 <20240719-u-boot-dwc3-gadget-dcache-fixup-v1-2-58a5f026ea8e@linaro.org>
Date: Wed, 24 Jul 2024 17:19:30 +0200
Message-ID: <87o76m4y2l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

Thank you for the patch.

On ven., juil. 19, 2024 at 15:56, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The current flush operation will omit doing a flush/invalidate on
> the first and last bytes if the base address and size are not aligned
> with DMA_MINALIGN.
>
> This causes operation failures Qualcomm platforms.
>
> Take in account the alignment and size of the buffer and also
> flush the previous and last cacheline.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/io.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 04791d4c9be..1aaf5413c6d 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>  
>  static inline void dwc3_flush_cache(uintptr_t addr, int length)
>  {
> -	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
> +
> +	flush_dcache_range(start_addr, end_addr);
>  }
>  #endif /* __DRIVERS_USB_DWC3_IO_H */
>
> -- 
> 2.34.1
