Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0472AC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 16:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63A18644B;
	Fri, 25 Aug 2023 18:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8199086AB7; Fri, 25 Aug 2023 18:42:17 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F07B8643B
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 18:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from [127.0.0.1] ([84.226.64.168]) by mrelay.perfora.net (mreueus004
 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N0WTY-1po3pv1Mto-00wTQh;
 Fri, 25 Aug 2023 18:41:47 +0200
Date: Fri, 25 Aug 2023 18:41:38 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "philippe.reynes@softathome.com" <philippe.reynes@softathome.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "bb@ti.com" <bb@ti.com>, "marex@denx.de" <marex@denx.de>,
 "pali@kernel.org" <pali@kernel.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>
Subject: Re: [PATCH v2 3/3] board: toradex: add verdin am62 support
User-Agent: K-9 Mail for Android
In-Reply-To: <72cf350455ba063d79dd1971a97a39a48aa87191.camel@siemens.com>
References: <20230612205444.363727-1-marcel@ziswiler.com>
 <20230612205444.363727-4-marcel@ziswiler.com>
 <aa6e7ddab0a43f94d8530d4781599d59612764a2.camel@siemens.com>
 <72cf350455ba063d79dd1971a97a39a48aa87191.camel@siemens.com>
Message-ID: <7B2FFAA5-F011-4C0F-8ED1-C34B9985A5C0@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kl49qvYKGl4UHEFTcIGpNgFNVVnGyPO+fKXA2gavbc8GRZbk8Dq
 w8W+XKak4HSV3pGYkbeebJV8QGOOVQnuk2iTHWElCdbLJmK79MHfL0w//b6ZHwF4MjmSjyq
 IL6geKQkRJqr20R1XFAcHoTvT/BxNN7RyYLntzF4LyI9D8WeKXUhHVXzTUgWuvR3XQu2z4Z
 +4eO8o1CgVikZ3ucPvMuQ==
UI-OutboundReport: notjunk:1;M01:P0:7yhgoEcZhMM=;VbyWWA1aAOM+0ppgRM29+LGp/SL
 uVi8JAvtsumJq+3iIYTuogmiAeeoSTDw6Zmb1Rlgu7LD7Rs0i1jr1yS0ICmY8MZw6kag856v/
 fqVyFaU7wtwr4IeHzFY+PdWzM3fZ/ya4mfahT+R+TsEu5+omDXNX544iTriy8E1AnE8PALtTv
 H76H5KcFaqgt+L9cpkCemL2cjjlrgwG/yzIU74LPUIyiMAv+eSTpXf76rWnvzWMIsDmuw7OdH
 wS53XhczeUsynUdmpLXKcsS/u/BdNQ35sgmHEmA3p58fcsDTBADxp0+xjiR1Ayb7RjgkM9/4D
 n/eATRLaI1mEHYWDMEj7ey15oVx9A6ugOaIdSMWXeyxDutcVNXeqq1YRZhCXLzwwyipq/Odnc
 QbFTSTYL/VnnDrmJUakvdH3KlnDvVEJhYjEQynmlFVA9PITGQuZI9cJZkufscU7xaCmY+6413
 NP/0bWryOiZmxibGr7cqja7OKrOLInIIjyf2dnxXvnH54/jE9ymmdHESvbvE+77rPjmP+uQLB
 yD6khe2X9D38YFWmQ6z58XCi7MHpF1vli24YQ0CkTMA/4aIIR2/KvEWrJJcLu7OL5df9Q7ed+
 xgPJmo1WVxXKc6dYICQWBuO3Y1fyY47FToqZWUIKQBgcZQs6Z7Ix7MnyT8N5/bbKiSRj95Xs0
 8eeugYJxu4mMFWxBQZUahP56sACPwX2+cNDQg9uI9LlfCcqdmS0sH7wBRgU9457CyF0DChqAc
 eDCBVDJtr09yEDUJZe+2Ztcizpx3dqbtf3yVc9W4/brt8yVgO+kO8cjqlJHxIRWzClpAazplH
 Xoj59ZYG7KqKohbc6+GEWmzB0H0zbd9c0i9L+KzJqfWTWaC2gZJXhqkLCrSvZlHax4xnSTyF8
 6gGolxT+KdWI/QQ==
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

Sali Alexander

On August 25, 2023 6:24:01 PM GMT+02:00, "Sverdlin, Alexander" <alexander=
=2Esverdlin@siemens=2Ecom> wrote:
>Hello Marcel,
>
>On Fri, 2023-08-25 at 15:20 +0200, Alexander Sverdlin wrote:
>> > +Build U-Boot for R5
>> > +-------------------
>> > +
>> > +=2E=2E code-block:: bash
>> > +
>> > +=C2=A0=C2=A0=C2=A0 $ export ARCH=3Darm
>> > +=C2=A0=C2=A0=C2=A0 $ export CROSS_COMPILE=3Darm-none-linux-gnueabihf=
-
>> > +=C2=A0=C2=A0=C2=A0 $ make verdin-am62_r5_defconfig O=3D/tmp/r5
>> > +=C2=A0=C2=A0=C2=A0 $ make O=3D/tmp/r5
>> > +=C2=A0=C2=A0=C2=A0 $ cd =2E=2E/k3-image-gen
>> > +=C2=A0=C2=A0=C2=A0 $ make SOC=3Dam62x SBL=3D/tmp/r5/spl/u-boot-spl=
=2Ebin SYSFW_PATH=3D=2E=2E/ti-linux-firmware/ti-sysfw/ti-fs-firmware-am62x-=
gp=2Ebin
>> > +=C2=A0=C2=A0=C2=A0 $ cp tiboot3-am62x-gp-evm=2Ebin =2E=2E/tiboot3=2E=
bin
>> > +
>>=20
>> the existing K3 platforms have been converted to binman workflow:
>> https://patchwork=2Eozlabs=2Eorg/project/uboot/patch/20230721184446=2E5=
821-21-n-francis@ti=2Ecom/
>>=20
>> Do you think it makes sense to convert the newly added Verdin board
>> to binman workflow as well?
>
>I'm sorry for the noise, I totally missed the fact this has been fixed an=
d
>accepted already!

Don't worry and enjoy (;-p)=2E

Cheers

Marcel
