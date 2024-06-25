Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A94C2BBCA
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 01:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B891C8844F;
	Wed, 26 Jun 2024 03:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="QB7ppxMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9BD88499; Tue, 25 Jun 2024 14:48:42 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6834688496
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id A92C2120009;
 Tue, 25 Jun 2024 15:48:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A92C2120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719319718;
 bh=y7qh1Q4sqKNTck3lf5j5jzGUG/I5LLU8TSu48Q1siFQ=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=QB7ppxMTYyuGCLXamoI4H4/bbA6fZ16ptm5gzZGT6obyu7dSnRwjXzw5gIngD2sx2
 NGimJ02T+YIXTe4kyRTqPJOqbPfJPlPpjHGdvDAwPv/U8eSeIQOJdEJmi46MG2uuXr
 b0U0aNigFjzqbjuDs1AZL1gdZw3LVkgFkAgUeaY12iAPiSc5gUTbGUt7ljY4Mgkm8Q
 7gRqjv+PNREFeF8ZhUPuBDdWZrA0h02Kf+4OflkUr7VP3QU5QomF1BeqxsOkC7cksX
 a2YZOzg6DBvReLPrdj+hV0z54t+JlCDvSoDGNLGzkXEV1DfnzIVY+WSw+LGGFChYG1
 kgFGpldrLX3dQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 25 Jun 2024 15:48:38 +0300 (MSK)
Received: from p-i-exch-a-m1.sberdevices.ru (172.24.196.116) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 25 Jun 2024 15:48:38 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 25 Jun 2024 15:48:37 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518%9]) with
 mapi id 15.02.1118.040; Tue, 25 Jun 2024 15:48:37 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt
 <jpewhacker@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Kever
 Yang" <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Michal Simek
 <michal.simek@amd.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, Patrice Chotard
 <patrice.chotard@foss.st.com>, kernel <kernel@sberdevices.ru>, "U-Boot
 Mailing List" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v5 0/3] Introduce mtdblock device
Thread-Index: AQHatc6zqVAL1cVPUECQBY+Z/hNaPLG4PgcAgACE8ACAADSVAIAfZoQA
Date: Tue, 25 Jun 2024 12:48:37 +0000
Message-ID: <20240625124832.nrwip43boybt44hc@cab-wsm-0029881>
References: <20240603155702.1840464-1-avromanov@salutedevices.com>
 <CAFLszTi+ONdb2P5gtSX_OMUD162G7OtRMD-LbmzO7xuNLRX_HQ@mail.gmail.com>
 <20240605100922.er7xwi5wadaa5dlk@cab-wsm-0029881>
 <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
In-Reply-To: <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <170676F6B9C35043B04FB70B657DC8F3@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186124 [Jun 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/25 02:33:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/25 02:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/25 09:29:00 #25697523
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 26 Jun 2024 03:59:08 +0200
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

Hi Simon,

On Wed, Jun 05, 2024 at 07:17:34AM -0600, Simon Glass wrote:
> Hi Alexey,
>=20
> On Wed, 5 Jun 2024 at 04:09, Alexey Romanov <avromanov@salutedevices.com>=
 wrote:
> >
> > Hi Simon,
> > your message is empty.
> >
> > On Tue, Jun 04, 2024 at 08:13:34PM -0600, Simon Glass wrote:
> > > Hi Alexey,
> > >
> > > On Mon, Jun 3, 2024, 09:57 Alexey Romanov <avromanov@salutedevices.co=
m>
> > > wrote:
> > >
> > > > Hello!
> > > >
> > > > This series adds support for the mtdblock device, which
> > > > allows to read/write data block by block. For example,
> > > > it can now be used for BCB or Android AB command:
> > > >
> > > >   $ bcb load mtd 0 part_name
> > > >
> > > > Tested only on SPI NAND, so bind is made only for
> > > > SPI NAND drivers.
> > > >
> > > > ---
> > > >
> > > > Changes V1 -> V2 [1]:
> > > >
> > > >   - Drop patch [2].
> > > >   - Add warning if bind NAND mtdblock device.
> > > >   - Move documentation of mtdblock implementation
> > > >     from commit message to the source code.
> > > >   - Remove __maybe_unused from mtd partition functions
> > > >     description.
> > > >   - Use blk_enabled() instead of #ifdefs.
> > > >
> > > > Changes V2 -> V3 [2]:
> > > >
> > > >   - Rebased over [3].
> > > >   - Rename mtd_bread/bwrite -> mtd_blk_read/write.
> > > >   - Fix GPL-2.0 license short name definiton in headers.
> > > >   - Add empty line after MTD_ENTRY_NUMBERS define.
> > > >
> > > > Changes V3 -> V4 [4]:
> > > >
> > > >   - Fix build warnings: use LBAF printf format string for lbaint_t =
types.
> > > >
> > > > Changes V4 -> V5 [5]:
> > > >
> > > >   - Rebased over u-boot/master.
> > > >   - Fix build errors and warnings if CONFIG_BLK isn't enabled.
> > > >   - Fix failed tests in cases is mtdblock device isn't binded.
> > > >
> > > > Links:
> > > >
> > > >   - [1]
> > > > https://lore.kernel.org/all/20240227100441.1811047-1-avromanov@salu=
tedevices.com/
> > > >   - [2]
> > > > https://lore.kernel.org/all/20240227100441.1811047-5-avromanov@salu=
tedevices.com/
> > > >   - [3]
> > > > https://lore.kernel.org/u-boot/20240403114047.84030-1-heinrich.schu=
chardt@canonical.com/T/#u
> > > >   - [4]
> > > > https://lore.kernel.org/all/20240404105813.1520732-1-avromanov@salu=
tedevices.com/
> > > >   - [5]
> > > > https://lore.kernel.org/all/20240524102920.2631731-1-avromanov@salu=
tedevices.com/
> > > >
> > > > Alexey Romanov (3):
> > > >   disk: support MTD partitions
> > > >   drivers: introduce mtdblock abstraction
> > > >   spinand: bind mtdblock
> > > >
> > > >  disk/part.c                 |   3 +-
> > > >  drivers/block/blk-uclass.c  |   1 +
> > > >  drivers/mtd/Kconfig         |   1 +
> > > >  drivers/mtd/Makefile        |   1 +
> > > >  drivers/mtd/mtdblock.c      | 227 ++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/mtd/mtdpart.c       |  76 ++++++++++++
> > > >  drivers/mtd/nand/spi/core.c |  20 ++++
> > > >  include/linux/mtd/mtd.h     |  21 ++++
> > > >  include/part.h              |   3 +
> > > >  9 files changed, 352 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/mtd/mtdblock.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
>=20
> Are you able to add a sandbox test for this code?

I think no. mtd/ubi block devices at the moment binds
to real SPI NAND devices, which makes it impossible and useless=20
to test it with sandbox.

>=20
> Regards,
> Simon

--=20
Thank you,
Alexey=
