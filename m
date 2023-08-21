Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF88EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF845868D7;
	Mon, 21 Aug 2023 21:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UQ5QXwo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A80E80770; Mon, 21 Aug 2023 21:13:54 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AB5871E1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59234aaca15so9111437b3.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4b8vVOy+7wecpbSr04GBcW/NVbN5vG825shqLiwpSys=;
 b=UQ5QXwo3tRZd3NmqWF1BZToVsPp+urnkkbM7zmYloiTGBq1sJFYEG89Pdhp9MDranQ
 qYXu3c7gTG8lzdQFbrkH1WjY4C225EsU/7S5U5lDxOchIUSmLfZfnSUy8QDNnDUEvJcC
 t5KwbZW5QgCWLyNE7uumD0Rnya5VJp9/aNg2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4b8vVOy+7wecpbSr04GBcW/NVbN5vG825shqLiwpSys=;
 b=lUkKAwa7yBjTNmucdhDf3kckBwlpO1nMHtffmxkJFWgiFmIS5UfR+jQtL0AFnsTaaL
 zLcQK7G7dypWFTHbFzOEzOnoqbkhYoIsQj+5vATQV7dQ2+qAwKQo8/n4jV1Qh8DN+QyH
 gyc7ogMJYWd8p7+cKMf9oamwiQhP97A0pSqYFx4z7MwhbxIaOHxy9T+0E/sAeBBg6F7V
 qpfzbffdj8Prt56JCXSKHFs4O65yUG1Seis1bgzIZQRBU5DGxmilTzX9M6SIeeF1c3Np
 thBLsBLXSW9mrov8CcHM9uZMg2LTR6HRZidAyHid0QXnjLpUzZHc7ayC1q/h/eYl/bBs
 yakg==
X-Gm-Message-State: AOJu0Yz43deRY437j3WPmptkE+URYYrC719KfQh9VqKmE45S1pVviJjS
 VDEG8QucPKV7Oo4Cy/8RfOlDzTgg5Ai32ZI2SOxwUA==
X-Google-Smtp-Source: AGHT+IGz6onVLaBq5SgMlvOlRVzPtuIoSQmIoY1RA5Np6UijxL01X70HGA+5W7rboBPf54h4A1z61iMXypakJKMH28g=
X-Received: by 2002:a25:e758:0:b0:bfe:e383:6297 with SMTP id
 e85-20020a25e758000000b00bfee3836297mr6799558ybh.19.1692645218700; Mon, 21
 Aug 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-12-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-12-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:53 -0600
Message-ID: <CAPnjgZ0Ho7h5T-7S1Mi23+1ez7hq2MCEEZJjjieM3oZNHY5uOQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] video: Use VIDEO_DAMAGE for VIDEO_COPY
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
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

Hi Alper,

On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> CONFIG_VIDEO_COPY implemented a range-based copying mechanism: If we
> print a single character, it will always copy the full range of bytes
> from the top left corner of the character to the lower right onto the
> uncached frame buffer. This includes pretty much the full line contents
> of the printed character.
>
> Since we now have proper damage tracking, let's make use of that to reduce
> the amount of data we need to copy. With this patch applied, we will only
> copy the tiny rectangle surrounding characters when we print them,
> speeding up the video console.

I suppose for rotated consoles it copies whole lines, but otherwise it
does a lot of small copies?

>
> After this, changes to the main frame buffer are not immediately copied
> to the copy frame buffer, but postponed until the next video device
> sync. So issue an explicit sync before inspecting the copy frame buffer
> contents for the video tests.

So how does the sync get done in this case?

