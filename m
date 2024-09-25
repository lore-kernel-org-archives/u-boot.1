Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E39C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5A788C24;
	Wed, 25 Sep 2024 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGp9ZCtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6204D88216; Wed, 25 Sep 2024 14:49:22 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F239288216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9b72749bcso603933685a.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268557; x=1727873357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=98Pz2WR/Lcvu6i/AGBQhwQ8uo7SQYjQGT/Ndd8N55ac=;
 b=VGp9ZCtCwQMmsLPShETGQKTzuwkH/R27h5jhzv2c9aQDw55Reujwptdsy0vXiM9Msj
 k63//GKOAY7eh6eZ6qa9bsDUWHcjvqnXYqVqSBmlA2f2XcfwLbqdzwPhd5fuqe9DRQ7F
 hiU7hiZ3MzUAU3XfG/eHW1CeWUK5AqSc7k4/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268557; x=1727873357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98Pz2WR/Lcvu6i/AGBQhwQ8uo7SQYjQGT/Ndd8N55ac=;
 b=hY7ZyCYf6uVfTEoa5Rj49jIkXuPx2GSUlTf2nwvlqPd64DiyFgUp3HG3MQum+85FSU
 agtF/BrFa4/hZj43H/6yVXKHZRnhzKmAF+9nnhhHuB28JzPirwn63zTnN4S10bmeMUQP
 7Xr3vjTwZ3p7JFZyp1n461RAF5BfBZA8kY09VWdI6ue76NWUeO6E31mbEyfVTjxzJzxf
 fFzJ6eylTWHunH3xm2bvaRhWCtk20BnoCI77zMAyO06re+3PnI8Rcxb9718/NSG18oiY
 jEtOqzmc6CJ3nN6M60ysLAFTDAHZJAa0fDGpesZ/LnJSlJbsVx2d2d/pEiuU58b0KM4+
 u27A==
X-Gm-Message-State: AOJu0YwcnzggHn0isbmXl1H58KKUCPJlg6f3l62Py82KRFzsmJdYRU4w
 YbxMNfVfOcYIqRjsxBTHXtz7njtsetORGn7B43dZA6hOILhxUdpNo67ryjk/ZLsZk9fNfGmhGvW
 jeNYwl8JqbLQzgL0GNgQjqZAzQDI9S03Zs6Tq/KnozvZsI9QfUg==
X-Google-Smtp-Source: AGHT+IEGbeNSFLdLZ3HGIz2qcmfraKtoGvJClloWTWxxJnhe/SweS+XIwcUKW9CUz0v/cNkVXostafdEnLc+YFpTrig=
X-Received: by 2002:ad4:470c:0:b0:6c5:1fe4:c642 with SMTP id
 6a1803df08f44-6cb1ddcb806mr26743396d6.32.1727268556726; Wed, 25 Sep 2024
 05:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
 <20240627144214.GC38804@bill-the-cat>
 <CAFLszTixbMxDq7TvjPzc+Xup6biMmPvLP5CVPJLp7w94e0dd4Q@mail.gmail.com>
 <CAFLszThFL4BnoprJJ8qdSo8g_5Umo36yGp0ba4w=cAexgH9cNA@mail.gmail.com>
 <20240729181719.GP989285@bill-the-cat>
 <CAFLszTi-ajf+wbwxyK3Xq3Efnwz9y+8U7nL7MgLrNY2h=V7faw@mail.gmail.com>
 <20240731171719.GE3794063@bill-the-cat>
 <CAFLszTiSngoo_6-t7u+uPCsELHGkoRy4-5J_i_1v8rWfFpvMRA@mail.gmail.com>
 <20240923203503.GP4252@bill-the-cat>
