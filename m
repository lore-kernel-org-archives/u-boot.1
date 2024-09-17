Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08666C36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 11:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0EC88D51;
	Tue, 17 Sep 2024 13:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzT91J9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406D688D93; Tue, 17 Sep 2024 13:55:07 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2576A88B2D
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 13:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so304623a12.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726574104; x=1727178904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BHqT76XwjzHyQixCuxC/ze2PKqLdEpQrx8qKmpT3DSQ=;
 b=nzT91J9cIFDocn7fujd5jES6/I5ocz/xKqOAU3H9EK9rwwOoxFgYMIFMagT2iUE+ch
 IQrQxS/a67PjPHrHEn0lR5pgmguYwkvzkIeZshJw7rknxZaYfP6ap5hPQuCoE2ptkT7N
 14grg8OFtu4qEFLWfdHpCXVS97WvvK1P6T+BHH84wxPaCVdsy7GziYB5VqLWGek6pIlB
 l03Fgydi04CICJ+vgJ6gB/DSaddMWdrRGDF5S7qm6UAC6wqFxPHJvFjE8pOhRQUp4KVT
 HLM0pRE8AT8oYCIIEnYGTtRwf0DN8b8AtEY+2A6Z+UfCfs7ilTeWKHSmVajBhIIfa8oA
 MCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574104; x=1727178904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHqT76XwjzHyQixCuxC/ze2PKqLdEpQrx8qKmpT3DSQ=;
 b=tiwAm0NTJQw80erN8A3Qj0CH+yFX7tYw3MTXMXz03Q1OW2hIfdm8XQVLc6o26e2WBz
 I6dCd4EDkz0npBW+vcAd0qa59OScHzIMrwem1RevPJJy1EtjdFwBbHpwiQZzgaoNwn9S
 Xnh7YlMfFQC+2rkmAyB+UCoiMGi6hg1skiYLi3rnwNj2yanzlk45aCukQiAXGTZXIMVd
 2geeA66AWgd46njphXT1V+cYZQLkkfoJHe2Y4BeWibXsHekiO8B4EDadXZMcy6RDWkSw
 2lPmIUmUlQI876baV0Nxka9bvBvpXqXyFpG0sHao6L0cPOTwnwvhP35VY5MJreGwkdvt
 UwCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL1xnIxkLB7H8Umc7HPoGJG09WmHzV5ah843Kit0xQ0W8bfsOJqMVTs4hKpqFats1ff2JUKPk=@lists.denx.de
X-Gm-Message-State: AOJu0YyhiSLJtRcwtqtMkXfAzLc56RmqK808q457iVl2/L4AAysTYkmX
 mWZsI1pWaKaZhEeCPEtXgocpJCc/n/rlzmLIsaYg7EXN0brE/+r0fwlTO3CD0gL/avl6/Bqdyn6
 LZva9kOzarGdZ8JiT+egzc0fkl2aEw6whqcK+TQ==
X-Google-Smtp-Source: AGHT+IFKh6khRDrOMPq6FazBAwor+G0F83Z6D2PcBiJYMZhep1vXhwpjWCG4UJnuBzvKtCpFc/Rf2d8A/IqROaNjzJc=
X-Received: by 2002:a05:6402:3206:b0:5bf:fb:33b8 with SMTP id
 4fb4d7f45d1cf-5c413e60880mr19077981a12.34.1726574104464; Tue, 17 Sep 2024
 04:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
In-Reply-To: <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 17:24:53 +0530
Message-ID: <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 14 Sept 2024 at 20:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/5/24 10:27, Sughosh Ganu wrote:
> > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > reserving memory. This will then result in no notification being sent
> > from the LMB module for the changes to the LMB's memory map.
>
> You seem to be using this in patch 3 and 7.
>
> Please, describe in this patch why you want to be able to suppress
> notification.

Will add the reasoning behind this flag in the commit message.

>
> In the EFI context we should use LMB notification to notify the
> EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.
>
> See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> specification.

So, do you want me to use the EFI event signaling mechanism for this
purpose ? Is my understanding correct ? If so, this will mean that we
have an event notification specifically for EFI, and there might be
one needed for any other consumers of this event. Currently there
aren't any other consumers of the LMB memory map change event other
than EFI, but using the U-Boot's event notification mechanism means
that the same notification mechanism can be used if there were any
additional consumers of this event in the future. In that case, we
would have two separate event notifications, one for EFI, and one for
non-EFI consumers.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   include/lmb.h | 1 +
> >   lib/lmb.c     | 2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 45a06c3b99..ffba7e2889 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -23,6 +23,7 @@ enum lmb_flags {
> >       LMB_NONE                = 0,
> >       LMB_NOMAP               = BIT(1),
> >       LMB_NOOVERWRITE         = BIT(2),
> > +     LMB_NONOTIFY            = BIT(3),
> >   };
> >
> >   /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index da6a1595cc..419b31a651 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -30,7 +30,7 @@ static struct lmb lmb;
> >   static void lmb_print_region_flags(enum lmb_flags flags)
> >   {
> >       u64 bitpos;
> > -     const char *flag_str[] = { "none", "no-map", "no-overwrite" };
> > +     const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
> >
> >       do {
> >               bitpos = flags ? fls(flags) - 1 : 0;
>
