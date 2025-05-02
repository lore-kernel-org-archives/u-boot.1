Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54839C3ABA9
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 07:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E59480F03;
	Fri,  2 May 2025 09:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u7ETI/Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA211812BC; Fri,  2 May 2025 09:29:30 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AB88070C
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 09:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5240a432462so1127467e0c.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746170967; x=1746775767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=enQo569jLuwEfp2N7VoYq3vBqEfn1OzyGnSTI36x7C0=;
 b=u7ETI/RgwUj9+Cz+y9V3fiGkEaR93U7o3JHupZUHzqdXlfgvHEdzv8LjItEOUcT5Pc
 JNGNd20IizuYA9BuC0lLU1io8Ugi9fqUi0UzVvECgVo0wOkCkA3MGdSQJRMGWAljfITc
 2haOLW3RTLXOBbtw8rUmU8v39DyDCfKhseozLsLusCImu4hiJEeXD/hyLznNcnF0XwEQ
 bN0EtWiKa+INq8hYEdRJ4G+TPAbMkN4EKQLleg1i+AQ54cQfJCnyM+kkRQL+dBxxZwNf
 MhmFPkQM3gC0UX2bbVSeiyGlE4eGuJdPaShJmgkQNnuCjmZHmyXhgX1dNvHf5k6SJTyw
 6yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746170967; x=1746775767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=enQo569jLuwEfp2N7VoYq3vBqEfn1OzyGnSTI36x7C0=;
 b=P2o6xclH3MHiyD/VMX8WvEOZjPSnOqW4tpPNIX+RDsCR6xQOuGNs6lY1QfQq8W6Dgh
 8NVfu9phrjD4cCCVbAbF62Rl48U71P0q7cborwe6RFxda70xB+46CXzr3LgNC9qLoA3T
 XdZo5YJQpY5si/dk4Lv9iSNIKjmbCEqxcgwiwtgWczusbJSNZ1Nh17R2KkVhSxZ+4G9G
 ggvddBpaQYy6bHzy46FC1ZHLUi5pEnDAO+SCRHvdXK8jAI1TcZK4W1JoP1RlBTokS4VK
 jcZEbw6Uv/XFZZTCLUv81QJg/cN5UgwZ7cmc1AIdOeuWW7HJUZ44zCY+zqWiJeY42oYS
 k+UQ==
X-Gm-Message-State: AOJu0YziEH7bKcocX3e7cXbdzfAs/rZDVdF1zp7AG9QuacpKKKmBqSY3
 tSyBb5kZccTcJ1SbntE670PDs8tZi601eYQUCoEbc9rDtDP8rg531fFKtnclQ5iUy2R2C5Gs36E
 826nref6OxT1pow+8XwgwDWHMvfqhK8KG97sYsw==
X-Gm-Gg: ASbGncuRbibJW/abaHxHPyKWQurKajmWkfYy9ujDavple1KDi/Uk6bgkW+lSuf8z3Wq
 MGaKiRrEA6a+p82BrJCIJfUqeEmeDBHS8JGspVxL53bsloI5MnYSdmplG+rvesglnrxUjUb+wpw
 sQyDuKdYWXEfMrcfrAj3ooPQ==
X-Google-Smtp-Source: AGHT+IGklnIZufQihaw36EqjAse1iq2JnBJsrm6lT6gapLQnkRjjqw5xf+lkT55IOZL22NjP0A0Fg8Zvb/eaUWqIGmg=
X-Received: by 2002:a05:6122:1907:b0:52a:654e:bd98 with SMTP id
 71dfb90a1353d-52adea1c00bmr4157265e0c.0.1746170967382; Fri, 02 May 2025
 00:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-2-sughosh.ganu@linaro.org>
 <D9LH4NBVTI6Y.3CQ2ICBEYXZT3@linaro.org>
In-Reply-To: <D9LH4NBVTI6Y.3CQ2ICBEYXZT3@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 2 May 2025 12:59:16 +0530
X-Gm-Features: ATxdqUGwt3-vFwjwMVKRu8oPnxenoqVEaHZ5lwEcO2iuuFeXM8sTrVxaPZAyDdk
Message-ID: <CADg8p96dT1+umwWWqeO95xcZTjvw3pNU7PsGnsnS-n5sHysg+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] lmb: replace lmb_reserve() and lmb_alloc_addr() API's
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Fri, 2 May 2025 at 12:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> Thanks for cleaning this
>
> [...]
>
> > + * @flags:           Memory region attributes to be set
> > + *
> > + * Allocate a region of memory where the allocation is based on the parameters
> > + * that have been passed to the function.The first parameter specifies the
> > + * type of allocation that is being requested. The align parameter is used
> > + * to specify if the allocation is to be made with a particular alignment.
> > + * It is 0 if there is no alignment requirement. The addr parameter is used
>
> Use 0 for no alignment requirements

Okay. Will change.

>
> > + * to return the base address of the allocated region. Depending on the type
> > + * of allocation request, it might also contain a particular address being
> > + * requested, or the maximum address of the requested allocation. The flags
> > + * parameter is used to specify the memory attributes of the requested region.
> > + *
> > + * Return: 0 on success, -ve value on failure
> > + *
> > + * When the allocation is of type LMB_MEM_ALLOC_ADDR, the return value can
> > + * be -EINVAL if the requested memory region is not part of the LMB memory
> > + * map, and -EEXIST if the requested region is already allocated.
> > + */
> > +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
> > +                  phys_size_t size, u32 flags);
> > +
>
> [...]
>
> > +}
> > +
> > +int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
> > +                  phys_size_t size, u32 flags)
> > +{
> > +     int ret = -1;
> > +
> > +     if (!size)
> > +             return 0;
>
> Shouldn't this be an error as well?

So I had this return an -EINVAL in my original set of changes.
However, I hit a corner case issue with my testing where a tftp
transfer of a payload which happens to be a multiple of the tftp block
size, and that results in the final receive loop having a length of 0.
Jerome confirmed that this is indeed a valid scenario with tftp. So
this can be an issue with any kind of loop based reservation requests,
where the final iteration of the loop might present a size of 0.
Moreover, I checked the implementation of other allocation functions
(including efi_allocate_pages()), and they do not return an error if
the size passed to the function is 0. Hence this behaviour.

-sughosh

>
> > +
> > +     if (!addr)
> > +             return -EINVAL;
> > +
> > +     switch (type) {
> > +     case LMB_MEM_ALLOC_ADDR:
> > +             ret = _lmb_alloc_addr(*addr, size, flags);
> > +             break;
> > +     default:
> > +             log_debug("%s: Invalid memory allocation type requested %d\n",
> > +                       __func__, type);
> >       }
> >
> > -     return -1;
> > +     return ret;
> >  }
> >
> >  /* Return number of bytes from a given address that are free */
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index 3bf558f7f4f..f80115570e7 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -71,6 +71,19 @@ static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
> >       return 0;
> >  }
> >
>
> [...]
>
> Thanks
> /Ilias
