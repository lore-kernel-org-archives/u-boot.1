Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9462FCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368AC84836;
	Mon,  4 May 2026 22:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XH2EY1q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA7884706; Mon,  4 May 2026 22:40:50 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9446284859
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c2d57a5ceso3363860a12.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927248; cv=none;
 d=google.com; s=arc-20240605;
 b=IZUJeUqlST0F8HWqlk3zreVGgVTKLd0m0OVr/kEQ03IM3i9f5okAjXufxlMXvI/sHQ
 bixBo6tjRH2TsHiQqKJARwOYl/rlBypi5M2ghv+kUjL/iMzsOiH0kxSMp9PbOL+UDq05
 zBfBD5t/Oi37OPF5VJ9kjKvNa4x/nltxZH/45dHnXZm8coVXba6bFrOeNlonecjTmvTq
 kRNZDJkrpkCz6PsnSufOQVayknbr13GqzyR/+wPPzNGCO/PbUIGJMEvCsR8AxLBfcBKM
 GM9CAJTw67/PJxPVhhJMMlSDnB17Aghl9ynPriANmNtc+jElHliX3IGSK2KUwNwfiTG1
 0VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rb5HwW8rB4LFDA6bRTFJslM+YN5yY8MPBvz97W3aoYw=;
 fh=KOAJnZ3yqZz1k4UafEiM97ZsU4VPS7w6l2kYYxF7AlI=;
 b=QSBGpAvrq1lXi9sLfdlPWaTRVHno6qPY50eSmVfVQlZEkAlugr+ITAzKE/sg+5fUcL
 /qmid1dwNRR8VchWzGH1gCBAjqTsqu9tNHCDOV2TnXPbrZB2n7nQop3+iisaLeNjcs1J
 ARBYZs+qWd0wRsUV32wY3lGsWnpwTyLssFqqylWO1/aYRSXdUF/YcfpJb+4gPPgVgALg
 s4BjCqm7KuiNjP3kIPJ2lAm+A0q0TVtaHVDWTdZyRMYfExJo3JIUNqAA+gVyEvuIAeTI
 htHtMeC1djp4lufwhXDO0K/jdcJUEKOOKBD54pApyAV31YE9dVUyV2uQuEJXed8TPlPP
 yAbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777927248; x=1778532048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb5HwW8rB4LFDA6bRTFJslM+YN5yY8MPBvz97W3aoYw=;
 b=XH2EY1q6co57BCCG0lc624gzVdNXvRgLB2X0QmS7pb0j+0gPFxll4K58q7+cB+ET3J
 HKARP9Vo2vTMX7KFUd+cNJEV1faKy6Ue5BO8eWe/icDECn2tKfsqkmZIynsTdVnBkkCi
 0vg2gfxJZrUmyhUy/VJh7EFcaoyTNddVSilZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927248; x=1778532048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb5HwW8rB4LFDA6bRTFJslM+YN5yY8MPBvz97W3aoYw=;
 b=RSJoJ5RCy4GRUtxydE9b7oHgyvYkl+XD76i1sxvbeadbxiVM4s/In3TEgCqoIe8cPG
 ZL2vvi+Pj+AwTK2/CFu7CjrDBxk/o73tYDKaHhKXfYBJl36SHDdq6AW37eKmK4AUu/L0
 49iFrqVy3DtEo39ptsuzbbTo990Y6uYF6XWk4BrwUN2u8pr3DTerOQYhcWaA7j8Ek8cv
 HSM5Qu+tDj2575+SC4B2gb4bWpM09jEipTaCv2KEiF7hpxtYlKdejcC5+F5uXqIg7Mdd
 F4iGP4P/PKUANVliJQrUSRZ2HO03doP5vwdLHfHWnd8mrZqBjBUfCSlu6AgnLe8bQYYi
 oPEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UWLIPuGlm4or3r96hG1SeAcTQVBZ/SYA7k/evEOA+jStT8CmFyZf2VEtl9PJy0XqpCZeReGI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzjp7YCq7y/g4bT8xPfTmyXiidLFNnAM+g0IJey0hWoM/B82nlb
 H6GFVUb+wHUTdo+z/Ux2Bw5kzuPu5Ulam5GkPmUVBhQ/mXcWpAb9yn2mLp51C6lG3SuPCk574S3
 +WQY3/9FspmrXyjhBASA9WrYTFHyNzGaKD38VPy8hLngfpKZyq3w=
