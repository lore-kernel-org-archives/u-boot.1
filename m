Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263C0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82AAD88958;
	Tue, 16 Jul 2024 09:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VERBrPjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA6F88907; Tue, 16 Jul 2024 09:36:16 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D20788998
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso37940255e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721115374; x=1721720174;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YcQyHS9B/qoB67fsFzZWNJ9g+wo59fMFb93iBdEyDO0=;
 b=VERBrPjFCRhVLqSNWglghGD8HDuPX8tNX9Yxa/7sw44vluXhnK4t8/gPV/2H7cD4oj
 duP2rjzP3w0ClZOEq3AaYUxO3WLAZCTE5anaC6Z62p9o5EuDMuboExAuAzBhi2B5Zl4N
 wtxq9bT7GUK7ExSqTfFy97g7J0eNd4Gy2rQt8qX0EGHtG6eeMD5BMQH4Ao1KCwFDdj2A
 Okra5wFnRN5vBuxHOcGGTAJQAskK7nGbdLzuMVt/KNJapSgZWy3gewKkHJuUEnRhZ9Xa
 /vaKKZNYtqW/jufu/Jt3z/VqRW3d3u1UQsJWKxOgRVtw7DbdmuhZoIY6665GSTeTrW9H
 G42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721115374; x=1721720174;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YcQyHS9B/qoB67fsFzZWNJ9g+wo59fMFb93iBdEyDO0=;
 b=fjMIL0qORpKHmL5p8otO4TlhxxX2OIcNeHarT/V+tdh8/HDcvDqSQLC3i4QwGVJ6Zs
 AWfcT3XoI6F4a6GQ05LPoyVWv/ns5oGTDaU/Q+M54BCIFwer2QdeDC5avhkym3XEHAQW
 Sb8EFNY57MIZLdmWUVEiZ5Cr9zHk98YspUJ0P2GlIuzTxEYOYfmBrKbkv/PKcjgjXj6+
 kRPq0cdj7WETl3wMBnrnKkbzXPXNxeQ9IH+73E/rGl4+rkScrAGMhYgtDL4BGWT9kji4
 9n7A+yuacsOQL66CpHuff79WdRBOy0wePTOS8E5IYEYVWqQFRQRD+rVoSo1pI7kuQuQN
 iFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgnC51EDgk2yfm5tG++BQTRX+y88n5WDbbUE31UjSESGwpnv2KX2cTcaG40pgGw5OJc+2pR0+nvKZQuEgoghzBLBd3MA==
X-Gm-Message-State: AOJu0YyKFK6iDJx3rzb6ZPC9cADzum1nOwltX7gjzzKItD9fvajlkNGw
 bvw7hqsMz88t+nLN+4ygRTFNLrwyA6ojWVVsjTmS3SISX6nAXBU5FTTU35FUGexA69FztEVjSqF
 K8eLbmA==
X-Google-Smtp-Source: AGHT+IHLZ9aW6CKmhIWIQJqDEbu9uh4hQWLJPEGjZVFu+gb0tEcVAJxQdONj7kVov4Mf0WWK8Ut8Pg==
X-Received: by 2002:a05:600c:5129:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-427ba701fa1mr8594515e9.28.1721115373694; 
 Tue, 16 Jul 2024 00:36:13 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef44b4sm113016715e9.42.2024.07.16.00.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:36:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 03/14] doc: Mention automatic binding of bootmeths
In-Reply-To: <20240716070419.1897560-4-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-4-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:36:09 +0200
Message-ID: <87zfqhn5zq.fsf@baylibre.com>
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

> Add a note about how bootmeth drivers are instantiated.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Add new patch to mention automatic binding of bootmeths
>
>  doc/develop/bootstd/overview.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index 761f61a573b..d5051e986bb 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -419,6 +419,9 @@ Bootmeth drivers are provided for:
>     - VBE
>     - EFI boot using boot manager
>  
> +Each driver is controlled by a Kconfig option. If no bootmeth driver is
> +selected by a compatible string in the devicetree, all available bootmeth
> +drivers are bound automatically.
>  
>  Command interface
>  -----------------
> -- 
> 2.34.1
