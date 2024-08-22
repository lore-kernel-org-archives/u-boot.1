Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF7AC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05412887D4;
	Thu, 22 Aug 2024 16:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pp7GHGWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9A0887D4; Thu, 22 Aug 2024 16:14:25 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0F6888A0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 16:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-709428a9469so641590a34.3
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724336060; x=1724940860; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3wnV2lBknLIy5OgzDzERH8qvC2q8wUQXCYQWS81wamw=;
 b=Pp7GHGWPD3XJ4p6RhB20IJIhbjn0BPzv1EhCKQAH70MP+ASpCCAXmtSJ/0npIRpe8G
 w46m5VIgDF9w6NbllRhcAu2FfZaP7cgXx31vtYpV5noWvDaNteLmvesEEOFUo6IEThfr
 bXSDlLUpHeP8fCxEmjvNmHViVLj3nh7rAEYac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724336060; x=1724940860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wnV2lBknLIy5OgzDzERH8qvC2q8wUQXCYQWS81wamw=;
 b=Nhs26+zMZJ5/4ElXXCgRzWsBNL5AWY/kBFHZprQFt2+UMcw8MBENPuMwhkzmKSyIwv
 vwT6imPAAGAu9JN/MVSVLCKPQZDhusKoCnzjhtNPvGqXnVhxqSqqNlJ6M4RvGehTvdnM
 ylsNWj8mtPCdnf6XdUqFewsPBaFmceHXElJBazBD0wkYxGkyjNdibPAV4kQTmnVuaTGm
 VTrhU4ldavGvoOSuBiVEAK7175l/brTrp4UIBDAkjbEz80GJE+03ZUU5cTVku0Hd4hII
 iyw0yfKmDDuGjcFR63ler8MVu+V2aJWDr4mS6ylPfngdt9JzG7920gxnUVHH2FTMz3TX
 lfyw==
X-Gm-Message-State: AOJu0Yyb3OjIT5a4S2z4psAChkEqgq8sceVnOnClm8AmSyaNar6S78RP
 amgY2QH5lEHgtOR7VMZOiDV4NzjwML21LRt8fR4JtDzwWUFlOmpW5zOA1SdiHdI=
X-Google-Smtp-Source: AGHT+IElg0c0mH4nkUOm+cFfHHVlyfr4tFtAP0xDCXAtSHutJlht9bWBYD+9WwX2lbzzlBF9BKJMTA==
X-Received: by 2002:a05:6808:338a:b0:3d6:3450:7fe0 with SMTP id
 5614622812f47-3de22fd31e7mr2260972b6e.9.1724336059753; 
 Thu, 22 Aug 2024 07:14:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de2256d788sm291226b6e.25.2024.08.22.07.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:14:19 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:14:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de, Claudius Heine <ch@denx.de>
Subject: Re: [ANN] U-Boot v2024.10-rc3 released
Message-ID: <20240822141417.GS1626301@bill-the-cat>
References: <20240819231535.GK1626301@bill-the-cat>
 <CALeDE9NvYUqCsv8L4NurYtBfe4VxF2p-+_qG85EphP8YKhYWWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="diAWQJU964O/5+Uj"
Content-Disposition: inline
In-Reply-To: <CALeDE9NvYUqCsv8L4NurYtBfe4VxF2p-+_qG85EphP8YKhYWWA@mail.gmail.com>
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


--diAWQJU964O/5+Uj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 08:19:12AM +0100, Peter Robinson wrote:
> Hi Tom,
>=20
> > It's release day and here is -rc3. Things have been mostly quiet, and
> > with the -next window firmly open I believe things should remain quiet
> > moving forward.
> >
> > In terms of a changelog,
> > git log --merges v2024.10-rc2..v2024.10-rc3
> > contains what I've pulled but as always, better PR messages and tags
> > will provide better results here.
> >
> > I hope to remain on schedule and that means the rest of the rcs every
> > other Monday, and with final release on Monday,  October 7th, 2024.
> > Thanks all!
>=20
> There's an issue with the tar ball at https://ftp.denx.de/pub/u-boot/
>=20
> It's onlt 11Mb and there's no .sig

Oops. I had some local connectivity issues right then, but I thought it
completed. I've re-uploaded it now.

--=20
Tom

--diAWQJU964O/5+Uj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHR7kACgkQFHw5/5Y0
tyz7GQv9HlBhHJtTDSdX8N2FjE2fTjkOsA90pLMePGvZ08SguLYj4bBZ54wUo3Ax
lFEprSCX3DMTyfHoybBveVm6OGh5GP1RCaoxXw1iZKbmRceK/pF48hfN/VTBGJ8W
ag/MNtgrgkiY9CsXRdEofcMj6ETgGq0yg4EJx9ikU43OR3VlONkIwYzbQ8RUohGq
dGqFmXFx3ewaXXsuPnhTew6WoADRoPd0T2fMzdsb+GQKt3/7hCNDfArEWxcwgJTi
J5afb2ZZ5/nTtDHHyCpB/6BYI8+7ZsFqjrR44qvuEXXEUDr8cHIYYwIZmb/jQDvi
b9HqL+8ptDNaXoKi4JNGmJImvREQyiPiHv7f3Yda+jhV6ra/PHsBwUt6wFxlvPdj
H0EVLWpeuLCaugjPcqX02S+MmsdUuAuRMpSFHqbLu/hWvGY7HAQfGyL5bYPr9I3d
PhMxvQnqOD77rOXORhrYetD9A1UnKx4tYlkeR29uTgP1LWOihqAo2ayubu9BRafZ
UGC5EUXC
=r0R2
-----END PGP SIGNATURE-----

--diAWQJU964O/5+Uj--