>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Rebase for fontdata->height/w, fill_part(), fix memmove(dev),
>         drop from defconfig, use damage.xstart/yend, use IS_ENABLED(),
>         call video_sync() before copy_fb check, update video_copy test]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Remove video_sync_copy() also from video_fill(), video_fill_part()
> - Fix memmove() calls by removing the extra dev argument
> - Call video_sync() before checking copy_fb in video tests
> - Use xstart, ystart, xend, yend as names for damage region
> - Use met->baseline instead of priv->baseline
> - Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
> - Use xstart, ystart, xend, yend as names for damage region
> - Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
> - Drop VIDEO_DAMAGE from sandbox defconfig added in a new patch
> - Update dm_test_video_copy test added in a new patch
>
> Changes in v3:
> - Make VIDEO_COPY always select VIDEO_DAMAGE
>
> Changes in v2:
> - Add patch "video: Use VIDEO_DAMAGE for VIDEO_COPY"
>
>  configs/sandbox_defconfig         |  1 -
>  drivers/video/Kconfig             |  5 ++
>  drivers/video/console_normal.c    | 13 +----
>  drivers/video/console_rotate.c    | 44 +++-----------
>  drivers/video/console_truetype.c  | 16 +----
>  drivers/video/vidconsole-uclass.c | 16 -----
>  drivers/video/video-uclass.c      | 97 ++++++++-----------------------
>  drivers/video/video_bmp.c         |  7 ---
>  include/video.h                   | 37 ------------
>  include/video_console.h           | 52 -----------------
>  test/dm/video.c                   |  3 +-
>  11 files changed, 43 insertions(+), 248 deletions(-)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 51b820f13121..259f31f26cee 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -307,7 +307,6 @@ CONFIG_USB_ETH_CDC=y
>  CONFIG_VIDEO=y
>  CONFIG_VIDEO_FONT_SUN12X22=y
>  CONFIG_VIDEO_COPY=y
> -CONFIG_VIDEO_DAMAGE=y
>  CONFIG_CONSOLE_ROTATION=y
>  CONFIG_CONSOLE_TRUETYPE=y
>  CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 97f494a1340b..b3fbd9d7d9ca 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -83,11 +83,14 @@ config VIDEO_PCI_DEFAULT_FB_SIZE
>
>  config VIDEO_COPY
>         bool "Enable copying the frame buffer to a hardware copy"
> +       select VIDEO_DAMAGE
>         help
>           On some machines (e.g. x86), reading from the frame buffer is very
>           slow because it is uncached. To improve performance, this feature
>           allows the frame buffer to be kept in cached memory (allocated by
>           U-Boot) and then copied to the hardware frame-buffer as needed.
> +         It uses the VIDEO_DAMAGE feature to keep track of regions to copy
> +         and will only copy actually touched regions.
>
>           To use this, your video driver must set @copy_base in
>           struct video_uc_plat.
> @@ -105,6 +108,8 @@ config VIDEO_DAMAGE
>           regions of the frame buffer that were modified before, speeding up
>           screen refreshes significantly.
>
> +         It is also used by VIDEO_COPY to identify which regions changed.
> +
>  config BACKLIGHT_PWM
>         bool "Generic PWM based Backlight Driver"
>         depends on BACKLIGHT && DM_PWM
> diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
> index a19ce6a2bc11..c44aa09473a3 100644
> --- a/drivers/video/console_normal.c
> +++ b/drivers/video/console_normal.c
> @@ -35,10 +35,6 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
>                 fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
>         end = dst;
>
> -       ret = vidconsole_sync_copy(dev, line, end);
> -       if (ret)
> -               return ret;
> -
>         video_damage(dev->parent,
>                      0,
>                      fontdata->height * row,
> @@ -57,14 +53,11 @@ static int console_move_rows(struct udevice *dev, uint rowdst,
>         void *dst;
>         void *src;
>         int size;
> -       int ret;
>
>         dst = vid_priv->fb + rowdst * fontdata->height * vid_priv->line_length;
>         src = vid_priv->fb + rowsrc * fontdata->height * vid_priv->line_length;
>         size = fontdata->height * vid_priv->line_length * count;
> -       ret = vidconsole_memmove(dev, dst, src, size);
> -       if (ret)
> -               return ret;
> +       memmove(dst, src, size);

Why are you making that change?

Regards,
Simon
