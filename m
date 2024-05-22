Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD513C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7711884C7;
	Thu, 23 May 2024 01:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/qx8SLp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72A1884C9; Thu, 23 May 2024 01:07:07 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F16F88489
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f0e190e5adso1884245a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716419224; x=1717024024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Qcun1mElGdv7doJ/qFLraDo34EO/xDuPTSEgQBCihU=;
 b=f/qx8SLp7x2BcjZloBx2jEIE2ATB4LNcU7GGOOUnwPj3W7AZqxEu2vg1CXYGo4eD2K
 qJ3FkJ7rgWXQ2fHnzUzjDn62tmxdnwZZFo+3NZrxMLBh75F6+rAqigqqPg7XggjH8vCy
 FoPiqSjtg2mRIJtuzb4Te47WLzCXMtgIIfVGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716419224; x=1717024024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Qcun1mElGdv7doJ/qFLraDo34EO/xDuPTSEgQBCihU=;
 b=kea2MC7dB449VTJpEGG9eWdHagh7T56g+7cu+uHbzvLg9sjUKFH8Cz8UzhxwUsESyT
 L5T4kunldvoWvxKa/V94qE6jeEXDjx4EXzppN5VZd4BJAS9ukVwqsoR9L0aaMOH6poB+
 NypcBZ5fkcg2Nuy5fg2uIWbsnWtrW7d8DC7KUAVoL7l1REBwLaJ5wSo+5rhWGFvzhzfU
 +hJPcLXJ8phF2F3ffdw0U3Rfb4xaZIMz7O+VEsfhCyw85MyFnVcDoReZq5JIpwK/Az0y
 E0dfoKUnQf/0qSy07wEEF+ENttfXM21HDdEZ4PgSlNbGr564v0sVPZHCs56nno4I9M1E
 sAGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnjhMsGbysd8f/ue0OmL5ACBeuyioMPJihfvQaazhWMTNEpYVWJbR7otWNzfQBaYLjirzLohmqSE85YudQ6zFXHszN2A==
X-Gm-Message-State: AOJu0Yw1X6IoBc/cAuryEjbVbek8l4x6drqaFu4TktC/Y43eBjutafTn
 Kirg+WwrWyfpGqQO6R/z7v4ufM7X7LRoeYTUXGd6d1jAiQiYH32zXWltUc7yfYQ=
X-Google-Smtp-Source: AGHT+IFcL2ga+WQH6AkQE4zC3vDhY1uec1RJqyFrgbSbgEVM4BrOoET6ADBb7xfG6jeWoi103+dMBQ==
X-Received: by 2002:a9d:69d1:0:b0:6f0:5195:f34b with SMTP id
 46e09a7af769-6f666aa3f16mr3807761a34.19.1716419224129; 
 Wed, 22 May 2024 16:07:04 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-793003beff1sm765987985a.95.2024.05.22.16.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:07:03 -0700 (PDT)
Date: Wed, 22 May 2024 17:06:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Jayesh Choudhary <j-choudhary@ti.com>, u-boot@lists.denx.de,
 u-kumar1@ti.com, a-bhatia1@ti.com, nm@ti.com, n-francis@ti.com,
 joao.goncalves@toradex.com, j-humphreys@ti.com, d.haller@phytec.de,
 hnagalla@ti.com, bb@ti.com, seanga2@gmail.com, sjg@chromium.org,
 clamor95@gmail.com, martyn.welch@collabora.com, m-chawdhry@ti.com,
 a-limaye@ti.com
Subject: Re: [PATCH 1/7] arm: mach-k3: am62a_qos: Move common bit MACROS to
 k3_qos header file
Message-ID: <20240522230659.GK2568172@bill-the-cat>
References: <20240522113726.302908-1-j-choudhary@ti.com>
 <20240522113726.302908-2-j-choudhary@ti.com>
 <d444e122-59d2-44eb-9dde-fb8ec373920e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9l8Xj23Lvn8lvDMy"
Content-Disposition: inline
In-Reply-To: <d444e122-59d2-44eb-9dde-fb8ec373920e@ti.com>
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


