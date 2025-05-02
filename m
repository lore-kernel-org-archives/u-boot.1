Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FA7C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175EA82CCE;
	Fri,  2 May 2025 17:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ym5Kak/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0A982CF4; Fri,  2 May 2025 17:04:35 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3519982CC9
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2dab7a32fb7so344659fac.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746198272; x=1746803072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QLP8sh2TpDCKtV1tojGPwrbmjsMJX9Aux/3Y3TiEZmA=;
 b=Ym5Kak/MFnm+ZKa045xy6IjStXhYYthbRHdjres/D4riuihsRpbS6/TNU0Sj5FmuII
 PZqcFVZKJ50vCtmqmAks58QIKmEptiYAOklqeH98iJYJ8ngBB9TjWV/LGqHhEIQOcd/C
 hIyJn9inEHgMWj7QU/1+QJn1mxyor/Sq/4SKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746198272; x=1746803072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLP8sh2TpDCKtV1tojGPwrbmjsMJX9Aux/3Y3TiEZmA=;
 b=rhTZqGq3dZ/Uvcboit/zziZ4buH9c3DOQ3ZR4PPeWhnk2Adcn1M/GDYoEW4q0DwYKB
 +0RTlmb2K/BFL2z+G73amWpYM25+7BrZz/uR9pUdIbKJe3d/0fQXZUJfMG/jB4qz3K2h
 1SMY71aUBdoUtPRW0IHC0+aI6PNN4l/xyNzYotHAD0Tti7ZlyFHMUodfiJQmwMk/7dc/
 acoE0P0NtbI/Jx+kVXnbRNENLGv8L9okIbaAK3HpwEL0RPc6FP+tvHH/e1OrY+90VW07
 rHtT0KKxQH2C+NeAIx/egslG4438qJBh653u+UeYPwCYkQew/TEYqaUezmV7Im+FWact
 QNyA==
X-Gm-Message-State: AOJu0YyAilut5rhkHwpc7l0asQSY6fGwaNsN2xcRRtFSH2rhEd4yfw5q
 yTN46irfeD6VsZ4OSdtXrOx2RLNe5S4pibzjg1kVmCoB8JDEqzx7wG2b1LOvvxc=
X-Gm-Gg: ASbGncsKt/XM4mllc9bIpPI09zciuzAiG9M4Me2ShePj1jTqY4DfH51XCj8wUdsmVna
 HIZ3ITNjc3oXjHFS71JE3qi4tfLY82FSMvzUbXfQ6hRN2F/X7tn2+WRAlNbAkHBti7QKuKBgtu/
 sjJbwi+FkkkY/z/OvnuKtt+JqXbmkuuoU4xGsp7HtfJovSqnkuFvoiJPInZeoOZky8O551CQSkY
 2nncVQAKF9S93gGA+xVQIZ+P96JTKS0Im/Ihz9wQ0C6LG0DXTVCdWnL3w0rOGw+CQlxxM1Pxm2/
 pvmRbb7haAfrBUYtqf/qO0UFD7/DwXLeEQ5gxADNe6G8w/6nB679B+v3qFK79FGrzjNSCvPGUip
 Gzg==
X-Google-Smtp-Source: AGHT+IFgKAVtrf5rHKbAmMiPqtcCfEujjM4bAR5OnwA2Wi6TWdUMWcxLr26zcUY7vggO0wmzo2jvsQ==
X-Received: by 2002:a05:6870:8301:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2dab3274a25mr1649024fac.30.1746198271594; 
 Fri, 02 May 2025 08:04:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31a26e8sm523834a34.9.2025.05.02.08.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:04:30 -0700 (PDT)
Date: Fri, 2 May 2025 09:04:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: Re: [PATCH v2 02/22] congatec: Include env.h to permit reading the
 environment
Message-ID: <20250502150429.GV1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-3-sjg@chromium.org>
 <20250501140617.GD1261075@bill-the-cat>
 <CAFLszTirfZExTrcmNWZrjbaz0Av5VCCq6q1iLwoxCdG2KrmDVA@mail.gmail.com>
 <20250501153316.GH1261075@bill-the-cat>
 <CAFLszThcmQYqXO8rqiYKS-1TdyXcTbfTuaOTa3W8vWMTzKn-YQ@mail.gmail.com>
 <20250502140649.GQ1261075@bill-the-cat>
 <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8t5309HOUSIOyC7O"
