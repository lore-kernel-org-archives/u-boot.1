Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16681CF856E
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 15:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F0B83A6A;
	Thu, 20 Nov 2025 16:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jiIdTpAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFD383B8A; Thu, 20 Nov 2025 16:54:07 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D7783935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 16:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-656b4881f55so426751eaf.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763654044; x=1764258844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JaLw8WKKk6exi8GVrqaFTP4j4F7qtB01NI+04T1lgfM=;
 b=jiIdTpAl3LSc4A6cDHqAsCYm4o71yAWpEqIhVQ6TEUpLH6kgoftCTwEacBqvXb0Mt9
 OMUGhiYv/LH7JOlnDrw/fN3Ep6/EvIIz0DE5VLSbgr9nXmz13Ud7ZTwnZCROtUQw91X7
 ooIbgAXWo+QWYwPFud52nh6o+7qpAy/hh74ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654044; x=1764258844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JaLw8WKKk6exi8GVrqaFTP4j4F7qtB01NI+04T1lgfM=;
 b=WoJoMEDHrIhuJdvhgu7CgMgIP9HlAaOvh6su1vEyZ1buhm/Bfhjv9CDT+l9i8ZrwVP
 XqtvxotT9fhOghfqb5SEIEbGqAkugJ7nY7epQWqQrNDN7xFpKcnatHVDjGAjyeaSCRee
 a0av/D6WmJqYt2tuSx1FvNIJh65a9ZlFjqCzfw6Niv3bhUCJN1ojD2lUTETfmMydU5fD
 ZgBOYv0wm/1k5V1eawca0fYH63Mzduw/a6bUhrYPYpCX4+lb75bjbyySCVJnI4GS8mwp
 QY6I/sV1gE7pWy49LgMfffZtUigd7zmwJHtVKvqOaP+L+G3hd+iN8Ce7mQG8RnQ6TO71
 RA8Q==
X-Gm-Message-State: AOJu0YxKF1cW8Khse2ddKPSHrfW9nz6VDbJ6N3JFN2LFXcbaDsxp0idw
 XLtvh2hxdGqxMZKo8PROY6zdEfQpwX1D1vXkbg7EhWx1oJow4MoNiRubv3mGyvxdGqE=
X-Gm-Gg: ASbGnctC+qh2PPnKbPnaMsgRA1Ce1idvThjIqruB932qLh5c/jMFgUB7OboVtmRQ/wE
 8v8r1mqYWWtNmBC65+8tHLf9VEyCzEgEF0Qxx5i6cvK1ggzTz0bXwqCtsudzUEJwUaVSpuCS1du
 LLkNreIychdFKrsoe+gKE/mrxJNG577SBL4LpjWZhUweJutDkM24EQYOpAv4+/r5cqjfe9cu07+
 yqJiDlloqV68s9GQH6UAfe33t5MHActlaxyD/2oD8QohPzTxzTu/p1wOkBpUgCSvoMiXFddQ5iH
 bpcqgsCfFoCYgF39mFMR0efS6EkJny06MLN2vTh0ar+61/5T0JUm2MLrJfKI2R8aCUwREL+SLOz
 CfpfCxPCXxq0C1nOd/cLajM85vXGKA/EqcxwyvdZTktivzSy4a52RtXVl7ueMS54ppzSvHCHyyV
 Xr4TJp1V1uh6BEUWahnfdmzl/AziI4w3Q5CNh6fcUI6DgUDuhBiw==
X-Google-Smtp-Source: AGHT+IE72YljK9jshopXal2bRuvr8QrBykp6jXBOfOwKuK9FuKQ3eLiD6g2bCPM4r/SrGqukiPS1Vg==
X-Received: by 2002:a05:6830:3808:b0:7c6:e92f:41e1 with SMTP id
 46e09a7af769-7c78d263c05mr2592179a34.14.1763654044111; 
 Thu, 20 Nov 2025 07:54:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d306196sm1123975a34.2.2025.11.20.07.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 07:54:03 -0800 (PST)
Date: Thu, 20 Nov 2025 09:54:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251120155401.GI2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
 <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
 <20251116141151.GC2125796@bill-the-cat>
 <11a631a3-644a-4c4f-8b09-7202687a4a90@mailbox.org>
 <20251117184027.GN2125796@bill-the-cat>
 <5dd7d2e7-7e1d-432a-b737-ae4dfa2689b2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ivmxnpICeGEwH+Y"
Content-Disposition: inline
In-Reply-To: <5dd7d2e7-7e1d-432a-b737-ae4dfa2689b2@mailbox.org>
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


--5ivmxnpICeGEwH+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:31:24PM +0100, Marek Vasut wrote:
> On 11/17/25 7:40 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > > , and then
> > > > every follow-up location doesn't need to perform that (or possibly =
many
> > > > other as well) validation checks. My impression from when I looked =
at
> > > > the code last, a few year ago, was that it was designed with "valid=
ate
> > > > with most? every? function" and we would be happy enough with "vali=
date
> > > > once".
> > >=20
> > > If you can make that assumption -- that whatever we feed into libfdt =
is
> > > valid -- then we can simply patch out can_assume() .
> >=20
> > Maybe the question I have then is, why isn't can_assume being optimized
> > out at compile time, if we set the mask right. Makes me wonder if
> > there's not something to fix upstream too. Or maybe we need to change
> > the default to higher than 0?
>=20
> Maybe because the mask is set differently for U-Boot and SPL , see:
>=20
> CONFIG_SPL_OF_LIBFDT_ASSUME_MASK=3D0xff
> CONFIG_OF_LIBFDT_ASSUME_MASK=3D0x0

Right. We might want a different default for full U-Boot at this point
(not assume perfect, but also not assume nothing). But still, I would
have hoped SPL growth was smaller, but perhaps I just need to
re-evaluate things. Let me know when you have a next iteration of
everything branch somewhere and I'll run the size growth build before
you post if you like and we can iterate on it.

--=20
Tom

--5ivmxnpICeGEwH+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR85lQAKCRAr4qD1Cr/k
CjZgAP0RhQBhPRWQCh9O8QYGnPLZr+UQICAOAVb7ZJLBdny8ZgD9GZsvPFMtBV1A
tt7QStP0RkBXLVIpvS7Ny2LCov5qBwc=
=7geI
-----END PGP SIGNATURE-----

--5ivmxnpICeGEwH+Y--
