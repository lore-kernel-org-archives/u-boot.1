Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C5AC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 14:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D666877D5;
	Thu,  4 Jan 2024 15:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fPSgh1qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79978792C; Thu,  4 Jan 2024 15:24:50 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1E6877D5
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 15:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50eaaf2c7deso609939e87.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 06:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704378288; x=1704983088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rSSlCe+RDfzuUtG7JMpBujVPvQUh1q+MSavSrSYrf28=;
 b=fPSgh1qot9amlCv0LPitQ++R1auCfmVzRsxH50z6P1aITtBY5xLiJRcxw/Z8FSBekJ
 M1orSrwqhBuzIiLrhP6LExI+ePTsnT81C8KBBid4Wm+MapHy85NuI8lpbYSs/QKH4E+2
 u4Lnr1S5REJQ6ud7KoEwW8RM95KYNjiCUjhu18IUutIuL9S6gYguPEsLFccOti92h/iu
 F0J5TFfzzI+6O5sc3V3RXY8EPK7JYhg2TOLQcAMLkfzYSFbFKiGO2Lu5OEXraSX8wVj2
 a3HFqvMpGs8yCa0VlQsBHkfDAuZO677ltKlh+RVwVpa1EUe0IKJHv4ZbtbR8SIkKF0HE
 v+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704378288; x=1704983088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rSSlCe+RDfzuUtG7JMpBujVPvQUh1q+MSavSrSYrf28=;
 b=vOUAClXfI6R/UNX0m38dtHQaw8HYnBrTs0iO6lrR/BvvU7SlHLybGl6obce9Y2DNfO
 N5qBQJd+0bEuaJPwAxky60HZr7L6mLcM+Epeeu4PUGt/jTpqP0Xm6DYSJFu6RZxQjV5i
 avrVwul/x8/xbJUX+najQSnQz6Xw/6GIZD3JQIhzQbQbCzFtBQEXe0qpDvnIMxC1giqB
 NIPh3Db7GqdpQwvnZV3Lt1PFISVggvlFuEOJ25OPCd+k17tG+TAwwZfjVqA3fpkF3gIm
 /3G4Z6a6mMcb/F3rs1OwmJDAwlXw7eD+et6NlwHr9Y2ZOnQxVtoPL+JIktSPN5tH/ivj
 e7Uw==
X-Gm-Message-State: AOJu0Yy31kj4Ws7jdd+GzKqVM0y9JDWVLBuZ43QHWIYGJlMMRT5eEISm
 v5jg0ulHntO8f0LA1KMGTDUbaM73y5sFeDhGZLT59FWc6/zz+g==
X-Google-Smtp-Source: AGHT+IE/QGdt1sGIPvcx529DfeE1C07/Qq4lejmpqy69yhG8hz4T4x2jdpW7HUbPGQpHV1hvrPwmY8Gj9ofKkmyWZqg=
X-Received: by 2002:a19:6507:0:b0:50e:75a3:5804 with SMTP id
 z7-20020a196507000000b0050e75a35804mr392267lfb.14.1704378287850; Thu, 04 Jan
 2024 06:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20240104014919.413568-1-sjg@chromium.org>
In-Reply-To: <20240104014919.413568-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 4 Jan 2024 16:24:11 +0200
Message-ID: <CAC_iWjJ6=NjqwcFzVvV4DzMWy5nY_QAeD=vfQrRSjodLbVqroQ@mail.gmail.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
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

