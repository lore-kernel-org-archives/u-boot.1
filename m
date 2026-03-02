Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEFEA4E2F
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D4283F2A;
	Mon,  2 Mar 2026 17:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n9uL8A2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D97683F2D; Mon,  2 Mar 2026 17:03:38 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6D683F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so2030374eaf.2
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772467414; x=1773072214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ucT4feQz6fyd2SucYaNhANmjwT1prO/vX1SN/ePreJs=;
 b=n9uL8A2RwtRKTz6W52MpeYilvwYW+x99k+XRJovfFN3I43UoITkJ7QHi5K8vX4KQ/V
 yidlwaOz4dnbPR06um5O4ebnlEutbdtx0q5INJ1fdlZQ8UUA8CkTV9mdxb3EH0ig6tnp
 oCKa2xetwAvhOQsgl09rty+8UqaAHfN20dKFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467414; x=1773072214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucT4feQz6fyd2SucYaNhANmjwT1prO/vX1SN/ePreJs=;
 b=LcolhzjhdgmHOGy22bNW9AVKk6+kPcnOL56VSNEvPJALz66J/E+EYQvM1ihNbc97mT
 khxzOvPHLvZijFWRpvpeUs3XGNH9cGBWAEaP12lN6VuWxbpZdTcjriWsnVQxICJkYx2Y
 /DkVCMyLNHrqN1bNMFhWjhLGhY1vbLv0XJYnh16eBVXXvXY9KZmBQLUqIXmxK69pASZN
 ikMrPTDsvS2NR1lfqcGBdsO+z30WwTQ/x5qHp/R/qBuG6uo8uV8S9gDQWBiLV/BmlHSa
 OMol/QuipqWXEaEjJNM4qnJ5oEXSOQque8z4RY8Vs0NLqTQH+wa5SE8CLbOegICdhtu/
 n3kQ==
X-Gm-Message-State: AOJu0Yza5YJEBTwN+sLdnPqEy1F8W1MLuwjvNcOuSFxXdY4/yT+CBEdT
 BMl2tSQ7pXCL+nW3JvGc4+7p8lpMRZjwcwjk+GbRpAD4LGgjJqRofZBDRO5aLk8c1ds=
X-Gm-Gg: ATEYQzy3TtubfyjxYq225HdMGioIdQOLAj47OQS/anr+2EIkgLf+EsubexJrbXMByRP
 J2BocjV8YMpE++dbojknHrD+dxC2oc7OAYIslQ404wegl2EZmd+G7CsWrovPXjMueYq8YeNDNOy
 FozSxHgX4ac8vX2e9+ydMz2SmTYyhjRWzNLYoVw5WPEX+m7ql8Q9oRvDf6eY4oWlWGCa5vc5t00
 LIJRn+DNJx63keKUIfjdHARpxNEY77cNVRbBdUkD1NzVQfcY5SbaBmUjDJA7bUy7oljGEoa02d6
 7NNAIDYdaSOe3u4K24VwOTFZQ/CSBhCieFWRspXSNG3LciVAmg0kvGfqhqHqo6vivM7boq2nHkD
 c+4nQRinm0pKZTC8/BSxc6MNc68NiW6iqa+nOmQUmqucxOkl5uXel/3NmFgO0KdAy5EzSCQCwnA
 1oFO8M7jS0+X4K322C2b5xGeYpzE2Ymxml+OeoyjvIwy150f138cOknFvHHBdl7bqHcaTqPie0i
 c6+t9ill+57nefEIhg812y7TQjl8+p95DKo9ifOHzz4G4O2swE=
X-Received: by 2002:a05:6820:e03:b0:67a:2e3:2236 with SMTP id
 006d021491bc7-67a02e33328mr3502365eaf.23.1772467414316; 
 Mon, 02 Mar 2026 08:03:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2db737bsm9501582eaf.15.2026.03.02.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:03:33 -0800 (PST)
Date: Mon, 2 Mar 2026 10:03:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/7] test: fs_helper: Allow passing the image filename
Message-ID: <20260302160331.GC1388590@bill-the-cat>
References: <20260228182304.3728735-1-sjg@chromium.org>
 <20260228182304.3728735-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/WlWSufVpOssNuI+"
Content-Disposition: inline
In-Reply-To: <20260228182304.3728735-2-sjg@chromium.org>
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


--/WlWSufVpOssNuI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 11:22:41AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The mk_fs() function always generates its own image filename from the
> prefix and fs_type. Some callers need to specify a custom leaf name
> while still keeping the image under the persistent-data directory.
>=20
> Add an fs_img parameter that accepts a leaf filename. When provided,
> it is joined with persistent_data_dir instead of the default name.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/WlWSufVpOssNuI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaW00AAKCRAr4qD1Cr/k
ClV+AQC6MAbGxqPaMCX/LTaB39xTcVHP7HK0WsrMuwgqT0aatAD/ZJBA9ggLz/eP
GkJ5NqzpUOF2hq+12c2y4E2Avb/tKgM=
=WfzL
-----END PGP SIGNATURE-----

--/WlWSufVpOssNuI+--