--9l8Xj23Lvn8lvDMy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:21:28AM -0500, Andrew Davis wrote:
> On 5/22/24 6:37 AM, Jayesh Choudhary wrote:
> > QoS bit mapping are common across all K3 SoCs so move those defines
> > to common header file (k3_qos.h).
> > This ensures that we do not define these for each SoC.
> >=20
> > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > ---
> >   arch/arm/mach-k3/include/mach/k3-qos.h | 74 ++++++++++++++++++++++++++
> >   arch/arm/mach-k3/r5/am62ax/am62a_qos.h | 74 --------------------------
> >   2 files changed, 74 insertions(+), 74 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-k3/include/mach/k3-qos.h b/arch/arm/mach-k3/=
include/mach/k3-qos.h
> > index e00e1de5b9..6ed5704803 100644
> > --- a/arch/arm/mach-k3/include/mach/k3-qos.h
> > +++ b/arch/arm/mach-k3/include/mach/k3-qos.h
> > @@ -9,6 +9,80 @@
> >   #include <linux/kernel.h>
> > +#define QOS_0	(0 << 0)
> > +#define QOS_1	(1 << 0)
> > +#define QOS_2	(2 << 0)
> > +#define QOS_3	(3 << 0)
> > +#define QOS_4	(4 << 0)
> > +#define QOS_5	(5 << 0)
> > +#define QOS_6	(6 << 0)
> > +#define QOS_7	(7 << 0)
> > +
> > +#define ORDERID_0	(0 << 4)
> > +#define ORDERID_1	(1 << 4)
> > +#define ORDERID_2	(2 << 4)
> > +#define ORDERID_3	(3 << 4)
> > +#define ORDERID_4	(4 << 4)
> > +#define ORDERID_5	(5 << 4)
> > +#define ORDERID_6	(6 << 4)
> > +#define ORDERID_7	(7 << 4)
> > +#define ORDERID_8	(8 << 4)
> > +#define ORDERID_9	(9 << 4)
> > +#define ORDERID_10	(10 << 4)
> > +#define ORDERID_11	(11 << 4)
> > +#define ORDERID_12	(12 << 4)
> > +#define ORDERID_13	(13 << 4)
> > +#define ORDERID_14	(14 << 4)
> > +#define ORDERID_15	(15 << 4)
> > +
> > +#define ASEL_0	(0 << 8)
> > +#define ASEL_1	(1 << 8)
> > +#define ASEL_2	(2 << 8)
> > +#define ASEL_3	(3 << 8)
> > +#define ASEL_4	(4 << 8)
> > +#define ASEL_5	(5 << 8)
> > +#define ASEL_6	(6 << 8)
> > +#define ASEL_7	(7 << 8)
> > +#define ASEL_8	(8 << 8)
> > +#define ASEL_9	(9 << 8)
> > +#define ASEL_10	(10 << 8)
> > +#define ASEL_11	(11 << 8)
> > +#define ASEL_12	(12 << 8)
> > +#define ASEL_13	(13 << 8)
> > +#define ASEL_14	(14 << 8)
> > +#define ASEL_15	(15 << 8)
> > +
> > +#define EPRIORITY_0	(0 << 12)
> > +#define EPRIORITY_1	(1 << 12)
> > +#define EPRIORITY_2	(2 << 12)
> > +#define EPRIORITY_3	(3 << 12)
> > +#define EPRIORITY_4	(4 << 12)
> > +#define EPRIORITY_5	(5 << 12)
> > +#define EPRIORITY_6	(6 << 12)
> > +#define EPRIORITY_7	(7 << 12)
> > +
> > +#define VIRTID_0	(0 << 16)
> > +#define VIRTID_1	(1 << 16)
> > +#define VIRTID_2	(2 << 16)
> > +#define VIRTID_3	(3 << 16)
> > +#define VIRTID_4	(4 << 16)
> > +#define VIRTID_5	(5 << 16)
> > +#define VIRTID_6	(6 << 16)
> > +#define VIRTID_7	(7 << 16)
> > +#define VIRTID_8	(8 << 16)
> > +#define VIRTID_9	(9 << 16)
> > +#define VIRTID_10	(10 << 16)
> > +#define VIRTID_11	(11 << 16)
> > +#define VIRTID_12	(12 << 16)
> > +#define VIRTID_13	(13 << 16)
> > +#define VIRTID_14	(14 << 16)
> > +#define VIRTID_15	(15 << 16)
>=20
>=20
> This all seem like it could be made into some macro, something like
>=20
> #define K3_QOS(qos, orderid, asel, epriority, virtid, atype) \
> 	(qos     << 0 | \
> 	 orderid << 4 | \
> 	 asel    << 8 | \
> etc..
>=20
> Then use that instead of raw values. That might also make it more clear
> we are setting the other values to 0 when we are setting these registers:
>=20
> .val =3D K3_QOS(0, 15, 0, 0, 0, 3),

This sounds good to me too and to be clear, move in one patch, clean up
macro follow-up patch in this series.

--=20
Tom

--9l8Xj23Lvn8lvDMy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZOeokACgkQFHw5/5Y0
tyy5mgwAjJ4SA57p+ldJMXz5YzKcnMt2HLVdx5JThiUEn9ZNOeFk+AsaNaBgp6P0
Qab2uHA/SMimZlQsgqnhRcsAelixcKcF5LCxFFcQ+tzL9tb379eGPIdRh9aHTIS8
wIHOuslTls6z6Ldbqjh7bNubZzzd4dqc0yWVANqVKGHmQGtSwGItCX5N5yJnlKjc
mnBB1o2ahF5Wsnuu/b3SiIENxM9Q4z07pKpFDFNGcwbXcigemCS/rgwdjrpsA3dw
EOefF+NpslqQPUE3/KGrBPsmmfVSMpocs5oJe9iPmwI9ge6l16dFQoe9y29BHGAK
xtODLzYavYzM7kHFUYExXfXHA+HB3TiaG6J5b5XQiJLDN8hiuO4uJvKvKqTTDYlM
odgjs8VS5agNd2tVBsJvIG0U2XmK2yYFHmyUUNRqXeGL/kMfNXv7/tsSlgKj6hjW
O2I2QXW9HNOkylediqarU3zhV83x269KFImmg8LAXpRsOsTbVs1OJXAQ1vhPsXtE
bfUcbpiH
=bi8e
-----END PGP SIGNATURE-----

--9l8Xj23Lvn8lvDMy--
