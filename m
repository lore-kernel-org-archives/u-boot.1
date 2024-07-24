Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A7AC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BCF889A6;
	Thu, 25 Jul 2024 00:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkfzfGTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC8AC889AA; Thu, 25 Jul 2024 00:40:33 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96838899C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-260e5b2dfb5so140861fac.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721860830; x=1722465630; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nIQDZ/utEjXuj/Djm/2cKKWFrz1GWkrEaURwXpKeAe8=;
 b=mkfzfGTeS7uAdfU/AZmCgNr3hoiA93aASTnaY0cXq2U6+EQjpy4FNf40zakYxWmMJb
 Z+/dj+DaZk0kq9fjhyT6yGgHZOWfFq7k4gSMk/cZH4Rh5ERrEZ4QAFbyGMTBFpMt864+
 SoyH66P0TZ2eoSvaiVT3B1GNsxXSiBHeQ6jV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721860830; x=1722465630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIQDZ/utEjXuj/Djm/2cKKWFrz1GWkrEaURwXpKeAe8=;
 b=t+7WITl+pICOMR+tavBcSk0gmouaRzzp18/0PTK517KMTO8hWb/5tai1CcaSZA2vko
 F2KJX1/5YzXekIvxSPLJ8ZMO4mOV5UysxuXbHUPyIrV/QspVL4NBDm08UrTp8uPdp/ou
 atsQGx28kSCo/jeuvhey8hXfXMcXkHno/MEA8em2N4olta+kdCIpexulVxwacyhLd5gL
 gMjxTwm940O879R+r7O0flfbRcYLrpD/SocMykKziOnWoqRfApprTRURD3Lwh46emzN0
 AmRGKNB/bVWhpfmvJ3OO9Wz/A/kgra/eYZGukgnTozi3g9wxMOJ1Z4VjefNaD1rtr3gf
 sz4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfz6lHsFTmN3GqlMttYpadN/Tfq0RengTgyxIvU1YYz+4pkY9DW6UL7yPY9B7uWbu78ENHjDMw5QQ7oNj9SMjqQh4ppg==
X-Gm-Message-State: AOJu0YzvonwRGWockQaDIem7tG0ifewmsnKDPPEdynT8jTS+tikIPLRi
 0AJBKRU6+ODLQt1zzhy8lSvHG/ZBAamMUa9zotvGeREczOfmKuHnVQxWyFJMRFI=
X-Google-Smtp-Source: AGHT+IE/OsVwaX+CmcuF5XR3Se4UQ3ar+KePaVN5UMoL7ez84nHS3T5foUtv6gCxwzv1jc2fRf+zUQ==
X-Received: by 2002:a05:6871:3285:b0:260:3fb2:b724 with SMTP id
 586e51a60fabf-264a1058716mr1160733fac.46.1721860830269; 
 Wed, 24 Jul 2024 15:40:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e63f463sm60582fac.18.2024.07.24.15.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:40:29 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:40:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20240724224027.GP989285@bill-the-cat>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com>
 <5329b5b4-b54d-4c4d-aedc-c21c3da5f9ee@gmx.de>
 <87o76n5d1a.fsf@baylibre.com>
 <A6FA1C43-24E9-4738-9AE0-E0E67E71CA65@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5fh5dEEaxIDX43Sz"
Content-Disposition: inline
In-Reply-To: <A6FA1C43-24E9-4738-9AE0-E0E67E71CA65@gmx.de>
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


--5fh5dEEaxIDX43Sz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:06:46PM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 24. Juli 2024 11:56:17 MESZ schrieb Mattijs Korpershoek <mkorpershoek@=
baylibre.com>:
> >Hi Heinrich,
> >
> >On mer., juil. 24, 2024 at 11:45, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
> >
> >> On 24.07.24 11:21, Mattijs Korpershoek wrote:
> >>> Hi Tom,
> >>>
> >>> Thank you for the report.
> >>>
> >>> On mar., juil. 23, 2024 at 08:18, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>>> Here's the latest report.
> >>>>
> >>>> ---------- Forwarded message ---------
> >>>> From: <scan-admin@coverity.com>
> >>>> Date: Mon, Jul 22, 2024, 8:07 PM
> >>>> Subject: New Defects reported by Coverity Scan for Das U-Boot
> >>>> To: <tom.rini@gmail.com>
> >>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> Please find the latest report on new defect(s) introduced to Das U-B=
oot
> >>>> found with Coverity Scan.
> >>>>
> >>>> 8 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> >>>> 3 defect(s), reported by Coverity Scan earlier, were marked fixed in=
 the
