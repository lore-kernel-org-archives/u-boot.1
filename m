Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01560C83F2D
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 19:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF50867C7;
	Sun,  3 Sep 2023 21:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mc27knfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7AC864E8; Sun,  3 Sep 2023 21:25:34 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF599864DD
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 21:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58fba83feb0so7069117b3.3
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 12:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693769130; x=1694373930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yge7DkeqU8MgdT2E1ofBklJvLsNi7qZbgWFbKjzIt5g=;
 b=mc27knfb5p9/A+A1Igmad5XLdv8iHAqBcnY9AuwzhOhLWY3WiubYkUB8862FUBo7pY
 Bnim/RKRVmeVfWhesCYzSmlGju9DAORxOIzZVmQjOIiokRuDkjEM0b8MOss/Sp+Dxmgk
 dzzvk0BnLEX9fTGKyzF2P7kDe2fZZeYE4q8J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693769130; x=1694373930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yge7DkeqU8MgdT2E1ofBklJvLsNi7qZbgWFbKjzIt5g=;
 b=i9xJ71qSVm5IEblbNUO0Qt6NqRlYW+C5XWfwrTBnI6LQQrDwbthJ0yDhj8n4CCMO/K
 0RjI6NLGYoZIsl8PJ8vVg/AZJiTHfABji/NXWDVwReGrDNvIfAbgKpvZAv2wYge2wFF8
 TM64G07lrMDcy14MqPLguO6+14ewOV8Kh3IUxkuiaEM15rPP4E0TbsR5Q+2nU3vE1krb
 vfYueWxiz9U8YIBtw2ZURpvmgfK8v2O4bS2olsD3Cxr2kCz3VGEGVJJVHBqN5l1W7GDJ
 Opzty7x3m5SvS7ztMaqfb4orYKIq5MaMyx1XciWj5uO3a8I2LDCbKDErD/Cn1FmBJcCh
 1Z0A==
X-Gm-Message-State: AOJu0YxO1+YkRrNCnNciLYwUBq4kX2AqAkYhuthD9YuOpAoc2FM68xTK
 W8kUQ03srnKIHK20bup07iZV41gOkCcVvZHUgxbNEw==
X-Google-Smtp-Source: AGHT+IEVm5ndBRJNHo0vRor59lOagbeSszO3pngb3jvRuWiaTiTOQJazY+Efl/BJ59Pj3XerPtqUxA==
X-Received: by 2002:a81:91d2:0:b0:577:417b:8e90 with SMTP id
 i201-20020a8191d2000000b00577417b8e90mr8686804ywg.10.1693769130555; 
 Sun, 03 Sep 2023 12:25:30 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-e2c8-2093-3a74-c444.res6.spectrum.com.
 [2603:6081:7b00:6400:e2c8:2093:3a74:c444])
 by smtp.gmail.com with ESMTPSA id
 da7-20020a05690c0d8700b0059a34cfa2a8sm755655ywb.62.2023.09.03.12.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 12:25:29 -0700 (PDT)
Date: Sun, 3 Sep 2023 15:25:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] Azure: Split sandbox and qemu test.py runs
Message-ID: <20230903192528.GA3101304@bill-the-cat>
References: <20230901204143.3617876-1-trini@konsulko.com>
 <20230901204143.3617876-2-trini@konsulko.com>
 <CAPnjgZ2JL5QW6470rKgyijcJvRGG7GFgTbwH2erfhwPtdg-+Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YD0ByA+xrChndiu0"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2JL5QW6470rKgyijcJvRGG7GFgTbwH2erfhwPtdg-+Kw@mail.gmail.com>
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


--YD0ByA+xrChndiu0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 12:09:39PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 1 Sept 2023 at 14:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > Currently, most sandbox runs take a long time (due to running so many
> > tests) while QEMu based test.py runs are fairly short.  Split the
> > pipeline here so that we get more consistent average run times.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  .azure-pipelines.yml | 61 ++++++++++++++++++++++++++++++++------------
> >  1 file changed, 44 insertions(+), 17 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> ...so far as I understand it...there seems to be a need to pass the
> argos to docker again.

There's not a clean way to re-use all of the logic we need prior to
docker run, or move it to another type of "task" (in Azure-speak).
There is a Docker task, and we could, I _think_ migrate the volume
options to that (but I'm not sure), but we couldn't handle the loopback
devices in that way.

--=20
Tom

--YD0ByA+xrChndiu0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT03agACgkQFHw5/5Y0
tyzF3wv5AUCcRcU7L1XkArOq01JPWisfPPlKL0S1t1vHk0O9AbESHW6CksUNjzkt
ykRziiDumZSRKw+XWGHSS+jRAAjWFLWmHaO1rP5hQvEOyhMajAkBKsHORRLGXzsO
YYC5tTeMQZLJlks4ZdrPX46PBOReMC769VzzZABM9eGuMaHKIjytpBx9l436qwar
e6TYXDXMusJ2jqEePPGn2fJt6DTdme6qfTAkly7cE8MwVCWTVi2BtRxWjEC1Arga
Butq5slfXGSAfqut7vAIXoeWEv/brF0XeGpdCZnGzFD7sMp121Qt2rYuN1Teda0G
xLyYQ0clOLeYeF0aYj95Fu5M3hAXfDBwgSCxrNaQ3a1Q5tuFORbtmSj3avakzvA/
NRCaXLld/Knp6MOCmQOCSpyB4xcSAvgFIeMzsLSnFZvLeveHrQYxd8xPTE2sm6hK
4D+IohCoPZnoxBtsRRqaFWg/tyMqBaolR7cTOkWV1Bd0U53CBerHBG84c5rv0/O+
L+ozpjtU
=2Nkh
-----END PGP SIGNATURE-----

--YD0ByA+xrChndiu0--
