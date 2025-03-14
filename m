Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEE3C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E7280F9C;
	Fri, 14 Mar 2025 15:09:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dR/pwXc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37D681C64; Fri, 14 Mar 2025 15:09:35 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B083280F16
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so19130456d6.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741961372; x=1742566172; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tCuSikSXsNLGli+jfuKU/3D0YaiCqzIm0NutO9bcBVw=;
 b=dR/pwXc1HDjUva+tslFa6W5xUd3Gc5a0S9sCNfqtTqfptDAb4UtCr3PVIwxcyJn46W
 vyK7GulBl21qokpZIYSrFwPV3wMZtMgMDIiGkvXanuezSon597btg/U1/oaH4AOWNAlw
 SwV2HF0ThVnWGW7XK6BDcNEp7mk1C6hPkD0Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741961372; x=1742566172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCuSikSXsNLGli+jfuKU/3D0YaiCqzIm0NutO9bcBVw=;
 b=KBOhz8kGbRu+DVBRu7tQfXcSPK53Ff2iQwdXtTdYpiwBPZsuTtLgv92eIWwl3V0CkJ
 N7IQqLbvLSfT4KyrWCOpFLM5SFTarC24JIrVu88yPa7rd+9QLStIFG+2V+xWIW8soS4C
 kUkPzdy5cmnBeJvEosICTgLLuxsRt+bfHOnLPTVjRfzS3OsJHDNvLFnrhbmaiMf8MAh9
 rgH5JXRrbMV5NmH7AIkr78RAGxWxoHcza1E+gQOPARb42eVMiET/HtJxDbo0Vq9RUKTO
 KFJgl1LJez7RHsrO6OG8jGL2ebkaT/t5sfvvKy523NUwHm88rePNbOBTRL5HQls5+S7k
 T7FA==
X-Gm-Message-State: AOJu0Yxy7k1OQk4tW04RtZ7Chh/Jrc1VgbaPf8kYYF3k9XVHYaFeGaDu
 V/USb4HwbTaTpkbsAKLxDgmIE8FpiHz93pAAj1nUoctobsKzLNCUZ7jVRz7d4lA=
X-Gm-Gg: ASbGnctIGvFLcg3DHzbT4i9uqWWPVkv/iFxPxl4IoANk+GWeD8iJtLafOZu9o9KK47I
 vzog0ZPWdJAissdmEFooLTRfA8jWqzMzEDeZdZyKLeyseVU0iYngkCA/0SCdQBp5LQUNBXhUj80
 L/GaJexw7F8twarynZhbBK6x7CphHKtivcOZzw9RViSy8U2Wis3NxqFQKAY5TfEBRUSJESdjoZU
 Ve8x5kEfKr0zdHtTTmNZ9kJ9cF5a7UN6anIFXEkiY3XqEnRow8GvPgimdIHM47JLhAmJnrmQppb
 4t4qQTzmiUGbd/e9xV/gZTfbLQCuEgRyweQP5+iRbsH/0w==
X-Google-Smtp-Source: AGHT+IFItCsJuRy//Dw9EW4rDcdgbrFOUuo05nSC+6gRD4P33X8oA4Uq5rKwl+RaAi0AZpM/NrCTQg==
X-Received: by 2002:a05:6214:2582:b0:6e4:3eb1:2bde with SMTP id
 6a1803df08f44-6eaeaa527edmr42725276d6.19.1741961372409; 
 Fri, 14 Mar 2025 07:09:32 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade330dfasm24085016d6.76.2025.03.14.07.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:09:31 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:09:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com
Subject: Re: [EXTERNAL] Re: [RFC PATCH 1/4] cmd: fuse: Remove custom string
 functions
Message-ID: <20250314140928.GL2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-2-h-vm@ti.com>
 <20250313161539.GE2640854@bill-the-cat>
 <768e6b56-b55a-834b-4abc-41b9cee701e1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bk+XhPJO/zhVpnjn"
Content-Disposition: inline
In-Reply-To: <768e6b56-b55a-834b-4abc-41b9cee701e1@ti.com>
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


