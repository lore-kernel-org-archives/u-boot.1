Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF7FC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537C487D2C;
	Thu,  1 Feb 2024 16:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K2eURtLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C1387D2E; Thu,  1 Feb 2024 16:40:38 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3014787D28
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-60412866c36so11039597b3.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 07:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706802030; x=1707406830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YNw890gxb9kXi4rPSmoGmWihix1Joig+wcclFPInVE8=;
 b=K2eURtLyKbIdrFmdHTeZ1QMR5R5/5vhYiSoHIsezk8LuvoRAEdgbxJPvfbqoDdISOs
 rpfAiKSRbc8rBC4jKutFGhqbwqSiHbqnbrEIoieuosih2b08J/XgfCyZMS/YgLHtMjTL
 oYOK1LJ3wIJMt+0f2Y6HzFqLvnhgvFi9lUVYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706802030; x=1707406830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNw890gxb9kXi4rPSmoGmWihix1Joig+wcclFPInVE8=;
 b=kSa3RxtMbHBZEx9g1f5bHDj/FlXWcBlDWyXUFzH/tAsg3jftoKjhEg6uSm7YQYNueg
 p2qVnfbaaBEaMoN+W590deqKURYyfc5PGgGKrVGy5dNVGvIiCi4Mh8g7nKBCwLKMB9+A
 BAdpHf7IRV1prO5Y4zKLAJjBy30X6uOz0NZEahG4rZmbTans3HBhzXAj5WDazqVt5Eia
 3SM1f/7rpdHv7vF9vAXfGK2V6AUrP3Mzqyo/3p2etT5qdeHatkzdsIw9e7eEcLm/tD81
 Qwed13fQISKcJyFiMyG97HynRBFHp/T79bsLBbR48ISYjwDigNSRrQag5kFEkAU6Clg+
 y75w==
X-Gm-Message-State: AOJu0Yz/1UiQvUDO5Gr5e9FIsitEWEga9lNdAcae6r1v/XqTy9RmKHr3
 DbXnhuqi5tWj1M18mMUyx7RtPNmCSrB1ujraIReDA6okhZt1t7+EEs6z/TKRCeM=
X-Google-Smtp-Source: AGHT+IF0omimRnhYaGp1TsHMYvg28skx4iWPzqZnU8U+wYPB32Bb2ccB2xbTPu/616YVW7tust0IRg==
X-Received: by 2002:a05:690c:f85:b0:602:da5e:816b with SMTP id
 df5-20020a05690c0f8500b00602da5e816bmr5670561ywb.32.1706802029926; 
 Thu, 01 Feb 2024 07:40:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXqDwM6QPaMQl5hB8aOuRB24FsKK/VQh4Pe4nvcYlXbXUOoZoRDpp3/48VVLgjVeLCXmB7Rd/EuOUACrjcQgnwbhM5Wmg==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 r65-20020a0de844000000b005ff928d6effsm1220780ywe.33.2024.02.01.07.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 07:40:29 -0800 (PST)
Date: Thu, 1 Feb 2024 10:40:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-fixes-20240201
Message-ID: <20240201154027.GZ1152441@bill-the-cat>
References: <bb777d08-1723-44b3-ac69-e55af1218cf2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8miLPwCrpQqFuRmv"
Content-Disposition: inline
In-Reply-To: <bb777d08-1723-44b3-ac69-e55af1218cf2@linaro.org>
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


--8miLPwCrpQqFuRmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 03:26:25PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this simple fix avoiding printing the board model twice.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 6faba41927bdc8973b59678649ef83c564cc42=
1e:
>=20
>   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240201
>=20
> for you to fetch changes up to 076529725f16f07a5cb2d5feba25d62b5f5a5872:
>=20
>   ARM: meson: stop printing board model after sysinfo update (2024-01-30 =
09:35:51 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--8miLPwCrpQqFuRmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW7u2sACgkQFHw5/5Y0
tyx7wgv/QMYRnG6TRzhT2PEW5Koi5/X/ONwrQSLr6Of330f0ctEhexK80X1igpn9
xADy3WzWNCO5LMAdw6cb6UUHo12Nd9w1Lx0GUhOYd+hWSvtgldF+qan+BMGnJ2GM
e2IegeE6a08oBLB8tFehlnAXM4XNSxobmIHsdj+p6mzSyQ9wtn466yfbZSRlBwbC
U2HE/ZSnykyNI9ab1nT4vcDzwX/An2IdYoAyfhPPvdGY93Th/TwdmhWSkb01JybY
xrnBCBQlxWFGNoT0wWDtL64tUIiFSekGStrqypQfx83M3JmFheicpCfTEaVJr2+A
z22z/eDQGwKUZ8vuyu7OHLx0iU2PhMzEBQelZ6gMC3G7pdOmw1srBumTTeEoWfhz
CdvipZhNRV+eQnZqIkl5V6SL6t939Cb8SRixmYEQ6kPLQwuPLmup5lu+6vqIwZaV
+rZBtX0BfpwN2NR1D6LrBH8d5vDLPAdmmokPvVcyaU4ksyLwIU3Qf2iWKtNjdaVn
+xz0c91h
=9urQ
-----END PGP SIGNATURE-----

--8miLPwCrpQqFuRmv--
