Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A39BC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1E082B0F;
	Wed, 18 Jun 2025 16:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPHOajuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A27480E9A; Wed, 18 Jun 2025 16:06:37 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BE9982BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60efc773b5fso3754003eaf.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750255593; x=1750860393; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=osgGLIzrX1zjXAXLDyn+pGFyyI/dKEyzOlLcVqBQ7n0=;
 b=BPHOajuN6G5rOSXbu1BtHprm4tBpD03jyagzYi2LLnS+468RMDP3KPzke0AGmOdBOD
 to0YiHHgV9bvOzGZldzWZPzQrvLkKneqYbo3JEJFyTvm1I1nS2Vm8stINJswm9ZNTJK8
 lbG8GSTTEIzbof1Oa0IG1QL1Sni+lKyBgUUW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255593; x=1750860393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osgGLIzrX1zjXAXLDyn+pGFyyI/dKEyzOlLcVqBQ7n0=;
 b=lPXK+uMIvkJJctDsMslW00YOlrFPJJsBY2iOIbpnG+iy+UsktwQM/m7v2F+hMHtOdX
 l6c3VA1kwnlJZzcskMVJOQP98GQGAOFMa3JwKkV1AsCVc1Nma/eMClB3vIAtEAtbbetv
 w3IbGPHuNz4ggY5LFeqhYyqzPgG8MeWfOHXsLb5Vwr69QxVIdG4DWniF5WNZkQ5WVqui
 8zhvvw/RETSf0N/P625vMfkVrAZjyr0/nIoCgEhvWhn1kZZOx35z1hJ80vleMOpF7j3Y
 grZlIE1U5QzRqc2oiTvO1ai5JMHG414hoAVL93HX6IM14s13NKgjWMqpEIkzftA05inZ
 iQkg==
X-Gm-Message-State: AOJu0YzxP6XLm3ae2MrZHTEGHtwBYJ7FFZjRcraa+FpgjLTV+BNWBANE
 EImG6dxmXyk7j2YX9AnUjS8BmrV/++GompAREaFWkmrveFLJIn0ZpAp8dgiGzyzLXA0=
X-Gm-Gg: ASbGncsXi/965+AsvIPXc9hTwK1rh0Yz/nEFsOk5UVHytZgotvQcCe4NhRO67I+e3uu
 LVhZsKu8mVX2uASUuArF+j8t9Qczf0QQcDIxhEJPTTnS9O1+belxl14EKuZPrcxBmmiQpZM4QGl
 0LRKf3zGQF8UxF3DBGkOfAWzSHqkVhwZT3NLq7V1dSBjj2CSLniGTSKfPkQ0avdlJGvvEdNldBB
 ULIryPVHftBO+Dqi2nsb7JTQKU+3AJOMOyJM+UC4uSAxqRZN5SAYTJTtNVPC5pA0LbRZr6v2nye
 JuI1BizEMEVc6Y71orM5659wkdI5d2gHGNaeSyXn6WaO75kT8QP+3Ay+xfcjiD5Hcwant+3AS08
 mEmHvpSlWVeONP+0lOsV+rbw=
X-Google-Smtp-Source: AGHT+IG3nwktZAKsRZTkFpf+/rpnvshJS5WLSzXC45icfBvCOBqMnOuoGODMXhcRoO0EcaCRODucYQ==
X-Received: by 2002:a05:6820:168d:b0:60f:847:8354 with SMTP id
 006d021491bc7-61110f312abmr10798850eaf.7.1750255593212; 
 Wed, 18 Jun 2025 07:06:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d785a6sm1418724eaf.1.2025.06.18.07.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:06:32 -0700 (PDT)
Date: Wed, 18 Jun 2025 08:06:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-ID: <20250618140630.GC6521@bill-the-cat>
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat> <87ecvhzhyx.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iRa5QLM+uCb9nJIp"
Content-Disposition: inline
In-Reply-To: <87ecvhzhyx.fsf@prevas.dk>
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


--iRa5QLM+uCb9nJIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 08:23:02AM +0200, Rasmus Villemoes wrote:
> On Thu, May 22 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:
> >
> >> While looking through list.h, I saw that the regular list_* helpers
> >> (and one of the hlist_* ones) still contain the prefetch() that was
> >> removed in linux 14 years ago. It doesn't do anything, but makes the
> >> macros harder to read, so get rid of it, and the fallback, no-op
> >> definition that they relied on. That requires removing a few uses
> >> outside list.h as well.
> >>=20
> >
> > Unfortunately this leads to build problems on lots of platforms:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1141951
>=20
> Hi Tom
>=20
> Now that the 'remove volatile from gd' series is in -next, could you see
> how these cleanups would fare on top of that?

Yes, I'll give it another spin right now.

--=20
Tom

--iRa5QLM+uCb9nJIp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhSx+YACgkQFHw5/5Y0
tyzw3wv/Vnl6xm7PMmlkxDOM297eEB0Le9n5b6NjuZtzEvu0JP4AWbn7e8ZB0MCc
nc9kcA1zjPhIlpW0H2vVUxXmejzIM3Ndl9C+h4ab9AkpovY7/7EiBcM71qiQ4Shr
h3hPOda8NCnm+zHXYzTcTeu+syfiyuv255dOtP+HyvXTyt6h2rpPJITWt9bLiHhy
T/CfRP9cYuLjBk1Abxbu4IiVKLAVPg1IEv9Xk94P8fHKnTkkawClJHw8DmM8f3Mn
HQVTI2jnCmOys/hMcbYu+H7enTUkGrpSfU5RBFKieouC6yN7IBdXI5kpIgezv2II
40ZvjzRU7xv5SH1rQSpDim/4DAieM0WpIPpJgVzeVDbdjCUTjWUPAzKzikqWuAHu
wxDKIxuXJxgYLhjGnjzVcOewhZyYN+DCy0Itf6rTKvMpFWgWVvVBIYWqHVcG/kBH
Gz9401HJgRHjqXNhT3pUGbaHHcrNbaEPWsND98xcsKRDpD5DnFpBHFF35RnVSIqL
qPP5EKa1
=f9Rm
-----END PGP SIGNATURE-----

--iRa5QLM+uCb9nJIp--
