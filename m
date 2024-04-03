Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E60CCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088658838E;
	Wed,  3 Apr 2024 14:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="mOnn8Y3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF18881F7; Wed,  3 Apr 2024 10:45:27 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6DF87F4A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 10:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 0DDD312000C;
 Wed,  3 Apr 2024 11:45:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0DDD312000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712133924;
 bh=tO3tVWNl7vE0dHd9M7ab2qLzdUPlRzPSRmHZQneBSYg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=mOnn8Y3Rnd/Z+VIzwHWYWkAY2x4b+kJbyHXGUTs7ucbtus6AWKHCAhBqxu0Wj/h2I
 e2X9nlAzXtqMystZL4mSLBs6thL1RYMJkQuGywqKLvXrvQL/zx/yEOJh/I92rQVnW1
 2gs0rxMS0+7GvwMel6oznncMFE39EcZRY10IcB6hR++pEe9A3p3kRApYiX6BQhHxu+
 EVvsFjRUdzBQRRT2Ccip8IvqRiUSPJCMljr9Ip8wxG671TOPFhvHXwhu6fH6Xgb1ne
 HmpwUk2vd9iF/PUDdHRiM4ZPaDIhJY4kUUCIzJ5u7STSC4pNQTzGVbqGvhOYqAALIG
 0M4qgnhvjLY4w==
Received: from smtp.sberdevices.ru (p-i-exch-a-m2.sberdevices.ru
 [172.24.196.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  3 Apr 2024 11:45:23 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m2.sberdevices.ru (172.24.196.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 11:45:23 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Wed, 3 Apr 2024 11:45:23 +0300
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
Thread-Index: AQHacJBtVQvW33HFH0uSSC6xOt3Ka7FWMxYA
Date: Wed, 3 Apr 2024 08:45:23 +0000
Message-ID: <20240403084518.76ppbg7wwjzqaxj5@cab-wsm-0029881>
References: <20240307130726.1582487-1-avromanov@salutedevices.com>
In-Reply-To: <20240307130726.1582487-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3927979C210242459E076EC7AB250EC4@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184547 [Apr 03 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/02 23:35:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/02 23:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/03 07:03:00 #24587967
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 03 Apr 2024 14:55:06 +0200
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

Hi guys! Ping.

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
