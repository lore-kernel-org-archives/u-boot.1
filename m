Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4E4D735EE
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 03:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D028789440;
	Sat, 30 Nov 2024 04:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WxYfAjI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4596289442; Sat, 30 Nov 2024 04:42:26 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66FC893FA
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 04:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d87f00f786so16815166d6.1
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 19:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732938142; x=1733542942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NIhFAFZgUnC7SOXpzDJFhG2UK7glEaHsGX5jG64VW/U=;
 b=WxYfAjI6aEGcujQTpAw3zVjKHylcr2GdaeetnV0M1gMaTRmf0je3p8CaB14603ilT7
 5+5kfIx6QIwsgO9EEuBwQb6nMEfXKWTgtWgb98XRDnvSGSGDOdyGNJDZLezhpiQh9QuZ
 8HBarDSLBAq+QiTt6fjPev/XTJvo+3lmSkc0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732938142; x=1733542942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIhFAFZgUnC7SOXpzDJFhG2UK7glEaHsGX5jG64VW/U=;
 b=xNwrAXbFVB4Vfe+rdIqSCwylzf0zVgJaazuwtvKhwH9huQYAPMmKHa/N1gWFh38Nnr
 WhfEivdLyc3and9SLjFL/84TYDZ7/0hnNSVjjzwoeboDKh3G1Gl/JUgsq/jrklVco9Zv
 oKIvmrXlJ5y4AfM/SPeU+kAJXh1llf5QWyzLR9G9uxRtY8JvUTiji6hIerf+dwMt0s/8
 Xwecd2Hx3U0TnLA5y2cOEuV66bqjDoe6kjcQbPY6C1H/Hl05EHQ6sE4GEUyDyZtQ7/js
 8PE1M8dJAPkHWEVboGqFxor+Xp6n5vXJ3dJ941M5dyl+kywRt8u9mraBTkX2YysT59NZ
 BE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY7R+sJiXTo0EeFQAL5D8ZjUn5RF2JNZgUMwoazakea0qD4Do8WGTRTISfH3PyobbYEbhoSBE=@lists.denx.de
X-Gm-Message-State: AOJu0YyxZKFN0MV2SB0SByyYQAtVY3OO5FLv8EsfiNSOB6/3g6fr17k5
 CeVF8IY59ENvumd3RflOTBY970Dtngy5LTQb/RQR8nsTc6IOUxZZd3bWN6rsUTE=
X-Gm-Gg: ASbGncufqaf8Ibxpe7Cl5RC+NJ3SBwgFfblEa5axHOVnPhP+bun7NzEWB0GeXGlRUvJ
 9ZUeOkiAQG7IbEULB5VQ9WjTs+mvLC8rMfLjS7GeF6w9JuDoM4zzBrK6zGiAgupz1awSU64Djpe
 5QsULM1ujh4TP2TelaBX2jGLGb8/Q3YLpXPJQwU/0PP0VlIXP9ecpgdDquGg5EBhPW+zIM+AoOk
 a7EbnNZYgmR0dvbELQ98NZ3yeEXsef3A2zv9Rt/hhSwtg+k+Q==
X-Google-Smtp-Source: AGHT+IEnHOwqSsUx3oUoe2al5E9kb+1ZoOnGtwxA2sfkhmoBthkPuqFJXddRCaDLkgc2X7L1rhya2g==
X-Received: by 2002:a05:6214:5283:b0:6d3:f1ff:f8d6 with SMTP id
 6a1803df08f44-6d864de521bmr196004336d6.40.1732938142496; 
 Fri, 29 Nov 2024 19:42:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751801fasm23156356d6.37.2024.11.29.19.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 19:42:21 -0800 (PST)
Date: Fri, 29 Nov 2024 21:42:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
Message-ID: <20241130034217.GO3600562@bill-the-cat>
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
 <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
 <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
 <CAFLszThi51_bB8821kTdk7txP6z+0RpaQ47BFb=UTBkK4Ohpxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W4P/UkvW1da3CU2f"
Content-Disposition: inline
In-Reply-To: <CAFLszThi51_bB8821kTdk7txP6z+0RpaQ47BFb=UTBkK4Ohpxw@mail.gmail.com>
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


