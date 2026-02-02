Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F1E73145
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 08:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A315B83DA7;
	Mon,  2 Feb 2026 09:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="G44hKbUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD30783DA9; Mon,  2 Feb 2026 09:34:14 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6986E83BC9
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260202083352epoutp013af709929e02cbf503b7e29975398b0e~QYO7YnbE82003220032epoutp01_
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 08:33:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260202083352epoutp013af709929e02cbf503b7e29975398b0e~QYO7YnbE82003220032epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1770021232;
 bh=MGUwScdI6DW9SIUgs/SmXDPaRHioLAevLAlLt7Go4Vk=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=G44hKbUVGRK9mJrFzQfoL5rnGcCxtkTt9ZeJmNG9Tygq3+98ClOSbp9g7xslUqSDp
 c/2eA8XHLY+HmB70DBmNWnrBdZLx4FxYpO+ZlJJIlAwHq0fbryJv4buGhrmQZqb18P
 IzRgrsw86GvCxeuWuZcn2a8Rr5rN45qQlxRHKsSo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20260202083351epcas1p18160b72db41b980b40f7a44e478a590e~QYO6t_f9-3051230512epcas1p1_;
 Mon,  2 Feb 2026 08:33:51 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.119]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4f4Kdq2nN1z3hhTD; Mon,  2 Feb
 2026 08:33:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20260202083350epcas1p3dacd9a766d8430a0f5ff1ffce6d2dac6~QYO5aaqbq3263332633epcas1p3X;
 Mon,  2 Feb 2026 08:33:50 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20260202083350epsmtip2cbe1097858cd31da9c1836c93ed6ecb0~QYO5S2st02315523155epsmtip2Q;
 Mon,  2 Feb 2026 08:33:50 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Lukas Timmermann'" <uboot@timmermann.space>, <u-boot@lists.denx.de>
Cc: "'Alif Zakuan Yuslaimi'" <alif.zakuan.yuslaimi@altera.com>, "'Arturs
 Artamonovs'" <arturs.artamonovs@analog.com>, "'Eoin Dickson'"
 <eoin.dickson@microchip.com>, "'Greg Malysa'" <malysagreg@gmail.com>,
 "'Heiko Schocher'" <hs@nabladev.com>, "'Henrik	Grimler'"
 <henrik@grimler.se>, "'Ian Roberts'" <ian.roberts@timesys.com>,
 =?UTF-8?Q?'J._Neusch=C3=A4fer'?= <j.ne@posteo.net>, "'Jerome Forissier'"
 <jerome.forissier@linaro.org>, "'Kory Maincent \(TI.com\)'"
 <kory.maincent@bootlin.com>, "'Marek Vasut'"
 <marek.vasut+renesas@mailbox.org>, "'Mattijs Korpershoek'"
 <mkorpershoek@kernel.org>, "'Nathan Barrett-Morrison'"
 <nathan.morrison@timesys.com>, "'Neil Armstrong'"
 <neil.armstrong@linaro.org>, "'Oliver Gaskell'" <Oliver.Gaskell@analog.com>,
 "'Patrice Chotard'" <patrice.chotard@foss.st.com>, "'Peng Fan'"
 <peng.fan@nxp.com>, "'Philip Molloy'" <philip.molloy@analog.com>, "'Simon
 Glass'" <sjg@chromium.org>, "'Stefan Roese'" <stefan.roese@mailbox.org>,
 "'Tom Rini'" <trini@konsulko.com>, "'Utsav Agarwal'"
 <utsav.agarwal@analog.com>, "'Vasileios Bimpikas'"
 <vasileios.bimpikas@analog.com>, "'Yao Zi'" <ziyao@disroot.org>
In-Reply-To: <20251103191427.2410755-1-uboot@timmermann.space>
Subject: RE: [PATCH v2 0/2] Modern pinctrl for Exynos5250 devices
Date: Mon, 2 Feb 2026 17:33:50 +0900
Message-ID: <0e2901dc941e$a80ac4c0$f8204e40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIB4zzJpevgXuP0dx3fUttjmCX+gAMLe3K3tQwWQ/A=
Content-Language: ko
X-CMS-MailID: 20260202083350epcas1p3dacd9a766d8430a0f5ff1ffce6d2dac6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251103191515epcas1p209371cc60bfa83914a77194d3899619b
References: <CGME20251103191515epcas1p209371cc60bfa83914a77194d3899619b@epcas1p2.samsung.com>
 <20251103191427.2410755-1-uboot@timmermann.space>
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

Dear Timmermann,

Sorry I missed this patch..

I tested this patch but I've got compile errors.
Could you please check?; tested with smdk5250.

/opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers=
/gpio/s5p_gpio.o: in function =60gpio_set_pull':
/home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:240: multiple definit=
ion of =60gpio_set_pull'; arch/arm/mach-exynos/pinmux.o:pinmux.c:(.text.gpi=
o_set_pull+0x0): first defined here
/opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers=
/gpio/s5p_gpio.o: in function =60gpio_set_drv':
/home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:246: multiple definit=
ion of =60gpio_set_drv'; arch/arm/mach-exynos/pinmux.o:pinmux.c:(.text.gpio=
_set_drv+0x0): first defined here
/opt/toolchain/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ld: drivers=
/gpio/s5p_gpio.o: in function =60gpio_cfg_pin':
/home/work/git/u-boot-samsung/drivers/gpio/s5p_gpio.c:252: multiple definit=
ion of =60gpio_cfg_pin'; arch/arm/mach-exynos/pinmux.o:/home/work/git/u-boo=
t-samsung/arch/arm/mach-exynos/pinmux.c:952: first defined here

Thanks,
Minkyu Kang.

