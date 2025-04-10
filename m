Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305DC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 23:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B9183A41;
	Fri, 11 Apr 2025 01:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o1Tv3Vn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE94883A43; Fri, 11 Apr 2025 01:14:50 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5555483A3D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 01:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72be60c1d7dso174676a34.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744326887; x=1744931687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nzKG3D1rTjFFVw0iLmSqdy5RTgWj7DMkB4IHA/N7irs=;
 b=o1Tv3Vn/x1ELGw6YfK33pv3S7BGRdkKme/WeQD93xu+ZNZ8sqrPsp8rFepScrG/zof
 agp4b6RHVJKqtu4MY2O14ma4hp/Nmatc+QZhHqNtusqI5PIiBnPXzoLOMEO80YvopBM6
 2YSenCjZB6bWsPrUxfO4TTKuxauoezg7QEN+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744326887; x=1744931687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzKG3D1rTjFFVw0iLmSqdy5RTgWj7DMkB4IHA/N7irs=;
 b=K4sDT7J5Udyw2T2mRBzxpU8ElJ88Shqy2B0A7xs0aNnXw/kInFdzyFLWiX+L1mseEV
 zbjg6kUQ7zL7XI0jSqJyoUPn8fAsXDy2OTRY+UZoFtRFHdpzs60qzKjJKa/RpZ3WHM0w
 BQw5vTbqgjMTItBM0Sb7V9nwIUghhVQSqPoPu7/mWJfHgmNgIaxkV8QsVSF7+xpTkHcD
 HIPgSzFFjl7vwVx0OfsH6rt/KnYo9iDvO5K8HOopON3StnOxHI6QnCYkhJCfaWHThdUU
 6ID2dLMNs+WBgDKkferLnKl2A17eHEFRWCXQ9pNH+3F4GPPdmAvwqUUGoTJsqv0Ltc7f
 Y1gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4D7KA1V+oiL/C+7OQIMQXoW51rxR/yPnegkBV4C68mWvjptve0a4PCUudzKvPEcpF2nSOg8Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2hk0Ws1O/FSo/Q8QnHkh7DShVhflfVQDIge2LllBzf462kamx
 eBCjNyheHbpsZYC6mdvQXpKZPaJEIcpXzE+gA2iYbWjWIfemj/nalkSNqtDx0rQ=
X-Gm-Gg: ASbGncuLy5IkciSywVqnSd7eR/OARQ/IGGyv2YALDF+fiukkAlE+TlYQLd1cj0j/yGd
 wv6QNv9yg29otAV9a8C8N3LmDWdhHWUsxqP42/5fSM368+n8+AwNYEvYv0XAqzpPyWOFk0VCc8A
 vqaCsr4rDU0FNkbjlJHUci15Pz5Xb3XXIlRxMPnsRXweV0Ufrdaag2WGeyoYEkHINgD4iVcbHWb
 CfDIHHulaJmpuXWLip3OW53cvsr98k67D8uiIJcifIy05mrsmLCQkJ1FPVaQB8cF0UU7gP8T7JC
 Dj/HWFWdO1jtRkfb+KZjjB2lx4qBJtLTS+5rfGa4k0KBDu4KowDAc3HbylF1rHgTdDAqAhIZ64/
 BPg==
X-Google-Smtp-Source: AGHT+IEtVIE8NNw9IOAEag8sYufggkEA25UMULSIpbyu2o1XIX9fi6qoYmud34K1zbwk4ntukKUd1g==
X-Received: by 2002:a05:6830:611b:b0:72b:8ec3:9297 with SMTP id
 46e09a7af769-72e86509c16mr623491a34.21.1744326887027; 
 Thu, 10 Apr 2025 16:14:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e672bdsm736207a34.60.2025.04.10.16.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 16:14:46 -0700 (PDT)
Date: Thu, 10 Apr 2025 17:14:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250410231444.GK5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ea2j0UdIiZytw2Zc"
Content-Disposition: inline
In-Reply-To: <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
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


--Ea2j0UdIiZytw2Zc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org> wro=
te:
> >
> > Hi everyone,
> >
> > I keep getting an error on running the CI loop on -next on my tree :
> >
> > https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
>=20
> Thanks for the report.
>=20
> >
> > ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other
> > tests will run !
> >
> > Any clue ? It's been like this for few days. It doesn't look like a
> > faulty patch.
>=20
> I can't see that link you sent me, it 403s.
>=20
> Do you have any other traces or information to share?

It's been intermittent recently. I was able to put qemu + gdb together
and see it's one of the early initcalls that fails and hang()s but
didn't see why. You should be able to use commit 1f0281294d8b ("Merge
patch series "Annotate switch/case fallthrough cases"") as a starting
point of failure.

--=20
Tom

--Ea2j0UdIiZytw2Zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf4UOAACgkQFHw5/5Y0
tywOQAv/Y6ixOOdsINxiCqn9ehNlAjhCskSn3AbU1gFAhiPc6ADJXQ5EQV3nWgIJ
uzbBmz0+eK/5ewwhHiITUB1IAHmJKUXM2tQ7QTGipQSr4PEmvAzLG9PBS9/SUz44
a7NRRR+SyIVHpfJpaziSbcIeGUnYym9djQ0yGvIESsvUNx1Z96PMeWANdz4AqF0j
47GMvdsi7JfgsETlmFkJZv6ITSZmZ3zAzXo4lkKGXHkQ7mHZ/h20nfYMJ+PJZfb5
+LHVVjSHkWhdETnM6Hz9+R0BechqN0gyzEROvdnA5vwiHbaDODkLskrI87U2J32s
ztlr6ekZsSt9QMCiB+xCkXeGLOxY9m7trFgpl/aI9jsg75QHIoC1HSwYUxr4lAKs
fNq5RKBA7UpCrFRmP6XJEan746A1333Uv5FOIssbd23uN7vKK4qo1MDVxw9JUTsE
cBIpjKn5ropg0Sne3cXPSNczbBTSBr50NTkxPvD+Euq7mzXfEh9XA/IlbKJcvrTQ
v8uN38om
=rFud
-----END PGP SIGNATURE-----

--Ea2j0UdIiZytw2Zc--
