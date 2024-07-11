Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE82C3DA47
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 09:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A54886D7;
	Thu, 11 Jul 2024 11:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ti2IQUOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293AB886DA; Thu, 11 Jul 2024 11:39:57 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8648188685
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 11:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b5e4466931so4186736d6.0
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720690793; x=1721295593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VB0AJBGj6M9Lb4k6ljhOy7KJtNrc1RsJt4T4Ppi8Di4=;
 b=Ti2IQUOPDeHbmXKMPo83Cf72Iw5L1+5ZYEsviuWqqrgNgA5aRGkkP+gHqBSEO0U68y
 6wpntEvN/kmjAJv7i5kTsgu13CdVQtLzTRO10RLT4Ffv4CuSG4yyGx/i9UDAAYM8BE3E
 hYTTUF2+/lvygIeODps34wfEvpfsvxIqPrak0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720690793; x=1721295593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VB0AJBGj6M9Lb4k6ljhOy7KJtNrc1RsJt4T4Ppi8Di4=;
 b=WXCZO8bAKqj6Gakm4eOVIyURfQLaxVRGIpyzNpq9OMG0lEO6YoBEN0hJ7zi/7xhskA
 72QbM+InX4EwIV60ZjWhaBk2dHIq6VjlwSiTi7bfAzIYPb55rvOLTF6sOatyjMvDe9oI
 aGgJCfVuZMCCkSYS3n+zj+rqDSucGC6RqeiyWlFwZGI7M/gyhUywVQuFPDJlddELdgSN
 K2Pz3wJISU6p1IHc72JAfu8QFiCppdyVre9M9JrPtFUGoU9HFqsxLV3vtJ4eOeL3t+PH
 M5UzhQv/Dg/pmk0XrRAJwpuYxdIi6YwWEcVj4i/My0z/8bTkRa812v5pp3c+ZQ06Bm55
 Pdig==
X-Gm-Message-State: AOJu0YwEfYhJ0OTG+8Pbb495pS24fCbvqPWAFtm+b+kA5pC5/TcoAX9g
 KvwfS/YWiRodPq/GEQGXrmiDgsdeAU5Zn6IAJsEUettOJ35IJ5OKilRY7NtOin7GNUynUebBNo0
 904OwstXBgbKRvorMvlPqcVUMx1eWm8u61xoO
X-Google-Smtp-Source: AGHT+IHN8jdNK4qWZ/if0/OV+O5RdXv2VubVPpTWK8eConc9nvv0sv+G0CLaGnuTMGXpAaNBZrjQNG7fK4XKkRP+tgc=
X-Received: by 2002:ad4:5be8:0:b0:6b5:4098:abe2 with SMTP id
 6a1803df08f44-6b61c1f5264mr103404096d6.52.1720690793248; Thu, 11 Jul 2024
 02:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
 <20240710061528.4afx6lcsdsbookug@uda0497581>
In-Reply-To: <20240710061528.4afx6lcsdsbookug@uda0497581>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 11 Jul 2024 10:39:42 +0100
Message-ID: <CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
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

Hi Manorit,

