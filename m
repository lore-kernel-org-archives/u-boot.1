Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE618C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA6BE874B9;
	Sun, 12 Nov 2023 21:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PZZAwMKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0668A874B6; Sun, 12 Nov 2023 21:03:48 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F3D8747B
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7dd65052aso44520887b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819423; x=1700424223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YBTH7KiZdfuvypRzTEjLfqoi1JBU71nNeG9gm/1Hy1c=;
 b=PZZAwMKttvvvxLYOZCP6JNoUFeuaagLyCLonOLY0p5ggyTfHZ+E+6N6khmWay09zHc
 MISl9yc8g+jo0myVtgCK+JVcM5VRUWvXcKkxnZgl3hZKIF1+/3F6bw7AbhPBgLPkXtag
 7ErBOQGhCYKLdHMJxLVVLrjSbMPj1urhMLIGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819423; x=1700424223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBTH7KiZdfuvypRzTEjLfqoi1JBU71nNeG9gm/1Hy1c=;
 b=PJHwmF0lE7whn+SFacuN4mMReXvmMNzUOVBwouW1wzMckIK33UCdhQYt5VK7m/rU4w
 1W5Fz+6cvqPC1ZRG1wkv4ZUcnE/jMP72LjPCpCXvfofb7zJeit1JjFSeEyF7PpyNf5Nv
 W/sHjB6+wqhLYcFGNeZFMMmd+ZcvKmDXcg5Z4N++Xuqhk/cR1yiAmRsY4ZrN51sJhEv/
 wHVidDsu2FUsvfOYdKo0C6W0d/e7+d91eTIiUh2Dz84LCf5oc1GDgMi1zXnV3zoLPFNI
 NB07JUn+36vMRshEsrtnAEur03fH3OK7wYQw+u8UBRNQmggwWHEf5vdJVzT2BP3vNBdJ
 qfeg==
X-Gm-Message-State: AOJu0YyAOruz2PAuXrs4bXW8wYwi8MX7/PQgTv7inoc7aN8GvLTKG372
 ZBSZzBiGuceA+zRwiKUpxz9oQkyVQ1Y9skpzZkr62QDGrQJ1iUc6ZS8=
X-Google-Smtp-Source: AGHT+IGqa+HwIY7YNA6AKK+uA9/lTJ3RDe895P7DINupb7HK398m2zeqG+j0zK94ItpSi9Hfx2L4Hl2ntNKA9JvJgPk=
X-Received: by 2002:a0d:ca13:0:b0:5a7:d73d:42cd with SMTP id
 m19-20020a0dca13000000b005a7d73d42cdmr5538785ywd.20.1699819422723; Sun, 12
 Nov 2023 12:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-7-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-7-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:23 -0700
Message-ID: <CAPnjgZ1rwogk1Q9xJ5X=_bZN-rX7V1pnZXiybdnG9EhX8FcMbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: spl: Add info regarding memory reservation
 and missing Kconfigs
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Add information regarding memory reservation scheme in SPL
> and details regarding scheme which need to be followed while reserving
> those areas which need to be preserved across bootstages.
>
> Also add missing CONFIG_SPL Kconfigs and new ones which were added
> recently.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V1->V3 : No change
> ---
>  doc/develop/spl.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
> index 76e87f07c7..fc570589eb 100644
> --- a/doc/develop/spl.rst
> +++ b/doc/develop/spl.rst
> @@ -65,6 +65,15 @@ CONFIG_SPL_NAND_LOAD (drivers/mtd/nand/raw/nand_spl_load.o)
>  CONFIG_SPL_SPI_LOAD (drivers/mtd/spi/spi_spl_load.o)
>  CONFIG_SPL_RAM_DEVICE (common/spl/spl.c)
>  CONFIG_SPL_WATCHDOG (drivers/watchdog/libwatchdog.o)
> +CONFIG_SPL_SYSCON (drivers/core/syscon-uclass.o)
> +CONFIG_SPL_GZIP (lib/gzip.o)
> +CONFIG_SPL_VIDEO (drivers/video/video-uclass.o drivers/video/vidconsole-uclass.o)
> +CONFIG_SPL_SPLASH_SCREEN (common/splash.o)
> +CONFIG_SPL_SPLASH_SOURCE (common/splash_source.o)
> +CONFIG_SPL_GPIO (drivers/gpio)
> +CONFIG_SPL_DM_GPIO (drivers/gpio/gpio-uclass.o)
> +CONFIG_SPL_BMP (drivers/video/bmp.o)
> +CONFIG_SPL_BLOBLIST (common/bloblist.o)

Did you intend to add the above? If so, please put it in its own patch.

>
>  Adding SPL-specific code
>  ------------------------
> @@ -164,3 +173,16 @@ cflow will spit out a number of warnings as it does not parse
>  the config files and picks functions based on #ifdef.  Parsing the '.i'
>  files instead introduces another set of headaches.  These warnings are
>  not usually important to understanding the flow, however.
> +
> +
> +Reserving memory in SPL
> +-----------------------
> +
> +If memory need to be reserved in RAM during SPL stage so that area won't get touched
> +by SPL and/or u-boot, it need to be reserved starting from end of RAM.

U-Boot (please avoid using any other spelling in docs and comments;
please fix globally)

> +
> +Also the regions which are to be preserved across further stages of boot need to be reserved first starting from
> +framebuffer memory which must be reserved from end of RAM for which helper function spl_reserve_video_from_ram_top is provided.

Worth mentioning that framebuffer being reserved first means it is at
the top of the reservation area with everything else reserved below
it?

> +
> +The corresponding information of reservation for those regions can be passed to further stages of boot using a bloblist.
> +For e.g. the information for framebuffer area reserved by SPL can be passed onto u-boot using BLOBLISTT_U_BOOT_VIDEO.

Can you please wrap to 80 cols?

> --
> 2.34.1
>

Regards,
Simon
