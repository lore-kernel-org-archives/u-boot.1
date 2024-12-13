Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F2E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B296801A0;
	Fri, 13 Dec 2024 12:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n/aQr4+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5113801BF; Fri, 13 Dec 2024 12:49:49 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A484080192
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ef60e500d7so12757127b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734090585; x=1734695385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+7dGfze9IezAIFtiheYWPo8Fw+k+fdvDk3QXsxRHUM=;
 b=n/aQr4+17lfN3H16XAd2NN67xrqvJ4COkR4lubE1HEezwnwolrIuxWxJ+8ypYcTbxY
 2ENXdHCoTA9tAhh8MIdBaF38FbheUFD6L/DzlrD1pC0CDw7bzMMZIqU7rxjGFLTVugLD
 bwKVZfno48jEX8l5XXc2yR0Pl0W/h8fz0CKoM773rB1l7QEfFNJUqhpD7LN2RwvRaOm8
 j5DnQOXhmua8cNill/imM2hcYTf+8oSlzbLtYiiI+ZsdNlRWZoXboN8SRuKDQnmZ7Yzz
 QZ4V99ITLAwhKUa8YsVk8FSfMPiEahNFLDhR0F3qOpSuvoUWKBjPeyBxY3joEHCLJlJ8
 DLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734090585; x=1734695385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+7dGfze9IezAIFtiheYWPo8Fw+k+fdvDk3QXsxRHUM=;
 b=NdqHIHSHdk0r9RrDBPb4MZENnMYsT+KJFLCbtNwfliGDUbEs20fJNdjMXeYtD4NScd
 i1CvgbP453ucRWebdJMx3IKKKi82ltJHNFcbsZnp7E4BEENSaDMFjlcd53lJpdKc2Xx7
 2tdWb9vG4UBlnzrJR5w6tIPc28BIV/20l2kj6af00V/w7ddnpQ9PLbM+Gg3kpuFlz4KS
 enlATSP8NjVbWoiDAsUbXdocKU92UvZX7xU223EGl/wk+iSuFBhM/9tz2X82dzmaKwjt
 hNBg7AuE8xhtAsq7xCEp9RwExmkDEDvoQf/B0luWbNjzd/m8i+retLz6uixs/XJLti1d
 tmdQ==
X-Gm-Message-State: AOJu0YwIcfT85OpBMYEPnmiKpNfcoXWmJWXvCW5wUQzX2cJQ8I2qFgdP
 vMlEOVXeMuJct83Ue4hmcC59Kogg28Nq7E3LbbgGjc3MV+ohf20zqhDbFWfFRU1MCK1A0G2Ovk+
 f+8sIiowkxxyn2OxSrl4j1R+JbCBDMIihNpTXog==
X-Gm-Gg: ASbGncvM9nppLfZTklmzUUO8mYgcXexPzyrftsU4/kvWonyIQoUkBHXiY9srlx3Z5hU
 FZEjtbz25WH0ValjY13MXxrZcLJ0idX4ntVs8rA==
X-Google-Smtp-Source: AGHT+IFa9vsMBnAnj7YLgmWnJKWDy+refpNJi82dzcaSe6TDB33fhZy3vz/jEHRbQxAt6kMOgv7fjBtpVjZMtuaVvkI=
X-Received: by 2002:a05:690c:6c8c:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6f279b7c5a0mr20891487b3.34.1734090585566; Fri, 13 Dec 2024
 03:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20241213085840.21872-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241213085840.21872-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 13:49:09 +0200
Message-ID: <CAC_iWjKOd-+90A_tVDNt0xWnTgKDKxuB2G+kshTCFY2uafS4uA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: update EFI specification version
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 13 Dec 2024 at 10:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> UEFI specification 2.11 has been published.
> There are no changes relevant for the U-Boot scope.
> So let us update the supported specification version.
>
> Change the comment for the constant to Sphinx style.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_api.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 61c4eda8f8a..b10f467f67f 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -20,8 +20,10 @@
>  #include <charset.h>
>  #include <pe.h>
>
> -/* UEFI spec version 2.9 */
> -#define EFI_SPECIFICATION_VERSION (2 << 16 | 100)
> +/**
> + * define EFI_SPECIFICATION_VERSION - UEFI specification version
> + */
> +#define EFI_SPECIFICATION_VERSION (2 << 16 | 110)
>
>  /* Types and defines for EFI CreateEvent */
>  enum efi_timer_delay {
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
