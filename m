Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CA7C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:40:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879A78640E;
	Fri, 25 Aug 2023 16:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YI9QGgiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C51C86A74; Fri, 25 Aug 2023 16:40:07 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3BC86366
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-592972da9a6so10864367b3.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692974403; x=1693579203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BA3FJOheRW8moyz9KO8Xt7XySOOWQte7Aah4K5wyoDY=;
 b=YI9QGgiEK4YLd9ce1AxiuunhVtsf9nYn/o7LmfGC1c5k6gpbBktGbxla1OIP2ZPG2C
 Drf1LdPGEDOVh4wQRA0LnKHB3P7LZniCUvVkrF3CrZ5VoPOjH/zdHYCj8BDDmlgNjQD9
 s1IyaaW79H6xPexX53ztMaSUdJ7tDDk+du5Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692974403; x=1693579203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BA3FJOheRW8moyz9KO8Xt7XySOOWQte7Aah4K5wyoDY=;
 b=F/Tpvn2+E98g8NYgq+xIxdSxMHaZQbDxXkuMTstTN9hvAVVIi7SIG4/+b43TM46/M+
 kJIqWbzNMxRTPQEXTx3+0Xkn5XiJyKdJrRoBbNebek1Zg6uft/w++v2xwtGpOBEkAnjp
 2eGKdw01G20tFDgZUrA77nteUgdOofLDcxviMbgrsXdw+7LxfWfYms7HxmwTf0sTjqqm
 +gq9sZD156dpO6oE6fjkPtssJR00ZSygkDZjQyxAfcjCQL03fQ4ASN5pC8T7Ug4X6+S+
 Zm7mSJSqr1yAgufVsCg34VDwVLetkLLsb0SiWW/fGPQcNAgEnGgETq7kCEeOaT9XiBAa
 XWNA==
X-Gm-Message-State: AOJu0YwX9ybopxLTWS/joWG6ELP8IW70EIvoEKAr5OP+ljfPRZdgG0GJ
 dtm/TgQRZ1csptbuifO87kU6VQ==
X-Google-Smtp-Source: AGHT+IE4ruhIvyfR4e48rYet6OWUsTkUNSW7XLRiHSAF5o5oWT/2Cv423xapE5ep36XN6Y8Vly1JDQ==
X-Received: by 2002:a0d:ca4c:0:b0:570:63d3:9685 with SMTP id
 m73-20020a0dca4c000000b0057063d39685mr17581574ywd.25.1692974403363; 
 Fri, 25 Aug 2023 07:40:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 v190-20020a0dd3c7000000b00579e5c4982fsm529139ywd.36.2023.08.25.07.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 07:40:01 -0700 (PDT)
Date: Fri, 25 Aug 2023 10:39:59 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de,
 lukma@denx.de, seanga2@gmail.com, git@amd.com
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
Message-ID: <20230825143959.GH3953269@bill-the-cat>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
 <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U7tE7TSxhym083y0"
Content-Disposition: inline
In-Reply-To: <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
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


--U7tE7TSxhym083y0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 09:15:09AM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 7/11/23 11:51, Ashok Reddy Soma wrote:
> > There is a chance that assigned-clock-rates is given and assigned-clocks
> > could be empty. Dont return error in that case, because the probe of the
> > corresponding driver will not be called at all if this fails.
> > Better to continue to look for it and return 0.
> >=20
> > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > ---
> >=20
> >   drivers/clk/clk-uclass.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > index dc3e9d6a26..f186fcbcdb 100644
> > --- a/drivers/clk/clk-uclass.c
> > +++ b/drivers/clk/clk-uclass.c
> > @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *d=
ev,
> >   			dev_dbg(dev,
> >   				"could not get assigned clock %d (err =3D %d)\n",
> >   				index, ret);
> > -			continue;
> > +			/* Skip if it is empty */
> > +			if (ret =3D=3D -ENOENT) {
> > +				ret =3D 0;
> > +				continue;
> > +			}
> > +
> > +			return ret;
> >   		}
> >   		/* This is clk provider device trying to program itself
>=20
> What's your take on this one?  I didn't get reply from Sean.

I guess, what's the validated upstream dts where this is the case?

--=20
Tom

--U7tE7TSxhym083y0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTovTUACgkQFHw5/5Y0
tywlXAv5AXoURUYamndb0ypSiYbBUdzj4CFvi3m8vnxNkb1vvpRJUOners8J8e9N
spWD97Jsx4gsV7cLMnNf6fLMQBngG0D0FjlIcyS9nu0yo79HZPkCdRl2/tD23pIO
QSkQajXCRBdTopajGPcLtz9gLr5opikpnQYHxUzAGtssRdt/p2F6/sfj57U+zzh9
a0iK01Ziah6C6lXMVmJt8JLdu6U0krAcPHN3RvCydbeBBC5ordNjqrHO1gHCBRCa
rqJrqZxSzaKYz5cekvf84R7++JuhnRZ6c0GSouPgrMYAEyjd4Z7plLQ6T11BGCpe
AXpfzjS+7WcMKx76nDEFU8X61zGsvo3V9FLo2skRcSTUm0FsYuwT9QoAaSxYlkWx
MejqIeh9ZSWh08f6vGWP22V5ZfN65+SJgaka+jQgxcjmCEFCujheeMBzVsy5lezv
dtEDI5uU68G4K/smOzw9FeWV8VRHPASToSVCYivQHo/lChi9bZsp7WLbjWg8TWAR
3nubyZU3
=w3m3
-----END PGP SIGNATURE-----

--U7tE7TSxhym083y0--
