Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AD6E7E627
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B545486D7C;
	Tue, 26 Sep 2023 13:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NW2yu5P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C8886D73; Tue, 26 Sep 2023 13:37:50 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E3786A33
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so13927130e87.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695728268; x=1696333068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OMrqPIBdD4b6IgCPDh/yBmcicGIHHURwwlMC6uMAtN4=;
 b=NW2yu5P3XiHHm7qFePSQV+WQUfE5FuhyHsFBQCLXsLARWwSDo5fU1uTRlbUdFN53Xw
 jlGWwml4iYQDAWw11EwVMXntN2/V3700tFKBHvQqC4CYpHVWOo3r8UtjvnBoKpj2R6EE
 UbxICAFgSioSyADwfPTR2j+zgK7o6momChHFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728268; x=1696333068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OMrqPIBdD4b6IgCPDh/yBmcicGIHHURwwlMC6uMAtN4=;
 b=NxVeCUkz+IlC9bpc2oTt9ZRa4ccbffNyeFUirrDUMN6eLlrgwadrXzKmDe8PU2ST4d
 HoKeOYeWGGin6y00rPe/Yarr2sOi3UZO16/4v69vvFz3a2NfH+KRafgaCrvGP1u15vrw
 VKY7Ws1dRU6ZX8TwqopMdQRhaPsN/eIJxGFa2n2adQRnI5bxsYKkXSxW2xlWfpsLtN2Q
 kpd+Flxes8wJWKhlLN+w3jmca3KQFIoJ1YbDgVdpKzUpgYGCM6cYtAsBpgcimfiRPZ4Z
 f/CfeCuBbhX3m3UkjwxBM7eL1TNvgzHrvLVj2uGrzrxcdDtTS65P1qeK2a582lxf8YF3
 +Swg==
X-Gm-Message-State: AOJu0Ywb1zqf/QnfQA6p/egQI7FwEQWE2w3sQgH5STh5vP8F4D6ErSI8
 ZJtSN3WXD4718+zEHWPwdkJMDlSF50HIGIJHx4Ro8Q==
X-Google-Smtp-Source: AGHT+IFIIr9UsluXd/u4U1Cx2ogoqQxTaybfM180BL3GK52LEyIV2Rn0O0DZ6klXMtBX226LbPLR2XTa2k5QTjEvfp0=
X-Received: by 2002:a19:6756:0:b0:500:b88c:ea79 with SMTP id
 e22-20020a196756000000b00500b88cea79mr8080942lfj.54.1695728268069; Tue, 26
 Sep 2023 04:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230921015730.1511373-1-sjg@chromium.org>
 <20230921015730.1511373-31-sjg@chromium.org>
 <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ=-MvO5rPwmnGTbjyaqTv+VzXNq2mXmP+Az3FKaQ_Jyg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Sep 2023 05:37:36 -0600
Message-ID: <CAPnjgZ3yAYQ7V=n-4MyPiaB_JU7_wre9xOHg5K0L22a4gYBenA@mail.gmail.com>
Subject: Re: [PATCH v2 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Mon, 25 Sept 2023 at 13:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> I commented on the v1 thread, but let's continue the discussion here
>
> On Thu, 21 Sept 2023 at 04:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - No changes as it still seems unclear what should be done
> >
>
> [...]
>
> >
> >         /* BLOBLISTT_VENDOR_AREA */
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> > index cbb65c9b177f..56e00090166f 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> >  devicetree at runtime, for example if an earlier bootloader stage creates
> >  it and passes it to U-Boot.
> >
> > +If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
> > +from a previous stage.
>
> What I argued before is that we don't need to be this explicit.
> The bloblist can carry a bunch of options that might be used by
> U-Boot.  It would be better if we had a more generic approach instead
> of adding Kconfig options per bloblist entry

Yes, fair enough. It would really get out of hand if we had a lot of
Kconfig options for everything that could be in a bloblist.

I believe someone objected to this in the other thread, so there may
be board-specific issues to resolve.

>
> [...]
>
> >  #ifndef USE_HOSTCC
> > +
> > +#define LOG_CATEGORY   LOGC_DT
> > +
> >  #include <common.h>
> > +#include <bloblist.h>
> >  #include <boot_fit.h>
> >  #include <display_options.h>
> >  #include <dm.h>
> > @@ -87,6 +91,7 @@ static const char *const fdt_src_name[] = {
> >         [FDTSRC_BOARD] = "board",
> >         [FDTSRC_EMBED] = "embed",
> >         [FDTSRC_ENV] = "env",
> > +       [FDTSRC_BLOBLIST] = "bloblist",
> >  };
> >
> >  const char *fdtdec_get_srcname(void)
> > @@ -1666,20 +1671,35 @@ int fdtdec_setup(void)
> >         int ret;
> >
> >         /* The devicetree is typically appended to U-Boot */
> > -       if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> > -               gd->fdt_blob = fdt_find_separate();
> > -               gd->fdt_src = FDTSRC_SEPARATE;
> > -       } else { /* embed dtb in ELF file for testing / development */
> > -               gd->fdt_blob = dtb_dt_embedded();
> > -               gd->fdt_src = FDTSRC_EMBED;
> > -       }
> > -
> > -       /* Allow the board to override the fdt address. */
> > -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > -               gd->fdt_blob = board_fdt_blob_setup(&ret);
> > +       if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
> > +               ret = bloblist_maybe_init();
> >                 if (ret)
> >                         return ret;
> > -               gd->fdt_src = FDTSRC_BOARD;
>
> So, instead of adding OF_BLOBLIST, just move this code under OF_BOARD,
> inside an IS_ENABLED(BLOBLIST) check. If a bloblist is required and
> the previous stage loader is supposed to provide a DT we can just
> throw an error and stop booting

This is the bit I don't get.

The OF_BOARD thing is a hack, in that the board can do what it likes.
It is our way of handling board-specific mechanisms.

But I am wanting a standard mechanism, i.e. like 'standard passage', a
way of passing the DT through the phases.

If I put this under OF_BOARD, then the board gets to override the
mechanism, so which is it?

You say 'we can just throw and error' but what is the error? If the DT
is provided via the bloblist, there is no error. If it is not, I
already show an error and halt as you can see in the code below.

I guess I'm just confused about what you are saying here.

>
>
> > +               gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > +               if (!gd->fdt_blob) {
> > +                       printf("Not FDT found in bloblist\n");
> > +                       bloblist_show_list();
> > +                       return -ENOENT;
> > +               }
>
> [...]
>
> Regards
> /Ilias

Regards,
Simon
