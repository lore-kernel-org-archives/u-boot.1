Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8870AC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B860886AB;
	Mon,  1 Jul 2024 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkN5eJ3u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7C7884EA; Mon,  1 Jul 2024 15:57:55 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013DE8848D
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-79c054b65d4so196681385a.1
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842272; x=1720447072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2wja3/icVX+1r2sippFdO29KHL9Ex32aEKrbpfVkiSg=;
 b=mkN5eJ3uIkYh989RmuNZatvHgU30BAZH70vT6Nz3Df2byB0mSe50NjM1xVHjWTVzsz
 O8qDO82BlZOkI52DJC/s3XRO1aQHBSKw+8p24kVBtU+47VWtYRnPllRJh5XD+0N86+qv
 plQRMDOorwgJIsruK0Y50xeSM9FM2DTjHQCnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842272; x=1720447072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2wja3/icVX+1r2sippFdO29KHL9Ex32aEKrbpfVkiSg=;
 b=U8XDyaYs+uInxoJkNazZmTqPcxgRh09pOqybjPskMukFKhqPbMBPlzYKJomuxlHdAr
 wvWnOjxjf09Zf6OA4AFTjw9kBun1BsSD8zjhZ5F4RavYfBEkokewDZchMj7NKlYJExuh
 L5tOzIkOATD/563Pt8ARFSjnRpbKdqU4Jci2nJ+FlP22oTpNpIvx2CaY8MjxeYao7Zo8
 QR+pvgN2IuGdLJxabWoz9Qw4nnWCRCE72gXzZU9IyfQ7uezpNSLqgHs/LraFC52Mgnq6
 3UixaQZbx1crVLJRR27oANItof+0xjowrjrH0Y8vBDHe7MKEye4Kdhy4ZWZZf1qM6TBF
 RQWA==
X-Gm-Message-State: AOJu0YxD6ZMnVk2hZdm+zm+xgM9ZTFkMGF83aDXw0Q6BucnWA+oTqRYa
 KWvrPCpZ6HSXJVPA4IOf/u3zRI+GHHlckNO7UMcx3F0OHwsH5sJjyGNRYbLqM9LJFNz7Os4EI0B
 7wmmvNImrQBiEX7Xsofkeb36194mrt6FhO2Pvney/SEQOtF8=
X-Google-Smtp-Source: AGHT+IEJhOr0KxP9ZmpTRRHvSck4aRSz0I5X07OTyxtIGIddXayRrgC2eeH9Q/PXDO3IPn62xLzeTWc4CqIzXCwyyEU=
X-Received: by 2002:ad4:5c42:0:b0:6af:c289:b96e with SMTP id
 6a1803df08f44-6b5b71a9e55mr79930326d6.56.1719842271870; Mon, 01 Jul 2024
 06:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240624092900.2108175-1-andrew.goodbody@linaro.org>
In-Reply-To: <20240624092900.2108175-1-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:40 +0100
Message-ID: <CAFLszTg1HmMT-Lzv2aUEmG-jHr0gOAScpdk2RbDueCu_bCnKvw@mail.gmail.com>
Subject: Re: [PATCH] sandbox: Fix LTO to work with STACKPROTECTOR
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Andrew,

On Mon, 24 Jun 2024 at 10:29, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Add the STACKPROTECTOR symbols to the script that generates the
> symbols that should not be removed by the use of LTO when linking
> a shared object. This prevents a fail to build due to link errors.
>
> https://source.denx.de/u-boot/u-boot/-/issues/35
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  scripts/gen_ll_addressable_symbols.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
> index d0864804aa..ebf89b04bf 100755
> --- a/scripts/gen_ll_addressable_symbols.sh
> +++ b/scripts/gen_ll_addressable_symbols.sh
> @@ -13,3 +13,5 @@ set -e
>  echo '#include <common.h>'
>  $@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
>         sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
> +$@ 2>/dev/null | grep -oe '__stack_chk_.*' | \
> +       sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
> --

It is OK to add these new ones, but here you seem to be adding lots of
other things also. So far we are only allowing linker lists. So can
you update this to allow just linker lists and stack_chk? Perhaps
egrep (_u_boot_list_2_|__stack_chk_) or similar?

Regards,
Simon
