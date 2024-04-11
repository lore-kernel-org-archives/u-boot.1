Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE523C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 20:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6077587F00;
	Thu, 11 Apr 2024 22:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="kNfzOd7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A2487EFA; Thu, 11 Apr 2024 18:09:36 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D34988208
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 18:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id E4C7110003A;
 Thu, 11 Apr 2024 19:09:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E4C7110003A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712851769;
 bh=Wnnqbf9DEiw0neNFZEaVnitKAB0QhrKYyX1xREucgu8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=kNfzOd7vxBQcqnAkUuxr5CWgGf3u9pO/4tp7uYgMb4Qn83XwzmQWH+yFitKcaBVBl
 Y3tx41rQZ0F5a+tzKhheJUEoyM/ElweXTLfpXrBFYQPWHle33F+LwXHwUwBfgJWVJ9
 oJI+vzMp7aWgLXI1tjtyfBJ9YycF/cUJCLv0lMaLCbmeoLJKIqquygbFhWZW9RWlqp
 wCdPbrCXoBRLnNMHTCqdEUKWbl8Tgl/yXeGR8smDQ+HbVMvZtB8a2Uh7Iv2SDGB3fq
 6NpyoUb3EJ9FK9CxfH4rj7APMHZkZ72hypS+VmZlLLugWOWLb6ICEkNkEykPBuHFcX
 aml0g621s6Sjw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 11 Apr 2024 19:09:29 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 19:09:29 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Thu, 11 Apr 2024 19:09:29 +0300
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
Subject: Re: [PATCH v3 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v3 0/3] Introduce mtdblock device
Thread-Index: AQHahn8E065oAbZrwUS8pgiLN8ifkbFjFfGA
Date: Thu, 11 Apr 2024 16:09:29 +0000
Message-ID: <20240411160857.fb6a2neossmz2d4y@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240404105813.1520732-1-avromanov@salutedevices.com>
In-Reply-To: <20240404105813.1520732-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FEAB6AF68693B40A7A68A6690DFFBB4@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184677 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16
 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:7.1.1,5.0.1; lore.kernel.org:7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/11 07:46:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/11 07:47:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/11 11:38:00 #24745823
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 11 Apr 2024 22:31:40 +0200
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

On Thu, Apr 04, 2024 at 01:58:10PM +0300, Alexey Romanov wrote:
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
> Links:
>=20
>   - [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@sa=
lutedevices.com/
>   - [2] https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@sa=
lutedevices.com/
>   - [3] https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.sc=
huchardt@canonical.com/T/#u
>=20
> Alexey Romanov (3):
>   disk: support MTD partitions
>   drivers: introduce mtdblock abstraction
>   spinand: bind mtdblock
>=20
>  disk/part.c                 |   3 +-
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/Kconfig         |   1 +
>  drivers/mtd/Makefile        |   1 +
>  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtdpart.c       |  69 +++++++++++
>  drivers/mtd/nand/spi/core.c |  20 ++++
>  include/linux/mtd/mtd.h     |  12 ++
>  include/part.h              |   3 +
>  9 files changed, 336 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/mtdblock.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
