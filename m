Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB4CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AA381E18;
	Mon, 11 May 2026 20:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f4al1A10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD32B838BB; Mon, 11 May 2026 20:10:46 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6779B803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so2513801a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523044; cv=none;
 d=google.com; s=arc-20240605;
 b=Vwu7BuvlNEfM7Pr/Il1da4poRiLebWX27lCGYU6MbEDOEdL+5W6zMXTOHcwDF4UX+h
 EDC6LqOgQ6f4oev+8JFAGWl86F2/87jvIzHEpy80BOo4s4rv1JDTWcEJgpwb/qZt3GyL
 ZjYPk5UZBmrO8xpvF+qsIsGkv6UsY7cWCMWJL1cU3y4rF7OlFCd6pGP6KeF0FyEjwcwg
 t5FAG/DttCv1YWm5xVyK6qYe1az2sjjbZf/i1Ff8MkbSw3YrYjEC4zNeSZWvuYWCWMKC
 6YU125pk8MdAv8o5q3WNKNEKP0Oh3AIEpNwN8HHfrOkcbrBkwPGfaG2rp7I5BNiIYrum
 MKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=60GtXdguh+Zu9traolp6Rf9RJqEnewKaAlwkvPlIIlY=;
 fh=i54dpIxGeZ+F0CeMGMfcubtzGCuskNYR8jut3UjgzxA=;
 b=HODZDxWHIc62jp1rQpyf2RQBpeU3BVnyKCbHACPgtkga9dfol59XooDxp8mHYeoWdr
 FKz8E4z33dhGxY9MF5FDn+1+aR6QAy5UVHOdv7Ig7tiL24rumki0Mo13y+ouDX+4oSrp
 8SiQtNVfLJgFb82/eG2tXefMz4dnc8JRzH2F5B69y3VVoqZjXh29WbczQff5gC0vF9tS
 U8VkFF+tM24NudxvhwsgzMlsJ4OkMIfZ44vtHcHYquu4oKR89r4n3a3DMne6I/guBuAD
 O55SLWF4Buh9GOq7xRwFtv+B/R3knbIpVwGRsbJe3TYsfhEIP0CHs3GDxCHkcujazm1Q
 Pbpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778523044; x=1779127844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60GtXdguh+Zu9traolp6Rf9RJqEnewKaAlwkvPlIIlY=;
 b=f4al1A10NhgzbBkl1To5ecIvEuIN/kdas7LNxNYyjDQkQIg1JL8+ug5lRNlHYAlnUG
 os8qP/oqhmsoSbMKpO9LJpzH8ceVEJql2NgA7ZAIj6duHSdHw6auGN3JDTrfTj/9bwMe
 PyxGRGcQW7Kz+XhjKxoRBkIA4pzx2YFlxvBRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523044; x=1779127844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60GtXdguh+Zu9traolp6Rf9RJqEnewKaAlwkvPlIIlY=;
 b=YLennUUicR3zrpzvzsuxP+scUKT6rHVEJmc32y9U2Av9ndIeWdvkG9MsJtXOX21O0T
 VHxznqUQ8Q2yIYiiH8kfjsRDWVpBH9h6Apl93y5cID5ooWt23C8JXewqKUCYUNpPywja
 LRoedh8wcFhd8kM0Hm1nLor87nnFSu7UEMvXa13sGlzBZkkpy5nNo/rd2nS3CcHOBK/v
 0naBuegDM+fh/TU0kXVTERHFfeuiucfXabpYQeuEuWT4pLod8KQBWDRMMGtbCZ0C/ere
 zrQfCkWayn6xhelNOBcsP4zGE957qRKzacwTRIaO9f373QlFsAf3CDxQESawOWakuBm2
 m/NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91fEvw0iJakJuxapcQXribLOhs5CHKZe61KszQ+Uy0N4EAiavvQVeMRRz3ut/iwi/+1SqyLLM=@lists.denx.de
X-Gm-Message-State: AOJu0YwNNazKc5cmeodrBuEY3PPrmS1ZM81b2gBlcnnh4fZm3Ee1trNX
 lFZ2g9rT/rwqTalMPO0RW4NJpf/K7LVs8PlX1DXIExz2NLgppj+/PSNu3TJ1SieXSgI1mOptxAc
 0GkN8jVv3UBQu4WrsiYQrL8WlwBNSJpKN0A6H18Mp
