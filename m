Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5F3EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A40987266;
	Mon, 21 Aug 2023 21:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSech7+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0358726A; Mon, 21 Aug 2023 21:57:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E1387266
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so2836104a12.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692647845; x=1693252645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H/vJS+JEKmgGI+jMV6ENSsownZmUUeh84qrWQbvjAp4=;
 b=oSech7+VBxOSgnnNk8jVAZOaHVxn6snvCjr7+tjhlu1Cwbltesld3O9+X01rRFZb+6
 ownfmpQ9zRRdycWhluWwwlVmuVLdvig22dnNgHHoW2CjPBhs2hnvTgANMIvniK3snAus
 WCg24D1tPKj4ChE/xOcztQ0Ir3mF6yMTKYqSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692647845; x=1693252645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H/vJS+JEKmgGI+jMV6ENSsownZmUUeh84qrWQbvjAp4=;
 b=d4wNlhE23DkqiYDpJN7rJ7drkKdSD8SpSEWq/NDDEz9JfsmZY/ysWxLKIUkjP42REs
 wn/ymYB0Rh3aAxVu6S5NG/ljcwmpmiaAzb9X4FxVQi45v0Q5pHwouu8uApzeor5dQcWF
 imU4ObV52fHjuR4EfwDSvIZ7gWxisCRHTrdV1WOQkI28f9TmmILRtIHBfTgg2wtdXkPS
 y2qKACzDo9suvCriQigoZicAHvnLhAVMDXUXJ+xoegAaIzTfFqN+oCHK4WLSglWSFxIE
 BIt4PSeOGX4LdwnN0wAitVt4BOynsimGykeD6GHZZ/TdRf6F5GNxL+03IDR6wGleCXut
 UNOw==
X-Gm-Message-State: AOJu0Yxm/Vi+YXEKUwB0inijNplR88xcqLTogTFbEBPOdO3/EYs4XjdB
 IKZv7MIu/eueJRmLWe+2QDowl/ff1wltt/T2FKjzLg==
X-Google-Smtp-Source: AGHT+IEkeGlVFm70rBXI5lRTxhL1+Mv2dYdL21pwaosragzCN8r4P5X3JUriYNyXM7VlCy+E9LvM5g6KQtcI3I+TdCk=
X-Received: by 2002:aa7:d3d2:0:b0:525:528d:836f with SMTP id
 o18-20020aa7d3d2000000b00525528d836fmr5370608edr.18.1692647845088; Mon, 21
 Aug 2023 12:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <CAPnjgZ0FrwViFv8xLFSkTtztZQw=hnNprCcHfp39s_jfMHRCgA@mail.gmail.com>
 <eda9f0f0-fc4d-42b6-abbd-749f67ef6b10@csgraf.de>
In-Reply-To: <eda9f0f0-fc4d-42b6-abbd-749f67ef6b10@csgraf.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:57:12 -0600
Message-ID: <CAPnjgZ376PEfX75eGL6QvmehZ9Kp+5_orhcsKOpr=8rpRKutFA@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Add video damage tracking
To: Alexander Graf <agraf@csgraf.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de, 
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com, 
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

Hi Alex,

