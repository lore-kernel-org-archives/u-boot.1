Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B51CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006D783CC7;
	Wed, 12 Nov 2025 16:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="exm/KKEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3692583CCA; Wed, 12 Nov 2025 16:27:57 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C0683CB9
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-656b8900ac1so424903eaf.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762961274; x=1763566074; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3OnrL1RSoQpTtkTrev5syrXklZc0G8JPYlJtrBQ63jY=;
 b=exm/KKEzpWk1UkMxWqos4CZk6fOcGdFqCTOLlLdLBomqlngSdMTDoEORIKsmzAq/yK
 RhMvL359enGkteNC46rN07/hxTdCExJbtWiADx2CLmNlM9AKPqNjlZSbSalE/RTCyruX
 fslFU3IQlMTpR3EF3/GvIZVpv671R3LVXl7l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762961274; x=1763566074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OnrL1RSoQpTtkTrev5syrXklZc0G8JPYlJtrBQ63jY=;
 b=k8VXzQ7iMcl4bQAUHhosJOg/zhZGH8bEvD8NlF+arl2g1V1YEjg/BXViUwxVAaaU/I
 OpzMlHztlxpRqvc4DCikaHxmWal84cRbgFCKJlP9R/jcinCj33EQy1VxryvbLGnYV52Z
 qMtkDc/r5j4/Uz0ANMf+SBlxnFRekDTy1HhLFEIoMs2esaT3SZu6vThlDphgC4EszpYy
 gnomWzyrUkK5D8Ygudm3VouW/Iii9OrRB3XtVtQdhweWWT6CYnZm/Wqjr5ZrHjS0znZj
 oYluUddMxwIo5VtWZPedl21lkvJUD967FrLRQs5eTGBWAz+UpbSpRusCdDuQwtlLYysL
 kOgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFA9gbLlyfu48I/hkIEnb+sMINT2mWBxOGE7cKe0cEfdhFZEjChD4/AgzEnVMoDn6Lwcgf9Ec=@lists.denx.de
X-Gm-Message-State: AOJu0YxxZpYBJ98BrcUzHfgFXFvQFaH9yuhbSleSRhkdh9kcygSO6/MR
 s0dZTnQcb/VNjWzoM2AMVV/EnRbDAXVkrEfTTUXJhCPuyxSRAhX25z7kqDHTepbwr/k=
X-Gm-Gg: ASbGnct+nKgosCkOCKGNpadPwjaWWw3VnEA48nb+8B68UsnBQ0UggpWx1DsrQYMWwYD
 avphJ87xv2pMnZdqoRHRUUQU4DhanqLgMfHu31mvEBsL3ZAMZZYNxdVEtxCPPV8LjD4glhRVMzL
 rHr9428QM9mfZC8R6iVHbZOxiv/tk6MRNPO4bCPu+iaRMeT+J6U2/p2OLZ5jO8eYqsouC54gF+V
 t48lllTRgorDViILbgRVrV7EUY13X85ot+7ODuLcOXjzf1jDVDOiejkS5xGh059E9IICmV1G6l3
 qQBhzGJKX2CRx1mufXFu6EuKM+wMEEP4ccmWsbrS6GmveI4+tTaMbSn3YZBbyNmXpiL0IDalMj3
 tRsFpEAGTZI6Y3P+HZgtpbpKxUsF866mRfGcFkurOa7wt5SN58vkv1DiWAaksQoYBHkCaaC41SQ
 tMQzO3/4NojzK+fRsdVHqkHR/SVgOnp+Ru8MBYRdE=
X-Google-Smtp-Source: AGHT+IE21i1DmjRGCKAh5TTJ+XyIxKOHaxBpa3Me823gPKBmLX+gXcoeirFTCxAcor5+WwkJdmlWVg==
X-Received: by 2002:a05:6808:2515:b0:43f:7a07:44e4 with SMTP id
 5614622812f47-450746360d5mr1364111b6e.51.1762961273630; 
 Wed, 12 Nov 2025 07:27:53 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656dc45c3a8sm5775052eaf.1.2025.11.12.07.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 07:27:52 -0800 (PST)
Date: Wed, 12 Nov 2025 09:27:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test/py: Use aligned address for overlays in 'extension'
 test
Message-ID: <20251112152750.GA6688@bill-the-cat>
References: <20251112020230.414101-1-marek.vasut+renesas@mailbox.org>
 <20251112133558.GY6688@bill-the-cat>
 <1933c9fe-22f5-4405-8938-fa28fe89a330@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q3FobeIK4vEMBHri"
Content-Disposition: inline
In-Reply-To: <1933c9fe-22f5-4405-8938-fa28fe89a330@mailbox.org>
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


--Q3FobeIK4vEMBHri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 04:24:34PM +0100, Marek Vasut wrote:
> On 11/12/25 2:35 PM, Tom Rini wrote:
> > On Wed, Nov 12, 2025 at 03:02:21AM +0100, Marek Vasut wrote:
> > > The 'extension' test would set 'extension_overlay_addr' variable to
> > > decimal 4096 due to conversion in python. The 'extension_overlay_addr'
> > > is however sampled using env_get_hex("extension_overlay_addr", 0);
> > > which converts the 4096 to 0x4096 and uses that as DT overlay address,
> > > which is unaligned. Fix this by setting extension_overlay_addr to 0x1=
000
> > > as intended, which is aligned.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > >   test/py/tests/test_extension.py | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/test/py/tests/test_extension.py b/test/py/tests/test_ext=
ension.py
> > > index 61223496054..ddc62e7d5ca 100644
> > > --- a/test/py/tests/test_extension.py
> > > +++ b/test/py/tests/test_extension.py
> > > @@ -38,7 +38,7 @@ def test_extension(ubman):
> > >       assert('overlay1.dtbo' in output)
> > >       ubman.run_command_list([
> > > -        'setenv extension_overlay_addr %s' % (overlay_addr),
> > > +        'setenv extension_overlay_addr 0x%x' % (overlay_addr),
> > >           'setenv extension_overlay_cmd \'host load hostfs - ${extens=
ion_overlay_addr} %s${extension_overlay_name}\'' % (os.path.join(ubman.conf=
ig.build_dir, OVERLAY_DIR))])
> > >       output =3D ubman.run_command('extension apply 0')
> >=20
> > As we often get patches to remove the "0x" portion, can you just correct
> > the format character? Thanks!
> Do you mean s@0x%x@%x@ in this patch ?

Yes, thanks.

--=20
Tom

--Q3FobeIK4vEMBHri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRSncgAKCRAr4qD1Cr/k
CgUJAQDSu8Eu4j+uc37L3Uv1NrqgRabbsGHWcD6RMpX2UyROPQEA0mofjgU80P6c
76yx4Vo8WF5+X+TicH83hx/bGOyISwQ=
=7e85
-----END PGP SIGNATURE-----

--Q3FobeIK4vEMBHri--
