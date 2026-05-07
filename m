Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936A2CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EF584B58;
	Thu,  7 May 2026 18:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DL1n2+n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565ED84B5D; Thu,  7 May 2026 18:49:33 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5873784B02
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bb962ce4dcfso165499566b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 09:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778172571; cv=none;
 d=google.com; s=arc-20240605;
 b=gTMIxlSNUhiWG/54wufc0sfXYBVqQ3sT7ddAx1WNcQFyMALoJ9Uo9jHPTD2rd5MXrB
 vIgIuwv8xmc6QMVaRL1AL1Q2X5A8qMyeKNnxvgUzQDCYSiYO3nciNaqX1s8potvZoaso
 tWqhXX65dp67amoGfJxsQNnQpOl5+nmBCftYp1SKcnBvEjT0Y0iplC9NHKlZxbe9KncZ
 ACsTWCgVugNVMYl/5/DQMlRVsR5BUJO0TWJzAWC2zhGezf8H7d5SSmK/Pk5HSH43TsM1
 Fuh4M/+F73OQH0HxLTg4IHKUsdNkXfa+w387T1BdAjFDBxiIkF5TtyYcNaNRv1zF0P43
 6mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CyJoH3vpLzXaDzsEWkkMZzRJvD+8U/bx0QSud5jChdA=;
 fh=bkTRm9uB1henLigdDZ6kqD2z2GhHB1q1akSmKeRAOJY=;
 b=g0keB2+d/YXekfnO5gS4GMDqNMe7qVBuZ/uWNBSr3lMs0cOUAvDWHnyLelqA5vz2H4
 CrR6WQRVXcH4ajYIW6vqDBBkb/U7RhbUzV2Y5gM8gK/QN6SNr0xhMI9kbZkCUyfHm0mn
 RRFBb93miTpbrizmpNwcVdpfGtldCQDRPmOgrwedxBNTLh29nmJu/m3Elf9MIJeHq8IH
 m3np671PpLJUDz0D1rv6Fe8oRnpmuu9iGcRtLAEAX0H3P+mFV65Otccub0wkBa/aiuaS
 ON6c4/Ujh5rxeYE6GDSsdu/Eb0CqX1NukxVDZ8Z+raCFSpvijNSH9FbbQQs9rxtNF1tW
 8AyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778172571; x=1778777371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CyJoH3vpLzXaDzsEWkkMZzRJvD+8U/bx0QSud5jChdA=;
 b=DL1n2+n7WYHjsC1a7u244qFtAMClsDbFe0GMVXMvFCPZXdijgrvN7Le3jpgAs3yCx6
 4Oc8cIuzQ6RJ/4NOPgCRScRZz0YE84SPD8fVPxoSj/rjxYGAvwMkhGx8ynyh18JuHcGI
 xZ8B3m+azPNcEncAHArdBX1qU1GVpKaprA6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172571; x=1778777371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyJoH3vpLzXaDzsEWkkMZzRJvD+8U/bx0QSud5jChdA=;
 b=OHCYyW9rJls9xn5eP/aO7L/1S48UrK7ebWqSPlHN9TkYQTX81NuOMHNvWkzfxmrN+l
 06+OQW+0IpWrQxXDL4hJUUUzqL2RgNovjpp2V0Ucc4uXGrPPTEKf7IEQgE8NfDzRLUkQ
 x4Lw2c3RgCTp80bo6c6/7i4Sn1dmo89pEUqsnb4aGOQpTKjC8jhsLU535r+ubpcAPXVf
 rvcs5zf1O6MonePz3+66cPVWo9/Y1L+eojxOn873ZHm0z0lN/5sYH+LHPgzNfxfUSW5R
 7HSIZLCZ6938sAg6lIyJzZVxxFv3CokxEq12iG3nQqZ3jeT9NAwiIyNcaSIpiEl+dR90
 gr2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jrR0Nf6xhBImuQ3ucRgkpkchArRQzXRABuvC9ROKXHfaQQ1Yp/ElgQgxNzYb0QOalpdO+39I=@lists.denx.de
X-Gm-Message-State: AOJu0YxPPIUDDr8ilmvI3GjczO6aXAqbDeHiSEkEoOYf4P8JxIWdD4jr
 uLBD2a8vBfQicnlVY0aYmQPspwflyH6tqYWTD8Fj6XAs+wZVtDUR0PidXY9FUSa0Ay/81qOEa1h
 6Xzw+BWCRCDlJUlGyKabiPwfOOfXnnji02inupfkhiBirBwqb2VHJvg==
