Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD8DC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D8687F2F;
	Tue, 19 Mar 2024 13:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="hU6WBrhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D738083F; Tue, 19 Mar 2024 09:44:29 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A328B87D40
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id EDF6812000B;
 Tue, 19 Mar 2024 11:44:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EDF6812000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1710837866;
 bh=qveArEVbyeAbgMiy9zLi00DM9qXO76dGimPzVLOhYu0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=hU6WBrhROzFXIT6nEmfYpt/r/YtTMqrZIQ3soWsEdJoXkSgPJgJCzeDE+9fvEvqlV
 dW6pQYvYWNsdRecIvtYv/fzGrq46twciJv6ZCpK6NE2fhE1DauLcQ3i1GoMmTLICOD
 J/pH4fnStCBHbVq9kXd2DvBTSq4IrEHdtgmNEIa+6dKrp+e9XU9PKRjFnklqLw/JaX
 RGcyzrAVlqRR0H7F6XykChbCDCPH1hYdtGLbYUI7czvXcoHetX3D1ZLiCVLLVtAeqE
 uzbdAMwKPdd5qlCG1R3SSkOFgm3bmT5nPObS7EGT87z8OCi+1rVAORo5c3gZf9EqIT
 j0RAvpVku5+YQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 19 Mar 2024 11:44:26 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Mar 2024 11:44:26 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Tue, 19 Mar 2024 11:44:26 +0300
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
Subject: Re: [PATCH v1 0/6] Introduce UBI block device
Thread-Topic: [PATCH v1 0/6] Introduce UBI block device
Thread-Index: AQHab80XWfhjCaCdmU6STPmk9GLMTLE+oV8A
Date: Tue, 19 Mar 2024 08:44:25 +0000
Message-ID: <20240319084408.s4h75ku234oavodw@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
In-Reply-To: <20240306134906.1179285-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5D845FBDDE9D546BE8B741A322E1ED5@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184251 [Mar 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 10 0.3.10
 53c821b925e16276b831986eabc71d60ab82ee60, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:5.0.1,7.1.1; cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2, FromAlignment: s
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

On Wed, Mar 06, 2024 at 04:49:00PM +0300, Alexey Romanov wrote:
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
> - Links:
>=20
>   [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
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
>  drivers/mtd/nand/spi/core.c |   9 ++-
>  drivers/mtd/ubi/Makefile    |   2 +
>  drivers/mtd/ubi/block.c     | 130 ++++++++++++++++++++++++++++++++++++
>  drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
>  env/ubi.c                   |  16 ++---
>  include/part.h              |   2 +
>  include/ubi_uboot.h         |   8 ++-
>  10 files changed, 334 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/mtd/ubi/block.c
>  create mode 100644 drivers/mtd/ubi/part.c
>=20
> --=20
> 2.34.1
>=20

--=20
Thank you,
Alexey=
