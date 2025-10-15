Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9DACCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 16:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F29D833F6;
	Wed, 15 Oct 2025 18:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jJVooIjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF0A835A2; Wed, 15 Oct 2025 18:29:05 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC8A83303
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 18:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7a7d79839b2so5227491a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760545741; x=1761150541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fns5PYFV6eXkII6i0cGOr5GZGGuYCfyCY0HVZS5uDQs=;
 b=jJVooIjIAt8Z7slU2ce59n9umQiyYJGJPGLz7Acc0opKB1nWIzeNjIJt30cnF1j89k
 K3gqkL53/h/7dmp0UbSXX3LIU4LvLIzOiiHciZPqoz9RFJ41v/mpzLkdnTcdnKjHvNG3
 g/ICmm3XmsLefsmEoKyFd/THPW4wP/qOpnq+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760545741; x=1761150541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fns5PYFV6eXkII6i0cGOr5GZGGuYCfyCY0HVZS5uDQs=;
 b=UKGNXxqFpvMiCj7F/rgGaPl1zMfRvRp+jMUWsR6pKuu8stxdnfJ4dnxPAiGKFIDtXO
 3bDtJGnMTJx7eBS9pKBOQIX+FmgOo/8IeA3VTmZNGVVWWANREhitI0y+4um+BmQe9fPt
 IbCbdoYB5Yh/29GEOsQmsXOS+36eEOIZAXbu7+7phbWrLO3dpDvbHnS7qrU/s93fByJ/
 SrvKykkcunc29hYqhxO/K/ZeW4LSq735nwIqyEXCQg6uOvp/RzRaF1w5ig4V+v+iMHYC
 f3F547+1GA9azLlGdTAKTVrenLuZsD5r/jwGv1Zos2RIIE+y7Lvf/iNSIikRj1MHgJhZ
 ghXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+3AdPYbm2jWSsEGma2a/aRP6G2A+r38DJTOINLfQH8ht824R7/3IuHoEkce5TbwCn8/3fk7U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Ec15c6qzl0LbMJZe1M2kxNClUAIsmeFM57hBq9Z/lNBYs0Op
 /YE367Vv6kBx7joSmQWWgvlRc9WhbJZ2h3v9BM73uOhP+okI6d40uUUqlk4OuGucadI=
X-Gm-Gg: ASbGncvdZzPC6fCt5yIyUJNolBRH1Kmno/1Imn19A3deeAnZDTEhmci2DMZEjEvG2oC
 YGi7plVfEVP06mzsSoJx+7qNxUv1KKbRzNPt3VLSHCIXZrhllU3T17DYG0MLhFihgRfmU7cdUME
 Js8nJMWOdjHDm0CChWg8ntwXUpDIPWopA538LVIqwaA6y+9g8zLvcxuEUshJ9EB3+eKs+sfL3hN
 1Rsfn2xCZKH1bGhdVDFM7fn86KceZJ70Hhcn1rGQWmpJvKyIIeDa7V8oOw9k1LlHyEK2OerDL6E
 dCelu2Flyz+rBrxQlUd6nPsel9XdDmcbLTBjrEvCjkesNXDV2qiimrb/axp2tuRfDusEkJTPPr/
 xRaO+iVC4rucsGfZxeWPdMJVJvoqfsGl2Z8xNQxZ6DGw1jpRc+DTXRrOQwTSZYPd9AjiG2t1QtU
 VOPUEWoy5HLvEdEjo=
X-Google-Smtp-Source: AGHT+IEGbK/TJ1au1MKwNJricHv4rbzl+5fWBrzs2Uufb9UEvdLpzGq5zPFK07elBcYXtFCn9Jiclw==
X-Received: by 2002:a05:6830:61c7:b0:75a:3c7d:9826 with SMTP id
 46e09a7af769-7c0df804a75mr12352015a34.29.1760545741516; 
 Wed, 15 Oct 2025 09:29:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90fb4a0sm5441136a34.17.2025.10.15.09.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 09:29:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:28:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
Message-ID: <20251015162858.GA669557@bill-the-cat>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VxeW2LUK+0/FQG/m"
Content-Disposition: inline
In-Reply-To: <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
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


--VxeW2LUK+0/FQG/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
> On 10/2/25 05:52, Heinrich Schuchardt wrote:
> > On 10/2/25 11:39, Andrew Goodbody wrote:
> >> After calling a function that can return an error, the test to detect
> >> that error should use the return value not a different variable. Fix i=
t.
> >>
> >> This issue was found by Smatch.
> >>
> >=20
> > Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
> >=20
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> ---
> >>   fs/semihostingfs.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> >> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34=
b31df58e2d65de7db9 100644
> >> --- a/fs/semihostingfs.c
> >> +++ b/fs/semihostingfs.c
> >> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff=
_t pos, void *buffer,
> >>       }
> >>       if (!maxsize) {
> >>           size =3D smh_flen(fd);
> >> -        if (ret < 0) {
> >> +        if (size < 0) {
> >=20
> > The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis=
/clicktime/v1/query?url=3Dhttps%3a%2f%2fdeveloper.arm.com%2fdocumentation%2=
fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0=
c%2d&umid=3Df17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=3D1759398729&auth=3Dd8=
07158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef8=
4918) has:
> >=20
> > SYS_FLEN (0x0C)
> >=20
> > Returns the length of a specified file.
> > On exit, R0 contains:
> >     the current length of the file object, if the call is successful
> >     -1 if an error occurs.
> >=20
> > Please, consider that the file length on 32bit systems may exceed 2^31 =
You must not consider this as an error.
> >=20
> > %s/if (size < 0)/if (size =3D=3D -1L)/
>=20
> This cannot occur because on a 32-bit system SYS_FLEN only returns
> 32-bits of information. The host must detect files that exceed 2 GiB in
> size and return -1 (simulating EOVERFLOW).

OK, but this is for 64-bit systems too, isn't it?

--=20
Tom

--VxeW2LUK+0/FQG/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaO/LwgAKCRAr4qD1Cr/k
CuAMAP9ew7ZicBHII6DrgOfwbdN0V5kmv9iBNcShfFKwyeHDogD/SLVknVmSzfMK
/efAogx1xDbolo/CseCQXaQBJmp9pA0=
=0Qhf
-----END PGP SIGNATURE-----

--VxeW2LUK+0/FQG/m--
