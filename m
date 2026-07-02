Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB732C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9875C84CDE;
	Thu,  2 Jul 2026 10:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BRCsAoSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3D884CD9; Thu,  2 Jul 2026 10:32:04 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDE2846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so2773934a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981121; cv=none;
 d=google.com; s=arc-20260327;
 b=I5FHA+cuwCMFhLnRmSU0mn4ir2XyJ6t7chhHSowirufmBLmQj/7VzudW5l7UY7THxy
 +BEzPL7uXIv8V5Gzcv3SvF2ES4PioiRHPgmeX1zz75r3LiGpmxHcYl38IZ00xrqERtjR
 z/477RVhx8bj80XSvmJBWsbgp/u65i9NQJGHAFvG2jlOn9LYFQibd2qTREazPKrNmqWt
 30B7EAUM+9Bfmdy9a/GfmvtHdi2sFfbKLAQEFpSeD9x4Wvw0vPMj0U4AEfz8I3QCwoEx
 jbIuefF897P2IOYy2Hau/tiy0XukMEq/b9i0Cf7119vSjZ6bpnWw75XFmRph2zp5gCkB
 y60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b9dNROOacstf6UY8g+gmdlCxXBcUapyN6c5FpankntU=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=smtILw8MPk5rptn+Jsw5sgR4Z7+SHAzvq5hTeI4SvKUjk9jeFUeuGksrJimO+B3pJ8
 pGhydYMWZiOyTMzObC5zLYZ/Xi3uPEdWCXcpoXghJml7GGN3xmrhKKlMy7CnfbSGlRi7
 9E5vRnHSAyuBDIRv452semkJBfbXIWGctC0+4wrWtlqtnPn5M05sfDhKT+8SDwVN5dr3
 uVn6cTPgoIg88a8xWpvFeK8upQdYnZF3OQNv30vb9HtxkouxF7YFWGmSmzPGTsDvrHgh
 gCs1KzGfxYTEhrt1wtDS8i+y1xEWC2xEpcC8qbOk9ptjOb8NwWNX49Wkh/ExgPfL0boL
 1wrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981121; x=1783585921; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9dNROOacstf6UY8g+gmdlCxXBcUapyN6c5FpankntU=;
 b=BRCsAoSLjU1z7eyozYqvLi48nad8S0py6LY6YyTSP7F9bEvkESKAq+mnjqAc36b+DW
 gszDcLN+BTUSA3J3ouSChE2ghTTijpwXnOmPvUV1qHm7z1TgjmfjAmP2tQ48ESzGwyBK
 AUBSoa5GpIQc2cySrQmROdCh77Z2WFIP6NGDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981121; x=1783585921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9dNROOacstf6UY8g+gmdlCxXBcUapyN6c5FpankntU=;
 b=rwb53uB7gdoXUIMH8Cf1jnRzBBjKI2YvTkSHdieb9KNphxJBzgy3Npok+UJngwd696
 nfHnQC4tM2tiJvi9KnRkTA/VuqmZxzFQtp0gfHm+TiXobhar4vs1J58fm7NcUXuGDS4Q
 +ueIIO/No2BRXwGoo18ANvwOMOnWxX+KAww882KduJ5FDxpvnWZbTbTBoIoTtuxINpyr
 Qkuz6I2Ze7WoO+wBv2mOQQz5GhFVNNRza3hw3mHogfzUEvtiqj7rRaZkaAAxcj7GuF0D
 jk9KEOIIaDwF1pzofmcRqUUSW0gHkfaaptDYEvGT89/VHo3gnSWI0pTaG8Htz5udN8iR
 QTYw==
X-Gm-Message-State: AOJu0YygmAH2BR2Wube4Q88Q1vmka/qFqlrc9EufY/uKbZhOvvArxIvY
 Uzon5NEh3fADa0F4ODhWILVESlFk80YZt5e+C7M0z9jkLO1P16b8u4OHi5+riS0dOpaFK54VhAM
 NKgmtkVb6leua7EBGw4pstth5800MyNX9PSa6v36Z
X-Gm-Gg: AfdE7cmVVS8o8NmBejTfgU5/vfWbV5G+fv6Vd42YJSVsTaaPvjajk5E5E+pVl5zVMhD
 gLdjrDNOTDlsF37cANosnKz4iCEbAoOln0s0XcQhsrsHkdjo7cpv86WWAq2wKkPGbrCg5R2iIJc
 VcZHjuuHXHJx4C5zDwueHGqcgbOqlotyjDrD1RHV5mFHf1lm4pHmzkQGjspwMfpfIZT96bPDN8t
 b68DEvtZkEO46iMTY9R4I/zn61pQ7jr8Zx1y7i5Clh9aEgfoH5KJ1q4fS6YIQNGecumWANLzQ==
X-Received: by 2002:a05:6402:a6d3:10b0:698:adfe:fc09 with SMTP id
 4fb4d7f45d1cf-698adff07e2mr416324a12.33.1782981121469; Thu, 02 Jul 2026
 01:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-7-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-7-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:15 +0100
X-Gm-Features: AVVi8CddoPUt-ANfesrshdyzCIon9g0of4Lo9UQiJB3Ghc2qjhwrnUrdM9mxwKY
Message-ID: <CAFLszTi58-YBJU=Z-Ab00xSTaaFGkibyogd4dP_whYv70MqOpQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] string: add strcasestr()
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

Hi Rasmus,

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> string: add strcasestr()
>
> While this is not likely needed by any 'real' driver code, a later
> convenience addition to the 'config' command will need this. As usual,
> the linker will throw it away if nothing actually uses it, so it
> should have no size impact when not used.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> include/linux/string.h |  1 +
>  lib/string.c           | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

> diff --git a/include/linux/string.h b/include/linux/string.h
> @@ -77,6 +77,7 @@ extern __kernel_size_t strlen(const char *);
>  #ifndef __HAVE_ARCH_STRNLEN
>  extern __kernel_size_t strnlen(const char *,__kernel_size_t);
>  #endif
> +char *strcasestr(const char *, const char *);

I've been trying to add proper function docs to newly added ones, so
we can clearly see the behaviour. Despite these being well-known
function, they sometimes differ in how they handle edge-conditions.

Also you could group this with the strstr()/strnstr() declarations a
few lines above, so it sits alongside its siblings.

Regards,
Simon
