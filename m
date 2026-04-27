Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19ABFF8862
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347BE83693;
	Mon, 27 Apr 2026 09:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zqngEnGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF50E83C14; Mon, 27 Apr 2026 09:55:33 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F5480433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-656d749109cso1171362d50.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 00:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777276530; cv=none;
 d=google.com; s=arc-20240605;
 b=jVK4AWNuzP5fVBv353PDAUQBV27ZSLXW5d3zqa0Xm+zyh8+HN71KkUxREMdiyRLbVT
 JmPC3ztbSu+GAJ0aMpH8vX9jaGDEyHLf5eDuQQ7nzjwCZD5OCD/Ub325D0AOVbGXQydk
 fD9v/DAJbU5dAqCKBk00h246pomyfQ4z6HzfjOoLkHHjE4QzrDO+oKgg8yimvCb5QmeQ
 plPChJpxhtH0SZgkLsuAGS3SneOjpT5xogbpzlt/SmdpJaMVbemw2GS/HR6TToUlZL0q
 5KzR14qXjBtZVC9QvEDrN4RmwXdKSKbJIidDI6lMSjV6WZfPRg73Ofr6SjjMDEojRrRw
 YFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nHyd9IWh9tMkoDZauxdxk98HXlbts8JlYZAKFRGP2Nw=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=abvLEF19i6h4NgHJOnEJgDbfPMa21D7glZYatUetM4YfKtv4UMds9iViT1uxRf7+Uo
 ByxculrErI2LC7Q/XtJGIDu2gtEwteLacDYl2/Jpd2Z3jlWRQzycF4vR5VzTOEdG+VO8
 i58bdsT/AL6sj7l0ph/WpM/HvSjWOcWSLsfCC9hJwhFskh2vMEpuuAcvdwbQYaOUYyeX
 tPFc1m1aM4YrETKoVS6mgiPpzMJLEjpfD/2snOOyoa8MsF0R47/ll/7AUJ8fsbALur/L
 He1BBYwHD4He0v0Ns1AoPlhjTlfb5v4P6c5oLvvaTHiJ6VpY6pLeTQTcRw8C/CFk8Y0B
 2Agw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777276530; x=1777881330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHyd9IWh9tMkoDZauxdxk98HXlbts8JlYZAKFRGP2Nw=;
 b=zqngEnGzW9p72oLFlzZXkB2FigNau7OVTBv2A5paTT8KKRAbdIp07UtBBfKw3mxuqM
 ApoFabocMiEVBkuuUiVRFTOCShW//tP4gcTlc6Z2le2+66/o/SfPACjpaI3+jUUHwYdU
 /zhLiHANCOyzqFTDPfXMK/4tyu6bPfUTAj1HOMmSGVv5xxoImgX0tT/mfhQiDjgwCrSa
 7fcvOfE7vaUXdy6Qq8iMkzI3eKNBVCRB39jYKmTNnk4Cg52hH7SP59XwRMRybckQiSg1
 bLIZKGCzvulMuLFR8dfVN6IPcpy0ePMSoGiNU3MxQlcWp2xUAEeMF/cPK2Tpo8XLf5Aj
 nv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276530; x=1777881330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHyd9IWh9tMkoDZauxdxk98HXlbts8JlYZAKFRGP2Nw=;
 b=BKZLRGTCkGHaOQvDvTwu0Wiey9WSn5pGqe9X/OA7RMBX+c7CR+ZNm+nKDZwx9sRRld
 oH2EbweJeBWVqJor+oB1ntBP5yBN3Lqkmbj8TTCzOVWNVDt/BLbhxf3ixX4ydihCGGBY
 87DcWCMUc0qWDt3e3+ka9NfQ00LdpDNYlwNg8sfXhL5mSfsZGpQ3Wjpdj9H38jHBE9D8
 PIrtKZrurHman37oc7N5uUC/3HjvGMRcOQiJWRdAOISHdAXBufVw3rkI7rfcXhbY3V7F
 f868F6V5thuScb3d1bocNnG85kxwITKunLM1JKVxyoEKvAbX+xhQfAX2eXDeQZeT4Iy/
 v8pQ==
X-Gm-Message-State: AOJu0YzdWat4RG6HwXgaa0ruNi/HvHgSrHDIqmCxVR+0D4DisxFAF/kZ
 RHIen6rexbO5+wcNJSq5r7UzSz73ma6/eBkmBS9CLhh1vR4EWy6c/7lgvsjkDGIWbNJ4DvYqS5U
 kwAUkWu/8o0LR6g7NQpeJ1jiAK69Ukz7BoCJW/VrNug==
