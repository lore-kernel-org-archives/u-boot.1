Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237A9E95A6B
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94E88691E;
	Sat,  7 Oct 2023 22:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mFTnnTh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B561286D7E; Sat,  7 Oct 2023 22:19:13 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B188B8691E
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so568480366b.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696709947; x=1697314747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MbmD3960l1ka3duexs4RTWfAdGW+YFr9iJGyPR8N+r8=;
 b=mFTnnTh8kV+QVzJlwNhuTfEpcL3tppaqrqCX95VSNJwFW8Us38obkLgjBPmY6a98Kl
 OyR3bkop+dSh9bo4xgplqLUF6Yd712nn4WCbmrDEDA01HD8Do4EXX5sELJn7HqA/Ldpc
 f5p72YK6/WLERhuc/WpqH94X/2ZzF7S1GVLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696709947; x=1697314747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MbmD3960l1ka3duexs4RTWfAdGW+YFr9iJGyPR8N+r8=;
 b=vexw2b6QUYglDqCQRrmccpzID+YcsHUU2tnE2mRJ4Drz/lXXNO6M+pCt7MIdutMc8g
 jdswmUabDbqWnVOpQqnh9lat0n1aA1pu+vV4uCxxL04N2XSoy/DCgDHOcDqEYQvvZ4KL
 d+1xzYEE/bn49t4JW9qBim5+Kh+ogaLglxwWST/afTz/Zuf+SC4fDcUlrsRvIrlGu01L
 /Q+u8WeNQb0oC3CHHw3r62wmoFUQBQSAGUG0tz7rza21+V330xhgcx+7htXw4BAvn3wc
 geiaidVxjAUZDRD5zEdRoJeJAKD6DIyoFu2hbAcAS6VVPNH0iRW7xXhsk4/+DuT1GVJ3
 9F6w==
X-Gm-Message-State: AOJu0YynlH3Ty/h9WnpbsvKKtWdu4z5Vx8+5moah5R36tyrhsyLo4M/E
 D1z/hIOezYyzCOnrdhYy2Ftz9ABrJj8fwyaUDYaz7A==
X-Google-Smtp-Source: AGHT+IEWFKmT9ydxasJJm4ji0wAUpQsx9H4pEVB05ru+LZjg99lbHZnqAQOCA/rXdQcONzd22miKMhIiLh6tUfsnz3w=
X-Received: by 2002:a17:907:7897:b0:9ae:3c6c:6ecd with SMTP id
 ku23-20020a170907789700b009ae3c6c6ecdmr10975657ejc.19.1696709946843; Sat, 07
 Oct 2023 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
 <20231006021616.GB2227687@bill-the-cat>
 <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
 <20231006165504.GC2227687@bill-the-cat>
 <CAPnjgZ1GZ+Ryt2=_Sf0Z+XM+V58Ty4UmdrAo2bW-Ubs9s19=Ww@mail.gmail.com>
 <20231007010053.GE2227687@bill-the-cat>
 <CAPnjgZ3Pss6uOhnopo4Yn0digdNs1niNqqrJHRmnrbDvehT1hg@mail.gmail.com>
 <20231007172516.GH2227687@bill-the-cat>
In-Reply-To: <20231007172516.GH2227687@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 14:18:53 -0600
Message-ID: <CAPnjgZ1GLqA_Zk7jZQn+d72TU=X8FBzr9nDHOZx4h4-cUdX6Jg@mail.gmail.com>
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

