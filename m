Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1D1FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B6A8465C;
	Mon,  4 May 2026 14:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="edSkl0fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B643C8465E; Mon,  4 May 2026 14:49:47 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00B88460E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so6926929a12.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777898985; cv=none;
 d=google.com; s=arc-20240605;
 b=KSr5UjO4ho+xRKyr9OqIYMH4dIQsjIFXlwKuailEpNnNcZdT49ZebSQLQWLwMlZeeX
 rOY2FFlB/RmK7k+Y8a0uhuYb7Pmo8ivcWPYrzrTs9SMpGtpFw6IidtUFX6iw//MRaXoL
 QPtBgqRkUujP5aOANyi1PXE99ldXLksWrpbtpSfizfkIWylRDltmnN6zZfUZ0XFh+5Jd
 C6HR5iGY7P1OHcR+3BxcdA71X8EsmCU56egf18k54GIPp/5rM1Syd/zJrUaannf2Hxpm
 TuePp1nq4kk2p6nfCjkM+lbFQ9ELBiyxq2ovOTD/cgdHAjLMHsNrrNVtcFF34UDO+lfh
 QceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=duFsvBvVxffwwRf/FQkvQkX70PNbYLr4nMJTRJFmnJ8=;
 fh=MiPMVlZqbKlw1fatphHz+fPQCRVQHGg4dnQ7ziOy4C8=;
 b=YtL+O8XGbahJPmlg6J9zM5q+u+bu38tgykqQzSaOTy20hSqjqydqifE7YoUPGs3WQj
 nSWKaXBmpjFHo/PPbU5pR2Vb7FlCe836DTbuKAy70LlPZCAjy+ovrL4m9nw51qZi/JB4
 pJT1CoRrNYZyxeLDoS13SyBv09SsbFJhuREL0yu0xRq9H3h7JEXLRnUDJTYKX/2zElov
 36fbaZj6nDY0T7aE5ekF4LT59gNDjyQNCyj9PtSdlhb/TWArATG90IIG5NmG26dJDL+0
 BOaXr9rtG9pKZ6aQ5IL240MiskwP3G/ivOegxCoEwbxvZFI6FrEfR2oGFkHesG0MBdgy
 xJTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777898985; x=1778503785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=duFsvBvVxffwwRf/FQkvQkX70PNbYLr4nMJTRJFmnJ8=;
 b=edSkl0fQ5HgNRsSOKXhQT1w2xf30ZqLqGA7L8SZcPnX63GWkrkCS/dIMUG2YdWzZ9U
 baoYA3CYvPj4BrWmWBwRYkiIpRZPsiKwwTD6cMQGPq6vDtrjHsM32NGRQWFALiHUapWc
 w7QJr45QxxhevVGBUsp1Nr5DYtuMosFgmuGZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777898985; x=1778503785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duFsvBvVxffwwRf/FQkvQkX70PNbYLr4nMJTRJFmnJ8=;
 b=EHts5Sm/8zPieCKjcvOfTtK0Hw64oVDL8Ny42Gk0N7PZBg7AHNOeuONILKph9FvBcr
 NcUpo2VKu2Bun++gPWDDjcu4sHMTPVHbBVo4ubZOQV/Vmgq+4N8xH8AASDIsBAvhQ6r1
 CRjhunyNoJZb7OwHFNQ1Q9fsV3uaJMzbzIK9J3ea47BOcl+LgibdWVMrs1v9NNnoIKWw
 Vap0WlGhJjG5RypgMzOaMEl2ZzNGP5SFJ/O+I0cu4RXDS29j8PMN1K211suV6A2gVg82
 g0Took0WKIfwTDCACUyHXh+EsQWcmGpnXvIEgNmxPOBRfPJoPMn4didhb1QTjXJWbJxF
 XAdg==
X-Gm-Message-State: AOJu0Yx+6bXx3tFj4gxTfN1xVtqeCxvGDMU4tYzJrGY2EtrU41AH/fWs
 1zC4jo2AkUJFcAObP3KOxYX4GVxFmsAitOCZjogPvq/ACRUbUzMXDWOHkT5v5OnVADXu9tSOsKh
 9iDgo7ZSWqCBidI+Zg3nXUcOuhliOyhSdyhN8cTly
X-Gm-Gg: AeBDievXRJEcP7qkMlEManNeB9uUFuhEw3X4D4z6szlQVsbn2INfmP3Ut8/aUkgqKJj
 xlrR8fnXE1o2xbW2ej67AQt3DFmZYOwC9K2VZzPhPsxjIP9XZAN6L5EgRcIazZwtecQe8Iwc4F9
 lRhLrDPA31guEEgFyTtPG2hidiQE5mMUw4kbOv2QQqQtkH26WZxs/W/bWTC/4ICQDIjK+L61J4R
 DavdVOUfIjIwILzaf4HW3UsXLNDpnItm86QBCG8416dCJRKL7mTe0zMF3MnBdn/3IQb8ILeygUj
 toPOHv82GdIsnuFp
