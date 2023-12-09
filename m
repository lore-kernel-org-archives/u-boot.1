Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E2DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DAB8761C;
	Sat,  9 Dec 2023 14:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQNreilS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAAE87620; Sat,  9 Dec 2023 14:45:55 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9527F8757F
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cdc0b3526eso22979077b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702129552; x=1702734352; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIbXlLx1WE6r6gCrII0MXABhRLUQKoRyQZ/hCp5geiI=;
 b=aQNreilSt0xcYuh2VCIKLRZiCXR/q8MEHCDXhRSOyvrreZd3hE+ZV5w03ju+tmvVem
 4pH9oO/4fJpO79305MUQ3PdIpfbJnbwsHSitrKt/nHuCmZE7C2zBejWxsHo0ab50pvd7
 DH3WA3QPRB0jlRejfDHXFVba2eH3KAxno76Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702129552; x=1702734352;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIbXlLx1WE6r6gCrII0MXABhRLUQKoRyQZ/hCp5geiI=;
 b=Hl218gyTHzWFg7+vA3j672q8yFHguVPKz8LeboXNxq1uRx1HrAHJxrdQUdp1pkbeG5
 wy43xNhnCXARpmfxvgsJg6jNfv+G/2ND54FU7RMl2x6ecWSmbeWRLq+w+Y3OOqyK9Hcm
 gFjqpcNgilJT5mobx1advtXuXaL4wM1M1Lirzt+rVLcTNYgHYWpZ6rQIy+nLvGqB2ri8
 Uu95o+rREI/tt4fTnok3mEWrx29XhmoBp6PmjVhxMllc8G9pOZvcy9DxAY1ixmk8CO/t
 FD271zUz+5yUSgUkEpujSdRlPgiWolFB0cv+/mhiVQP0FS5TbrwczYy9Ir3Iin4G3kAI
 m78g==
X-Gm-Message-State: AOJu0Yxc+aGEavmgh4n4Wa+P/TJNHU2t+SdgoyLl88j4kbF7eiTIZyve
 zt+TYLGMzVqYop25oJYZVm/Atg==
X-Google-Smtp-Source: AGHT+IFgBVdaV1Yr0DyTbTsLluNVQ89MI7j73PU+5txsNqcLc6j7tItZNJxoRdBhmqlHcSMZztPnJQ==
X-Received: by 2002:a0d:f346:0:b0:5d3:d489:ccb2 with SMTP id
 c67-20020a0df346000000b005d3d489ccb2mr1629960ywf.24.1702129552265; 
 Sat, 09 Dec 2023 05:45:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a81dd07000000b005d755416307sm1449504ywn.73.2023.12.09.05.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 05:45:51 -0800 (PST)
Date: Sat, 9 Dec 2023 08:45:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/7] riscv: qemu: copy ACPI tables from QEMU
Message-ID: <20231209134549.GC2513409@bill-the-cat>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-6-heinrich.schuchardt@canonical.com>
 <CAPnjgZ0jM5QiTTn7f88daZpO2qmR2fh8WMqDO=faRdfJ6kFcCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7P7Q2v0ExRW9T6sj"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0jM5QiTTn7f88daZpO2qmR2fh8WMqDO=faRdfJ6kFcCw@mail.gmail.com>
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


--7P7Q2v0ExRW9T6sj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 11:23:19AM -0700, Simon Glass wrote:
> On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > If CONFIG_GENERATE_ACPI_TABLES=3Dy, read the ACPI tables provided by QE=
MU
> > and make them available to U-Boot.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         no change
> > ---
> >  board/emulation/qemu-riscv/qemu-riscv.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Can we not use common code to do this? What is different about ARM and x8=
6?

This is why I was trying to convince people we need a symbol that means
"handle ACPI tables for QEMU targets" as yes, this code too should be in
that common area I bet.

--=20
Tom

--7P7Q2v0ExRW9T6sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0b40ACgkQFHw5/5Y0
tyzBQgv7BuThI1h8zes333ZRRAYJtApw8f637feoFKVHSm/4lbPMR5zWEM8ZrE/v
OTxAumkLq97GMpjc+FDA/sEtBMDyl4w3uHwYCdl1D7gFM4XJrL07O3WTsk3Hu4Ny
bLyjWfTDBj7iXaAbxOQX8HHvkdPhA/UecjDAY3f3GnGDTpjF/4sa+UoOZf9TH/GA
Ib73MpIaAokVo/2ITRW5zDRNFoKw+QfnFAtH7/ZfmkwXLol6DXcz0Dpcya7PpFRQ
yBiaW5GKqwZwG+CmYi++lBR2yiPmj72A91oxS1e5scgpMx0eAiwSprdXIKfIbuVc
hGQ0TfWKq6xaNc0F4LCevt84CixynPMJE0lUbddmKMvYdP+oIuu4S+orWTm92GN6
d3krF8VTbOgwL/38Dp1kDU6ydDm+wBk05tBjB00K5Spnbq5Q1YWekmL3GWUPRw09
EkmsD4b+V59sUaXoUibDPUrO37B/D1EvQEx1DnZTSugtGuxNnkTIQxOhwEfhZJ1T
OsHity5U
=m69W
-----END PGP SIGNATURE-----

--7P7Q2v0ExRW9T6sj--
