Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223C2CD342C
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 11:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E108394E;
	Mon,  4 May 2026 13:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MRLJK96L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF5B8394E; Mon,  4 May 2026 13:14:29 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E1380F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 13:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso611840866b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 04:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893265; cv=none;
 d=google.com; s=arc-20240605;
 b=hbF2E7SRwccDd3r1/KYsAmjw0ozSIDMJBvLdmLK1kBViQTQMSWlRH/tQ+xzsU8rPoz
 9cfcuhGFglZWr5g3C8b6VDZ9zkJrZivQpQN82A6C/fPWYao6QR+a4XsvQiz+ZxY87wqt
 YAYuCUAB3sW2KPox/Bp5RqckoLQ+jpW13OvTXkZ77igCUW8akSqE06XLxN5nxfUF7AOV
 WPwFTuaslQpvwEa0wIjNRoFODKFlvwdOXaLTziPG3Im8k7KLKrlRgHOfFZZCd/w0lQuY
 3/0TfYzRR0FZn1V7JcZVIMKlvAbS0RJS+xNRkQCFAdpD8ufE9fLLKUBMC2elXhSgmhSf
 m9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dU8oHawJ8ujj17E2PFUcF4bZOECvOrR9Gn4DJNGcqAA=;
 fh=kQgZ7drqGakxxYqmVZnHHVfWvH/1Kn+b3g1fJhlnZkU=;
 b=RmvbuPKWXgSDV67VfLwvSg1KkJ8pzWCyQYZ642s572sk2BXnPAhvs/2o4O06zxrPRK
 wnFMTmkdNoI3K0fHCHa7SMde7eFWBRKZrK6dWwhfn0WD0OWpuwzZZVUpTfEmzmL9lm5Q
 8yJgEhS5tiGQU2bvqq2xIXqJa1wY1Ry2aWzbf/Cmr/c4a1sTWMGgNlFrFNXqkbKe/w2Y
 biE9T8XadzWAJTMFJ3+BWZP8AVpg07Ak4V1yMG8c6brXMz7WAUcyJ0FmF0sRr9SFKsQK
 FUzkTsMlaJPTxQGr//Wje+RXT6TejXdx8CXbnyZ0JLHQfvUYC6MZCEsqNxneS1O4nPlD
 YMqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777893265; x=1778498065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dU8oHawJ8ujj17E2PFUcF4bZOECvOrR9Gn4DJNGcqAA=;
 b=MRLJK96LppisrSZ3XBHBaVCBU7PNG7YvvJPII8wqlT/HkKWrX6XL/WCeGjPpjD+AXn
 6LLDefQb+qdN51rExrQvQLRxASjf21U2UGKdvpTgDospB4Guiw0dwJZrK0409S6bh6Q0
 CaFyRZ+lLx+1dBd0n3EnwxGToz/WNOGZIGlh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777893265; x=1778498065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU8oHawJ8ujj17E2PFUcF4bZOECvOrR9Gn4DJNGcqAA=;
 b=Ay0C3j/Xqn5tzkKGaD/po1TO1l102eUassRo1wlBMQ+WMOwn6d9H3b+prrTMgkJZ92
 ZCE2EWl8kgzxfEKBsg/c/PESAUFaVY89H3IjUKzAHFAljA2pQRHyX9EERDD4mVp2ABQG
 4DRSbUVVwoP8mIMA8rwQt8lv3sPC3PIOR4tk0PWcQGiTZlUheodZ/t5lO8komfStIP1w
 Y+nqQ70JHrImVPvkevqeAIMACE6gAqVRW2BYyejKwI97qzOKv515za17n8is2pN1p9Qc
 c6+Ux9M3FnZ8JBTJTcEB4ue8BiBQn75u9jrLtfJ0rSwQyiEkx1X+JcNjvmrsx6tq7pX3
 h0EA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87+tk7T+3I612aqW8gTC78PynJalMyQSt6R5TzPOPtgMfqZe/gO5S2wYal9E1wY6LOg5o1XyE=@lists.denx.de
X-Gm-Message-State: AOJu0YyqS5r/HnhdMixansUs32TZAnZUeGlQSq0tNAu8qGNr6D+P/zcV
 T4ClxSPWDqxq/RHfiv0m4DLIgZcotL+YcP9nczN8/PV9+4uE0UQEXQ3b8M+afupx4Fy5rKmw9uL
 fCFyFDvRP3vBcQOvcJjr9mUSCR355vjy+TFaRWMAw
X-Gm-Gg: AeBDieuNwWM59/CdVbxM/iFvhAzVas+o+8KfMDSmdZPu6t1h6zPhTp/li/7W5Ae4U18
 tx+uYPGsjMVwWBT2I61w9n3ix0zOwUTppkXYY2vnl/AwyLnTBpXQd57oZR+ordggiuydqL1njb+
 +2WVXK6RSnjtINgK0o3hUou7ymdhvDOa8bQp4Sleg6GFcwYPns8U+RclkjPD5A8pDOf2T1yJ9kc
 sx+RNErtXemPh/IyDg7kTAHAdnlEdpYCW8244VXWLIRQnD6QJ64nhV02tfeXgoKkdYgoK6QRdSz
 nH9EECp2FHzM77agiV/LravKEsE=
