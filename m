Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F74CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EB584BAC;
	Thu,  7 May 2026 18:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ibag8Tt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A788584BBE; Thu,  7 May 2026 18:50:01 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957D784B02
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba6838e76f2so135968366b.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172599; cv=none;
 d=google.com; s=arc-20240605;
 b=VXfGRYihZUbMIeSlH1jKHAixa1UJrA8K2daIfyUa3Rd/CfR0ALEvhOk07xsRGi1MQ+
 D/5U6hCE9N/zMwG58B2OEvLPcKKpQc9Qd7Q2MfuyxFAg90Y1eUAzBzrtlWz8O3uCcEL3
 /CwIHJlX/qvNtvxHbbmmbyvTzCz/JoxjawYlm3z0pzACdWvvxOq4JY0LeEkrtdyGanK7
 oL8ywSlMpPTJOq4OlBpIDVgwEmvqnbUvl+snZ/buLyXFovPobRvNfJGoOVTb6hT1zzKE
 fZ7vheE8o5MK0GbRVEfzUWpAzVFW56PiD0q8IhykTRjcftBqW+zRihROaa0zJ5lTkvWf
 L9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A/NCYfHES1ZdmjvcJIYAKvOfAqsth/OfLCGvkm1jx28=;
 fh=EbGWCKFZJCliM95ZoiFBcyO2r4EsOdMnPJFtFtwgKiM=;
 b=CCx+Nq25jjIVrBRgH/hu8YBQti3NRDG6OQJBaydbd5rwrgBucdzn4l4Q0dLjTDpaxG
 pRxxGVrMocac5XRwZhgxxZiVGFykHZcpASix5UXdft9XMnxRJ4zJpRWYtFpkguwnsP+R
 2otV5NDwGZ67C6k8GoVOYjeFFht1u/cWPSVx8S89JL5VAa1Vv2UeX2T9krzXxhRChw8T
 2liq8HD6b/9aeOKUax/XdvSeMz7jSxCb09v+33ymxJKMd1VOOdSwMCKXjfiGAl0KFqM6
 FleVrrPipQuFOR+qr/uigwCxgJUVlnnZWsA9IOO7X2QtiA67eJFDznYgGbjsDUeqHI7G
 2baw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778172599; x=1778777399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A/NCYfHES1ZdmjvcJIYAKvOfAqsth/OfLCGvkm1jx28=;
 b=Ibag8Tt6Hn9CxIOHSAK5yOrb0qdIMo4M+4xiw20erWYhP7lO4HXbKWyAVpPXfvdpYJ
 bdKCrJOSk0AMaspnsblUkL+KsmGB57gj44vXVVhojzPdB9POazCLqpPxP6oTuC1/rwMj
 eRxd4O7A0vC5iQz372KGaoDnJXh5nwDAenCu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172599; x=1778777399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/NCYfHES1ZdmjvcJIYAKvOfAqsth/OfLCGvkm1jx28=;
 b=pNJ754jOV7UF1DuMdIKyyibDSDI6h2D0TThgdY3zcKekDkstCWHpdeOBlmenwv9/Wo
 0LDiPN8Cuxag+NqegOdiOXjLQj6YwKUMwt5W+FSesGTILNK6XAismzZT5BQxkrO/jMJY
 ViO3X3HQr6Cb6ftU4EGBCVE+VPIN5XDONXBkYhXIBnz9CUj2DMiyIAvvUWnSGLIFNO2D
 cw06pNStYoRryIYFflxn3rHcVIehfOKEPh0sxTYELsqg7MtIJHSbFZrhU1oaqnsXPRz/
 H9J3sQQc4LRBg3f8sgvY092mmrmBZxKrHoJSzeIBnE7ZrRfifAxPMLu93jOzNVTXpYaF
 x/Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vr0rPlFtfoaxXnxjrFTScuyQ2MgmFhYiaIJ7V7gwYJh+WukA6Rs1LZcn+YkY3pYRCT2cJ4bg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyl0IIxwBGqw0pwxowXCcVe2+Z317k34Jxuh1u3zJ/FwezwD/1i
 8pqK527FR8UwXmUsW2voMOUBaL8OF28likD7SbhqDy8+6boj4h55c+z3FhOLzOAuaCLv2rvXwvF
 DqGP2J+W1zE+amEqP3o/DWJJATIozgCX8ZN4aJzSq
X-Gm-Gg: AeBDieuyaVj6YWZbWtN42tVSgpJMZxR9EMI+IYdCYvFL4fw8NNJhVyU49/18TOraV9/
 v0CiRstAzND2cifRn6YRDrP4jIAzPRz1gFbHThHXK1UWnVgmlReFm5HDsLCRwG1WJ2BiruVgfFO
 QsHVcpb+OSWXTGPmXio4zYAc8szLlC98RjeDYaPCVipz4a9vlwXlRLZoZY5PUX/hxqCmikI1die
 vTJklqRe1qb5LgiPlZr/O4Z6nhOf7DZt4Rv93SP2ISYPwkfKubapPL31iemmYdUB4751ySjJuwn
 4BOLRw==
