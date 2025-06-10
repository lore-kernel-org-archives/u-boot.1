Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177B0C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8758982B95;
	Tue, 10 Jun 2025 17:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dTqRI/b2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD8082C03; Tue, 10 Jun 2025 17:29:40 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3775982B0E
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-406e31162c6so1628849b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749569377; x=1750174177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R7mVa/02HWpGIhySFilS99ZMoUeGglCAEVF0ZV+Snfo=;
 b=dTqRI/b2BwKO/9VOFI4UIVV25qqY2eKSip2pjxDn3hA7nw9NHaJ5NQZy+pw+fa3LY8
 Cu94dnN/CtBZCp97w49039EI74B9hrpQGm3TpuJ9EdZRjMlQuoUnspg7Vd0n09JhSPwT
 eoJ6WPgE6fql2RI023MuLKQlWLqyR4zBsPoSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749569377; x=1750174177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7mVa/02HWpGIhySFilS99ZMoUeGglCAEVF0ZV+Snfo=;
 b=SagTx69qDtbNUXz1tt9eLRzMuX5+fV1gSICiNytM2AV1QWDd75h5r2mE50Jw78QWEM
 k12QYm7IThqIX7eeIdfzQlhUkR9Hnse4iKBXQmWTVu1WiziAsUYl07Zs+EO8DvjzdtsK
 z3mzRGiiao8EG1gGdX2CijDaFasVbgvRy7re5/cBNfOzJ0YpoCISZZYEEGqCs6p/dkf2
 7owhdcpc2rlr48xezW2lE/vHS0ggg3uUeBLxpPqr38nQbxDbkkPIiHJwl/mTgHAyH33l
 NW0BKMf9xkfkWKQTds2TjnWxqZdwCvQ55U5D9Dy/xqBizK1yc1sYyR7VdHx14wjoS+Dj
 xo7g==
X-Gm-Message-State: AOJu0YxCjvN/wIVtzKiv9g5AocpzWDMmwjpVRWL6GNDlS5ISe+lmbIr3
 Za1TRkU7Lcm7ZTnvzgrSo50fwsu5AvS3Tm68u+SItRqMoTjrrVjYQA5xhPmJxMk8wtWnRqDGDTp
 ChadTVOA=
X-Gm-Gg: ASbGncs3VvdYaBxsWJPajLimY2lHWeFEkqjo+zm5yMDxjlw/DQyB/fPQJxfL2yXJIA8
 ODxWb4Uj39HZ9Q3lglYWkJI0n2u/SoozqsZTsVcXzirfcMHL+Zrmtyf7jnda3g/jj+w/eEnagBc
 yF8GQDua2C8lymePw9imiLVTBmo4ZkyM8HzWIJQZb52BXL+sAfSIKOtej/D/lu2rNFKBYkYxo9o
 3ku/4YoM1YzzLYWnedUcAy7lm6+M0qkw3VCcK6iWmXA1LDnstiC7jrkAdGrCMtRDCFpC5yqJVBA
 Wp0yQL27YZOkEewHJFFUdy2cId0d1gv1mX2TajJrvXhwRgqg3y+UdRZxNGD9y7mHTAC2z+KomS+
 0wuGtt16vhtl+kkTOdy9bUrU=
X-Google-Smtp-Source: AGHT+IGCn//P99D0Xea24Hdpohf5MC3gcfcLgmYrvJiuOjueYzcJ33DjrWEX9JPmmIZfy+t0esqtvw==
X-Received: by 2002:a05:6808:218c:b0:401:e95b:3b0e with SMTP id
 5614622812f47-40a56aa4296mr1784113b6e.12.1749569376936; 
 Tue, 10 Jun 2025 08:29:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e46bc17sm1644394eaf.0.2025.06.10.08.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:29:36 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:29:34 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc4 released
Message-ID: <20250610152934.GB1382132@bill-the-cat>
References: <20250609215536.GX1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rDISzrWmHoUxAiqV"
Content-Disposition: inline
In-Reply-To: <20250609215536.GX1382132@bill-the-cat>
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


--rDISzrWmHoUxAiqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 03:55:36PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and first I see that I put the wrong subject in for
> the last release. We had done -rc3 and now today, really, is -rc4. I
> have now tagged and pushed out -rc4 and will be syncing that to the next
> branch shortly. At this point, really, we should be looking at
> regression fixes or otherwise important bug fixes. New platforms and so
> forth can go to -next. In that vein, I am currently looking at:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D460155&state=3D*
> as patch two fixes something we introduced in this cycle.
>=20
> What I really want to call attention to however is this post I made:
> https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/
> Where in short, I think for the overall health of the community and the
> project I need some help from others in the community, on not strictly
> technical matters.
>=20
> We're continuing with a community meeting following the release and is
> the same time as the previous meeting. The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> June 10th, 2025. 9am (GMT -06:00)
>=20
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

A very short meeting. I gave the overview of this past release, and
repeated what I said above about regression fixes. The next branch seems
to be in good shape. I need to find the time and motivation to break
down Simon's big series and see how it can be most easily managed, but I
also want to continue on with the cleanups I've been doing. No one had
any new topics to raise with the group, so we ended the call early.

--=20
Tom

--rDISzrWmHoUxAiqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIT1sACgkQFHw5/5Y0
tyxVTwv/W7lUhYocJfcSWC8xMclLx2BCzudaBrmcOx0gElX/T6bf4vEtXkXcz246
jHia0Vo/63hBVfYD0kHguXZ0m5u5rE7BMesd1PSM1FVj2Bb2nJi95S/do36M1ofq
Ws3B7Emx/9HLCqj+OWjmjGTF9rYSCLTD50+LCLv0FTHRRAzFrlwQk4DUBZObkL7f
jM2Ji7jh/hKm+LuWsblDzXsb/KmphA9mh7hw7w4mjmC9jDH9hpore+ZbeChGIAFm
H+PCxVJvIfbBkEaeDcSSZxwwpOOypFni+saEYzVFbJS0icWUu6vGit+bTjoHtRQ6
FWbXUZygilEtQeITeI42hSaCWZQzfjwr3qcvyCV1p1COHB2NfX3j0vshtUw0P65w
LAA4z6iNLq+xEPYTXgyNuW3c+Hm5YO11F1NCW0YpI2ga/c+uylipDzvaAlX3lmFI
++IeMF72CE53Sgg2XsGVSswow3ZpFuU+v+PCiZ3xIuPJs8XSu2xAETe3yidUA/NC
y5oKf+jn
=XFY+
-----END PGP SIGNATURE-----

--rDISzrWmHoUxAiqV--
