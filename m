Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15933C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743E2812BB;
	Mon, 27 Jan 2025 22:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GjqNV3yD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCBD812C8; Mon, 27 Jan 2025 22:23:28 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4B78129B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so731338885a.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738013005; x=1738617805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HLYt3RxrdSkOdaArMNV5VSGNXhbNfV7aSQkipqVGK5I=;
 b=GjqNV3yDupZXjSgk12SuUHne1Eq3UoSv+txmXWvlbEfyAuvUPf2KBJjm1k8xZ+kfO0
 P0JnrR1KqpUc1eNYqesE2ODzLAcV6SZ2Ivg3dwsW3fz06XbBxS7LCd3BuBPAxl6R1ULc
 MidhzGPOMKNh5SbcnVIMibKEqrA6IbIpCSOiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738013005; x=1738617805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLYt3RxrdSkOdaArMNV5VSGNXhbNfV7aSQkipqVGK5I=;
 b=aNF4qgS8xmOpyl3EYNnIsPdmPMRWbb1EaqI8dJ+2fJPDQkvAIFZ9vUq5rex0aVlThx
 isvfqWR3aVE5HpIm0MKElBdQ4bZb4+OwPg2cKXsrCLBcs59YEXj/ETKKHqO6VVzrHNBG
 0xl9pP3VBpjYA98Qz27TYJBCnmxWhIirVA5GwcIF+IQcu+8zhYOo+MdPAlCSZpRHS66K
 A5Fr41HsEc2llWIs8CVKxucP81bY1Ni06T1cQHq8u6pXEP9QmKjqlyhOhO0iwLwemL0O
 lKiB5XhlElcXfzv//v9djrJkE7ZRTYEbg3fe4imEfEFrXlfgfndL/nsU27AU5XJ7xSM1
 twzw==
X-Gm-Message-State: AOJu0Yy3cbrT7o6pwR2OaGzKE2iVD+dzeMbMd6AfySQCW7uRuaSdVQin
 rYkOr7muWZQHqYHPUDMj6s9J98Qnn0n2TtGxpzMUGokFQWQft6m16DN2YQp+4tki2IpWR9aO/Sg
 Q
X-Gm-Gg: ASbGnctnyMXRUPYeUV4fS6QL2Zaxox4lRUDtjM+zwmz5PkoWbIjvZFtbyaMgIkJsSuo
 yIbon3yX0fY3nukIQ6iw/+eGdpL3AnFNHfE8GkLoZ88PskLKO1hBWuLp4OMovU36PxhwPUbDO9V
 TS+3WwM52wQnPcpeI+QGIWxwkdKxVzsyIdvhks3hPOlUtfuq3z0g/p69QoGIHr70i3BO9rqbdUK
 1dTp3wcMYSqwvN7QCIr4XkFLkTGkbE7Fe48uXVA3YfTSBC94B2EcQqdGXnATklO07lqXSUPsnDh
 qLWv
X-Google-Smtp-Source: AGHT+IEN7jwiyCcaGWSVZq70ikJsNuJxSboWSKpCyYeN/ZgjgVzHii4PGWdXYMy+d4fOK5zufm8tcA==
X-Received: by 2002:a05:620a:2894:b0:7b6:e47a:8e14 with SMTP id
 af79cd13be357-7be6324fb5cmr6716768685a.35.1738013004871; 
 Mon, 27 Jan 2025 13:23:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af03b6esm425928385a.92.2025.01.27.13.23.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 13:23:23 -0800 (PST)
Date: Mon, 27 Jan 2025 15:23:20 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: Invitation: U-Boot community meeting @ Tue Jan 28, 2025 9am -
 10am (CST) (u-boot@lists.denx.de)
Message-ID: <20250127212320.GG1233568@bill-the-cat>
References: <calendar-926beecc-acd7-48be-8677-baa3d3be0394@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gvblu1kZnETrkAL6"
Content-Disposition: inline
In-Reply-To: <calendar-926beecc-acd7-48be-8677-baa3d3be0394@google.com>
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


