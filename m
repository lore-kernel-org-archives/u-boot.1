Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468A2C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 12:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2243087B7C;
	Tue, 23 Jan 2024 13:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="YC7PItgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C6987D15; Tue, 23 Jan 2024 13:28:02 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AE587D03
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 13:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:9106:5cb0:487c:7b4c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id AF3853D42471;
 Tue, 23 Jan 2024 13:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1706012879;
 bh=HsHfFpym3FYxb3YYO6pEKn7nteQNis/G/DBYXOo23Jk=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=YC7PItgdOgFVo97fOK0OmsyBGwvJn/0/+vlmmEqOZbyKANGrYd6ponFJCZzDbRvGA
 VMuN0yGUiQKjDL796M3dk7Ev5PTYRHEeUmnt/lGKAziwO/GXUt9Ar3G5MZK+CfDYg6
 ofj10mRkTqPV+yeNA87/k5dlK9WjvuwDm9vYH5oc=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v5 0/7] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
Date: Tue, 23 Jan 2024 13:27:48 +0100
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Stefan Wahren <wahrenst@gmx.net>, florian.fainelli@broadcom.com,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <68A667BF-F7BC-4ED8-919E-16B2CB406369@jens-maus.de>
References: <20240123080819.13625-1-iivanov@suse.de>
To: "Ivan T. Ivanov" <iivanov@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

Hi,

as requested [1]:

Tested-by: Jens Maus <mail@jens-maus.de <mailto:mail@jens-maus.de>>

best regards,
jens

[1] https://lists.denx.de/pipermail/u-boot/2024-January/544243.html

> Am 23.01.2024 um 09:07 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
> This is new round of patches posted earlier here[1]. They are adding =
basic
> support for RPi5 and are based on v2 series from Dmitry Malkin[2].
>=20
> What changed sice v4:
>=20
> * Support for SDHCI controller in 2712 was simplified a lot. It turns =
out
>  that special registers accessors are not needed[3].
>=20
> * Latest EEPROM firmware changed "kernel" load address from 0x80000
>  to 0x200000. And because on RPi=E2=80=99s CONFIG_TEXT_BASE is set to =
0x80000
>  code execution run through the grass. Switching to position indeended
>  code fixed this.
>=20
> These changes have been tested on following devices:
>=20
> Raspberry Pi 5 Model B Rev 1.0
> Raspberry Pi 4 Model B Rev 1.1
> Raspberry Pi 3 Model B Plus Rev 1.3
> Raspberry Pi Zero 2 W Rev 1.0
> Raspberry Pi 2 Model B Rev 1.2
> Raspberry Pi Compute Module 4 Rev 1.0
> Raspberry Pi Compute Module 3 Rev 1.0
>=20
> Thanks,
> Ivan
>=20
> [1] =
https://lore.kernel.org/all/20240110122908.31612-1-iivanov@suse.de/
> [2] =
https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=3Dqx1R+L24WBgpo-=
iP1yo7A@mail.gmail.com/
> [3] =
https://github.com/P33M/linux/commit/8a15e5d99667cb4499836d6f360246a69f020=
256
>=20
>=20
> Dmitry Malkin (2):
>  rpi5: add initial memory map for bcm2712
>  rpi5: Use devicetree as alternative way to read IO base addresses
>=20
> Ivan T. Ivanov (5):
>  rpi5: Use devicetree to retrieve board revision
>  bcm2835: Dynamically calculate bytes per pixel parameter
>  mmc: bcmstb: Add support for bcm2712 SD controller
>  configs: rpi_arm64: enable SDHCI BCMSTB driver
>  configs: rpi_arm64: build position independent code
>=20
> arch/arm/mach-bcm283x/include/mach/base.h  |  5 +-
> arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
> arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
> arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
> arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
> arch/arm/mach-bcm283x/init.c               | 74 +++++++++++++++++++---
> board/raspberrypi/rpi/rpi.c                | 22 ++++++-
> configs/rpi_arm64_defconfig                |  3 +-
> drivers/mmc/bcmstb_sdhci.c                 | 64 +++++++++++++++++--
> drivers/video/bcm2835.c                    | 18 +++++-
> 10 files changed, 171 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.43.0
>=20

--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

