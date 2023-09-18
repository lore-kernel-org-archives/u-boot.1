Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB83FC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 19:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC97C86915;
	Mon, 18 Sep 2023 21:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="S4HLGXSS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252E986925; Mon, 18 Sep 2023 21:40:28 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F7D865A5
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 21:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1695066017; x=1695670817; i=frank-w@public-files.de;
 bh=xPuGYfUv23llKHq+f5Thj1Vk6r4inlkHd+mxpNygaO8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:References;
 b=S4HLGXSSoCTruANZUpBIowcFI02JPVa/XXp9agBjYL2A9zAS+QWnzS76Yr1F2DJ5AsJY3zrJoRq
 djkQ3X2UZUE4nVQi9/bnFKpZvn60Vum+5fZcwjTY/oEQCPrMQ++uh4WClwteJDfiZSzwn8B2O6NF2
 E6FUAw9iRGs74SoYATGflrxuyqc6p6iomslzkheJPBJ51BE+b4mMPTiKxhpU0/3jgf9mJyqx/ViqW
 3uqlnzoU0NevLYDGKVh31bJRzY72TL+KfytiUzvmxSMetU1KbeNmd8T/24ilRy2BM4GqI4wfOlV5t
 oacNP2GwwWUge40y+ggYQUfQn4vpeHzGTAwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.158.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1rDzjm1JoJ-00Vcms; Mon, 18
 Sep 2023 21:40:17 +0200
Date: Mon, 18 Sep 2023 21:40:17 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
CC: linux@fw-web.de, u-boot@lists.denx.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, jonas@kwiboo.se
Subject: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
User-Agent: K-9 Mail for Android
In-Reply-To: <87v8c7e28k.fsf@bloch.sibelius.xs4all.nl>
References: <20230918173624.31464-1-linux@fw-web.de>
 <87wmwne5cw.fsf@bloch.sibelius.xs4all.nl>
 <32AADEE4-360F-423A-BF6C-C8A934D86EF8@public-files.de>
 <87v8c7e28k.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <91110092-BF99-4744-94D5-59CF14C42F83@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vymQdMlGXrO8CoGki928bGJc9KfaDJcJ1+/3hYbiNM4KS1ZiDKc
 EVMVyu1q7lpFs3tuRZxu7GFNMw+T8Io6H4G7YPT7FIKniy6+Nsz0EaDtm2hyjVLXludo2/D
 U0huqxvx4Gy1MH369/f9BqOjxxkri+shIlJpZ9hu92mpqpu/PSL4Z0GnwRhRNygF0mvoefw
 hYqNvUCYtcn7k1/W/cLOw==