--Gvblu1kZnETrkAL6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 09:16:02PM +0000, Tom Rini wrote:

> U-Boot community meeting
> Tuesday Jan 28, 2025 =E2=8B=85 9am =E2=80=93 10am
> Central Standard Time - Bah=C3=ADa de Banderas
>=20
> Join with Google Meet
> https://meet.google.com/btj-wgcg-euw?hs=3D224
>=20
>=20
> =09
> Join by phone
> (US) +1 224-585-7864
> PIN: 107799403
>=20
> More phone numbers
> https://tel.meet/btj-wgcg-euw?pin=3D1307528552322&hs=3D0
>=20
>=20
> U-Boot community meeting
>=20
> Guests
> u-boot@lists.denx.de
> View all guest info https://calendar.google.com/calendar/event?action=3DV=
IEW&eid=3DN280N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgdS1ib290QGxpc3RzLmRlbnguZGU&t=
ok=3DOTAjODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhYmQxMWMxYjgzNjA2MWFlMD=
ZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5nb29nbGUuY29tNmU1M2I5ZWI3N2M5MmQwZ=
DQxOTczYzg4NzZmMjYxMDZkZTlkZjBmYg&ctz=3DAmerica%2FBahia_Banderas&hl=3Den&es=
=3D0
>=20
> Reply for u-boot@lists.denx.de and view more details https://calendar.goo=
gle.com/calendar/event?action=3DVIEW&eid=3DN280N2tlcXE3aDVtbjlicnNkcm82YnA1=
bDAgdS1ib290QGxpc3RzLmRlbnguZGU&tok=3DOTAjODliZTdiODEzMTM2YmVjMDZhODNkZTRkY=
TU5NzQ1ZjBhYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBncm91cC5jYWxlbmRhci5n=
b29nbGUuY29tNmU1M2I5ZWI3N2M5MmQwZDQxOTczYzg4NzZmMjYxMDZkZTlkZjBmYg&ctz=3DAm=
erica%2FBahia_Banderas&hl=3Den&es=3D0
> Your attendance is optional.
>=20
> ~~//~~
> Invitation from Google Calendar: https://calendar.google.com/calendar/
>=20
> You are receiving this email because you are an attendee on the event.
>=20
> Forwarding this invitation could allow any recipient to send a response to
> the organizer, be added to the guest list, invite others regardless of th=
eir
> own invitation status, or modify your RSVP.
>=20
> Learn more https://support.google.com/calendar/answer/37135#forwarding

Just to confirm that this is a legitimate meeting invitation.

--=20
Tom

--Gvblu1kZnETrkAL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeX+UUACgkQFHw5/5Y0
tywRRAwAnBlSneoGCG695q3ObkbfcDKvVAvOOpX2bjsiN9XQPeuDNdGKvwy1aDAQ
dRycKgRD1pn4QKXyF+w+g01If4+vvJcQUtwWp0cs2IOxf8d8hGLNhdGOJ/vNKu+h
OUwjf6tVPgBBqkYI+SmpcauWXYt6oaury6i40Q1ZFpTy9P7bgBlLRJM51KAt9hmH
VzgUUIB9eHgwvbiAkiX9al8DbvRvlNPjmVXLto1LY07mlkBPd2/yKvxWSUr++SHq
xeSLoigKeBYjnX91KKDJx3CNxc3eNPslcwAzD7Atk32xv31uT46231mUfGTiNSYa
gFgkaOe3uKPC8WUJja6wJthHKa9rwkhrYKq08Tl0r4Zh0WDLypPMMQ9Z1aHgpXdq
jgfcAhsmKrlrafpTcHJcXCQ6BfQfx/DAm8UlfjCpG2afurCldRYTp0cxFlBcklzM
mQQkjVXuSPA6aMHoVxUzgSEP5narmGq0dCQsVTYQCC8NK0aOlkjp+uqKBv71X3yA
Qf/r1Oe6
=t/jG
-----END PGP SIGNATURE-----

--Gvblu1kZnETrkAL6--
