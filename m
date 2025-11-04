Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E0BCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72B083968;
	Tue,  4 Nov 2025 23:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tFO+lXeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5B583980; Tue,  4 Nov 2025 23:38:00 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E54483957
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-656b612e607so435439eaf.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762295877; x=1762900677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RttxVY8Yc7+v8clTM5i9wps0BfiUAjfNX+504+Vg2CM=;
 b=tFO+lXeIUrvROnYZ2aWW5/1eBN6MTNK8z9pd5HT6TG43T8uRVqlwEJEU9r3DXULHJC
 taoQ+NfMexFSBpFVnHkZPolWaRuP3n1mypgNgcwpQIHKyTQOs0GF4XH6y5EFlgRtoMh/
 2+ajep/Lc6NlSJUwE7EITJ/vQBL3Ux3X+O2Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762295877; x=1762900677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RttxVY8Yc7+v8clTM5i9wps0BfiUAjfNX+504+Vg2CM=;
 b=nQggPf9zAiOIJBuydF5eyrAENA7qodkbPMw/3QQKIUPINg06ZBeIxUK/hMI/A0J3fI
 rxibEq5MMnXWNsMy8aWKdygbU4tuv37GdWRng/gYOqm0ripY1BObsEIIFDtDbR3O/Ks4
 Tmbj+9IZdqf6ZUHIGKwR8h7nzx0BoMawVqyB5UjiRYE/faGXwiADaSGMb6QZ5CxM75hQ
 OcpGh+87Hp8R4o+gW8N8bdw4LWo9aAhDJT/xL28Jm1BLpgqsoaF+6h29UNtahNNj9z7R
 2YHXqRbepa+Fkq1GUt7BF9mULBcfCi/ZWwGPRiZGpIxQDGCXkslTXyUqtNYYOON3vl8X
 AfgA==
X-Gm-Message-State: AOJu0Yw8jo2WlWiSk+srqMIpr1y8zgMjJ3LN/nyUcWpN/5xW3bwwpdDe
 jAT35RzuNN8y0B4Vch4VCRQgsui95qlduCA0CtfBqjpXFkr8qJ3RwSI9b3XoLs3PVq0n3rbvCWD
 U0PaeLTLFVQ==
X-Gm-Gg: ASbGncv8xggXJsCCpzNHF9O7LoakY585fyPa4k/gKWIpAEOrVdHUiTgNPSPoEG30fPl
 nXw7MWF0ZSt3sN9+WzlFlAZMrcvRMFpbJVcjuUs31p27kEI0euL7GGpeQ5Wo6/nBbCiMD8x7unX
 4CnzthKG6xR3NAbGe0Xxx9FzKHowdiF+zMQtk8FHmMmUpsO8b1A5zHuur/Vt+FmyvyZTsGhD6mK
 J6v0NfMa6zfqEukhWjH6DZTcP7TxvNImwuSGqUt4bgJeayyW3Z4MKUyDHVaMOh8i+eoL/HvhGd7
 e25NzHuW9Mn3guIxVbr9lvoYgVhle+P9jlIfexHDVTrCyqpXXO2B1HgO542sJKfnvfFNAcNcvmr
 W60gjTadDBLaQ/m/1qX0iYGXhQn+b9iWyE7/jSp8Nylfxquy18aZ+x3jjdysrOHzck0u1ruO49w
 iAgw2Gz9orlGZYP2DTBHBnOWYNah4klL3za+v0D6ed00YcBr45lg==
X-Google-Smtp-Source: AGHT+IFiEyttinQATkvnQP/AuBEPB0rjXculXC+deU2WcRE/PGCcXVtc+4G2HkbcaloroWpTarWraA==
X-Received: by 2002:a05:6820:1c9e:b0:654:f77a:1a5c with SMTP id
 006d021491bc7-656bb60d15bmr299963eaf.3.1762295876763; 
 Tue, 04 Nov 2025 14:37:56 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656b44cce6csm624264eaf.6.2025.11.04.14.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:37:56 -0800 (PST)
Date: Tue, 4 Nov 2025 16:37:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
Message-ID: <20251104223753.GJ6688@bill-the-cat>
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
 <20251104211832.GI6688@bill-the-cat>
 <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ANiiyFJpW3zPus9G"
Content-Disposition: inline
In-Reply-To: <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
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


--ANiiyFJpW3zPus9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 05:33:15AM +0800, Sune Brian wrote:
> > I'm sorry, but I don't think that's an appropriate response to me saying
> > that if you're using an AI to generate any of this then you should
> > disclose it.
>=20
> I didn't generate any of this via AI. I just use AI to analyze the syntax=
 cost
> what you pointed out previously on the slow down.
> I think there is a very distinct difference. Asking syntax vs telling AI =
to
> generate the code is not the same. Otherwise any copy paste from
> google is considered the same act.
>=20
> However, I should not mention this in the first place because people are
> so much trouble with AI tools these days. It is "voldemort" don;t say it's
> name!
>=20
> Back to the original issue.
>=20
> Indeed $(src) is missing.
> HANDOFF_BASE=3D$(src)/$$BOARD_DIR/hps_isw_handoff;
> and
> python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py
>=20
> With the above fix it should run smoothly w/o the issue you pointed out.
>=20
> So you will insist me to move it to arch/arm/mach-socfpga/config.mk?

Yes, it really needs to not be in the top level Makefile, the more stuff
we have there the trickier upstream merges get, especially when this can
be hooked to archprepare and work just fine. Thanks.

--=20
Tom

--ANiiyFJpW3zPus9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQqAPgAKCRAr4qD1Cr/k
CnyMAPwKnPV4dlLG8wLRwPJKgS7hIneF9IRIV859wedisJ48lgEA8xNyMeUlFsiP
B6LU0654rqi7SfAHkcorPTcKDQ/y4wk=
=XLwt
-----END PGP SIGNATURE-----

--ANiiyFJpW3zPus9G--
