Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69811C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 20:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E934082C2F;
	Wed, 18 Jun 2025 22:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dCBOook+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0249882C55; Wed, 18 Jun 2025 22:01:21 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE6082BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 22:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-311bd8ce7e4so6313283a91.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750276877; x=1750881677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJfKFLhT9b0C1z/8BeV/ryNRhP5WVt3CLYeqXDC89uY=;
 b=dCBOook+IZGxAygoDXfaj9XQsKmKGlue/eYT9vP5x5WyTmrYuSDGrV5fcQDppYkgrA
 Dg/I8ItUQ/jLx+0l836VFgfGO55ulWhnD06diTAW8NFJrg5asGe/D6TbQ6bPLydpgjLh
 cbKu+AYHl5exhWCHRMeP95aSjzPAYxezaX6zooG7PImjgk+5WK6C9XVThSNvZ0XSh3hM
 DtelD0WEDIN3Vd+6+/QoY7/LigcXddyYrmWwkUNB96xe2avk/1cYoIAgOoxrAQm0VLQt
 19yjmXCH7jYBq/6rx3Wd8U9b2hNsT/gXv2ZatA07BMAW3MjkCOzbrCJBYgjXwyWO6YDh
 J+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750276877; x=1750881677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJfKFLhT9b0C1z/8BeV/ryNRhP5WVt3CLYeqXDC89uY=;
 b=JSnVUXio/+kA9j35cgsWFKtALXdE46gNPfTTSGcNQAopWj5+OvvI5qxhuEmYL93jFo
 6fqeyCp2f6gHUzOKZSTmq8CRPMFyqFQ2q7BePlhfqJw7s+hoKAqoz7xeeTl7z1GJnllm
 z7Ac7M4YY2EWTrHLuQhXIzqwwjOlFBEYnU9Ry2/IqAC87EphkEcSjdbJrsLV87e5TH9a
 FRrGkEBovhX0Qxrua2erlA4z7ERbnuDFIPTPfcAjwKtiwtr4TtBCrUmZsB4+0IQtrXq+
 xWgcw/kBT4ue5qdU6LoOmFBQh/1NofHlY466aN6+lwQlo1y5LEgAmTXF/0DivPA6sqQ9
 VyLg==
X-Gm-Message-State: AOJu0YxSAF9TtbgH3BuS+N2pIQCHHJtyASOoiT86eiNiBMg4tuB1Sdml
 P+ad20qCqvYTJs3UkYmt3WveH704nm6/rrycr90rPc4sZsMe2MmOfpyWOhU4+4E+FGZZB3Im6Re
 METQ1wiLq4DQpHfXZxV4n/EhJPGcopRYRvpdcNT7pbw==
X-Gm-Gg: ASbGncv4n5ISQB8Ig6w0hR7cKcw181tC6EBTkxbkiZrYDBAdQNRCyBxzCRKjeqWnpfC
 opNeshgs95jWBE4boLMRO8evhUHh2ivwCSFow7Y682t9kyRf9ruqUtN4x8Rk8tWcwYbpuzlDeTz
 2jrs64v/gXT35rFf7uHVnWxia0NLukHJjRn3IB00kyQTLc
X-Google-Smtp-Source: AGHT+IF5IEnYLnPD8csAB0xv8fCbPU0v9M5hnaEhSqwGOt8RECmuzqR0fCnofzEB0fjG+92G34CERTnlHIKSh9AAa3g=
X-Received: by 2002:a17:90a:d60b:b0:313:283e:e87c with SMTP id
 98e67ed59e1d1-313f1c77731mr25836446a91.3.1750276876962; Wed, 18 Jun 2025
 13:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-5-raymond.mao@linaro.org>
 <20250618174011.GI6521@bill-the-cat>
In-Reply-To: <20250618174011.GI6521@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 18 Jun 2025 16:01:02 -0400
X-Gm-Features: AX0GCFvvfVc_m6Z4aY7PE85sfYzyHjrhfIj2zWyqmwOJk_qfCJ9dmabW437a-Oo
Message-ID: <CAEfUkUJnUf2m_Dv=4HM79qqDzQRnhsUU4mKFiprp8cRqHoJogQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] bloblist: expose 'expand_by' as an output argument
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Tom,

On Wed, 18 Jun 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 18, 2025 at 07:59:26AM -0700, Raymond Mao wrote:
>
> > Some advanced usecases of bloblist needs to know the actual bytes
> > expanded or shrunk after blob resizing.
> > For example, to support applying DT overlay from bloblist, firstly
> > the FDT blob needs to be resized for potential size increasing after
> > applying overlay. If the DT overlay blob is one of the following blobs
> > of the FDT, its address will be shifted after FDT blob resizing.
> > Thus, returning 'expand_by' helps the caller to get the shifted data
> > pointer when it comes to get the overlay for applying.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> [snip]
> > @@ -337,6 +338,7 @@ void *bloblist_ensure(uint tag, int size);
> >   */
> >  int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
> >
> > +#if CONFIG_IS_ENABLED(BLOBLIST)
> >  /**
> >   * bloblist_resize() - resize a blob
> >   *
> > @@ -345,10 +347,17 @@ int bloblist_ensure_size_ret(uint tag, int *sizep, void **blobp);
> >   *
> >   * @tag:     Tag to add (enum bloblist_tag_t)
> >   * @new_size:        New size of the blob (>0 to expand, <0 to contract)
> > + * @expand_by:       Number of bytes actually expanded by (-ve to contract)
> >   * Return: 0 if OK, -ENOSPC if the bloblist does not have enough space, -ENOENT
> >   * if the tag is not found
> >   */
> > -int bloblist_resize(uint tag, int new_size);
> > +int bloblist_resize(uint tag, int new_size, int *expand_by);
> > +#else
> > +static inline int bloblist_resize(uint tag, int new_size, int *expand_by)
> > +{
> > +     return -EPERM;
> > +}
> > +#endif
>
> Do we really need to be doing this if/else in the header? What's failing
> otherwise, and can we not guard that with:
> if (IS_ENABLED(CONFIG_BLOBLIST)) {
>   ..
> }
> in the code?
>
This function is needed to be called in fdtdec, if it is not guarded
in the header file, we have to guard it from all its callers to avoid
linker error when BLOBLIST is not selected (In the future, there might
be more than one caller).

Regards,
Raymond


> --
> Tom
