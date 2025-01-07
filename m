Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F9EE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC022801E8;
	Tue,  7 Jan 2025 14:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gbeAeWAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C18F805D5; Tue,  7 Jan 2025 14:58:21 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FF78007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-216281bc30fso8588275ad.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736258295; x=1736863095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtA/arabJOhxQ0QFhQwHZj1MtZ+fF6hFSCsa/Gv+eQ8=;
 b=gbeAeWAci0QihKPP/EO4EoBQL74LKX43yzthoay9pZbPkYkZKYyUmFgj6rr9n06TeO
 oyBE0quC8RXsGWJucGNv8AoIjixIf7qA03LW3xV+XR9EwQ6e7y7VRXSIpJrdqXIRM00e
 GlMTZ8XocAbwc+VnxGpafRfWsoBZXVEe/w4Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736258295; x=1736863095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtA/arabJOhxQ0QFhQwHZj1MtZ+fF6hFSCsa/Gv+eQ8=;
 b=dHmiTIiRdSK8nXtzjevIJXyraxOXU6UmkzuZrNSi3wNjwFUdiuWxzN8rccQlbXRd0h
 Cj+K6hV5SlbwOST6eS/3tVr77CMQX/J4ZB0NhJ+NXMKE8bJ5pxMiohBEH1ZhPTTuVdJe
 pZ0rdmXvCBY23B3AoF2otVogx6iVFF9exxNeNu9u4XZiCT7d9a/093J1Gx9xsU66WAXm
 aDxIfix634Rf/g0VILaI7Y2uv/sXPbxjPc2Q+K2cXD7/ROMi55YM0RebWfrY4ZBspUE0
 Kw6IKGlyjdIJLCpjCp5vn5Jn7/bFlPTXK5TAbbttJRqaStRTK7xeH811cIT8niWsVi0F
 8HqA==
X-Gm-Message-State: AOJu0YwXQbAgWVBeLbqEOJZbH2oyEP/Q1WRN3HCvTpu3YX3eu3l6X9G8
 azgaPjlmOY0hjq0JepA8DudNLCdpM5o8O2PSmOH+UBdGmpk2la1FYcFVovl3EaMjGZ8SQRMfbRg
 F70jMwn49ZilN0TvymhRlxk7teJ9WEdsbUdAz
X-Gm-Gg: ASbGncvKp7lgDskkgE984K2AdOJBxX8dtfsVQXDKTcJOmz7q336bqXmXIt7HS4MvJEC
 z7m/97wFZSaZRao0U4DHDVYGal2dbst3rrSOBt70=
X-Google-Smtp-Source: AGHT+IEzDEG13/n+4Dq9G8ix0n0Sb9/qQ4L2Qf/vxxFdYvb5/gOvoIdm6qWKOyk7vbc0XpHT8J4CP9I6Q89ioN6EBPM=
X-Received: by 2002:a05:6a00:8087:b0:725:ef4d:c1bd with SMTP id
 d2e1a72fcca58-72abde84667mr91967346b3a.19.1736258295398; Tue, 07 Jan 2025
 05:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-3-sjg@chromium.org>
 <CAC_iWjLrSEpHgTGK3WhHTGQ-SF5Zg6o_h14x++ot8FD+JAm3RA@mail.gmail.com>
In-Reply-To: <CAC_iWjLrSEpHgTGK3WhHTGQ-SF5Zg6o_h14x++ot8FD+JAm3RA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 06:57:58 -0700
X-Gm-Features: AbW1kvav79uG6CSPLZMifvRw9ee66Mm8GEHH-VDyqp2JegtX3vgvFVAsQ87m77k
Message-ID: <CAFLszTjaeMimD_0HczGXxJUhjDjP+-TjT6RdfW5XOzBFhg+hkQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] efi_loader: Fix display of addresses in log
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Tue, 7 Jan 2025 at 06:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > The allocate/free-pages functions return an address, so there is no need
> > to convert it. Fix this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: c824a96d76d ("efi_loader: Use the log with memory-related...")
>
> I can't find that commit in -master. Is there anything I am missing?

Sort-of. You, Tom and Heinrich NAKed this series. See [1]

> >  lib/efi_loader/efi_log.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
> > index 4b9c6727fe7..ad490bb431c 100644
> > --- a/lib/efi_loader/efi_log.c
> > +++ b/lib/efi_loader/efi_log.c
> > @@ -340,8 +340,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
> >                 show_ulong("pgs", (ulong)rec->pages);
> >                 show_addr("mem", (ulong)rec->memory);
> >                 if (rec_hdr->ended) {
> > -                       show_addr("*mem",
> > -                                 (ulong)map_to_sysmem((void *)rec->e_memory));
> > +                       show_addr("*mem", rec->e_memory);
> >                         show_ret(rec_hdr->e_ret);
> >                 }
> >                 break;
> > @@ -349,7 +348,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
> >         case EFILT_FREE_PAGES: {
> >                 struct efil_free_pages *rec = start;
> >
> > -               show_addr("mem", map_to_sysmem((void *)rec->memory));
> > +               show_addr("mem", rec->memory);
> >                 show_ulong("pag", (ulong)rec->pages);
> >                 if (rec_hdr->ended)
> >                         show_ret(rec_hdr->e_ret);
> > --
> > 2.34.1
> >

Regards,
Simon

[1] https://lore.kernel.org/u-boot/CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com/
