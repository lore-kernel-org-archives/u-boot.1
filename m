Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3290C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540C287773;
	Wed, 29 Nov 2023 18:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gykrMgGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844FD87762; Wed, 29 Nov 2023 18:47:47 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9582B87651
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9fd0059a967so230839866b.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280065; x=1701884865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IvLfNcl+ef8ffX9YA/OiB+93HmIkVmjGeJepx47eMJs=;
 b=gykrMgGK/l5BWwmqKh1KZtc94/VNWI28NHlxvuspzB4bAHlXuTVxlXMZvvza4/6KE+
 dv3mgpDaK4aGJ9crk57q3v7I93q0W1pka/gieGJWY/UsXWTFKiCAZAZCjWK7RqsA7jCW
 0kuI2u62+hX82pTe8LaxNvacBFsMMkB9uCu/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280065; x=1701884865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IvLfNcl+ef8ffX9YA/OiB+93HmIkVmjGeJepx47eMJs=;
 b=Wf6lCy5DURgwez722k26gVJsd5atb7twoj6q0aGZoOQqVJPg6h+L42m5PcwYtZfhUm
 PYUHhNKA9aZkCtWmZqhyMRZagYM+O6mmOMRJ3B+REbecmNocVqwlkUUlOIz+AYtHONp6
 EvjNMnmXGW9WdqaOq3fzR/1tR8pKHeNiIWDf0V/xsd8CteY/q1wDSc5wHxHjP5T5UhhU
 g4ja6OPDU632Y0tJcojn8QE564Wu42/FI/Ycp9kThACEmyPycBxC/S+cSpFGJZdKKoJq
 l8GC+joQ8QO1z5PZYGydCRFm/PG3Hg23O97uxSBCr/d525HR6uogwSORas0oEfU7Dr1w
 z33Q==
X-Gm-Message-State: AOJu0YxWsCIrqGVdkSQ9ilGdF6dQADc4xb8iXEPyZlmUWYmRWwJKyv2s
 05qiP5JiJ+BAdiJVgZYe7b+ON+LDM9RcVRd70Aoftw==
X-Google-Smtp-Source: AGHT+IHOae9WcBroy6k2OXbSf12Gmqb5SKG0zJ4QRTm902pVRBuyc1KqnCnFqmKy6B4Pou4KLgglYWYiVXzMhWSEVW0=
X-Received: by 2002:a17:907:7da9:b0:9fd:9e54:a4fc with SMTP id
 oz41-20020a1709077da900b009fd9e54a4fcmr25067283ejc.15.1701280064975; Wed, 29
 Nov 2023 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-5-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-5-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:31 -0700
Message-ID: <CAPnjgZ1emsUAJ=w4uyyEkBLTAvPgxdtp6kjWxF593mVbd3f+SA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> There is a preference to use the "ofnode" API for FDT fixups
> moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> fixup the kernel FDT with the ofnode API, it's required to set the
> OFNODE_MULTI_TREE option.
>
> To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> the default value for OFNODE_MULTI_TREE to ensure it's always set.
> This will cause a 1007 byte increase in the code size.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
