Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8841FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD7483F0A;
	Fri, 27 Feb 2026 00:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKVIPJ70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD06283D1A; Fri, 27 Feb 2026 00:45:26 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFCD283E96
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b936505e7a0so137981766b.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149521; cv=none;
 d=google.com; s=arc-20240605;
 b=Ka7PuLyH8RyFPbWNWQgo+NZbwtpxl3OGFBRIOLLogEsntRMXLTbKjWYqVjocFAhtoR
 hTQTqNm4CPqAmJrJF4THcEBfVtLhQvxdSNWK2hU76ZCA5e1LpOQ4pkH1mvyTK5QupPIC
 lfKJUG3HRMjTCmqVp74w1bqNxqaty+cZ3D0PmvBJjQW5whZP26bYuv+xCIuJCH5kVSPZ
 R4/VNJIZ06EjMuzjFdA9Dl95ZUzf9EFfQBNuTHURNZa66aTHAyrI2OweJsjWRcdX3gur
 jBuu/6kYliNX6ZmqDt5+TBaQtIlMqktD0Mp6CMPIExHM3uAJRX+jFhnCKCqOm33XboV8
 9dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bT6cK/wel2Tj/quaOTp6xZiGING8dDFl6mt8heHKN/k=;
 fh=ww1AezHhUrUdgwpMh26fcq5DchE7hdDM1E6MkGEhdpY=;
 b=CO+FyHIt+12PKEm5fRNnM0ApMCIdS5LOORZGmd8fUJJowiGJnQlAuq71KTaM4FiifD
 nTJklMypicTZzVKMuBW8yCi4iOwaoxbA48oVBsrc9UpCdY/vQIbEDrZSQVSKyX7tJTFD
 97ZHcVd4ZaWwdbDb3bmha7WT+ZbSNrhcbRKq+jVM5yEr649Xj4/zcup1fZsHznpMZt8I
 vZzdbCKBUU5LNW2EVYmLR7LIlh+lJtfeI7fDZ1R2Ntw8Zau2FbLlxsD6eIVNrVGF6n1m
 6Pa2sac8Hr5au3vpGO/W6hxiQ7RrcBs8wEfPd72eN2K7I38Z6fQ62cLrRa5wMv4DN2KW
 jDRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149521; x=1772754321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bT6cK/wel2Tj/quaOTp6xZiGING8dDFl6mt8heHKN/k=;
 b=fKVIPJ70W+ncPhRDnNu2viq0/Sp+gJPPpXFXcdXxqZVxXnXXBN4Hxc6uhVRFmwLRRJ
 tCFLGDKxQp8D0VW4lMLOdMyrNz3U0X3yTY9FTMWRl1m3j9jI6urTBgvKRBr5I0JS9ykC
 HQ0g2527ufpkyDdG0+3XfROriKE6LedxSJLgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149521; x=1772754321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bT6cK/wel2Tj/quaOTp6xZiGING8dDFl6mt8heHKN/k=;
 b=cfhw5/+I0+xk5+WCnSH2Meh8v8lDp5Ra1xbfrxzdPWQqab7tWPveYoAVm+pYvt/vZx
 Nij/LxiqNPm9uGu7fOFHlNgu8YHADaVyX3IsSDk046ItZZrUXqsYhVXMY0KStloSFJPz
 zQ4naYPoPOihaazuALFjbHveWjauyE25YK7hqyaJa0we5KeRNZh+0r18NDuCCdcOBqSo
 jDclRkePqgHAhf0jpiQjiJnr9OaqP9ndw4UIiwB1k2OZVVmui64rI84U6nKW46Z2a7FE
 wCVFt8txueRj3AERYpXNCgThV8nJmY4tfVIYBWX2ikb82EKsnU1Sm4/jHN8YNtJWtDHy
 5Mvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS2s9Ntk3HO8JIIRobNC8M+kF5RkDIPHCsll/JoN+/1lR809YyU7i88g1Ztz2A2ZA15/6tRb4=@lists.denx.de
X-Gm-Message-State: AOJu0YzRALPq2zPyXtM5RLx039j9ST6UnlydPrIwt1N1UDm+DDL2szsC
 S34hJzxpoT6vMcBGH0ZHvSzB7NBzWt+cv1avpCmhPpM7U+3hUF/Rb8Q6POugtOU+SkbAIqgvvqI
 REYaPopnmY/dftZfcjzzSlImh6iN8TbIG30Aep78w9TBH2cRXHqY=
