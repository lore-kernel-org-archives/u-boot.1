Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AB3C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491EB87871;
	Fri, 22 Dec 2023 13:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fFpE9m8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D81D87860; Fri, 22 Dec 2023 13:31:40 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE9287860
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4277e7146abso11458371cf.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703248297; x=1703853097; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ToVeUAR/l2UC0dYfqQN8EkFukE+eoI1Sttpbwph256o=;
 b=fFpE9m8+Wf8I1GxVaCLFf8maX7lIMI3boihOR9RyOdRwGCp4aMJhTOapg13oYtmxPB
 sgiT19kJeD8+Wf8dO+rfvB4xmAJeSxiPvyQvj/Iq27W3cWFvU/cHnPIlEiBzmscFC04g
 VN6HhXy9YiBYWRX68qa6QcETKmuNmJpCcqnu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703248297; x=1703853097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToVeUAR/l2UC0dYfqQN8EkFukE+eoI1Sttpbwph256o=;
 b=vara6w8H+ktsq5AMXtPIB14OiZV+oV23QWme0HnqTGCc9VHqVD/5DXbykSHDYMU9iv
 HEQAXjK/upjHZzW+w1M3N8Ug85epZht18yRSydtgKvIZXi90emkEpqdEjD1FzeNMjLk5
 Zk3YZS4m8ju89g/UxX0uz0LkVEqhu2l9eQB5s8lKsAVCbbcrayOuCrR3AHfaPJ9ajzJM
 kbn0TOYSX+g1wW8p0oegHFvXR8bXJAtwnB3gFajvPdyrm9yrtPVdiTI/+BR01LKiLjzR
 SypQgjw+RffANBZjw7KmSsdb9WJjpHB26WuLo/Bi9vj2jmTou0jMvkiossaZo+i+2nj3
 5T5g==
X-Gm-Message-State: AOJu0YyqXBGRZMzXM+uUyPjAs2No3zm/xcLI7TMTEaN1B7sv6GuMg7rO
 aXZevhK2agau2tUrnUScfFGBw/eBhTP1Ww==
X-Google-Smtp-Source: AGHT+IGfbx/swNA5LJhtXtKicr57p67KrrRYVQhFtbtdau1fwlCNtU8fHeXI8H+6BvU6aiai3/VwRw==
X-Received: by 2002:ac8:5b89:0:b0:427:8c57:59a1 with SMTP id
 a9-20020ac85b89000000b004278c5759a1mr1509618qta.14.1703248296745; 
 Fri, 22 Dec 2023 04:31:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 dq15-20020a05622a520f00b00423de58d3d8sm1780476qtb.40.2023.12.22.04.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:31:36 -0800 (PST)
Date: Fri, 22 Dec 2023 07:31:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231222123133.GX2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-8-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5gO15gW3QgaL+Dmn"
Content-Disposition: inline
In-Reply-To: <20231222061208.3009970-8-sumit.garg@linaro.org>
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


--5gO15gW3QgaL+Dmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:42:07AM +0530, Sumit Garg wrote:

> Although there were still some variations in board DTS files based on
> meson-gxbb SoC but I think those were minor differences from upstream
> and shouldn't impact boot on these devices.
>=20
> So switch to upstream DT via mirroring amlogic/ directory from
> devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> building DTB from there including *-u-boot.dtsi files from
> arch/$(ARCH)/dts/ directory.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  configs/nanopi-k2_defconfig           | 3 ++-
>  configs/odroid-c2_defconfig           | 3 ++-
>  configs/p200_defconfig                | 3 ++-
>  configs/p201_defconfig                | 3 ++-
>  configs/videostrong-kii-pro_defconfig | 3 ++-
>  configs/wetek-hub_defconfig           | 3 ++-
>  configs/wetek-play2_defconfig         | 3 ++-
>  dts/arch/arm64/Makefile               | 9 +++++++++
>  dts/arch/arm64/amlogic                | 1 +
>  9 files changed, 24 insertions(+), 7 deletions(-)
>  create mode 120000 dts/arch/arm64/amlogic

Do we need all of the Makefile portions of this? One of the things that
works today is that trees listed in ONFIG_DEFAULT_DEVICE_TREE (and a few
other variables) will be automatically built. We might just need the new
Makefiles to just have:
include $(srctree)/scripts/Makefile.dts
and then the trees a given config will need will be built.

--=20
Tom

--5gO15gW3QgaL+Dmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFgZ4ACgkQFHw5/5Y0
tyxl/Av9Hx04+tllsX47mC4M7jdeCWY0pWPvj1xuNtYoALwl8sZKdZ+5Et6gNtSu
pSw1tNc1MfLrJnjHG8xX9vQL/r9NPAO9hQDl0Ci3Thh5+2/MJUXSF7xJdZgMxoLC
DVRk/muMCHu3txciXjCsD5Uw7p8Ve4DZNkXRnlFeZCNw9+VnMaW3/8H0X0+M07jL
C8VcuxBnp05oZFAoTmhSHR52kahfJAdgjVzQqvIWSJOHc0AmuM2J9tMlEKafYhn6
4gXH9Fejl/eXuwVTdTKjoDy/TlHmvKx8kt/KAhR9vUX3f6WUypkobHQkt0G7ARlk
uHiTk5tAcLOnCKPe6xuUdlkDIiMwzMWY5rrOYuO8KziD4k57cIaZU9nRL2T/KuKF
Vp45pkOXnlFu/0UDBAZWQVsn3yfrcc7i5KEWb5SHWmSKB07sh59IcH08lx1XuBJw
aG44zCBWCErYQStKASZwz+YH1P3VVZvmIBdgXPIUgW8mQI+loImheYHj7FHL4Sez
VvAzbLh/
=ygeE
-----END PGP SIGNATURE-----

--5gO15gW3QgaL+Dmn--