--bk+XhPJO/zhVpnjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 07:13:19PM +0530, Harsha Vardhan V M wrote:
>=20
>=20
> On 13/03/25 21:45, Tom Rini wrote:
> > On Thu, Mar 13, 2025 at 05:25:14PM +0530, Harsha Vardhan V M wrote:
> >=20
> > > Remove custom string functions and replace them with normal string
> > > functions. Remove the custom strtou32 and replace it with str2long.
> > >=20
> > > Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
> >=20
> > Thanks for doing this.
> >=20
> > > ---
> > >   cmd/fuse.c | 27 ++++++++-------------------
> > >   1 file changed, 8 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/cmd/fuse.c b/cmd/fuse.c
> > > index 598ef496a43..9f489570634 100644
> > > --- a/cmd/fuse.c
> > > +++ b/cmd/fuse.c
> > > @@ -15,17 +15,6 @@
> > >   #include <vsprintf.h>
> > >   #include <linux/errno.h>
> > > -static int strtou32(const char *str, unsigned int base, u32 *result)
> > > -{
> > > -	char *ep;
> > > -
> > > -	*result =3D simple_strtoul(str, &ep, base);
> > > -	if (ep =3D=3D str || *ep !=3D '\0')
> > > -		return -EINVAL;
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >   static int confirm_prog(void)
> > >   {
> > >   	puts("Warning: Programming fuses is an irreversible operation!\n"
> > > @@ -54,14 +43,14 @@ static int do_fuse(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> > >   	argc -=3D 2 + confirmed;
> > >   	argv +=3D 2 + confirmed;
> > > -	if (argc < 2 || strtou32(argv[0], 0, &bank) ||
> > > -			strtou32(argv[1], 0, &word))
> > > +	if (argc < 2 || !(str2long(argv[0], (ulong *)&bank)) ||
> > > +			!(str2long(argv[1], (ulong *)&word)))
> >=20
> > I didn't know we had "str2long" which is a differently rarely used
> > function. Why not just simple_strtoul inline? Am I missing something?
> > Thanks.
>=20
> We cannot use simple_strtoul inline directly because we need proper error
> checking to ensure the simple_strtoul conversion was successful. The
> str2long function is a wrapper around simple_strtoul and the necessary er=
ror
> checks. Hence, using str2long here.
> Thanks.

I'm sorry I'm still not getting it. We virtually never call str2long. I
was taking a quick look at why if anything the 4 callers in the entire
tree today have more special error checking requirements than every
other command which parses user input.

--=20
Tom

--bk+XhPJO/zhVpnjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUOJUACgkQFHw5/5Y0
tyzCSwv/TycFxWwvIFw18UZk15bsC6DNQ47DAhfEjboSLYZeNmYbS7C13DvMMNys
kLdOTQGY/hccPHELJe1Qu4UiQyTDrZaewYnv/Id5sGKvyQnzi3UywlLvPf3oua2I
wF9YEE0cEZzMGJ6+EDEy0S46oRqZtLKWMZtnAkHDVaynzA6x9US0UkQpGQM2T6X/
K3FDBi5sU/dvL04m0UQzx07ePVR9BfBuFp0WAlsLgPomK132SqdqFVwY9f3JygSF
DVbA1UC5aBws1d68rnEgZGSW8Bg0e/ZZR31KSKRwyqqpqsPfFulNWPjD41Gq0/zL
b+tAW4Gk4qQkTGbPlvmCniZ+7wNhT4SMoUkCn+iwJeCeN+ep1OIvMMt0Fjf0K+/O
QqAk8kJZj6pLj1fbHTzHdvfP/FQEgWXT/j2P/DYiy8h9wJVFwnd0DEGGVTFHKEwP
+EpZDPTVzbCkvLNpqW3dlkSngBhDdpgbX3tj4UlzNRcvS5iYUVrHNqscdWDylu9n
zh4aJBZ/
=1Afy
-----END PGP SIGNATURE-----

--bk+XhPJO/zhVpnjn--
