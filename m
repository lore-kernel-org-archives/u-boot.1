Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2249DC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 14:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91C0182FCA;
	Thu, 17 Apr 2025 16:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WShrLcEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5467F8300B; Thu, 17 Apr 2025 16:16:10 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D32082F87
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60406de9cbfso268323eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744899367; x=1745504167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KcHkSh8a6is+bsR21Co5F8cdyLd8e6NtNzs/0pz9Olo=;
 b=WShrLcEm7eoG6Yx8digRZyoEIzH2c78LLJCSOhT0kS0OYVgzddIguSCywgIimtZcPz
 VSIL1MIi0RF7q4nqup902+XF6RO0+0TtN1M2THq9pdbbayhTnbw16vVUPrAnspaFDxuT
 8LUCJgh5yw6HkOS7naaoNQYvfzYdgfef1lnIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744899367; x=1745504167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcHkSh8a6is+bsR21Co5F8cdyLd8e6NtNzs/0pz9Olo=;
 b=G6oCe5qO6Vg+YL7X3iBbwUl3ANqxH+TP7QcAk77Q/znY4kZ7ELrfvit/iZR4Wp3s1R
 m8zrq8x2+v94UKVV5Z61sTbgzd24ubrjjA4OrXAltuXjgbDkGMdLEP27X6dcZ9A+m30R
 J8ubZ9avoSCeFqJFx8syT3VdjS9dmCI7vPt8oP6FzLW/EV9Esp3vx/VfUbtNW+VksIuq
 Ki5c7WyyE7RfsXG6SMFME2JiWTo545Yxajd1F8uOstNloHnHAMuh4IfTVbMA0JIxiG/p
 UCyDQCTI2Dk/kE/bhTiji3/TOX9UZPmhiBOcG+8y5Ud2K+fFoLB5FFZU+Ns5dKvsPnct
 hmfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4J9CVpv+zZGRjTgP0Q1lmyrsdju6S/8XEVK8etfqffaGF7QANrVxofc0TrGEJtrKFn3oldwI=@lists.denx.de
X-Gm-Message-State: AOJu0YxMnhDKqBnhuQqJ7EjrX7WlBGTDnNAJy5wjt3epmZRbhms68aKF
 huc8tfbklgfnsQ8r2OOWVbeG5nAPqbOiNRqf/zlSbNM+eXf8JVEwZBslzBDswaw=
X-Gm-Gg: ASbGncuJMVudEknI4JbE6yXIJWESSvo0oNHeOP3IyeJe4mpg6YELCtgOasUqvvLN488
 rLJv6mpNorQqTLliSR4oPiEz99OplwJuPYb7C4n3JMH3UG6MqPw/r1xb/XzaCbZedkqMH64bBZq
 T44Xk4Z+ECf0rF3MoyvHfR52KW6hn3iXUVtbHNn3TZ2OB2/tu/qEuXp7I60dm7xgzvFPJBISE8V
 uhs/bKsilt9JHALOFyhm248XuE/TKAGmFRyxx1VVjkwORQnyIShvWy33sy9JRioktoB55J2/93w
 VOrbaFPmnobGFcjufrMtlvxOwJEW6RCKwE79NsjpfpPLKfh1q7EtTlpGzkP9MtA7Jv/cgmReykK
 VW8gVf2RoT31N
X-Google-Smtp-Source: AGHT+IEjPNauAU0X9GqlNJOZXk6Nzu0zUs2nxGmKoiPIkB3GXVYX/wlgfDYQdQ0e6k3RbhrK1UpnhQ==
X-Received: by 2002:a05:6871:d046:b0:2c2:30e9:b15f with SMTP id
 586e51a60fabf-2d4d2b5642emr3819953fac.20.1744899366625; 
 Thu, 17 Apr 2025 07:16:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0968ea417sm3788053fac.2.2025.04.17.07.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 07:16:06 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:16:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, Andrew Davis <afd@ti.com>,
 u-boot@lists.denx.de, vigneshr@ti.com, robertcnelson@gmail.com,
 w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, m-chawdhry@ti.com, a-nandan@ti.com
Subject: Re: [PATCH v1 0/4] k3: migrate SPL_TEXT_BASE to new address
Message-ID: <20250417141603.GW5495@bill-the-cat>
References: <20250416073058.1441001-1-anshuld@ti.com>
 <20250416112418.nod2fut4v77qlmfq@hummus>
 <D983ZXCIAF06.2I0POMKUFPF2L@ti.com>
 <20250416150506.ws22odswwkjn2wth@deflected>
 <8146a036-681d-4c45-9285-c58259fec14b@ti.com>
 <20250416195113.mtfdclfvb756vpll@scoreless>
 <D98SY3X7C15U.15HUGCO6FK1T0@ti.com>
 <20250417113013.mrlhl65farooaiq2@extradite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t0pysYuDtqGHTi9Q"
Content-Disposition: inline
In-Reply-To: <20250417113013.mrlhl65farooaiq2@extradite>
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