On Wed, 10 Jul 2024 at 07:15, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 09:36-20231217, Simon Glass wrote:
> > The existing bootph binding is defined such that properties in a
> > subnode are also implied in the supernode also, as in this example:
> >
> >    buttons {
> >       /* bootph,pre-ram is implied by btn1 */
> >       compatible = "gpio-keys";
> >
> >       btn1 {
> >          bootph,pre-ram;
> >          gpios = <&gpio_a 3 0>;
> >          label = "button1";
> >          linux,code = <BTN_1>;
> >       };
> >
> > Provide an option to implement this in fdtgrep.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Coming back to this patch as am facing some issues with the bootph-all
> propagation to the parent nodes [0]. We have a dmsc/sms node in our
> devices and it is a parent node of k3_pds, k3_clks, k3_reset.
>
> During U-boot proper we are initializing the serial console and during
> that time we have to make some calls to our Device manager for clocks
> and power domains. With the DT modelling, the clocks and power domains
> come under the device manager node ( dmsc/sms ) but interestingly that
> driver is not getting probed while putting bootph-all in the child
> nodes. Do you know anything about this? I thought putting it in child
> node will propagate it to the parent nodes as well so it'll be probed as
> well. We are having to put bootph-all explicitely in the dmsc/sms node
> for it to work.

Yes, that is because fdtgrep is only used with the SPL DT. The U-Boot
one is used unmodified by U-Boot and it does not check parents for
such properties (neither does SPL, but fdtgrep has logic to imply
these properties internally).

The easiest way to fix this would probably be to process the DT in
Binman for insertion into the final image, since Binman already does
lots of other DT processing.

If you like, you could create an issue for it [1]. If you want to have
a crack at fixing it, I could provide some pointers.

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues


>
> [0]: https://lore.kernel.org/linux-arm-kernel/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com/T/#t
>
> Regards,
> Manorit
> > ---
> >
> >  tools/fdtgrep.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> > index ca639a2d9f4f..f1ff1946bd4a 100644
> > --- a/tools/fdtgrep.c
> > +++ b/tools/fdtgrep.c
> > @@ -63,6 +63,7 @@ struct display_info {
> >       int types_inc;          /* Mask of types that we include (FDT_IS...) */
> >       int types_exc;          /* Mask of types that we exclude (FDT_IS...) */
> >       int invert;             /* Invert polarity of match */
> > +     int props_up;           /* Imply properties up to supernodes */
> >       struct value_node *value_head;  /* List of values to match */
> >       const char *output_fname;       /* Output filename */
> >       FILE *fout;             /* File to write dts/dtb output */
> > @@ -606,6 +607,16 @@ static int check_props(struct display_info *disp, const void *fdt, int node,
> >                                        strlen(str));
> >       }
> >
> > +     /* if requested, check all subnodes for this property too */
> > +     if (inc != 1 && disp->props_up) {
> > +             int subnode;
> > +
> > +             for (subnode = fdt_first_subnode(fdt, node);
> > +                  subnode > 0 && inc != 1;
> > +                  subnode = fdt_next_subnode(fdt, subnode))
> > +                     inc = check_props(disp, fdt, subnode, inc);
> > +     }
> > +
> >       return inc;
> >  }
> >
> > @@ -955,7 +966,7 @@ static const char usage_synopsis[] =
> >       case '?': usage("unknown option");
> >
> >  static const char usage_short_opts[] =
> > -             "haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTv"
> > +             "haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
> >               USAGE_COMMON_SHORT_OPTS;
> >  static const struct option usage_long_opts[] = {
> >       {"show-address",        no_argument, NULL, 'a'},
> > @@ -985,6 +996,7 @@ static const struct option usage_long_opts[] = {
> >       {"skip-supernodes",     no_argument, NULL, 'S'},
> >       {"show-stringtab",      no_argument, NULL, 't'},
> >       {"show-aliases",        no_argument, NULL, 'T'},
> > +     {"props-up-to-supernode", no_argument, NULL, 'u'},
> >       {"invert-match",        no_argument, NULL, 'v'},
> >       USAGE_COMMON_LONG_OPTS,
> >  };
> > @@ -1016,6 +1028,7 @@ static const char * const usage_opts_help[] = {
> >       "Don't include supernodes of matching nodes",
> >       "Include string table in binary output",
> >       "Include matching aliases in output",
> > +     "Add -p properties to supernodes too",
> >       "Invert the sense of matching (select non-matching lines)",
> >       USAGE_COMMON_OPTS_HELP
> >  };
> > @@ -1202,6 +1215,9 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
> >               case 'T':
> >                       disp->add_aliases = 1;
> >                       break;
> > +             case 'u':
> > +                     disp->props_up = 1;
> > +                     break;
> >               case 'v':
> >                       disp->invert = 1;
> >                       break;
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
