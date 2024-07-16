Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70907C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05566889DC;
	Tue, 16 Jul 2024 09:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DhYF+Byy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2082E889D3; Tue, 16 Jul 2024 09:04:51 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127AA889D9
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368255de9ebso226622f8f.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721113488; x=1721718288;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/ezEM0Zlc7gA1owQG6CwiBK4N02Wqz+lGNUQ6S8XTI=;
 b=DhYF+Byy1zdlcTB9LYhhhZSrfNJaaFuisu7FWwYxCINzT5rtKpvs2FhPjus+vRPg+p
 ZEWtgjTAT0cvxHHICpJbkb1lMJOhlpcGi5Dfw1o3AeoW5n5fOPbjZYKkW4JJtvvtEd74
 nEK+GzGVbcqF2kRuWP+bLQ7X84wjDDbeBH1LNKGLpjobH+ZsUr7wB7EeIuX9NryO/YL2
 +6J6gNIIOLAlASKDGJHvZOjez0YviQenjjQWtOCJX2j2TZ2eCg1Txd8LHDIZmqF9mm0t
 tdNG2zhKxx3moRao/GxW5Ww6IGoN/j6xMOIaqDHF7DMQg9/fzIL3iv4zRv6htfxk6U4l
 z20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113488; x=1721718288;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k/ezEM0Zlc7gA1owQG6CwiBK4N02Wqz+lGNUQ6S8XTI=;
 b=ZNL3vWjt90jtZX5Syxp3caak3VjttkEMhpjDvU7TMFZaYMOwxSuBghKo24KRs7WG3B
 zYa6zSBgX+PSazyF3wFNYaavTUxaUwtjmk8clJoAJ7FCCqlF3GxanbU0kyL215RSF9Ld
 g9hZFtK2FlMsKJU468yhKY6KnWBiaNpyBHmB2yyYHT7GhPaeusERGqE2yHWF3Xup1+Kk
 ChqvcPL7nDeb2l3eKR3qL784mCZ5ZG6f0TNpqFl7PRA0KYN4mk2zYHd9/27Elzdhop4l
 V3hGruzZ7reYGcsrzvxpcpL4tPVpRbTzCNO2KKr80s6Eu9J3jhNSo9Yu/BpIltUhqXXK
 ubYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4m/Ula4tOLO0hTfTtac+MJvPH+uIoqh9I7PHvOOrkG4peQt5BvWLVxAlCkCaJMS1Gi6esz2CzI6jJFs/Nk4IBosmq5Q==
X-Gm-Message-State: AOJu0YyN2GEJHWB4vrK2LNhJVmQQRXKSK2i1kjtfFAvskNMFZjF/AbT/
 3OZ1Dz1jUffaIroakuztVDBc6GTcsS7DEUiJnKX4YaPRVQSr2Rg9LDS8HvaK0Kc=
X-Google-Smtp-Source: AGHT+IEU7RsEaAtZw7lz9D5Pdc1jpTssivyRDA0yBhf1V/tQ6SSoHXrbyOQF2X2U1XC8B9TjEtj+Sg==
X-Received: by 2002:a5d:4210:0:b0:367:8e63:4da4 with SMTP id
 ffacd0b85a97d-368273e392fmr521419f8f.14.1721113488174; 
 Tue, 16 Jul 2024 00:04:48 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a63449fcsm111314235e9.29.2024.07.16.00.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 01/13] MAINTAINERS: Rename BOOTDEVICE
In-Reply-To: <20240715101354.97895-2-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-2-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:04:43 +0200
Message-ID: <87plrdom0k.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On lun., juil. 15, 2024 at 11:13, Simon Glass <sjg@chromium.org> wrote:

> Rename this to BOOTSTD which is the normal name for the feature.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c6de3a1d84..9bee9284cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -918,7 +918,7 @@ F:	drivers/block/blkmap.c
>  F:	include/blkmap.h
>  F:	test/dm/blkmap.c
>  
> -BOOTDEVICE
> +BOOTSTD
>  M:	Simon Glass <sjg@chromium.org>
>  S:	Maintained
>  F:	boot/bootdev*.c
> -- 
> 2.34.1
