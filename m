Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AA2CD98E6
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBE0848A2;
	Tue, 16 Jun 2026 14:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V6tZ+RZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03EE0846A4; Tue, 16 Jun 2026 12:02:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47A684105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 12:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BEA53F2D2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781604125;
 bh=aS9TETAZs2Fh0CBbQws+61GjpGiLYopRf9/URV/2hT0=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=V6tZ+RZeTYuEbSxBPES+oISMGRjxnXHPTzPBxpvDIX2/Pk2RTqiwgTixrPeXtVrrb
 1RxUN0xYGsJoVB+uRJwT2KJ6szAt8TxN1d4pOdXZSua/oJT8N2gHNm5R0OzRB6E4ca
 3SUQDQuxdNnwwY8sSm1lxx2WRMhLWGCkwnG9QbV0VQ7wHsT1Qhr/ZgC2Bb/sOCOKlt
 c6qnUlpMdw5cSTEaqWLLAJfPTuoXH7HJ+uU46Ft6/Lj/pjtSDIaw4XRbSumGX5FugG
 6cgEz+H4HmF9QoLqqoTlZowSo85RB5Awx/LPMnirI6Br/A7nF1yoWTh0qS93xjtU62
 mPvHn48oANzGTtvr21Q73cUSXAGISjddmrXKlxvHDQnVLoKK/0RKZ5JgOTCip7AkAy
 MzDWN57/QSWckGksdGGBsuPTlzs5Cch5r73oFC3BoZv2FX0xpvL8CuZGMcMalEHqux
 ejqV7S803oSSJjYTdOQ6Bkv0CkenVQjOjUgeInLmJEJGYuX6RGF5bvxrd+KZAltUI6
 F2eqM9GfoZof84pACoTulOxfusvKKmGSbAPqGrSVDGZMDobrxSnCjG/fxeirMMhC8g
 PXhSKJv5A4Dm0phDVxvQ4PBIOIshQC0SPfqX+Au8DaXZgr/9Z5jr/G664KDerebqJ8
 FbTuWoxpks1SZZNc/uBsAMM0=
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-68d23422ec4so4832617a12.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 03:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781604125; cv=none;
 d=google.com; s=arc-20240605;
 b=TmtmH4/Zb42QTsPatyKWKzlIdNi4zcL0kdqcMBqL3wrfIJAlmK/rxFkDNT6R4hxeBW
 MwgPAmuywriCPh37+A1mb29Pvfq9bF2c2GYisF+jOg/UaYvULX+1NQyD/MgvtdZ6sLa8
 xh6OQkli7A/yClOI4hj5/Bh8J+Toxbv4WfJdq75eNPOvughl/OVonHtQJ2MwUFZM5nRA
 Ydqzb5t+QSrUj1xNz7cWBqBiQ0G5raUs2NUFv625TIjyK2fEEHQ/R/z6IVPl8VrYc5yL
 Uk4mDi1ZR8yCvaKq1ESddAk+M9UZPCOolwpa0owW8EaPHCMi/q8ZQRsOrWPwqv/t8Ugk
 su4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=aS9TETAZs2Fh0CBbQws+61GjpGiLYopRf9/URV/2hT0=;
 fh=10QzhohGSOy7HoLOFoKbMs02HANOUw65j+xbl1OQEDg=;
 b=CLDHsyC75C43a8i3Fl+wsiXdZ6u1UFZCerPD1y1uxqQ2nmp4s9osXqGDpecuugjFpe
 x1Ed6gJL3OTaV3oSI763otjEZ0dt/XlVS7IfmbasdG3U2tYfSu861Ba0JeDkL1K9o7sO
 FmjdkBBa3Xv1YHLDccw01nzT4tdeuxzEsQ2O81pVdZT6CiHvA4LnaK4FbcbpNGxt7RJ0
 q4pMmdJAo1yVp+9uJVCnlry8mXVFjs4QB6B9EMudKxbHuV4EVlubocrZa5NtncfcnPNN
 nTd5idFSQ/7hFWtIH90rVgXwij5r8LdGTzDOC5sonvBRLDyBObUC1ZhAd2XqxUQKWZxP
 yTnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604125; x=1782208925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aS9TETAZs2Fh0CBbQws+61GjpGiLYopRf9/URV/2hT0=;
 b=ANNquLnuj2uQynVo33EFa+Z1ngE3LjNF/uXVTcoSvuhz1BD63GpJ2b7degJsWM+0wU
 b/jGJ8kCPfMw5AJ1u0s7WcKS8cBhzjBFD9wxDejii+Mxv4gf5RcYGLENa6m4kax9xQCE
 LcLKnp2Q9LqbeH6aneIRg1WQEs/RvPHuUUudVIlwvj6bVAsRKQ8Z2E09Vo/ttTjgHrLW
 cSSgBdBTE0rppAeCRSCknVQ2byrWhkmanhtAbJ1pEXcTf1+HbG20T8+RUiQ1EqCeCaMc
 t98LJqaTMxjDH9CUX0PXc60+VbqeS/8bVFuIJDVn8xX59bqLTov3ploWlwlJHhADLThA
 KC2A==
