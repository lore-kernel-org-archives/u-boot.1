Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49158CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CFD848A6;
	Mon,  8 Jun 2026 15:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UC9Jm09O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05A983FEC; Mon,  8 Jun 2026 15:00:42 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74010807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so6883123a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923639; cv=none;
 d=google.com; s=arc-20240605;
 b=fGoCKi2pu9hmpzsFeWe5YzPaJ/GSvzJ+Yh7YBTGcRV1ms2Kem0aGaFJRN0aZznzCJR
 yb7D1uTD3IiqzoYHsryuA0BQ8y05tudLqzpwCl54j6h/iGvBYQ4c4BFc5rhpn8u6td9w
 HreHs6Vl8M8or0XdbPxi6z5A3VQ+QT6lnnFng8fGmeJS92k4mVLW3/V01wdpFiBev4fT
 cDUgqT7PtSMrIjha8pA2aiIIl+4Ck6pE1wsLaj5GrQQb6uOo9Qzg3OtSdYtoLyoNXHKU
 pXKd4ciAasLdPmP09hY4H+METPoBaG/t+8uS6UkHNacX4jv0zeHZLxdr5t2+9qBfc2x+
 UjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5jpSLx2GLmT9V9qPH8zX5ysVIV5Ij6n9OWBkFtYOK2k=;
 fh=C8KNnmDUXYoWv+T7JLFT20ex51m+2GUQp9Rb9xuCvDc=;
 b=FFmJCEwKstOlG2xuwO4gXeBw9qNcwempNnhStrp3HeU0oTJmbEHq0dd7KGNOMNSC+f
 KrS8AyvMdcxH51Hat+3aOar7MfbxdSTvlyCXIlLZjV9U6/yRZ/wVV53spZxg6dV+IHmA
 qMQLLP3uKwnf+aeKca+xILKWW/2wdpUVJKj4MoQHmSH/RYS+NebaEoBMqco5EOa2BEgx
 O/xJFr+aucJTxyk9rvyP5nkG7gYvArv+leJpOL/2tH4o1g0SpUi/vVvfKHWstrvqr35C
 edUW6ap2aOT4BaHtZ6bwtYzb9L559nXsnkkZqF9jwABXmXoAPUKyJAgxmJKEvgFgN+2D
 t98Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780923639; x=1781528439; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5jpSLx2GLmT9V9qPH8zX5ysVIV5Ij6n9OWBkFtYOK2k=;
 b=UC9Jm09OhFlmbCPELwf+xliHLhdGlmo2/gD78qBOMUb84bqocXfLkX2fb2ybQ58ECj
 JXPDe8KL+d5eZWTy1a6j/yP3krvxMwrCN50984f0P1Zep7DAPbE87RYN0aE+4lurlL57
 TANCuZ9mlkoS2Qze6zJyv44xQyrk3g7mAhVYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923639; x=1781528439;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jpSLx2GLmT9V9qPH8zX5ysVIV5Ij6n9OWBkFtYOK2k=;
 b=A+7L+jDoYWQLoOlEtV0kJpKysXhu6pc7SmNW4BHbaJcNupShCv+Xv5+ZGhYe84DdbU
 fdFFKmr2vr4HDUTBRRINjmJf1e9gIH5EAu32bM5CwlFV11KVYs6SgcgUfRmB6GIFbwa/
 7gUV/IlyaZnnMedb2SnqVv/mety5EpTKwTZi4qwItrQGeeIYv719c4LrhYgXySbzaVbh
 iQEeTI839k2z4+8gUasutUYO2a1sUIdnjbbqBQHdMlecfoMVK5aZn9EZzdGHBXshPg12
 uCYHdIIWzkDZjOzWkxXt82nqUAC/E+kChAzfNs7ome9A6cXjqBfKy/VKs88MCVTvo+Rg
 MpdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/U8eRwshGpEyH7uB9zLB4X3BDW5eTaYWXKGjICamMbrob8Kj+4aQFMF0N2kbD0ed0EYfPWRjM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/r4AqWYRfWNjrztTLpd4imIQkd1JfE1tu6ug3ryIKViS8hWEG
 /anQ201EB4Um+tYIUnhd7IjhaJKxAMn3GgpETYGAFi+QKmL1ZrYCiQu3zvMIm/YdqlrH/cusM9o
 C3iXIMZMUUjUplHMHoTxKNLDAUjy/AxrXTHua2P6y
X-Gm-Gg: Acq92OElqu2HnwhhZA5ZNJ1smn8Q2ar3EijhVHJU7ScbhgpGKiJJo2qE9OU8VRrmOV9
 9lEhEaoMOujIgSoUQ+qweJ81N62d4rXmhD+xPlPIeaAR0ZQ7FfHIQsdjD+QNs5OjPhFhppa/oTi
 Hh+wypseLYuFthhNuy2inwIo3PDATR/+ZjiaFv6tEAt5H7zBiAWIpq0oc2DayEQ6ERzFAsMiZw5
 TkU65RSTR/XyHb0Y28rD7VDsVjgLpTtQBZY8/i8Y1bTO+06pytlJEDvGD6WqFkO6llVJncXUyeE
 5mPXNAe9PEIk/pBNQSVi67yY3T0=