X-Received: by 2002:a17:907:70a:b0:b9d:94e4:d35e with SMTP id
 a640c23a62f3a-bbffcb7b5a4mr509045866b.29.1777893265508; Mon, 04 May 2026
 04:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
 <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
In-Reply-To: <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 05:14:13 -0600
X-Gm-Features: AVHnY4JHvP7dYZqnE3hu75-mfJuS3PCha6i3Js4rUd9sLTQkatlNitSH2UzcG2U
Message-ID: <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
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

On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> On 4/29/26 4:25 PM, Tom Rini wrote:
> > On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> >> Hi Tom,
> >>
> >> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> >>>> Hi Quentin,
> >>>>
> >>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
> >>>>>> Hi Quentin,
> >>>>>>
> >>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> >>>>>>> First, let me know if this is a bad idea :)
> >>>>>>
> >>>>>> I don't like it, as it makes development slower. I like to see all the
> >>>>>> warnings created by a change and tend to fix them iteratively. We
> >>>>>> already have a warning check in CI. A better approach is to
> >>>>>>
> >>>>>> Can you use: KCFLAGS=-Werror
> >>>>>>
> >>>>>> either in your environment or on the 'make' cmdline?
> >>>>>>
> >>>>>
> >>>>> Well, if it's during development, you can always disable WERROR? The
> >>>>> fact that I've never actually enabled -Werror locally in about a decade
> >>>>> in U-Boot probably isn't a good sign. One of the things that make me
> >>>>> wary though is compiler updates with new warnings. I've tested with
> >>>>> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> >>>>> about to be released as well.
> >>>>>
> >>>>> By having the check in CI, we have a longer-than-necessary feedback loop
> >>>>> for contributors. Has this been an issue in the past? /me shrugs
> >>>>
> >>>> This is strange though, because people should see the warnings during
> >>>> development. I wonder if it is scrolling off the screen.
> >>>>
> >>>> One my bugbears is non-actionable output. When the build succeeds
> >>>> (with no warnings) I see no output, using 'buildman -I --board xxx -w
> >>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
> >>>> -s' under the hood, so that it doesn't print a huge list of filenames,
> >>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
> >>>> check everything is clean ('buildman -m' does something similar).
> >>>>
> >>>> Note that buildman returns exit code 101 if there are any warnings, so
> >>>> the build basically fails.
> >>>>
> >>>>>
> >>>>> No defconfig seems to be setting this option, not sure exactly why that is.
> >>>>
> >>>> To me this is a difference between 'functionality' options and
> >>>> development options. Putting development options in Kconfig makes it
> >>>> harder to turn them on and off, since you must either edit the
> >>>> defconfig or edit the .config file. It is easier to just pass an
> >>>> environment variable.
> >>>
> >>> The point of a configuration is that it configures the build. Stuff in
> >>> environment (directly or make FOO=bar) is a workaround and anti-pattern.
> >>> Having to run one of the config front-end to change the config is a
> >>> feature, and good thing.
> >>
> >> To give an example, we have boards which enable LTO, but it is
> >> sometimes useful to disable it during development - it used to be a
> >> huge time sync but something seems to have changed recently, as I
> >> don't see much of a performance gap now. We don't want people
> >> disabling LTO in the defconfig, though. The same applies for things
> >> like V=1
> >>
> >> So I think there are build features which are of no use to end-users,
> >> but are helpful for development. That is the distinction we have had
> >> for a while and it would be a shame to lose it.
> >
> > Yes, the LTO thing is a good example of something we shouldn't have done
> > really. Outside of sandbox you cannot just disable it.

Are you sure about that? I seldom build with LTO, except for CI. For
an incremental build the non-LTO is often twice as fast. Most of the
time when developing new features I am just trying to make things
work, so it is big time-saver in the IDE. To some extent this is
changing, though (LSPs and AI tools). The main impact for me is with
sandbox incremental builds.

> >
>
> FYI, the Linux kernel defaults to CONFIG_WERROR=y. See commit
> 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).

Do we suffer from this same problem?

>
> I wouldn't necessarily recommend to switch it on right now, but I think
> it could be a good idea in the mid-term. We're also very far behind in
> terms of warn flags compared to the kernel. Syncing will take some time
> though. For now I'm looking into enabling -Werror for host tools and
> this resulted in (so far) 21 patches.

I must be misunderstanding what you are referring to here. I don't see
any warnings when building tools-only - certainly I would not put up
with that. Do you mean that you are enabling additional warnings?

We already have CI checking (which fails on the first warning) and we
already show the warnings for normal builds. Importantly, without
-Werror, we show *all* the warnings rather than just stopping at the
first one depending on -j, etc.

So forcing this option seems to be a tax on people who fix warnings,
imposed by those who don't. It really should be the other way around
:-)

BTW we do have KCFLAGS which can be used to set Werror (and also
perhaps other things).

Regards,
Simon
