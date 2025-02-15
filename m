Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF16C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0941E80C83;
	Sat, 15 Feb 2025 13:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M8TdljrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D510D80C98; Sat, 15 Feb 2025 13:13:27 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B949680C6F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abb81285d33so32531966b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621605; x=1740226405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bx6kt1XG9mQo6sg8QPCVsHJG4OeLH/iLZI9twJx8Xeo=;
 b=M8TdljrZOZgjJ045+QJSXD0PRRqnC/aMlLdQCYR0awajJz6D5vMQDcl+R7WiGgKlMP
 0f+RP8o1lA3ubB+G6/IkkTRIvOl7lyrz8XV1Gqgxm49who1sRn2ZVFHjFHekZYaYRzAN
 nIpvDNcxbeaQEA9otPNrnGUtpCeRDtadwX+QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621605; x=1740226405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bx6kt1XG9mQo6sg8QPCVsHJG4OeLH/iLZI9twJx8Xeo=;
 b=A+hV+BIIQIXRs3JsrrQsjqviYOtjmUUyM0rX14uf/XtvDz1XMuMavBodkO/+gIENZK
 sM3vhd67D1UW5YbrRilefOyDpKmcSZwlFJLPU7HrF8OCmZkd5prf1DSReLZYoc9FoVui
 5zmYykxItoylMMgiwGKsGvIdkqpZWPUrDqzdQ/cHMkB3qsTALOuoDFKmUzkV6OMd7Xw0
 T3bivCETGerrlcixT+AVir8gbAR9QFtl07RZaEb6hD29oA0wiHC9vebvwu4c87rQBjqO
 MaFd+BRV2//HcSkYHRmjomvXnmeAHydhH3XzThlUl+H8DyjpQHqC20GFJOYk/Nt6ZXt6
 w1Bw==
X-Gm-Message-State: AOJu0YxfFAzZ26TXRB8Gf4RFpliIKKjalLBDKmvjIJbySwxRyU50ywLP
 WeDKn3pF98jlpiPDebXdg0Go8T7zDXTcOmNvBwByKeAda3i/5lf+NejF54WboA3Jf4LOdZLOCsn
 CJSE7NNj9+qJuerFYlPyWPCtzKjitT3FfCTWM
X-Gm-Gg: ASbGnctsznWzhd/4zAvBGeES78G+fKWCrqokRsrSr1GDOFd6UKDGHO2mBa16FZUVVNS
 JsGv1Md46OGKY620LW8Zkr8udZBbnDTROptA8JJH0YA5FvEeZhgwtpmk66j3MMSXp97XSvOvgHw
 ==
X-Google-Smtp-Source: AGHT+IEKYF8TjdrJ6jqhemoHBTpFocfV47vD31MEU9uA7+nIX+H9Z4Q+JuV688RsRX08EZG8biblUE7MDpUTCa0u58s=
X-Received: by 2002:a17:907:1ca1:b0:aa6:6885:e2fa with SMTP id
 a640c23a62f3a-abb70b2087dmr243699266b.14.1739621605138; Sat, 15 Feb 2025
 04:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-13-sjg@chromium.org>
 <1c308da8-2fa5-494f-b175-c8519e5480fb@kwiboo.se>