X-Gm-Gg: ATEYQzwLns2wjaPBSsXgwnAS9nAZPn0vBXbAtFMxsCwZoPbdMFneEoDGI1OoT0frK5o
 K0ml44rc/rg0JzpIaLxAKAWcurwNHj4DKHo/SIgLKO6MQig21tmDXNABUFE6tZbQGevVJzLkSUF
 vJ71BYpevWyxNUJkvUBExxs1k7MuO26QtammgOl1KNZF2PhvV/38aRXkQRp7kFQGjKFej/yNkrv
 UlIsljUuAM7pfBtz9K+v8caaO+4oa69RXvuLkx+bUuT6nEcyJkB6ITl7CcqgTf7390p/1v/Tzj5
 q5S+Gg==
X-Received: by 2002:a17:907:97ce:b0:b93:56a4:d6d3 with SMTP id
 a640c23a62f3a-b9356ed6a7amr299047266b.1.1772149521273; Thu, 26 Feb 2026
 15:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20260226-fdt_size_hint-v1-1-5a731a5f8d6d@maquefel.me>
 <8fd72f0c-51ed-4721-a39f-1e41aa6665a0@cherry.de>
In-Reply-To: <8fd72f0c-51ed-4721-a39f-1e41aa6665a0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:54 -0700
X-Gm-Features: AaiRm52b3JxjeN2poSJLKDcXuzBE83Q3e9N3ggFQcgSA6hwQr1W7ZdxFWlqbUEk
Message-ID: <CAFLszTjaUnQo1=VtCjdf2ocQVCnnT05j0wyd0KT0EKxf1e6opg@mail.gmail.com>
Subject: Re: [PATCH RFC] binman: Make FDT size hint configurable
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.denx.de, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Bryan Brattlof <bb@ti.com>, Yannic Moog <y.moog@phytec.de>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Chukun Pan <amadeus@jmu.edu.cn>, Moteen Shah <m-shah@ti.com>
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

Hi,

On Thu, 26 Feb 2026 at 09:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Nikita,
>
> On 2/26/26 2:52 PM, Nikita Shubin wrote:
> > [You don't often get email from nikita.shubin@maquefel.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > The hardcoded 64KB FDT increment size causes excessive reallocations
> > when building FIT images with large artifacts (e.g., 250+ MB rootfs):
> >
> > ```
> >     ncalls  tottime  percall  cumtime  percall filename:lineno(function)
> >      16118  297.130    0.018  305.189    0.019 libfdt.py:947(resize)
> >        870    9.876    0.011   15.211    0.017 fdt.py:56(BytesToValue)
> >      16118    8.024    0.000    8.024    0.000 {built-in method _libfdt.fdt_resize}
> > ```
> >
> > Add support for configurable increment size via --fdt-inc-size option,
> > with recommended value at least equal to total binary artifacts size
> > to minimize resize operations and reduce build time.
> >
>
> Does it *need* to be configurable though?
>
> After all, we kinda know what we're going to put into the device tree
> right before inserting it no?
>
> I'm wondering if we cannot simply set the INC_SIZE based on the size of
> the data we're going to include (+ size for the property name and some
> overhead I guess). I'm assuming changing it before using fsw.property()
> and reverting it to the default value after the method is called? I'm
> assuming we may want to cap this such that we don't need to worry about
> OOM with very big artifacts.
>
> I"m also wondering... is this code path also used when you put the data
> external to the FIT? fit,external-offset (can be 0, the case for most
> platforms except NXP). Maybe this is what you want? I'm not too verse
> into fit generation and quickly reading tools/fit_image.c, it seems like
> it expects an FDT with data properties and then relocate them outside
> the FDT and set a data-offset property in lieu of the data properties...
> That seems pretty inefficient to me, why insert the data inside the FDT
> in the first place?
>
> The next question is how exactly you're planning to set this size.
> Because as I see it now, this is only configurable when calling binman
> manually and passing it an argument. Which means, this won't be used by
> default when building U-Boot with make.
>
> This also will trip the coverage test though I'm not sure how we want to
> test this feature to be honest.

From memory, we had a discussion about incrementing the size by a
calculated amount in one of the patches for adding signatures in the C
code. I favoured doing the calculation but the author felt this was
too complex.

A better place to fix this is (sadly) in pylibfdt:

    def property(self, name, val):
        """Add a property

        Write a new property with the given value to the device tree. The value
        is taken as is and is not nul-terminated

        Args:
            name: Name of property to add
            val: Value of property
            quiet: Errors to ignore (empty to raise on all errors)

        Raises:
            FdtException on any error
        """
        while self.check_space(fdt_property_stub(self._fdt, name, val,
                                                 len(val))):
            pass

i.e. pass len(val) to check_space() and have it increase size by at
least that much (but a multiple of INC_SIZE).

Regards,
Simon
