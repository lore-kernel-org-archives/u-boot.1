Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB91CD54BF
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE53D86B58;
	Mon, 25 Sep 2023 21:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JVwaEzMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5D086C22; Mon, 25 Sep 2023 21:48:42 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9986E86B58
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5041d6d8b10so12038583e87.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695671320; x=1696276120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MQQWLlwfL6FLb3FoU2J980COd9OaG+tkNUARxG+wUFk=;
 b=JVwaEzMBl/jMNSoryLmxT2blvubE/cHfInCv+fbrEPr+1/C2BobZacBGEBNLp+MIOC
 ie5YsE2UuiCX14MRbNqe9Ig6Rnjtj2sDFTn4Uk5Ii3Algvr9yfK6UaXye38I6dsq9KL8
 wohALZNGTaTgTViiPqSgHR8M8ybVo2tQCPyy0UYgI3cNDxknu1eablvb+lSVVr+9layq
 +AX48bkaRU8JUWRXeyOYoifvXGAu5ySWTLWWNRjgejnwBA7rLLQDJIx+4Z5dQ2+mgTDL
 bqvSbCP/UeXNBIDhBl9qNYzxDjS5NiJ3/AmQgwjUnvB4zEBvLL3GlFDLvhcnbe52Up6r
 DTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671320; x=1696276120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQQWLlwfL6FLb3FoU2J980COd9OaG+tkNUARxG+wUFk=;
 b=DaVIRLSpTcs4Z87tQ799sXCIReSTUkAxEVxxAgZ6sFLCqG95k3vJXzOEiv7HaGGVEj
 myx5dUGYN3+1Bs6vYN3EnLCa41HvZh2HMghUFqZd11xLfD60PJLGE903h2Xf815PrM/2
 xBOeVAawofBiDFwvkKlU95lKNGJi0vutt05C+LwGetJsRokIivyCZSvAHQQo3T0sQw+R
 LLHkPUTHfpBlGxCFXwffBG4WMBPrjtH1KN/+eyqUzX7x7RLMsrwMyGrofuhn2bZOP3H+
 cYihDVOSw/B+d3pHwqEmMeQh8Erg8dmiTqWa2CEGcmO0/oo3GqZ2gQxB9+eb+2h+K2az
 Blfw==
X-Gm-Message-State: AOJu0YzBD41si4mJlDeTEIFF+cg9kbi3MNSk7zn8LRmlsk/auFDBL4+R
 7xYk4dpSS1d/RC+NgrpPgM1MHwVtZeUxY9WH2nqa4w==
X-Google-Smtp-Source: AGHT+IE2QFj6zuPB2HZ7efnsvO+W6vLw0ZwmRixCRy7UFyQbF2ivdfw4vtBhH1hrLawA622wMOixLOMAew3U7Tsg7Xk=
X-Received: by 2002:ac2:5a5b:0:b0:503:2623:7cfa with SMTP id
 r27-20020ac25a5b000000b0050326237cfamr6318184lfn.35.1695671319782; Mon, 25
 Sep 2023 12:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015730.1511373-1-sjg@chromium.org>
 <20230921015730.1511373-31-sjg@chromium.org>
In-Reply-To: <20230921015730.1511373-31-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Sep 2023 22:48:03 +0300
Message-ID: <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>
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

Hi Simon,

I commented on the v1 thread, but let's continue the discussion here

On Thu, 21 Sept 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
>
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>
> Tests for this will be added as part of the Universal Payload work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - No changes as it still seems unclear what should be done
>

[...]

>
>         /* BLOBLISTT_VENDOR_AREA */
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b177f..56e00090166f 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
>  devicetree at runtime, for example if an earlier bootloader stage creates
>  it and passes it to U-Boot.
>
> +If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
> +from a previous stage.

What I argued before is that we don't need to be this explicit.
The bloblist can carry a bunch of options that might be used by
U-Boot.  It would be better if we had a more generic approach instead
of adding Kconfig options per bloblist entry

[...]

>  #ifndef USE_HOSTCC
> +
> +#define LOG_CATEGORY   LOGC_DT
> +
>  #include <common.h>
> +#include <bloblist.h>
>  #include <boot_fit.h>
>  #include <display_options.h>
>  #include <dm.h>
> @@ -87,6 +91,7 @@ static const char *const fdt_src_name[] = {
>         [FDTSRC_BOARD] = "board",
>         [FDTSRC_EMBED] = "embed",
>         [FDTSRC_ENV] = "env",
> +       [FDTSRC_BLOBLIST] = "bloblist",
>  };
>
>  const char *fdtdec_get_srcname(void)
> @@ -1666,20 +1671,35 @@ int fdtdec_setup(void)
>         int ret;
>
>         /* The devicetree is typically appended to U-Boot */
> -       if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> -               gd->fdt_blob = fdt_find_separate();
> -               gd->fdt_src = FDTSRC_SEPARATE;
> -       } else { /* embed dtb in ELF file for testing / development */
> -               gd->fdt_blob = dtb_dt_embedded();
> -               gd->fdt_src = FDTSRC_EMBED;
> -       }
> -
> -       /* Allow the board to override the fdt address. */
> -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> -               gd->fdt_blob = board_fdt_blob_setup(&ret);
> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
> +               ret = bloblist_maybe_init();
>                 if (ret)
>                         return ret;
> -               gd->fdt_src = FDTSRC_BOARD;

So, instead of adding OF_BLOBLIST, just move this code under OF_BOARD,
inside an IS_ENABLED(BLOBLIST) check. If a bloblist is required and
the previous stage loader is supposed to provide a DT we can just
throw an error and stop booting


> +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +               if (!gd->fdt_blob) {
> +                       printf("Not FDT found in bloblist\n");
> +                       bloblist_show_list();
> +                       return -ENOENT;
> +               }

[...]

Regards
/Ilias