X-Gm-Gg: AeBDietltq1UMq8nqY9kymMKe3nl7cRntlyG9VzqEomrAc75tckfBWNLah0opxH5H7l
 smO3vNHr2DY5dcjnOtjeYEa2D1TI3/eEI3kP04Xgf6yZa6tqNk/mRJ/mxrpZaHaOOcrAy8m7oP5
 EE8ifzug1s+NJzyRSBaIIqZRLwuR2oztiS6sLVywq0AW9uhLYVxnkAzJgInrrhaQnjrqx78CiwC
 BP2TtCRApyig9S+FAtmkx25KH33G3u+1bwA8ZzQr6Mo5uO0gNopwm43wNj2BcULAn43HQDUUBZq
 u/OCuBPeBtPei1Hb
X-Received: by 2002:a17:907:e8f:b0:bbe:384e:4c4d with SMTP id
 a640c23a62f3a-bbff97349a7mr633262566b.14.1777927247907; Mon, 04 May 2026
 13:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
 <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
 <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
 <20260504173544.GI1614990@bill-the-cat>
In-Reply-To: <20260504173544.GI1614990@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:40:30 -0600
X-Gm-Features: AVHnY4L35OQT7R13tnyjo2JrSUBoEd9vGzW1vYsiBQFRVVarjwGjkkI7ytfC5is
Message-ID: <CAFLszTjESKRGDD3wi4ftxRdXR1X2JZcqybOMHdUYboZ7xjN3Qg@mail.gmail.com>
Subject: Re: Couple of clang warnings for Rockchip boards
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
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

On Mon, 4 May 2026 at 11:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 04, 2026 at 05:14:13AM -0600, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > On 4/29/26 4:25 PM, Tom Rini wrote:
> > > > On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> > > >> Hi Tom,
> > > >>
> > > >> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
> > > >>>
> > > >>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> > > >>>> Hi Quentin,
> > > >>>>
> > > >>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>>>>
> > > >>>>> Hi Simon,
> > > >>>>>
> > > >>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
> > > >>>>>> Hi Quentin,
> > > >>>>>>
> > > >>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>>>>>>
> > > >>>>>>> Hi all,
> > > >>>>>>>
> > > >>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> > > >>>>>>> First, let me know if this is a bad idea :)
> > > >>>>>>
> > > >>>>>> I don't like it, as it makes development slower. I like to see all the
> > > >>>>>> warnings created by a change and tend to fix them iteratively. We
> > > >>>>>> already have a warning check in CI. A better approach is to
> > > >>>>>>
> > > >>>>>> Can you use: KCFLAGS=-Werror
> > > >>>>>>
> > > >>>>>> either in your environment or on the 'make' cmdline?
> > > >>>>>>
> > > >>>>>
> > > >>>>> Well, if it's during development, you can always disable WERROR? The
> > > >>>>> fact that I've never actually enabled -Werror locally in about a decade
> > > >>>>> in U-Boot probably isn't a good sign. One of the things that make me
> > > >>>>> wary though is compiler updates with new warnings. I've tested with
> > > >>>>> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> > > >>>>> about to be released as well.
> > > >>>>>
> > > >>>>> By having the check in CI, we have a longer-than-necessary feedback loop
> > > >>>>> for contributors. Has this been an issue in the past? /me shrugs
> > > >>>>
> > > >>>> This is strange though, because people should see the warnings during
> > > >>>> development. I wonder if it is scrolling off the screen.
> > > >>>>
> > > >>>> One my bugbears is non-actionable output. When the build succeeds
> > > >>>> (with no warnings) I see no output, using 'buildman -I --board xxx -w
> > > >>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> > > >>>> -s' under the hood, so that it doesn't print a huge list of filenames,
> > > >>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> > > >>>> check everything is clean ('buildman -m' does something similar).
> > > >>>>
> > > >>>> Note that buildman returns exit code 101 if there are any warnings, so
> > > >>>> the build basically fails.
> > > >>>>
> > > >>>>>
> > > >>>>> No defconfig seems to be setting this option, not sure exactly why that is.
> > > >>>>
> > > >>>> To me this is a difference between 'functionality' options and
> > > >>>> development options. Putting development options in Kconfig makes it
> > > >>>> harder to turn them on and off, since you must either edit the
> > > >>>> defconfig or edit the .config file. It is easier to just pass an
> > > >>>> environment variable.
> > > >>>
> > > >>> The point of a configuration is that it configures the build. Stuff in
> > > >>> environment (directly or make FOO=bar) is a workaround and anti-pattern.
> > > >>> Having to run one of the config front-end to change the config is a
> > > >>> feature, and good thing.
> > > >>
> > > >> To give an example, we have boards which enable LTO, but it is
> > > >> sometimes useful to disable it during development - it used to be a
> > > >> huge time sync but something seems to have changed recently, as I
> > > >> don't see much of a performance gap now. We don't want people
> > > >> disabling LTO in the defconfig, though. The same applies for things
> > > >> like V=1
> > > >>
> > > >> So I think there are build features which are of no use to end-users,
> > > >> but are helpful for development. That is the distinction we have had
> > > >> for a while and it would be a shame to lose it.
> > > >
> > > > Yes, the LTO thing is a good example of something we shouldn't have done
> > > > really. Outside of sandbox you cannot just disable it.
> >
> > Are you sure about that?
>
> Yes. Outside of sandbox LTO is enabled because the platform binaries
> will exceed their non-optional size constraints.

