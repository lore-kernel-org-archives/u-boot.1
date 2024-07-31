Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B61C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A1A588886;
	Wed, 31 Jul 2024 09:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LH7QAvrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 294AA88934; Wed, 31 Jul 2024 09:27:35 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA97D8780E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7163489149eso3870201a12.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722410851; x=1723015651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v0Qo0rppn6tdPrHQTQQzZ3QZgJA68Y5I3EgM1ZIReWY=;
 b=LH7QAvrVMjTc1pu3/SSyWE6zqi87h8QnFF47GvpH2B/Hm/bX3Atr/m/O3mA4tggHRd
 S9cA0iLMRzLJJaXr828KEpdINakUh3MXmOXyY+rH12SnMdrw4NLOfYTyVH3GwvOs0vQN
 7CpdZ0xsbt30IW0aLEFHMSE0t6Ybgs/D2sUvedAt9M73WdjFm9bLRTyJnIGjJHyFLA/J
 q30CuNSsOFGJs47IbSvl0qlbzGIwjPMo4Q8ajAsAzMHbUEgPpwtHsBUL5ROmIzaapoJ9
 pdHodO4vKjGQ6FwbDStIBCzuFCtIFGQzxPwfPPUnIY9jNVsD6Tp2n6IE3cXj+KeanVpf
 Jo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722410851; x=1723015651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0Qo0rppn6tdPrHQTQQzZ3QZgJA68Y5I3EgM1ZIReWY=;
 b=SA2XE3g+QiYId7YXflItYFcA8Nd24qtpPSUZ5eg/0gH7+db7jetmkUgDd1cShEdxh9
 dmsXE7znAyM8NJqrMTFkAObmo+kyO4PiIvJXOUz2xNzF4630+lOsdxk+nWuSG+o5xXnu
 G6RtgVAdKKasetrXxcsXfHzpvevtoGAuViCd/OO1oj5rZj0yY4Vf0sBdDu3AVkq5nkTF
 Id+s0Yx306kRt67aFhYichidrK14lDgjxlXttjW22YI3oX7Rgr/WUG18Ozd7AWrDCpgv
 A08+0Jd6tNcel7yriVIAVuLY/aGZh8ymn4MgMZ9h4IaqssCEG1tDp93/xqJyY2SUVasB
 ELPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOErULLOfzU7e7/iPlRZRcxty/zSlg2tczOE+kjFeqSJTr8G7WNPccAkzAZFCSTjknj+Q/uZKcRHAJDLJfpz+mM3tRaA==
X-Gm-Message-State: AOJu0Yw6fFSCwn2mJakKCz5gcuk0c/rqUEJqmK845ToxMZrnvH28oOdV
 k6HsCh2I+50lVV+HYvHeTAtSYJw0vSOTinsVsCP+lfDAOpf3PSAHC2QyoWRzqs/8ZtZBcfqg68P
 KjkVc6gooVsinf+HGBb8TU2DO566XPZxnGgi5gg==
X-Google-Smtp-Source: AGHT+IFAaPKWdD48Undcv447BkHYqZJ/53ULofuGVhlMrxED7waELO0p61XyuvdLJReAh2wcfZ4RRw9oppYjJl3FaAw=
X-Received: by 2002:a05:6a20:9e4b:b0:1c0:e612:296d with SMTP id
 adf61e73a8af0-1c4a15147e2mr16371567637.54.1722410851247; Wed, 31 Jul 2024
 00:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-3-sughosh.ganu@linaro.org>
 <ee72476f-7926-4cea-9525-3f494ec1ce72@gmx.de>
In-Reply-To: <ee72476f-7926-4cea-9525-3f494ec1ce72@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 10:26:55 +0300
Message-ID: <CAC_iWj+v0yA3mrUxA2aw7xaTYtani9qu2ne3P+Judhk78w=_1g@mail.gmail.com>
Subject: Re: [PATCH 3/5] efi_memory: avoid possible null pointer dereference
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
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

On Wed, 31 Jul 2024 at 09:19, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 7/30/24 13:11, Sughosh Ganu wrote:
> > Populate the previous memory descriptor node pointer only after it's
> > parent struct has been initialised. The compiler fixes this logic to
> > do the right thing, but it is better to have correct code in place.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Fixes: 7b05667ce239 ("efi_loader: Merge memory map entries")
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> > ---
> >   lib/efi_loader/efi_memory.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index bfadd6bd41..8d4f6e339d 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -138,7 +138,7 @@ static void efi_mem_sort(void)
> >               merge_again = false;
> >               list_for_each(lhandle, &efi_mem) {
> >                       struct efi_mem_list *lmem;
> > -                     struct efi_mem_desc *prev = &prevmem->desc;
> > +                     struct efi_mem_desc *prev;
> >                       struct efi_mem_desc *cur;
> >                       uint64_t pages;
> >
> > @@ -149,6 +149,7 @@ static void efi_mem_sort(void)
> >                       }
> >
> >                       cur = &lmem->desc;
> > +                     prev = &prevmem->desc;
> >
> >                       if ((desc_get_end(cur) == prev->physical_start) &&
> >                           (prev->type == cur->type) &&
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
