Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4638C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 02:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 017FE800CF;
	Tue,  4 Feb 2025 03:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gf8b/x0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FCE9801BE; Tue,  4 Feb 2025 03:12:57 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C39800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 03:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f53c12adso445300485a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 18:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738635174; x=1739239974; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=glS4CXRoArNrRzwke9b1v5ZDwxeFICez57xUQWV9+cI=;
 b=Gf8b/x0iCS5xVWvpXPKlrRFRrZbEWL9JJKvQ1A11rOe2iq90W9Y2ebj7A+5reQD8s3
 6+3c0Hpb5CM852quOSdCB+jjPImZIT6IrIMeDjlMsw1ri1pai+kcoGPQRBzIUKeA5aTa
 AnTxtrMqND8NZitcNop+L6Ahem+riEboyF/S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738635174; x=1739239974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glS4CXRoArNrRzwke9b1v5ZDwxeFICez57xUQWV9+cI=;
 b=MTUURgQPwxCbfGSwjwgUYVmIryo7xLaVs4bgOkWGJ2gUdLBvVTN6Nt+yZNW7W15NHN
 5jhguZ03BO1tSZHf8fso61g4uMm6U18TpZxRlp/KRoAxf5matQfRhyTJWUezWg77Mn07
 hOesgTNPoXs2sBZVlPHOrXFOYyTKuQzYyKYgpnyd63nUolVHwZsfos2ZhnkBXl3r28Lo
 vYaC/UmJz8uXtg65rriJNYOrd9MXRmUkzI13wim/+Wh604M2vxcZEMcKtyzrNAm2gr3h
 TVpOulze4Z9iHSSHze2z+V2fL/ujnA6iD7AX9D9nnr6PCEf7BwLf3yWBEBOWOncfY6TJ
 M1WQ==
X-Gm-Message-State: AOJu0YyePYjoD0qTNAADDRpPjF6w6OCR+vbvLcuuyuIG013XgfTIPGkK
 x2/9uCACyWgtjFCzUzpn0fpXg3CNldlqpPb74CMz7Ir1L8FSyYhCmLoEoM73vkg=
X-Gm-Gg: ASbGncuEBHAxxB40s9NlvVSs/d3K0XeZ8H19+XyOFcMymtO/kKrJkaiWHgzjcGlrBJ9
 c+pnZR4rg7qb03IdSB2fg//qG/YRRE8wYXBjHv6YR0RMFgaID89GxwEmWpUqyGIrhgIQQcRhmEB
 v/GC/O9+bdFawR9x3ofKPX33rYXMAcPFMjQ4y/i/XtRX7xhK1Am/yR/6EfVQAZxkpSMwig5LO9q
 FIhu9cqIqjsjZPa5dKdkc+e7Jlf/UtiOvK6Nlt5aUbO01Y0Wajo0a9wmXq/XH1u3o0Y+OyEoIif
 V1qKOhiPwItBANk=
X-Google-Smtp-Source: AGHT+IFFpx8gMcT5M4t969w0WC9bcGBKXxrR0UXz/MMfqwF2C1WzTLzXYNYMJIH5yfDAkMbpBRqiMg==
X-Received: by 2002:a05:620a:45a8:b0:7b6:ea22:3069 with SMTP id
 af79cd13be357-7bffcd06f41mr3403520985a.26.1738635173876; 
 Mon, 03 Feb 2025 18:12:53 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8cf5f0sm590644485a.33.2025.02.03.18.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:12:52 -0800 (PST)
Date: Mon, 3 Feb 2025 20:12:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 15/32] efi: lmb: Avoid access to _start
Message-ID: <20250204021250.GD1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-16-sjg@chromium.org>
 <20250203200911.GI1233568@bill-the-cat>
 <CAFLszTgSD+jACUegQ4yw6yOogvk+LVtsC9kOCs8zJ9ECDiZG3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VkODwqKlAIytbvb0"
Content-Disposition: inline
In-Reply-To: <CAFLszTgSD+jACUegQ4yw6yOogvk+LVtsC9kOCs8zJ9ECDiZG3Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--VkODwqKlAIytbvb0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:38:44PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:42:08AM -0700, Simon Glass wrote:
> >
> > > The app does not have this symbol. Also the memory where the app is
> > > loaded is not under U-Boot's control. Disable this reservation for
> > > the EFI app.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  lib/lmb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 588787d2a90..420eae4d0b8 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
> > >               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> > >                                 LMB_NOOVERWRITE);
> > >
> > > -             if (gd->flags & GD_FLG_SKIP_RELOC)
> > > +             if (!IS_ENABLED(CONFIG_EFI_APP) &&
> > > +                 (gd->flags & GD_FLG_SKIP_RELOC))
> > >                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_star=
t,
> > >                                         gd->mon_len, LMB_NOOVERWRITE);
> >
> > What prevents U-Boot from overwriting itself, with U-Boot commands? Also
> > how is this linking today? I see lmb_reserve_uboot_region in
> > efi-x86_app64 for example.
>=20
> The only memory U-Boot can use when running as an EFI app is that
> which it has allocated using EFI calls. The actual U-Boot code is
> certainly in memory somewhere, but does not lie between gd->ram_start
> and (gd->ram_start + gd->ram_size)

That's not what the commit message means to me. But the next question
is, is EFI_APP setting SKIP_RELOC?

--=20
Tom

--VkODwqKlAIytbvb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehd6IACgkQFHw5/5Y0
tywdRQv/X4NqEO5a3Z1c0FlxkG3o1sdxSMeFt0yDMa6JpxXUnxlmanTSSwvvkMZR
4KQz6zOZV11CDzGLL0tYRz+ydryR1s/Mwz/LKBUwyD+lqBxtlMJ2Bs9sIbRH5Db3
qtjpBSvQx49mlpL/sshezNRQPPG3GZJ6qKBVOcFr09cSYpcz+iluERdEB5XFIv7i
qR/MRPy8VLnRMepyIXMl5uFMUoxZ0GFerR9+wJdp8mMPW4lhUpA+INI+cOx+EO66
qGToyukc1DvquECt2tXTUHOk6DF059rbYayojqtcLkG9myU9Rf4WMgm+Y/A4dpn1
2IqWSXGn7j+prQhYDejUCxZylqn7ny2KusIkne2bWIfu1vHRXytBpVbjGBhH+pKN
lPUQ4QMk+XvKdl/hNU1IUmLdYG0+imT2bXfEnXHjZG4O1gTrMMRmctoXch2k12nY
01m5gfl061R/VIUlVh6c6Tl8rV8qBOEULJKkJwOud1pLw23rE+txcVcKaYmzyRmu
lRqROScx
=pXyw
-----END PGP SIGNATURE-----

--VkODwqKlAIytbvb0--