On Sat, 7 Oct 2023 at 11:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 07, 2023 at 09:37:07AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Oct 2023 at 19:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Oct 06, 2023 at 04:42:44PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 6 Oct 2023 at 10:55, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Oct 06, 2023 at 07:03:17AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 5 Oct 2023 at 20:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > > > > > > > > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > > > > > > > > > > Declaration of long help should be bracketed by an #ifdef to avoid an
> > > > > > > > > > > > 'unused variable' warning.
> > > > > > > > > > > >
> > > > > > > > > > > > Fix this treewide.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > [snip]
> > > > > > > > > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > > > > > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int flag, int argc,
> > > > > > > > > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > -/***************************************************/
> > > > > > > > > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > > > > > > > > >  static char dek_blob_help_text[] =
> > > > > > > > > > > >       "src dst len            - Encapsulate and create blob of data\n"
> > > > > > > > > > > >       "                         $len bits long at address $src and\n"
> > > > > > > > > > > >       "                         store the result at address $dst.\n";
> > > > > > > > > > > > +#endif
> > > > > > > > > > > >
> > > > > > > > > > > >  U_BOOT_CMD(
> > > > > > > > > > > >       dek_blob, 4, 1, do_dek_blob,
> > > > > > > > > > >
> > > > > > > > > > > This really doesn't read nicely.  I would rather (globally and fix
> > > > > > > > > > > existing users) __maybe_unused this instead.  I think there's just one
> > > > > > > > > > > example today that isn't "foo_help_text".
> > > > > > > > > >
> > > > > > > > > > Hmm, what do you think about adding a __longhelp symbol to cause the
> > > > > > > > > > linker to discard it when not needed?
> > > > > > > > >
> > > > > > > > > Well, I don't think we need linker list magic when __maybe_unused will
> > > > > > > > > just have them be discarded normally.
> > > > > > > >
> > > > > > > > Yes, perhaps things are in a better state than they used to be, but
> > > > > > > > there is a linker discard for commands at present.
> > > > > > >
> > > > > > > Yes, but __maybe_unused means we don't get a warning about it, and it's
> > > > > > > literally discarded as part of --gc-sections as it done everywhere with
> > > > > > > maybe 3 exceptions?
> > > > > >
> > > > > > Actually with this series we get a lot closer to that. The problem
> > > > > > with the status quo is that disabling CMDLINE doesn't disable most
> > > > > > commands, relying instead on discarding them at link time.
> > > > >
> > > > > I don't follow you here.  We're talking only about the long help.
> > > >
> > > > I was actually talking about how the command code is removed. This
> > > > series allows that to happen via Kconfig rather than needing a
> > > > linker-script discard rule, something I only just fully appreciated.
> > >
> > > OK.  But this series as-is has a lot of problems and I don't see it as
> > > more than a proof of concept.
> >
> > Probably I need to send a few version as this discussion is becoming a
> > bit theoretical.
> >
> > >
> > > > > There's already an option to enable/disable it.  When disabled all of
> > > > > the long help text should be discarded, because we reference it via
> > > > > U_BOOT_CMD macro which in turn cares about it, or not.  What's missing
> > > > > is a U_BOOT_LONGHELP macro so that instead of:
> > > > > #ifdef CONFIG_SYS_LONGHELP
> > > > > static char cat_help_text[] =
> > > > >         "<interface> <dev[:part]> <file>\n"
> > > > >         "  - Print file from 'dev' on 'interface' to standard output\n";
> > > > > #endif
> > > > >
> > > > > We do:
> > > > > U_BOOT_LONGHELP(cat,
> > > > >         "<interface> <dev[:part]> <file>\n"
> > > > >         "  - Print file from 'dev' on 'interface' to standard output\n"
> > > > > );
> > > > >
> > > > > Which then does:
> > > > > static __maybe_unused char cat_help_text[] =
> > > > > ...
> > > > > ;
> > > > >
> > > > > And we discard the text automatically due to --gc-sections.  We possibly
> > > > > haven't already been doing this since back when we first started using
> > > > > --gc-sections there was a bug in binutils that caused text like the
> > > > > above to still get combined in to other objects and not discarded.
> > > > > That's been fixed for ages.
> > > > >
> > > > > And the above macro would also let us clean up U_BOOT_CMD macro slightly
> > > > > to just omit the longhelp option and instead always do _CMD_HELP(_name)
> > > > > inside the macros.  It'll also make it harder to add new commands
> > > > > without a long help by accident.
> > > >
> > > > Gosh this is complicated.
> > > >
> > > > At present the U_BOOT_CMD() macro just drops the strings...the problem
> > > > with the unused var only happens in a small number of cases where an
> > > > explicit var is used. I don't see why creating a var (when none is
> > > > there today) helps anything? It doesn't detect missing longhelp, since
> > > > this is already an error (missing argument). Sure,  "" can be
> > > > provided, but your macro doesn't stop that either.
> > >
> > > The problem today is that 95% of the cases surround the help text with
> > > #ifdef CONFIG_SYS_LONGHELP ... #endif.  That's why the rest of the
> > > macros are the way they are today.  And that in turn is due to (in part
> > > at least) old compiler bugs.
> >
> > I see about 46 #idefs for that and nearly 300 commands that don't have one.
> >
> > >
> > > > If you are suggesting a new U_BOOT_LONGHELP() macro, bear in mind that
> > > > we already have quite a lot...each new 'top-level' macro results in
> > > > more combinations.
> > >
> > > It really should just be a single macro.  I think I'll make an attempt
> > > at this, to show what I'm talking about.
> >
> > OK thanks.
> >
> > >
> > > > > > With this series, it looks like we can in fact do that, so I should
> > > > > > remove the discards as well.
> > > > > >
> > > > > > The one proviso is that this does drop a lot of things we want...e.g.
> > > > > > BOOTSTD_DEFAULTS cannot be enabled due to its use of 'select', meaning
> > > > > > that common filesystems are dropped. So we'll need more effort after
> > > > > > this, to allow (for example) bootmeths that don't need commands to
> > > > > > work correctly. But I think this series at least provides a better
> > > > > > starting point for teasing things apart.
> > > > > >
> > > > > > So OK I'll go with __maybe_unused for the ones that need it, which
> > > > > > isn't too many given that many of the strings are just included
> > > > > > directly in the macro. It is considerably easier than trying to be to
> > > > > > clever about things.
> > > > >
> > > > > Yes, this series itself has a lot of problems that need to be addressed
> > > > > before reposting because I don't like "hiding" that network stuff no
> > > > > longer works, and I also saw that DFU also silently failing.
> > > >
> > > > Yes I saw your other comments. But I think this patch is the big area
> > > > of confusion.
> > >
> > > This isn't the tricky part of the series that I'm saying has problems,
> > > that part is all of the functionality that's not being untangled and I
> > > think leads to the question of what exactly is the use case where we do
> > > remove the command line but don't need some of that functionality still.
> >
> > For security and code-size reasons it is useful to disable commands,
> > perhaps all of them. Quite a few features don't need it, but it
> > certainly would take more effort to get a usable version. The goal of
> > this series is to avoid people adding Kconfig mistakes which need to
> > be cleaned up later.
>
> Maybe the biggest take away should be to do things smaller.  DFU
> intentionally and fundamentally constructs something for the CLI parser
> to use.  Rework that.  Same for the network stack.  Do some slight
> re-org / fixing of more intentional dependencies on their own.

I think it is better to do it the other way around, to avoid further
Kconfig regressions. At the moment we can't actually turn off CMDLINE,
so none of the work can actually be used.

The particular thing I am interested in is booting an OS without CONFIG_CMDLINE

Regards,
Simon
