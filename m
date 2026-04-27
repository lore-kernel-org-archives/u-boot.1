Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D361FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8583E83693;
	Mon, 27 Apr 2026 13:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ecLwv/hn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1AF780433; Mon, 27 Apr 2026 13:54:25 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F6480433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so1648019266b.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 04:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777290863; cv=none;
 d=google.com; s=arc-20240605;
 b=UH+ZdlNY3SBpX4wA3ZsjMkxWra+Ddfl8nWqemYcy8vaLo/EoFBHxO9uEQ2L7PwQzee
 zcZLTF3+YcTxfztaYZwgN5w83+dYJq5pGVeynMLOP4LQdBiuYnUCRzwovuBE6yfMKN86
 d+oepCdBTcNPGJiYy+nKhop92C1KA73Wi6G03E5CsA00Uu9ZcL+CAlRg0jQyV8KTWkVR
 EredvSIRVz9LxUlLK29fxCM1ibRK3ZWMCyIFFX80q0ALZK2g/y+jBugp27OmNJOomZCD
 JZQ4bNW+Zko6cye6s8Vljv0sCOECW8tJM7rlO1nyFJIh8YE8E33THqjQNDZeufVLNa/k
 Exhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Wpw9O2wJ5n3o8zSORG/tAAsUqcKpiKOPT+3GYjffMIo=;
 fh=gXGkhr1MrhK2wEDleHYXVHAigNGe1Sk0dnbdYi9qgxA=;
 b=NCcHIqxxz7zWAHgxcftQrnP7NNxOQUOwnVeByzNxiLGRDFkU+f4QLzKSo/dN+MWtZA
 8tvWDXPo2iaOlBTqT4wwZtxi+HS/mmPLzj/JGUhbcULKRlBjWLdS2J74qA3Vel1Wg3/a
 Gax3xkk7/Ha/APkpFAsDM9urUMWvt2jIY7yLStTl6aa/RatSfV3qA+2I2J1F6KIUJYXt
 C1JEXXcWhwIXbIvlb0xwKDg+1J2vQDq9n0bmQyHFS267psQf+y9lWQdy6MxxrmA5qYny
 rgHpHasZGb1Uq15d3YoGYsblWDxdlNpXCybEIwhch4K+UHWwhiCmEANnxatwljVPmYEC
 +ccQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777290863; x=1777895663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wpw9O2wJ5n3o8zSORG/tAAsUqcKpiKOPT+3GYjffMIo=;
 b=ecLwv/hngyTU0AwMs2lyKkSDe7vKa+75arN6G46OW2wWa+3rRDaW/OX7eQEKunTseb
 RaaX8gvSwe8RcAiUBBP9fuZuKJNUfLk3JKF1BLZH+1gKsrDcsONj4QSc6H5xy461Rxpc
 LCziiWljDYECxI4QTXtqRzDgqJ9ninUWVanVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777290863; x=1777895663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wpw9O2wJ5n3o8zSORG/tAAsUqcKpiKOPT+3GYjffMIo=;
 b=hM3gUjAsv3HJ4kxrBadrmb+Chr7XzYzWCzM02w792sglav90Dww489jTecWvkfzquB
 TGMsh0tRIdOfoE9VLJgcs8+Hr6FKY6XmEQkdItE/fyNARPqf9DqlMXWPzrMZBASpZI+L
 X4sZx4qkmjftvSHo7YDJ426xre0Y29ZlE0DMq/xJCiVf4OOY80v9GCrr6O6mRvXNxGvK
 mT/ARD1j/Gdz1V+xtu6GNuYTqcq0eMlWagcwHIKaLjF9iXSO6Iq5DHlowdYpzti3P3OU
 BEghP1oQmwjJh5D6pIQscMkb11VT9usWbnCYlaxok1+3Jxx3+5670epHD3jVWeplGO39
 kdPg==
