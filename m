Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF3CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 23:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128E684659;
	Thu, 21 May 2026 01:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ia7rsRzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACE7846E7; Thu, 21 May 2026 01:04:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5139E8460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 01:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so1021606066b.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779318269; cv=none;
 d=google.com; s=arc-20240605;
 b=kzhFn9C02ZUvhdoRHa5C+/Uy0Xrcs5c9QAwCJv5Z7EsjAoNBqoddcYeOK1xXREtHWw
 6xVKuhSwRiEmVZ1Xm9rkOuv3gPf6wE0Wnp+qRqEMB93Eg4RGoVSF4o84AysEAS2T4rMW
 hkyyiw/4DhcQFNusZ+VcZAPtNU64uiWB0+6razJxRrq4fZ9zHsTidCmh9zBVqOJSyfR5
 piKaPuHtmx4X2SOifG//wmkUke5F1/qKI2NMfbwhLnLeaIBx4wC5z7t+vmiI3xY0W50o
 0CAPDMOIAKxiBAcE6K+PWdhkWys0mI1VGwsrlBOSHqaA9zFFLdo7jeNvkfvT1ngUDW+x
 UAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GkJHFWmZk25c6GQFZqu6jtvLltYvdSLEcrxyy4QFG+A=;
 fh=C2fdRhram/+9bExdCpFmSaeU3UGhhgrhBeASXvIpanI=;
 b=QI2f1R6AYFUiB5dzoVcTVPTaxN7tqyzG+KDU9EsXXOw7tr7KJTE8U0TuKcP0bEIV6f
 6/QD71mZP0mKJwyFIbtQXMLiyTI3BxDOW/8UEPcSpNboXT0oHOOa1yyPWQpom9XRI7yn
 M4hAgIuiGX6Kvr4WgNUt+Z/GnDoLoyubyMlthHlWINjNudx/hvtt5PMh79XeHKFu21Yy
 3rasD91SCK9HsNS2kjmHooh5iryeMKqHNwTgv+8DNLoU9kzPfZ0ZBAkCNbLzChvGT80W
 Zn9TULiBE1jsD+NejfBbSkLJ4WnPtH+2/EhRhlkGTe3b0tVNE6V11tFpEq5uGmaQA0Qc
 TJBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779318269; x=1779923069; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkJHFWmZk25c6GQFZqu6jtvLltYvdSLEcrxyy4QFG+A=;
 b=Ia7rsRzdFfIQ6xfq80rIihQWjkaIITZRo7NzDGf34XWJWWKF3pNterYY5p86MW0l3/
 HdI+3xCtJwMH6pmUl5W9JcWY3SOw1z3TU34cWh0z2PJZjWY/P3JEgLCPazfrDHV+FmWi
 IYTRvdf5WAyk/Fax80lu856PqXc3CDkZ7jZHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779318269; x=1779923069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GkJHFWmZk25c6GQFZqu6jtvLltYvdSLEcrxyy4QFG+A=;
 b=WytjSker25dEek1lI2HSxV2QHJ7/+bkBnwSp094xN6/tw+e2Ca1hJOdMEXWpCI92pT
 VqvLYstpcPoKx79Wt/PtgRUh3PkVG2sx9pAcv9lHAwKUhZYlf6Udl8GuTrfeJ0j/Mi9o
 bGT/hRQohsREaJ7gwKNyUpky1DlnpXYmJBJuH8q6Lls5wxP0vaVdLq2U1cJT88OJ26nV
 JUIG0uN/DF1zHIaFPOGTYmt2//4umRL/HMqFLX7/guM+QsIRqua7InVFL+nNZ9IfAbpW
 dsdpb+i7feEy96q+ATueh1/k5Yu4eYd7Uoh3t8/tUWBViFCLlECrSLZkWgbJxK5JqIW4
 jkjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X4w15sCQFjIVfUrgXi5Wml19cGkw+7fAV9HZGVr11+cvK/rOHDbrqvbSe6T4pf1BvAwATxqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj0zAzrd6B6g0P57XpC286DOViC6+LeSyKVCHwLbl3n7RKcDJX
 5BbPg3EPvNVlOsnZp6liKt3brbEMo52/l0Ii011NoJy3JTbqywzMsSx+eWNlq7rAJT7HVsqkjA9
 cqZffY4EI0tCIzGjHFxbB5Kwjg1tqiXzqms8ntGxX1a+2/3FjkWzkbljEPSE=