Content-Disposition: inline
In-Reply-To: <CAFLszTjqhnJNvzRUx5UD0ibSOnu+fFUCJa8CUDrTYy7vw1cjyw@mail.gmail.com>
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


--8t5309HOUSIOyC7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:52:37AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 02, 2025 at 07:11:56AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 1 May 2025 at 09:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, May 01, 2025 at 09:04:45AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 1 May 2025 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 30, 2025 at 07:04:27PM -0600, Simon Glass wrote:
> > > > > > > This file reads from the environment but does not include the=
 correct
> > > > > > > header. Update it.
> > > > > > >
> > > > > > > Drop the unnecessary config.h while we are here.
> > > > > >
> > > > > > Are you sure about that? It was explicitly added in commit
> > > > > > ab61cc7d98f6 ("board: congatec: Remove <common.h> and add needed
> > > > > > includes") probably because of CFG_SYS_... usage.
> > > > >
> > > > > Well I assumed it wouldn't build if it had it, but perhaps that is
> > > > > incorrect? I understood that CFG_ things had to be values and you
> > > > > couldn't #idef them?
> > > >
> > > > The cases where in that series I added config.h were for good reaso=
n,
> > > > either failure to build or tricky size change reasons. All were
> > > > intentional. An audit-and-remove of config.h would be it's own seri=
es as
> > > > yes, there's perhaps not the need now as whatever complex chain was
> > > > unwound.
> > >
> > > Oh dear, OK. I'll respin the series.
> > >
> > > Hmm but I see you have sent a series that does some similar tweak[1].
> > > What was the goal there?
> >
> > I fixed your problem. Please don't bother re-spinning this series, it's
> > not clear what problems it's solving correctly.
>=20
> OK thanks. The problem was trying to include net.h in include/efi.h:
>=20
> https://patchwork.ozlabs.org/project/uboot/cover/20250501010456.3930701-1=
-sjg@chromium.org/

Adding headers to headers needs extra care (so that we don't end up with
massive implicit include chains).

> So long as that works, we're fine. Having said that, even if it were a
> problem, we could always refactor things to put the Ethernet decls in
> a separate header.

Yes, if there's some problem down the line then some refactoring is
likely the thing to look at, not adding more headers to C files (the
right path is to unwind the header chain and fix C files, your series
doesn't remove env.h from any header).

--=20
Tom

--8t5309HOUSIOyC7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU3vwACgkQFHw5/5Y0
tyzCAwv/XpZAqbix/ZHZ/fsSorh0ZikNGw2ODnqREwFYBrzraZ9ND3Nc1VH4FwHO
FRHS+P/7BeYMtsYIODRtVz/iuLdMxUW/FKDMjXkrTNi/zEpzFJKFmFr5kEgpf1Ca
VUpJ6Cx5OsGBfsQD50FW9D0v0pqTtvuYNXrAoqu3MrALbXVlimw8eODBg/GeQvwB
hf2UCi/kh9mdd3R3ReHxcJ7co2DK3aTOSQD8i7v0BG3Kkku7KHQ3+MiYazwGqSY+
Gc8NRr+d90QBusgMhgBjjR0OVc5eyE2I4iW70Ey9yHnWz1DI6kYhdPjuQzAkDDg/
k1RmlfrkJ++n0xs1ykeSZPEZfjG6a6iJntsIkVRxHHoPc1ZZQNi5GaVcru3f7jTA
aB5IQmLFgQiPqUravCwFJqGs9pbu9Uv8heAP62aeVQ0xQHEEvX+tFX4C9IzblNlu
bZ3AN3i9vpfc5mDQwq7P/gt8XmsXFXiTamLaFvsh5CuogwjIm89ZuIpHr4X8Q/4v
UmJq876P
=hyxO
-----END PGP SIGNATURE-----

--8t5309HOUSIOyC7O--
