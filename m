Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89141E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6B6871B0;
	Mon,  2 Oct 2023 03:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="liCLl+66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3955B871A9; Mon,  2 Oct 2023 03:19:51 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EEE870D3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59f6e6b206fso140938447b3.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209563; x=1696814363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7kFM6ysijcrOTTmA/whL2gndbofZurrBAFrjbNnCVqw=;
 b=liCLl+66taap4m2NgP4EEyR+29aSHzUkGUOgn+0uGoF/1ei07xGGnHOwpWKl3ktMlF
 DWzMPZdjVTMOIQOgU/Etj4ANv+B6p3Y4q8c1q4Ak4CLBVx+GM608oRTGfk3rJ3XoeGzx
 Ved0UsLm7a+I2HhePxXglRHG6OvLu9o1Dt+Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209563; x=1696814363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kFM6ysijcrOTTmA/whL2gndbofZurrBAFrjbNnCVqw=;
 b=v1msHybHaieQ1uT6RU86EL91xmTF+HtmJYws493x6KVNjxzawqX+/QTyVGsMWVu0GX
 6PVTtf2rwvPHRLmYXBo7lCHEptxxm8aex60p1ccNqN5OGrbRzT6sDHVvB59jhql9Gam4
 8jFYiRsZa0ODbg1BOpjUs68NBJoW0GlOY6XkJB/jNA41nKah0hGunYLxfdG9IRnrl5ML
 LQAtsg8ncvVvkc4AIzOKQCKbMDvm80PhhaZYcm++WSzElqt6rPFApROn/GDW+fakbmXv
 f8g2IB00xcCtjpniq/e4knII0kfVkggBYDpDlHUOhNO80elbXr9Vq+obmqeE+Qx+RPIW
 3DYA==
X-Gm-Message-State: AOJu0YyloxhtPJNPffIdSx9bBHN7THMjwNJOLhOeVTNdLFfj6X3/QwW5
 c786YgChNLCPuaQTcyFCWMQMmeTp+SCdNEs2W291fq1XpxIKUxwVNEE=
X-Google-Smtp-Source: AGHT+IG6h5lMXDrFsI747PDYfx+/P1G/RTluzD27I9wen1rsBdu/HbGsUyaAA5oJ8oUGbmleSugf9WDHRoYEa5zXeUk=
X-Received: by 2002:a0d:dd8c:0:b0:56f:fffc:56ff with SMTP id
 g134-20020a0ddd8c000000b0056ffffc56ffmr10319445ywe.42.1696209562551; Sun, 01
 Oct 2023 18:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230928144458.2511087-1-sean.anderson@seco.com>
In-Reply-To: <20230928144458.2511087-1-sean.anderson@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:47 -0600
Message-ID: <CAPnjgZ1Y=+2GoHzj=6mJySyYrn9CoHBZzSDjFreWNEWJyi+jMQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] malloc: Reduce size by initializing data at runtime
To: Sean Anderson <sean.anderson@seco.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Sean,

On Thu, 28 Sept 2023 at 08:45, Sean Anderson <sean.anderson@seco.com> wrote:
>
> In my efforts to get SPL to fit into flash after some changes I made, I
> noticed that av_ is one of the largest variables in SPL. As it turns
> out, we can generate it at runtime, and the code is already there. This
> has the potential to save 1-2k across the board, for some (very) minor
> boot time increase.
>
> This series is based on [1], since this makes checking for SYS_MALLOC_F
> easier. Passing CI at [2].
>
> To measure the boot time difference, I applied the following patch:
>
> ---
>  common/board_r.c | 5 +++++
>  common/spl/spl.c | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 58a5986aa54..ca624b20d46 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -194,6 +194,7 @@ static int initr_barrier(void)
>         return 0;
>  }
>
> +static ulong malloc_begin, malloc_end;
>  static int initr_malloc(void)
>  {
>         ulong malloc_start;
> @@ -208,8 +209,10 @@ static int initr_malloc(void)
>          * reserve_noncached().
>          */
>         malloc_start = gd->relocaddr - TOTAL_MALLOC_LEN;
> +       malloc_begin = timer_get_boot_us();

Perhaps this would be better done with bootstage, since then the
timing can be enabled / disabled, and reported along with other
timings.


>         mem_malloc_init((ulong)map_sysmem(malloc_start, TOTAL_MALLOC_LEN),
>                         TOTAL_MALLOC_LEN);
> +       malloc_end = timer_get_boot_us();
>         gd->flags |= GD_FLG_FULL_MALLOC_INIT;
>         return 0;
>  }
> @@ -570,6 +573,8 @@ static int dm_announce(void)
>
>  static int run_main_loop(void)
>  {
> +       printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
> +              malloc_begin, malloc_end);
>  #ifdef CONFIG_SANDBOX
>         sandbox_main_loop_init();
>  #endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index d74acec10b5..b34d1f4b4e6 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -755,7 +755,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>         spl_set_bd();
>
>  #if defined(CONFIG_SYS_SPL_MALLOC)
> +       ulong malloc_begin = timer_get_boot_us();
>         mem_malloc_init(SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE);
> +       ulong malloc_end = timer_get_boot_us();
>         gd->flags |= GD_FLG_FULL_MALLOC_INIT;
>  #endif
>         if (!(gd->flags & GD_FLG_SPL_INIT)) {
> @@ -817,6 +819,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>         spl_image.boot_device = BOOT_DEVICE_NONE;
>         board_boot_order(spl_boot_list);
>
> +       printf("malloc_init took %luus (%lu %lu)\n", malloc_end - malloc_begin,
> +              malloc_begin, malloc_end);

debug() ?

>         ret = boot_from_devices(&spl_image, spl_boot_list,
>                                 ARRAY_SIZE(spl_boot_list));
>         if (ret) {
> --
> 2.25.1
>
> I found that MALLOC_CLEAR_ON_INIT dominated the mem_malloc_init time
> (taking around 150 ms in SPL on my board). After disabling it, I found
> that MALLOC_RUNTIME_INIT took around 5 us on average.
>
> [1] https://lore.kernel.org/u-boot/20230926141514.2101787-1-sjg@chromium.org/
> [2] https://source.denx.de/u-boot/custodians/u-boot-clk/-/pipelines/17900
>
> Changes in v3:
> - Use CONFIG_IS_ENABLED in conditionals
> - Don't enable SPL_SYS_MALLOC_RUNTIME_INIT if we are short on BSS
>
> Changes in v2:
> - Only mark malloc initialized after mem_malloc_init
> - Fix cALLOc condition
>
> Sean Anderson (4):
>   common: Only mark malloc initialized after mem_malloc_init
>   malloc: Don't use ifdefs for SYS_MALLOC_DEFAULT_TO_INIT
>   malloc: Don't statically initialize av_ if using malloc_init
>   malloc: Enable SYS_MALLOC_RUNTIME_INIT by default in SPL
>
>  Kconfig           | 27 +++++++++++++++++----------
>  common/board_r.c  |  3 ++-
>  common/dlmalloc.c | 16 ++++++++--------
>  3 files changed, 27 insertions(+), 19 deletions(-)
>
> --
> 2.35.1.1320.gc452695387.dirty
>

REgards,
SImon
