Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E8C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0094D82006;
	Thu,  3 Apr 2025 17:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDO9C0Hk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1BA382075; Thu,  3 Apr 2025 17:34:26 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5688059D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 17:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af5085f7861so816171a12.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743694462; x=1744299262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QBClg/Yp/LDOnzE2+4mlbI+kc2+BznQYsVsLGWluJFE=;
 b=MDO9C0Hk4six699nehere0d3ZIY/rC3yaZRMk73gKJytliS8V3xKzCTsw1Ru97zdGf
 N34swSFGHl+qVhtx0LLTBYy7CwVTmAnLbvhEsa40ZwEXwi3dronks1zTHpCkdLrAohOY
 KVE2lfVJmx1i1pDitFaiciD+roGkLPiCRUicHq9VZ3lOk90kpdxO23JJpOB0wJClB9ir
 YTnKEkvfcgrGgWwRNSiI8hS+3EtYBlmG0gY8wgvblbwgxa3Ni9tvwohrGZIA2+DMg2zG
 qbKEk1cNwaY84s7HGmWse3nlYriO7b72wghkTnlz2+CdstHNPOWf7TxYWruV2mNE7DZf
 Nh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743694462; x=1744299262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QBClg/Yp/LDOnzE2+4mlbI+kc2+BznQYsVsLGWluJFE=;
 b=cRiuhD5k3OwEnEbOnmxD4cF/XOWpQQTQ/0/PaneFELWdvIsOSOOP4mDZKhKih4gC4k
 l2AaZGc/ZTlwKv+BWV2G/2pg26AQhsxmhgAHTTm9xY9lhczPI7g3TJDp/dERIPIwlpPm
 c7TtsiSqPRo+CNLjL7WvdHGzFBo9CTtYzDET+7bcSSCbW6j1lS1SXnZdXUMhP/+R/Jy+
 ON897OCT1r5iDIuCV8/ZbV/zofNlcW07Q4TUf25BvM8gWEhgulVUTudIQQWm9BW86L/H
 VWfDvG48Ff53t/1Kbd/5V93YJK7NVbGJEbH8zHLVWL563a/5Wk75i+Zkj0KQeY8UoX47
 j+IQ==
X-Gm-Message-State: AOJu0Yy7k0kn4i76SHIx0SAc9ysxx9+9AsiUXgRX76Sh5AXRx0lvHYZA
 n8ouaRv5WCq5/jcHwUkDgPAnFwrRmZWl8P1l30tBgX1zMKTjHmFNU//aiot6CPxjFjxSpXCO07D
 tjkwgP7BmcQtZWGlX+asIhebn2gg7Lf1wYAzF0A==
X-Gm-Gg: ASbGnctZXNIcR/Qzx4IfYLeuAlMK7nrqWQw5Y9ueonXNqVpWlVNCGincb5yHJCB31Gi
 SmXZ7pZNL1zT5ImQO5s6cb+u5dkhX7KvcfntceUMn7irNx7iB4HnC3/3kkJZerOcGEyJ6+P1NTD
 5dR6dBTe8WOlUsO8mECU68ytxa/RA=
X-Google-Smtp-Source: AGHT+IGkE3luKOuTUEESKBFNCXBRgoKNWsfpu8ibtLdNehd/2tcYjcTBhA5UMuwNiKDpW+GvHX2+pngS6/5gje/Y7Y8=
X-Received: by 2002:a17:90b:53d0:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-306a4865143mr52965a91.12.1743694462540; Thu, 03 Apr 2025
 08:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328154401.3563921-3-sjg@chromium.org>
In-Reply-To: <20250328154401.3563921-3-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 3 Apr 2025 11:34:10 -0400
X-Gm-Features: AQ5f1Jq1ebQiHZK7BD6KO1Y4X3WJ7GTE-1Y7QEjU877qVLhSfcNnsbipCEopbw8
Message-ID: <CAEfUkU+zzsxR7xwY2E4APG9LWK5XJXToLhG1SyC6LQBL3wvo7w@mail.gmail.com>
Subject: Re: [PATCH 2/4] fdt: Introduce OF_BLOBLIST
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
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

