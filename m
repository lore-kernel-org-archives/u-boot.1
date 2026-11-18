Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29960A2601
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pFfXUyvh;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pcolJ4fH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8B7360A8D;
	Wed, 18 Nov 2026 15:52:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GIXP1SJaEjb6; Wed, 18 Nov 2026 15:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19D5160A7B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795017145;
	b=BXPbs6Th1V7YG/GcaypnKvXHgEp3wY5u50PvfsPVz5ybSuVUOTpSEB+HOXFV+5DDpNs2
	 imVbIuUFyXRaboXKS7XLUP3a2wKh9whlH7N1xNU0BL1U0TU09Otaq3hJ+vnEU99i2H2OL
	 Jvpr3J5whOpXzrqkJCbpJkfkWwMNW7eg1fjIUZThaiasOFIgcykLFq0ljI8o9CDL/4BPb
	 WQkqeKBRPuzg7I2rZOFZaNqMMVsHG5ZkBZmzPYtouiUOXxJnjmVB6Iv8TEy195RuzZwLT
	 wH6k/nfkHUqFFvi9ELD95lBKdjGb9tjTPfj4giHm10HIVNl8PwMC7Pxqx6m0m7JM3IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795017145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tnhG+ARnNc9cPqsOHKzmsJEg7TlQcU2WXC/dFgN5fyU=;
	b=LVIL75l6OLa3oAAKU8Xe14cAcHAW3MvsGaLJyRy6oVpIFnlNll7iRa7dC0i42XRBbTCp
	 GrlyJbbl5GSUOawlE+1lz/RxaN4mfcs4sibLWz/TaJ4yamJFUVaROWqjSajUhT9aC4k+w
	 s9/Dub6DLdI6EAUULEaZPhNPWbOD9SX7uTm0NBySRaY+lw+d/iwPK/1sECSKrZGFLb3xE
	 +2krqHvMpg/s8FBCAN5vi/uftFMC9fsEYDNcVbjco6b3BCiYG+OrpPF9dS8xRFKEkwzVy
	 QH9YnTCAF7nRmbjCZL+PbzapoxGmRxl3BCpYPVI1h10YawZQqsnWGtWhOtjxDIMvaHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pcolJ4fH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795017145;
	bh=tnhG+ARnNc9cPqsOHKzmsJEg7TlQcU2WXC/dFgN5fyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pFfXUyvh6qII1kSOZoLJj+ieLX9mg3Vv5sXbS0klSDJxgIYYC3LxCN0VAbQkZc7G+
	 9IG7DfR1s56SCbXEgWamTY+wUW4RMCUM7z2YKAaNxaqj7b9s91zjolWA7zvxVzNwDe
	 TJtdXyg/fqIt0F8v7JAxU7b6DUqXZDhjjAAMc2Eg8PxDZ5VOJsZ6YJH2X8h4FlQiDx
	 DUFfjHe/qNQb+F8OvR6Dw6WJXcow+LaT/FQuF+Fg9F5SA45Pelbhzgyc2EXLRtGaMR
	 +WNuWPqxauHC7OuW1SXFweKXsnN2aitzjOmqzeFz6mPj60gg5jpBgX1SDEaqy8LMpH
	 SyYomwl6vTPpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19D5160A7B;
	Wed, 18 Nov 2026 15:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 88A5D977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 860F560A7B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGn0ieojwAUK for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA3CD60A67
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pcolJ4fH
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA3CD60A67
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:52:21 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b4c2da74c0so7724417b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795017141; x=1795621941;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tnhG+ARnNc9cPqsOHKzmsJEg7TlQcU2WXC/dFgN5fyU=;
 b=pcolJ4fH05VZVmh/zFY+VyWgYGgT9J2rrIlJQgKszMbBMkcyyRmlltYw1UHhXbpko9
 W+lJBeApOWdZverqd3y0pVYieszhx1p5OKSfEKy1CG0MtRpP0CxQpRMdF+mqvX2qYJbz
 ad2wqjTjM4HIgk6dbciEk348Nd49Af51I6kpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017141; x=1795621941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tnhG+ARnNc9cPqsOHKzmsJEg7TlQcU2WXC/dFgN5fyU=;
 b=Wb7xdf/9FEZ1zIRTqvvHceFiuXECtSFE+4QIE1ATrhhk2xSUflpWJE+r5qpr7dX9dF
 o4byHvP2izONjhM9SQPL2cWFPoczt9YE+XcodWQh0hu02I/o1NzL/6PSMPRs8n7L26kF
 3syshqqwmxs+w3bMd7npuE9dxqok65P4q8z83OMaz6tK/NaWnV5fBPXh9o6tkSZWFV8X
 dSba3cc8sTG2kVd+wso7i20G1//4lpdM/oq7PGzv/7abF+iC/HCQxrhntXT7cQChjuRj
 qSGhs1k4rw3oGJ2gRnSsmuYcZZ1JFyPVBIUF5dRSwV6REVz0sHPLARlZ/qwl/BT4rIwV
 I5CA==