X-Gm-Gg: Acq92OFEy1a0agMORHMD7L36p7rrrZ7UXqlWkEvtYepWPj2o4aIhx0wXwV/nNNvXsIA
 pXGTDCYx7rQ4tIKQ6bEjNISiJNIb4mWRys1/fDfi4w8kRZ5MnEOKdkMHoZrV6kqtzao7Ldd3iyG
 cU7yoVfZRIyM4Zagemu5YN81EgtqTKp/Pn3oR8mUwysIvYZ+rCwd03uNfioInTWgzWf4TgXbPRx
 Fjz0cREzIUOIZmerrxLL856Zb7SGb2jjRVt9UgRVTyN29+jZMEuT+9dPvMJblcNjHIT8K647kHD
 qDaNOg==
X-Received: by 2002:a17:906:ee84:b0:bb2:71a9:37d7 with SMTP id
 a640c23a62f3a-bc56dd1a539mr1472891866b.39.1778523043643; Mon, 11 May 2026
 11:10:43 -0700 (PDT)
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
 <CAFLszTjESKRGDD3wi4ftxRdXR1X2JZcqybOMHdUYboZ7xjN3Qg@mail.gmail.com>
 <4ac27732-3697-43be-9585-35be67752938@cherry.de>
In-Reply-To: <4ac27732-3697-43be-9585-35be67752938@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:10:31 -0600
X-Gm-Features: AVHnY4JOmvjEY-R91tKIBjSg4p-ZbmidCZdlBBCnUrdU9gFPhZodGiwRF-OVNak
Message-ID: <CAFLszTgiB8qgoqAyFOMvuvjXuY88eYagPvfsrWe0vkeRnKqTqg@mail.gmail.com>
Subject: Re: Couple of clang warnings for Rockchip boards
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Quentin,

