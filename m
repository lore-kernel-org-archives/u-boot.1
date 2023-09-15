Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68D4EE6431
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 08:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FDFD865D0;
	Fri, 15 Sep 2023 10:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wm1dnrJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A8886679; Fri, 15 Sep 2023 10:00:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FC18652F
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 09:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40473f1fe9fso15331335e9.2
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 00:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694764798; x=1695369598;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=JGuPCOyUPdLV9RuN298gSjgG+zrbkYfNsdVU9iVXFX4=;
 b=Wm1dnrJjtEmyqO37InQV8N3+tAeB2uYQOoqw0INxoZs36gnH0GwwiGxQcv2HtpZ5J9
 AZviTUA55Mvv/qeDeZ05wCLpZVQ/vAsvWMQEmgpV5865mWn+J4yZcHAiomLBRwdbpI/j
 UDqse71cxwNL1WeuazlSZDNjgNcxcyR14VbEiH2sOVM27jysxwpAy0cPu5e5pUabGwq4
 lY0+0Cih2e1Fu7QFYOm/hfrcZ208ExRfs2J63z4MDXpt22GFGnwrWk4Rt8VN5XbQtNaH
 D0ISevveDMC3aKcFexLtyZlq5K+EmC0/Bga9LEE46oP9qMtOYl8cUfZXdO6kQ3JFoUlX
 fzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694764798; x=1695369598;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JGuPCOyUPdLV9RuN298gSjgG+zrbkYfNsdVU9iVXFX4=;
 b=aTxo/Rtpf5NyXWMdHvdk1zZ4FmkFze3UxO7keJNppLi3LWDoUySP99f14F8icQGDll
 1IObvppzmTJ3WM6/dMHYnpEpsvXul6sqV6wMRJVec00hvoBoCCKYcfQvddkmmbWJYfpn
 UUnCpS3AMooVkpeifYzzXk+gmbiuTj3vpMIk9pd/orzt7HdiDJd2cAALh/59bvmcdLcS
 Tsg6U7Z7uxpM24OZ9H9kSOmeuQdH6tv922rMuXXXLL2lkVOrGbq1tjDQxSFO0EAZr7lY
 AuPxwSCWSbXZJew+MKO7zCEl0yMq91lOpv3JDHN6r6OZ3jJ5nwND9F9MUhYwZbjicYOf
 mM7A==
X-Gm-Message-State: AOJu0YwlzqcghwD663T3iPcXJyfU4jBwFCudNnQ9qn9iA8o9ud5CFgJV
 MaLjmj56OtUdDOz0XRmJq6ec6A==
X-Google-Smtp-Source: AGHT+IEatsbMLRZgMaUjEM5N7aTQYDKuCHhzPMKqSwkyIwTc7lRHJVM9ZB3olSH+nInjSryiBmRDDQ==
X-Received: by 2002:a05:6000:86:b0:31f:b6eb:2aa4 with SMTP id
 m6-20020a056000008600b0031fb6eb2aa4mr785492wrx.21.1694764797904; 
 Fri, 15 Sep 2023 00:59:57 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 m6-20020adffa06000000b00319756d5b80sm3769751wrr.29.2023.09.15.00.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 00:59:57 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 10/21] boot: Rename Android-boot text
In-Reply-To: <20230914165615.1058529-10-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
 <20230914165615.1058529-10-sjg@chromium.org>
Date: Fri, 15 Sep 2023 09:59:56 +0200
Message-ID: <87bke33lz7.fsf@baylibre.com>
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

On jeu., sept. 14, 2023 at 10:55, Simon Glass <sjg@chromium.org> wrote:

> Phrases like 'Enable support for' are pointless since this is an option
> which enables things. Drop that part so it is easier to follow.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index f8b8d608951..017f7117d57 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -3,7 +3,7 @@ menu "Boot options"
>  menu "Boot images"
>  
>  config ANDROID_BOOT_IMAGE
> -	bool "Enable support for Android Boot Images"
> +	bool "Android Boot Images"
>  	default y if FASTBOOT
>  	help
>  	  This enables support for booting images which use the Android
> -- 
> 2.42.0.459.ge4e396fd5e-goog
