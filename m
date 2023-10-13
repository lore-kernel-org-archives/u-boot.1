Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17FECDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A62F86F02;
	Fri, 13 Oct 2023 17:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c/1xGN5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379B186D62; Fri, 13 Oct 2023 17:16:48 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C400886EB9
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f6492b415so19160197b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697210178; x=1697814978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zeViv6997IIKbOm2rTM12I+jckR3/CY+AtnAPohGo1E=;
 b=c/1xGN5o0hI1EDc6RmBIKSewwBOe8dB5vLOXjPP5BHdqCtoSJei4CsnQoMy3BLokkH
 j5HzlQwuu1KjNkqu0fqB2NVCh9lZ9M9oHVKFkhfavctRPTl9XFPSSiCvVNzayzPFmrLZ
 7O4/uPmkCSpMZN/ifbQRHwHPLaekI2WqHRtL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210178; x=1697814978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeViv6997IIKbOm2rTM12I+jckR3/CY+AtnAPohGo1E=;
 b=k6KahmYn/wzgx9opsMPBJuL5oJlkSyTrzOLvKni+JR23dBbHE6ljWd1KfZhlbrCdm6
 0osplKoryV61JOn4Pk6if6gyfxzW7AWJboXWNRGqp+H4kDGQ0pjPzNsj7mrtKMl2CoPm
 wwfKRCeTOSQX0SVWIlXJIpjmLgFiTg6uQkZDYOHRdwClbu3FAp4UW06ATEWeHdLUiig9
 74CR0KrJqfJlt8kH7KTSaNxm+BQxlmuk+92K5XA4FmiiJ1pYURBheMhhXRFTkk2Htucr
 t94wY8JO/Ig0AvLTja5woW7WIh01mrep//FMfB1vBXXJrqAFYDjBEU4B1t5oc8PnI3OX
 H3Rg==
X-Gm-Message-State: AOJu0YwULZd6SPEyk6L70n+j/i3DklbLsUwv2FvdpUWyMuNoVqmEuudy
 cTpmbQUGgGg4xAvWvllCNCcmla/cl4B5hH4xR2S6VA==
X-Google-Smtp-Source: AGHT+IFZTbJgt9M7rnMSkon7RcJx9pb94M735rX2p1mJ4rxgtdvKw3EU0eJGcYcCEQOSFpaFOKTZVg==
X-Received: by 2002:a0d:e692:0:b0:59b:ca32:7460 with SMTP id
 p140-20020a0de692000000b0059bca327460mr325532ywe.3.1697210178036; 
 Fri, 13 Oct 2023 08:16:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a81dd0a000000b0059bcadded9dsm735044ywn.116.2023.10.13.08.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:16:16 -0700 (PDT)
Date: Fri, 13 Oct 2023 11:16:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/7] checkpatch.pl: Make common.h check boarder
Message-ID: <20231013151614.GK3119521@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <CAPnjgZ0dHBBAAYLx-jLr7nHSMBcTonH2cHgMJpb1KasbY=V55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mT79szvrnPDRUick"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0dHBBAAYLx-jLr7nHSMBcTonH2cHgMJpb1KasbY=V55A@mail.gmail.com>
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


--mT79szvrnPDRUick
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 08:15:00AM -0700, Simon Glass wrote:
> On Thu, 12 Oct 2023 at 16:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > At this point in time we should not add common.h to any new files, so
> > make checkpatch.pl complain.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> >
> > This causes a bunch of patman tests, for checkpatch, to now fail and I
> > don't really understand why, at all.  And that was before I added a test
> > for the new error, which I had hoped would clear up the problem.
> > ---
> >  scripts/checkpatch.pl           | 8 +++++++-
> >  tools/patman/test_checkpatch.py | 7 ++++++-
> >  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>

It can't be reviewed, as I can't actually apply it, as it causes CI to
fail as patman tests now fail, and I don't know why.

--=20
Tom

--mT79szvrnPDRUick
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUpXz4ACgkQFHw5/5Y0
tyz9Ngv+I4CWjUyRXzZNp1bHyKHD3UsX9eps3zcOYWEnZ/6KCWBagvi3EV/yymRz
1zyvwGQ0Sqenuilza9zgHuwS+JXi6D1evpbYAc7fDM7Iyg5OHyRIj0DqJ6cKdb0G
2Ewkqdh6mj0IyaUP3DTMoT3ygR7HJZxdvqzUvuvGEqgsJuDl/aGx5or3++LE5vz5
RYCQXa78MQEXWYQPtZO2paWnXZXLC0MgqVU98J/bw8X/csXL13oaBvkTGxBywhDZ
pduK5JdxTZXQe3WIi1dRnE/NaXLJFkEfRPND4/Ue2TaXfZejRkUBqMGY3Q0LkTKE
ihR4JjkoSkcKNJdF2Aei0fx5sJD0qXCROERHqDro29BPm2Zrj4PxxwQmTsxkzXvR
lkfcMfnZVpULzAiC3PJsKBYevXEHSsn3YPagGotKTdOZHs6BIypM9qvlrhPUoySg
BoJ8Gn0ZuapODlmqw4VcVhiieOgVjaaVTFH3umiKmjCKUItmoNqBkHEXm3e/63+l
AFB++4an
=Q5c2
-----END PGP SIGNATURE-----

--mT79szvrnPDRUick--
