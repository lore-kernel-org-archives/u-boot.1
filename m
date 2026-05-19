Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CD0CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 19:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5B1846EC;
	Tue, 19 May 2026 21:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrawILXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21897846F1; Tue, 19 May 2026 21:59:51 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072CE846E7
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso3235383a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779220788; x=1779825588; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vAI81B4Je4YXCk0vavnys9QHNn2L7JIpgGvhtsCMcr0=;
 b=CrawILXk1AOhTTsYKcTQQqwB7WMizzjdj2dM8qs5+mXpDN93RZwFS1aLvb4WsuHsvU
 CIABIDeI3fayhkRWJdbJpnWLxNghuyHvraPEu+aTNddDtm5syJoXeNJgElmNaVVTQiBq
 f9huFiCB+yYGJq7zZRVcGA0Q+oVRs0e5hsjKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220788; x=1779825588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vAI81B4Je4YXCk0vavnys9QHNn2L7JIpgGvhtsCMcr0=;
 b=XWkVfnHv+9S0x848074KikRRF1edof8mlgp2XvmCb+PSzC7WRRuJQmtKndecJTEazw
 0SIZFO0gEHxMh51ZA3NF0tmM7QdUrN1haGlY3HFnGc3g/a9qSobkCiEUeQl4+mxKKdff
 Vvt9IJpsndrDdebCqQt98qiNM0Tm2lLdu/bQDhwAE77k/OivqZIg9PDUAIRIMHGppEJn
 Ng9wGN9jyVCnQejHvMsrkJvsfk4+oP2dpWQZJc55w1qolSBIeMCzgUztXZdB1j4CPZ7n
 gt4itUU40+6xdsVx0YhnN57peYxuRnShOdesHPJDcsujY9FrK9xCuSf1d61I109+qz2J
 sQYA==
X-Gm-Message-State: AOJu0Yx+npQ1dO/nm54cfP4W6qawAWQT2nz26YbOkCtm+Qs7JBjKfNPE
 bq7ftrAMoWqzVMk3iRy3Q99SnAcjW0IvFqTkSvROPB/vYcQJ9XnGb+x+0RRsTS8WpJNw2v0B7au
 eu69wPff9B8f5
X-Gm-Gg: Acq92OGtXxTpqV995g0VzDBwuzOEVC+50K+UjlW5JUvMVpE6SfIJkhKpiqgDC5L+YfG
 DJgOEL+6Be/MmDR7sHak8PMmQyNKYm75MBnhuTQtdoTJOgKiqP0TTjJ151H1K8jfad/1PNgkEYW
 ZHPOPv4LUzNuDa5DL6485apLT4/fAgL8tvQCvW9YZOVgpR2199+SRWwyLXqLkwibKc2lHrIafWB
 NHIXWQj5uPYLQuRdVrhMlfQuylRgs0zvaBbwG3h9wwLel2iCWLiOwfNLRHdobDtMdCBxrN5s2dn
 6rZ+w0s78RzO17cqmlWgEd2mbuvyeQ84mCNuDTcqvwIyCGf/i/cRYh9yohQzsUNo3uCQS68Zkj+
 S7jB1O1ZpNATCYtSGu3ee8aUGOxmgdIgDjPp4QqgSV/5ZTk+eZ7vGMHRQIziR3euRCzG/80I5cN
 a6sOfvb0Z/YxDhkp3V3Rrs4raLarNWCjASSSLOeeoONQhfcBpgMGP3Rliw9zmZrm+1tRA+7dx9/
 IYDC1OgqRsPBjhmrqoiHnZJzFQo+NFPNyfmSvGW9QBPERp6M9Q=
X-Received: by 2002:a05:6830:2b22:b0:7dd:b184:1338 with SMTP id
 46e09a7af769-7e4ea06248bmr15163103a34.6.1779220787596; 
 Tue, 19 May 2026 12:59:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c68d6sm10499992a34.3.2026.05.19.12.59.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:59:46 -0700 (PDT)
Date: Tue, 19 May 2026 13:59:39 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] event: Guard more of the prototypes with an EVENT
 check
Message-ID: <20260519195939.GF1858239@bill-the-cat>
References: <20260519182856.865924-1-trini@konsulko.com>
 <20260519182856.865924-2-trini@konsulko.com>
 <20260519191054.GE1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1iKQav0vpOA0tPUv"
Content-Disposition: inline
In-Reply-To: <20260519191054.GE1858239@bill-the-cat>
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


--1iKQav0vpOA0tPUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 01:10:54PM -0600, Tom Rini wrote:
> On Tue, May 19, 2026 at 12:28:56PM -0600, Tom Rini wrote:
>=20
> > To make sure we cannot encounter the case where code is written to use
> > the event framework, but EVENT is not enabled, guard most of the header
> > with a build-time check. This will promote the case in question to a
> > build time failure and not a runtime debug issue.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  include/event.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/include/event.h b/include/event.h
> > index 3ce5f992b04e..71fb14391f25 100644
> > --- a/include/event.h
> > +++ b/include/event.h
> > @@ -308,6 +308,7 @@ static inline const char *event_spy_id(struct evspy=
_info *spy)
> >  #endif
> >  }
> > =20
> > +#ifdef CONFIG_EVENT
> >  /*
> >   * It seems that LTO will drop list entries if it decides they are not=
 used,
> >   * although the conditions that cause this are unclear.
> > @@ -348,6 +349,7 @@ static inline const char *event_spy_id(struct evspy=
_info *spy)
> >  	__used ll_entry_declare(struct evspy_info_simple, \
> >  		_type ## _3_ ## _func, \
> >  		evspy_info) =3D _ESPY_REC_SIMPLE(_type, _func)
> > +#endif
> > =20
> >  /**
> >   * event_register - register a new spy
>=20
> This was really my v0 of the changes, I have made this more general and
> will post a v2, of what I had intended, shortly.

On further testing, I'm going to stick with this version, trying to
guard more of the file would require a larger restructure to avoid
other compilation problems (the header being perhaps too broadly
included, CONFIG_IS_ENABLED(...) checks, and so forth).

--=20
Tom

--1iKQav0vpOA0tPUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagzBKAAKCRAr4qD1Cr/k
ChsaAP9tT/hSvK5XdeWVrI//JJHkNVJ3nCXGBPvld35Vu5jRMwEAzQ32C7gwRGdz
0nl8ctv/6gymBcGtfFUAhM3X5O820wc=
=8rFj
-----END PGP SIGNATURE-----

--1iKQav0vpOA0tPUv--