UI-OutboundReport: notjunk:1;M01:P0:3kRoEec/HEY=;YGJn+gSbERxDB7MVzGe+nr+QbWO
 OL5+OPXlHsDVm/TmM3Bgs4D7Qn96aGP3GhDz80XHkNEpCgy9w2ZtxXbz4ukziPv5PYbHPlR0i
 wSimmkv/nWHb1TioqydpBKryzGiIXYsbjn7VSUbMdPGPZxiRbaUqKFKK4qyjJkz25Eoj0keH2
 R5rpwEiQbFOebiviYo3ayCkqC1RCSEbo3IdXSuAAGfXVeT/40qSin/5vPK4Fx/St8Ep0DnK4Q
 1YTwctbia/xyxvhGBwEj2+E/odGDDeJQBT78mxMYahGD2TY2xYakdlnSR+tYp1ekttSsnnJRJ
 AaaIlLt1RqSm5QnOBtO9RC1FFdcFdgIRRtj/2AM5dauJ7MAKBz8VIESwAvLyb6GrcAkTMS3Sp
 jscTDwBaJEBRpB5GmdUybNof9QQpsDxgalYblOmqlhg8kqhbwB0CKiL0tyxf4/qOqLTY6z2qX
 NQ1u2vlc60PE0NBbRFLTZG5mbQ9J5vOC72mqeLiwavaoUHD/y3ke0tJMMS5TQDqG29ucZ3Kwf
 WFMMYG/pC5qtmf5ks1en8+1+iHwwk+ON5jQ606nx7ESXOzMAm7fNwYPAt9j54Yhcp7w6APZHH
 5jRi+5tZIrTgOYJ41kf5kTl2BBjntSFnHUism1niqEAmzkW6qJ6lzYpTZNm36U3jP/rUP6bPA
 Im1NI3fCBAP2IXMaj5Fu82YbpZjvX+xj0uur3U5FHIHIVwPGjUEEBfHAp8nM8trpJnWDBfwUI
 S55Pcyu1PCxOO1u9gf7vwtAfRQBQ5mPbzja61Sv5rp1aEeq08CTxKqYGF/eG55KsHLoVD4AZk
 2fv3wbgUEFM07bt26gKc7VGjnEhbb5ZDicG/L0MR8Z687j53PRJbrU/e5wUbjsDgPrWTnjuVl
 ujw/w2puHkD1iN8nNA7AKOVGUgCq9RI6zKEW4yUIREhJTtqIxoYSrzKIA+C7DRD9XT2Y3nRZ8
 /ZiqvA==
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 18=2E September 2023 20:59:55 MESZ schrieb Mark Kettenis <mark=2Eketteni=
s@xs4all=2Enl>:
>> Date: Mon, 18 Sep 2023 20:09:54 +0200
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Am 18=2E September 2023 19:52:31 MESZ schrieb Mark Kettenis <mark=2Eket=
tenis@xs4all=2Enl>:
>> >> From: Frank Wunderlich <linux@fw-web=2Ede>
>> >> Date: Mon, 18 Sep 2023 19:36:24 +0200
>>=20
>> Hi Mark,
>
>Hello Frank,
>
>> >> --- /dev/null
>> >> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot=2Edtsi
>> >> @@ -0,0 +1,28 @@
>> >> +// SPDX-License-Identifier: GPL-2=2E0+
>> >> +/*
>> >> + * (C) Copyright 2021 Rockchip Electronics Co=2E, Ltd
>> >> + */
>> >> +
>> >> +#include "rk356x-u-boot=2Edtsi"
>> >> +
>> >> +/ {
>> >> +	chosen {
>> >> +		stdout-path =3D &uart2;
>> >> +	};
>> >> +};
>> >> +
>> >> +&uart2 {
>> >> +	clock-frequency =3D <24000000>;
>> >> +	bootph-pre-ram;
>> >> +	status =3D "okay";
>> >> +};
>> >> +
>> >> +&gmac0 {
>> >> +	status =3D "disabled";
>> >> +};
>> >> +
>> >> +/delete-node/ &{/ethernet@fe2a0000/mdio/switch@0};
>> >
>> >Why are you deleting the switch node?  This way an OS that uses the
>> >device tree provided by U-boot will not have a working switch=2E=2E=2E
>>=20
>> Is there such an OS?
>
>Yes, OpenBSD tends to rely on the device tree provided by U-Boot=2E  It
>is impossible to include device trees for all possible boards on the
>installation media=2E  And if U-Boot provides the device tree for the
>board we don't need to (as long as the device tree uses the "official"
>bindings)=2E
>
>> Linux uses own dts=2E
>
>Well, Linux *may* use its own dts=2E  Some boards never make it in the
>official Linux tree=2E  Or a generic Linux distro may use a kernel that
>was released before the board made it to the market=2E  So generic Linux
>distros face the same problem as OpenBSD in that it isn't practical to
>include device trees for every possible board on the installation
>media=2E
>
>So the goal is that U-Boot provides a usable device tree for as many
>boards as possible=2E
>
>> The switch will also not work because the gmac0 is deactivated to
>> fix the timeout in uboot because phy does not answer=2E
>
>I missed that=2E  But that is a bug in U-Boot that should be fixed=2E
>Probably by adding support for "fixed-link" switch ports=2E  Now I
>appreciate that having a U-Boot that partly works is better than no
>U-Boot at all=2E  So that may justify what you did=2E  However=2E=2E=2E

I'm not sure if it is the fixed link that causes the=20
timeout or that switch is not initialized due to=20
missing driver=2E I guess last one=2E=2E=2E

>> I can leave the switch-node, but i do not want the timeout on network a=
ccess on gmac0=2E
>
>=2E=2E=2Esuch a timeout could be seen as a reminder that the work isn't
>finished yet=2E

I wanted to work cleanly on u-boot,but of course i
can send without these "fixes" and add them in
my own tree if this is the better way=2E

>> >> +&mdio0 {
>> >> +	#address-cells =3D <1>;
>> >> +	#size-cells =3D <0>;
>> >> +
>> >> +	switch@0 {
>> >> +		compatible =3D "mediatek,mt7531";
>> >> +		reg =3D <0>;
>> >> +
>> >> +		ports {
>> >> +			#address-cells =3D <1>;
>> >> +			#size-cells =3D <0>;
>> >> +
>> >> +			port@1 {
>> >> +				reg =3D <1>;
>> >> +				label =3D "lan0";
>> >> +			};
>> >> +
>> >> +			port@2 {
>> >> +				reg =3D <2>;
>> >> +				label =3D "lan1";
>> >> +			};
>> >> +
>> >> +			port@3 {
>> >> +				reg =3D <3>;
>> >> +				label =3D "lan2";
>> >> +			};
>> >> +
>> >> +			port@4 {
>> >> +				reg =3D <4>;
>> >> +				label =3D "lan3";
>> >> +			};
>> >> +
>> >> +			port@5 {
>> >> +				reg =3D <5>;
>> >> +				label =3D "cpu";
>> >> +				ethernet =3D <&gmac0>;
>> >> +				phy-mode =3D "rgmii";
>> >> +
>> >> +				fixed-link {
>> >> +					speed =3D <1000>;
>> >> +					full-duplex;
>> >> +					pause;
>> >> +				};
>> >> +			};
>> >> +		};
>> >> +	};
>> >> +};
>>=20
>>=20
>> regards Frank
>>=20


regards Frank
