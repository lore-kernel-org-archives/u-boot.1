Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EF5C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 14:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4F3810EB;
	Sat, 26 Apr 2025 16:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLDaPjRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8512810EB; Sat, 26 Apr 2025 16:14:30 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 346C580FDA
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 16:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c16e658f4so2234624a34.1
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745676867; x=1746281667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L/Rljue20D6GVGaFn9P4jYozbuID7uxGqj95oz0zaLQ=;
 b=TLDaPjRPu/YoEPN2LqmD5sUW3fA/pT2qXrrAjb/rEsCODDwQKmlsRsGiCPUX+PDKuD
 C+OFFLhD6oyWZTQTskrvtLtPOqEoUGSaFgWdI631OYqDN2Q52LkqSAG5xTwljfKTSJmj
 7/LdmJYmpKHBULKaixM85SdtgWG2DiQvf/2Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745676867; x=1746281667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/Rljue20D6GVGaFn9P4jYozbuID7uxGqj95oz0zaLQ=;
 b=LE3JOkLhZZZXs0pKCbCHZ8ec5uUaJwT2p/tOrGuFcXAZ8ocEvaf6+G/vNx0x0V6QSX
 D1vv5KxYfkzgaR4vrsmu+IT1LGsoGmX/VzqnHbY2yK2wiL6vzDtI1Bpdpg9bs/uTZj+8
 6PGJMQSutuLllY6q+D3LvAf15HGOBM+y9TteN42jW1Dh9aL5SiJYtHkzHqFnlBiJLrw1
 NdGdCPsWuFBRsBZjpi8Uk5jHwf8BPiY58wsI+Ph0jXYKmp498ec5K3DhuCH8+P6V7DSz
 sBV6kYd4JLavGOLW6zxAlKlKOQXYNudzdWV5RVOXouTytbcnF3EFZ6f7zbtrF37RM00G
 rMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9UOZwB6iTtMyhpf+iwVJ2vt+0ZFNq6PUUuSjitNi1iCK+EJEzF0mJjDyiZ9+mCeedYtj8jr0=@lists.denx.de
X-Gm-Message-State: AOJu0YznQK+FWtci2B9sYGYPeufsOrIVOMD8iv7tGl7Z1s0FCAIc3HHP
 1Kd0w11OWxEIUe1uAViESOZL4dYbqDaJQKp8bxkrwivV+yAifpbuh4cjX1EOJlQ=
X-Gm-Gg: ASbGnctGYuuELY4JuKt6ONu7IxZEEkz9g6EkSHVZdvXFGyQcpG4wdndhi1RO9sDXLyn
 ov7eYDKGQPwh4pS4OqMwRHFszbAUCii4p3ygYCkclXvPc0xDR3SzLOt+MZS1Lwx8IfpHpQ49iVL
 INLHEz4rTup8pmfmEe9aSmoQBd0kyp8SY19PnxgSXlm8KdMDKGroJ7XobEOyxM0qdJMIDq52iSx
 jloTinSxrizevgfSpFhxEeMIXMBHNJbqguweCDs9JaUfGl2TxK47wY7iTrjCC90hvwphdYLlW+4
 VgsWAio2Ao5zPnFXpU+3sa13/PM+okXDQJJAWe6kWAiHrP5LtESRnl/qVH6h54zkvkISfz7gbZu
 5jw==
X-Google-Smtp-Source: AGHT+IERrQ6Pe8BwBk4MMKSQOY5aVeK71ypQxH0Mopzbg9iXuLtreP5uWelcnb18X8jcx496Mr6A0g==
X-Received: by 2002:a05:6830:3c8e:b0:72b:9993:11a5 with SMTP id
 46e09a7af769-7305c7b0e63mr4050582a34.9.1745676866826; 
 Sat, 26 Apr 2025 07:14:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f19fb76sm1073921a34.16.2025.04.26.07.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Apr 2025 07:14:26 -0700 (PDT)
Date: Sat, 26 Apr 2025 08:14:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250426141424.GX5495@bill-the-cat>
References: <aAte-nS8ZhO_Odw1@swlinux02>
 <aAtlctz9Gx6-Vzuv@pie.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qGKOWb2y7oA/Z6Sa"
