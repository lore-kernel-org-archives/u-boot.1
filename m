Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFF2CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20BCF83835;
	Fri, 17 Oct 2025 21:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dywO1EOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C93D83837; Fri, 17 Oct 2025 21:53:29 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB4383829
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65051376edbso576834eaf.2
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760730806; x=1761335606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GSt5geIGk02DCSqu37S6KkOiP1JqJElLntACoNRgtwk=;
 b=dywO1EOJiikOn9EuG8Zcyh01RzxJBMbnl0sz4yNUoCF4EP8OooMWjd3HM/uA8gTsGH
 4XBvJsOROFUH0tFPZlwCvht1D7ezNiaon7osuG3jVcmQqDWXmNHGP0FU0qQfie2ECAC+
 MAv+AqkiZIP2RfHFsMlf0b36+z9HEDCwMFqdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760730806; x=1761335606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSt5geIGk02DCSqu37S6KkOiP1JqJElLntACoNRgtwk=;
 b=hT0idQ1Yt5Sf6BknblrKXBVQSiWWxPi/FjeSaH26Ij+BIFQwxZy8ogufqsoJdkPugz
 4QdkT2UdtF3KlZHgxPxY3a3iZExjZ3TwnLDUkkV6yAWpFkwiP4ckYeOJDdubaZGdsEEW
 qXL/Nzw0yg4xlkR2gLksxRS8Hup1bw5LziqGKVHSqBm1pzgAZQ3rUvgSUVsqS8vW1Nvp
 h9TOOrN5QaMKoS1in0IVu6+F7Gh83Hda3LJahFVIh3TvsHo9ztGzegjm4B9FlYlMonmH
 4IWASICXKZM8/bUfM5KpAhBOz13xx7jcr6vc7tYbnfWR5tovie+xJnw5fJjbRSIIrVmR
 qfzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6ufBnJBjAm/GsSi+cX7ATVZ+UqVGYABPPxkmeHdUtyWsCdoTQleThu3fd5A6v+y8q7TSHhT8=@lists.denx.de
X-Gm-Message-State: AOJu0YzbLMkaOJ7O3f+PkXxscWb2OVi+P8/L1QEgPs3vfwgozbS+fAc0
 sSgEoxVCNR3/OyRCj4sBb//Nbdp3wehOO2g5xPv3PpQ68+jMekKAQFAxiYnQiXh+96K53jsk4BN
 Y8lNMIsM=
X-Gm-Gg: ASbGncvPRoiwZwpAHEuTR/DlwfoFmKBeLaPfRjKUa9K0UgPIBB4lRRdzzmcsOKIZk2t
 y8U8DDjOm4HfuWe4OQOSMWaLQm6gJGldTeJsWnoL9OIt4MooaARPtBotjBtY2cBhkmDagK/J52q
 +GRydBR4IbUmfEFQYjijAjQqixI0LMRyHS03Vo5fZDL1EL/kErCnhi7IaH3f6sR1YjQSKfwOw4L
 R1MwQGItBM8q4SDjTDguNr891mpyzBfquZPkrgb8aB6Q85i6Pc/vHJUQu26sseFtf+tCMVPmnRA
 adRYFcam94wqsjAX/B7CNiM5lBHuZ9L23NX3dB3skNTFOwy+QGy+0yVceQs7+Ry0FhOk43VwWgC
 yUoy5HSixutU2pYtU0rSoxx+dmxmnF7CX3z2zvFgddZkB5eqQu01CfG+TWXH5gtEJuioreOdJgV
 wr8ggW8X5a2ZfvZJKOifhayCrW2aiLpn8JLGd0xYBJs03Tl2mLIQ==
X-Google-Smtp-Source: AGHT+IE6TQ+YhNWu6YGn73Z3jQY1Z6wqC3wjjmYejaleinFPojba72yEbjWd/Nl0GSb0g2XHLZLTRg==
X-Received: by 2002:a05:6820:2f0c:b0:651:c820:ed0a with SMTP id
 006d021491bc7-651c820ed97mr1562610eaf.0.1760730805721; 
 Fri, 17 Oct 2025 12:53:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3edaf1csm146328eaf.11.2025.10.17.12.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 12:53:24 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:53:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
Message-ID: <20251017195322.GF6688@bill-the-cat>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <5ae75a6e-83f1-4343-b9a8-324892405bc0@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hwTC7eHDn002LfK7"
Content-Disposition: inline
In-Reply-To: <5ae75a6e-83f1-4343-b9a8-324892405bc0@seco.com>
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


--hwTC7eHDn002LfK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:58:39PM -0400, Sean Anderson wrote:
> On 10/2/25 05:39, Andrew Goodbody wrote:
> > After calling a function that can return an error, the test to detect
> > that error should use the return value not a different variable. Fix it.
> >=20
> > This issue was found by Smatch.
> >=20
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> >  fs/semihostingfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> > index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b=
31df58e2d65de7db9 100644
> > --- a/fs/semihostingfs.c
> > +++ b/fs/semihostingfs.c
> > @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_=
t pos, void *buffer,
> >  	}
> >  	if (!maxsize) {
> >  		size =3D smh_flen(fd);
> > -		if (ret < 0) {
> > +		if (size < 0) {
> >  			smh_close(fd);
> >  			return size;
> >  		}
> >=20
> > ---
> > base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
> > change-id: 20251002-fs_semihosting-85d697fbfcad
> >=20
> > Best regards,
>=20
> Reviewed-by: Sean Anderson <sean.anderson@seco.com>

I am inclined to say that step one here is this patch, and step two is
figuring out what if anything can / should be done for the problematic
case where it seems that other implementations of this do not follow the
spec, or the spec is too ambiguous.

--=20
Tom

--hwTC7eHDn002LfK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPKerwAKCRAr4qD1Cr/k
Cn0XAP9yEcmrFqp7MRbK0m0Ni973jjzpYPbxXEoVBCSrv9rjVAD/bS/uOHHjYQpS
XbamOo3cfnJox/SLHMPhRx3CS906Wwg=
=HIjE
-----END PGP SIGNATURE-----

--hwTC7eHDn002LfK7--
