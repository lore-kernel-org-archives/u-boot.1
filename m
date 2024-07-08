Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DF8C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A5A88765;
	Mon,  8 Jul 2024 14:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="DuGuxdWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37723886D7; Mon,  8 Jul 2024 12:08:06 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443DF88585
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 12:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6DC89100006;
 Mon,  8 Jul 2024 13:08:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6DC89100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1720433282;
 bh=ZIdpt5MDVOdMrfDkozshqHX1whIQwpmuMapsovgOQl0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=DuGuxdWxWH8er04pHeaRrh5eLib8ZP3mAvhZJDpWi+nkE/Z+UUN/UKzAo2x2/APVP
 +/DNq+RuEqnL+OeywQ6LKZ2AUdoZYywysyXYSEsEGPtC5DlH4IPjs/Z5m/XDQ3hjYP
 oljKeNcNYw5s7vuXem38ENrkX9DwGZVHLwKuzFxd77QAtIXF6+gycK3bPth4hvLWn2
 FaFWa5Yth7619fGljK/W7nQ/nXpmOafMIRJr6QE0whFCyrBww3nwilrwRQBpvxWnso
 DSRdj6A/KSVr3WUTUmTqOaDUa67wKGLHNg9p+EL0sCFFgBbU9YXZZyCyYLSRDprTxh
 Tmk88HS+T5zCg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  8 Jul 2024 13:08:02 +0300 (MSK)
Received: from p-i-exch-a-m1.sberdevices.ru (172.24.196.116) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 13:08:01 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Jul 2024 13:08:01 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518%9]) with
 mapi id 15.02.1118.040; Mon, 8 Jul 2024 13:08:01 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org"
 <bmeng@tinylab.org>, "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "michal.simek@amd.com" <michal.simek@amd.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>
CC: kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v6 0/3] Introduce mtdblock device
Thread-Index: AQHax7XfB/TET30V0UC+bXQsuJtnxrHse7EA
Date: Mon, 8 Jul 2024 10:08:01 +0000
Message-ID: <20240708100756.j34cftjmjkl2hiv3@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240626104440.2811686-1-avromanov@salutedevices.com>
In-Reply-To: <20240626104440.2811686-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6307A4FD221A8A4DBE5018324E4ED59D@sberdevices.ru>
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
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
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

On Wed, Jun 26, 2024 at 01:44:37PM +0300, Alexey Romanov wrote:
> Hello!
>=20
> This series adds support for the mtdblock device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
>=20
>   $ bcb load mtd 0 part_name
>=20
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers.
>=20
> ---
>=20
> Changes V1 -> V2 [1]:
>=20
>   - Drop patch [2].
>   - Add warning if bind NAND mtdblock device.
>   - Move documentation of mtdblock implementation
>     from commit message to the source code.
>   - Remove __maybe_unused from mtd partition functions
>     description.
>   - Use blk_enabled() instead of #ifdefs.
>=20
> Changes V2 -> V3 [2]:
>=20
>   - Rebased over [3].
>   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
>   - Fix GPL-2.0 license short name definiton in headers.
>   - Add empty line after MTD_ENTRY_NUMBERS define.
>=20
> Changes V3 -> V4 [4]:
>=20
>   - Fix build warnings: use LBAF printf format string for lbaint_t types.
>=20
> Changes V4 -> V5 [5]:
>=20
>   - Rebased over u-boot/master.
>   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
>   - Fix failed tests in cases is mtdblock device isn't binded.
>=20
> Changes V5 -> V6 [6]:
>=20
>   - Rebased over u-boot/master.
>   - Fix build errors when CONFIG_MTD isn't enabled.
>   - Use auto blk device devnum generation when call
>     blk_create_devicef (pass -1 parameter instead of dev_seq(dev)).
>=20
> Links:
>=20
>   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@sa=
lutedevices.com/
>   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@sa=
lutedevices.com/
>   - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.sc=
huchardt@canonical.com/T/#u
>   - [4] https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@sa=
lutedevices.com/
>   - [5] https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@sa=
lutedevices.com/
>   - [6] https://lore.kernel.org/all/20240603155702.1840464-1-avromanov@sa=
lutedevices.com/
>=20
> Alexey Romanov (3):
>   disk: support MTD partitions
>   drivers: introduce mtdblock abstraction
>   spinand: bind mtdblock
>=20
>  disk/part.c                 |   3 +-
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/Kconfig         |   1 +
>  drivers/mtd/Makefile        |   3 +
>  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c       |  76 ++++++++++++
>  drivers/mtd/nand/spi/core.c |  20 ++++
>  include/linux/mtd/mtd.h     |  25 ++++
>  include/part.h              |   3 +
>  9 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/mtdblock.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