--t0pysYuDtqGHTi9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 06:30:13AM -0500, Nishanth Menon wrote:
> On 14:51-20250417, Anshul Dalal wrote:
> > On Thu Apr 17, 2025 at 1:21 AM IST, Nishanth Menon wrote:
> > > On 11:38-20250416, Andrew Davis wrote:
> > >> > > > 	How about u-boot documentation?
> > >> > >=20
> > >> > > I will update that in the next revision along with any feedback I
> > >> > > receive on this patch.
> > >> >=20
> > >> > IMHO, This change is too intrusive and impacts downstream customers
> > >> > including inflight production devices.
> > >> >=20
> > >>=20
> > >> Could you elaborate a little?
> > >>=20
> > >> They do not even need to update their TF-A version, if they want to
> > >> use their current version they simply recompile it with a single
> > >> extra build flag:
> > >>=20
> > >> PRELOADED_BL33_BASE=3D0x822000000
> > >
> > > For folks who are trying to boot linux from TFA, they could do the sa=
me.
> >=20
> > This change would allow us to support both standard boot flow and falcon
> > mode from the same upstream source. With the only downside being the
>=20
> Other than trivial usecases, no you cannot. There is a lot of
> monkeying of dtb that u-boot does with mac address, HS-FS based dt node
> enable/disable etc. In effect, at a product level it ends up as a differe=
nt
> flow.
>=20
> > slight overhead added by the jump-stub (~1.7KiB added to tispl.bin and
> > two extra instructions to jump to u-boot from older ATF builds).
>=20
> The boot flow is already a complex flow at the moment. If we go down
> this road, U-boot will have no choice but to support both variants of
> TFA for all eternity - any fallacy that people will upgrade U-boot and
> TFA baselines in sync is wrong.
>=20
> >=20
> > And we can remove the stub altogether once all the customers have
> > migrated over to the new address.
>=20
> When would we know? There are gazillion usage models we are not aware
> of. U-boot is not the only game in town for bootloaders. Barebox, and
> other bootloader ecosystems will also need to pony up, that too hand in
> hand with migration to new address proposed in TFA.
>=20
> >=20
> > In addition to that this also frees up the bottom of DDR which allows us
> > to more easily support low memory systems (512MiB or less) as we can use
> > the freed up space for more tightly packing OP-TEE, DM etc.  instead of
> > having the binaries loaded at scattered addresses like we do now.
>=20
> Now, we are suggesting an entire memory map revamp impacting more
> s/w components. For platforms with low DDR capabilities (e.g.
> PocketBeagle2), please do the necessary changes when introducing to
> mainline.
>=20
> >=20
> > >>=20
> > >> They should have no reason not to be able to do this. But even *if*
> > >> they cannot do that, the whole point of the jump-stub here is to
> > >> save them even having to do a simple compile.
> > >>=20
> > >> IMHO "downstream customers including inflight production devices"
> > >> should not be a reason to block good and useful changes here in
> > >> upstream. But again, this change doesn't break anything for them in
> > >> the first place, so why bring that up?
> > >
> > > I dont see a specific value here. U-boot just works. For folks who wa=
nt
> > > direct TFA to kernel jump (which is a niche fast boot usecase), go ah=
ead
> > > and use TFA with the mentioned build option.
> >=20
>=20
> IMHO, there is a simpler alternate solution - build TFA, dtb etc in the
> model of your desire. let us leave the defaults be.
>=20
> I will let Tom and other U-boot maintainers make their choice, as TFA
> maintainer, I have already rejected the approach. it is already
> PRELOADED_BL33_BASE ?=3D 0x80080000 which allows for override at build
> time instead of all the massive rework and downstream ecosystem impact.

Thanks Nishanth. As you point out, all of the relevant projects need to
stay in sync for this to be useful and I agree with your position so
this is nak'd here too.

--=20
Tom

--t0pysYuDtqGHTi9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgBDSMACgkQFHw5/5Y0
tyzLqQv/T8VuX9Wddf3QIwY+oB7fi/3vFKtVDbbwHktVdDzlnyKyp4ZXyjzEUhOZ
SAAfCQUdQ/ReeKhaZOoih8IvTR/Y9/vTGYR9l/ecULPGvBMTi+cEtqEEpNoDNGqT
TpEVb4XPsjmFWC6Evy91sF8sZenwQS3N7FAxcCP+JOsG223n0AiB63jxtWnBwC9T
wVp4NvS63U9LKJSZhsAa9J8JeM3IXTj8mzJXqZiFM3cHY+7nSzxR0dI44HoOJ1Yw
U423z4HitChmEoWTttndyITP/E8JbZD/kLYbX67SCnLVIDCzwsNGVFMTvXTbaoH9
mxbdSU6fGdIJR2nIdDkV3GN0E52OlfxcswG0yJHGae7WT0voZUj8lnc+yjSGeqBz
SCGhAo31JOk1xF3EvUKIRNj6pDXSOBxCnJj1NFJb3fW7na0YN2sppNq9gE9KelFm
whSsgyMr2JHlJNpqVA0fY+MREKErQnfCcQAyA99iAJO4pyytOQjP8YSyZNzX8c/2
BShjq1Ku
=rAHz
-----END PGP SIGNATURE-----

--t0pysYuDtqGHTi9Q--