X-Gm-Message-State: APuU4Z8y1BYx3rDMQLeRJaTrJylUHOOPqYC0ObJrDnW+pYTt/KIc/u7u
 U4cKXGSczDEHko37AYB3o2x5jP0B72t9R0owy4OAV/mfFPETuph/55LscUeXb0SD54ruvDqMh6b
 gO0RQDrUg2Q==
X-Gm-Gg: AZFdTZe8nApkZi9NZhf/2WIV26guSn4ZdTubFmd0HgXNCKNLqcuL10xJEgJW1YrcxOu
 mNqZ/TH41qO7P2OQA6xw/GcKoCiGNSsrkjtHJNC7BPU0Htgm3ry7enVlt/E+nwY6B2kBNxg+W5j
 vXmacjgtwr+4H89P41nwFrkdF99Lebxwn9ENzTvmBaq14GO3gikEYbBDCcHE5nTPJ7v/XpzWIgH
 w6evmPtOKoF75QDu+KS9foLa0+QilKA6lJzl+tc+Xw4djrusE79VXNWFZjFGYm/i5UT889QtexG
 02NyH0yYgH114ORtsBSOacVahh1AXe1AzHnIjSM4UEkD2M8K74S9WxhD57uSpEf0lNusiLh3pWQ
 5WBMvITjVENV7/NrLR8iz6PBiQHbmkB8y+m/dp/Q8MbkSKT9jntKsbt07/cYW4J/0zj7TzvovRi
 aU4GUS5d2Dvbvr7MgQKOpmyhJ+I4GyKHAPfFWNkCZCA42pavM56yiMBO5uP0R/+zwA/r5ggy6SF
 cCx9lSYEvcvAjgvKF0Vhyb9a0p5Hg5KzTFY0bP2wpEsr3HUSSsBARgizWN47WLC2RPpcSMaHilW
 r8aMt4wQ5L/jrOxNfdbokA5qVSUT2074DYr3D0OnlbbZ+OPD0yd9rVFFmwTsaEiChuLztI4tsV3
 yKCIOw/0qSushTsqegW4MbnywCUK8c1ZWrHnGVhc5290PPDaNKls7HtCYTxUcp5phswlHUIUV/p
 XoJ83p/DiSVxVqpTaRKDNOE45SjrtIFdthlrIQiKFuZdRy6iMAch+T
X-Received: by 2002:a05:690c:93:b0:8b4:c993:f01d with SMTP id
 00721157ae682-8b4fed83828mr10104357b3.53.1795017140918; 
 Wed, 18 Nov 2026 07:52:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4fe09f434sm19935247b3.25.2026.11.18.07.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:52:20 -0800 (PST)
Date: Wed, 18 Nov 2026 09:52:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: Remove spring board
Message-ID: <20261118155218.GX554944@bill-the-cat>
References: <20261113172043.1235725-1-trini@konsulko.com>
 <ee124480-6356-474c-92ca-6f27de77be7f@gmail.com>
 <c8a86b05-8b77-45a3-b729-69a4b7ba7034@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8UNmdSZ0+kber9qv"
Content-Disposition: inline
In-Reply-To: <c8a86b05-8b77-45a3-b729-69a4b7ba7034@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--8UNmdSZ0+kber9qv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 03:16:55PM +0100, Quentin Schulz wrote:
> Hi,
>=20
> On 11/18/26 2:45 PM, Alper Nebi Yasak wrote:
> > Hi,
> >=20
> > On 2026-11-13 20:20 +03:00, Tom Rini wrote:
> > > This board no longer has an active maintainer. Furthermore, as it see=
ms
> > > unlikely there are active users of this platform, remove it now inste=
ad
> > > of waiting.
> > >=20
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > If someone would like to pick this up instead, that's fine.
> > >=20
> > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> >=20
> > Can we postpone removing this for a while? I recently managed to get one
> > of these (HP Chromebook 11 G1) in non-working condition, though I don't
> > know how broken it is, it might just need a re-flashing if I'm lucky.
> >=20
>=20
> I think we only need someone to take over maintainership, mainly because
> unmaintained boards are not allowed in our CI. So, edit the SPRING BOARD
> entry in board/samsung/smdk5250/MAINTAINERS to replace Simon with yoursel=
f,
> send a patch and I think that's good enough for us.

Yes, that would be great. Thanks!

--=20
Tom

--8UNmdSZ0+kber9qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav3JqgAKCRAr4qD1Cr/k
Co8uAQCCXrJJ3TJRatpFOIOKxGjZ9YdRWtpX04zOOiWD0yj60gEA5xGvjBgRgpCN
Sce2S8EWQHCNZLy8mYDr7bAgizUUnAA=
=u7rr
-----END PGP SIGNATURE-----

--8UNmdSZ0+kber9qv--
