Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C09E74AC3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 17:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6DB893D6;
	Tue,  3 Dec 2024 18:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="jVXhikk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0492E893E6; Tue,  3 Dec 2024 18:53:20 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37EE489398
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 18:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1733248369; x=1733853169; i=marcel@ziswiler.com;
 bh=ryJaT+tErbNM0ubo91r5EtBI841F1/qsZSfw3dhJPRI=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jVXhikk0nSH7tblh8mKFMg+6/pU+v57UyVHx4pS71JqWRGOqHkVlQLVEP/HpawlO
 a9SudAayHWMMLJz1YLlkEEojdT8m9io5YDZE4OS90WHIy6wjLfOeYX1sVXSEJrmOa
 IUb37ew2AjQ02ZXxdJ3Z3CgYUK6UH3qxKXafcGc0asKUzjgv7SfIXmQNaULjnTUt0
 jovoP6g2xjJY4FeuELuYxxuF5GyJT9UkcFTCrx+02yvmECytae/rMfbm2IAd8VDim
 Sr3UY44pkkU2ZQFeCPtz/mO1UP1xgyjBAwCnyBv8EKo1PbmD3Sw5uwCN21O2NA5Z0
 rkGWMGn4/VztnE6OJA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.195] ([194.230.241.203]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LlD04-1tqDTC2zRO-00fJgH; 
 Tue, 03 Dec 2024 18:52:49 +0100
Message-ID: <e3ab3f1e2ebfa638f7a4f97483b3def75d005ace.camel@ziswiler.com>
Subject: Re: [PATCH v4 0/2] riscv: spacemit: add support for bananapi-f3
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Huan Zhou <pericycle.cc@gmail.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?ISO-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>, Kever Yang
 <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, Michal Simek	
 <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, Padmarao Begari	
 <padmarao.begari@microchip.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel
 Holland	 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel	 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu
 Chien Peter Lin	 <peterlin@andestech.com>, Kongyang Liu
 <seashell11234455@gmail.com>
Date: Tue, 03 Dec 2024 18:52:40 +0100
In-Reply-To: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:ynWwZs/pR3mG9poRQ/TJx/5xiLOSK6DAipFFNGudP7yibgmVL7f
 VcCf0Hlc8Qsz0COA+hjP4D6xklVxh5SvGsK6BDyQNWEI1Q7qepeiHM4iyUakB+eRFqMyT5g
 3anmCpbydCjuzWbH4cgjpJSdCW+pseeuA/HP+rhr/INpXjcXUNBz/WXm2ROeFknpNGAiQts
 68KLv4zWKtTU6BG83INiA==
UI-OutboundReport: notjunk:1;M01:P0:GlQzK7QcZy4=;xa9yEu4aWcnxXRteYXB8rYjC7Lf
 dhg53pYvd3TvAaMQATCwRt0MMV1ZPIJRX+ReQV3D6MfPSSnXEIoPSKAYwivBCZdQ4xEYBSGz5
 5HYnS8+RQLBF4sb1pGM6fv8UVj8UdypbhFZyiTh8kO81mGYcq/GtRPvNXTlpikKqwCjjIwYIG
 jjXBaZHH0Ez3Kt6yfbv9uhY88XPQU38+UXnrwYUGdDaiNKHt2eU4lL4aw6h02EewN1ZirUtIr
 gsZr8ip69xmmi7IISn/9Z2SrB6D/zPg02my34aAeY7Jbd2qGViVRqfwhdnJoy26ZmGlC1mnJq
 buXfTwZnOkB+d4WRo4kzxnQc60hvEHi1PNSxcaaCLZC/fNr3H9NXtLvpC7l9EvXiUasMGyytA
 C4AsIAGNoJw2dTtI0xBCzgNkCzAqg+T0XIkHDmJjKRFkNleAce9Vr4coCE8A38veYsUWcOvua
 5CCuMGWNYwBhqF+x4OIMC9HojmVBEJEc8S0+qcebd/hc3jS6uB+9IogSQCmlqXLErnswSucFd
 /q9HTN3aA9yHkhNmjrgXpnAgawe9o3Syw7N95ArtQchMBgZkdk0AYbSXqkvUtBbZkEgU9N5PC
 EU4TMX01ha3MLcz2+zo4SgWJGq3AFfVzx3uwLa4V1HxI2jkfePXZ2C0mb6LIYWpEduokXVodY
 ZdNxGvtqa6q6oqUoxzgt1ie6n7EDBUAUbUUurFg/fhaiYGYQ6HgO85Bi75lLCuSJ9fnJSxf/p
 zE4XDuj9bTzQ41G7G827HsDhU9X/9ONuXW7v+ZCsTBydsc8CGyaDRe/ntZrormMsgrOaydTE5
 F3LgRaWxVv9muN/tTsoxJVa1DQzDRzoFNBC5Xvn6sDfl5551/+iy3Fr7WW9D5CP3qyCskw1Z/
 fAOxHXIaRJ7d0WhuGYIY6gdEIFANcElN6cMOoaO5DWoBr0JrJlY2YtDArfmRBllFkNsnn+7q2
 sPoFAEmR/GDpkQip1MPNk70MOxm/55KtqOwBUfu51rm4534MD/m06uvNtz5gdhLRsA/Be1AWK
 mJQerVA4TvoaJlfPfj3D0Z2f+ocMxCfUb47Rrp8
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

Hi Huan Zhou

Thanks for taking this one step further.

On Fri, 2024-11-29 at 13:37 +0800, Huan Zhou wrote:
> Banana Pi F3 board is a industrial grade RISC-V development board, it
> design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> computing power. 4G DDR and 16G eMMC onboard.

There are also variants with different sizes of DDR and/or eMMC available. =
I do e.g. have one with 16 GB DDR
and 128 GB eMMC.

> 2x GbE Ethernet port, 4x USB
> 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
>=20
> This patch introduces fundamental support for the Banana Pi F3 board,
> encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> operate in serial console mode.

I have only some minor comments on the second patch (see separate email).

Plus you could mention that this patch set is against the top of the riscv =
custodian's next branch.

> Changes in v4:
> - Change uart compatible in k1.dtsi in v3, cause related driver in not im=
plemented in u-boot.
> - Update doc, show how to validate the patch.
> - Update maintainer, remove kongyang cause he lefted.
> - Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a458=
02ab79@gmail.com
>=20
> Changes in v3:
> - Add base commit
> - Clear redifinition warning while building in UART_IIR_ID
> - Change underscore to dash in bananapi*f3
> - Update maintainer
> - link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashel=
l11234455@gmail.com/
>=20
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
> - links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashel=
l11234455@gmail.com/
>=20
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

Whole series

Tested-by: Marcel Ziswiler <marcel@ziswiler.com>

> ---
> Kongyang Liu (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 riscv: spacemit: bananapi_f3: initial supp=
ort added
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: spacemit: bananapi_f3: document Banan=
a Pi F3 board
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
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 459 +++++++++++++++++=
++++++++++++++++
> =C2=A0board/spacemit/bananapi-f3/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
25 ++
> =C2=A0board/spacemit/bananapi-f3/MAINTAINERS |=C2=A0=C2=A0 6 +
> =C2=A0board/spacemit/bananapi-f3/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 5 +
> =C2=A0board/spacemit/bananapi-f3/board.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 9 +
> =C2=A0configs/bananapi-f3_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 20 ++
> =C2=A0doc/board/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
> =C2=A0doc/board/spacemit/bananapi-f3.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
86 ++++++
> =C2=A0doc/board/spacemit/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> =C2=A0include/configs/bananapi-f3.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +
> =C2=A017 files changed, 750 insertions(+)
> ---
> base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
> change-id: 20241112-pickup-bpif3-245ab208b9a4
>=20
> Best regards,

Cheers

Marcel