On Fri, 8 May 2026 at 03:33, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/4/26 10:40 PM, Simon Glass wrote:
> > On Mon, 4 May 2026 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, May 04, 2026 at 05:14:13AM -0600, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> On 4/29/26 4:25 PM, Tom Rini wrote:
> >>>>> On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> >>>>>> Hi Tom,
> >>>>>>
> >>>>>> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> >>>>>>>> Hi Quentin,
> >>>>>>>>
> >>>>>>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Simon,
> >>>>>>>>>
> >>>>>>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
> >>>>>>>>>> Hi Quentin,
> >>>>>>>>>>
> >>>>>>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Hi all,
> >>>>>>>>>>>
> >>>>>>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> >>>>>>>>>>> First, let me know if this is a bad idea :)
> >>>>>>>>>>
> >>>>>>>>>> I don't like it, as it makes development slower. I like to see all the
> >>>>>>>>>> warnings created by a change and tend to fix them iteratively. We
> >>>>>>>>>> already have a warning check in CI. A better approach is to
> >>>>>>>>>>
> >>>>>>>>>> Can you use: KCFLAGS=-Werror
> >>>>>>>>>>
> >>>>>>>>>> either in your environment or on the 'make' cmdline?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Well, if it's during development, you can always disable WERROR? The
> >>>>>>>>> fact that I've never actually enabled -Werror locally in about a decade
> >>>>>>>>> in U-Boot probably isn't a good sign. One of the things that make me
> >>>>>>>>> wary though is compiler updates with new warnings. I've tested with
> >>>>>>>>> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> >>>>>>>>> about to be released as well.
> >>>>>>>>>
> >>>>>>>>> By having the check in CI, we have a longer-than-necessary feedback loop
> >>>>>>>>> for contributors. Has this been an issue in the past? /me shrugs
> >>>>>>>>
> >>>>>>>> This is strange though, because people should see the warnings during
> >>>>>>>> development. I wonder if it is scrolling off the screen.
> >>>>>>>>
> >>>>>>>> One my bugbears is non-actionable output. When the build succeeds
> >>>>>>>> (with no warnings) I see no output, using 'buildman -I --board xxx -w
> >>>>>>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> >>>>>>>> -s' under the hood, so that it doesn't print a huge list of filenames,
> >>>>>>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> >>>>>>>> check everything is clean ('buildman -m' does something similar).
> >>>>>>>>
> >>>>>>>> Note that buildman returns exit code 101 if there are any warnings, so
> >>>>>>>> the build basically fails.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> No defconfig seems to be setting this option, not sure exactly why that is.
> >>>>>>>>
> >>>>>>>> To me this is a difference between 'functionality' options and
> >>>>>>>> development options. Putting development options in Kconfig makes it
> >>>>>>>> harder to turn them on and off, since you must either edit the
> >>>>>>>> defconfig or edit the .config file. It is easier to just pass an
> >>>>>>>> environment variable.
> >>>>>>>
> >>>>>>> The point of a configuration is that it configures the build. Stuff in
> >>>>>>> environment (directly or make FOO=bar) is a workaround and anti-pattern.
> >>>>>>> Having to run one of the config front-end to change the config is a
> >>>>>>> feature, and good thing.
> >>>>>>
> >>>>>> To give an example, we have boards which enable LTO, but it is
> >>>>>> sometimes useful to disable it during development - it used to be a
> >>>>>> huge time sync but something seems to have changed recently, as I
> >>>>>> don't see much of a performance gap now. We don't want people
> >>>>>> disabling LTO in the defconfig, though. The same applies for things
> >>>>>> like V=1
> >>>>>>
> >>>>>> So I think there are build features which are of no use to end-users,
> >>>>>> but are helpful for development. That is the distinction we have had
> >>>>>> for a while and it would be a shame to lose it.
> >>>>>
> >>>>> Yes, the LTO thing is a good example of something we shouldn't have done
> >>>>> really. Outside of sandbox you cannot just disable it.
> >>>
> >>> Are you sure about that?
> >>
> >> Yes. Outside of sandbox LTO is enabled because the platform binaries
> >> will exceed their non-optional size constraints.
> >
> > That is certainly true for some boards, but I'm not sure it is very many.
> >
> >>
> >>> I seldom build with LTO, except for CI. For
> >>> an incremental build the non-LTO is often twice as fast. Most of the
> >>> time when developing new features I am just trying to make things
> >>> work, so it is big time-saver in the IDE. To some extent this is
> >>> changing, though (LSPs and AI tools). The main impact for me is with
> >>> sandbox incremental builds.
> >>
> >> We could maybe just drop LTO from sandbox, now that it's enabled more
> >> widely on hardware.
> >
> > The nice thing about LTO for sandbox is that it tests a different
> > build path. We could perhaps disable it for just the 'sandbox' board?
> >
> >>
> >>>>>
> >>>>
> >>>> FYI, the Linux kernel defaults to CONFIG_WERROR=y. See commit
> >>>> 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> >>>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).
> >>>
> >>> Do we suffer from this same problem?
> >>>
> >>>>
> >>>> I wouldn't necessarily recommend to switch it on right now, but I think
> >>>> it could be a good idea in the mid-term. We're also very far behind in
> >>>> terms of warn flags compared to the kernel. Syncing will take some time
> >>>> though. For now I'm looking into enabling -Werror for host tools and
> >>>> this resulted in (so far) 21 patches.
> >>>
> >>> I must be misunderstanding what you are referring to here. I don't see
> >>> any warnings when building tools-only - certainly I would not put up
> >>> with that. Do you mean that you are enabling additional warnings?
> >>>
> >>> We already have CI checking (which fails on the first warning) and we
> >>> already show the warnings for normal builds. Importantly, without
> >>> -Werror, we show *all* the warnings rather than just stopping at the
> >>> first one depending on -j, etc.
> >>>
> >>> So forcing this option seems to be a tax on people who fix warnings,
> >>> imposed by those who don't. It really should be the other way around
> >>> :-)
> >>>
> >>> BTW we do have KCFLAGS which can be used to set Werror (and also
> >>> perhaps other things).
> >>
> >> I'll note that I just had to request changes on another patch because
> >> they didn't realize warnings had to be fixed. It's quite likely that
> >> making CONFIG_WERROR=y will save more people more time (maybe document
> >> make -k? I don't know what people don't know about these days, but I do
> >> "make -kj" a lot when doing the randconfig stuff for example) than what
> >> we do today.
> >
> > Yes, could be, particular if people are not using -s with make. I
> > really dislike warnings quite a lot. I'd be happy enough with
> > CONFIG_WERROR if we have an env var to disable -Werror like we have
> > for LTO.
> >
>
> I'll let Tom speak his mind whether that's a good idea.
>
> I really don't want to be touching scripts/Makefile.extrawarn once
> sync'ed with the one in Linux kernel's, so adding some logic in there is
> a no-no in my book. So it means we can only change the CONFIG_WERROR
> symbol. But we kinda don't want to rename it as it'll likely be used
> throughout the source code (hopefully spreading more and more over time)
> since we also want to sync as much as possible kbuild/makefiles from the
> Linux kernel. So what I thought could be a way to make this more
> palatable to you would be to introduce an invisible symbol which depends
> on an env variable.
>
> Something like
>
> config DISABLE_WERROR_FROM_ENV
>    def_bool $(success, test "$(DISABLE_WERROR)" != "1" )
>    help
>      Allow to override CONFIG_WERROR from .config via the DISABLE_WERROR
> environment variable.
>
> config WERROR
>    depends on !DISABLE_WERROR_FROM_ENV
>
> for example (untested).

That's clever!

But Tom is very opposed to being able to disable -Werror from the
environment for boards which enable it. Let's leave it alone.

Regards,
Simon
