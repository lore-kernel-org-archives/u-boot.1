Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E70C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73BA82153;
	Sat,  3 May 2025 18:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lZyj+Zts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AAF82163; Sat,  3 May 2025 18:51:42 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF0D8210D
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-601b6146b9cso1527690eaf.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746291098; x=1746895898; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4jaNvWe3qb9eF3Jb4truPBMAu0c9b7cHCn9/p0vBIE=;
 b=lZyj+ZtsG5d61X96CgQe4BAxzwRkeSr2eU3iKxpJLkASsIXkYzC12c5Tu2SClVwzJJ
 q9T/O13zsRQBU2y1x1qgNFESmvbXbaPcOF0DTL8UMI6Jql8BJV/ffxVLxPBRymjs9F0A
 0uCy5r2EmOlKk0uKZJNXJZwMqVxFHQO+IJjB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746291098; x=1746895898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4jaNvWe3qb9eF3Jb4truPBMAu0c9b7cHCn9/p0vBIE=;
 b=mlKaPPNL3ERS6UZ8eG03NqAdww+LpMMbM7DRIn5Z/beIt8qJGusOO7gks0T3qHh2LL
 YEiX+m+8+jOk6gWvIdl96PEIDfsUGwMaj8lUXL/5W7DRD64/g+eJn4qc0OyO88kE+VzC
 jMw3/iH5Opoj7xkaCtlDbERbrvxFvkZCGg4jC60/9EyK4oBwZmpC+aHYkWOKiyfz2qh+
 32HeqGUoinw6sBqIaSVGkNA+wTQq7GsUhw1osMGeXNqlfK3JMdSj5zU+yyrxiL5inH60
 kcpaC+4kHZ9GEDLzUfBumXsFBrFJKS+p5dchHJPMjRBECVMxKDYLDOLh1PueexfPWful
 PJzg==
X-Gm-Message-State: AOJu0YwApQFOyFmN7m7jrFfqFneqzy75dDXZHEIHzO7P8JJde1WUnUX6
 Zpueopx0frMhHvOQx9r7b2QSQNfQqraJ8I/s0iBKupoPasq0YULg5OVuMbCO7cdyIn3YdbBrpf2
 /
X-Gm-Gg: ASbGncszc2sd8rvZfQG6QyQnWv3GSUx+6axyaIGJ+2k3qKRp3tqkmVU9d2r1rhDni0N
 OBkjMZaFl9KFTficGrB1KO1NvU0h6RCHCU+vUHFMj0lxnJe6e+AP/XAi0A71y1CYSm7EQ68Q+t4
 vmoudaDHEIYOFsNlcSAv/NyW/iBk+LSujVGHFAmLc6T8LSOplPRuC73RzJqttsF3iQMhKbXJ1Kb
 B2b4Oa44+w6LwnPymPD65JO5DEj05N8E6uUuSU/4RQeb5FZDpAvrMbTj/cFMK7ikDs/r2a0QaDo
 uJbjgaCUFHl87RQ6Y8cGZvciviSb4VWF0uzC+3wqJsH/K2CV4zTQOBH6vfiWYmqY25QD4Z9+vpA
 i0w==
X-Google-Smtp-Source: AGHT+IEkHJkEhjoFQnEqG/ElcWBQDrlTsnt7w8igIdzvR7OiwIWIXkQStTc2xSn2QdCgOvIHXOhL/w==
X-Received: by 2002:a4a:ee86:0:b0:606:107a:ebd8 with SMTP id
 006d021491bc7-608002e3ed1mr773186eaf.5.1746291098461; 
 Sat, 03 May 2025 09:51:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm973400eaf.39.2025.05.03.09.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:51:37 -0700 (PDT)
Date: Sat, 3 May 2025 10:51:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20250503165134.GE1261075@bill-the-cat>
References: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
 <20250502222120.GB1261075@bill-the-cat>
 <CAFLszTgxkTLWZUw23ntowwA+MYCMy6t+0swjw_fTT3y-PgPpxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zGld0IO2Cec9o80T"
Content-Disposition: inline
In-Reply-To: <CAFLszTgxkTLWZUw23ntowwA+MYCMy6t+0swjw_fTT3y-PgPpxA@mail.gmail.com>
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


--zGld0IO2Cec9o80T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:11:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 16:21, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 02, 2025 at 03:40:32PM -0600, Simon Glass wrote:
> >
> > > Hi Tom,
> > >
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26056
> > > https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D77&vi=
ew=3Dresults
> > >
> > >
> > > The following changes since commit 6cc812f8cc55c132458c7da5b9fb766631=
5cbe8c:
> > >
> > >   Merge patch series "video: Enhancements related to truetype and
> > > console" (2025-05-02 13:57:26 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.denx.de/u-boot-dm.git tags/dm-pull-2may25
> > >
> > > for you to fetch changes up to d31d3a2949873b6217036650a449c1a1f74e62=
44:
> > >
> > >   patman: Drop the old status code (2025-05-02 14:54:39 -0600)
> > >
> > > ----------------------------------------------------------------
> > > patman improved to prepare for new features
> > >
> > > - Create a separate module for the 'send' function
> > > - Move to asyncio for patchwork comms
> > >
> > > ----------------------------------------------------------------
> > > Simon Glass (30):
> >
> > You posted these three days ago, which is very quick for
> > non-security/regression fixes, and didn't post v2 where you rebased to
> > master and should have reworded:
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/5a4f8a1f339=
ce4de2eca812bc19cca1e2ad6b9ea
> > as the commit message and the change no longer match up.
> >
> > And this is the same standard I hold everyone else to as well.
>=20
> Oh well, I'll hold off for a bit. I'm itching to send the actual
> feature, so I might do that while we wait.

And you're going to post v2, right? The thing that needs to be posted
and have time for people to review it first?

--=20
Tom

--zGld0IO2Cec9o80T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgWSY4ACgkQFHw5/5Y0
tyx1eAwAp222OPwkomK/D2Xjlc57lx0ET9bClMJFsOoQ5XQayINzSqBm74vIb7g/
OEsthifSl74unCiqcaW0VfTURyjxxJoC3mq95R8u8i5A/5/dw6d0Cv/BBGfw6fI/
OcjUU4upTsTQY9C9k1wiBT/6l4i85RFLVpJqnWjWfi45J9zzCRWJyxuKQ1w3Lg9R
NVppYVpRWGe+ZJqNBQvFiyluLcP5nBeC5vRfyISPyKueaU85csRDcQwdUGHZXSOW
4ej8og3Zjv4McH0HjvchLfI1cpk1tTUfvpx09MOgjJW2nLyo2oLBkCKsepfIr+4i
1JExoYt6FHSPS3QqC8JUigwLV0qg1fTEBXTzF0EafWN3RQaM1SLRoGBaJw3wZbBa
jSmvXrFXWPqwWlTsGsGcxnyS1HtI0aZVnLBm37uOgoTy+DMdkyiw7/rqkItCDTtl
tGO3OaM11AO9La1K2z2GX75HjjJcLz7pIB9QkOKIOv50/8PhY/fN1ZLkah5hhZ2G
hWlakplD
=DS8a
-----END PGP SIGNATURE-----

--zGld0IO2Cec9o80T--