X-Received: by 2002:a17:907:e106:b0:ba8:e7d5:6a7a with SMTP id
 a640c23a62f3a-bbffbf85aebmr291331466b.40.1777898984992; Mon, 04 May 2026
 05:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
In-Reply-To: <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:49:33 -0600
X-Gm-Features: AVHnY4IVqAZYdqcj-wlnfVjS3Pm4-a_KzeWIyKm_cFH_-gAQb0aYYO9AfjZkzsw
Message-ID: <CAFLszTgQxCEYrCTyLkFiEtoDJKPBJKUJqGHFpUK0chb-wCV+DA@mail.gmail.com>
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Mon, 27 Apr 2026 at 03:14, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon, Marek,
>
> On 4/22/26 4:31 AM, Simon Glass wrote:
> > When producing a DTB from fdtgrep, there is no way to reserve extra
> > space so that more nodes/properties can be added at runtime without
> > growing totalsize first.
> >
>
> Ok but why is that an issue? What is the actual usecase? What I'm afraid
> of is that you pad enough and you hit random bugs because you forget
> that adding enough properties can now hit the size limit and you forgot
> to add the logic to resize/grow the fdt when it's too small to fit new
> properties.

I'm going to leave this question to Marek :-)

>
> > Add a -B/--pad option that appends a caller-specified number of free
> > bytes after the strings section and grows totalsize accordingly. The
> > padding is applied after fdt_pack(), so it is not reclaimed when -r is
> > used.
> >
> > Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   tools/binman/btool/fdtgrep.py |  3 ++-
> >   tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
> >   2 files changed, 32 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> > index 446b2f4144b..7b393241878 100644
> > --- a/tools/binman/btool/fdtgrep.py
> > +++ b/tools/binman/btool/fdtgrep.py
> > @@ -16,9 +16,10 @@ Output formats are:
> >       dtb - device tree blob (sets -Hmt automatically)
> >       bin - device tree fragment (may not be a valid .dtb)
> >
> > -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> > +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> >     -a, --show-address                 Display address
> >     -A, --colour                       Show all nodes/tags, colour those that match
> > +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
> >     -b, --include-node-with-prop <arg> Include contains containing property
> >     -c, --include-compat <arg>         Compatible nodes to include in grep
> >     -C, --exclude-compat <arg>         Compatible nodes to exclude in grep
>
> I'm tempted to remove this and just tell people to look at the
> documentation in tools/fdtgrep.c. Especially since we don't actually
> allow the user to pass any of those parameters themselves via the
> bintool, so it isn't actually useful.

I would like fdtgrep to give useful help, though. It is a tool which
can stand alone.

>
> > diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> > index b4c041070f5..83e3d0b9314 100644
> > --- a/tools/fdtgrep.c
> > +++ b/tools/fdtgrep.c
> > @@ -64,6 +64,7 @@ struct display_info {
> >       int types_exc;          /* Mask of types that we exclude (FDT_IS...) */
> >       int invert;             /* Invert polarity of match */
> >       int props_up;           /* Imply properties up to supernodes */
> > +     int pad;                /* Free bytes to append after the strings section */
> >       struct value_node *value_head;  /* List of values to match */
> >       const char *output_fname;       /* Output filename */
> >       FILE *fout;             /* File to write dts/dtb output */
> > @@ -913,6 +914,27 @@ static int do_fdtgrep(struct display_info *disp, const char *filename)
> >                       size = fdt_totalsize(fdt);
> >               }
> >
> > +             if (disp->pad) {
> > +                     int new_size = fdt_totalsize(fdt) + disp->pad;
> > +                     void *new_fdt = realloc(fdt, new_size);
> > +
> > +                     if (!new_fdt) {
> > +                             fprintf(stderr, "Out_of_memory\n");
>
> Should we free fdt here?
>
> man realloc says
>
>         If there is not enough available memory, realloc() shall return a
>         null pointer and set errno to [ENOMEM].  If realloc() returns a
>         null pointer and errno has been set to [ENOMEM], the memory
>         referenced by ptr shall not be changed.
>
> though it also says
>
>         The realloc() function shall deallocate the old object pointed to
>         by ptr and return a pointer to a new object that has the size
>         specified by size.
>
> so if it happens in that order, it's freed before being reallocated (but
> I would guess this to be racey since you want to copy the content of the
> old object into the new object and if you free the space and it can be
> claimed and used by something else).

My understanding is that it does not touch fdt on failure, so we need
free() as you say.

I'll hold off on v2 until you and Marek have figured out the other
questions / issues, since they are bigger than fdtgrep itself.

Regards,
Simon