X-Gm-Message-State: AOJu0YzUElUYQVydXiTjxHYn2sUjLdDPp12KG8LtXkThfYchMQXi9SXt
 eixp0iCKkTcTx30PuJkhFzcP9dJsT/aLs3PDjP5mquZyPJeMLZTmaQr0YlQKO7UVeLlelp5NXny
 pTky1mDUi6Q7AHWaQBkhJwDAzA2ktrUnEon2T5ZjCgj0X7DA0uDFRWA==
X-Gm-Gg: AeBDievKg5abRGkfhWzVxZSV3vUwD2QrjuqX9PY17FqirV8y7pnxBT0zqH1F3rlrk3Y
 KPKh08dnWOM9CigIcfGuQtNZF4a+y+rSW7di8D53zpbMXXJFHIH3TpDl7dVDapZOYgEdx5Grc6b
 nD+CfwEF1nVnNjpoUo5hZnMOeuFMJRYjWIBapnyz5KcycLbn3U2AKjFw3tscVEyxcPLXTs+ccy0
 03i4I69d/WIM67NHZZwJMIC+A5CvZCHOpJLAquUwOEY6k83B6WQ2mPFxhzV6rl+2OXDg/3JdHS/
 SR5vPLnDyNTglRzRvmXjYcqOpJ+blg==
X-Received: by 2002:a17:907:d641:b0:b9b:e619:a73a with SMTP id
 a640c23a62f3a-ba41b3e2885mr2020222966b.46.1777290862639; Mon, 27 Apr 2026
 04:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
In-Reply-To: <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 27 Apr 2026 23:54:09 +1200
X-Gm-Features: AVHnY4JFRbeEHih58bP6Yife7PREjivXrJfuryZf5l0XiA3h5PTjAxiNDJQvchQ
Message-ID: <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
Subject: Re: Couple of clang warnings for Rockchip boards
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
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

On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/22/26 11:57 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi all,
> >>
> >> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
> >> First, let me know if this is a bad idea :)
> >
> > I don't like it, as it makes development slower. I like to see all the
> > warnings created by a change and tend to fix them iteratively. We
> > already have a warning check in CI. A better approach is to
> >
> > Can you use: KCFLAGS=-Werror
> >
> > either in your environment or on the 'make' cmdline?
> >
>
> Well, if it's during development, you can always disable WERROR? The
> fact that I've never actually enabled -Werror locally in about a decade
> in U-Boot probably isn't a good sign. One of the things that make me
> wary though is compiler updates with new warnings. I've tested with
> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
> about to be released as well.
>
> By having the check in CI, we have a longer-than-necessary feedback loop
> for contributors. Has this been an issue in the past? /me shrugs

This is strange though, because people should see the warnings during
development. I wonder if it is scrolling off the screen.

One my bugbears is non-actionable output. When the build succeeds
(with no warnings) I see no output, using 'buildman -I --board xxx -w
-o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
-s' under the hood, so that it doesn't print a huge list of filenames,
etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
check everything is clean ('buildman -m' does something similar).

Note that buildman returns exit code 101 if there are any warnings, so
the build basically fails.

>
> No defconfig seems to be setting this option, not sure exactly why that is.

To me this is a difference between 'functionality' options and
development options. Putting development options in Kconfig makes it
harder to turn them on and off, since you must either edit the
defconfig or edit the .config file. It is easier to just pass an
environment variable.

>
> Also, FYI, enabling CONFIG_WERROR doesn't apply the -Werror flag to the
> host tools, which I believe is an oversight. I see buildman sets
> HOSTCFLAGS=-Werror, maybe we should do that in the appropriate place
> based on CONFIG_WERROR as well?

Yes, that seems to be an oversight.

