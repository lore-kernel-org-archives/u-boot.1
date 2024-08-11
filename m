Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F534C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A945C88453;
	Sun, 11 Aug 2024 16:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LMumhGN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3A387E9D; Sun, 11 Aug 2024 16:50:24 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AE788852
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d5ed6f51cfso2406869eaf.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387820; x=1723992620; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AuWnGY8gVgg0r+yzTE7FFfs7E+9RpdJft3DvUdzddr0=;
 b=LMumhGN8I62g59YXABbthMTnPkTn9LoqMRi7pZNNC1WE6J+UAvsbsj39sFM7HJkr4+
 Um67RFHmi2NXUSy/cuTe7Ymh2csag5sZuaCbyisYz9zt5p6V43p/FKndjbOlovF/aijN
 yiQIQ9L0xh5CM7XyZjq33xBIFLI7Bwe9Z+PqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387820; x=1723992620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AuWnGY8gVgg0r+yzTE7FFfs7E+9RpdJft3DvUdzddr0=;
 b=jVTtPDsE1hhcmFrV/u2Hiocjh8+7DHOmqHIDgXvejpr4IlA3pYyKuj2s4mdxLZDj2v
 QsHdOKUi4BgH+vhH03vxCphyn1oeHMCaTWDLnNYzqTwWDm7RjKop65mHQqcGBhtsxoKl
 Fk8FOnZtrGvt355cD7bcQSm/RU+8dwPPENIm15v52UZcAEEwxip2hbZ0GCdM/BhNDCOK
 gYJ8Vye43TwZAmTe+ZpL9oyy+jpgGSuQCoVarEaQZSufWamGXDjHOp6Z86zo/YUP6M3+
 FUfUIaVZNZ2zF0y3ozBhwQNCMhOb5L5wp1dwqLZcoSv5JK8tZvqrr3rXbY/xwkkydvO8
 v3xw==
X-Gm-Message-State: AOJu0Yw/0A4O0d/D9uyH+tPmMUzjEHhp32OZ6a0ScGQcdQ+y2GgUtTgh
 LQqAJFwqoQZwLGxhIpE09oKPcPUJmDrcCEusEsg4GBEJOs0dVtXTG/B+AjhbC3yrgAseModcGR7
 412XAcb64oY07IFewWRaiJtOQ5gRerlnzX52x
X-Google-Smtp-Source: AGHT+IGnnS5mQCRAYaZZ5gBIyQKDl3fU+r7rhDfb4lynLvnaV2ZXHhgixVJAkZXWppdCHVMy5vevke/W9kSa+VfJUeA=
X-Received: by 2002:a05:6359:459d:b0:1a5:4b74:2214 with SMTP id
 e5c5f4694b2df-1b176eeafbdmr1024071255d.3.1723387820470; Sun, 11 Aug 2024
 07:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-5-sjg@chromium.org>
 <f21f478b-87ef-4074-84f3-3738cac3dda1@cherry.de>
In-Reply-To: <f21f478b-87ef-4074-84f3-3738cac3dda1@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:09 -0600
Message-ID: <CAFLszTionmfwhxLXtHGiNKLNjPuTMHjDkhkMSRC3zcaC-RnhnQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] spl: Remove remaining #ifdef in
 spl_parse_image_header()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>
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

On Tue, 6 Aug 2024 at 07:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
> > in this function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Avoid changing comment
> >
> >   common/spl/spl.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 02567e766f1..30ff1e6f7d7 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -245,7 +245,6 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
> >       return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
> >   }
> >
> > -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
> >   void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
> >   {
> >       ulong u_boot_pos = spl_get_image_pos();
> > @@ -273,7 +272,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
> >       spl_image->os = IH_OS_U_BOOT;
> >       spl_image->name = "U-Boot";
> >   }
> > -#endif
>
> I assume this doesn't add too much to the SPL in terms of size?
> Otherwise we could just define an empty function when
> CONFIG_SPL_RAW_IMAGE_SUPPORT isn't defined to avoid bloating the SPL?
>
> >
> >   __weak int spl_parse_board_header(struct spl_image_info *spl_image,
> >                                 const struct spl_boot_device *bootdev,
> > @@ -357,16 +355,16 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
> >                                   sizeof(*header)))
> >               return 0;
> >
> > -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
> > +     if (IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT)) {
> >               /* Signature not found - assume u-boot.bin */
> >               debug("mkimage signature not found - ih_magic = %x\n",
> > -                     header->ih_magic);
> > +                   header->ih_magic);
> >               spl_set_header_raw_uboot(spl_image);
>
> We could return 0 here.......
>
> > -#else
> > +     } else {
>
> .... to avoid here the else whose last instruction is returning -EINVAL.

Sure, but then the function would be returning -EINVAL at the end. We
try to have functions end with success, with failure handled by its
returning early. That way we can read the 'normal' flow of the
function from top to bottom.

>
> In any case,
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin

Thanks for all your reviews.

Regards,
Simon
