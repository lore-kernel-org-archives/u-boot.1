Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C54C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9744280C6F;
	Sat, 15 Feb 2025 13:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yy0lf2E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51D580C83; Sat, 15 Feb 2025 13:17:23 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7A580B98
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5de4d3bbc76so4718324a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621841; x=1740226641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E8B/kO/V1JrR6OKi5TzLGPxmu3xFeEMz6yQxGlQIB+U=;
 b=Yy0lf2E/xT/a7pJTjj5Tcx+4c8PB6d5JLSEFSfaoqiXPxljmYnQljEXTp3ALOw9L/k
 GE3qXsb3ho4j6GgyNIht4JzpUDCEjZ5ahF7ISSG+TR/Y6oYGVJx0aQa6+lZAV08RfdVy
 xignfvWmPXKJwY/Y5oNocw6FXsBRjRqAJn/AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621841; x=1740226641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E8B/kO/V1JrR6OKi5TzLGPxmu3xFeEMz6yQxGlQIB+U=;
 b=ArLqEMEKO9q4Ca9gmvCxxjWnyWDgksbbdfhILmJtdAYVAFdaXmykjdbMuHWN34hhve
 hCmimNTIZtCMMmhpfOqcx5s52fE/WPBJfsxM1SnynYSI/GSOeDboAQ1RI2q4Gdx/shJp
 r/b8/mzs3es6zA1bDrsVnrmDdhHZkMMH9EVOUSlYXOqRjt7NRKOTmxB9BwkuJhppyj4C
 sHdkCvJUA1TZTZ5mymRZKW0qwlUR88g8hXUAKp+EQhn8UPVztRL2pcmUELkq81Wlnr4L
 eIMZx2+zFHfbSQWtbET/zNszfcaeOx5MZpcVtiw3oYWIT3IvrFRjLDRA9Nmupl42AXO/
 607A==
X-Gm-Message-State: AOJu0YwiRHl52zYZbhI+xtCVNe8SVu25MV+LBwV3m6kInmpJhbT2rnnb
 vJOb0kj162WdS2sYQMjp4j666v1VT1GovgnyoHcUbX+O5/fKNQCdBW3l4CRbcIgdEFG5vX4eUug
 r7khS7UxxOShloxPhlOs7d4whqQeNBVJJFhOc
X-Gm-Gg: ASbGncsH1PwHZmLWaKMSKk5TCeU+jMGJFoHLTUWHbu2+qRdJ6oXycjUw2lrDe9ffN94
 3ZrprswZGZKlliyIVUnvl5XiNp2XPaZrHMSBEd7vBH6oYSkXab8c9gC+bBZRZD5QwEFragbNPyg
 ==
X-Google-Smtp-Source: AGHT+IH5vd6eb7tknMDfCESJ4zWQ6ysIIfsxwlTwauVIIv1FM8XmP+cCkKx9gd7fQ4iCcW5uZ2DttSYuR43yxkQ470A=
X-Received: by 2002:a17:907:784b:b0:aab:d7ef:d44 with SMTP id
 a640c23a62f3a-abb70bcb911mr217719966b.24.1739621839143; Sat, 15 Feb 2025
 04:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-15-sjg@chromium.org>
 <020e69f7-4428-4bcd-8a78-4af819d5d0fe@kwiboo.se>
In-Reply-To: <020e69f7-4428-4bcd-8a78-4af819d5d0fe@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:17:07 -0700
X-Gm-Features: AWEUYZnzCucjJ9QjCtJUVr9hy5ACPnBcDMfljKHGia6YoBpv6JBb_lQu_IM4Iek
Message-ID: <CAFLszTi0p4wfB+m91KGjdSTLbZjAHJ+54rw5jQdLMAUYU__tNA@mail.gmail.com>
Subject: Re: [PATCH v2 14/35] rockchip: dts: Use the new binman template for
 the SPI image too
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, FUKAUMI Naoki <naoki@radxa.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
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

On Mon, 10 Feb 2025 at 15:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > At present simple-bin-spi relies on the u-boot.itb file created by the
> > simple-bin image. Use the template to avoid this, since Binman may
> > change to process images in parallel in the future.
> >
> > Drop the filename to prevent another image being created which uses the
> > u-boot.itb file.
>
> As mentioned in "rockchip: dts: Create a template for the FIT",
> we should keep the u-boot.itb file a few more releases.
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 281119a53d3..79f4188b76b 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -41,7 +41,6 @@
> >  #endif
> >               #address-cells = <1>;
> >               fit,fdt-list = "of-list";
> > -             filename = "u-boot.itb";
> >               fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> >               fit,align = <512>;
> >               images {
> > @@ -208,8 +207,7 @@
> >
> >  #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>
> As mentioned in "rockchip: dts: Create a template for the FIT", this
> should be changed to "#ifdef HAS_FIT".
>
> >               fit {
> > -                     type = "blob";
> > -                     filename = "u-boot.itb";
> > +                     insert-template = <&common_part>;
> >  #else
> >               u-boot-img {
> >  #endif
>
> Please also update u-boot.rom in rk3399-u-boot.dtsi to use this template.
>
> With that included this is,
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
>
> I also strongly recommend you break out following rockchip-u-boot.dtsi
> related patches into its own separate series:
> - rockchip: dts: Correct the OS for U-Boot
> - rockchip: dts: Factor out arch and compression
> - rockchip: dts: Add an fdtmap
> - rockchip: dts: Create a template for the FIT
> - rockchip: dts: Un-indent the FIT template
> - rockchip: dts: Use the new binman template for the SPI image too
>
> Those patches stand on their own and help solve the "Entry 'u-boot-any'
> not found in list"-issue in "rockchip: Fix binman error" [1].

I'm pleased that this has some potential use outside of VBE. But this
is the final VBE series and I really want VBE to work on a real board
once this is applied. If you like, you could apply these patches
separately, but your comments on the whole series have been very
helpful.

>
> [1] https://patchwork.ozlabs.org/patch/2040246/

Regards,
Simon