>
> >>
> >> gcc version 15.2.1 20250808 (Red Hat Cross 15.2.1-1) (GCC) for both ARM
> >> and Aarch64 machines report no warnings (built with a config fragment
> >> enabling CONFIG_WERROR).
> >>
> >> For clang, I went for cross-compiling using either
> >> make HOSTCC=clang CROSS_COMPILE=arm-linux-gnu- CC=clang O=build/ ...
> >> or
> >> make HOSTCC=clang CROSS_COMPILE=aarch64-linux-gnu- CC=clang O=build/ ...
> >>
> >> First things first, I can't even build any of the Aarch32/ARM with clang
> >> for some reason, so this only applies for Aarch64 Rockchip platforms.
> >>
> >> Some platforms couldn't be built due to hitting the max TPL limit (e.g.
> >> PX30).
> >
> > It's interesting that clang code is larger than gcc. There was a time
> > that I thought clang would replace gcc. But clang is much slower and
> > if it doesn't provide code-size benefits, I'm not sure that will
> > happen. We all use it as an lsp though, at least.
> >
>
>  From what I've gathered, clang can cross-compile to many different
> archs with a single binary, GCC goes for separate toolchains, which
> kinda is a pain to be honest.

Yes it seems so. I've never actually tried it though, have you? For my
workflow, buildman handles the toolchains.

>
> Also, it's nice for build systems like Buildroot or Yocto to only need a
> single toolchain (either clang or GCC, but not both) for everything. So
> in an ideal world if you want to use clang for everything, you could.
> Last time I checked, you cannot build TF-A on RK3399 with clang only.
> I'm also not entirely sure how far we are from building the kernel with
> clang, or maybe it's already fully supported.

I don't know either. I wonder how it handles linker scripts?

