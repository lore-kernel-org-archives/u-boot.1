Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA37BC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE7D8768F;
	Sat,  9 Dec 2023 16:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TCVRyGFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E618764D; Sat,  9 Dec 2023 16:49:00 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5326187686
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d34f8f211fso29484857b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702136937; x=1702741737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YN0ME/Bm168oEEvllR5heFlsy+s+xQLBKwAcmqFJAzQ=;
 b=TCVRyGFNSsGxOXWj319Pwkqu/k4XlSOj7LHccr51mkdmI3SmmnZZ0rQsqtRo57/X8H
 dncxaPHLRGTerjkez0j/ffn41wHbihrRMTpb9CC1mkkGeHIw9cV+PMVkW8wEZYOdhWnE
 xkg1Mns32HDMGLA5/JWNJ19zfIp9YA/vylsA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702136937; x=1702741737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN0ME/Bm168oEEvllR5heFlsy+s+xQLBKwAcmqFJAzQ=;
 b=o93KFI2fWoT1BeopfP727Hye0QKllAvn47E5KVNBAdbF5E1Zo4aTHCTol44jEL6c8Q
 m48EUkJc6yLIdQv+2Jpngb10Xp5K7ArIiIXyW4T61YkQ+9wkFeDU6JNC5fZ4+04G8w0S
 jU9VvbVQ2No0aszBkEJctmOmTGMaUBiWk3QKtCngNrbJgHMt7DpM9WNhU4UxemZupAvy
 Y8na8h99OifoY1G58qb8TY1n/0yxEWMyn3VQhbloEnKYMzm5IBaZXe6W1VTv5j/0A8oN
 Y9bmf4fj/N4YKcH34WqTd7S9zwyplwK4dPu7y2SybvTOuFgpz7/UGHJW+1Iow3e4lktX
 r92w==
X-Gm-Message-State: AOJu0YzdAgvf1m74Dd++Z82XteraDLr5/JvyuJCriDkkkLKztR1ap4I7
 yf8VuOUSaLXNkDeDHOm8MngZZ6Wjnepa0T52OZ6EEw==
X-Google-Smtp-Source: AGHT+IHDTHISotuKmiM451D2IcERDV5c9k+xk2uMwXgAWyDcIwREOMKQa4NXfKfvL4ViawzDYoBzGw==
X-Received: by 2002:a81:54c1:0:b0:5d7:1940:53bd with SMTP id
 i184-20020a8154c1000000b005d7194053bdmr1335206ywb.53.1702136936888; 
 Sat, 09 Dec 2023 07:48:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a0df606000000b005d317074440sm1541229ywf.79.2023.12.09.07.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:48:56 -0800 (PST)
Date: Sat, 9 Dec 2023 10:48:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 06/11] lib/sha*.c: Update header list
Message-ID: <20231209154854.GI2513409@bill-the-cat>
References: <20231122131154.2444690-1-trini@konsulko.com>
 <20231122131154.2444690-6-trini@konsulko.com>
 <CAPnjgZ0_U0-9y9o_FZ3-snLmBauuhUW1uoL5ghC=dTRdy3xcKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7IMxKE3J34qKat+c"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0_U0-9y9o_FZ3-snLmBauuhUW1uoL5ghC=dTRdy3xcKw@mail.gmail.com>
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


--7IMxKE3J34qKat+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 11:23:13AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 22 Nov 2023 at 06:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > Cleanup the list of headers we include here. For the tools build we only
> > need to exclude <cyclic.h> as that's used by the target build for the
> > prototype for schedule(), and we don't need to get that via
> > <watchdog.h>. We can also make use of our <string.h> intentionally
> > existing as a redirection to <linux/string.h> to reduce ifdef'd lines.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/sha1.c   | 7 ++-----
> >  lib/sha256.c | 7 ++-----
> >  lib/sha512.c | 6 +-----
> >  3 files changed, 5 insertions(+), 15 deletions(-)
>=20
> As mentioned in my series this will prevent dropping the #ifdefs in this =
file:
>=20
> #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
>=20
> Actually I see that I didn't send the v2 so I just did that now[1].
>=20
> Regards,
> Simon
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20231202153400.53705=
0-2-sjg@chromium.org/

Yes, I prefer what I did here instead of [1].

--=20
Tom

--7IMxKE3J34qKat+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jGYACgkQFHw5/5Y0
tyysEAv+PDPb+tHhu1bXWGq9yRAprbhoBbemO2GTyfXecHq7HTw+pY1uvw21NYtG
OYTQk1VXUzbdSIkjKJvhDx0T6ePMtMglx5HdALpyCv3PlcYZTWpbGXgyCssIIXq2
SSDANoBQWXjw/7UNjDFoOcdgS8+r/CGH7QblHqmXP2QgRGOjKR/fjaqYvBDzfZai
NArGbtB2lU1sV18iS+7xkkfpvIQuJaY05jjqky82g1J0p7Y2SafoNym7Ctx9n+sL
dgPPqkAqa4uKOQiLYHjgiQxLFlNAcO88/KovVqVDleSAdgiGkkl1KgEIhACEu4Pz
J0LYgFqhrI0fHk9qUonAEWruR1TuBjnIVU2LSAsRGpPW7u9Ikyjw/1ol18ma39Ix
Vy1ExJ+2KRn7TW7nnNmX+iotD3MJ5nPwSs3PKDm0BbzplZhpcj4tUz/hBSSpxJRN
9gcd2dx7VrhaU111zP6/qj3dCfmRBDgon/pjq1BkMkLVNW9sfUS9oBTHMyk8EezX
kNoj/1Qp
=X+6u
-----END PGP SIGNATURE-----

--7IMxKE3J34qKat+c--