Content-Disposition: inline
In-Reply-To: <aAtlctz9Gx6-Vzuv@pie.lan>
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


--qGKOWb2y7oA/Z6Sa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:35:30AM +0000, Yao Zi wrote:
> Hi Leo,
>=20
> On Fri, Apr 25, 2025 at 06:07:54PM +0800, Leo Liang wrote:
> > Hi Tom,
> >=20
> > The following changes since commit 10f48365112b164bee6564033ab682747efc=
b483:
> >=20
> >   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:=
46:17 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
> >=20
> > for you to fetch changes up to 5ac699efe94f24df561d33e420d3c73f5fb797e8:
> >=20
> >   board: starfive: visionfive2: Order board detection logic to match co=
nfig (2025-04-25 17:04:09 +0800)
> >=20
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-bo=
ot-riscv/-/pipelines/25940
> > ----------------------------------------------------------------
> > - riscv: lib: Simplify FDT retrieving process
> > - board: k1: pinctrl: Add pinctrl support for bananapi-f3
> > - binman: riscv: Fix binman_sym functionality
> > - board: starfive: visionfive2: Reorder board detection logic
> > - board: starfive: Add DeepComputing FML13V01 support
> > ----------------------------------------------------------------
> > E Shattow (2):
> >       doc: board: starfive: visionfive2: add missing format command to =
Flashing
> >       board: starfive: visionfive2: Order board detection logic to matc=
h config
> >=20
> > Heinrich Schuchardt (9):
> >       configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
> >       configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
> >       riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
> >       board: starfive: DeepComputing FML13V01 fdt selection
> >       board: starfive: spl: support DeepComputing FML13V01
> >       doc: add DeepComputing FML13V01 documentation
> >       doc: starfive: use consistent formatting
> >       doc: starfive: use jh7110_common.rst
> >       doc: jh7110: describe debug UART
> >=20
> > Huan Zhou (2):
> >       riscv: dts: k1: add pinctrl property in dts.
> >       config: Enable pinctrl in bananapi-f3
> >=20
> > Minda Chen (1):
> >       MAINTAINERS: visionfive2: Add match N: starfive pattern
> >=20
> > Yao Zi (7):
> >       riscv: lib: Add a default implementation of board_fdt_blob_setup
> >       board: qemu: riscv: Remove duplicated board_fdt_blob_setup
> >       board: starfive: Remove duplicated board_fdt_blob_setup
> >       board: sifive: Remove dead board_fdt_blob_setup
> >       riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry for proper =
U-Boot
>=20
> There's still an unresolved comment for this patch[1], which doesn't
> affect the functionality but makes the code cleaner. Should I send
> v3 of the series? Or alternatvely I could clean the filename property
> up with a separate patch, which may reduce your work. I'm fine with both
> ways.

Please follow-up with a cleanup, thanks.

--=20
Tom

--qGKOWb2y7oA/Z6Sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgM6jwACgkQFHw5/5Y0
tywG9gv9Ecb4UCFd/Qs9HVg/f0cPwrZPWcuOwPd0H3eTbSXs+bukXpn2oBjkmtHV
4CCay6W/P+2Vvi+uHGnLdJizbCKkPhNsIMQ2LokBKyR8YsWcPoUWMucdCwnVCjl4
AxNIliOlmJIAumzIBBWuN7B7i8uvNOfB2AHde16t++8WfPP7fAuqlXXCOOo34Lrj
Hf412oCN+rmiSNxmb9SogpIsa5HZvKhE/53aalojb15L4jPhds96fzTUD/3UscXq
d4/aeuJI8yZTT0+D1EW86xQIysG3PZvA21ftTb84HVTPD213k3Kbe6WyXpo4CH8J
kmMPXDLWWwfVemwDRPAwkkVazPmH7UC2akgSHYWKG5vC4O1hcu3Rk3P6s/lVTW4R
64rbAcMrdznVdaJeU+REyrpCVwI56FJID286+0GQSvHDFUUkTQJN2V/NrZ95xL5K
z9cB5RHrJahYvflmiuN9fryxVi5YlrfGeN1g6vigGsj2d0neRCJjQ+Db0ea8iF/s
QN64xLjJ
=lP4y
-----END PGP SIGNATURE-----

--qGKOWb2y7oA/Z6Sa--
