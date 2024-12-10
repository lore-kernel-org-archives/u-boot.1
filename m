Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A47E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 17:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17E1802E6;
	Tue, 10 Dec 2024 18:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FNWih4JS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB5C802DF; Tue, 10 Dec 2024 18:13:16 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DE8802E3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4675feed835so21477431cf.1
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733850793; x=1734455593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3A40TbTpfrYVi2oCqul71bxEj/I8mCrkq9Gd60e702U=;
 b=FNWih4JSa2+Lc5QauLNAjaiKKqzr8Qznh0B/Yf3EWZ6ESVe0saCyuloZX9IXmaYw56
 vk8gammNKp6u3OsIrGJMNnwT4ZZoU1tCFNTFS8fdrq0+pI6E41JI2bH22dFCzTdzeiBB
 DHnXsEZbWlUpG1/YO5RZ9S9yd99Yn1Yk/+CvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733850793; x=1734455593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3A40TbTpfrYVi2oCqul71bxEj/I8mCrkq9Gd60e702U=;
 b=ZqaKoVWIo9OcwEL8mc+g9L2io7GSK/JlpUrwVDZJKV7fVoV/+qQR9CShSV+z1o34Vh
 VlLxuUU99TWTntDZqYDEs0xDw9MXa+R/Ge96qDt3T2F2sIc3uyLpcm2cWUdBwhACVppu
 HFcbif4DVsA/Kt1kSNp/qBhRlM1PvwcXLd1T63X2bjvdqhKm5iKDTJuvjP0dRiJR8eVn
 uNLo5RKHrXqvqNCcPaS6os4nnQPxkMrTvVa//tZy+7hWAz46bEArpzFcYi2z7LzT78Hn
 XKja9F60FB3d29NSo0TJ6xkRdWJXIDy08QkQKuYbGdotsC5E/jJBaEKhRfCjIgB4pUcG
 n6lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2EuKBlBRjZImMEl8Q4D2/P1eL51Sjk5/h0N5fUosDSctp+2KYqLAsTcb24EjHnsk2gFtA1Jk=@lists.denx.de
X-Gm-Message-State: AOJu0YyPjU0XXwEVBuavIyEXpsgdPcUOdmeDXAL0yMRVssoxakT18K2N
 0nt90Fxps8H58/yBf/zHESb9zMszONGgA2rMqMhAgM8esGmyqE+iVXaJboVEM4E=
X-Gm-Gg: ASbGncvN3nbooPazS/eFI2hqAEeppIrQPAbDtciCY91wl0IeEPk9wBTy3G0zWQ/SyC3
 azw4HE/e6AejhVIbUYlqcoeRMla2LuxVokNKtWqUJ4UTq+oIHlH/BzyPmak7yNpSXJb2DnDIdTP
 Ice+lkrNMIOiRy58jPx4KXLzjIAZeDqCDZnZLPSgdQPv/l4LD8jMW3c9eOnVE5/BoHOOLH8KDMc
 HN3S1ftUC7pmGy7cTgtEukN9/nFtDkmzTg1oWJapqTRsCv2LElWvQ==
X-Google-Smtp-Source: AGHT+IGz71CGIrXlLWx2uqF/aJ8PHwLA2y/jpVMIPPCS9REWaRQJhtIgCfEyG2IgzmnTksHTgRC1+w==
X-Received: by 2002:a05:622a:5d3:b0:467:681c:425c with SMTP id
 d75a77b69052e-46771eaf019mr87934021cf.1.1733850792904; 
 Tue, 10 Dec 2024 09:13:12 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm33485741cf.70.2024.12.10.09.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 09:13:12 -0800 (PST)
Date: Tue, 10 Dec 2024 11:13:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Moritz Fischer <moritzf@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 09/25] efi_loader: Use the enum for memory type
Message-ID: <20241210171308.GE2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-10-sjg@chromium.org>
 <20c4487c-f908-40ef-be05-1ac7eb7e8be6@gmx.de>
 <CAFLszTgs9i4yrL8=YZvh91urYisj0s_ukH+vVGyWWBSULe71Dw@mail.gmail.com>
 <CAFLszTi88v1BFXLJCpp8UbnV_JO3Hg4Bx5CtWxEZ42__oVCFFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="axxpssjGt3bnyptw"
Content-Disposition: inline
In-Reply-To: <CAFLszTi88v1BFXLJCpp8UbnV_JO3Hg4Bx5CtWxEZ42__oVCFFA@mail.gmail.com>
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


--axxpssjGt3bnyptw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 09:17:43AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 3 Dec 2024 at 08:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Tue, 3 Dec 2024 at 07:38, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> > >
> > > On 01.12.24 16:24, Simon Glass wrote:
> > > > Rather than an integer, it is better to use the enum provided, when
> > > > referring to an EFI memory-type. Update existing uses.
> > > >
> > > > Call the value 'mem_type' consistently. Fix up one instance of
> > > > upper-case hex.
> > > >
> > > > Fix up the calls in struct efi_boot_services so that they use the s=
ame
> > > > enum, adding the missing parameter names and enum efi_allocate_type.
> > > >
> > > > While we are here, rename the 'memory' parameter to 'memoryp' so th=
at it
> > > > is clear it is a return value.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Simon, I have no clue why you keep ignoring reviews.
> > > This is just annoying and won't lead to merging patches.
> >
> > I got your feedback on [1] and incorporated it in v2 onwards. Did you n=
otice?
> >
> > >
> > > NAK
>=20
> It has been a week and I have not had any response on this. Does that
> mean you are OK with the patch now?

I'm unclear what part of NAK implies that Heinrich is OK with this
patch? I believe not since part of it was to not rename "memory" to
"memoryp" and you're calling out doing that still. But I suspect you'll
just keep this in your fork all the same.

--=20
Tom

--axxpssjGt3bnyptw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdYdqQACgkQFHw5/5Y0
tyxNLgv/e+I/wmW72S/sN3UGhPBRaoPM5Upk3c6Hsw026qaSKWwZMWQIlz6kEGqw
AayjyI97zoVp1VvHbrmzesMWzLK5OG3Voe/fRAd1Zaqc6Akdj2ziRIsocBl7AtId
BKkOmhvimNayIk13KLnaBxw5erreEh9xU1vBOhdMgqThQ7v4Dc4E6mtFDTjJlcHC
agtGIXijm4U2pKqNqSwIKrlkeVzUUDzDKVxQZm64yn4lKvWQbeWLs4scfIPE/j7I
4PrM6Tjj2AfMNlCkgY8YUG/GRHXYsiyNVBY5PNfLNRgKn4jDPvsC7CSuIrC57bz7
htK3KDV9RG1DUuwOBKedLEULBvukC682eObGmdK0wCt6nMThReA1ArDv9c/Kr21Q
QyCKREQuMj3Vs0eNNq/MH6RkQbGGiZv2ypghZcGukufTUKSEzWNkPEeSi3bgM3Ev
Mui3dGTkFvP/Xm3ZZv2QioEXmGsaNVGpECdqZVHkyfMOt0rtw56JwUhbAOoKdrsq
RF5750Z4
=j7sF
-----END PGP SIGNATURE-----

--axxpssjGt3bnyptw--
