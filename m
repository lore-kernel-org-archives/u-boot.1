Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA1BE94139
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 22:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEBF86BDF;
	Sat,  7 Oct 2023 00:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jadbyeSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1552186B89; Sat,  7 Oct 2023 00:42:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE0C86B89
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 00:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so4428652a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696632175; x=1697236975; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gyR5sV5GMYvjytTrl0n0bTviimCSK3SbnVT9yfcYBjQ=;
 b=jadbyeSZW+MZVYGgVbUVYBlSPKkOPUt/Ch0sDW+yfCxhp9GLK7muCOJM7cXH1ksibo
 Qdipc4SlrSvnJQLPQ/v8f3CRw43BzNW+1I80bmcy99V4BG+PRW7iJ8eg7fuVI86+KfUv
 K0yRDrDEWhVZBoOa6LDCDXxqOn84tCCQbFeLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696632175; x=1697236975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyR5sV5GMYvjytTrl0n0bTviimCSK3SbnVT9yfcYBjQ=;
 b=wuNf9K2/5YusICa26ayh1r4Qv1Yq0sUMI3y2y03VQIFvwbYB9lbM7qJGaiiI4fCVaf
 iN9Mb5m0COn4twMPNmMl+CNVyd7JpN71jsPmxNxQTR7y0hHrZ0BqcxaRnqPk2Hch++Jz
 w7DYULSXhsiMzMoIWo5mxqczU9WD7sWektEo8xK6FAjnxLKg5bOPbLnROTGAQOfm1KqD
 Nc+caNwSiCRIy3BtCLUhP/IvxOqv+R93B9XfniabXwj/C8b1YdwefG/VFQnM+k06chYs
 nKQ9VYxOnwTSOp2+1dZLkXrZq+WI9gAAL6FuV/l0jFmwxx7ZTzVSrrOM2wYvDd4vb73w
 M7ng==
X-Gm-Message-State: AOJu0Yy5gTaWJL00HHYpZ+xZdBlUJAQLBnFUS3IoDAioo0uA8HDI3TRu
 DsL5xEy7cbK+8wRj4bDGUGlONyjouSzV4+GbDflO6w==
X-Google-Smtp-Source: AGHT+IG6z2Qgpv5CAIdZTG0sTKtGt1xIeTIEfnKCDdbQPNQ36Na6n5QJJRusE8Ys4KcsTz/ZY8F4R5P9621Fzh5yf/8=
X-Received: by 2002:a17:906:1097:b0:9ad:7890:b4c0 with SMTP id
 u23-20020a170906109700b009ad7890b4c0mr7445670eju.56.1696632175274; Fri, 06
 Oct 2023 15:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
 <20231006021616.GB2227687@bill-the-cat>
 <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
 <20231006165504.GC2227687@bill-the-cat>
In-Reply-To: <20231006165504.GC2227687@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 16:42:44 -0600
Message-ID: <CAPnjgZ1GZ+Ryt2=_Sf0Z+XM+V58Ty4UmdrAo2bW-Ubs9s19=Ww@mail.gmail.com>
Subject: Re: [PATCH 05/25] treewide: Correct use of long help
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, 
 Leo <ycliang@andestech.com>, Michael Walle <michael@walle.cc>, 
 Michal Suchanek <msuchanek@suse.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Rick Chen <rick@andestech.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, uboot-stm32@st-md-mailman.stormreply.com
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

