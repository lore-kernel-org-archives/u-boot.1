Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884D6C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DEB84B0E;
	Thu,  9 Jul 2026 03:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OLGpg/ZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 904A884994; Thu,  9 Jul 2026 03:53:13 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E989484B1A
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9fa42f08cso1000006a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561990; x=1784166790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2mGl8zcV51PwXRVi0yiULuKcq2xTY2hl4q3Y6qPc+0M=;
 b=OLGpg/ZX3YjCf9TjVsfSa3epQqyV5srNN07I2A5KmT+k64DPW9nj5G81raWvjU9huT
 xH3zWqDJVsHtjtuZUYw9o3czVB2oVXcw4aeML8g+StdV8/q1wDQi+LPjXoNvwla2n5aq
 KFRcumQtrl/x56Q2qd7aCTmRu+R+4ArDiBZXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561990; x=1784166790;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2mGl8zcV51PwXRVi0yiULuKcq2xTY2hl4q3Y6qPc+0M=;
 b=D7WwuzLTy7tKynUZaDC1K3fLWQrhkLHCnyk09lURX9lFJYOrcn0NUOq1ova84d0dsa
 A9bRTeHtgB7L3dWLDWiFNT1KrEPt2Uz4DzYjZCvAT0uAfluyTVlV5ZFfrTHxSzobATIy
 MJFDzL+GUleuvf0VFnuXJMjzo9VIvcPCp4Rtcs9pxdZLfGvXKkm+rSuVycrRPLZMQv9i
 adnVqaoOG+SDxP3iKgd8qOvuafU3MK9/Ex88FTKJNWfDpfAuRx1P+01lWshA4ayHuCP2
 yc6Y2SdoiUq4J7ZmKufM1E4o+tEV4I4UPjGbR7nLnLGceNo8EKodz+GwLSCuNUooc8dP
 IAsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Z7UwHLNzqqp1e9Ld21E3YdcQ9zwINNpdCgBx80cKomPQMdflWeHsneTdjcfhmdfMiS+H2tf0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxo/xDNgbxoKB4bBo3sPmA+K1Wd2oYR2EPAKmR/65bwvEbr2T9
 Wo7VNFtwgBYcqWKmuDDV9tPSQzahxrOb/7h+UY2xD80hrvb6c6bb4CdOYMpdg9WThD1AUhCbFP4
 tzDUyai4=
X-Gm-Gg: AfdE7ckHCk4qTe8h5OtEcHgMBomgBE0W82V/yaVaikB4yr9fAluZ6c089XXgNw4VJiH
 f97eJRhOUqxw+DXiQd/LSMRR/y/fGUvwL7XbQbq3pOIu3YHOJ7VhsP+X5Qw9xtgRvLz3MKRHMGH
 i0M4qGbPhP6j8Lx4o0hhFn9oePU9pKQc5K6L/BdeY0So3A1fl8kos5j5Be1VuN9qa7GWd6JWCuZ
 R/x/GdWp3+KFf8AC3Xs0xjyC1vIe+vjgVApaWO50mgQWh0oGyvo+ijo47cGMdoUCezdQhD6rtcT
 tk5tHmoVc6+HEkyOb35E2FuHxHPoZrg4cr4dWvNJODutojRge6NKK9LNE9WhT1DUQjQtM/2Ir9i
 ELg62krtvL6q0EUDNjWX5vj+atx/UQe1lYv9wHQAj8OtAx1lo48Ftgsc1O77R+LCn8uLi1WABs+
 Y5XivVqbNseOblKmsQeF/7nBmqbWa0z2Or7WJLHJYRSZQG0EOJavD3fW4dV0sYer6iUQgpLIvUD
 sZRRZrcbhdYMpuRMvfZcxwwtmYV2YN7fH9idw==
X-Received: by 2002:a05:6830:650c:b0:7e9:f8e8:d905 with SMTP id
 46e09a7af769-7ebcff78647mr3881837a34.16.1783561989702; 
 Wed, 08 Jul 2026 18:53:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2630casm3311005a34.18.2026.07.08.18.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:53:09 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:53:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Stefan Bosch <stefan_b@posteo.net>, u-boot@lists.denx.de
Subject: Re: [PATCH 10/11] console: Use CONFIG_IS_ENABLED() for
 SILENT_CONSOLE checks
Message-ID: <20260709015307.GU749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-11-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gsvrWMMTjsFVQSfC"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-11-jonas@kwiboo.se>
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


--gsvrWMMTjsFVQSfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:36PM +0000, Jonas Karlman wrote:

> The xPL_SILENT_CONSOLE Kconfig symbols are not fully respected for xPL
> builds, instead common code is guarded by a mix of SILENT_CONSOLE and
> xPL_SILENT_CONSOLE symbols.
>=20
> Change to consistently use CONFIG_IS_ENABLED(SILENT_CONSOLE) to make the
> common code properly guarded by the intended Kconfig symbol.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gsvrWMMTjsFVQSfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7/AgAKCRAr4qD1Cr/k
CgeaAP9kfIl3FQmC3FZpnKqqoDgdig9ZhCMoVQJ0/zrSil1Q9AD9EemDJitSDu/E
yup/J3tnmtfaftxga/k17Cvk55y/eQM=
=lMjO
-----END PGP SIGNATURE-----

--gsvrWMMTjsFVQSfC--
