Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54633EEA84B
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 19:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 829C98367F;
	Thu, 12 Feb 2026 20:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MfE8gitS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4013783A47; Thu, 12 Feb 2026 20:46:27 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D991383015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 20:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d1851d85daso70099a34.1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770925583; x=1771530383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nfyVyITkQYtVtgTRxEOt4BLS6cSBb4InHMZZkOIdXJs=;
 b=MfE8gitSp3zIHnm8j9ZfJ1pe0Sm1IalsIlrRNB6+r2OxSS8qvx5l0RuT0f7BmfOven
 bKTTRwipU0xgtVkpkHj20t22u3UHLRRVtc7SebpWwOFaQ3Iq7jGced1cuh16D0AaUUhH
 jWnPwfntb2Llh2+SjzaeCJmuxO8XOtytuMFlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770925583; x=1771530383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfyVyITkQYtVtgTRxEOt4BLS6cSBb4InHMZZkOIdXJs=;
 b=R4hf45Hk2WAN33QB3XtZnZH5Wk7GbmRwzCCFs5lOyVKDUg/t26+Ns88N1m8sKaeTF2
 hZC1omiFWvf0ni2ePLMbtrO8HDm1A6fF9nar6KamwLSo5SI7b0KNbp7+Av9GXPSD5pvj
 Cd7WjMK7jMUHjyfH4T8t9ypZIiB4o0ST8GkRuzcUtVb0fmGB8JtuTMt1JwoP+pFyHVWF
 IXPNKikJ1M2VQLsrdDlApMdk6OEwgPo6UUhIPjLtu9tYI5kXpV3ez2SifZQcScWVwfie
 +cEV3FujiHXLxGeuKGxwdyt7UFtg+IIgtGdxO3XpY44N9pOiuq9qKWVdQD2HtJB7MBiu
 7SSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnKgAfuICEjizn0Fx4d8lJ9Nt2K+ZJEoPcUFXDZyjvx7yPYU/V4GPU1hQVERlwrWRDWICWMZA=@lists.denx.de
X-Gm-Message-State: AOJu0YzglRJ28E8jV93Cq311kJoCkSRTYB7fTLiCHJ4Ujj2h29A+iEA3
 TUlOAJQBWd8TO2ZxxbGVZQnzYw6u/OV8O32LnrViUBFNLli0mvrjUKCugw+Haf4rNwM=
X-Gm-Gg: AZuq6aJRfiN2Ki67/jw1RI++LYgJtuGeRKK2BkVCQL2L8K3bQMLuVZHQAtQtLR7fozC
 7iPJEc6SpIrOvK9DfvGL3YPDknI8WJdC5EHBpCmjauzYVpFbel0nDP00cmJmP5Z3fxIIcc95qMz
 pvIGp9ya76wJwwZQcj49mkGRZ5+UYh0SKquiAvQJH435uz7+IlextO13QxJ447FJNFGup44WIES
 SW7BGF4nKodFG2MFrFU4dPv5Cx+d5yxNa8aTzQNomN3fRD4ijhhi5pnB2S8ey6QO+jBwxJD/SQa
 84MCrS595P9bGnOTIYk2RmbdD3bykrjdZsnr3boKcabp86ty65LOK06RGSuBoplyq+gSexd047i
 gRZbyPPL9Xv8IOrL5Hx3mFCHwrdOU4ytDH+mvob23DwvsdF0QO1IO3ce3ACk+IRNL2ToP54reCk
 1xbMmTF25AUKRo7G2urMcHRyOC/IZIgUfXxEzM2SX4zbjDEqPdePnuEH8CGAPdVZqOQdXBec6Ts
 pRytvM932nx/CvGoHsRuWg/+lid9W4/8AuEEYXj7ootfX9jrpI=
X-Received: by 2002:a05:6808:3608:b0:463:9a77:a552 with SMTP id
 5614622812f47-4639a77affemr9960b6e.45.1770925583578; 
 Thu, 12 Feb 2026 11:46:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a75309bcsm4384045a34.1.2026.02.12.11.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 11:46:23 -0800 (PST)
Date: Thu, 12 Feb 2026 13:46:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: David Garske <david@wolfssl.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Todd Ouska <todd@wolfssl.com>, Larry Stefonic <larry@wolfssl.com>,
 Wolfram Kusterer <wolfram@wolfssl.com>, Aidan Garske <aidan@wolfssl.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
Message-ID: <20260212194620.GD2747538@bill-the-cat>
References: <CAFLszTjgsSj47P6u2JohHv3vV1=sOWQxQ7qS3RDuBYBQsejKWA@mail.gmail.com>
 <CANqXHyEShK3bCA-5K4K=zH_b19i9+o9DRPYW8LHo-gFpMB2Hkg@mail.gmail.com>
 <CANqXHyH3OwPEpo=rv6E+uSP01quOQisEJ3_aD2-r=DkNDK4_+g@mail.gmail.com>
 <CAC_iWjLKotX4X9mD1qnJbnkbh9xBHfnyF+b=b--XvMjjbCrU-g@mail.gmail.com>
 <CANqXHyGZSGybzchkqSE0-7s3HgfY=UBjpkjS1wjuRkZzOLDMWQ@mail.gmail.com>
 <430A021B-7511-4C08-B30C-72C153A25A27@wolfssl.com>
 <CALeDE9M7ENPccTD18b3YKrvYEu8yU0cXT1ePXM_tagV4Ou+Z0w@mail.gmail.com>
 <CAC_iWjKnbp_gtHQ6nMZEHEOx92NA2U1OLFKkgDtyqS_aDHO6GQ@mail.gmail.com>
 <48C4A401-E824-46BF-BC93-1EA9A45AC374@wolfssl.com>
 <CAC_iWjJD+_spstOX5z2tDoyEUZwbV7QXNz_s5ffz7FWK9QopEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rkz9LcpHjtdNYunh"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJD+_spstOX5z2tDoyEUZwbV7QXNz_s5ffz7FWK9QopEg@mail.gmail.com>
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


--Rkz9LcpHjtdNYunh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 02:58:19PM +0200, Ilias Apalodimas wrote:

> Hi David,
>=20
> On Thu, 12 Feb 2026 at 04:11, David Garske <david@wolfssl.com> wrote:
> >
> > Hi Ilias,
> >
> > Thanks for your reply. I did submit the patch via git send-email on Jan=
 28 to u-boot@lists.denx.de with subject "[PATCH] tpm: Add wolfTPM library =
support for TPM 2.0=E2=80=9D. Can you check if you received it? Copy of the=
 email is attached.
>=20
> I haven't and i can't find it on
> https://lore.kernel.org/u-boot/?q=3DAdd+wolfTPM+ either. Any chance git
> failed to send it?

It's:
https://lore.kernel.org/u-boot/20260128171112.1818705-1-david@wolfssl.com/

--=20
Tom

--Rkz9LcpHjtdNYunh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY4uCQAKCRAr4qD1Cr/k
CgAqAQDEUbE0zW2pEvN8/zH3/8IIEKYw7QrM4a7x2VxEG//tagEAtVWSIIzO56cO
arEmkspFFI7olPmissJiEcITVj8zngw=
=Zpin
-----END PGP SIGNATURE-----

--Rkz9LcpHjtdNYunh--
