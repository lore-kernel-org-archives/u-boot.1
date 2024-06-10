Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3CCC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B3F880A8;
	Mon, 10 Jun 2024 11:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jPQ57Hex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1CE88239; Mon, 10 Jun 2024 11:44:49 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B1687E0D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so5066690a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718012687; x=1718617487;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kitNeS9GtZKqwC9ndq4IvdHnjYHHSMX8VKyElLVC9FU=;
 b=jPQ57Hex3ya4eNBqa9ozJxJRA1UwKBXYcT629S7yXl4IZ8I8/tAG6rdORzXVNaBByj
 zNAxJZk1ffdU1tt1AOmLFOCmlGK8y3BhDMcia0xZRt0OSX1EjZXO8lpKVvJtozOqyeik
 KJfk3tMPjMMVOfXxLUz9YQqtMxrtJSjHfc0sfckjzzJm4gi/8Wtd8/8LrbTeWXuuCmiI
 JLF+aeZT+/FuL0qLdW8VNAEPh/fYYD/MHaEmELolPbpArzlmstUCYbRZ/LKYRsYEEQms
 uSyTm/rcgFiSoxCMTcB+6DWOOp1mZGvfjWiuMbYBeek1QGCR/xHR+f0YzhM/KaVqrZCl
 4fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012687; x=1718617487;
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kitNeS9GtZKqwC9ndq4IvdHnjYHHSMX8VKyElLVC9FU=;
 b=AICrk1+/FFDcAdEe1k11jDREmCIJ7+PF/abuP6VSX6psqdsuN/ul7adNRD3ZBnoXxJ
 nnzf/xArmQ1I12n9zrbCcZqj+MP/F9/+3OCN3/mmraGjt+cRMikQTEv5SD2NzkirHnlH
 GxajMmoHwbi1Ng8bCUA3kASwgaj0U7vTVJoJV1HNwJvNlfQyRd0Uerbp3QWwMRtZnctP
 s95IwthU6w8rFAR+XQHi/qMKWtofriGcVYFFZLOXGybmmR4QGOUq3pBTURNFXNgnTTA2
 tfEOeQBR/YbFJeN3ivCqoeoGj3g6ArYIQziw1FCeQfCYb7hTKgaETGcvqxiL/Doev+n+
 q+QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMRbz/PTPPSecS0ImWCWfSqLe/zawp93t9sdr57WH+Af8zcJnIw79CkKyafjrx4Kn8YdUzsgB2qDM67WeB9jZsmqvYoA==
X-Gm-Message-State: AOJu0YwufUdjk7tF4k5Xnetgiee7lxDzq4A3QkdRoyFa8HBbVcrM2cJ/
 V2HWlBDdSCneED4xtCkHaW8wh3Y3i4qlOAjPbYB5PX5XErRPilp/TjPZahLdvPc=
X-Google-Smtp-Source: AGHT+IEbQYRLFZXTPCneBs9gw23mi2dPAwK45qCXm/2z7sXIT2aMhhYt+pDRG90kZFkhc9+ktBGguQ==
X-Received: by 2002:a50:d70c:0:b0:57c:628d:f0eb with SMTP id
 4fb4d7f45d1cf-57c628df308mr3639089a12.24.1718012686829; 
 Mon, 10 Jun 2024 02:44:46 -0700 (PDT)
Received: from localhost ([2a04:cec2:b:49d2:7655:6cc3:de57:63b7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae11a98csm7154312a12.48.2024.06.10.02.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:44:46 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini
 <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] image: Set load_end on partial loads
In-Reply-To: <20240523-image-partial-decomp-v1-1-af036235963a@baylibre.com>
Date: Mon, 10 Jun 2024 11:44:45 +0200
Message-ID: <87o789i12q.fsf@fedora.mail-host-address-is-not-set>
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


On Mon 10 Jun 2024 at 11:43, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> When decompressing, it's possible that the algorithm only performs
> a partial decompression.
> This usually happens when CONFIG_SYS_BOOTM_LEN is too small for
> the uncompressed image.
> 
> When that happens, image_decomp() returns an error and *load_end == load.
> The error is then handled by handle_decomp_error().
> 
> handle_decomp_error() expects the number of uncompressed bytes in
> uncomp_size but receives *load_end - load == load - load == 0.
> 
> Because of this, handle_decomp_error does not report the expected
> "Image too large: increase CONFIG_SYS_BOOTM_LEN" error message.
> 
> Modify the image_decomp() logic to always report the decompressed size,
> even when a partial decompression happened.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> This has been tested on an AM62X SK EVM board with a big lz4 image and
> the default CONFIG_SYS_BOOTM_LEN of 0x800000.
> 
> This has also been tested on sandbox using:
> => ut compression
> ---
>  boot/image.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/image.c b/boot/image.c
> index 073931cd7a3f..4f48e6eb563d 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -531,10 +531,10 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
>  		printf("Unimplemented compression type %d\n", comp);
>  		return ret;
>  	}
> -	if (ret)
> -		return ret;
>  
>  	*load_end = load + image_len;
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
> change-id: 20240523-image-partial-decomp-d6604e998e3a
> 
> Best regards,
> -- 
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