On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
>
> Add an option which indicates that the devicetree comes from the
> bloblist.
>
> After discussions with Tom, it seems we are comfortable with introducing
> this option, ensuring of course that the transfer list is properly
> supported.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  doc/develop/devicetree/control.rst |  3 ++
>  dts/Kconfig                        |  8 ++++
>  lib/fdtdec.c                       | 66 ++++++++++++------------------
>  3 files changed, 38 insertions(+), 39 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> index 0233945f8b6..d80f4d420a9 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -137,6 +137,9 @@ If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
>  devicetree at runtime, for example if an earlier bootloader stage creates
>  it and passes it to U-Boot.
>
> +If `OF_BLOBLIST` is defined, the devicetree comes from a bloblist passed
> +from a previous stage.
> +
>  If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
>  passed from a previous stage, if present.
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 6a5141b56e9..04359a4d7b2 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -167,6 +167,14 @@ config OF_INITIAL_DTB_READONLY
>           If initial DTB for DT control is read-only (e.g. points to
>           memory-mapped flash memory), then set this option.
>
> +config OF_BLOBLIST
> +       bool "DTB is provided by a bloblist"
> +       help
> +         Select this to read the devicetree from the bloblist. This allows
> +         using a bloblist to transfer the devicetree between U-Boot phases.
> +         The devicetree is stored in the bloblist by an earlier phase so that
> +         U-Boot can read it.
> +
>  config OF_BOARD
>         bool "Provided by the board (e.g a previous loader) at runtime"
>         default y if SANDBOX || OF_HAS_PRIOR_STAGE
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index f09c9926a7a..833f8aca3ce 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1689,55 +1689,43 @@ void fdtdec_setup_embed(void)
>
>  int fdtdec_setup(void)

I think a better idea is to use BLOBLIST_PASSAGE_MANDATORY, see below
pseudo code:

```
if (IS_ENABLED(CONFIG_OF_BOARD)) {
    /* get fdt from board */
}

/* allow fdtcontroladdr to override it */

if (CONFIG_IS_ENABLED(BLOBLIST) && ... ) {
    /* try to find fdt from bloblist */

    if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY) {
        if (no_fdt_in_bloblist)
            return ERROR;

        /* override fdt with the one from bloblist */
    }
}
```

Regards,
Raymond

>  {
> -       int ret = -ENOENT;
> +       int ret;
>
> -       /*
> -        * If allowing a bloblist, check that first. There was discussion about
> -        * adding an OF_BLOBLIST Kconfig, but this was rejected.
> -        *
> -        * The necessary test is whether the previous phase passed a bloblist,
> -        * not whether this phase creates one.
> -        */
> -       if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -           (xpl_prev_phase() != PHASE_TPL ||
> -            IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
>                 ret = bloblist_maybe_init();
> -               if (!ret) {
> -                       gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> -                       if (gd->fdt_blob) {
> -                               gd->fdt_src = FDTSRC_BLOBLIST;
> -                               log_debug("Devicetree is in bloblist at %p\n",
> -                                         gd->fdt_blob);
> -                               ret = 0;
> -                       } else {
> -                               log_debug("No FDT found in bloblist\n");
> -                               ret = -ENOENT;
> -                       }
> +               if (ret)
> +                       return ret;
> +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +               if (!gd->fdt_blob) {
> +                       printf("Not FDT found in bloblist\n");
> +                       bloblist_show_list();
> +                       return -ENOENT;
>                 }
> -       }
> -
> -       /* Otherwise, the devicetree is typically appended to U-Boot */
> -       if (ret) {
> +               gd->fdt_src = FDTSRC_BLOBLIST;
> +               bloblist_show_list();
> +               log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
> +       } else {
>                 if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
>                         gd->fdt_blob = fdt_find_separate();
>                         gd->fdt_src = FDTSRC_SEPARATE;
>                 } else { /* embed dtb in ELF file for testing / development */
> -                       fdtdec_setup_embed();
> +                       gd->fdt_blob = dtb_dt_embedded();
> +                       gd->fdt_src = FDTSRC_EMBED;
>                 }
> -       }
>
> -       /* Allow the board to override the fdt address. */
> -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> -               void *blob;
> +               /* Allow the board to override the fdt address. */
> +               if (IS_ENABLED(CONFIG_OF_BOARD)) {
> +                       void *blob;
>
> -               blob = (void *)gd->fdt_blob;
> -               ret = board_fdt_blob_setup(&blob);
> -               if (ret) {
> -                       if (ret != -EEXIST)
> -                               return ret;
> -               } else {
> -                       gd->fdt_src = FDTSRC_BOARD;
> -                       gd->fdt_blob = blob;
> +                       blob = (void *)gd->fdt_blob;
> +                       ret = board_fdt_blob_setup(&blob);
> +                       if (ret) {
> +                               if (ret != -EEXIST)
> +                                       return ret;
> +                       } else {
> +                               gd->fdt_src = FDTSRC_BOARD;
> +                               gd->fdt_blob = blob;
> +                       }
>                 }
>         }
>
> --
> 2.43.0
>
