Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7FCC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9A787EFA;
	Tue, 19 Mar 2024 13:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="QmjQZroV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D699087D82; Tue, 19 Mar 2024 09:43:46 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F6E08083F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7C714100013;
 Tue, 19 Mar 2024 11:43:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7C714100013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1710837823;
 bh=DhORVQpB+GM9+jMEL+HbS9J78a+qPQVN3DwOFQy4aYk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=QmjQZroVoIUyaL4IX3hkq2Dd+vRVSoAkogN92jxjcbBaz+bFXnpl5f8pO5s6UB+W0
 CYAZBnqhkhmmQ7zbYVybfnnCViVbovy0rsrZZ/R48/7Qr3xoDe3Mv/3qUf036MU2x8
 DR48or1SaOLKhJQqCgdmG9423arXNmOIWvWM2Hjiz8L2EGNCj2+kgP4kHlzO8o9YGJ
 OLpxuCxk2+4ucXj8jBd+7VIVqFfbaxr+HH5RS1oSPye3xi18VcTgIwaAGOdtFV/+2H
 AjggFnL1Uyo7ZiNkmVE1F544hkRT/GWP8pYEQRmXod/0jf3wHgelysHfNuMDzzGf5B
 tvSflwPO5wZkw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 19 Mar 2024 11:43:43 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 11:43:42 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Tue, 19 Mar 2024 11:43:42 +0300
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
Subject: Re: [PATCH v2 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v2 0/3] Introduce mtdblock device
Thread-Index: AQHacJBtVQvW33HFH0uSSC6xOt3Ka7E+n6IA
Date: Tue, 19 Mar 2024 08:43:42 +0000
Message-ID: <20240319084334.n43r73hegb2hrrd4@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240307130726.1582487-1-avromanov@salutedevices.com>
In-Reply-To: <20240307130726.1582487-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AECD51CF70534144B0DC720AE2948B61@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184252 [Mar 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/19 04:38:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/19 04:38:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/03/19 01:36:00 #24282057
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 19 Mar 2024 13:12:10 +0100
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

Hello! Ping.

On Thu, Mar 07, 2024 at 04:07:23PM +0300, Alexey Romanov wrote:
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
> Links:
>=20
>   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@sa=
lutedevices.com/
>   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@sa=
lutedevices.com/
>=20
> Alexey Romanov (3):
>   disk: support MTD partitions
>   drivers: introduce mtdblock abstraction
>   spinand: bind mtdblock
>=20
>  disk/part.c                 |   5 +-
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/Kconfig         |   1 +
>  drivers/mtd/Makefile        |   1 +
>  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c       |  69 +++++++++++
>  drivers/mtd/nand/spi/core.c |  20 ++++
>  include/linux/mtd/mtd.h     |  12 ++
>  include/part.h              |   2 +
>  9 files changed, 337 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/mtdblock.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