>
> >>
> >> clang version 21.1.8 (Fedora 21.1.8-4.fc43) (or clang version 22.1.1
> >> (Fedora 22.1.1-2.fc44), doesn't matter) issues three warnings:
> >>
> >> 1. Chromebooks EC fails to build:
> >> In file included from
> >> /home/qschulz/work/upstream/u-boot/drivers/misc/cros_ec.c:21:
> >> In file included from
> >> /home/qschulz/work/upstream/u-boot/include/cros_ec.h:12:
> >> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2: error:
> >> field  within 'struct ec_params_charge_state' is less aligned than
> >> 'union ec_params_charge_state::(anonymous at
> >> /home/qschulz/work/upstream/u-boot/include/ec_commands.h:3578:2)' and is
> >> usually due to 'struct ec_params_charge_state' being packed, which can
> >> lead to unaligned accesses [-Werror,-Wunaligned-access]
> >>    3578 |         union {
> >>         |         ^
> >>
> >> The following
> >>
> >> diff --git a/include/ec_commands.h b/include/ec_commands.h
> >> index 23597d28b2c..c5f9777c0c7 100644
> >> --- a/include/ec_commands.h
> >> +++ b/include/ec_commands.h
> >> @@ -3575,7 +3575,7 @@ enum charge_state_params {
> >>
> >>    struct __ec_todo_packed ec_params_charge_state {
> >>          uint8_t cmd;                            /* enum charge_state_command */
> >> -       union {
> >> +       union __ec_todo_packed {
> >>                  struct __ec_align1 {
> >>                          /* no args */
> >>                  } get_state;
> >>
> >> seems to fix it. The upstream EC git repo
> >> (https://chromium.googlesource.com/chromiumos/platform/ec) has a commit
> >> with more changes, see 65da9cc08766 ("include/ec_commands.h: Fix
> >> unaligned access warnings"). It doesn't apply cleanly (and I haven't
> >> looked into other patches to backport for this to apply cleanly). I'm
> >> not sure what we're supposed to do here? I also don't have a Chromebook
> >> to test.
> >
> > It should be possible to backport this, to avoid divergence. I could
> > look at that if you like.
> >
>
> That'd be nice :) Maybe the solution would be a sync with upstream
> instead of backporting select patches? I have no experience with CrOS EC
> so no clue what we're supposed to do here, especially since if I
> understood correctly, they switched to Zephyr somewhat recently, so
> maybe the API changed and isn't backward compatible (I don't think the
> Rockchip Chromebooks were migrated to that).

Yes, I led that effort in the distant past - we changed from a
home-grown OS to Zephyr. But it still uses the same protocol.

https://chromium.googlesource.com/chromiumos/platform/ec/+/HEAD/docs/zephyr/README.md

>
> > For now you could use a #pragma just around the header include, or in cros_ec.c
> >
>
> I'd rather not silence warnings if we're planning on fixing them soon-ish :)

Indeed, I'll take a look at updating the file.

>
> > I don't think you need to worry about the struct going wrong, so long
> > as the size remains the same. There are two Chromebooks in the SJG lab
> > you can try it with: bob and kevin
> >
>
> Well, if we pack it, it may change the size, that's the whole point of
> packing no? Or you meant checking that the current size of the struct is
> the same after packing it to make clang happy?
>
> But also, are we doing anything with this? Like some CrOS EC checks in
> labgrid for example? I cannot see any test for the crosec command in
> test/py/tests/ for example. No test specific to a chromebook either (git
> grep chromebook test/py/tests).

It is used for the sandbox keyboard, for example.

>
> >>
> >> 2. RK3528, RK3576 and RK3588 boards fail with (replace rk3528 in path
> >> for the other SoCs)
> [...]
> >> I tried casting CONFIG_COUNTER_FREQUENCY into a u64 and it builds and no
> >> magic smoke when booting a board. Whether this is the proper fix, I
> >> don't know, but the warning is then gone. We could also decide to ignore
> >> the warning like for Android's Little Kernel (where and how much this is
> >> used is unclear as the repo isn't seeing much activity).
> >>
> >> The register documentation indicates this is not used by the hardware at
> >> all, so even if it was broken, we probably wouldn't see a difference?
> >
> > Similar to what Tom says...does this work?:
> >
> > asm volatile("msr cntfrq_el0, %0" : : "r"
> >    ((u64)CONFIG_COUNTER_FREQUENCY));
> >
>
> Yes this was among the things I tried (see paragraph with the magic
> smoke not happening). I should probably start practicing condensing my
> mails :)

Ah OK, missed that sorry.

>
> >>
> >> 3. Boards building USB TCPM fail with
> >>
> >> In file included from
> >> /home/qschulz/work/upstream/u-boot/drivers/usb/tcpm/tcpm-uclass.c:12:
> >> In file included from
> >> /home/qschulz/work/upstream/u-boot/include/usb/tcpm.h:12:
> >> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2: error: field
> >> within 'struct pd_message' is less aligned than 'union
> >> pd_message::(anonymous at
> >> /home/qschulz/work/upstream/u-boot/include/usb/pd.h:212:2)' and is
> >> usually due to 'struct pd_message' being packed, which can lead to
> >> unaligned accesses [-Werror,-Wunaligned-access]
> >>     212 |         union {
> >>         |         ^
> >>
> >> This file is apparently adapted from upstream Linux, where the code is
> >> identical for that struct. So not sure what to do here.
> >
> > Maybe add __packed ?
> >
>
> We could, but if upstream (Linux) didn't fix it, maybe there's a reason
> and we should discuss it there first?
>
> So, looking a bit more into this, the kernel actually silences a bunch
> of warnings when not passing W=N to `make`, one of them being
> unaligned-access, see
> https://elixir.bootlin.com/linux/v7.0/source/scripts/Makefile.warn#L155.
> So maybe we need to sync some of those back to U-Boot as well?
>
> Our scripts/Makefile.extrawarn is claimed[1] to be loosely based on
> Linux 6.1's, but it is actually quite different. So not sure how much we
> should be backporting and how.

In most cases it would be better to line up with the Linux version as
much as possible. But for unaligned-access, I suspect we have good
reason to warn about that since it can cause some boards to fail to
boot.

Regards,
Simon



> [1] bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