X-Gm-Gg: Acq92OGSFyd4I4pfZso2fz0s9+rLr0pD8kNa2uJ2ToaJffRZzfW08rKgZjJGXJOGbT7
 rBUOToJM/EGZEZ/LufoEXj2E2XmC9Y0dXLWGHSRzEWX5mbDtUuDF4Oi3Hj3/8OuGgwFBaPjY20L
 xXfQ96pzZdkixd5wFj7m69FRQ7dBPVcSDrX2d2Xo3R/shupzYe4waTpikz7oklBvtFLM4sGcZHr
 5tyFE8TR7c26mQ2ziSM+cI+sOWFNhew3yCyeyAFomqfMfTuyvLzaVKm3uubrVPYT3oHcqbirBWw
 FwNTx4o6KeCKxeTI
X-Received: by 2002:a17:906:d553:b0:bcd:c899:904e with SMTP id
 a640c23a62f3a-bdc12d97dcemr10387566b.7.1779318269089; Wed, 20 May 2026
 16:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-2-philippe.reynes@softathome.com>
 <CAMDkj5xSEbEkHPrsJ2ZnRZ56BsiZXTKV6RxoWrJn-oZfZBi_cg@mail.gmail.com>
 <agiktUnWJV5WzXFD@kehys.lan>
In-Reply-To: <agiktUnWJV5WzXFD@kehys.lan>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 18:04:14 -0500
X-Gm-Features: AVHnY4Iq_1u5yC2k1UUWGPYUnLvBx_fjn1bTD4ErfpMSL6D7sdtwGlVshQ4-wAE
Message-ID: <CAFLszTg8SKiGdj84vAvaA9VO2RZMobYzf-Q0JmwQVguiATMWmQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] ecdsa: fix support of secp521r1
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Raymond Mao <raymondmaoca@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, jonny.green@keytechinc.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marko,

On Sat, 16 May 2026 at 12:09, Marko M=C3=A4kel=C3=A4 <marko.makela@iki.fi> =
wrote:
>
> Hi Philippe, Raymond, all,
>
> Wed, Apr 22, 2026 at 02:32:22PM -0400, Raymond Mao wrote:
> >Hi Philippe,
> >
> >On Tue, Apr 21, 2026 at 5:10=E2=80=AFPM Philippe Reynes
> ><philippe.reynes@softathome.com> wrote:
> >>
> >> Current implementation of ecdsa only supports key len aligned on
> >> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> >> aligned on 8 bits. In this commit, we update the keys management
> >> for ecdsa to support keys that are not aligned on 8 bits.
> >>
> >> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> [snip]
>
> >> +static void fdt_free_key(struct ecdsa_public_key *key)
> >> +{
> >> +       if (!key)
> >> +               return;
> >> +       free((char *)key->x);
> >
> >It is safer to be:
> >if (key->x)
> >     free((char *)key->x);
> >
> >> +       free((char *)key->y);
> >
> >Ditto.
>
> Sorry, did I understand correctly that you are requesting to add
> redundant checks to prevent invocations of free() on a NULL pointer?
>
> The C standard specifies that free(NULL) has no effect. The
> implementation fREe_impl() in common/dlmalloc.c documents this as well.
> I think that we should aim for minimal code size.

Yes, good point. It is a bit strange to make fdt_free_key() handle a
NULL arg though. I'll leave it up to you.

Regards,
Simon
