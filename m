Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F0C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFAAF8768E;
	Wed, 22 Nov 2023 21:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GX+Otx8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4254F87631; Wed, 22 Nov 2023 21:50:37 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E881F876B2
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cd1bbc0413so1691717b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686233; x=1701291033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mbIyBzPl6v1j9P5MYZF2hg/RhE7tnHKGRGUp6aPdfBc=;
 b=GX+Otx8i8fczZwpdCcb2vhwN62xgjdBn5W/OrFVDmOGw8RWe/XEyzIVA4OUDxevGZo
 4/xi7XWxP+HjvvTmUMgKME2dd7wnpb0UKi8xrUskSw0GZxQdN/ozgt0wToK6nQebxSwE
 jjheX7UMhpD/TisoNfL/bohYwjeDA9V/3eEeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686233; x=1701291033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbIyBzPl6v1j9P5MYZF2hg/RhE7tnHKGRGUp6aPdfBc=;
 b=Rz8n2SSF7ComTKkB3hlyTJfHjV3O0c2HVgpm2yKa3D7E6zErA4SMge4DkOF29117E4
 G+HceG/1BCShgZmpWCkFQzy7tJ1h+9SbU6N2SNY2H1rRhT62t2A1Cb9/y0kIwLYJwPLa
 4D56tPy4ztKdVdKBymN32/0LzQK7yj1e+feVdWSV36hLZf66t5nhxACw5aOXz1nBsLlk
 TRHEWR6c5FKY8KZtQLXJLJj5lMwLN0QiomMhba6dVM1AxUjTVU4RCYHsQdI76A5xyX4f
 m9BjNj4XvH3mukLC0jixtb4c+om4w2QUs+NPO8nBpqPU0QkBjmzCSRJMELWF8zJi3csq
 DPGw==
X-Gm-Message-State: AOJu0YwcWyY8cTE54KnUbPKlKzW+43JN1UH50BnsZcE277crrI3q3u06
 R4Lt8Hju/6LQ4yXpgA7YsJMPtSKqXqox8sR4glcFmg==
X-Google-Smtp-Source: AGHT+IGh8r+Qm90+E+bpSndTzi/5kGUR8DlaKHJNSbkgR9H/LIrooG3lIdE2Lwcf+rlfP6YbYRQNpg==
X-Received: by 2002:a0d:d5d3:0:b0:5a8:1727:cab4 with SMTP id
 x202-20020a0dd5d3000000b005a81727cab4mr3517751ywd.5.1700686233706; 
 Wed, 22 Nov 2023 12:50:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 g65-20020a815244000000b005cb331f463esm93361ywb.8.2023.11.22.12.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:33 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-am68*: Sync with kernel v6.7-rc1
Message-ID: <20231122205031.GP2513409@bill-the-cat>
References: <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-0-d9a8cfbf1be7@ti.com>
 <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-2-d9a8cfbf1be7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nubC1hjbOat9oylr"
Content-Disposition: inline
In-Reply-To: <20231117-b4-upstream-j721s2-dt-sync-6-7-rc1-v1-2-d9a8cfbf1be7@ti.com>
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


--nubC1hjbOat9oylr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 10:32:57AM +0530, Manorit Chawdhry wrote:

> Sync devicetree with kernel v6.7-rc1
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--nubC1hjbOat9oylr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaZcACgkQFHw5/5Y0
tyybCAwAq7JOaIPKzMlig6BoGv2pMu4HTR/725UM7q7He4aJm2pnfMB6KSKHKkzV
P9k4c/2APY8WsVE4aKXOqPkk1axaYf+k7gWoBv5k5OgaIZfBHAkHqOsz5q4sfXFU
eQKNKNKZyZgdsxLo/YgUmlhcNt0f2/lS5KAq5lUHEpMz61v8PPtr89aL+HV3+pw8
7UvGgAHSiQG3Ev0JaDSRuJ6H8b5+s0vRkZ+oYdLieKB47vITkkPOcviTlnQRzC9j
/J6T8pmWr7DTIyXMDZkB7CcnPMaMSpnheUMxX0jkMek5cUZ83RwxKnI8MBisGM2T
9/zdPAF/8MHj6rDd+6/riAZ2UVqxLMBcHi2hMQ459EqdmCdPBZh0VXM4rnaBL4up
n9c+DvVG1lI6pNmhUkIL4Dqvubu+e1SHzaykhxIxU3vytL80Ylxoi+c3iZJWiIOZ
aRQR5V+cltmjiny5TAQCIc2AJGF5WTG7hmKnz39Egal0LL/naPFbVkGauQY5h0mi
CvIwvA+I
=oEVl
-----END PGP SIGNATURE-----

--nubC1hjbOat9oylr--