On Mon, 21 Aug 2023 at 13:33, Alexander Graf <agraf@csgraf.de> wrote:
>
>
> On 21.08.23 21:11, Simon Glass wrote:
> > Hi Alper,
> >
> > On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >> This is a rebase of Alexander Graf's video damage tracking series, with
> >> some tests and other changes. The original cover letter is as follows:
> >>
> >>> This patch set speeds up graphics output on ARM by a factor of 60x.
> >>>
> >>> On most ARM SBCs, we keep the frame buffer in DRAM and map it as cached,
> >>> but need it accessible by the display controller which reads directly
> >>> from a later point of consistency. Hence, we flush the frame buffer to
> >>> DRAM on every change. The full frame buffer.
> > It should not, see below.
> >
> >>> Unfortunately, with the advent of 4k displays, we are seeing frame buffers
> >>> that can take a while to flush out. This was reported by Da Xue with grub,
> >>> which happily print 1000s of spaces on the screen to draw a menu. Every
> >>> printed space triggers a cache flush.
> > That is a bug somewhere in EFI.
>
>
> Unfortunately not :). You may call it a bug in grub: It literally prints
> over space characters for every character in its menu that it wants
> cleared. On every text screen draw.
>
> This wouldn't be a big issue if we only flush the reactangle that gets
> modified. But without this patch set, we're flushing the full DRAM
> buffer on every u-boot text console character write, which means for
> every character (as that's the only API UEFI has).
>
> As a nice side effect, we speed up the normal U-Boot text console as
> well with this patch set, because even "normal" text prints that write
> for example a single line of text on the screen today flush the full
> frame buffer to DRAM.

No, I mean that it is a bug that U-Boot (apparently) flushes the cache
after every character. It doesn't do that for normal character output
and I don't think it makes sense to do it for EFI either.

>
>
> >
> >>> This patch set implements the easiest mitigation against this problem:
> >>> Damage tracking. We remember the lowest common denominator region that was
> >>> touched since the last video_sync() call and only flush that. The most
> >>> typical writer to the frame buffer is the video console, which always
> >>> writes rectangles of characters on the screen and syncs afterwards.
> >>>
> >>> With this patch set applied, we reduce drawing a large grub menu (with
> >>> serial console attached for size information) on an RK3399-ROC system
> >>> at 1440p from 55 seconds to less than 1 second.
> >>>
> >>> Version 2 also implements VIDEO_COPY using this mechanism, reducing its
> >>> overhead compared to before as well. So even x86 systems should be faster
> >>> with this now :).
> >>>
> >>>
> >>> Alternatives considered:
> >>>
> >>>    1) Lazy sync - Sandbox does this. It only calls video_sync(true) ever
> >>>       so often. We are missing timers to do this generically.
> >>>
> >>>    2) Double buffering - We could try to identify whether anything changed
> >>>       at all and only draw to the FB if it did. That would require
> >>>       maintaining a second buffer that we need to scan.
> >>>
> >>>    3) Text buffer - Maintain a buffer of all text printed on the screen with
> >>>       respective location. Don't write if the old and new character are
> >>>       identical. This would limit applicability to text only and is an
> >>>       optimization on top of this patch set.
> >>>
> >>>    4) Hash screen lines - Create a hash (sha256?) over every line when it
> >>>       changes. Only flush when it does. I'm not sure if this would waste
> >>>       more time, memory and cache than the current approach. It would make
> >>>       full screen updates much more expensive.
> > 5) Fix the bug mentioned above?
> >
> >> Changes in v5:
> >> - Add patch "video: test: Split copy frame buffer check into a function"
> >> - Add patch "video: test: Support checking copy frame buffer contents"
> >> - Add patch "video: test: Test partial updates of hardware frame buffer"
> >> - Use xstart, ystart, xend, yend as names for damage region
> >> - Document damage struct and fields in struct video_priv comment
> >> - Return void from video_damage()
> >> - Fix undeclared priv error in video_sync()
> >> - Drop unused headers from video-uclass.c
> >> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
> >> - Call video_damage() also in video_fill_part()
> >> - Use met->baseline instead of priv->baseline
> >> - Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
> >> - Update console_rotate.c video_damage() calls to pass video tests
> >> - Remove mention about not having minimal damage for console_rotate.c
> >> - Add patch "video: test: Test video damage tracking via vidconsole"
> >> - Document new vdev field in struct efi_gop_obj comment
> >> - Remove video_sync_copy() also from video_fill(), video_fill_part()
> >> - Fix memmove() calls by removing the extra dev argument
> >> - Call video_sync() before checking copy_fb in video tests
> >> - Imply VIDEO_DAMAGE for video drivers instead of selecting it
> >> - Imply VIDEO_DAMAGE also for VIDEO_TIDSS
> >>
> >> v4: https://lore.kernel.org/all/20230103215004.22646-1-agraf@csgraf.de/
> >>
> >> Changes in v4:
> >> - Move damage clear to patch "dm: video: Add damage tracking API"
> >> - Simplify first damage logic
> >> - Remove VIDEO_DAMAGE default for ARM
> >> - Skip damage on EfiBltVideoToBltBuffer
> >> - Add patch "video: Always compile cache flushing code"
> >> - Add patch "video: Enable VIDEO_DAMAGE for drivers that need it"
> >>
> >> v3: https://lore.kernel.org/all/20221230195828.88134-1-agraf@csgraf.de/
> >>
> >> Changes in v3:
> >> - Adapt to always assume DM is used
> >> - Adapt to always assume DM is used
> >> - Make VIDEO_COPY always select VIDEO_DAMAGE
> >>
> >> v2: https://lore.kernel.org/all/20220609225921.62462-1-agraf@csgraf.de/
> >>
> >> Changes in v2:
> >> - Remove ifdefs
> >> - Fix ranges in truetype target
> >> - Limit rotate to necessary damage
> >> - Remove ifdefs from gop
> >> - Fix dcache range; we were flushing too much before
> >> - Add patch "video: Use VIDEO_DAMAGE for VIDEO_COPY"
> >>
> >> v1: https://lore.kernel.org/all/20220606234336.5021-1-agraf@csgraf.de/
> >>
> >> Alexander Graf (9):
> >>    dm: video: Add damage tracking API
> >>    dm: video: Add damage notification on display fills
> >>    vidconsole: Add damage notifications to all vidconsole drivers
> >>    video: Add damage notification on bmp display
> >>    efi_loader: GOP: Add damage notification on BLT
> >>    video: Only dcache flush damaged lines
> >>    video: Use VIDEO_DAMAGE for VIDEO_COPY
> >>    video: Always compile cache flushing code
> >>    video: Enable VIDEO_DAMAGE for drivers that need it
> >>
> >> Alper Nebi Yasak (4):
> >>    video: test: Split copy frame buffer check into a function
> >>    video: test: Support checking copy frame buffer contents
> >>    video: test: Test partial updates of hardware frame buffer
> >>    video: test: Test video damage tracking via vidconsole
> >>
> >>   arch/arm/mach-omap2/omap3/Kconfig |   1 +
> >>   arch/arm/mach-sunxi/Kconfig       |   1 +
> >>   drivers/video/Kconfig             |  26 +++
> >>   drivers/video/console_normal.c    |  27 ++--
> >>   drivers/video/console_rotate.c    |  94 +++++++----
> >>   drivers/video/console_truetype.c  |  37 +++--
> >>   drivers/video/exynos/Kconfig      |   1 +
> >>   drivers/video/imx/Kconfig         |   1 +
> >>   drivers/video/meson/Kconfig       |   1 +
> >>   drivers/video/rockchip/Kconfig    |   1 +
> >>   drivers/video/stm32/Kconfig       |   1 +
> >>   drivers/video/tegra20/Kconfig     |   1 +
> >>   drivers/video/tidss/Kconfig       |   1 +
> >>   drivers/video/vidconsole-uclass.c |  16 --
> >>   drivers/video/video-uclass.c      | 190 ++++++++++++----------
> >>   drivers/video/video_bmp.c         |   7 +-
> >>   include/video.h                   |  59 +++----
> >>   include/video_console.h           |  52 ------
> >>   lib/efi_loader/efi_gop.c          |   7 +
> >>   test/dm/video.c                   | 256 ++++++++++++++++++++++++------
> >>   20 files changed, 483 insertions(+), 297 deletions(-)
> > It is good to see this tidied up into something that can be applied!
> >
> > I am unsure what is going on with the EFI performance, though. It
> > should not flush the cache after every character, only after a new
> > line. Is there something wrong in here? If so, we should fix that bug
> > first and it should be patch 1 of this series.
>
>
> Before I came up with this series, I was trying to identify the UEFI bug
> in question as well, because intuition told me surely this is a bug in
> UEFI :). Turns out it really isn't this time around.

I don't mean a bug in UEFI, I mean a bug in U-Boot's EFI
implementation. Where did you look for the bug?

Regards,
Simon
