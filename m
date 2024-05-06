Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D3C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 15:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F57188685;
	Mon,  6 May 2024 17:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="RlEqc5Xb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF4E885B5; Mon,  6 May 2024 15:58:03 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 359FF884F6
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 15:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B7E87100007;
 Mon,  6 May 2024 16:58:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B7E87100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1715003880;
 bh=hyY5LCyxcWmoaDKAVvMqOeMNQIq5QH2PvnQFee0maYo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=RlEqc5XbAqEuJkN+579BbmtUO4gNTwe52xWfofsqTNI5HtVFjqs51g0KaOW7XVOcM
 jOeCQhKY9XCMkv3P0XIrL80K4nmLi7IP8BhElNGdNzeAcbXPYlDvT7Tnvbsr7p9ARI
 gII5tr4QwJkns8kOhn8XwlhhlrkrPnPlUzY2q3QLlGWXCeLJT2BlqfP/DdkA07Zydn
 Y/3XTs5h3nJKlE1YcO7nmNW/1BmEMVKF2D/wAu+iztbwZ1yZEAxxuZcBtBsaVFN6Kn
 QK6N9PD6mOYTllK0aRcZBYMwoRothhupd3gXhRnGkuqY1H223J56mpFmNXOy4sbdKo
 5QFgkgQY3VucA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  6 May 2024 16:58:00 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 6 May 2024 16:58:00 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Mon, 6 May 2024 16:58:00 +0300
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
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
Thread-Topic: [PATCH v2 0/6] Introduce UBI block device
Thread-Index: AQHafsKY1wi7DQ3h+k+mVy5zB7Awi7GKSvmA
Date: Mon, 6 May 2024 13:58:00 +0000
Message-ID: <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
In-Reply-To: <20240325144148.3738195-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0E645017C086146842939079A66D4F3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185086 [May 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19
 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/06 13:00:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/06 13:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/06 12:01:00 #25108659
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 06 May 2024 17:22:47 +0200
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

On Mon, Mar 25, 2024 at 05:41:42PM +0300, Alexey Romanov wrote:
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
> ---=20
>=20
> Changes V1 -> V2 [2]:
>=20
>  - Rebased over mtdblock v2 patchset [3].
>  - Compile UBI partitions support only if CONFIG_BLK option
>    is enabled.
>=20
> - Links:
>=20
>   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
tedevices.com/
>   [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@salu=
tedevices.com/
>   [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@salu=
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
>  cmd/ubi.c                   |  77 +++++++++++++++++++--
>  disk/part.c                 |   7 ++
>  drivers/block/blk-uclass.c  |   1 +
>  drivers/mtd/nand/spi/core.c |   8 ++-
>  drivers/mtd/ubi/Makefile    |   1 +
>  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>  env/ubi.c                   |  16 ++---
>  include/part.h              |   2 +
>  include/ubi_uboot.h         |   8 ++-
>  10 files changed, 332 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/mtd/ubi/block.c
>  create mode 100644 drivers/mtd/ubi/part.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