In-Reply-To: <20240923203503.GP4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:49:04 +0200
Message-ID: <CAFLszTiLJnkwU5=P+xx-_8VQoVHLCxrepusUTAQ5U_Ox_oEBiw@mail.gmail.com>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 19, 2024 at 04:13:57PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 31 Jul 2024 at 19:17, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 08:39:30AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 29 Jul 2024 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Jul 28, 2024 at 01:36:09PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 28 Jun 2024 at 01:33, Simon Glass <sjg@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 27 Jun 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Some configuration is now in variables with a CFG_ prefix. Add these to
> > > > > > > > > > > > > > > the .cfg file so that we can see everything in one place. Sort the
> > > > > > > > > > > > > > > options so they are easier to find and compare.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > > > > > > > > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > > > > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > > > > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > > > > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
> > > > > > > > > > > > > > >  quiet_cmd_u_boot_cfg = CFG     $@
> > > > > > > > > > > > > > >        cmd_u_boot_cfg = \
> > > > > > > > > > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> > > > > > > > > > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > > > > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > > > > > > > > > > > > >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > > > > > > > > > >               rm $@.tmp;                                              \
> > > > > > > > > > > > > > >       } || {                                                          \
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't like this because whereas "CONFIG_" is enforced to be set only
> > > > > > > > > > > > > > by Kconfig and so always all reliably set and found via a single header,
> > > > > > > > > > > > > > CFG_ stuff is not.
> > > > > > > > > > > > >
> > > > > > > > > > > > > OK, so how are CFG_ options found? I hit this when trying to find the
> > > > > > > > > > > > > SDRAM size on rockchip 3399 and I could not find any way of figuring
> > > > > > > > > > > > > it out.
> > > > > > > > > > > >
> > > > > > > > > > > > It's just another define, there's no uniformity to it. For some of the
> > > > > > > > > > > > SDRAM values really we need some build time way to grab some information
> > > > > > > > > > > > out of the default device tree.
> > > > > > > > > > >
> > > > > > > > > > > Can you give an example of a board that could use this? I looked at
> > > > > > > > > > > the devicetree for chromebook_kevin and don't see a memory range in
> > > > > > > > > > > ther.
> > > > > > > > > >
> > > > > > > > > > OK, wow, I didn't realize /memory was optional now. But indeed, I don't
> > > > > > > > > > see it in the dtb file. That removes that option then, sadly.
> > > > > > > > >
> > > > > > > > > Well, we can still require it, so long as an error is produced if the
> > > > > > > > > property is needed but does not exist.
> > > > > > > >
> > > > > > > > "We" who? I don't feel like we'll have a lot of traction with linux
> > > > > > > > kernel folks in requiring /memory to be added to the dts files on
> > > > > > > > however many platforms don't have it today because I'm going to guess
> > > > > > > > it's added at run time, possibly by us, with the correct size and we'd
> > > > > > > > be asking for statically adding things half-wrong like a lot of
> > > > > > > > platforms used to do (and in turn rely on U-Boot to correct the size).
> > > > > > >
> > > > > > > Hmm yes of course, the firmware is supposed to add these
> > > > > > > properties...that's how it gets in there. So we need to stick with CFG
> > > > > > > (and perhaps the RAM-size prober) for now.
> > > > > >
> > > > > > Coming back to this patch, can we apply it? It provides a way to find
> > > > > > out the value of these CFG options, which otherwise involves chasing
> > > > > > around header files.
> > > > >
> > > > > No, because it implies that there's a consistent way to know what a
> > > > > given CFG value will be when there is not. There is no equivalent header
> > > > > to include like for CONFIG symbols to know that you got them. You're
> > > > > likely better off trying out "ripgrep" which I have found to be much
> > > > > faster than "git grep".
> > > >
> > > > Hmm it is really hard to know which files to grep!
> > >
> > > It's super easy with ripgrep:
> > > $ rg -g *.h CFG_SYS_SDRAM_SIZE
> >
> > All that does is show me lots of matches. I'm not sure which board
> > they relate to. Some of them are obvious, but quite a few have header
> > files common to many boards.
> >
> > >
> > > > Could we require that config.h includes all the CFG values? I'm just
> > > > trying to find a way to bring a bit more order to this area.
> > >
> > > Well, some of them could perhaps be Kconfig symbols instead, it just got
> > > too tedious to untangle some of them. For others (not
> > > CFG_SYS_SDRAM_SIZE/BASE, sadly) it goes back to my idea about seeing
> > > what can be pulled at build time from the default device tree.
> >
> > Hmm, yes. I am not sure how many are in that category. Linux often
> > seems to use tables of data in the code, since it doesn't care so much
> > about code size. So finding bindings for some of this data may be
> > tricky.
> >
> > I suppose the SDRAM base/size could go in the DT if it had its own
> > binding, e.g. in /options/u-boot - but still many boards would want to
> > determine the size at runtime.
> >
> > With text environment and a solution to SDRAM, perhaps we can require
> > that new boards not use CFG_...?
>
> I don't see doing anything further to CFG_ as particularly important
> right now, honestly. The majority of symbols are in legacy things and
> then it's just a few symbols that no, really, there's not a good way to
> get this information other than a define.

OK, I give up on this. I will try to ignore CFG from now on. Most
things are in Kconfig so that is good.

Regards,
Simon
