Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C343C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 15:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDDCA84A52;
	Tue, 30 Jun 2026 17:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LbcBeDtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B769084AC8; Tue, 30 Jun 2026 17:30:47 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C8E84105
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 17:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9f6e7846bso410045a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782833444; x=1783438244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxDLGjVXXHNP9ABGgkwr3/h6ka9t2iFHfUss+9xxLV4=;
 b=LbcBeDtbKzl8HNRV+eVq/OwnqJLL4GuLEsFUizvfOAQj3rOTLtF/TIEBAsxRFNOGoe
 OnrL8Ulogfp5QZbtsq7oJl7mibaRuZJCtFzt4jtOJdj5nXaa/FMm+KsyGWFzeY+L756A
 Z+xJlB76jcEWAz+YK81TIWZB+FIbMjcX9+jU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833444; x=1783438244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxDLGjVXXHNP9ABGgkwr3/h6ka9t2iFHfUss+9xxLV4=;
 b=iUwik6OJBA0XAbllSAJYvqEvLmpPJxqJ5nYntbXrhKT/DFJsvy1lxqkGJx5uXKa1Zs
 UJ3gDkIVi886ZSZR6CoP1rzwMW/ni7UlHFtUMj78fBZbpMdVuJQ1EynUnSvqf62OpDI7
 L06ggkcnY6UHiMOvBXO5+gGL+kEnI0/ZHstNqRQEk3lWVGwoM5A/owyaXoe+s7/GLIWv
 ATIn12YSDYS5lo/3jyZaQxkfgLTbt4++wLx5pQK2L+e/gq9tkANQsM4MCkFgvaq5dwyg
 JF1FWBjVzyKs0IlPP7IJQDsQOv4WyfuCPIgcyND2RKTON99Ggu99TO08PqRNkxQT3l1k
 ODVQ==
X-Gm-Message-State: AOJu0Yz2IAso2rDj9CMBTnN7FrX6P4acdrHlAKPGbQNu6zb4fMMMER/5
 RgHdFz8irHdvD3vfHIphfuLxVDeR3EkhgxzKXD/9q3Hzgv3h5c60c3u0J5tfZSv0En9EnKXsmHS
 gXo2uGQo=
X-Gm-Gg: AfdE7cmyHCrDUicCqHdRPH77e0a0Z8vhuDdRXSBp0iQZfBNX/Oj2S1lSBcbPtIAp7wV
 2GdrpyT9M+Vl9Ntv4fIewPEmLtJDjXQQYMdJdGaOi2gWscZsxbhJc2jW3lWgcL070EiEW6evcfi
 VE3CTYG43NcFbUmtfZ3IO1V7tTKslkZUvlk90nizHJ1Rd3SyHQWuyQX+swvbtIv4uOZ4lBaJSF3
 iMp17H8/xgzz6yqopIkwPmUZ0MpGzjok4w3Fc5Q6382M4kYMb/4M5B2eHDwdntZY4Zw8UkEBx0U
 NrBo5VMQU7tnfD4ncpEvmE0kANQrorDia+fHHwHSk2jLo/3yZultAcLdynEyyJ8feTvwlKr03tc
 80LoZgvDjOhis9Uowi8Z/Td+z07frl7bRxrQ33OaZ8+BWZZRyiVbPlQkQcPKFV+k4ptsc+JPN+l
 S1h+Vis96cfz669WT3/qN89MESe49r/Rco6O4xGVTdyb7ocIySfy2Ng7WPYuSQjUnIQb2Qo8vhd
 MyxXGRyZiwNxsIbuIeLowee+QGJnqPBkvt/1nMq
X-Received: by 2002:a05:6830:6814:b0:7e6:e022:4b44 with SMTP id
 46e09a7af769-7e9ec6e04c8mr3276917a34.15.1782833444055; 
 Tue, 30 Jun 2026 08:30:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9ec307edesm2558519a34.21.2026.06.30.08.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:30:42 -0700 (PDT)
Date: Tue, 30 Jun 2026 09:30:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: Add entry for ARM
Message-ID: <20260630153040.GB749385@bill-the-cat>
References: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ib9j5GPm3241GKGS"
Content-Disposition: inline
In-Reply-To: <20260630144244.449753-1-ilias.apalodimas@linaro.org>
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


--Ib9j5GPm3241GKGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 05:42:42PM +0300, Ilias Apalodimas wrote:

> Since I've added various features in the arm architecture
> support and review most of the patches nowadays, add myself
> as a co-maintainer
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ib9j5GPm3241GKGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakPhHAAKCRAr4qD1Cr/k
Cr+pAP4/gK5c1yFVwt+/o4bDhSURRU+bNG6jrpU+834/u+cDUgD/dmJ19ziJnAjS
v0QepNsSFklUq/Yo+fuFGxfSDa9SBAo=
=pbxG
-----END PGP SIGNATURE-----

--Ib9j5GPm3241GKGS--
