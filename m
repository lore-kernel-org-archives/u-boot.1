Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62071D6A222
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32E588B9F;
	Thu, 14 Nov 2024 18:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="otDfwWcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013FE88001; Thu, 14 Nov 2024 18:33:52 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029CC88B9F
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e60d3adecbso484494b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731605627; x=1732210427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B2Yjf4OvbE4LpII9ixFcI9qGlZc9NHDnIJtYhP40X0I=;
 b=otDfwWcfO5w8Qx0zoKrdQIDsbJgF7jXgT/GcGLoB7W+a+TeM/aXJhXbvwA9BsSbgDR
 NTXg/JcDEh30uDHeAvJGh3pEbzUNnHIG8Qd6sqpAgq+1YJn2xQqpuIephtY5/hkVbvaw
 G6QPosUAMLVw4d7/lOkDXNKMKanCtTnLcNCoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605627; x=1732210427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2Yjf4OvbE4LpII9ixFcI9qGlZc9NHDnIJtYhP40X0I=;
 b=WsKAu0pr+xkqxLS1oQfgijU5NJZ6kP2g8GMM0rmNr5pBlZV85ZSVH6A0Bn3gyzXTwa
 7g2gGGQ5kFKGG6/xjWKzvBYSMf6GK3FjvBtich2KDiDLfk4oZxANUXJwLJ3u1FABdLxx
 1PfydVEVjYpt3ORdfwaPne798VzTHCJE3FEkW+4ruoyu+zkeuzWrc8p6zfD8frlEYU2N
 fSh7QPYcYzUeJOYHWorpdWGJQyZ24ukadg21HwrpsCSD18rbCMUm7Hp3ZguWSwXgghw6
 HnhhyqwZ+QaBqJo2JlQ2PEQbtSz4gD0XDR4KhFRY5+jW5tXFd4ePObuzZ3pouBCvJL0c
 g5Dg==
X-Gm-Message-State: AOJu0Yw3cnzBgv8bhQ60rEAWSWPowjmqrjC0y5zhHd7BXlga7ACQBkrW
 lzyPBACavtw4tBKwiW4UDg+4GE5TJwLbxKEu0EkD1wIRUnnFroxmIa5WtvV4VhI=
X-Google-Smtp-Source: AGHT+IGGyvd8jTzHdA5ymRECoBbi49Wnl9qMFHcpGFNW2xyHNjTwWIAlUu9Rb5Dc6NI1U5PNgqcF8A==
X-Received: by 2002:a05:6808:1896:b0:3e7:63ce:2025 with SMTP id
 5614622812f47-3e7b7bf6081mr3289505b6e.37.1731605625124; 
 Thu, 14 Nov 2024 09:33:45 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b85e6af3sm462773b6e.38.2024.11.14.09.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:33:44 -0800 (PST)
Date: Thu, 14 Nov 2024 11:33:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heiko Schocher <hs@denx.de>, Stefan Roese <sr@denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20241114173341.GI3600562@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <DU2PR06MB8334E5B005467C449D9923BEF75B2@DU2PR06MB8334.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yGeVhqPaK8JlR9+"
Content-Disposition: inline
In-Reply-To: <DU2PR06MB8334E5B005467C449D9923BEF75B2@DU2PR06MB8334.eurprd06.prod.outlook.com>
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


--1yGeVhqPaK8JlR9+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 05:01:41PM +0000, Holger Brunck wrote:
> Hi Tom,
>=20
> > >
> > > We have actually discussed this recently and we have other issues with
> > > jffs2 and not going to fix it or recommend to use it.
> > > JFFS2 should be removed from our configs and it is also not under our
> > regression.
> >=20
> > Ah OK, thanks. Adding a few more maintainers now then.
> >
>=20
> for all the km PPC boards we can remove the config.=20
>=20
> Should I prepare a patch?

Yes please (and I assume Michal is as well for microblaze-generic),
thanks!

--=20
Tom

--1yGeVhqPaK8JlR9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2NHUACgkQFHw5/5Y0
tywhxgwApjo+OnxXXSm+ZwquGXzclchRjA2ya24Ni5EFdluZIyG9gQ4i1TdG+xhA
35O//91uhgy8GMyXycydomctLPiiyIc3L/6GQpQgx0NdVAv9wFeHajrRMUt3Wkr5
aiwUG3Lnb4VMz/l3kotHKRpcBathyc6fGMv0DEx4YoZgQe9FG+NlXbAYVIJVzOUF
K2VWcxZwdoRsSiBzSZ8OkOmoEFLwg1riSitSNee4mpGDCbJVuDqBpggYpe4we9xm
pYm1pqi/uKkRe//+OLWR2qbFkqLwsZmbjGbdCxcvxVEkvSCzuYhfIEsRgpxXhXmV
A14CSC/Y31Pw3eP93Q5Y91/a4HdBImfTK5GJjbUPZCQlDajmiN5ClXRwF6IjTQO6
T2dIxoRHzFPd2PDQfH/G/ueDP3iZW2lGVzy4LinLO3rDBtHKSZXa0kWlN4S1PIqb
QU580d9YKdHA/D0DqgmwQ2/woJG8HjAlXgFyjZ0F1NfQxrsrSDJed2eXlJE+AerA
QUJ1bibT
=t3tH
-----END PGP SIGNATURE-----

--1yGeVhqPaK8JlR9+--
