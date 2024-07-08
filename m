Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDE7C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562E0887B3;
	Mon,  8 Jul 2024 14:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="bJtNXgOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF23886E7; Mon,  8 Jul 2024 12:08:39 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A70E088585
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 12:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 58BB1120003;
 Mon,  8 Jul 2024 13:08:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 58BB1120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1720433316;
 bh=Z7z7Q1BecOINwBsTGUbelNf0lnW7M9Bl1XWfSQNWHvk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=bJtNXgOvxLeq4K0zWlRUQgk179bao309xEdnKnrZ4g/km6Gsn3EzzzXEMXsq67uUR
 lVInaTVTgLZvxakF9kUPD7NHbq7cv1cT+aodq2hIc4XPhBJAE3AayqpscudgPmjsy/
 UwVgA4UjgLOQ5+jB+eQ0OWwxPvs9m88z9N1EyqiWyUx4/SsGagim41iwa//9AJHWhu
 qIP1d/yXZccLE3Q/71PLZ/i0UpnmSh7rMe7eIzof6OUw3b68uIpKpvmoPyEo+aJJjD
 AOYNt1OAqPMxQ1g20+JewDgpcpB8E3WSKYC05qB458zIrSUAq17VsSRvnqAwTcR0y9
 8e2R7D7xT3a3g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  8 Jul 2024 13:08:36 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 13:08:35 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518%9]) with
 mapi id 15.02.1118.040; Mon, 8 Jul 2024 13:08:35 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "kmpark@infradead.org" <kmpark@infradead.org>, 
 "hs@denx.de" <hs@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "dunaev@tecon.ru" <dunaev@tecon.ru>, "sjg@chromium.org" <sjg@chromium.org>,
 "bmeng@tinylab.org" <bmeng@tinylab.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>
CC: kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 0/6] Introduce UBI block device
Thread-Topic: [PATCH v5 0/6] Introduce UBI block device
Thread-Index: AQHax7X7t9DY0JPQjE233mnW6FP0pLHse9uA
Date: Mon, 8 Jul 2024 10:08:35 +0000
Message-ID: <20240708100831.tn6zzvgtqdz7x3bu@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240626104527.2811828-1-avromanov@salutedevices.com>
In-Reply-To: <20240626104527.2811828-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA404A95FFB7984C96EF1DD62097401B@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186370 [Jul 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/08 08:42:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/08 08:42:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/08 09:16:00 #25900162
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

Hello, ping.

On Wed, Jun 26, 2024 at 01:45:21PM +0300, Alexey Romanov wrote:
> Hello!
>=20
> This series adds support for the UBI block device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
>=20
>   $ bcb load ubi 0 part_name
>=20
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers. Can be used with mtdblock device [1].
>=20
> ---
>=20
> Changes V1 -> V2 [2]:
>=20
>  - Rebased over mtdblock v2 patchset [3].
>  - Compile UBI partitions support only if CONFIG_BLK option
>    is enabled.
>=20
> Changes V2 -> V3 [4]:
>=20
>  - Fix build warnings: use LBAF printf format string for lbaint_t types.
>=20
> Changes V3 -> V4 [5]:
>=20
>  - Rebased over u-boot/master.
>  - Fix build errors and warnings if CONFIG_BLK isn't enabled.
>  - Fix failed tests in cases is ubiblock device isn't binded.
>=20
> Changes V4 -> V5 [6]:
>=20
>   - Rebased over u-boot/master.
>   - Fix build errors when CONFIG_MTD and CONFIG_MTD_UBI isn't enabled.
>   - Use auto blk device devnum generation when call
>     blk_create_devicef (pass -1 parameter instead of dev_seq(dev)).
>=20
> Links:
>=20
>   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
tedevices.com/
>   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salu=
tedevices.com/
>   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salu=
tedevices.com/
>   [4] https://lore.kernel.org/all/20240325144148.3738195-1-avromanov@salu=
tedevices.com/
>   [5] https://lore.kernel.org/all/20240524111319.3512009-1-avromanov@salu=
tedevices.com/
>   [6] https://lore.kernel.org/all/20240603155740.1840571-1-avromanov@salu=
tedevices.com/
>=20
> Alexey Romanov (6):
>   ubi: allow to read from volume with offset
>   ubi: allow to write to volume with offset
>   drivers: introduce UBI block abstraction
>   disk: don't try search for partition type if already set
>   disk: support UBI partitions
>   spinand: bind UBI block
>=20
>  cmd/ubi.c                   |  78 ++++++++++++++++++++--
>  disk/part.c                 |   7 ++
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/nand/spi/core.c |   9 ++-
>  drivers/mtd/ubi/Makefile    |   1 +
>  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>  env/ubi.c                   |  16 ++---
>  include/part.h              |   2 +
>  include/ubi_uboot.h         |  13 +++-
>  10 files changed, 339 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/mtd/ubi/block.c
>  create mode 100644 drivers/mtd/ubi/part.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