In-Reply-To: <1c308da8-2fa5-494f-b175-c8519e5480fb@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:13:13 -0700
X-Gm-Features: AWEUYZmeE08srxVfRT9Ku4J4DIwojZBml3wrFyQf5GW6uwQXVCmI0KCOfvp28Hg
Message-ID: <CAFLszThPLtACtxjKYuimaxLTY4nm6qGzD+8d42LyDUs95jxfDw@mail.gmail.com>
Subject: Re: [PATCH v2 12/35] rockchip: dts: Create a template for the FIT
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Mon, 10 Feb 2025 at 14:52, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > Move the FIT description into a template so that it can (later) be used
> > in multiple places in the image.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 57 ++++++++++++++++++-------------
> >  1 file changed, 34 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 64a6b57d5fd..ca666ba0cd4 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -19,6 +19,10 @@
> >  #define COMP "none"
> >  #endif
> >
> > +#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
> > +#define HAS_FIT
> > +#endif
> > +
> >  / {
> >       binman: binman {
> >               multiple-images;
> > @@ -27,28 +31,9 @@
> >
> >  #ifdef CONFIG_SPL
> >  &binman {
> > -     simple-bin {
> > -             filename = "u-boot-rockchip.bin";
> > -             pad-byte = <0xff>;
> > -
> > -             mkimage {
> > -                     filename = "idbloader.img";
> > -                     args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > -                     multiple-data-files;
> > -
> > -#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> > -                     rockchip-tpl {
> > -                     };
> > -#elif defined(CONFIG_TPL)
> > -                     u-boot-tpl {
> > -                     };
> > -#endif
> > -                     u-boot-spl {
> > -                     };
> > -             };
> > -
> > -#if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE))
> > -             fit: fit {
> > +#ifdef HAS_FIT
> > +     common_part: template-1 {
> > +                     type = "fit";
> >  #ifdef CONFIG_ARM64
> >                       description = "FIT image for U-Boot with bl31 (TF-A)";
> >  #else
> > @@ -59,7 +44,6 @@
> >                       filename = "u-boot.itb";
>
> Please move the filename prop to the fit node in this patch.
>
> There are lots of guides and Linux image building scripts that depend on
> the u-boot.itb file, so we should continue to keep this file to be
> backward compatible for a few more releases.
>
> >                       fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> >                       fit,align = <512>;
> > -                     offset = <CONFIG_SPL_PAD_TO>;
> >                       images {
> >                               u-boot {
> >                                       description = "U-Boot";
> > @@ -164,6 +148,33 @@
> >                                       fit,loadables;
> >                               };
> >                       };
> > +     };
> > +#endif /* HAS_FIT */
> > +
> > +     simple-bin {
> > +             filename = "u-boot-rockchip.bin";
> > +             pad-byte = <0xff>;
> > +
> > +             mkimage {
> > +                     filename = "idbloader.img";
> > +                     args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > +                     multiple-data-files;
> > +
> > +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> > +                     rockchip-tpl {
> > +                     };
> > +#elif defined(CONFIG_TPL)
> > +                     u-boot-tpl {
> > +                     };
> > +#endif
> > +                     u-boot-spl {
> > +                     };
> > +             };
> > +
> > +#ifdef HAS_FIT
> > +             fit {
> > +                     offset = <CONFIG_SPL_PAD_TO>;
> > +                     insert-template = <&common_part>;
> >               };
> >  #else
> >               u-boot-img {
>
> There is one more fit node in simple-bin-spi that should change to use
> #ifdef HAS_FIT. Also for consistency with fit/u-boot-img node in
> simple-bin-spi I recommend we move the #else/#endif to not include the
> offset and closing bracket.
>
> I suggest something like the following fixup to be included in this patch:
>
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c3013e75ed10..460bf15e0032 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -41,7 +41,6 @@
>  #endif
>                         #address-cells = <1>;
>                         fit,fdt-list = "of-list";
> -                       filename = "u-boot.itb";
>                         fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
>                         fit,align = <512>;
>                         images {
> @@ -173,14 +172,13 @@
>
>  #ifdef HAS_FIT
>                 fit {
> -                       offset = <CONFIG_SPL_PAD_TO>;
> +                       filename = "u-boot.itb";
>                         insert-template = <&common_part>;
> -               };
>  #else
>                 u-boot-img {
> +#endif
>                         offset = <CONFIG_SPL_PAD_TO>;
>                 };
> -#endif
>
>                 fdtmap {
>                 };
> @@ -207,7 +205,7 @@
>                         };
>                 };
>
> -#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
> +#ifdef HAS_FIT
>                 fit {
>                         type = "blob";
>                         filename = "u-boot.itb";
>
>
> With something like that applied this is:

Thanks for the patch, that helped me figure out what you wanted with
the braces. I have tended to avoid #ifdef around open braces, but I
agree it seems easier this way in this case.

>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Simon
