Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B72C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 17:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E331D8081A;
	Tue, 25 Feb 2025 18:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OKT5Rmlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A151580977; Tue, 25 Feb 2025 18:59:26 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE3E807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 18:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5208736db3fso1733728e0c.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740506363; x=1741111163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yzq0j5IAn3sD7/CXGlwhPFUEy0VyUUgkmFQlMEBm7sw=;
 b=OKT5RmlmslrsxW9iTPjlDnfCm1og5+cn6KZbaixffeTeGEcl1OXDcg+4vP/yH2yWXj
 znAE7OyYGfQNhaVieCcSM2auvzkfgu+ImX9d/T/1M9SxVfNxND7b2VLNIJt15gWzZivf
 iQBWqu3ttZpDoRUf8UNgqV2XpsCrNcyjj+o8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506363; x=1741111163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yzq0j5IAn3sD7/CXGlwhPFUEy0VyUUgkmFQlMEBm7sw=;
 b=JOHH3tUt2eaiSr7l8ONKpirMdl9kkb7Pm3YhxftHohRMdMipTPyCuyPK6c84TOvuMz
 l9JDFgwblRbEkG3jbfu/PJ09i4ncV+a4pSHDCSMM4Ras8Zx5LcDtxaULWA/Fen6PALdc
 qBSl3QSycylTvfZ41+VBK6Gp8CIcrX6xFOD5ZLzsupGYtPzR7AxCEHYy6Sylvh5/N0rW
 vaonyS47kfiIkO2vWt0ECjLswTy4mWpZ2gj79rLGX8v/sbGertUOfn9biE4svbsJGO+H
 kLzhHXjFXlM79+7DVVqZTMSphj+oR4E1LipEc1vVw3xAPpJo32aBe0mUqRFa2xBWKl/N
 S8Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdQ90qwDMQb5nQgmrHoxUlVCeDAp2EjYrJtmAJpJJMu3XkCukaDqZJXn6k4uVOrJjrxSKuV/s=@lists.denx.de
X-Gm-Message-State: AOJu0YzluukWo4t7i64f3bhfTwMFZFSlbRIcQAD5ZbGih8xDoflk3IxP
 dgxwZBHURniZsEDDNqHqnjBe0xAtiS7u4woSI1EeAj66Wanny1FGwwjhl//OOrA=
X-Gm-Gg: ASbGncscxXBTxuEZg1zgjVURm7AQKGPfHOsKaycld3+zKFMougV1Z+XoYVqswaa+Odm
 2IBE91C0P0B7oJ60tawYOdw+Tee08zg871dKzp3MFXFKwfEmE9p5Wcz1DQ599hw9AzWZIgjvFuG
 kD3UH4tKGPelj8Py60MEvg9PzpzKAz8FYpgTegxZ9D54RFb82I4ow2RUTV8naBK/iWFRm+o1REt
 b5e6KJlMYJIh2hK++y+LxiVLEehpbj66EhQ1SlxZuobZdlLpeisQIpSDb7XUTl/8FMmz6zghkUv
 zU24BltIs8vOvRTi3hcycY3i
X-Google-Smtp-Source: AGHT+IGabwerju1Imh4dTxynGtibP1U/FqxBhXpmyBM9wo45zg/M1sGxbA4/0xyCaYiRQFr1cIWFRg==
X-Received: by 2002:a05:6122:4286:b0:520:3465:7302 with SMTP id
 71dfb90a1353d-5223cc12bf8mr2750324e0c.5.1740506362988; 
 Tue, 25 Feb 2025 09:59:22 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5223e1e4d7dsm281760e0c.42.2025.02.25.09.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:59:21 -0800 (PST)
Date: Tue, 25 Feb 2025 11:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Bar Or <jonathanbaror@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Huang Jianan <jnhuang95@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
Subject: Re: Security vulnerabilities report to Das-U-Boot
Message-ID: <20250225175918.GQ1233568@bill-the-cat>
References: <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat>
 <8734gjsh8t.fsf@bootlin.com>
 <CABMsoEGq+s2qudAHVwydpwXw_ROVfgw90yU7+VKYO6x27AWdew@mail.gmail.com>
 <CABMsoEFcL-D2OzJWQM685TfLq20L+d2gNmy4XD7yW6aDwpKb4w@mail.gmail.com>
 <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qv+uw9jvr52Cxb9K"
Content-Disposition: inline
In-Reply-To: <CABMsoEEQPvHM7jKYZZE1UaTgVTuN-TneVi8X9LRsr3+bD7xH3Q@mail.gmail.com>
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