X-Received: by 2002:a17:907:a80d:b0:bc6:78fc:c77a with SMTP id
 a640c23a62f3a-bc678fcd82amr389242466b.22.1778172598715; Thu, 07 May 2026
 09:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-6-lukas.schmid@netcube.li>
 <553ba73c-8a90-44e3-9809-185b0fdfd2ce@cherry.de>
In-Reply-To: <553ba73c-8a90-44e3-9809-185b0fdfd2ce@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:49:45 -0600
X-Gm-Features: AVHnY4LKx9v4vKSGHd3m6KMiIjb8a1kCxZ0uORVUcf1gx_ZALWJXnALV8UFeToM
Message-ID: <CAFLszTjwdY_+17qWouSMq9Bh2N1UJ6_Sq-JP7huwA5Y-YKb9zQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] sunxi: extend binman FIT description for signed
 SPL images
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>, 
 Tom Rini <trini@konsulko.com>, Hans de Goede <hdegoede@redhat.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
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

Hi Lukas, Quentin,

On Thu, 7 May 2026 at 05:30, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Lukas,
>
> On 5/1/26 12:33 AM, Lukas Schmid wrote:
> > Extend the sunxi binman/FIT description to support signed SPL FIT
> > images. Add an SPL public-key DTB image, per-image hash nodes,
> > fit,sign support, and a configuration signature that covers
> > firmware, loadables and the selected FDT.
> >
> > Handle TOC0 SPL output as well by adding the required filename and
> > mkimage wrapping so the generated sunxi image remains verifiable.
> >
>
> I sympathize with the effort as I'd like something similar on Rockchip
> but I don't think this is right.
>
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > ---
> >   arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
> >   1 file changed, 64 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
> > index e1a9a7f5d4c..313fcad3922 100644
> > --- a/arch/arm/dts/sunxi-u-boot.dtsi
> > +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> > @@ -27,6 +27,38 @@
> >   #endif
> >
> >   &binman {
> > +#ifdef CONFIG_SPL_FIT_SIGNATURE
> > +     spl {
> > +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> > +             filename = "spl/u-boot-spl.bin";
> > +#else
> > +             filename = "spl/sunxi-spl.bin";
> > +#endif
> > +
> > +             u-boot-spl-nodtb {
> > +             };
> > +
>
> You're missing
>
> #if !IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)
>                          u-boot-spl-bss-pad {
>                          };
> #endif /* !CONFIG_SPL_SEPARATE_BSS */
>
> here.
>
>
> > +             u-boot-spl-pubkey-dtb {
> > +                     algo = "sha256,rsa2048";
> > +                     required = "conf";
> > +                     key-name-hint = "dev";
> > +             };
>
> You're forcing the use of an RSA2048 key which is not recommended
> nowadays anymore as far as I know. RSA4096 is "better" when using RSA.
>
> This also forces the user to have a dev.crt certificate to be able to
> build the image. It's not a secret or sensitive info so I guess that's fine.
>
> > +     };
> > +
> > +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> > +     image {
> > +             filename = "spl/sunxi-spl.bin";
> > +
> > +             mkimage {
> > +                     args = "-a 0x20060 -T sunxi_toc0";
> > +                     data-to-imagename;
> > +
> > +                     u-boot-spl {
> > +                     };
> > +             };
> > +     };
> > +#endif
> > +#endif
> >       u-boot-sunxi-with-spl {
> >               filename = "u-boot-sunxi-with-spl.bin";
> >               pad-byte = <0xff>;
> > @@ -45,6 +77,9 @@
> >                       description = "Configuration to load U-Boot and firmware";
> >                       #address-cells = <1>;
> >                       fit,fdt-list = "of-list";
> > +#ifdef CONFIG_SPL_FIT_SIGNATURE
> > +                     fit,sign;
> > +#endif
> >
>
> This requires the user to sign as part of building U-Boot and therefore
> have access to the private key. Some users may want to sign separately
> from their U-Boot building step such that building can be done anywhere
> but signing is only done on specific infrastructure.

I wonder if binman could help here, perhaps by providing an option
(for CI) to skip signing if the file is missing?

>
> This also doesn't allow the user to use OpenSSL engines for signing (yes
> engines are deprecated and replaced by providers, but the same likely
> apply for providers once we'll support that).
>
> You definitely need to document this somewhere, likely in
> doc/board/allwinner?
>
> I'll try to keep an eye on this and see if there's something we can take
> for Rockchip as well :) But I don't know how to do this nicely and make
> it "safer" to set up FIT signature verification for devices and avoid
> common pitfalls or misconfigurations while still allowing out-of-build
> signing and configuration of keys.

Regards,
Simon
