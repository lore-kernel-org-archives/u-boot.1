Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75C3C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 18:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A2C87E46;
	Fri,  9 Feb 2024 19:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XEmjwV4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CA987E83; Fri,  9 Feb 2024 19:58:30 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B723087B6B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 19:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68cc9061c78so6751766d6.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707505107; x=1708109907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f6mhOk5DK7uPFT3UjuMT3XajNMmeyW5vpJgi0pXHDLE=;
 b=XEmjwV4O7xMOjYShmJq9dEL6ifZapyUkUKmSEw1o/obOFIdc4kpcY7jao3GWY2LI+n
 vsuyX5Oe/mMIBFljdb7zKWYz8I/sayLoMK9qI44xL7/JgXNuX1Y3Lqi0sDP5vZjFvhu6
 GTcKeBtC79QGrprK8xhaBBLZzm3DZrNDs8NgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707505107; x=1708109907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6mhOk5DK7uPFT3UjuMT3XajNMmeyW5vpJgi0pXHDLE=;
 b=Br3oUsxM46Au/B8J858oZ6z2yOEOUp7IhPsU9cfGspFQNO7mVBOlvUL2hcDutTKKyY
 6E/iGv3dfyehngrMoLbwqrKqh7cke7LCQJaqnK5mDmAfj25qIoOfNWQU1ADo24CaqIZE
 vr33aIdUgxmkFF/vSkvHl7+plAfuy41x/3xe5jIvQpzEjqLLdkHIkoctPyv1Wn2b02DM
 3JXM07Mp1hc+gaZfk7ggkvgFRlnDEfTK3Fh4gHxOeKyV5JrQT+vnN979OYmz0U21XGbm
 Kq2tiQMq65XO5KO8bM2SjFIqlvglhwCo/EVIHgKnTHtjyfX4OcmZ61qM2bHrmEaUAc7d
 GxXA==
X-Gm-Message-State: AOJu0Yzyd5z8YBGRUphRZdh1eVaoUlW0hW6m+dJWS3V/sQkzgSHmHH1T
 z0hh3NohR2XwhDu0yggUF8RGNhjf9bl6BkZ/itHTkIkZOlFGB0kwuI57SzY+T/Q=
X-Google-Smtp-Source: AGHT+IHi0R+URkSHCwG8yYd1pQY9wOhJJneqeP4CLVNKcJfESP8EZN6CYkCVvaICaJ/W1NIsOQOE0Q==
X-Received: by 2002:a0c:e393:0:b0:68c:6649:51a6 with SMTP id
 a19-20020a0ce393000000b0068c664951a6mr2178752qvl.51.1707505107503; 
 Fri, 09 Feb 2024 10:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/9SYMw4BQDzpjc/ydAW3BDTZqHWHJNQV0qDw8ev57Ab9upIScCMFa1xJDN2kWL34Ah2qt6WWJGkY+FpZtI0zr0GUoviqFrJH6X3zhRymYYQBXhBUt+xGVkqLpxDIWdKVwBucL+1NO8Z/vhSS+1e2bdDjsDrkZCueMA==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 op33-20020a05621445a100b006819636ba87sm1078199qvb.7.2024.02.09.10.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 10:58:27 -0800 (PST)
Date: Fri, 9 Feb 2024 13:58:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 2/2] smbios: fill wake-up type
Message-ID: <20240209185824.GP1152441@bill-the-cat>
References: <20240209155115.102957-1-heinrich.schuchardt@canonical.com>
 <20240209155115.102957-3-heinrich.schuchardt@canonical.com>
 <20240209181251.GO1152441@bill-the-cat>
 <97001fd9-1fbb-4f42-85fa-491660239ce5@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9L/M0ZItlW2iZ1A3"
Content-Disposition: inline
In-Reply-To: <97001fd9-1fbb-4f42-85fa-491660239ce5@canonical.com>
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


--9L/M0ZItlW2iZ1A3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 07:37:28PM +0100, Heinrich Schuchardt wrote:
> On 2/9/24 19:12, Tom Rini wrote:
> > On Fri, Feb 09, 2024 at 04:51:15PM +0100, Heinrich Schuchardt wrote:
> >=20
> > > We should not use the reserved value 0x00 for the wake up type but
> > > use 0x02 (Unknown).
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > [snip]
> > > @@ -108,6 +108,16 @@ struct __packed smbios_type0 {
> > >   	char eos[SMBIOS_STRUCT_EOS_BYTES];
> > >   };
> > > +#define SMBIOS_WAKEUP_TYPE_RESERVED		0x00
> > > +#define SMBIOS_WAKEUP_TYPE_OTHER		0x01
> > > +#define SMBIOS_WAKEUP_TYPE_UNKNOWN		0x02
> > > +#define SMBIOS_WAKEUP_TYPE_APM_TIME		0x03
> > > +#define SMBIOS_WAKEUP_TYPE_MODEM_RING		0x04
> > > +#define SMBIOS_WAKEUP_TYPE_LAN_REMOTE		0x05
> > > +#define SMBIOS_WAKEUP_TYPE_POWER_SWITCH		0x06
> > > +#define SMBIOS_WAKEUP_TYPE_PCI_PME		0x07
> > > +#define SMBIOS_WAKEUP_TYPE_AC_POWER_RESTORED	0x08
> >=20
> > Shouldn't we do this as an enum these days?
> >=20
>=20
> The field in the SMBIOS is of type u8 and cannot be an enum. Defining an
> enum would only make a difference if we had a function using it.
>=20
> Do you want me to resend the patch with an enum?

Since I think this is going to be the start of adding ore and similar
values (which to be clear, is good), yes please lets get in the habit of
generally using enums here. Thanks.

--=20
Tom

--9L/M0ZItlW2iZ1A3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGdckACgkQFHw5/5Y0
tyz+NQv/SsRilgr/h+jCuDmfMkVg4eb5MFv+ne9IwpbtqxdDOQPUyhTMuBDFbwQx
mS0ZGxXaI3uVSHek4zMefvPrPEbYv9xyTig7PRHbZAkW+MMKecpNzjMwKQvAWC1C
keO4D5MUlvex2KAbeSsq0XM8cqThh6P9sVX7g7DOY3QqRdUgZGFe4e0EWTGTjHcB
i72T9qQWjtnaTc+NLR/EB//bdHbmHN6qng+a5aXOxtfXEfJYtCnQrbJViJ3LniIT
XKz36fA2nDsp1vuWu5AkG/U9D4NARlYLV3dHmVNyAk09/w3Q++1IXf2wO+hk18Jy
71sGvV+Whzt5ctp60kzSuquGtkU3f+14Je7d0ET6O614gxIQ7gPK45msaYGyOUF7
cKRA5vX6NEXP+9xbLcwGTNgQNjsePUYFdQGgTUdvQSHYrA6agR1PBjIaI//cKRNJ
i9koX6jSa8b0g6MK1fiXLXqH6sZc4RNLlZISeZbOUzp7d2w18UxCbUT/eYdwMk3i
tr6/IiRB
=C6hv
-----END PGP SIGNATURE-----

--9L/M0ZItlW2iZ1A3--