X-Received: by 2002:a05:6402:1906:b0:691:5700:7d34 with SMTP id
 4fb4d7f45d1cf-69157008526mr4360122a12.15.1780923638199; Mon, 08 Jun 2026
 06:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
 <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
 <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
 <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
In-Reply-To: <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:00:23 -0600
X-Gm-Features: AVVi8CcuV7NzTOsLHJpVBmIhC1obuiQr1yKJfYjW4pt40IXIXPNdze0dBLYNzv4
Message-ID: <CAFLszTj0HfKTH3GJiSzw7L=7Gq5Qk9VJd5UBUna2_p_iw3eK9Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Alice Guo <alice.guo@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:40 +0200
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

Hi Casey,

On Sun, 7 Jun 2026 at 08:48, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Hi Sam,
>
> On 6/7/26 01:05, Sam Day wrote:
> > Salutations Casey,
> >
> > On Saturday, 6 June 2026 at 10:03 PM, Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> >> Hi Sam,
> >>
> >> On 6/6/26 02:52, Sam Day via B4 Relay wrote:
> >>> U-Boot is seeing increasing adoption on pocket computers, many of which
> >>> (sadly) have fused bootloader chains. Many of these bootloaders have a
> >>> very rigid definition of what a "valid" downstream payload looks like.
> >>> Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
> >>> it's something decidedly more grotesque.
> >>>
> >>> To date, this last-mile packaging step has been trapped in downstream CI
> >>> pipelines, blogposts, documentation, etc. This patch series aims to
> >>> gather up all that esoterica and institutional knowledge and codify it
> >>> in U-Boot's build system, using binman.
> >>
> >> Awesome!!! :D
> >>
> >> So happy to see this being worked on, it's a huge benefit to have this
> >> here in the build system.
> >>
> >> That said, I think we need a bit of discussion around binman, I
> >> previously worked on using it for teaching the build system to emit .mbn
> >> files (see [1]), in the end getting binman to co-operate was a bunch of
> >> really annoying work and I wound up with a sub-par result.
> >
> > Yes, I saw that series. I tried to engage you on Matrix about it a few days ago
> > to get a sense for why you felt that binman was unsalvageable. I should have
> > engaged you properly here on the list, that's my bad.
> >
> >>
> >> The new approach which made a whole lot more sense is to use a vendor
> >> Makefile fragment to add a custom build target, skip dealing with binman
> >> and just have the necessary info in Python (since adding a table entry
> >> to a Python script is really no different to adding a binman DTB node).
> >> That's in [2].
> >
> > I would prefer to use binman. It's already well documented. It's already in
> > use by countless other boards in U-Boot. I prefer maintaining DTSI's for the
> > configuration DSL than some Python dicts. Also, at some point once enough
> > devices have their native Android boot artifact described, there will be
> > clear patterns that can be neatly tucked away into shared DTSI fragments.
>
>  From my side, binman is a no-go for a bunch of reasons, polluting the
> device dtb being a big one, the ability to debug and maintain it is also
> not something i feel particularly confident about. Hence having a
> standalone tool would be the appropriate way to go for this, I really
> want to avoid having to learn this bespoke overly complex build tooling
> when it's selling points aren't things that have much value for Qualcomm.

Binman is the usual U-Boot way to build images. We should not be
inventing new, custom ways of doing things, least of all more scripts.
We should should be describing the image, not coding it.

>
> >
> >>
> >> I'm really not in favour of adding a binman node to the DTB that U-Boot
> >> uses, and I think it's kinda dumb that this is the only sensible way to
> >> configure binman today...
> >
> > I see nothing wrong with that. Can you expand on your concerns a little more?
>
> It really just goes against the goal of using upstream DT. Previously I
> managed to get binman to parse its config from a separate DTB but that
> was hellish to integrate the tooling for.
>
> Having this random node at runtime for completely unnecessary arbitrary
> reasons feels just wrong to me.

On some boards (e.g. x86) it is used at runtime to locate things. In
any case it provides a clear indication of what is where, in data
rather than code. We don't need to make it use a separate DT, so far
as I can tell.

>
> >
> >>
> >> The way that mkmbn works is it just has all the device-specific config
> >> in a dictionary where the key is the compatible string, it finds the DTB
> >> in the U-Boot image and gets the appropriate mbn config from there.
> >>
> >> I see you've clearly put a lot of effort into this, and I hate to ask
> >> you to do a lot more, but I'd really like to avoid using binman, would
> >> you be willing to rework this to put the config in Python and just have
> >> a custom make target like in the mkmbn patches? You can probably base it
> >> on top.
> >
> > I'm definitely not interested in doing that. I would, however, be very willing
> > to address any specific concerns you have with binman.
>
> That's a shame to hear>
> > At any rate, if you want to NAK any binman usage in the qualcomm side, that's
> > fair enough. Please let me know if you see absolutely no path forward, and I'll
> > split the series to just focus on the binman etype impls and their usage on
> > the Exynos side. That would be a bummer, but I'm intending to maintain a
> > long-lived close-to-mainline downstream anyway, so I would continue widening
> > the support there and hope that your opinion on binman changes in future :D
>
> I don't feel comfortable depending on binman for Qualcomm, so we'll
> leave it there.

I'd like to figure this out, particularly as Qualcomm is ramping up
its U-Boot efforts.

Regards,
Simon