--Qv+uw9jvr52Cxb9K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 12:47:45PM -0800, Jonathan Bar Or wrote:

> Hello Tom and team,
>=20
> Looks like all of the issues were fixed and merged - am I correct?
> I intend to make a public disclosure March 19th, is that okay?

Yes, I've merged all of the patches I'm aware of at this point.

>=20
> Best,
>        Jonathan
>=20
> On Fri, Feb 14, 2025 at 7:24=E2=80=AFPM Jonathan Bar Or <jonathanbaror@gm=
ail.com> wrote:
> >
> > Please disregard the previous message, those are the actual CVE numbers:
> >
> > - CVE-2025-26726 :SquashFS directory table parsing buffer overflow
> > - CVE-2025-26727: SquashFS inode parsing buffer overflow.
> > - CVE-2025-26728: SquashFS nested file reading buffer overflow.
> > - CVE-2025-26729: EroFS symlink resolution buffer overflow.
> >
> > Best regards,
> >            Jonathan
> >
> >
> > On Fri, Feb 14, 2025 at 7:17=E2=80=AFPM Jonathan Bar Or <jonathanbaror@=
gmail.com> wrote:
> > >
> > > Hi folks.
> > >
> > > Here are the CVEs assigned by MITRE:
> > > - CVE-2025-26721: buffer overflow in the persistent storage for file =
creation
> > > - CVE-2025-26722: buffer overflow in SquashFS symlink resolution
> > > - CVE-2025-26723: buffer overflow in EXT4 symlink resolution
> > > - CVE-2025-26724: buffer overflow in CramFS symlink resolution
> > > - CVE-2025-26724: buffer overflow in JFFS2 dirent parsing
> > >
> > > Best regards,
> > >            Jonathan
> > >
> > > On Wed, Feb 12, 2025 at 12:24=E2=80=AFAM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:
> > > >
> > > > Hello Tom,
> > > >
> > > > On 11/02/2025 at 15:29:09 -06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > > > >> Hi Tom and the rest of the team,
> > > > >>
> > > > >> Please let me know about fix time, whether this is acknowledged =
and
> > > > >> whether you're going to request CVE IDs for those or if I should=
 do
> > > > >> it.
> > > > >> The reason is that I found similar issues in other bootloaders, =
so I'm
> > > > >> trying to synchronize all of them. For what it's worth, Barebox =
has
> > > > >> similar issues and are currently fixing.
> > > > >
> > > > > Yes, these seem valid. We don't have a CVE requesting authority s=
o if
> > > > > you want them, go ahead and request them. You saw Gao Xiang's res=
ponse
> > > > > for erofs, and I'm hoping one of the squashfs maintainers will ch=
ime
> > > > > in.
> > > >
> > > > Either Jo=C3=A3o or me, we will have a look.
> > > >
> > > > Thanks,
> > > > Miqu=C3=A8l

--=20
Tom

--Qv+uw9jvr52Cxb9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+BPIACgkQFHw5/5Y0
tywZTQv/Y356nJw+qtF7DNuhc/jA0QViBtH9BpG68DIe3E6MCgDmqyal2DHgfpD6
LY5L2aLXXQL/formvyBk6BnCNiXyzbiy1N14e8Mp6TmHRPJ9/l0CH8+PMfoHgIgn
NCGLxpVdCfz6CP89sovVIMnWWtuWY1jAJHenOr0xuxrvlTPwS15WYSAualpvqM3W
KSIaKY6bta1ylMicVlsf3aUYPkxr1KZj0B66zp4QrSEKOSSyzsxoHJA7x8hgaDNw
jnxwWwKgbRl9i7dILCO2wtIkd5rPfrnVpPS4nb7WJUgGZ/lXbIzHAwDkLscRmYeP
EUYTHuxoKRlpO3aJXgePuGo+yX2RiQFRI9yHXQsPV1ueysdlQKA4h2jcE3Rlax8q
xUQnNSvNmcPNH/ZegwdSd2YlPAZXoUgGV0CzYuf+OX0+5Fz6BELVQd4Dc5CJ+kVh
+X5XyIAhhGCKdNrMXXbJoPcLts0TOnf6/wNVCBsOI8B2/I/LFpB81M2D8JT0LPq8
0Hjh1lNK
=dup9
-----END PGP SIGNATURE-----

--Qv+uw9jvr52Cxb9K--
