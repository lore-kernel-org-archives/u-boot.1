Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3794FC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30B280805;
	Sun,  9 Feb 2025 15:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nvjpudy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EA8807D7; Sun,  9 Feb 2025 15:27:32 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF9180141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso53366035ad.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111249; x=1739716049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKpJ9Vt8ZV3GiT/GgxLoVZXxzxHbTjEQUe2gkww0iOI=;
 b=nvjpudy8zwDKpJOVygZcfG00f/xO17W+7bF7V+eDR1V/eIGSIxKZ+RnNOSHWoJfGzu
 VRg4a9Ti3/fhl+C1UxIQ6sCKFX+IBvW3HSODdEC9mlc1z+aXx8/w6JXxpMXupvCchGWL
 O83EDBQhGhTqvW8pi9ePORRqNJG0RgUdiCWX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111249; x=1739716049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKpJ9Vt8ZV3GiT/GgxLoVZXxzxHbTjEQUe2gkww0iOI=;
 b=fnqU3tiRtcPtyBPJTyxcyDxN+hfnIAXysEI3Yr0SGrBrKwl182BK2la+FbxqxxBbzc
 RLVLrkMRJYKvDJ/q31cc6Z1PPAbna2EDD2dzDiB37mkJdXhPrz8Ux4eu6Gn5zTeAga5O
 7Ta245Qtzrj+7EuEsEVjyV6JgcPhqYgDAchU+NPdw5rOF7lzHX7Iwop/opmdl3JjL8z1
 c/tXvxvKQtDbV8pYbsc4JwvuAQ42UtA1WtbC4H5VUQT9H75Ne/N5TfuMOw4hR80wUihR
 N87wisZ4IpjRS3Ogmpk1zpWcoKIpR9VesNFSD+GQDmS3E1O3kVVn6+eHkA5j63QiXzMn
 iryA==
X-Gm-Message-State: AOJu0YyWafNAYsEuOEXE5NhjUYJTscnj+jpWr3I+kFSflI+zTsPKTT8l
 XzpH6kzG2EdLY6Dy7P6HTnCo6Vrp9EeH4Q7+9T7H2XdrDzMwtbGfKkp5lqIlkeBGVoeV3dB0Lvb
 cHSx8O1ASgOf9RsNtBBpY2WIPkssSw/zKvxUP
X-Gm-Gg: ASbGncvaTxsJr18nCmkg+YJNVfRnV18W/cGXkCbYkFpHcc4+p5puQPWLnj+FdvcY7BZ
 M8eysO5lsZbY6sjisjYQ/tDELuRRl7B4eZnPIuKR7sE2oZdfmbC2bZKrLl0DYIuxxJCJA2Ifujg
 ==
X-Google-Smtp-Source: AGHT+IHDp9jTWG3KZn3+8vpAZiJ3M2gJliKBOjPwahIt1XXZOkxFpAvVtoMvZVx/4k7DO7vdu8SOKuabgftA2V3mn9I=
X-Received: by 2002:a17:903:46c6:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-21f4e1cb92fmr149291825ad.11.1739111249146; Sun, 09 Feb 2025
 06:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-15-sjg@chromium.org>
 <39c87a74-3fe0-475c-a98f-fda1181d6e00@kwiboo.se>
In-Reply-To: <39c87a74-3fe0-475c-a98f-fda1181d6e00@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:27:13 -0700
X-Gm-Features: AWEUYZklRkUp8RW8irChmHkLD8mBfzomDP0ldQdCbw_jfJsc17-MjlNEsKR1jN4
Message-ID: <CAFLszTg-zSqrU69t5GYSz0Dix834H0RcNO6Q0fr+0K2o2T+pZg@mail.gmail.com>
Subject: Re: [PATCH 14/29] rockchip: Add SPL into the main FIT
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

On Sat, 8 Feb 2025 at 18:36, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:55, Simon Glass wrote:
> > VBE may want to load the SPL image from the same FIT as contains U-Boot,
> > if there is enough memory, so add it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/dts/rockchip-u-boot.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> > index 7cce213c32e..39908495894 100644
> > --- a/arch/arm/dts/rockchip-u-boot.dtsi
> > +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> > @@ -72,6 +72,25 @@
> >               fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> >               fit,align = <512>;
> >               images {
> > +#ifdef CONFIG_VPL
>
> Is VPL intended to be exclusive to VBE? This (and others) should
> possible test for another Kconfig symbol?

For now, yes. In the unlikely event that EFI adopts earlier update, we
could look at what else to do.

>
> > +                     spl {
> > +                             description = "U-Boot SPL";
> > +                             type = "firmware";
> > +                             os = "u-boot";
> > +                             arch = ARCH;
> > +                             compression = "lz4";
> > +                             load = <CONFIG_SPL_TEXT_BASE>;
> > +                             entry = <CONFIG_SPL_TEXT_BASE>;
> > +                             phase = "spl";
> > +                             section {
> > +                                     compress = "lz4";
> > +                                     u-boot-spl-nodtb {
> > +                                     };
> > +                                     u-boot-spl-bss-pad {
> > +                                     };
> > +                             };
> > +                     };
>
> Is this spl part really used for anything? Later you are adding a spl
> template and using that for other vbe parts, it is not clear for what or
> when this is intended to be used.

No, it isn't used, but only due to SRAM-size limitations. I suspect
with the RK3288 we can use it. I left it in so that it is clear that
the phase selected by the code, not which FIT is loaded.

>
> Regards,
> Jonas
>
> > +#endif /* VPL */
> >                       u-boot {
> >                               description = "U-Boot";
> >                               type = "standalone";
> > @@ -172,7 +191,11 @@
> >                               description = "NAME.dtb";
> >                               fdt = "fdt-SEQ";
> >  #ifdef CONFIG_ARM64
> > +# ifdef CONFIG_VPL
> > +                             fit,firmware = "atf-1", "u-boot", "spl";
> > +# else
> >                               fit,firmware = "atf-1", "u-boot";
> > +# endif
> >  #else
> >                               fit,firmware = "op-tee", "u-boot";
> >  #endif
>

Regards,
Simon
