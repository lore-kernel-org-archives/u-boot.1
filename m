Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01E9C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8691088855;
	Tue, 16 Jul 2024 09:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N5zcfw/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A7687D2F; Tue, 16 Jul 2024 09:51:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9676488907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so34615315e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721116303; x=1721721103;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8xBFrHuq1s3vRGMYrvo63sHrvagZCYhV5cl57X80l8Y=;
 b=N5zcfw/x4iYERd42QB3T0322dLoy9gX67P7A54vrUhU/GNID4jT99nftcArTQDjEYT
 LykxJP2dYYe0t3h7O9t8S5QgX0zS7xhSpf0Ul5VaBj6Ozx3+6h6bIM/qnk5ssk7Dzklr
 JaHaeypdmX+sYyT9es2Gczl6wYpp98N4Bz7eK4ccMdI7SsrIi+T0/w5aEAq6Iu8zH/Bx
 ejAN3tyEUtA8Pd15ATzcrkhQ+LoysAO4pPkfMkNOWh2/iQLC6RXq6jLD81cQLfN/n6+c
 HgTy9vcxzPaM3uytpG6W2QkP6kSDCqr8mV3lbYmOoKGXlihGbkO6Opu5Md9Aa2TVjo6m
 kjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721116303; x=1721721103;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8xBFrHuq1s3vRGMYrvo63sHrvagZCYhV5cl57X80l8Y=;
 b=Rv9zVwK4l63NeRVK17R1YtpJBtBkjbw2iiirjPVxoATA2AX4jgGV1hBz/ilBDhsPJ3
 /jA2msWtXgbMYaXCtfMSAgxkYYUC9jIHGMKtj66tKWHPRGb74T666XNM7lW2EzMAHzYk
 2ns/zakGf9H9rNfgRg4ZmEeDWu/0YxpVPtg+aAqnvf5PhCS2EKNQWlP/EAbq3WJgMpte
 RWjJ+Pgis1gaNrJz9KL8/w3cA5lWWayzjnSJuO0WSpIKbIw3qJ1VOjJuo9aTAZKoprIz
 UudZ7bsPl+8N0bBbiBMXJ9Vc/tAkEm+GXLKw2jwdGMasGmGQCEDSomxLvajBblwp78SE
 siGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ElbnPEmUa0n8vEPFscUqj5AcFHWRkskjh3NFWekYF0oCpUG9pmFIXyoGKGI3a+X4X1AppOInjOYCBGlPv9QAO1tr6A==
X-Gm-Message-State: AOJu0Yw4mu+scZMl1sbqa14ucBnbC5ohz4vi4OhD8INGKnSJmg9FMAr/
 TQgRnl96rYKNhhmn4Q0210nYyYBoU+PH5xh+WjVBJy2OJ9jUyqws35hFCPmLj3O4y3EkW45deHE
 ILOOvrg==
X-Google-Smtp-Source: AGHT+IEjYCMhnx8lPeEh7/sceXWIZZAeJD1cKVcF3HYdnniSVE0L1kEuf4b3LLaXNPgtmvLcqswQYA==
X-Received: by 2002:a5d:4084:0:b0:368:12ef:92cf with SMTP id
 ffacd0b85a97d-3682633d266mr874051f8f.48.1721116302931; 
 Tue, 16 Jul 2024 00:51:42 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3c38sm8258959f8f.8.2024.07.16.00.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:51:42 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 14/14] doc: Describe the bootstd settings
In-Reply-To: <20240716070419.1897560-15-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-15-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:51:40 +0200
Message-ID: <874j8pn59v.fsf@baylibre.com>
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

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> The bootstd node provides some configuration properties. Add these to
> the documentation.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  doc/develop/bootstd/overview.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index 4a55b7da00a..d92a649beb0 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -406,6 +406,19 @@ You should probably also enable `CONFIG_BOOTSTD_DEFAULTS`, which provides
>  several filesystem and network features (if `CONFIG_NET` is enabled) so that
>  a good selection of boot options is available.
>  
> +Some devicetree properties are supported in the bootstd node when
> +`CONFIG_BOOTSTD_FULL` is enabled:
> +
> +    filename-prefixes
> +        List of prefixes to use when searching for files on block devices. This
> +        defaults to {"/", "/boot/"} if not provided.
> +
> +    bootdev-order
> +        Lists the bootdev ordering to use. Note that the deprecated
> +        `boot_targets` environment variable overrides this, if present.
> +
> +    theme (subnode)
> +        Sets the theme to use for menus. See :doc:`/develop/expo`.
>  
>  Available bootmeth drivers
>  --------------------------
> -- 
> 2.34.1
