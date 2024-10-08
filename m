Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB0CEFC35
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 17:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7533D88ECD;
	Tue,  8 Oct 2024 19:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ws0WQhki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2647B88ECD; Tue,  8 Oct 2024 19:40:43 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B9C88B1F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 19:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a9ab721058so3511185a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728409240; x=1729014040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xHgCr0CiBF1oxLDzZZURp1Gd9PtUvD+a6g55qNdP6yA=;
 b=Ws0WQhkiGiUwuSiZ/1iEZj2ckJ7/YBqCHXLXKqhfarMZM43sC0bkRLSlRigYkRRAhV
 +dl5RXrEGKeUKmmNBLcSKvBClpSTLZyhM7tRRLKsNEDMmPbKoAFhXdRlmhOUvQMYYyRW
 A7MXB5yffYU0IP8WRvU8mM6L8WFEkkWNJol3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728409240; x=1729014040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHgCr0CiBF1oxLDzZZURp1Gd9PtUvD+a6g55qNdP6yA=;
 b=EkIPYnZYHjUwWEP+AEYugdmbEhnRA1+ZUKBP2QeY1xFYxdUfeWTK6LEcDayRkbycrd
 i+qseHEAHXNSRfr7XSKCIttmpNXGL8k3dr6WMpcwJHF97o51eMP5cLZXig15sl5yaOw5
 yhegnmT9E+OYve40k/4qormyrN97BfADwb9vvrkRbasle8h5NOx8FsxOL7y/de7F87Id
 WpvDXCPAWnFKS4MQ57HvQsLtIlai6mgsbP3leYzMSQru6d9TgkxJObmaRh5jOObwuAIt
 mjyPmxqE83lL/hOVyJVpctgTBiWWA4VYvZqrMVOr4E7DVn3EmjECwZtabZxbpbdh4/In
 QVkw==
X-Gm-Message-State: AOJu0YznRgLsID5G7L1A53FH6oRtXuor/Zg7V3LA8yqu+ZkigEIsG5+z
 CyoYofgJmNY7hdUyj2CSOy1eWP1oIf9FKIaWmoJn960jktdDoRLiFufInLzGYuo=
X-Google-Smtp-Source: AGHT+IHg7Pdlar5Mwf4oyBf9C1wi8qIebyO3L8oTccDTQQs9VRcLgpzR5abJQr30Asials13iAXeQw==
X-Received: by 2002:a05:620a:1913:b0:7a6:75e6:3c21 with SMTP id
 af79cd13be357-7ae85f022f0mr578596085a.1.1728409239833; 
 Tue, 08 Oct 2024 10:40:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45f07138b02sm3690111cf.45.2024.10.08.10.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 10:40:33 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:40:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2024.10 released
Message-ID: <20241008174021.GE14210@bill-the-cat>
References: <20241007145651.GU4737@bill-the-cat>
 <8d4f1b21-3e5c-47a4-aed0-790db8cc6331@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xvdf/kbrM0H84qna"
Content-Disposition: inline
In-Reply-To: <8d4f1b21-3e5c-47a4-aed0-790db8cc6331@amd.com>
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


--Xvdf/kbrM0H84qna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 09:22:50AM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 10/7/24 16:56, Tom Rini wrote:
> > Hey all,
> >=20
> > It's release day and so here is v2024.07. We had a few last minute bug
> > fixes come in, and while I'd prefer they come in earlier in the release
> > cycle, I'm still happier people are testing before the release comes out
> > instead of after the release is out. I want to thank everyone that's
> > contributed to this release, not just in terms of code, but
> > documentation, testing and otherwise ensuring things go as smoothly as
> > they can.
> >=20
> > In terms of a changelog,
> > git log --merges v2024.10-rc6..v2024.10
> > contains what I've pulled since the last RC or:
> > git log --merges v2024.07..v2024.10
> > for changes since the last full release. As always, more details in
> > pull requests (or the tags referenced by them) will result in more
> > details here.
> >=20
> > The merge window is formally open again, and I'll be merging in next
> > shortly. v2025.01 is scheduled for Monday, January 6th, 2025 and the
> > merge window will close and -rc1 will be released on the 28nd of
> > October, and then the next window will open with -rc2, two weeks later.
> > I'm also trying something slightly different this release and I've put
> > -rc6 in for Monday, December 30th to have one more tag over the end of
> > year holidays, to see if that helps with people finding time to test.
> > We'll how that went in January.
>=20
> Great. Can you please also sync up defconfigs after next merge?

Ah yes, sorry. The downside of the "#include" mechanism is that I have
to un-sync that. It's not overly hard to undo, but it means I need to
work on the commit rather than just make it part of the release flow.
Done now.

--=20
Tom

--Xvdf/kbrM0H84qna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcFboUACgkQFHw5/5Y0
tyzW+gwAgaFrPsE2s0uKqtrdwvGWvN+BUlqj4d0DAGKDt8dR6N18KWZHeNtVD4Ne
UXO7pZ5YCyXfdOoiA3P4ekN+Tdpn8qoHEf3raxov7Dl2A60tFxhQAQCjQ4HcGo2I
2qNLgyR2PIE4oNGalDOg/PLpAr0iZtcwEJUijFabrEH+Co0PNafnERuTSJP8KKSL
2nfnoyC0hiJsyi2DDZ3juOnZT2XbkaDysKyqHLTIAqRBxDwFoSYW3bohtXNus6DN
kCv+O3eTgueQj0Ta/XGMOBqakVU3Zst6N5oqgiMv9HWVtXpokN7ZfX4ICnYc2LTD
Vc+U7LJR+X9oaSiVMglfqwrV5HmsnHqFclYHKzCFQEPjWcHBXuxPxBm3zgzczJnw
BTUjoT29uhZe0OAqbyzwEFpRoVZrVDvv+HUErbaf4C9sbhxptUFDKNbno6uJV897
yzJ2obeICCwafndUqyFrSdWaid29UzrprOisdrunYbUbW5qXRKZDFiEgaKeMOD6s
MS8Kq80M
=q+6Q
-----END PGP SIGNATURE-----

--Xvdf/kbrM0H84qna--
