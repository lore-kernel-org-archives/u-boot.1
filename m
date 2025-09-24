Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB131CAC5AC
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 00:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D7F808AF;
	Wed, 24 Sep 2025 02:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lIBb1wXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCF9280B9B; Wed, 24 Sep 2025 02:57:24 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B2180107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 02:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7859d18aa33so1704224a34.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758675441; x=1759280241; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tjrEWOHV4E7G3udPLD9TVJiQSjGF2OLk9LGleEeozEs=;
 b=lIBb1wXzw3uy8uqIArFHdL8rkVGxaz3D/DDMrD7npLnycukTJNwd91PvyRJexGmDNK
 gumz+GiGNYDQN8Nq9Oubk5JYKZ2gq2YtBydjakVWcglk0afwwJEYajhveEDPSev3hkHO
 g7VSr7KHie4xti2WCsiHlDfH+WnvhN9HrVXxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758675441; x=1759280241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjrEWOHV4E7G3udPLD9TVJiQSjGF2OLk9LGleEeozEs=;
 b=cTPC/ExvG0kRyjblLhdjMj/j757Gg1CiR3IfXL6ZzYajHVqqmvJsZW13cznVk0iODo
 /gbp/IBRzKyuIl9ZBQ3PXwBwCaETFa5EtnO86UrQb4ubVSNqVsRLdbMh1W1teZQFM/ZY
 HHO3Zkk8BYqQClZHXxPm0OMNiETXjNfrHC9hQetWrVyOUMTAp7JnJOBJlSLHo26P9aMK
 pqwzRqXzyeeSdsmuJ2nT1+TxGAx0ZTGSFCFlx6GJF92RFvDDMTOXwLm0F9MnprUc1YoX
 QREe/0sEV2g/HVkQ0GXxuvEMCyxxIZmkcXxD81t9SasruT+EqbIrqyoPdrpDfinROp39
 VPbw==
X-Gm-Message-State: AOJu0YycUS6Bt55MEnJSzWxHw/uwwyXSJKQo76gfxFy1oRtX8zC8zx7I
 kQU1JkRz45dGBvers6E5+mpQyDXsAaxT/SOHzgYX7jZvWENDYADnFoQKZ1UVBEealcE=
X-Gm-Gg: ASbGncuUxGqUgJntZQMrWDD8Vdlnxvi0kpKkINNcUnW32YEZDpui1wVtej3y4nflsWF
 xqaG/jLvbSfE3Ug+I+7VK5oYn4szsbER/+prEOkYcJjqkupzwWrgn1PUQFQFfbyE47JDN05+Aer
 KEjyouWDofLs2FguS9aYSgjQ/FcLHvkb/KU/AOqiYlh8VrmNU+RJJUq5udYqNpKgAFI33koZ5BK
 XYZpoA9Ip2MxFRKFiKgRDqa75o74I+JaT1nxOnRsXQX34ErysVLq7JWptKc2Adhtd/lshIWmRRU
 VWblcuTTwfCYnOOxO92j1A9cB9orwi7N5RlzbbBjlMAJBn39QdtvoK6TQWKJEY+p05u/h0BSu9p
 6tTFJceVkaXhAIWCyL/I3Zzfo4XRs8uSmLr88cEpTSsNXxRXl707F+ttu
X-Google-Smtp-Source: AGHT+IEczNfJG9glG1NbPw+mjArQkFVey7F13zhSJuueMrwxTqkFYxhGHBtRKEo6pUA05/NVOf4zFw==
X-Received: by 2002:a05:6808:3091:b0:43d:2454:b694 with SMTP id
 5614622812f47-43f2d313433mr2360155b6e.2.1758675440927; 
 Tue, 23 Sep 2025 17:57:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c82251bsm6273347b6e.17.2025.09.23.17.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 17:57:19 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:57:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Message-ID: <20250924005717.GG197373@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
 <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
 <20250905230929.GN124814@bill-the-cat>
 <CACAHuLBgL2h+XYysfwYSOBcwyjrJRk7Z4X5Axr6PDDF_Xq17Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+VqLwnpoRWDaC0Ba"
Content-Disposition: inline
In-Reply-To: <CACAHuLBgL2h+XYysfwYSOBcwyjrJRk7Z4X5Axr6PDDF_Xq17Rw@mail.gmail.com>
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


--+VqLwnpoRWDaC0Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 09:49:05PM +0100, Adriano Carvalho wrote:

> Ping. Any update on this?

Yes, a patch has been posted and is currently assigned to Heinrich. A
follow-up with a cleaner diagram has also been posted. If you would like
to rebase your work and in the cover list them as dependencies that
would be good. Thanks again for looking in to this!

>=20
> Com os melhores cumprimentos. / Best regards.
> Adriano Carvalho
>=20
> On Sat, 6 Sept 2025 at 00:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Sep 04, 2025 at 02:24:57AM +0100, Adriano Carvalho wrote:
> > > On Wed, 3 Sept 2025 at 02:14, Adriano Carvalho
> > > <adrianocarvalho.pt@gmail.com> wrote:
> > > > [...]
> > > > So, in principle, we "only" need to replace all ".. image" with "..
> > > > kernel-image" (65 occurrences / 17 files). However, I did that, and
> > > > got:
> > > >
> > > > sphinx.errors.ExtensionError: Handler <bound method
> > > > ImageCollector.process_doc of
> > > > <sphinx.environment.collectors.asset.ImageCollector object at
> > > > 0x79380051bbe0>> for event 'doctree-read' threw an exception
> > > > (exception: 'uri')
> > > > [...]
> > >
> > > Actually, the right approach is to use ".. kernel-figure" not "..
> > > kernel-image". The latter is never used in the kernel.
> > >
> > > Using ".. kernel-figure" it works fine. The remaining patches are
> > > still required though.
> > >
> > > So, if you intend to remain aligned with Linux in the way the
> > > Documentation is built, instead of this patch a new one is required
> > > that replaces all instances of ".. image" with ".. kernel-image" (65
> > > ccurrences / 17 files).
> > >
> > > Please let me know how you'd like me to proceed.
> >
> > We should switch to "kernel-image" and update our checkpatch.pl to
> > complain (and this might be acceptable to the linux kernel too, are
> > there instances of ".. image" ? I assume they too should be
> > kernel-image) so that we don't regress in easy to catch ways.
> >
> > And then yes, getting the correct non-zero SVG for the TI example needs
> > to be done.
> >
> > > Moreover, the infrastructure to build the Documentation is a bit
> > > behind that of Linux. Not a lot but quite a few changes. Should I try
> > > to issue a patch series to place U-Boot as in sync as possible with
> > > Linux?
> >
> > This is a question for Heinrich. Thanks again for digging here!
> >
> > --
> > Tom

--=20
Tom

--+VqLwnpoRWDaC0Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNNB5QAKCRAr4qD1Cr/k
ChxsAP45T7C6oW9CA3PqMBqHnsmZQZZb+XEeG1lv1EEpnMyUVgD/QLXHcwsDSPtK
dCQsY8De49kMi85NiDzqHmShQjuRLwM=
=0N95
-----END PGP SIGNATURE-----

--+VqLwnpoRWDaC0Ba--
