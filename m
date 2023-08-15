Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18A5C04A6A
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66958869AB;
	Tue, 15 Aug 2023 16:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FMisEmhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5090869D2; Tue, 15 Aug 2023 16:44:34 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C8286995
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99bcfe28909so708395466b.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692110671; x=1692715471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g38pcbFBy3BzBP/NIDdsqQ3ZYJZ/2R3j1z9bmObcZR4=;
 b=FMisEmhS33z0EDOCyky3r37h+IwMPHewqXOeDmqUD14p+QhFKtXu7S2YJWDSYG83oB
 tU6zdQZGyrLEwL7i52g0szeodCFmhMV5PkiHj1DiPqR4F07gc3ZgLTA9YCqwcB3D6vAY
 MsgpotI045MYP7gGxe8v3A5J2S3vD7T6JKPtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110671; x=1692715471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g38pcbFBy3BzBP/NIDdsqQ3ZYJZ/2R3j1z9bmObcZR4=;
 b=GR7hSVQN9hlXIw/dEsNNW+i7WTcHTL97mBP/hbrK0986zcGL0gZ0egWPxC7kIwLWro
 ZvHX0+v10QNN1ZfXnNUmNeM39CbAAJMTfkKcmKdVKeN4b/A7m1ajjxcyHYyHN3+AHW6X
 PWuM9VZszpCX+SHnI4ujVmNcSHWo1pI4y9wiGRuHUfeWVYzc6e2VzwWNjlTH1GHUdxtJ
 mtmDmrNmDePadh/S2sEHUltu9SV3qvEuwcLxmxndN2tEe8zQr0eruEdT10N3I8tyxEk/
 UZmFLzk05dmJa4G0N/eZbc6w/Tj56FpHnsIc2tVneS0MR5yftaQJ5iu9mtf0xAbTeNQI
 f9dQ==
X-Gm-Message-State: AOJu0YxTumlZJ/UETMC4xWXzf2HH1hA3TGBq7T17dQFJYbepS7U1xCS8
 ebZY2jJK9wuwj3AcQPbc4QY+OdajAAU8p1e3Nd2hqg==
X-Google-Smtp-Source: AGHT+IH1/AWJcYzfK1UANKfVmBbYsLocXmzwd17+4cUj1Nb6uhvjPZaQQKpBlCx6vQyV4p4MtCRWXNAKPJlpZ9Bb7U8=
X-Received: by 2002:a17:906:53cd:b0:982:b224:2a5d with SMTP id
 p13-20020a17090653cd00b00982b2242a5dmr9981929ejo.37.1692110670975; Tue, 15
 Aug 2023 07:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230811155613.GE3630934@bill-the-cat>
 <CAPnjgZ3cL9v5VgQyqHhAr+Do2f8MOy2RYT3jNq7y6m_9i8aeJA@mail.gmail.com>
 <20230812142223.GI3630934@bill-the-cat>
 <CAPnjgZ380FF64cHtBjMTztJpj1bqF3-u2Vpt0YdRo7EzqSiVcw@mail.gmail.com>
 <20230812142824.GJ3630934@bill-the-cat>
 <CAPnjgZ3zC_F4OvuUqfU1=V_aAp74kyNNcEqgNky2VhyWhcpFOA@mail.gmail.com>
 <20230812223758.GK3630934@bill-the-cat>
 <CAPnjgZ0sfYRBGxB=_5Loi-9K=RgfSqLHA2FLafYgBs9vQaC59Q@mail.gmail.com>
 <20230813124045.GL3630934@bill-the-cat>
 <CAPnjgZ2moLG0HKVyQ5nZk91080dpNbC9EYD+u1H1Dw6sYkJ9sg@mail.gmail.com>
 <20230813144352.GM3630934@bill-the-cat>
In-Reply-To: <20230813144352.GM3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 08:44:18 -0600
Message-ID: <CAPnjgZ0DpYY3X9w66N6G0tgAwoN_3-SToTT+2yMmk0Gibse8fg@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] sandbox: Build the mkeficapsule tool for the
 sandbox variants
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>
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

