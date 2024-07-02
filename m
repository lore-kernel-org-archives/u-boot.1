Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA8C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51CC883AC;
	Tue,  2 Jul 2024 17:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jY6i5wSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17B9883B6; Tue,  2 Jul 2024 17:51:05 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6003287C86
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d55ed47cc6so2718801b6e.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935462; x=1720540262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2cIQfiQAXqgxOlu2W3G3F1vOSItbhCMcdfRI4h89hGg=;
 b=jY6i5wSUBR2PScBx9yNHeY8VfCTMSHSJI+63NP2WanTn6OZpp9vQnzs+WW8spwmN9m
 vjrJ2D7Z8YgVa4H4Us4GOGOcvqmG7Jv3+QMlUuPYjQeW7dHlcnEOhOtlQPzmxPd6Q8Oz
 1ThMiCmYcku9if2qR9IBUSmBmpYIxC6J/TCgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935462; x=1720540262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cIQfiQAXqgxOlu2W3G3F1vOSItbhCMcdfRI4h89hGg=;
 b=jl4NZwAfEQx7T4fjRkB7dFSY1pkkuYNCEi58opKsNZHVQT7+vKPSzEwnYxeSJi5dze
 lxrwtVjvNKz+Y7wJVqwWecKM0qwhsAcgfITXCmuuUN5hNZM7dKVmHxSeptLaXr5hkezH
 vVItyLIFbk0El68pidvkltmG5rZvfZj1OMs2VzsmrE9FO8LyrVyEQlwpAqW7sTc0L6QQ
 4YXPWuDtRGO5OlikKxVyMZBERNsQvhbDSK9EwH4IQov+Uba4CAJZxmfrYMo0auBNwyJ2
 plp5KDHfvVx5aAiyje7pQOu/zxGnLSuLe8eQu8ulNfSNqqsD9T6oBM+LkjNDbSxXQOwU
 jfOA==
X-Gm-Message-State: AOJu0YxSw9kwd3Txze59sIKDv6V57NaUjBvopInfKsh7L31AKSnHpWQr
 E8bNCUeToXyor1tA1ToIW01L16VCia7Cdh6qjUMGzoIrF+oYOIdTfctVySFMOSrU1IxkdLME3G8
 rpDXz7WvzZ1QFZOECMeBHh6OMoFKpkZ0AhwTU
X-Google-Smtp-Source: AGHT+IGPGG6ugHW1S8cxJ+F3OyOwzH3pdrD+2mfBCAEY/6Gh6GdB5EPAm5kFTZZRhropf/UoeJIW1W73UglNaM2ktxc=
X-Received: by 2002:a05:6808:13d3:b0:3d5:60d1:bdcd with SMTP id
 5614622812f47-3d6b50c08femr12699215b6e.41.1719935462063; Tue, 02 Jul 2024
 08:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240624092900.2108175-1-andrew.goodbody@linaro.org>
 <CAFLszTg1HmMT-Lzv2aUEmG-jHr0gOAScpdk2RbDueCu_bCnKvw@mail.gmail.com>
 <230eedde-87bd-4625-b258-a345427b659c@linaro.org>
In-Reply-To: <230eedde-87bd-4625-b258-a345427b659c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:50:50 +0100
Message-ID: <CAFLszTiTOLODDv9gYA4croPm=YOiSKd2nqGNUcgFg+pf+mWr8g@mail.gmail.com>
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

On Mon, 1 Jul 2024 at 16:01, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> On 01/07/2024 14:57, Simon Glass wrote:
> > Hi Andrew,
> >
> > On Mon, 24 Jun 2024 at 10:29, Andrew Goodbody
> > <andrew.goodbody@linaro.org> wrote:
> >>
> >> Add the STACKPROTECTOR symbols to the script that generates the
> >> symbols that should not be removed by the use of LTO when linking
> >> a shared object. This prevents a fail to build due to link errors.
> >>
> >> https://source.denx.de/u-boot/u-boot/-/issues/35
> >>
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> ---
> >>
> >>   scripts/gen_ll_addressable_symbols.sh | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/scripts/gen_ll_addressable_symbols.sh b/scripts/gen_ll_addressable_symbols.sh
> >> index d0864804aa..ebf89b04bf 100755
> >> --- a/scripts/gen_ll_addressable_symbols.sh
> >> +++ b/scripts/gen_ll_addressable_symbols.sh
> >> @@ -13,3 +13,5 @@ set -e
> >>   echo '#include <common.h>'
> >>   $@ 2>/dev/null | grep -oe '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*' | \
> >>          sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
> >> +$@ 2>/dev/null | grep -oe '__stack_chk_.*' | \
> >> +       sort -u | sed -e 's/^\(.*\)/extern char \1[];\n__ADDRESSABLE(\1);/'
> >> --
> >
> > It is OK to add these new ones, but here you seem to be adding lots of
> > other things also. So far we are only allowing linker lists. So can
> > you update this to allow just linker lists and stack_chk? Perhaps
> > egrep (_u_boot_list_2_|__stack_chk_) or similar?
> >
> > Regards,
> > Simon
>
> I am sorry but I do not follow you here. I am not sure what you mean by
> 'linker lists'. The script is matching on symbols from object files as
> output by nm. I have not changed that original match expression.
>
> My addition only adds the following 3 symbols to the output of
> gen_ll_addressable_symbols.sh
>
> __stack_chk_guard
> __stack_chk_fail
> __stack_chk_fail_local
>
> These all come from the same file, common/stackprot.c
>
> I can reduce the match to just search for '__stack_chk_guard' and that
> still works and I can put that as another expression in the grep instead
> of doing the whole nm | grep | sort | sed thing a second time. Would
> that address your concerns?

Ah yes that would help, thank you, just running grep once.

Regards,
Simon