> >>>> recent build analyzed by Coverity Scan.
> >>>>
> >>>> New defect(s) Reported-by: Coverity Scan
> >>>> Showing 8 of 8 defect(s)
> >>>>
> >>>>
> >>>> ** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
> >>>>
> >>>>
> >>>> ____________________________________________________________________=
____________________________________
> >>>> *** CID 501795:  Insecure data handling  (TAINTED_SCALAR)
> >>>> /boot/bootmeth_android.c: 96 in scan_boot_part()
> >>>> 90      if (!is_android_boot_image_header(buf)) {
> >>>> 91              free(buf);
> >>>> 92              return log_msg_ret("header", -ENOENT);
> >>>> 93      }
> >>>> 94
> >>>> 95      priv->header_version =3D ((struct andr_boot_img_hdr_v0
> >>>> *)buf)->header_version;
> >>>>>>>      CID 501795:  Insecure data handling  (TAINTED_SCALAR)
> >>>>>>>      Passing tainted expression "*buf" to "dlfree", which uses it=
 as an
> >>>> offset.
> >>>
> >>> scan_boot_part() generates this warning, but scan_vendor_boot_part()
> >>> does not.
> >>> Both functions follow a similar code flow.
> >>>
> >>> The only reason scan_boot_part() generates this warning, is because of
> >>> the downcast into struct andr_boot_img_hdr_v0.
> >>>
> >>> We can't change char* buf into struct andr_boot_img_hdr_v0 because we
> >>> need to be block aligned when calling blk_dread().
> >>>
> >>> Per my understanding tainted data means it comes from user input (whi=
ch
> >>> is true for both scan_boot_part() and scan_vendor_boot_part() because
> >>> both read from eMMC, which can be consider "user input".
> >>>
> >>> Since I don't see any particular problem with this code I propose that
> >>> we ignore this warning.
> >>
> >> The warning is specifically about invoking free for the buffer that we
> >> have allocated via malloc(). Our implementation of malloc() and free()
> >> stores some meta-information about allocated buffers at a negative
> >> offset and we don't overwrite this area via blk_read().
> >
> >Ok, so does that mean that you agree that this code is safe and we don't
> >need any further action to fix it?
>=20
> No fix needed.
>=20
> Tom just needs to nark it in Coverity as "intended".

Thanks. I'll copy/paste the explanation in and close it next time I'm
over there.

--=20
Tom

--5fh5dEEaxIDX43Sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahgtsACgkQFHw5/5Y0
tyxqYQv+KXLdhUT4xA7qCffwHZclmE7rC44Q7f9HLqbyBvEmiYhGQG5/WJDxAuLJ
KZGub5L4yEeM8GNiK0+qixS6ehGpRrPOrT8dFwQXqxkRlT2xm9TrSbjMF4wiRsAX
bO8RijUxjYDXIAQ905dg+Y2OhI7BHike0e2q4l9jYOfTxqMSOVpQr/xSiw+3Cn1D
PrjRmH00kTNJIrPQX2EZaBYxQIc3qi3g0UBmhRWvC3HxPrAMBQbjwXAXJtQ0pYLT
N2H/drd0C8GnL8z1Y06Bk07tm9QOipLi66N+4Pbgv489OmLeTW/J1iUB3us+O9/v
Y74j1RYo3Evnx5WRqIUukkhDGvKWWpxW27zBQ+E9lp96vZnoJ8PZ/RQCQ/o4HDqN
ZhbYOjlVpiFkCSP26jRMzCtQhGndEn8UhY+2jECMUyN6nxGaJYqIk/gec2OSZvwJ
TpbVyYcEP1FFNc6sGj43Jd/ZqBsjibZjiXFPN0pRaWCPwpcrD602OM66PTJUrE2J
T4jpbisA
=Qfe/
-----END PGP SIGNATURE-----

--5fh5dEEaxIDX43Sz--
