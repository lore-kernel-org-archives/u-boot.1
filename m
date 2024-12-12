Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F10E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF2880209;
	Thu, 12 Dec 2024 20:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oar0LBn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC3D80200; Thu, 12 Dec 2024 20:18:16 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A85B801F5
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d888c38841so7961656d6.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734031092; x=1734635892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+2+u9Er6vhxp3tPS6fQM4g3xDexL+dbR+ztoTd2raGo=;
 b=oar0LBn475SSLqAsuBnkzEW5CF1Uqh90NDNkK4t9C+qSdJgJtol1S0/on75l0GtksP
 zfF7aN1jhIihs1e8MFUioCOOt95xkNO3r42vONKet1febUCoO9d5y0zLEsLk/4KGglZn
 Hkm9FNpCwnccbsovhyQtHtlTFrcYDY662wuHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031092; x=1734635892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2+u9Er6vhxp3tPS6fQM4g3xDexL+dbR+ztoTd2raGo=;
 b=Wz5GP+VJ46A22GTIdvilI7nOBQGKbfqQTeIDdVpwq5ntwqEfPF3SnJj7WHhrJ89siw
 XV7edA3LX4ir374O9/wZtoPQptADxlFHdPO9tv+K/TmqE5LDJaCoeC/UGj/6pBdOnThV
 hU87SVqhNkOEgjaCEAdqXQ/nMSQ0La8Qh8dT2OL1PXHjeY6HGvOD1dV4WCFm+TTTE3OM
 VUs0IEaoGhcp+3/tHJNrLOBfQiMYyjAbqLBiy+yka+CrbH1erltyw3U/X3Ul2e85jMi2
 s/KZo8chJsAIw8/wltMNccytn1xsKMHdf+Vo3+wjHLwZYjc8rQLGLd7z1QvmOKQ/ZyGE
 omIQ==
X-Gm-Message-State: AOJu0Yyo7d9cI6Fx5AMW9eqhQpqHqrJtIbwRAk1Za7dMZ0BGIH0cqTkC
 +x79Ab7P1Wt5y9ET9in6kF/4iY3S669zZeEpbE9R8SvO6lj3Lc5/sqsOHkQUirI=
X-Gm-Gg: ASbGnctE/AQGvEfF0t3LvknAVkl1L+6KPO61MIys+p27wuxzy/OpvD7zTVA7WL8VfCF
 FLg5Kp59sWpkqap9HvhvTCs4r5SdJVWC6AuD/wHJQeFETHZLR1UfchwmXCTE9GOLxCqciTtaKcN
 K3SqzU36wpUYZ4mtxpod/TrGbBLYwnyqrlosnYm4h2McpX7SV904QlhcYTcHFIsRXgyD74ufifB
 CyRQNqOVcEEcs6PUs8UZ7WzXz0wiy8J3NGzp63DgbJ/LE9guE3ReZW6
X-Google-Smtp-Source: AGHT+IFYHtRvhDT5alNYb6zVHO1XXoc5AoFRn29nJuMk1fjkJyYRjGyuGDzifAAImCadQWGJRYbe0Q==
X-Received: by 2002:ad4:5d47:0:b0:6d8:a1fe:72a2 with SMTP id
 6a1803df08f44-6db0f87272amr26999046d6.44.1734031092491; 
 Thu, 12 Dec 2024 11:18:12 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da696e7csm84651546d6.47.2024.12.12.11.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 11:18:11 -0800 (PST)
Date: Thu, 12 Dec 2024 13:18:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx: Fix for v2025.01-rc5
Message-ID: <20241212191809.GI1505244@bill-the-cat>
References: <09e7bc07-46a9-41f4-914b-7855485ee090@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dvE6GFmJQ2PYbjBH"
Content-Disposition: inline
In-Reply-To: <09e7bc07-46a9-41f4-914b-7855485ee090@amd.com>
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


--dvE6GFmJQ2PYbjBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 03:42:31PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull this one patch to your tree. It is fixing issue on Kria SOM w=
hen
> SPL flow is used. Display port driver is touching IP registers but none is
> getting IP out of reset. That's why adding support for reset fixing it.
>=20
> And the commit 1a48b0be93d48f9ec5498297ec775fb572d3d150 "lmb: prohibit
> allocations above ram_top even from same bank"
>=20
> introduced regression on SOM
> ERROR: reserving fdt memory region failed (addr=3D7ff00000 size=3D100000 =
flags=3D2)
>=20
> but this series is fixing it.
> https://lore.kernel.org/all/20241211021703.2333-1-semen.protsenko@linaro.=
org/
> That's why would be good to get it to v2025.01 release.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c0=
02:
>=20
>   Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.01-rc5
>=20
> for you to fetch changes up to 8b81010a2fe385524b58bea9116f1b6954c3d2bd:
>=20
>   video: zynqmp: Add support for reset (2024-12-11 12:40:13 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dvE6GFmJQ2PYbjBH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbNu0ACgkQFHw5/5Y0
tywKrQwAtpkEEheaB2cqOm1Fgqa5kLPlw1bJ+xz5hYQQxfRk5rd+7aS/9UXIaa1p
rDfOA2sUj7XGlO7+s7atgQiF4arN8pV08ZKhSM2thvID2ZiH7yErtnFC+VLoArma
fm+2WMF7ej9asR2RRZPh5gt/DbPwuLLCCSibcuhtVzUvKCqLyKmNs9DJgxRKON+k
EaWzhegdR88GpSqNoemMZsncScomqtLsMENh5CPKVpGtGAZk1V+Y98FxN/OxjnsU
D/mD5nMq0H/4A87Hoc0quwCQWVVpae66Zn4fgR5FPiHwgJXls0zv87mLo3vH6YW2
jpDOOFTvZ2m6hwyryODqc/vuZDos95y0/khD/FVTlKbCKo8vv+GzZVTp+kx5drdx
GuiLYaoWywGQSMfdpLkoLKr4iHi2ZryZVUHiuYmZqeVBshbRAxnK/A5mzQ7JFRSL
03xWGRekL9/jxOpw5kWPIS7Pds+C+Ul7dXztycG0fmZv0X5ciTNJcT0DL8DQkkGm
9uXK5ezA
=Vc2y
-----END PGP SIGNATURE-----

--dvE6GFmJQ2PYbjBH--