X-Gm-Gg: AeBDievNPleToxNxLxHF8XeBSE95rdZJfOBqWNbZIIBAKj4fGpO2ESYDUDiTbFFg/9H
 Dxpd4XyKqotfZQmRtXOSEz2o4ICf9cGhw1JiV2Mn6rIOy8U/X0l3lA+n78q0k+jaKqSXQdaB0fE
 D/gq1nh4ERKeQ7oqgcmtzydMyI/Cuvl9/jwlX020FQyhb1iCUSs/1uqLL6kOj17Q497lOWthTEE
 efLBbHcr7XVgBHbNJZ3Ddxlcz5y6O6rhi2MJ10BkK5vlwGxUXO8W8dmC2/G9u8xMfK6g0rBsX/b
 vVR69g==
X-Received: by 2002:a17:907:1b1c:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bc56b028f46mr533250766b.10.1778172570579; Thu, 07 May 2026
 09:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-5-lukas.schmid@netcube.li>
 <f12da5bd-8bf5-4cca-9f20-0999ea36d025@cherry.de>
In-Reply-To: <f12da5bd-8bf5-4cca-9f20-0999ea36d025@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 10:49:17 -0600
X-Gm-Features: AVHnY4L8M5uEgo28pX_hsEcYrS0V4X1VJ8X_p5iNfv2HiJtIFNTN0m41if3TpYA
Message-ID: <CAFLszThTxu_9LEAZH8zgWjkHiddqV5MFewgUmNtm9NkxXDbG+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] boot: allow SPL FIT signature verification without
 DM
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

Hi Quentin,

On Thu, 7 May 2026 at 05:17, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Lukas,
>
> On 5/1/26 12:33 AM, Lukas Schmid wrote:
> > SPL FIT verification was effectively tied to Driver Model. The RSA
> > verifier assumed a DM-backed modexp device, and SPL_FIT_SIGNATURE
> > depended on SPL_DM. This prevents non-DM SPL platforms from using
> > FIT signature verification even though the software modular exponent
> > fallback is already available.
> >
> > Drop the hard SPL_DM dependency and only look up the modexp device
> > when DM is enabled. Non-DM SPL builds then fall back to the software
> > implementation and can enable signed FIT verification.
> >
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > ---
> >   boot/Kconfig         |  1 -
> >   lib/rsa/rsa-verify.c | 16 ++++++++++------
> >   2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 4e9bc9491a0..6ccb7d44a5e 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -202,7 +202,6 @@ config SPL_FIT_FULL_CHECK
> >
> >   config SPL_FIT_SIGNATURE
> >       bool "Enable signature verification of FIT firmware within SPL"
> > -     depends on SPL_DM
> >       depends on SPL_LOAD_FIT
> >       select FIT_SIGNATURE
> >       select SPL_FIT
> > diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
> > index 3169c3a6dd1..24b23ab565a 100644
> > --- a/lib/rsa/rsa-verify.c
> > +++ b/lib/rsa/rsa-verify.c
> > @@ -355,13 +355,17 @@ static int rsa_verify_key(struct image_sign_info *info,
> >       hash_len = checksum->checksum_len;
> >
> >   #if !defined(USE_HOSTCC)
> > -     ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
> > -     if (ret) {
> > -             printf("RSA: Can't find Modular Exp implementation\n");
> > -             return -EINVAL;
> > -     }
> > +     if (CONFIG_IS_ENABLED(DM)) {
> > +             ret = uclass_get_device(UCLASS_MOD_EXP, 0, &mod_exp_dev);
> > +             if (ret) {
> > +                     printf("RSA: Can't find Modular Exp implementation\n");
> > +                     return -EINVAL;
> > +             }
> >
> > -     ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
> > +             ret = rsa_mod_exp(mod_exp_dev, sig, sig_len, prop, buf);
> > +     } else {
> > +             ret = rsa_mod_exp_sw(sig, sig_len, prop, buf);
> > +     }
>
> Mmmmm I'm wondering if in the event we build with DM support but cannot
> find a modexp implem we shouldn't default to the software implem if
> available? Security-wise I'm not sure we're losing here, it's just that
> I'm assuming SW-based RSA verification is slower than HW-based no?
>
> Also, this function is only defined when CONFIG_RSA_SOFTWARE_EXP is
> enabled (and we don't have a toggle for xPL phases (should we?)), so we
> need to handle this here to avoid breaking builds.

Right

>
> Finally, I still see RSA_SOFTWARE_EXP depends on DM at the Kconfig
> level. So bringing this in SPL seems wrong, as we would depend on U-Boot
> proper having DM enabled for it to work in xPL. So either the dependency
> is incorrect or we're missing something in SPL. With a cursory look at
> it, it seems DM isn't required so maybe we can drop it.

Re DM, there is a UCLASS_MOD_EXP so we can support
hardware-accelerated verification.

Regards,
Simon
