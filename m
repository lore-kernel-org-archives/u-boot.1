Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCEACD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8980B8835F;
	Wed,  3 Apr 2024 14:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="YbSl+VfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FD2881BC; Wed,  3 Apr 2024 10:44:53 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0701587D1A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 10:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 32730100011;
 Wed,  3 Apr 2024 11:44:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 32730100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712133889;
 bh=nwmvnu5U1N9Yz5hLDm6NUE5XnjDs8wyyJIrVgTOTZ2E=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=YbSl+VfQUpMsvZTu9c1N+Wy638i8CJlvSfOh77VSL+olR3DyG16JqZevQdDh7QJsg
 923ZxNG3DfIJjCuASYpGPZZfV9SO3d8lz3wKI7qFzf7bu95vjfkmOLodPPFKi8JVAu
 mS2tuwSLQml1Ljc7si1+p+3LGUJH2l2ayWi245FUlgJ/xOL4BOncRsB4kV16cG6Ymu
 81Efkzz2xSp3Z3Pz8spoZsKU5xt1PyxJyRyTeHEPV9CoPUBIr84dKtHUamajfVVEMM
 kcswQM6OltXKrnRf4E27Hcha4LkpBR+Yf2xZAhFPRPhaC6WyN28Yv/SJ4Gs117G3cr
 U+FVHJF8RfRqg==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  3 Apr 2024 11:44:48 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 11:44:48 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Wed, 3 Apr 2024 11:44:48 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Heiko Schocher <hs@denx.de>, "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>
CC: kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "kmpark@infradead.org" <kmpark@infradead.org>, 
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "dunaev@tecon.ru"
 <dunaev@tecon.ru>, "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org"
 <bmeng@tinylab.org>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "tobias@waldekranz.com" <tobias@waldekranz.com>, "jpewhacker@gmail.com"
 <jpewhacker@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>, "jbx6244@gmail.com" <jbx6244@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
Thread-Topic: [PATCH v2 0/6] Introduce UBI block device
Thread-Index: AQHafsKY1wi7DQ3h+k+mVy5zB7Awi7FJOlaAgAzcMQA=
Date: Wed, 3 Apr 2024 08:44:48 +0000
Message-ID: <20240403084442.l5njqgwlfj4asv4b@cab-wsm-0029881>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <b5ab190f-6bcd-9cdc-ec91-6a9178ef9d9a@denx.de>
In-Reply-To: <b5ab190f-6bcd-9cdc-ec91-6a9178ef9d9a@denx.de>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D53EBC616A4ED4DB9531EC6CEE87929@sberdevices.ru>
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
 salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 lore.kernel.org:7.1.1, FromAlignment: s
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

On Tue, Mar 26, 2024 at 05:21:29AM +0100, Heiko Schocher wrote:
> Hello Alexey,
>=20
> On 25.03.24 15:41, Alexey Romanov wrote:
> > Hello!
> >=20
> > This series adds support for the UBI block device, which
> > allows to read/write data block by block. For example,
> > it can now be used for BCB or Android AB command:
> >=20
> >    $ bcb load ubi 0 part_name
> >=20
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers. Can be used with mtdblock device [1].
> >=20
> > ---
> >=20
> > Changes V1 -> V2 [2]:
> >=20
> >   - Rebased over mtdblock v2 patchset [3].
> >   - Compile UBI partitions support only if CONFIG_BLK option
> >     is enabled.
>=20
> Thanks!
>=20
> > - Links:
> >=20
> >    [1] https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@s=
alutedevices.com/
> >    [2] https://lore.kernel.org/all/20240306134906.1179285-1-avromanov@s=
alutedevices.com/
> >    [3] https://lore.kernel.org/all/20240307130726.1582487-1-avromanov@s=
alutedevices.com/
> >=20
> > Alexey Romanov (6):
> >    ubi: allow to read from volume with offset
> >    ubi: allow to write to volume with offset
> >    drivers: introduce UBI block abstraction
> >    disk: don't try search for partition type if already set
> >    disk: support UBI partitions
> >    spinand: bind UBI block
> >=20
> >   cmd/ubi.c                   |  77 +++++++++++++++++++--
> >   disk/part.c                 |   7 ++
> >   drivers/block/blk-uclass.c  |   1 +
> >   drivers/mtd/nand/spi/core.c |   8 ++-
> >   drivers/mtd/ubi/Makefile    |   1 +
> >   drivers/mtd/ubi/block.c     | 130 +++++++++++++++++++++++++++++++++++=
+
> >   drivers/mtd/ubi/part.c      |  99 +++++++++++++++++++++++++++
> >   env/ubi.c                   |  16 ++---
> >   include/part.h              |   2 +
> >   include/ubi_uboot.h         |   8 ++-
> >   10 files changed, 332 insertions(+), 17 deletions(-)
> >   create mode 100644 drivers/mtd/ubi/block.c
> >   create mode 100644 drivers/mtd/ubi/part.c
>=20
> Looks good to me now.
>=20
> @Dario: I saw that series is delegetad to you in patchwork.
>  From my side it is fine. If you think I should  pick it up, please
>  send a Reviewed/Acked-by for the SPI NAND parts, and notify me,
>  thanks!
>=20
> bye,
> Heiko
> --=20
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

--=20
Thank you,
Alexey=