--W4P/UkvW1da3CU2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 04:27:40PM -0700, Simon Glass wrote:
> (Sorry, that was supposed to be sent to Ilias)
>=20
> - Simon
>=20
> On Fri, 29 Nov 2024 at 15:26, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 29 Nov 2024 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add =
U-Boot memory to the memory map")
> > > > This code was removed when the EFI subsystem started using LMB call=
s for
> > > > the reservations. In hindsight it unearthed two problems.
> > > >
> > > > The e820 code is adding u-boot memory as EfiReservedMemory while it
> > > > should look at what LMB added and decide instead of blindly overwri=
ting
> > > > it. The reason this worked is that we marked that code properly lat=
e,
> > > > when the EFI came up. But now with the LMB changes, the EFI map gets
> > > > added first and the e820 code overwrites it.
> > > >
> > > > The second problem is that we never mark SetVirtualAddressMap as ru=
ntime
> > > > code, which we should according to the spec. Until we fix this the
> > > > current hack can't go away, at least for architectures that *need* =
to
> > > > call SVAM.
> > > >
> > > > More specifically x86 currently requires SVAM and sets the NX bit f=
or
> > > > pages not marked as *_CODE. So unless we do that late, it will crash
> > > > trying to execute from non-executable memory. It's also worth noting
> > > > that x86 calls SVAM late in the boot, so this will work until someo=
ne
> > > > decides to overwrite/use BootServicesData from the OS.
> > > >
> > > > Notably arm64 disables it explicitly if the VA space is > 48bits, so
> > > > doesn't suffer from any of these problems.
> > > >
> > > > This doesn't really deserve a fixes tag, since it brings back a hac=
k to
> > > > remedy a situation that was wrong long before that commit, but in c=
ase
> > > > anyone hits the same bug ...
> > > > Simon sent the original revert in the link, but we need a proper
> > > > justification for it.
> > > >
> > > > Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@ch=
romium.org/
> > > > Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory t=
o the memory map")
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > >
> > > Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > >
> > > Like you mention in the commit message, I don't think it warrants a F=
ixes tag.
> > >
> > > -sughosh
> > >
> > > > Apologies for sending v2 so fast but we need this in for the release
> > > > Changes since v1:
> > > > - reword the commit message and fix spelling
> > > >
> > > >  lib/efi_loader/efi_memory.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memor=
y.c
> > > > index e493934c7131..edd7da7d8c6e 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
> > > >  {
> > > >         unsigned long runtime_start, runtime_end, runtime_pages;
> > > >         unsigned long runtime_mask =3D EFI_PAGE_MASK;
> > > > -
> > > > +       unsigned long uboot_start, uboot_pages;
> > > > +       unsigned long uboot_stack_size =3D CONFIG_STACK_SIZE;
> > > > +
> > > > +       /* Add U-Boot */
> > > > +       uboot_start =3D ((uintptr_t)map_sysmem(gd->start_addr_sp, 0=
) -
> > > > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > > > +       uboot_pages =3D ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > > > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHI=
FT;
> > > > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SE=
RVICES_CODE,
> > > > +                             false);
> > > >  #if defined(__aarch64__)
> > > >         /*
> > > >          * Runtime Services must be 64KiB aligned according to the
> > > > --
> > > > 2.45.2
> > > >
> >
> > Thank you for digging into this. It is helpful to add more things to
> > the commit message, but please redo your patch with a 'git revert' so
> > we get the correct subject and body, as my patch did.

I don't have a preference about the subject, but the body above is
correct. It says "This reverts commit ..." and then explains _why_ we
need to revert it.

--=20
Tom

--W4P/UkvW1da3CU2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdKiZUACgkQFHw5/5Y0
tyx7agv9FCD9XHVGQ6NsI2+At0gx1gGsyN2h/qfAl6PyJVr7Y2MboM+mxWFRGSsF
C7Zc4BWay4ehQx5CTfOG7eD9umcGLXGxLqz9ZIX9Qr7L24tnKlVkEv6erc89F2f8
+Z4y+EGneUIXCtuhAJSUPeJW3YxfG1mck5korPLDp+AgxKDii9IC3JDbRotynD7C
ZEeC91+9tBHi8TMmzPgsJB5xAd73Lacm2Q6vMHKQUW3cySnQmD0tZiv3TN/lZnPV
rK23/W7cR9kp6N9+EKm9uBgTnCvC2CDve3XXunpEwi+v37jXIR8DGYC/XA8i6FFb
KfSVoBUk+8S+8hs/VdPPuoauqnkDWPXuXnIsutfsJRZ6nNMz0WYoeaJ5HfQnL4sW
GLv53kPW4e7NciZkjZYEELh2IS5HCyHTmrlCoR/nChTZpExSZbBavQMNHeewifh/
pc5PRGIRyFD1j546hPVXs2SCfVQoocJkMyLCNAwzgCg5ugq4GEjPyQHZtSY3aIVK
RpIYixle
=KM2c
-----END PGP SIGNATURE-----

--W4P/UkvW1da3CU2f--
