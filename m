Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D9D3B7E2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 19:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A80683B63;
	Mon,  8 Dec 2025 20:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mseGUDfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F8383B07; Mon,  8 Dec 2025 20:34:18 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E7883AEE
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 20:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45391956bfcso2379066b6e.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 11:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765222453; x=1765827253; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yVWl4OpUd6pKPa+mVCFDtHs/6gZYNi/mIZC5jfl6AXU=;
 b=mseGUDfFqpr2PLbfRwa+aOGPcmx09tMmWcatg+Do8T1/nWo6XlE75vKlxkN5FQkaZT
 xQE/I24Orp5NkInkbdu5Roekow5xMqHqqXK6CyMf5HBNfg7p9D3pgbxbOf22N/A4zT4P
 F22FAzzjkeq0pRJVn/BWVMCIBW7huWYs7Dq1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765222453; x=1765827253;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVWl4OpUd6pKPa+mVCFDtHs/6gZYNi/mIZC5jfl6AXU=;
 b=h6jTr4Gfpc7knj/UDfSKnuyeqQhcc3L+T5YkTUC0Jf6hXj5SykuJRHtTqv3tWgd+lI
 5z7hPEYxtr7+N/FB1NsGeihkp8s09OoWPJDCICYdBiBqhfzq3h4CZq2RbXP15TLS2z58
 SPw/NvSM8VoEyDz9wBjmerUXKdie+zJHlx14OApKFIO3MQNnNX+MVZ/MpQKw011gEuwa
 272tABkeV0CrPuxm99sGM8Nv6adY4Qt5IIiXDateF+uYIAKeE/0qOZPtBa9Jaqg6Ie1i
 WSgpnw282nGfFAnbhYK9vOGDjHsbsT5fohCCwzaB8fjSs93TpzDYQIyJpkYgXYuLSmyX
 /DMQ==
X-Gm-Message-State: AOJu0Yz3UR7u/CsAdauUH+kJZVasodvzR5f49KJGE5KYLmSROspF/Dyr
 5e5BFgTtlciLyabIUl19NiJQlOXFxgOPn9LCsGgRXq0W2suNnClf5nH5Bx6x1HVJ/e2L6/3ZQbT
 Z340B53U=
X-Gm-Gg: ASbGnctAEkN5KpduNE7uJXwsorOzqBPUFc7pkIh3bzlxYDZKx///CH70GTrOFzbNJyF
 EKtXKEOsWjv65CXTGFmphALln9P7TkTfo17P96tyODPpWjOF7jA3jEg64cF5sVTcviXOD+KnRhj
 ca5GnTU9mU/IjwXGrUcfm3lySBxD424mnRn6OK5iCGM2ce72l8UkT269KvsPDmOxcCt0E2JtfxN
 XQ+sTfIioJSSKXL8CerT1R/JGn21pUYxSnWSpvnvEiSvu5pLXEla437Au9/zTZudVlH5i0rNXmC
 hchOsHtsq7WHqEtWAPYmEPineCELb1jOLlUap2vFxDI41C8t51M1Bk1eo5TgBZBnHUWzaIo9Ezz
 cX9mfu4p+Tovq34dsTmCIBlD0nnUDv87zXbG3DF+D32JlIyejP7qSedcqdFng6X9yf8zUBkdtok
 KbjjBwzQj+bltzlDzOnaThZOHk+JMKaJX6sFQT9T7qVgxOmdai0g==
X-Google-Smtp-Source: AGHT+IH/UplWIW9N7BVqNwvzf0HAKsizKGML+mU4HwB/aq6c9iQN7KWfXmdIvXmQfjHERlUP0fNINg==
X-Received: by 2002:a05:6820:162c:b0:659:9a49:8fca with SMTP id
 006d021491bc7-6599a975ef5mr4008623eaf.67.1765222453218; 
 Mon, 08 Dec 2025 11:34:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef48d23sm6460602eaf.16.2025.12.08.11.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:34:12 -0800 (PST)
Date: Mon, 8 Dec 2025 13:34:10 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.01-rc4 released
Message-ID: <20251208193410.GR303283@bill-the-cat>
References: <20251208190447.GQ303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZHKOb6FUoSzNpMC3"
Content-Disposition: inline
In-Reply-To: <20251208190447.GQ303283@bill-the-cat>
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


--ZHKOb6FUoSzNpMC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 01:04:47PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and I have tagged and pushed things out. In my own
> patchwork queue, things are fairly solidly for the next branch, with
> just a few things like MAINTAINER entires to update. Which means that in
> general, I'm hoping custodians are looking at their queue and seeing
> what they have which can go to the next branch now as well.
>=20
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZGNs=
NTh2YWQ2YTB0ajAzZXRkdDVhdjFuNmpfMjAyNTEwMjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWM=
wNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=
=3D89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group=
=2Ecalendar.google.com&scp=3DALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> December 10th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
>=20
> In terms of a rough changelog:

Did I forget to fill this in before doing the rest of the release? Yes,
yes I did.

- Samsung, Raspberry Pi, i.MX, TI, SoCFPGA and Renesas platform fixes
  and a few updates
- Network, USB, UEFI and documentation updates
- Various small fixes throughout, and MAINTAINER updates.

--=20
Tom

--ZHKOb6FUoSzNpMC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTcoLwAKCRAr4qD1Cr/k
CjL0APsEsuCQ7bCqdJozLYtOYdG5WzxYO7fVrNskv2zymHshkgD/TZ8KVO1OAfdy
ebNrnCdhmziJxdtdCLw/Jc6gOne1ig8=
=9Oyt
-----END PGP SIGNATURE-----

--ZHKOb6FUoSzNpMC3--
