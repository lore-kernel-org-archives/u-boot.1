Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EB4C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 22:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0ED83340;
	Sat, 24 May 2025 00:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s3MG3hQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3298334D; Sat, 24 May 2025 00:29:32 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D5E83264
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72ec926e828so78179a34.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748039369; x=1748644169; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wfcqZk9vtpoQD30j6dsq32nH6KnoiIajNKoDSC4hoRM=;
 b=s3MG3hQCzsDLbxHPZRJsyewTQxhlRF7WedAD9nm3QbU2dn0sHFgmw5MqjghrUYe8C0
 jAWs4tSJCHeWqjR+jIid8/no8gGOU/UHCGKwag/vbAcTLN1ygMXdop2oBRSQ9666hcte
 r59bNKRP1ffqZODQCAC3Of1bK2EL6+94WvvSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748039369; x=1748644169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfcqZk9vtpoQD30j6dsq32nH6KnoiIajNKoDSC4hoRM=;
 b=pcYbPzwjIYYwNNHDMcCe8B9xSILgbhjL3JF8Gg3j6e+szXnxBqif7mhKqXiwtv+F6i
 AlMbGC1jK5yzxaYFQ4awzS7FxK86H+sUw8kraETOVsZJmNj+BzI6qJq/6NrlDaqhPWxN
 rbxOuPhHWF0g7/h6cwqHF2mzwSIvmgCJsphaC3OrIh8VyEBSlpazTMmotW/vZeScKZD/
 obbZ7g2U5KEpQpOtv4nGRrbMWqaNM6L/9QnNsCm6n/8v0P+kZIJwYkKLQJJrYs5rUrI9
 +AU44bJyp68DezznOid3wLnMRXRMBR71EsI/ITSaCEmut20JEovktNlRmePLlM+c9ntX
 ZheQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB6Ono/ukpbFl8efIJmEaYXxGGDnrFdw9lfAr9G/pWnG1xiJyLS6L3BNFefNKY+hMKAdV7X+U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8qA9oCeyACNYu0Rns6Pj1SzM/AmvlcFwD1t6RdZbtbj6QyMC3
 bXM14jECWkE161RGSZo2PJ72VkLORhoTyCTzej6qhbR4OJosrnaYY872ddzs87oof1I=
X-Gm-Gg: ASbGncvc9MhUBKZLI43aWihs7aA6+2dTVzohO5xRz1zBEa31qA8YC2PLlR+QfTlhYpG
 +vR78zafLRP8Jd1wwh44SLn3jB2V6Hx713/6ke9pEZfkwDZUG4j+4YO9sCgUi+U3DL1vmlSSIew
 1194DkbtqvgtC5b5m8aoxnDXAJenODueWnV0/yvSvv7fh/3MXlVla0zsGfL2Ewz0m3dgMXzZjE0
 kYKTAOqGAAU4tYwKfC7NtN4NSFXgi90dXZv3kt5wnTgHC2szHzC7ZYzub2goQJBsTuCcuyXUPkS
 VVv+E7R/+q+0NR5AMny1S8ijjXYgIOwII+5IR1ioRzISC3oMsPRHJ+mUnlcuoPG+Jo203LraWq3
 hfVjWNDYIOYf/
X-Google-Smtp-Source: AGHT+IHGvZP3zEctdbmBpEx4Aw2c/XzRDCqNJjbsPP1IHRHJdcX9Nttv93pZEbOLNA3YMeQ7SCOtWQ==
X-Received: by 2002:a05:6830:6885:b0:72a:11aa:6ebd with SMTP id
 46e09a7af769-7355d129602mr728519a34.23.1748039369271; 
 Fri, 23 May 2025 15:29:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4aeecsm3059342a34.8.2025.05.23.15.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:29:28 -0700 (PDT)
Date: Fri, 23 May 2025 16:29:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Message-ID: <20250523222926.GZ100073@bill-the-cat>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FGbLtX+5mNDpa1j/"
Content-Disposition: inline
In-Reply-To: <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
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


--FGbLtX+5mNDpa1j/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 07:04:46PM +0200, Heinrich Schuchardt wrote:
> Am 23. Mai 2025 18:41:45 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >+Heinrich Schuchardt
> >
> >Hi,
> >
> >On Tue, 13 May 2025 at 13:28, =E7=89=9B =E5=BF=97=E5=AE=8F <Zone.Niuzh@h=
otmail.com> wrote:
> >>
> >> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_O=
S_ELF),
> >> explicitly pass SMP core/hart ID and DTB address to comply with modern
> >> SMP-enabled kernels' boot protocol requirements.
> >>
> >> Signed-off-by: Zone.N <zone.niuzh@hotmail.com>
> >> ---
> >>  boot/bootm_os.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> >> index a3c7cb5332e..a0f310b1359 100644
> >> --- a/boot/bootm_os.c
> >> +++ b/boot/bootm_os.c
> >> @@ -402,6 +402,11 @@ static int do_bootm_elf(int flag, struct bootm_in=
fo *bmi)
> >>         if (flag !=3D BOOTM_STATE_OS_GO)
> >>                 return 0;
> >>
> >> +#if defined(CONFIG_RISCV)
> >> +       bmi->argc =3D gd->arch.boot_hart;
> >> +       bmi->argv =3D (char **)bmi->images->ft_addr;
> >> +#endif
> >
> >If this is a kernel, it should really be using a FIT.  The Elf entry
> >is for general ELF files, not Linux. Perhaps RISC-V is special in some
> >way?
>=20
> A defconfig kernel is booted via the booti command or via its EFI stub.
>=20
> Why would you use an ELF formatted kernel? What kernel configuration are =
you using to get such a kernel?

This is I assume a non-Linux OS kernel being booted. So the question is,
does anyone externally have some standard defined here which should be
used?

--=20
Tom

--FGbLtX+5mNDpa1j/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgw9sIACgkQFHw5/5Y0
tyxShwwAhMUpqkLYbX/xv0frN3XUutUqMQK5KXNl9PEG50LL1akzTnv/Ip4JQ5cJ
MXZLPt7AJ/B/o395u5X8CfQdu18mPGBZsFDW/TAMauY4Ce6fmydyCv1XlhyIUx4/
T/eMl0m3mPV/Z3I87rz2rwSZ4aMvFLeNs0iiUXcQ1UO3sc1GqzHZhNSWsls3Uct/
DgyzIbdlTV+LVRkpIiwXCOx+iZCcn8WXpJ5qNvWYC4g4fuaHWZsj+uPCjqaCvdPF
yFEJoYItxD2e3U6l6OieGNZO9+4G+NMUvF3roIfWB697xzNrG12pexe4hCegOIqI
Gm11qJqV9mkBWdgt8c408hyc+r5rW2iV9/0GED3Ypgg8AEoX/MyhkEV6n+z/SsfS
gow9ZEg1waN/3PR3CyXL64KvtfvP23/s5FFCMYI2LzljltGbG0esXSyZVzjHBocQ
JedRQXJJ4DF1Ef5XZ38Y93pFII6/aeyK1QJxKYHUIqjKb8s+UYj3WVoosor825hR
PUXK25iJ
=b3rF
-----END PGP SIGNATURE-----

--FGbLtX+5mNDpa1j/--
