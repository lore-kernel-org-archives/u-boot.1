Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FF5EEE266
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 21:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D2A8901A;
	Thu, 12 Sep 2024 23:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="pIr+IExI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0BC89045; Thu, 12 Sep 2024 23:10:31 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C7689006
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 23:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1726175398; x=1726780198; i=marcel@ziswiler.com;
 bh=m+HVRFutUWmdw7UpiJEeM+WcsOroCFxnab1PTm6vlyU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=pIr+IExI5Nn5WM4r5w4qOYTI0QefQD14x+3Pe3f6+V07XKzkgKOtGoDyuiaQ/HKA
 5sPUq13QR+ZNRrfvH9BtgXKv8L97MFg4Y3WWipcs5zf9yfl/RLTgmnmpxkm3zVKTZ
 0DmxmFULJqDSTr+EPdu3QaWcbJ6JFfJ5UmeQTDza8HP5IzfdZ5GZOW3VelJk8TVZj
 dkXbrehHSHpk+XWM9bFmTrZE+fLKIlb+SeQhPr5yo1ZVuG1ijEFhuiNHlu+jjX8p/
 t7bbsErPu+F9dGYYNcjtYmftsgzhV0ip7RG3OdDfQ92ZK30PgWRwUBNM1do0F5T1H
 2YNBPyd0dG6JWeFNlw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.123] ([84.227.224.111]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MguWM-1sbZQ61MKe-00SmLg; 
 Thu, 12 Sep 2024 23:09:58 +0200
Message-ID: <f27d9e29cc87e046f81191b238a6f576a81f84fd.camel@ziswiler.com>
Subject: Re: [PATCH v2 0/2] riscv: spacemit: bananapi_f3: add support for
 Banana Pi F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?ISO-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel
 Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu
 Chien Peter Lin <peterlin@andestech.com>
Date: Thu, 12 Sep 2024 23:09:49 +0200
In-Reply-To: <20240718043329.1500-1-seashell11234455@gmail.com>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:pSFVX1CqltxDtEYNzPEio7qMyVVMj1HSlXX3gwntypvSKlwhDef
 f4QpuA6gV5ZOtWEnTHDGKtlcGvolbPaShgYt7Z3BVkg3hZL00wkDQSXMYGRvVmkWQmRGrb/
 k6qrEpK9WiTY7ZVwpxfstsYW/ogePeu+/GQByA/qr7YIA1kizVgkfJgrR9KCOOFnr1/TN7Q
 fI+wEpw22r1w4YCyB3APQ==
UI-OutboundReport: notjunk:1;M01:P0:ombjpRyQOtA=;LHFdBpNk271LcqgXcaDFRNxZO3U
 iYFw52b9e+1iwXibqyyxZeHzYku3sLtWivbJKEFmR7rIlHCgxWX5Y96TfrLKGtC5z5qaQtnRI
 6NK08AAgr72fSFHRoVEjsQ/5f3kwE+MGg1fIsxSOwzWA2n9Mej4gfMjKA8KImr8AUsfKLSEOC
 +MuN2wp+fuZ4dLS7ghXt2zHEce0V6UllCTemf30KtYB4A533Af6XxSwiXPrfcbfbe90uKfZuq
 cYHiuL+N66JbcCKUvpI55GNFpty8WcullTdyA3fHH4Tik3MucH4BqXXPKEa8He6keHQdOTlQT
 Eg9pOdivUfSuOeLoo25AUWc+R8CENrHtWY9srQ/JIr05tamyfV9t8M/pJqDVh5+sNhJYbm44u
 zjpRbd+Mq8bzq85JWQMd8ozYVUu7hRq4tUWheF7+rqq921anP3R3RpiCuLaarpU2IG2uwmefY
 txVeftcc8q45Ky1AmZwl6JT6cTPM4HfrnWdIipajJGwy/ejwi2E37ldwoKdoeDuyz8gcYf/I3
 HjD924keCNhhb5OZN2qJ4Qt8vhzknyTyuF2jOMNjW/6hhK6CfXmESdmLOBRkklFUHEWCg1yA8
 QoVy5gteobdd9nRkG7woBn8Oyu51UO5vzukV/YGsjiczNsIKRKszbpUCSuYwBCO+6iiOWHydy
 VslbOgjZqOY3MJr6pUcHH1Qjq7mk9p7qb5C4DbwSL5eB19YpE1cht0WIe3L3nJbqA9TIx8XJh
 5YrPUdBCoZPeZ3XxVjZ16v0ZzlNoJjbbg==
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

On Thu, 2024-07-18 at 12:33 +0800, Kongyang Liu wrote:
> Banana Pi F3 board is a industrial grade RISC-V development board, it
> design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> computing power. 4G DDR and 16G eMMC onboard.2x GbE Ethernet prot, 4x USB

missing space before 2x and port rather than prot

> 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
>=20
> This patch introduces fundamental support for the Banana Pi F3 board,
> encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> operate in serial console mode.
>=20
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
>=20
> Kongyang Liu (2):
> =C2=A0 riscv: spacemit: bananapi_f3: initial support added
> =C2=A0 doc: spacemit: bananapi_f3: document Banana Pi F3 board
>=20
> =C2=A0arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 +
> =C2=A0arch/riscv/cpu/k1/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 ++
> =C2=A0arch/riscv/cpu/k1/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
> =C2=A0arch/riscv/cpu/k1/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> =C2=A0arch/riscv/cpu/k1/dram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 ++++
> =C2=A0arch/riscv/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/riscv/dts/k1-bananapi-f3.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 25 ++
> =C2=A0arch/riscv/dts/k1.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 375 +++++++++++++++++=
++++++++
> =C2=A0board/spacemit/bananapi_f3/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
25 ++
> =C2=A0board/spacemit/bananapi_f3/MAINTAINERS |=C2=A0=C2=A0 6 +
> =C2=A0board/spacemit/bananapi_f3/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 5 +
> =C2=A0board/spacemit/bananapi_f3/board.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 9 +
> =C2=A0configs/bananapi_f3_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> =C2=A0doc/board/spacemit/bananapi_f3.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
78 +++++
> =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0include/configs/bananapi_f3.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +
> =C2=A017 files changed, 660 insertions(+)
> =C2=A0create mode 100644 arch/riscv/cpu/k1/Kconfig
> =C2=A0create mode 100644 arch/riscv/cpu/k1/Makefile
> =C2=A0create mode 100644 arch/riscv/cpu/k1/cpu.c
> =C2=A0create mode 100644 arch/riscv/cpu/k1/dram.c
> =C2=A0create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
> =C2=A0create mode 100644 arch/riscv/dts/k1.dtsi
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/Kconfig
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/Makefile
> =C2=A0create mode 100644 board/spacemit/bananapi_f3/board.c
> =C2=A0create mode 100644 configs/bananapi_f3_defconfig
> =C2=A0create mode 100644 doc/board/spacemit/bananapi_f3.rst
> =C2=A0create mode 100644 doc/board/spacemit/index.rst
> =C2=A0create mode 100644 include/configs/bananapi_f3.h