That is certainly true for some boards, but I'm not sure it is very many.

>
> > I seldom build with LTO, except for CI. For
> > an incremental build the non-LTO is often twice as fast. Most of the
> > time when developing new features I am just trying to make things
> > work, so it is big time-saver in the IDE. To some extent this is
> > changing, though (LSPs and AI tools). The main impact for me is with
> > sandbox incremental builds.
>
> We could maybe just drop LTO from sandbox, now that it's enabled more
> widely on hardware.

The nice thing about LTO for sandbox is that it tests a different
build path. We could perhaps disable it for just the 'sandbox' board?

>
> > > >
> > >
> > > FYI, the Linux kernel defaults to CONFIG_WERROR=y. See commit
> > > 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).
> >
> > Do we suffer from this same problem?
> >
> > >
> > > I wouldn't necessarily recommend to switch it on right now, but I think
> > > it could be a good idea in the mid-term. We're also very far behind in
> > > terms of warn flags compared to the kernel. Syncing will take some time
> > > though. For now I'm looking into enabling -Werror for host tools and
> > > this resulted in (so far) 21 patches.
> >
> > I must be misunderstanding what you are referring to here. I don't see
> > any warnings when building tools-only - certainly I would not put up
> > with that. Do you mean that you are enabling additional warnings?
> >
> > We already have CI checking (which fails on the first warning) and we
> > already show the warnings for normal builds. Importantly, without
> > -Werror, we show *all* the warnings rather than just stopping at the
> > first one depending on -j, etc.
> >
> > So forcing this option seems to be a tax on people who fix warnings,
> > imposed by those who don't. It really should be the other way around
> > :-)
> >
> > BTW we do have KCFLAGS which can be used to set Werror (and also
> > perhaps other things).
>
> I'll note that I just had to request changes on another patch because
> they didn't realize warnings had to be fixed. It's quite likely that
> making CONFIG_WERROR=y will save more people more time (maybe document
> make -k? I don't know what people don't know about these days, but I do
> "make -kj" a lot when doing the randconfig stuff for example) than what
> we do today.

Yes, could be, particular if people are not using -s with make. I
really dislike warnings quite a lot. I'd be happy enough with
CONFIG_WERROR if we have an env var to disable -Werror like we have
for LTO.

Regards,
Simon
