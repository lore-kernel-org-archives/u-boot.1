Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A2BC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4C68769C;
	Wed, 22 Nov 2023 21:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ctPUnIpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F03B8768E; Wed, 22 Nov 2023 21:50:28 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BAC8769C
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cc7966e731so1993667b3.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686224; x=1701291024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D6Q4TQPKCqkbDvp39fMbG1iVfkzeir8U6pda2pBkt2A=;
 b=ctPUnIpJZKN3McFdexpvAfq+H0jP1W7RJ+/VMwjYSmCoi50uQ/qTQjvGsMiRmrKjGN
 Ot3ig6dKcbmx1V+rWt1MFMc7QOdUiUcKoXWxehffMOGJD161+78InXU9hx2BPIQrmFo+
 BabjJmKzXnDCD7zehIXoGtECpd5f3O17umWwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686224; x=1701291024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6Q4TQPKCqkbDvp39fMbG1iVfkzeir8U6pda2pBkt2A=;
 b=ZidWs1lkd5oDHZqrEvuiTBDVqS66rdy5GaASHFiiQtnOCGlB5Ys+2QrUqEeq8TOPSO
 rQv4reYbRI8rzcs69LeZmXOR+3CE5ZJX355bDvQBJCKPdaNnuSsGJ19fj2TJ5ZSA4qbo
 DKspJsD/bxfQx4Rgr6mS1h1NXFE4IKhXmFEL1dXM6xVnyRi5fbwc1UYiPyNK6G6INqKS
 VJRQCe64KbT3M6vpSi7qklfTEFAiTBMSYDuIgnvwNoieDUYROopAFEppATrK9bIQP7UY
 mH0WSDfJI9IlKF1xn9BQICAi2uuF6cKxhkjdtljFQERLGQY1NV37UHwIFkcEleKRIUd8
 L3cw==
X-Gm-Message-State: AOJu0YwDs07/HQIYgWgjtF4t7ufoYq+1mWr+IaKj2Ya4wOOGjg7jMZ34
 wTu+OsBo4OPe0SO2DZmdmbxLiQ==
X-Google-Smtp-Source: AGHT+IH5fJgZPgbyqeLangWYjfC5ywsH7lKfmTzo49wN9AJU2z3669Crx11lk6LVEKRjQGVoPV/xyw==
X-Received: by 2002:a0d:ee42:0:b0:5ca:e142:289f with SMTP id
 x63-20020a0dee42000000b005cae142289fmr3476645ywe.28.1700686224187; 
 Wed, 22 Nov 2023 12:50:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 k204-20020a816fd5000000b00582b239674esm85294ywc.129.2023.11.22.12.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:23 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 vigneshr@ti.com, nm@ti.com, u-kumar1@ti.com, kamlesh@ti.com,
 m-chawdhry@ti.com, afd@ti.com, mkorpershoek@baylibre.com
Subject: Re: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
Message-ID: <20231122205021.GN2513409@bill-the-cat>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1psz13d5q7LUprAW"
Content-Disposition: inline
In-Reply-To: <20231115101024.3441093-3-n-francis@ti.com>
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


--1psz13d5q7LUprAW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 03:40:24PM +0530, Neha Malcom Francis wrote:

> Reduce redundancy in code by using templates to generate the A72 boot
> binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
> (for legacy boot following devices J721E and AM65x).
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--1psz13d5q7LUprAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaY0ACgkQFHw5/5Y0
tyzzZwwAgyKSedAz2cHNrGZSMlpm7Fh2JqtntbWc2y+TOsfbQb5ysLL159ifIMAa
D2NOAOO+3i8yDVlUVzu9oyY2rAGwPDeTgBqM9Jend5K7xzoHwQ/4burhh2JrjHD/
3A5uzf5JuvqMZYTnmixiu/L7ym8dqzRRKTbOSEx9Bbc4aXCJQU2gRHTKz0yiikPF
1swuGlvajv2Sk0/OuSYSsjKDCFKIiynvdxeSga414lA85msl1zNMvZnQYcTLnM+8
T66QuH/9bS5qDMGRG2fi0AgPJ0kIbUkkRZz5fBohpUEv1IxVcICbtjjaQxH2GcSJ
jSD0KHKZpdclpXBHxRc+Cx3W24d51JkOUI6lIAgMF62By7okVVBPPf3cs/GnhQF6
6J5p4tLSDYGmL4lQWYvq0Y46QlBWim+K88nALbpoBcpFk2VDV4z/nFWZMxrQ5UJv
Rx+NcdnrgFLirMhmjARYYttvrQF/ctGqP5sqEvdM53h1a5rjGLfsDfKyAX39UjIg
6BY0MQwq
=fMZm
-----END PGP SIGNATURE-----

--1psz13d5q7LUprAW--