On Sun, 13 Aug 2023 at 08:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Aug 13, 2023 at 07:36:45AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 13 Aug 2023 at 06:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Aug 12, 2023 at 06:14:45PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 12 Aug 2023 at 16:38, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Aug 12, 2023 at 11:03:36AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 12 Aug 2023 at 08:28, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Aug 12, 2023 at 08:24:59AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Sat, 12 Aug 2023 at 08:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, Aug 12, 2023 at 07:08:44AM -0600, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 11 Aug 2023 at 09:56, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Aug 11, 2023 at 08:26:36AM -0600, Simon Glass wrote:
> > > > > > > > > > > > Hi Sughosh,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 11 Aug 2023 at 08:23, Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, 11 Aug 2023 at 19:28, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Fri, Aug 11, 2023 at 04:29:37PM +0530, Sughosh Ganu wrote:
> > > > > > > > > > > > > > > On Thu, 10 Aug 2023 at 22:47, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Aug 10, 2023 at 10:39:06PM +0530, Sughosh Ganu wrote:
> > > > > > > > > > > > > > > > > On Thu, 10 Aug 2023 at 21:22, Tom Rini <trini@konsulko.com>
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > On Thu, Aug 10, 2023 at 07:53:33PM +0530, Sughosh Ganu
> > > > > > > > > > wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Build the mkeficapsule tool for all the sandbox variants.
> > > > > > > > > > This tool
> > > > > > > > > > > > > > > > > > > will be used subsequently for testing capsule generation
> > > > > > > > > > in binman.
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > > > > > Changes since V7: None
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >  tools/Kconfig | 6 +++---
> > > > > > > > > > > > > > > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > > diff --git a/tools/Kconfig b/tools/Kconfig
> > > > > > > > > > > > > > > > > > > index 6e23f44d55..353a855243 100644
> > > > > > > > > > > > > > > > > > > --- a/tools/Kconfig
> > > > > > > > > > > > > > > > > > > +++ b/tools/Kconfig
> > > > > > > > > > > > > > > > > > > @@ -91,10 +91,10 @@ config TOOLS_SHA512
> > > > > > > > > > > > > > > > > > >         Enable SHA512 support in the tools builds
> > > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > >  config TOOLS_MKEFICAPSULE
> > > > > > > > > > > > > > > > > > > -     bool "Build efimkcapsule command"
> > > > > > > > > > > > > > > > > > > -     default y if EFI_CAPSULE_ON_DISK
> > > > > > > > > > > > > > > > > > > +     bool "Build mkeficapsule tool"
> > > > > > > > > > > > > > > > > > > +     default y if EFI_CAPSULE_ON_DISK || SANDBOX
> > > > > > > > > > > > > > > > > > >       help
> > > > > > > > > > > > > > > > > > > -       This command allows users to create a UEFI
> > > > > > > > > > capsule file and,
> > > > > > > > > > > > > > > > > > > +       This tool allows users to create a UEFI capsule
> > > > > > > > > > file and,
> > > > > > > > > > > > > > > > > > >         optionally sign that file. If you want to enable
> > > > > > > > > > UEFI capsule
> > > > > > > > > > > > > > > > > > >         update feature on your target, you certainly need
> > > > > > > > > > this.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Sorry, what is this fixing exactly?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > The tool is required to be supported on the sandbox_spl
> > > > > > > > > > variant, since
> > > > > > > > > > > > > > > > > that is used for the binman tests in CI. Simon had then asked
> > > > > > > > > > me to
> > > > > > > > > > > > > > > > > add support for the tool on all sandbox variants. I missed
> > > > > > > > > > putting his
> > > > > > > > > > > > > > > > > R-b on this patch.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > OK, moving forward just depend on:
> > > > > > > > > > > > > > > >
> > > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230810165224.514772-1-trini@konsulko.com/
> > > > > > > > > > > > > > > > instead please, thanks.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I will base my changes on top of your patch. However, we would
> > > > > > > > > > still
> > > > > > > > > > > > > > > need this patch as part of the series, since Simon wants the
> > > > > > > > > > capsules
> > > > > > > > > > > > > > > to be generated for all the sandbox variants. Thanks.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > No, this isn't needed.  Any sandbox variant that needs capsules has
> > > > > > > > > > > > > > EFI_CAPSULE_ON_DISK enabled.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Simon wants the capsules to be generated on all sandbox variants,
> > > > > > > > > > > > > including those that do not have the EFI_CAPSULE_ON_DISK enabled.
> > > > > > > > > > > > > Which is why we need to have the tool enabled for all sandbox
> > > > > > > > > > > > > variants.
> > > > > > > > > > > >
> > > > > > > > > > > > I want to avoid #ifdefs in the sandbox .dts so far as possible.
> > > > > > > > > > > >
> > > > > > > > > > > > Tom, I'll let you make the final decision.
> > > > > > > > > > > >
> > > > > > > > > > > > In any case, the multiple-images thing needs to be fixed.
> > > > > > > > > > >
> > > > > > > > > > > Sughosh, please update the other sandbox defconfigs to just enable
> > > > > > > > > > > EFI_CAPSULE_ON_DISK.
> > > > > > > > > > >
> > > > > > > > > > > Simon, this I think is an example of where re-working
> > > > > > > > > > > configs/sandbox64_defconfig
> > > > > > > > > > > configs/sandbox_defconfig
> > > > > > > > > > > configs/sandbox_flattree_defconfig
> > > > > > > > > > > configs/sandbox_noinst_defconfig
> > > > > > > > > > > configs/sandbox_spl_defconfig
> > > > > > > > > > > configs/sandbox_vpl_defconfig
> > > > > > > > > > >
> > > > > > > > > > > To be configs/sandbox_defconfig + boards/sandbox/flattree.config,
> > > > > > > > > > > noinst.config, spl.config, vpl.config would be helpful.  There's the
> > > > > > > > > > > sandbox config itself where EFI_CAPSULE_ON_DISK=y and then every other
> > > > > > > > > > > variant just gets that, and we don't have to tweak N configs.
> > > > > > > > > >
> > > > > > > > > > You mean split configs? So far I am unable to build those...
> > > > > > > > >
> > > > > > > > > I don't know what you mean by split configs.  I mean that I think the
> > > > > > > > > only intentional difference between configs/sandbox_defconfig and
> > > > > > > > > configs/sandbox64_defconfig is:
> > > > > > > > > CONFIG_SANDBOX64=y
> > > > > > > > > CONFIG_DEFAULT_DEVICE_TREE="sandbox64"
> > > > > > > > >
> > > > > > > > > And everything else is unintentional.  And there's lots of other deltas
> > > > > > > > > like that between each of the other variants, and sandbox.  And that
> > > > > > > > > this isn't the first, nor likely the last, time where we need to enable
> > > > > > > > > some option on other sandbox config files too, so that CI passes.  This
> > > > > > > > > would all be avoided by using the config fragments mechanism so that
> > > > > > > > > we captured only the intentional delta of a fragment rather than
> > > > > > > > > maintaining N nearly identical, but not quite, files.
> > > > > > > >
> > > > > > > > Well we do have other intentional differences, e.g. OF_LIVE. But OK if
> > > > > > > > we can find a way to make fragments work with buildman (amd qconfig),
> > > > > > > > then we could do this.
> > > > > > >
> > > > > > > Yes, I was noting this in hopes of sparking your interest in figuring
> > > > > > > out how to handle fragments with buildman.  It's similar to how we have
> > > > > > > the override option today.
> > > > > >
> > > > > > We need a list of fragments somewhere, so that it is possible to
> > > > > > enumerate the different board combinations. Does the main defconfig
> > > > > > have a way to specify this, or could we add it?
> > > > >
> > > > > No, I don't think that's the right way to go.  I was thinking of
> > > > > something along the lines of how --adjust-cfg works, but instead it's a
> > > > > csv of additional targets to pass along with the defconfig name when
> > > > > invoking make.
> > > >
> > > > So we would do them one at a time, with the 'name' of the board being
> > > > some portion of the filename of the config-fragment file?
> > > >
> > > > BTW CSV is not great for humans...perhaps a text file with columns
> > > > like boards.cfg ?
> > >
> > > I think you're still missing what I'm saying.  There should not be a
> > > file that lists fragments.  Outside of documentation, at least.  I was
> > > saying csv above because it would make sense to do something like:
> > > ./tools/buildman/buildman --add-fragments=64bit,vpl sandbox
> > > And that would eventually do:
> > > make sandbox_config 64bit.config vpl.config
> > > Which has the standard Kconfig merging of configs/sandbox_defconfig
> > > boards/sandbox/64bit.config (replaces sandbox64_defconfig) and
> > > boards/sandbox/vpl.config
> > > And passing multiple files with a comma seems easiest.
> >
> > So is it only possible to add one fragment file to a build?
>
> The example above is two, and yes, N config fragments works (they are
> merged in listed order).

OK

>
> > I see what you are saying, but from my side I am trying to enumerate
> > the boards, since generally I (like) build things without explicitly
> > specifying each board defconfig.
>
> Yes, but that's not possible in this case I think.  And I'm really just
> trying to figure out how we can make CI a little easier.  But maybe we
> can't / don't bother in this case and keep fixing up the sandbox
> defconfig files as needed.

Maybe...it sounds like you are really just wanting a way for buildman
to manually build a single board with some config added, rather than
having it detect and build everything that is in-tree?

Regards,
Simon