On Fri, 6 Oct 2023 at 10:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 06, 2023 at 07:03:17AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 5 Oct 2023 at 20:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > > > > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > > > > > > Declaration of long help should be bracketed by an #ifdef to avoid an
> > > > > > > > 'unused variable' warning.
> > > > > > > >
> > > > > > > > Fix this treewide.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > [snip]
> > > > > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -/***************************************************/
> > > > > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > > > > >  static char dek_blob_help_text[] =
> > > > > > > >       "src dst len            - Encapsulate and create blob of data\n"
> > > > > > > >       "                         $len bits long at address $src and\n"
> > > > > > > >       "                         store the result at address $dst.\n";
> > > > > > > > +#endif
> > > > > > > >
> > > > > > > >  U_BOOT_CMD(
> > > > > > > >       dek_blob, 4, 1, do_dek_blob,
> > > > > > >
> > > > > > > This really doesn't read nicely.  I would rather (globally and fix
> > > > > > > existing users) __maybe_unused this instead.  I think there's just one
> > > > > > > example today that isn't "foo_help_text".
> > > > > >
> > > > > > Hmm, what do you think about adding a __longhelp symbol to cause the
> > > > > > linker to discard it when not needed?
> > > > >
> > > > > Well, I don't think we need linker list magic when __maybe_unused will
> > > > > just have them be discarded normally.
> > > >
> > > > Yes, perhaps things are in a better state than they used to be, but
> > > > there is a linker discard for commands at present.
> > >
> > > Yes, but __maybe_unused means we don't get a warning about it, and it's
> > > literally discarded as part of --gc-sections as it done everywhere with
> > > maybe 3 exceptions?
> >
> > Actually with this series we get a lot closer to that. The problem
> > with the status quo is that disabling CMDLINE doesn't disable most
> > commands, relying instead on discarding them at link time.
>
> I don't follow you here.  We're talking only about the long help.

I was actually talking about how the command code is removed. This
series allows that to happen via Kconfig rather than needing a
linker-script discard rule, something I only just fully appreciated.

> There's already an option to enable/disable it.  When disabled all of
> the long help text should be discarded, because we reference it via
> U_BOOT_CMD macro which in turn cares about it, or not.  What's missing
> is a U_BOOT_LONGHELP macro so that instead of:
> #ifdef CONFIG_SYS_LONGHELP
> static char cat_help_text[] =
>         "<interface> <dev[:part]> <file>\n"
>         "  - Print file from 'dev' on 'interface' to standard output\n";
> #endif
>
> We do:
> U_BOOT_LONGHELP(cat,
>         "<interface> <dev[:part]> <file>\n"
>         "  - Print file from 'dev' on 'interface' to standard output\n"
> );
>
> Which then does:
> static __maybe_unused char cat_help_text[] =
> ...
> ;
>
> And we discard the text automatically due to --gc-sections.  We possibly
> haven't already been doing this since back when we first started using
> --gc-sections there was a bug in binutils that caused text like the
> above to still get combined in to other objects and not discarded.
> That's been fixed for ages.
>
> And the above macro would also let us clean up U_BOOT_CMD macro slightly
> to just omit the longhelp option and instead always do _CMD_HELP(_name)
> inside the macros.  It'll also make it harder to add new commands
> without a long help by accident.

Gosh this is complicated.

At present the U_BOOT_CMD() macro just drops the strings...the problem
with the unused var only happens in a small number of cases where an
explicit var is used. I don't see why creating a var (when none is
there today) helps anything? It doesn't detect missing longhelp, since
this is already an error (missing argument). Sure,  "" can be
provided, but your macro doesn't stop that either.

If you are suggesting a new U_BOOT_LONGHELP() macro, bear in mind that
we already have quite a lot...each new 'top-level' macro results in
more combinations.

>
> > With this series, it looks like we can in fact do that, so I should
> > remove the discards as well.
> >
> > The one proviso is that this does drop a lot of things we want...e.g.
> > BOOTSTD_DEFAULTS cannot be enabled due to its use of 'select', meaning
> > that common filesystems are dropped. So we'll need more effort after
> > this, to allow (for example) bootmeths that don't need commands to
> > work correctly. But I think this series at least provides a better
> > starting point for teasing things apart.
> >
> > So OK I'll go with __maybe_unused for the ones that need it, which
> > isn't too many given that many of the strings are just included
> > directly in the macro. It is considerably easier than trying to be to
> > clever about things.
>
> Yes, this series itself has a lot of problems that need to be addressed
> before reposting because I don't like "hiding" that network stuff no
> longer works, and I also saw that DFU also silently failing.

Yes I saw your other comments. But I think this patch is the big area
of confusion.

Regards,
Simon
