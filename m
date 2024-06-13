Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C33AC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 14:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55B088916;
	Thu, 13 Jun 2024 16:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iMrqT9cJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7554B88917; Thu, 13 Jun 2024 16:17:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801ED888E8
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 16:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421d32fda86so12754835e9.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718288219; x=1718893019;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W02A8dapwExiEtrNwtygvsWOKkIZO78PL0SudxYu2OY=;
 b=iMrqT9cJdpsLUf5ThThnozC/4fEscSHat4rf8gcYBb9c1QTPZATKQeSWfiy3BilZK1
 Wrz20ric+XouOHa1Cw+k3vlai3UQlb/V5x+hsEuG/gpCccNISI1q/XYZXu9Y968nDbcP
 rLGekJymLW836QmyiN3C40vNbbO2vTf9Brii8EGqMHYEN4wmeNk/CEy9JTIdM8HTtUof
 aeTn2Zsq2ij/b2n9lVtVzXgPNgtWEZIQoYJWAuNqGUYl7Cqy4hNit+I1icWfZKoJM6BC
 Rj5FcV+2gNLNXf7fdaJBpD2vaviDkXhPkRChN6QdbaWorPUbUWNot1lkMCrTlgx7UOkf
 iH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288219; x=1718893019;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W02A8dapwExiEtrNwtygvsWOKkIZO78PL0SudxYu2OY=;
 b=JNIeJ+Oc90rWnO6dHQt6rYnyE6XCjSDPdOMfehgSYJ9wrJQjUaSeKgapz2FxITitIN
 BM1z1sGKSRUDRs75JhcaUxqkJnjb9XxBozDJpwlS054zBiCY1t1r21DwHhfNZBTV313I
 TPnV0i6wlX4twTXgv21Yyq/k5GmambaoQmFruBgl6oHPu6cIiKaxp3zGBsThvshNjS2s
 rGKUP6d/DJwHIFAlMlc6JCWk9JJwsvTrbit/uck1iq4pS7LTEu2c9/7DahYZ5hw/XHi7
 VpCWe7FJHNhrOh3zaAlYN6UG/fDy/jVVb2T4oavKfZ0lrAewSCYAZSymKJa3n9x3O6Ni
 beNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ZviNvql3rpl4MICS0Loo0nMb4P+O7z40iBV2qXdlFYxvCBJ1+IBVSY302UMx3s5/u5Efx0BZquOVA0Wuz/HvwhGRFQ==
X-Gm-Message-State: AOJu0Yw6yOSGpmil7dsucn6m1fWUaTny0pdPjq077BOnkGPUxemP5b+E
 ru+CFo1lu7Tdi6gSqfTb/1DhZojf/jrUALzfb9N6MsMVJDWaTglMyjQv0j05Rns=
X-Google-Smtp-Source: AGHT+IFRBkQg3dSuRl6KmyaVujGCGXbVHMHyvYjdOcaftDD511fPA6IsHEdEh3cEDrihlp1QjJbqHA==
X-Received: by 2002:a05:600c:4fd5:b0:421:f04d:ebcc with SMTP id
 5b1f17b1804b1-422864aebcamr52425005e9.24.1718288218927; 
 Thu, 13 Jun 2024 07:16:58 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f641a64bsm26185595e9.46.2024.06.13.07.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:16:58 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Roman
 Stratiienko <r.stratiienko@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 3/5] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
In-Reply-To: <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Date: Thu, 13 Jun 2024 16:16:57 +0200
Message-ID: <87le39lyg6.fsf@baylibre.com>
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


On Thu 13 Jun 2024 at 16:16, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> The only way to configure the load addresses for both bootimg and
> vendor_bootimg is by using the "abootimg" command.
> If we want to use the C API, there is no equivalent.
> 
> Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
> specify the load address from C.
> 
> This can be useful for implementing an Android bootmethod.
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  cmd/abootimg.c  | 10 ++++++++++
>  include/image.h | 14 ++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 327712a536c0..ae7a1a7c83b0 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -22,6 +22,11 @@ ulong get_abootimg_addr(void)
>  	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
>  }
>  
> +void set_abootimg_addr(ulong addr)
> +{
> +	_abootimg_addr = addr;
> +}
> +
>  ulong get_ainit_bootimg_addr(void)
>  {
>  	return _ainit_bootimg_addr;
> @@ -32,6 +37,11 @@ ulong get_avendor_bootimg_addr(void)
>  	return _avendor_bootimg_addr;
>  }
>  
> +void set_avendor_bootimg_addr(ulong addr)
> +{
> +	_avendor_bootimg_addr = addr;
> +}
> +
>  static int abootimg_get_ver(int argc, char *const argv[])
>  {
>  	const struct andr_boot_img_hdr_v0 *hdr;
> diff --git a/include/image.h b/include/image.h
> index c5b288f62b44..df2decbf5c2a 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1970,6 +1970,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
>   */
>  ulong get_abootimg_addr(void);
>  
> +/**
> + * set_abootimg_addr() - Set Android boot image address
> + *
> + * Return: no returned results
> + */
> +void set_abootimg_addr(ulong addr);
> +
>  /**
>   * get_ainit_bootimg_addr() - Get Android init boot image address
>   *
> @@ -1984,6 +1991,13 @@ ulong get_ainit_bootimg_addr(void);
>   */
>  ulong get_avendor_bootimg_addr(void);
>  
> +/**
> + * set_abootimg_addr() - Set Android vendor boot image address
> + *
> + * Return: no returned results
> + */
> +void set_avendor_bootimg_addr(ulong addr);
> +
>  /**
>   * board_fit_config_name_match() - Check for a matching board name
>   *
> 
> -- 
> 2.45.2
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
