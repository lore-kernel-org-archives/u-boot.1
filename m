Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223BEC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5976A87D73;
	Tue, 23 Jan 2024 18:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gz+RJcsm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30DD87BBC; Tue, 23 Jan 2024 18:58:52 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85B4687DA1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ffcb478512so19841847b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706032729; x=1706637529; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3z5iXHQaRsOpt3nxVnJSwFMI8Dep99DGwU2xMfYZJ10=;
 b=Gz+RJcsmwnVXpXaqzmKhU36M6reaj3OmeZZmtaLjwydYdtzMCLQmsxwg/wm7P+0trt
 c3VatSn2/U2R/oKbfMYOKDbzNE0TDqT5igJmBqVDisWNd4Lf6HwERrLEuUlcbm1NUW6n
 2cDK3SzxYRTRNRNr+NYXgGPH0SxmFIVjssnY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706032729; x=1706637529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3z5iXHQaRsOpt3nxVnJSwFMI8Dep99DGwU2xMfYZJ10=;
 b=T5ab4zsOl3JJqTuJ0+C6SKhg7YlODw2Y1qvWydVl699ckrJCbnwnOlTCAEji/o7jZb
 EvpiaMpKX81TzCqJ3DIXYmPAEO0FdoyZIANIfp+az/Iaq62Wyq8SP4rA0SrLbspNt6dL
 9g4yl6pUM9l9N8oPpuSCEHgN41znJmGNi+5CnyPZnQL+yIEr4m7WBo634NoGhv3DSwKk
 67VEepYD81CpTEznWLYJncx+EzSlooZC2hQxK2pA+vpZhZGCLDO5HCn6kX0um64G5/M5
 JpoUvEBcz/0bxEL2nnT8LWfVcq+iE7U7ppD9BAtB38AHN7znn1wVHH3CFFCKISJzHomM
 MObw==
X-Gm-Message-State: AOJu0YwzdfE6r1xNcafSIMVBmKilN6O+eUO0oS3FYjugD4h8UrkvLGCc
 gx6yfxj7MlOxozRL+xkkbIt2TYRlOxpKVyTrWFyzJ0CioQ0OuGHa6QSpII/usRQxkdaLrqdSDmW
 K
X-Google-Smtp-Source: AGHT+IGGY6P4LTdaRjERYIBhcXDM4oKdAXzMd/ienAw3Jc+BBK5hJusVoFFH2tUnRBojIMdgt4PstQ==
X-Received: by 2002:a81:4785:0:b0:5ff:9dea:3777 with SMTP id
 u127-20020a814785000000b005ff9dea3777mr4811665ywa.13.1706032729223; 
 Tue, 23 Jan 2024 09:58:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 i142-20020a816d94000000b005ffa1fbfa7esm3111562ywc.101.2024.01.23.09.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:58:48 -0800 (PST)
Date: Tue, 23 Jan 2024 12:58:47 -0500
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/20] Convert CONFIG_SPL_STACK to Kconfig
Message-ID: <20240123175847.GT3652023@bill-the-cat>
References: <20220529165521.912054-1-trini@konsulko.com>
 <CAKUh=RyhSZKzh+ab6kq1ZLYqEonhbjikJcaDASqhbdo6kQ+-Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k5rYeUdgP7sO+RKm"
Content-Disposition: inline
In-Reply-To: <CAKUh=RyhSZKzh+ab6kq1ZLYqEonhbjikJcaDASqhbdo6kQ+-Lg@mail.gmail.com>
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


--k5rYeUdgP7sO+RKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 11:53:18AM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> rk3036 only has small size internal sram, so it can only use very
> simple SPL which only including dram init, and no SPL_FRAMEWORK
> support.
> In this convert, the CONFIG_SPL_STACK is lost for this SoC, any
> suggestions on this kind of issue?

Does this work?

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index e7b84fc1fa68..9deee0fdbea8 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -372,7 +372,8 @@ config SPL_SHARES_INIT_SP_ADDR
=20
 config SPL_STACK
 	hex "Initial stack pointer location"
-	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRAMEWORK
+	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && \
+		SPL_FRAMEWORK || ROCKCHIP_RK3036
 	depends on !SPL_SHARES_INIT_SP_ADDR
 	default 0x946bb8 if ARCH_MX7
 	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB

You will have to update the ROCKCHIP_RK3036 platforms otherwise the
build will hang now.

--=20
Tom

--k5rYeUdgP7sO+RKm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWv/lAACgkQFHw5/5Y0
tywx/gwAoPXIZiJjdTcqR6j1fYvzHr3xRb8JZrWSWAC3nLfJEdFqs/VyjsinBxL7
u/In3s01UqJxedf5aAq14J5Rg4NvhuDcPUXU2Zdao2mDqA+Mzjtxzo7wl9yryfrQ
URqKO6doJK3az8I7jGhGYDN7pDLf2K4SrV+sz8ibEWZ3PAJ4Ve694UEC4Uep+w5q
ns+Rr8xD/xSi+WVDp3MMJp339WD7W5hz6imCngCxayUm9D7Tnvt4sCuyLKAmKnGj
jmD2kQLeg2qz5mRiKLR7w+tPPLcUnIBG4KcNuDYdCSoM6eOcQ356Z6U3O5sxPYIg
as5rB08TxpvJ0odl1q+hRKf81CAY2zZUrQ/qV8Y+tO1kAY5gi9l31nT9ugWqo2Zn
GYF2EsHImIOC78ZzxXI/IVpkEKPRH6X4rdQHgYwaiQJwc1e2hlLuZRhK5tU9jv2R
MKsoksQ1G48CjHYv8D8VcnljLN612iu+K2IZkEcUFKZPRDJ8Uc8KyyDrqMuWk1WE
+86B2Ahh
=W7ss
-----END PGP SIGNATURE-----

--k5rYeUdgP7sO+RKm--
