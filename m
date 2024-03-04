Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5257D88054;
	Mon,  4 Mar 2024 16:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K5Ri179o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EA188055; Mon,  4 Mar 2024 16:28:24 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1AF8806A
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-788237c4536so35372485a.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566100; x=1710170900; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mbj7tERhXc7EubuE1+enWqbZFsRRwZpFE+5kgtOjC7U=;
 b=K5Ri179owhYtsuGm7UdifdTuMoLiCl5GoYOR3Y9FRqOLfdu8GMSEnJhg8ULn48hiJ8
 bryVYzzLcPGYv8mJEjoSRAQwL/CPqOgnpPOtdoiKUhm6xQKst3tV33YIekluIJ6+yURe
 jfB/mPUckNgnUZs9eOypORnJlV+HKHUkZ/OVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566100; x=1710170900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbj7tERhXc7EubuE1+enWqbZFsRRwZpFE+5kgtOjC7U=;
 b=kWylJiqpRyMjbC/Xi7VxCkBQO5LJJ8Q9vlChhoTcRsu4Ec4URYrEQzvN2FOHyHTA96
 j47IFxzGZDIJo6u0p9c2SJuixqn22GoSIfAS580wxLE8qdu9UPxpFYzmtweu19SUJdf3
 9C7hwmGg/dRLYyWd1GRBvbCtlD+6erNZMnxY0G3jJon4Go4WS2bm/YPRiZqZJbICd5v1
 9WI2grcn/rS6sAgacJKskGJ0jxcKmKNuv/GFxwhqMO6uYQcFJmiJaGG+xc10r7TCVKNK
 DX676Uu6VsAzwa2cV7UrUHrmXFKfovx+Zon84/reZHCPHRDIeeXXZ2uGLTaNXCh5t6Fh
 +5nA==
X-Gm-Message-State: AOJu0Yx5eDl7JGbSkmg3H9yei/GedCFbi/69cHPxeWwQZVjGx99jCH4u
 RPEeExxj2Ne8dXhUnehs5l8EkTyv4TjRZexeDqo9Lacfkb0pRkuPgRkHPVfnDC5SttTrUpnxv3+
 o
X-Google-Smtp-Source: AGHT+IHm4ZmxVGmdkgszJ37O6lSJC6UwWPMJrBsDM5dj/KhlprrwuQMabuTHQB7+Xn2J2vdQuqgXBA==
X-Received: by 2002:a05:620a:5e03:b0:788:5fd:bbd7 with SMTP id
 xz3-20020a05620a5e0300b0078805fdbbd7mr9844337qkn.14.1709566100193; 
 Mon, 04 Mar 2024 07:28:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 ea4-20020a05620a488400b007882df42fd1sm560707qkb.131.2024.03.04.07.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:19 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] fs: drop reiserfs
Message-ID: <20240304152818.GA1523872@bill-the-cat>
References: <20240218235940.987876-1-pbrobinson@gmail.com>
 <20240218235940.987876-3-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kDQEmVP8OsLec9f4"
Content-Disposition: inline
In-Reply-To: <20240218235940.987876-3-pbrobinson@gmail.com>
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


--kDQEmVP8OsLec9f4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 11:59:35PM +0000, Peter Robinson wrote:

> It was only included by a single board which doesn't appear to have
> ever used it for any default use cases so drop the filesystem now
> that isn't used by any in-tree configurations.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--kDQEmVP8OsLec9f4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6JIACgkQFHw5/5Y0
tyxa9gwAobqGPXBvMXvUNgH2o2E+PxHKAijUCT5kdR70XDeD9j4hPzfQZDldTaeH
LEEeZvyyQLActNTFO0BgGv8nIznVzyj/jXyIIUHsYlApTO4KdpO41+YLrHRrg9QG
DG8Ed/xAKt3vRR92zLUjPjfkccoJnxQz6dvsPYgLtDZPg3UULKtD+NW26V/8D6jp
6gWptI5Q1jccBiXvhYV7j+tBntaiKuQTl8D+e50vPFymNdPY6yMXgaXSAjmyluDF
AlwF6SBApnGkAjo1oY/vLnJnN0acuYT+52TJi4T7o2Pw/LrQSeEMTHa+e/FdE6rn
0qcPVs9RwDW3pGY789EsGtdQ4wD1KpvnS/g4N0tV0LODf6p0/QFRyW9Rk+kFTJXM
izyvJBxKLpsYgc7vrgVcWGhigK54c0qp0Ktb4RCN0ez8q0IdgzBaQXsHnVLDJ3Df
lYE+7uCtQU0nrFgMKEgSNo03h/TZGMFHzjqJDG5i11sYDm93MtbiJElZQW+TYOBS
IX2z0vfU
=O2gT
-----END PGP SIGNATURE-----

--kDQEmVP8OsLec9f4--
