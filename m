Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE08DCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E8984898;
	Tue, 26 May 2026 18:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BZ+mIebb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B818489D; Tue, 26 May 2026 18:53:58 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 469D0847B0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-43b4dad80a5so3400487fac.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779814435; x=1780419235; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qZaBUm9TJRLIIF01WomEkUsw5ct7Ho14r24uyUeS/RM=;
 b=BZ+mIebb7ZGbf+6viarNmRiIIoFJ+SLcaJ179ctymzx8IksxukUZX6oA6eFIlnH9Rb
 P6W04FwE2JARJ5F77y0rLNpe6CWk1myuhReCOKodV8CjgHDQIz2DFqddeWHhhCOdZ7pL
 bPLUWZzc7uyc8dy3fqGp3lqdIsVRzUzZBMWAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779814435; x=1780419235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZaBUm9TJRLIIF01WomEkUsw5ct7Ho14r24uyUeS/RM=;
 b=tXOglM8stwgqn3D5qWWV5W4uP3Rg1g4KcYwIfwdKs4bOuENp3qogQAMK8MzHr75ddb
 49c7WSVaqt6kaQyuPk5X+awIMpEr7rgG1xNHZkKem4pjTngNc5841OrLw7JYlQqRvlHN
 mS6kQNSuDXR6Bhf2VBTKGazzLcLUmSpAx0C9gLrWYzot2WmK0kOUzU6Jv2pJ8HvkLLRz
 67rE6R2ZBhBp/NQ/OD+rcDvPOIxTLWiSuTqGaJym4PHrAk0UoJm97/ZAuGwX/Vd70UeL
 Q/8XHSnnMTC2jfRP/rvrZK4YRkbXsn4fvniDGrQSsw3LTcrS5CvODRJaXqBzOHFdM26q
 z/9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vpB3xz290+S2pDQq+9FpNQ5V/2TiRJ7yxfb0HNQ5qUVYl8zugSIegG3+vihWv7pNgtVsXqdA=@lists.denx.de
X-Gm-Message-State: AOJu0YwG74NFlCLwkvkTq1pQtz0mifviiWtuOAeJd4ILLwNPrrSrn+HX
 Dv+JyIuyfM6/cYfVGmmNawZOIrCYwe2r8qNJVexgpwrFp7/SrVQrHgk1F3z2elOINxg=
X-Gm-Gg: Acq92OFKjERJ/aRms95WVBf5u3/LqvdJgalWcZCJF7K4SE/kJfGmowK/nj8EjOQGea4
 C4Ti0jET9qG/Ye+I5C/nn3AB5+rYvRY5OvXmlh/+rExvAlx2GQ8WSzvRVtOaX2Pu7O9GRsCvA0y
 ZcPTIchiDj1LsJ/jltENof5u5D/YzkNmUEiM5NYbQeDZcAx8Pfo8mGapIWYerKu+uiF1zkIyB0i
 J16PL/eSHSq0j/T96LFoZ5O3JHSYSyenGZPcoiQQNRm/NYIs0/yi2Nf/M14/H0/43dBpn6InDqy
 NR1mZ+JdO6TGxCVI1oqf1WUiXsho+yXHYYiIK6e2M1aPpzxuOt5mqNY0WA9ei+hlW2w5iLt/Z3h
 xiq3kNrNLC/9t3fO2NtB/10SVibIQPItH2RZX4mO23jhJEMoOXjL+SQMTReTI0DX27XRaZqAuZ9
 h9WfJ3WUIL9oprZAZy24ugQslC39m9c6eT1GzH3iYQCQakspzIykWynA9XuBBvCyUqYSU/05hEu
 gbhvR0snqvDmAbk0YGOPi4PT3ux2THFjNoyR1TJI6J/WA==
X-Received: by 2002:a05:6820:1798:b0:69d:9b0a:bf8a with SMTP id
 006d021491bc7-69d9b0ac541mr7682403eaf.46.1779814434996; 
 Tue, 26 May 2026 09:53:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d8373a80esm7093572eaf.8.2026.05.26.09.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:53:54 -0700 (PDT)
Date: Tue, 26 May 2026 10:53:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Javier Viguera <javier.viguera@digi.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/1] libavb: fix avb_replace() OOM handling
Message-ID: <20260526165352.GA1858239@bill-the-cat>
References: <20260521165122.17475-1-josh2@disroot.org>
 <64b5a656-d73d-4c72-95b1-3c843b18c2f1@digi.com>
 <87v7cafha2.fsf@kernel.org> <20260526142333.GT1858239@bill-the-cat>
 <ahXPidpyl-qRMOkH@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9EMsgLlI/I9+gTRp"
Content-Disposition: inline
In-Reply-To: <ahXPidpyl-qRMOkH@google.com>
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


--9EMsgLlI/I9+gTRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 12:51:21AM +0800, Kuan-Wei Chiu wrote:
> On Tue, May 26, 2026 at 08:23:33AM -0600, Tom Rini wrote:
> > On Tue, May 26, 2026 at 03:10:29PM +0200, Mattijs Korpershoek wrote:
> > > Hi Javier,
> > >=20
> > > On Tue, May 26, 2026 at 14:52, Javier Viguera <javier.viguera@digi.co=
m> wrote:
> > >=20
> > > > On 5/21/26 18:51, Josh Law wrote:
> > > >> Hi folks,
> > > >>=20
> > > >> Since I am a new contributor, I would like to introduce myself fir=
st. I
> > > >> am 15...
>=20
> Claiming to be 15 does deepen my concern, because I clearly remember
> seeing Josh claim to be 19 on the lkml about two months ago [1], so
> this is clearly a mismatch. If even his age has different versions, it
> makes me doubt whether the rest of what he says can be trusted.
>=20
> I previously had a private conversation with Steven Rostedt regarding
> Josh. At the time, Steven felt that Josh was just a young kid that
> didn't know any better, but in the end, Steven also gave up and decided
> to stop helping him [2].
>=20
> [1]: https://lore.kernel.org/lkml/043CED5F-7014-4776-824E-07E027B7BDC3@ob=
jecting.org/
> [2]: https://lore.kernel.org/lkml/20260423083246.4b32a665@gandalf.local.h=
ome/

Thanks for bringing the further background to the rest of the U-Boot
community's attention.

--=20
Tom

--9EMsgLlI/I9+gTRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahXQGwAKCRAr4qD1Cr/k
ChlRAQDnPIJVsul0tXZ7c0uHiCk20A+A8/R8ngi0I4gW0wDrcQD/Zp/y9TJtLwo9
tdthGmOZ19MlUwhqUc7PhnjvrSAUHwE=
=fIGi
-----END PGP SIGNATURE-----

--9EMsgLlI/I9+gTRp--
