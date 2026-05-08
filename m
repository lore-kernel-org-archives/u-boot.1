Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF43DCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF1784D1E;
	Fri,  8 May 2026 19:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fOfTGYsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0624084DBB; Fri,  8 May 2026 19:51:24 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D846184CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-42c08cbae4cso1780273fac.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778262680; x=1778867480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vcURqqFtbESSaqolbXtX/dxBwHFNq9yKOoAN2TbVYvw=;
 b=fOfTGYsLD65urFQazmV/qBy04bDfHlk5vgenxa0jsPxqz6tmWMnNSOfr8Fn17OwNmo
 UmkCh2F8MhTA9XBEQwb3pyh/lpvtJIfg37sYCSMdgEGE+C4Onm0SyWuc2d69YewYbx4B
 0+wcuRI0GPeiE7gmYuooD1Wt7Atw6T2MiJu50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262680; x=1778867480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcURqqFtbESSaqolbXtX/dxBwHFNq9yKOoAN2TbVYvw=;
 b=QtnA+9WG6/+YormrqVy7UbmDXy6eEvP9WVTJQEcSVWFy04sIlaBOGeREzM+8KatDBj
 kCg/NjSqfDma9q020m7Cmg/0aRSiPvbNRjySYHAIj+WdLapxQUhPNhp1f9RPXVinzoq9
 6nDCLEljiUs6Nq7qiisdMTMi25caiO7E+2oFI6jbPDdqlJN8E0WLtym3thIq2eO+RqwE
 V8sMkIRWcL0MXoDJ1a/5EP8e5ugpHexOJGG5djzttQaH4r9PH64cgCbDFQFgf1eOgYL2
 xnNLzgkRq2Mvgfzluo8yaZXSsh/zpcgUOeGYMPFH2VmsfQOrsHIQ3QSlKg0x/iwO1lqD
 dXNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80WUduOTxjqinPC/Yu9rjOsTNeVHb8CJYd5Owid+6qAquLsu7hP5zDlPaBPuyaDbIewn8jcd0=@lists.denx.de
X-Gm-Message-State: AOJu0YxrGvkOktA8Z3p4Uf1cyv+c4G8ngT0lf/ion5ad7WYntBKPwtcL
 DNiQZEpghEGzBgYzQTqHTzsd14OaR1UA4sFLzGmqErNb0y5VG7vQO/WHbudtADlcst8=
X-Gm-Gg: Acq92OE7uH2C2p5YfaXkDJMgmfAVvg7LPsmICfwPX8SSbFCU4F+SiKiEydOHApz6Oyw
 TfHdFSLjOFO7wHCNCQyKLaRFgsVwCG0nnsY3kxZL5yKDbKJqD/TuF1oHxM/Kwmi1nbH9CQBga1+
 jI52t0cwlaj6XIOUpALTgGYDx8vAu5IKTquTMywKK0qLZ6tYPKbMX5cjEdznxLEGznbh8XbZHf4
 ur7YhVJxoZMVB+4Al8XPiaCZAJxe5FKlrB3OksCXo5dfZQs/VoVAAcvlvXBX8uGTjZvOGn9svy0
 XP45ct1E1w6Zh1neT0cgoWRCy853EjShsAv9mhFeU+MxPcP8bj9yth8O9VIgQCE+BiMXa+Amspi
 pi90onD08lJWDY90rqobjQd/oovweDlvpXuksIYFcNocGkP/g5c5fow1aS5D07u7d4o5YZmKeXa
 pLpOqWhV6+Jz9LPpWuJOsts/I4jS5rpPvYtr1GU3avZKRYxSAqbhtQHtWj8popM/k6iO13MQbia
 f1/EM4WCiF34IVsB560PpncEbHf5PiYEQOHzPOdLPL5aaYfhEo=
X-Received: by 2002:a05:6871:3312:b0:3f1:6d93:4386 with SMTP id
 586e51a60fabf-434f68b18e5mr9041183fac.1.1778262680553; 
 Fri, 08 May 2026 10:51:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b67sm2192423fac.6.2026.05.08.10.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:51:19 -0700 (PDT)
Date: Fri, 8 May 2026 11:51:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Wade Sparks <wsparks@vulncheck.com>, u-boot@lists.denx.de,
 Disclosures <disclosure@vulncheck.com>
Subject: Re: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
Message-ID: <20260508175117.GB1858239@bill-the-cat>
References: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
 <af4hsnMuwzEKHZF3@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uOge1SmjloWoiejM"
Content-Disposition: inline
In-Reply-To: <af4hsnMuwzEKHZF3@makrotopia.org>
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


--uOge1SmjloWoiejM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 06:47:30PM +0100, Daniel Golle wrote:
> On Fri, May 08, 2026 at 01:20:44PM -0400, Wade Sparks wrote:
> > Hello U-Boot mailing list,
> >=20
> > [...]
> > We have provisionally allocated the following CVE IDs, which have been
> > shared with the researcher but will remain private until public disclos=
ure:
> >=20
> >    - *CVE-2026-29007* - Out-of-Bounds Read in TCP Options Parser
> >    - *CVE-2026-29008* - Integer Underflow in TCP Payload Length
> >    - *CVE-2026-29009* - Buffer Overflow via NFS Symlink Chain
> >=20
> > Please be aware that none of this information is public at this moment =
and
> > all parties involved are considered under embargo. The researcher has
> > provided us with a comprehensive technical report including reproduction
> > steps. Once an appropriate point of contact is identified, we'd be happ=
y to
> > share those materials with your team.
>=20
> Well, you've just posed it to a public mailing list, which even
> includes a search-engine indexed public archive. The mere description
> of the CVEs above already tells a lot (I'm sure any decent LLM can
> identify the vuln just based on the CVE title given the sourcecode
> repo), and should not have been made public before the fixes have
> landed, and users have been given time to pick them up.
>=20
> So I suppose you have to act fast now. Tom, Simon and Marek are the
> primary contact points (I'm just an external contributor, do NOT share
> any details with me).

Our documented process is to disclose things in public. We don't have
the resources for handling issued behind closed doors. I've always
believed bad actors are going to have found problems first. That was
true years ago, and is even more true now in this day and age where
malicious actors can just throw code at LLMs and see what breaks.

--=20
Tom

--uOge1SmjloWoiejM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf4ikgAKCRAr4qD1Cr/k
ChfcAP9GcNCrT8T8QOcl/kDu8k6Ywq0ImDla5+FH2cmUAiuVTwD/RKQwPv7DiU7B
d4SVBqhsWZ+OUFUPUZv8AK2LoRczKwM=
=brn7
-----END PGP SIGNATURE-----

--uOge1SmjloWoiejM--