X-Gm-Gg: AeBDievLgV9WjxHdSy8vk5GgsfrpMvNSDsgg5+eUeZIyXBdOKRrrAXnfd7JjCYplzMv
 KPINVoDgQQPBJ0P+a3YQnqqyHq8ekFcHpOfgyBjqch/Kqz8Hxn8eYFQ7jpVN+lVD+VC3QKeh4Ye
 qT3vCKg3x0iG3Ve+1CvNNCmPwZfqzP04shtHIGY7HOQ+sXTPD4HTtPZ0yMG8J1KEcwZM0rvtXI/
 GUwcIru8hVVqIrMLcZtqIlt6li9/p0Rh8srrXKk13vInI74yEV2WoVfqyZGoUvL1ObDgdW569gC
 k5SISn2cg9xvgmyMNKgaHX7Fuo5vdBSHz1QRbIT4cCLkZlhp+J4+P+6otCpGwjAvO/xHnSjVC+O
 JFELdMQn1rTX46tcQXWrTmHDoKk5HxyuE4QkmIncpDrHmNySzYk8m2moYpwmdEacR5Cdjp0YtMw
 sOePOxOpqFLAuC3SclGMJF5bw1Elk7dPV4XsSmcI4BGWNc/Xq6MoDDkV1NW/KVE8HMCd5ot/zBP
 yFMg8jIbcV0gzlXwOdArBxTUhGWWvsieXPKpzOhANypeBTIERFGED8KLah2Q4SjxDmvGroBgcgw
 xPLp8KAmg9UQ/xvzFHH8JGQlao106AfOG23Tn3YLdSP0pLAPAZrsUYUbRacWfhkOXZafMRqeUJc
 bIGIbKlGzBWeXbhCPemfGRYK1KqI=
X-Received: by 2002:a53:d748:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65310a737b1mr28722222d50.48.1777276529764; Mon, 27 Apr 2026
 00:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-2-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-2-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 10:54:53 +0300
X-Gm-Features: AVHnY4LYp1c_fUow9mYOsB2b6aLQ4dXGfnHcbm3viX3FL5VnpNL8u6IOfKV7owQ
Message-ID: <CAC_iWjL4zL=kH2XhDG5Cn4wyyn9i8CcXf019j=xxUi0fk1B+Jw@mail.gmail.com>
Subject: Re: [PATCH 01/12] efi_loader: add runtime memset helper
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
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

On Fri, 24 Apr 2026 at 20:32, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Add efi_memset_runtime() for EFI runtime paths
>
> This keeps buffer initialization in runtime-resident code after
> ExitBootServices() and avoids relying on non-runtime helpers.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  include/efi_loader.h         |  3 +++
>  lib/efi_loader/efi_runtime.c | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3a4d502631c..63944192aeb 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1151,6 +1151,9 @@ void efi_memcpy_runtime(void *dest, const void *src, size_t n);
>  /* runtime implementation of memcmp() */
>  int efi_memcmp_runtime(const void *s1, const void *s2, size_t n);
>
> +/* runtime implementation of memset */
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n);
> +
>  /* commonly used helper functions */
>  u16 *efi_create_indexed_name(u16 *buffer, size_t buffer_size, const char *name,
>                              unsigned int index);
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 73d4097464c..d9604399209 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -233,6 +233,27 @@ int __efi_runtime efi_memcmp_runtime(const void *s1, const void *s2, size_t n)
>         return 0;
>  }
>
> +/**
> + * efi_memset_runtime() - fill a memory region with a byte value
> + *
> + * At runtime memset() is not available.
> + *
> + * @dest:   pointer to the block of memory to fill.
> + * @c:      value to be set. The value is passed as an int, but the
> + *          function fills the block of memory using the u8 conversion of this value.
> + * @n:      number of bytes to be set to the value.
> + * Return:  dest is returned
> + */
> +__efi_runtime void *efi_memset_runtime(void *dest, int c, size_t n)
> +{
> +       u8 *d = dest;
> +
> +       for (; n; --n)
> +               *d++ = c;
> +
> +       return dest;
> +}
> +
>  /**
>   * efi_update_table_header_crc32() - Update crc32 in table header
>   *
> --
> 2.34.1
>
