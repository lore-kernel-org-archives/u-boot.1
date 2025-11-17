Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287B2CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991408388D;
	Mon, 17 Nov 2025 15:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bkoYSxt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5088391B; Mon, 17 Nov 2025 15:14:42 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D1C83623
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 15:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450bbac0368so685487b6e.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763388879; x=1763993679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qiHQo5BuSlOBWGzlkxTuby6cXWrTjpSTb0muqAl6FNI=;
 b=bkoYSxt2GUHl6TKxAYmS8WEqWcXplZEE+Naj9gl8SWR98ydqMRE0OcS6L1dJGbKrNE
 EFNp6qnoJQiNdHtJmSKJrGOHHJCnKj31Mx1YYvDsapWUESsdW+hSCHWf28J1CbUsv2G2
 ce8V/6oj19Q5d6PUQVGkbr8dOyU3wV0Kg0go8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763388879; x=1763993679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qiHQo5BuSlOBWGzlkxTuby6cXWrTjpSTb0muqAl6FNI=;
 b=qwLa2vmCvdCed73Twg4MP1Z8qyXMNVuBIScFx779M+HONUCxRrnmdcT8AFUqxfqAPh
 oOVY6SdYcvxmRWD3nxxw9LhLaqsROeKUz7pWA75Tb3tcLpr75j0yO5cJcINBXyspVeLl
 neXmKFcVSOosbsUAfK+lMIsChoGcQ/x1Lt7SFV8663R5p6r0t7OE58zMW+HhcSl6ucMT
 GC0So5qb+ehM5dPYZshX3ytxNOGa6FA0hsx8GnGrOmhLNMM7csGm2ovWus7QT5dFq5w8
 XdNs0KgAd5bfHvYONGVHl3rtE/uszEMADbHoRnoz4oInqDancFDcmxQxr9FbhidobYYv
 gxwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwRnNX3e7i+eDseg/kmNEhzAyNzmbQb9jwdBXY4cwTgP1iz+LZMTGcFsRiFCSu2LVxbXlxfws=@lists.denx.de
X-Gm-Message-State: AOJu0YwdJW/JaKjlsHhRothtSQFoFy5vm9xpGJbqIKAlZMa7sZmW/Gty
 BOA8qguKwRJaXvcoly0mI3dY5kLJXLiKbeuRhJFq4mqz+7btesn3KCg8JpO24IPo/5s=
X-Gm-Gg: ASbGnctFdv1aarFoCDopP+ExSGnXoREtD1njF9ttdc3sXZJ6qdpzPciJgLXKKX5AdD8
 jmXipghzJzW8y0C5jpYFc7FBhdOKMxntqxdbZLsx4u58FvCmBtR1InLa21oFEqDS7t4Vq4RaXpU
 NrFr1Y0Xw7GwOmLQSutMueknuLx/T2TjK/7Xv86fJpooOsf8YZSjeJQRpYyJ6riMVyW+BuBScV6
 HWOoKmy3Und1zxNAP5Hd79AUV/Ne0lTKB9CyNvvk5KA+apdO9RSoabC+yV44DSbi9idKgEcAJXp
 kwsgT80SPrMJkWLo7h4r4UCElPo5QdglCH0fP2eUOW9n99/ZNL6j5S7QaUPcD3V66iB/6szPn8d
 J/eMnARZKBiymwRW80rf0bt8n4oYBtTnrNO779h1NALc6dpabbNv6s/qNZCI6HIz7rpgP3eF6QA
 qRaY5VwWUtPgNX29EU6gwPc/k6HOKlvCES93Sbvpc=
X-Google-Smtp-Source: AGHT+IHCjwkNPBChRM1eqQi/iNIPTZWauG0JKiZaqMtwzRXwu5MYGBXdTnigVz8utIdS6Ytbr32XVw==
X-Received: by 2002:a05:6808:f03:b0:450:d4b5:3527 with SMTP id
 5614622812f47-450d4b539e1mr864947b6e.24.1763388879066; 
 Mon, 17 Nov 2025 06:14:39 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a3bddd2sm5399444a34.25.2025.11.17.06.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 06:14:38 -0800 (PST)
Date: Mon, 17 Nov 2025 08:14:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
Message-ID: <20251117141435.GF2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
 <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
 <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
 <20251114143609.GZ6688@bill-the-cat>
 <4ccf5adb-6e66-4842-8e4b-1c6f37ec966d@mailbox.org>
 <20251116141321.GD2125796@bill-the-cat>
 <93432931-3bfb-4c2d-a3a8-fe938d3ddf64@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="liYno4l1j2IbaxP6"
Content-Disposition: inline
In-Reply-To: <93432931-3bfb-4c2d-a3a8-fe938d3ddf64@mailbox.org>
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


--liYno4l1j2IbaxP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 10:28:28PM +0100, Marek Vasut wrote:
> On 11/16/25 3:13 PM, Tom Rini wrote:
> > On Sun, Nov 16, 2025 at 01:16:53AM +0100, Marek Vasut wrote:
> > > On 11/14/25 3:36 PM, Tom Rini wrote:
> > >=20
> > > Hello Tom,
> > >=20
> > > > > We would need a wrapper for almost every libfdt call, which isn't=
 really
> > > > > better.
> > > > >=20
> > > > > > What does fdt_getprop() return when the offset is -1 ?
> > > > > If can_assume(VALID_DTB) , then crash on NULL pointer dereference=
 .
> > > > > If not, I think FDT_END (premature end) or an error code.
> > > >=20
> > > > How are we now getting in this state is a question. Are we being pa=
ssed
> > > > an unaligned DT and trying to work around/with it?
> > > This is superseded by:
> > >=20
> > > [PATCH] xtensa: Assure end of U-Boot is at 8-byte aligned offset
> > >=20
> > > It turns out the problem was yet another unaligned appended DT, on xt=
ensa
> > > this time.
> >=20
> > I wonder if we have still more places. I've seen patches in your series
> > for many but not all of
> > https://lore.kernel.org/all/20221215115825.827111-1-eugen.hristev@micro=
chip.com/
> > and I don't recall how many of those were done individually instead
> > afterwards.
> Was there any reason why that patch (or subset of) was not picked up ?

It didn't get split up, and truncate isn't portable but later in the
thread we confirmed how to use dd in a way that is and does what's
required.

--=20
Tom

--liYno4l1j2IbaxP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRstyAAKCRAr4qD1Cr/k
CsaAAP45sXWatzo/kSR4+EaisUpbxnKJ/Xc9VdLWY795IZEYCAD+I4NdA6CvyRHz
y2KM9+oZuiJrmiBUQxmI/LAKsdAOVw0=
=rvfm
-----END PGP SIGNATURE-----

--liYno4l1j2IbaxP6--
