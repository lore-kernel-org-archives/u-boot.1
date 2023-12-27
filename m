Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E474C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5738798B;
	Wed, 27 Dec 2023 16:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z8HlabIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB18879BC; Wed, 27 Dec 2023 16:46:21 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D4887956
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9cb95ddd1so438415b3a.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703691977; x=1704296777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zH5tw9Q/9zx9RRUr7tF42br7wIxRIewnZyNbxYPwl6E=;
 b=z8HlabIqqlY5BlKMgjR9ZIvAuJPC/U6hi6Vt6DO61yE/vhvvm6pW0+HylxUS/sqEKd
 l0sAZl/cP0Bs4RQagIjhR0su6PFShLYSZv2zUOXnoe4/gEV0yOnvqiHfqY1tCtoj9i7h
 o0KqllQeTgKJdG1q4sC8rlouQeRMVY+kYVZAFBeJV5u3pd0iqt/CV7BXH3FmMTvLh6t7
 y/rWKnEO4OqITu+yeUrwCEoPxTgzZZKn/oBePA4xA6imHfB8waYx/VX6W2ODYDlNYg0m
 N50g6EmbN7sekddR01d0/Mmxpju7DJifU+oHTAfL8IVmwfuZxEbYo1uXwWxTKs7vnoVB
 Uthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703691977; x=1704296777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zH5tw9Q/9zx9RRUr7tF42br7wIxRIewnZyNbxYPwl6E=;
 b=DNd8nmUYa1tdh/fVXfjIvP/R9neEE6CdgGwsVPzNX5vWizfYVz1DPUYVwmQDOtKEYg
 +INXo3PFTFpGeQ5CPtIN7JJKpEow9YPC5DdxRwDvfO+kmI1H2Iz7IwLi8adJmLysBbHG
 a1y1qM6/U3Eg9Lc3vf16Xtcih61a3HH1a055OxWPfmU20f7D37gW1JQFQVINBY9x63PK
 9xVKsIlYan8U0nuW1Xe2+roriv/gOdQSsz69jsgT04f1MHa+8aof3xIi8FK2zUOFkI/O
 H67OuPbPS/AnJJY7DpfSfek8nq3XoFLjxEOjWTBK2TQDwaZ5XSaUPjvYDYOsg17mE7y2
 lWuQ==
X-Gm-Message-State: AOJu0YzUiZT1zHplaoMlv/kc6Gz6NeLKNYSbl99jlrmsVgazQT+Hox6N
 28QP9H1GQi1pfc7BNQtDeIN5pTVYMPdNKnvbEujEK6Q8Jj2g0g==
X-Google-Smtp-Source: AGHT+IHI09FPB+U8jARNDMY0B3vhwDPDahMrzS7D1Ph1Doov1JDiX9XdG2Cvd+w9og+/C4MQvkNxBqU6UoMyCkcKBqM=
X-Received: by 2002:a05:6a00:179d:b0:6d8:c7f:230d with SMTP id
 s29-20020a056a00179d00b006d80c7f230dmr4825587pfg.53.1703691977540; Wed, 27
 Dec 2023 07:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-4-raymond.mao@linaro.org>
 <CAC_iWjLTmmiDq7oP-mS0kvpsCz-k=S5C=8xNeS6VvKK5AeA4EA@mail.gmail.com>
In-Reply-To: <CAC_iWjLTmmiDq7oP-mS0kvpsCz-k=S5C=8xNeS6VvKK5AeA4EA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:46:07 -0500
Message-ID: <CAEfUkULSjnTi1++zhv=Ve8nybgAHVEsy5weFKfDb9ru3Myq-Uw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] bloblist: refactor of bloblist_reloc()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, 27 Dec 2023 at 03:33, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Fri, 22 Dec 2023 at 23:31, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > The current bloblist pointer and size can be retrieved from global
> > data, so we don't need to pass them from the function arguments.
> > This change also help to remove all external access of gd->bloblist
> > outside of bloblist module.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> > Changes in v3
> > - Check the space size before copying the bloblist.
> > - Add return code of bloblist_reloc().
> >
> >  common/bloblist.c  | 10 ++++++++--
> >  common/board_f.c   |  8 ++------
> >  include/bloblist.h |  8 ++++----
> >  test/bloblist.c    |  6 ++----
> >  4 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index db3fbb20cf..5ad1db137a 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -472,13 +472,19 @@ void bloblist_show_list(void)
> >         }
> >  }
> >
> > -void bloblist_reloc(void *to, uint to_size, void *from, uint from_size)
> > +int bloblist_reloc(void *to, uint to_size)
> >  {
> >         struct bloblist_hdr *hdr;
> >
> > -       memcpy(to, from, from_size);
> > +       if (to_size < gd->bloblist->total_size)
> > +               return -ENOSPC;
> > +
> > +       memcpy(to, gd->bloblist, gd->bloblist->total_size);
> >         hdr = to;
> >         hdr->total_size = to_size;
> > +       gd->bloblist = to;
> > +
> > +       return 0;
> >  }
> >
> >  int bloblist_init(void)
> > diff --git a/common/board_f.c b/common/board_f.c
> > index d4d7d01f8f..00b0430889 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -676,13 +676,9 @@ static int reloc_bloblist(void)
> >                 return 0;
> >         }
> >         if (gd->new_bloblist) {
> > -               int size = CONFIG_BLOBLIST_SIZE;
> > -
> >                 debug("Copying bloblist from %p to %p, size %x\n",
> > -                     gd->bloblist, gd->new_bloblist, size);
> > -               bloblist_reloc(gd->new_bloblist,
> CONFIG_BLOBLIST_SIZE_RELOC,
> > -                              gd->bloblist, size);
> > -               gd->bloblist = gd->new_bloblist;
> > +                     gd->bloblist, gd->new_bloblist,
> gd->bloblist->total_size);
> > +               bloblist_reloc(gd->new_bloblist,
> CONFIG_BLOBLIST_SIZE_RELOC);
>
> Why aren't we checking bloblist_reloc() for an error?
>
> Yes. This should be checked as well here. Will update in v4.

[...]

Regards,
Raymond