On Thu, 4 Jan 2024 at 03:49, Simon Glass <sjg@chromium.org> wrote:
>
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>
> Tests for this will be added as part of the Universal Payload work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD
>
> Changes in v7:
> - Drop use of OF_BLOBLIST
>
> Changes in v6:
> - Don't allow bloblist with OF_EMBED
>
> Changes in v5:
> - Make OF_BLOBLIST default y
> - Make OF_BLOBLIST optional at runtime
>
> Changes in v4:
> - Rebase to -next
>
>  doc/develop/devicetree/control.rst |  3 ++
>  include/fdtdec.h                   |  6 ++--
>  lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index cbb65c9b177..11c92d440f4 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
>  devicetree at runtime, for example if an earlier bootloader stage creates
>  it and passes it to U-Boot.
>
> +If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist passed
> +from a previous stage, if present.
> +
>  If CONFIG_SANDBOX is defined, then it will be read from a file on
>  startup. Use the -d flag to U-Boot to specify the file to read, -D for the
>  default and -T for the test devicetree, used to run sandbox unit tests.
> diff --git a/include/fdtdec.h b/include/fdtdec.h
> index bd1149f46d0..e80de24076c 100644
> --- a/include/fdtdec.h
> +++ b/include/fdtdec.h
> @@ -72,7 +72,7 @@ struct bd_info;
>   *     U-Boot is packaged as an ELF file, e.g. for debugging purposes
>   * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
>   *     be used for debugging/development only
> - * @FDTSRC_NONE: No devicetree at all
> + * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
>   */
>  enum fdt_source_t {
>         FDTSRC_SEPARATE,
> @@ -80,6 +80,7 @@ enum fdt_source_t {
>         FDTSRC_BOARD,
>         FDTSRC_EMBED,
>         FDTSRC_ENV,
> +       FDTSRC_BLOBLIST,
>  };
>
>  /*
> @@ -1190,7 +1191,8 @@ int fdtdec_resetup(int *rescan);
>   *
>   * The existing devicetree is available at gd->fdt_blob
>   *
> - * @err internal error code if we fail to setup a DTB
> + * @err: 0 on success, -EEXIST if the devicetree is already correct, or other
> + * internal error code if we fail to setup a DTB
>   * @returns new devicetree blob pointer
>   */
>  void *board_fdt_blob_setup(int *err);
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index 4016bf3c113..b2c59ab3818 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -7,6 +7,10 @@
>   */
>
>  #ifndef USE_HOSTCC
> +
> +#define LOG_CATEGORY   LOGC_DT
> +
> +#include <bloblist.h>
>  #include <boot_fit.h>
>  #include <display_options.h>
>  #include <dm.h>
> @@ -86,6 +90,7 @@ static const char *const fdt_src_name[] = {
>         [FDTSRC_BOARD] = "board",
>         [FDTSRC_EMBED] = "embed",
>         [FDTSRC_ENV] = "env",
> +       [FDTSRC_BLOBLIST] = "bloblist",
>  };
>
>  const char *fdtdec_get_srcname(void)
> @@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
>
>  int fdtdec_setup(void)
>  {
> -       int ret;
> +       int ret = -ENOENT;
> +
> +       /* If allowing a bloblist, check that first */
> +       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> +               ret = bloblist_maybe_init();
> +               if (!ret) {
> +                       gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +                       if (gd->fdt_blob) {
> +                               gd->fdt_src = FDTSRC_BLOBLIST;
> +                               log_debug("Devicetree is in bloblist at %p\n",
> +                                         gd->fdt_blob);
> +                       } else {
> +                               log_debug("No FDT found in bloblist\n");
> +                               ret = -ENOENT;
> +                       }
> +               }
> +       }
>
> -       /* The devicetree is typically appended to U-Boot */
> -       if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> -               gd->fdt_blob = fdt_find_separate();
> -               gd->fdt_src = FDTSRC_SEPARATE;
> -       } else { /* embed dtb in ELF file for testing / development */
> -               gd->fdt_blob = dtb_dt_embedded();
> -               gd->fdt_src = FDTSRC_EMBED;
> +       /* Otherwise, the devicetree is typically appended to U-Boot */
> +       if (ret) {
> +               if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> +                       gd->fdt_blob = fdt_find_separate();
> +                       gd->fdt_src = FDTSRC_SEPARATE;
> +               } else { /* embed dtb in ELF file for testing / development */
> +                       gd->fdt_blob = dtb_dt_embedded();
> +                       gd->fdt_src = FDTSRC_EMBED;
> +               }
>         }
>
>         /* Allow the board to override the fdt address. */
>         if (IS_ENABLED(CONFIG_OF_BOARD)) {
>                 gd->fdt_blob = board_fdt_blob_setup(&ret);
> -               if (ret)
> +               if (!ret)
> +                       gd->fdt_src = FDTSRC_BOARD;
> +               else if (ret != -EEXIST)
>                         return ret;
> -               gd->fdt_src = FDTSRC_BOARD;
>         }
>
>         /* Allow the early environment to override the fdt address */
> --
> 2.34.1
>

Thanks Simon
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