X-Gm-Message-State: AOJu0Yyt1DRIMj9/CuRwP1/b0zXkvTeh+SQGdk9zPYY5QLN4sFIATO0n
 1bYzsrHPkYjAGc+V3tTApOZ2goOrOyloTJ0q9VzfAxmuaJqVhoR2RlV3oOU40qxRUaeVcKCgKZn
 ZwSYL1gf9tbhXO8cTcKxSjtaTj16fcY9TIjhINWg0br+/2R6y0uSmzghdDWq3uwMlfWwiv0p9IK
 rCIKWXDkmu6/zTAra4C3U92QLZEseHHB5Ny7c733h8XBJKRg==
X-Gm-Gg: Acq92OE0gB/h649eE3o1N2OYd0GHosl3Tee50VRBS4D4LXi5rpg221szxOM56k3wtk0
 Gf1i/X2jHhr4W7tGRkXjpVu1yv5sSOOIKjKvbuLK7Lk/eJ0mI8fm5aZBiQ+ehyL5LS2yBiunB7K
 j4E+05k3CcAttOXNq83ev2EyPOae/DCz7wx1+jbmT6KYU0p1vhg3zMte2FYRbn1op0L2zSK/T5O
 CncKgg=
X-Received: by 2002:a05:6402:4493:b0:691:af08:a9fd with SMTP id
 4fb4d7f45d1cf-69378a03b9cmr8423395a12.11.1781604124745; 
 Tue, 16 Jun 2026 03:02:04 -0700 (PDT)
X-Received: by 2002:a05:6402:4493:b0:691:af08:a9fd with SMTP id
 4fb4d7f45d1cf-69378a03b9cmr8423347a12.11.1781604124217; Tue, 16 Jun 2026
 03:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260524151431.72296-1-aristo.chen@canonical.com>
 <CAFLszTitaXsCZn1e45m+Wn0v0=mD5LVdpb3vtZJZgcvGr8yqGw@mail.gmail.com>
In-Reply-To: <CAFLszTitaXsCZn1e45m+Wn0v0=mD5LVdpb3vtZJZgcvGr8yqGw@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Tue, 16 Jun 2026 18:01:52 +0800
X-Gm-Features: AVVi8Cee0YARWd4uBJtYSDtjU4MLcrp-pG56P-w6jF7T9Boe-TLXrf9qqOErjMA
Message-ID: <CAA=k7=k5NjdPEV6jVtxWBhVuL602J7eFP7TLM6aQtL+mKyVT9A@mail.gmail.com>
Subject: Re: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jun 2026 14:26:38 +0200
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

On Sat, Jun 13, 2026 at 2:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On Sun, 24 May 2026 at 17:11, Aristo Chen <aristo.chen@canonical.com> wro=
te:
> >
> > The boot_os[] table in bootm_os.c is a sparse array whose compile-time
> > size is set by its largest designated initializer (IH_OS_ELF), giving
> > it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() returns
> > boot_os[os] without any bound check, even though the caller in
> > bootm_run_states() passes images->os.os straight through. That field is
> > populated by image_get_os() from the raw 8-bit ih_os byte of a legacy
> > uImage, and by fit_image_get_os() for a FIT, neither of which clamps
> > the value against the table size.
> >
> > An attacker-supplied image whose OS field falls outside the populated
> > range therefore drives an out-of-bounds read of boot_os[]. The caller
> > only rejects a NULL return, so a non-NULL adjacent global is accepted
> > as a valid handler and invoked through the indirect call in
> > boot_selected_os(), turning an unsigned image with a malformed header
> > into a jump through an attacker-influenced function pointer. FIT
> > signature verification covers the os property and mitigates this path
> > for signed images, but legacy bootm and unsigned FIT do not.
> >
> > Reject out-of-range indices in bootm_os_get_boot_func() so the existing
> > NULL handling in bootm_run_states() reports an unsupported OS and
> > declines to boot the image.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > ---
> >  boot/bootm_os.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> I would rather put this check earlier and only for legacy images, to
> reduce code size. For FIT I believe this cannot happen, right?

Yes, you're right, FIT can't reach this. boot_get_kernel() loads the
kernel via fit_image_load() with IH_TYPE_KERNEL, and the os_ok check
there already rejects any image whose os isn't a known type before
bootm_find_os() reads it, so images.os.os is always in range. Only the
legacy path takes the raw ih_os byte unchecked.

I'd lean toward keeping the test in bootm_os_get_boot_func() since it
sits right at the boot_os[] dereference that every caller goes
through, and the cost is just a couple of instructions in
CONFIG_CMD_BOOTM code (not SPL). But if you'd prefer it scoped to the
legacy path, I'm happy to send a follow-up moving it there.

>
> >
> > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > index ae20b555f5c..69aa577a2fc 100644
> > --- a/boot/bootm_os.c
> > +++ b/boot/bootm_os.c
> > @@ -599,5 +599,7 @@ int boot_selected_os(int state, struct bootm_info *=
bmi, boot_os_fn *boot_fn)
> >
> >  boot_os_fn *bootm_os_get_boot_func(int os)
> >  {
> > +       if (os < 0 || os >=3D ARRAY_SIZE(boot_os))
> > +               return NULL;
> >         return boot_os[os];
> >  }
> > --
> > 2.43.0
> >
>
> Regards,
> SImon

Best regards,
Aristo
