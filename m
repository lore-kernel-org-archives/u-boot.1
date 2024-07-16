Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE33C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 04:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D510D88768;
	Tue, 16 Jul 2024 06:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZN9foq4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1386188633; Tue, 16 Jul 2024 06:42:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A83088953
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 06:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46G4gGOA105028;
 Mon, 15 Jul 2024 23:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721104936;
 bh=unlj39I13T8Bwx3UTFjSLIyGqBXQB1EGvgmiVx+nRoc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ZN9foq4Jb8ZuAf2XqvjuwK/a+IFwpfPCKyYQDVinqHmPta66yJCSAAC5mEGqcVFDW
 zKPd6Emk5Inx5/7mQr2vzbBRCJqS2Cy2g486Ae9jauHkLjjPc4G3X96ZB9M4Hj+2pb
 jQCxy8EuHikhMhOAQu+qPjswjp3AXwE8F+zgVlnM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46G4gGLX008971
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Jul 2024 23:42:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 23:42:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 23:42:16 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46G4gF1U012024;
 Mon, 15 Jul 2024 23:42:16 -0500
Date: Tue, 16 Jul 2024 10:12:15 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
Message-ID: <20240716044215.axz24dmwv4v5m5wo@uda0497581>
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
 <20240710061528.4afx6lcsdsbookug@uda0497581>
 <CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTjr7bJFPnyVx7rTdFB3AFBM_2DVAZU8FZnLBE7ep5ejXw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Simon,

On 10:39-20240711, Simon Glass wrote:
> Hi Manorit,
> 
> On Wed, 10 Jul 2024 at 07:15, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> >
> > Hi Simon,
> >
> > On 09:36-20231217, Simon Glass wrote:
> > > The existing bootph binding is defined such that properties in a
> > > subnode are also implied in the supernode also, as in this example:
> > >
> > >    buttons {
> > >       /* bootph,pre-ram is implied by btn1 */
> > >       compatible = "gpio-keys";
> > >
> > >       btn1 {
> > >          bootph,pre-ram;
> > >          gpios = <&gpio_a 3 0>;
> > >          label = "button1";
> > >          linux,code = <BTN_1>;
> > >       };
> > >
> > > Provide an option to implement this in fdtgrep.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Coming back to this patch as am facing some issues with the bootph-all
> > propagation to the parent nodes [0]. We have a dmsc/sms node in our
> > devices and it is a parent node of k3_pds, k3_clks, k3_reset.
> >
> > During U-boot proper we are initializing the serial console and during
> > that time we have to make some calls to our Device manager for clocks
> > and power domains. With the DT modelling, the clocks and power domains
> > come under the device manager node ( dmsc/sms ) but interestingly that
> > driver is not getting probed while putting bootph-all in the child
> > nodes. Do you know anything about this? I thought putting it in child
> > node will propagate it to the parent nodes as well so it'll be probed as
> > well. We are having to put bootph-all explicitely in the dmsc/sms node
> > for it to work.
> 
> Yes, that is because fdtgrep is only used with the SPL DT. The U-Boot
> one is used unmodified by U-Boot and it does not check parents for
> such properties (neither does SPL, but fdtgrep has logic to imply
> these properties internally).
> 
> The easiest way to fix this would probably be to process the DT in
> Binman for insertion into the final image, since Binman already does
> lots of other DT processing.
> 
> If you like, you could create an issue for it [1]. If you want to have
> a crack at fixing it, I could provide some pointers.

I am not sure if I'll be able to focus on this now but feel free to give
your pointers, might help anyone else as well if they want to take a
look at it.

Meanwhile I will open a issue as you mentioned for tracking this, trying
to register on the URL that you provided. Thanks!

Regards,
Manorit

> 
> Regards,
> Simon
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues
> 
> 
> >
> > [0]: https://lore.kernel.org/linux-arm-kernel/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com/T/#t
> >
> > Regards,
> > Manorit
> > > ---
> > >
> > >  tools/fdtgrep.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> > > index ca639a2d9f4f..f1ff1946bd4a 100644
> > > --- a/tools/fdtgrep.c
> > > +++ b/tools/fdtgrep.c
> > > @@ -63,6 +63,7 @@ struct display_info {
> > >       int types_inc;          /* Mask of types that we include (FDT_IS...) */
> > >       int types_exc;          /* Mask of types that we exclude (FDT_IS...) */
> > >       int invert;             /* Invert polarity of match */
> > > +     int props_up;           /* Imply properties up to supernodes */
> > >       struct value_node *value_head;  /* List of values to match */
> > >       const char *output_fname;       /* Output filename */
> > >       FILE *fout;             /* File to write dts/dtb output */
> > > @@ -606,6 +607,16 @@ static int check_props(struct display_info *disp, const void *fdt, int node,
> > >                                        strlen(str));
> > >       }
> > >
> > > +     /* if requested, check all subnodes for this property too */
> > > +     if (inc != 1 && disp->props_up) {
> > > +             int subnode;
> > > +
> > > +             for (subnode = fdt_first_subnode(fdt, node);
> > > +                  subnode > 0 && inc != 1;
> > > +                  subnode = fdt_next_subnode(fdt, subnode))
> > > +                     inc = check_props(disp, fdt, subnode, inc);
> > > +     }
> > > +
> > >       return inc;
> > >  }
> > >
> > > @@ -955,7 +966,7 @@ static const char usage_synopsis[] =
> > >       case '?': usage("unknown option");
> > >
> > >  static const char usage_short_opts[] =
> > > -             "haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTv"
> > > +             "haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
> > >               USAGE_COMMON_SHORT_OPTS;
> > >  static const struct option usage_long_opts[] = {
> > >       {"show-address",        no_argument, NULL, 'a'},
> > > @@ -985,6 +996,7 @@ static const struct option usage_long_opts[] = {
> > >       {"skip-supernodes",     no_argument, NULL, 'S'},
> > >       {"show-stringtab",      no_argument, NULL, 't'},
> > >       {"show-aliases",        no_argument, NULL, 'T'},
> > > +     {"props-up-to-supernode", no_argument, NULL, 'u'},
> > >       {"invert-match",        no_argument, NULL, 'v'},
> > >       USAGE_COMMON_LONG_OPTS,
> > >  };
> > > @@ -1016,6 +1028,7 @@ static const char * const usage_opts_help[] = {
> > >       "Don't include supernodes of matching nodes",
> > >       "Include string table in binary output",
> > >       "Include matching aliases in output",
> > > +     "Add -p properties to supernodes too",
> > >       "Invert the sense of matching (select non-matching lines)",
> > >       USAGE_COMMON_OPTS_HELP
> > >  };
> > > @@ -1202,6 +1215,9 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
> > >               case 'T':
> > >                       disp->add_aliases = 1;
> > >                       break;
> > > +             case 'u':
> > > +                     disp->props_up = 1;
> > > +                     break;
> > >               case 'v':
> > >                       disp->invert = 1;
> > >                       break;
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> > >
