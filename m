Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF2C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 13:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0C287EAF;
	Fri,  1 Mar 2024 14:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ok+iCO0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6278814A; Fri,  1 Mar 2024 14:42:48 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEE587808
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 14:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 168F11000D7;
 Fri,  1 Mar 2024 16:42:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 168F11000D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1709300566;
 bh=S2Tc6nE2oEO56wflp7eSChxmNxeQluVxvcaQ7N498dM=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=ok+iCO0yFrZ6l51Ch2v/jFTvpJBhlvLk3Hgm4H66PbwSDltuexTqv0xxaCLnpu4UN
 Kk2mKGz4viE1gaKPE3XoBufmDdQTBxXA77pFs4QpKdwQ3Y4CZ4GjW4kLSPMpFLD4vk
 j0G0U0te8/nvSQjkSQVNeOpHnTtHTc2eSDcsxaCBr1sutJy6cGnsiXiOxdqDlUlPjC
 TJkBx83L50d6PYrql6k5H1V2sDiGpxWJna/0AggJUJdRWrSfzMT0P10aKSrQYUBMo+
 pxyw7482iHMNxrZ+pgMMF+Bef+UOpA0awQKy9iluElZN308koMCHvfw0vGOkORGbA1
 v/07ciFzeQWKA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri,  1 Mar 2024 16:42:45 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:42:45 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with
 mapi id 15.02.1118.040; Fri, 1 Mar 2024 16:42:45 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, "bmeng@tinylab.org"
 <bmeng@tinylab.org>, "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "michal.simek@amd.com" <michal.simek@amd.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, kernel
 <kernel@sberdevices.ru>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/4] Introduce mtdblock device
Thread-Topic: [PATCH v1 0/4] Introduce mtdblock device
Thread-Index: AQHaaWRoW9wzhSiDc0OOvYc4t7P69LEg08cA/MfFUgA=
Date: Fri, 1 Mar 2024 13:42:45 +0000
Message-ID: <20220922220252.2r5ldxs626lqiwos@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <985f8309-7622-40fe-9352-36cdf7853556@kontron.de>
In-Reply-To: <985f8309-7622-40fe-9352-36cdf7853556@kontron.de>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32614EA9A4A6B643B67468C4AE223B1C@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Fri, 01 Mar 2024 14:48:40 +0100
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

Hi Frieder,

On Thu, Feb 29, 2024 at 09:51:04AM +0100, Frieder Schrempf wrote:
> Hi Alexey,
>=20
> On 27.02.24 11:04, Alexey Romanov wrote:
> > Hello!
> >=20
> > This series adds support for the mtdblock device, which
> > allows to read/write data block by block. For example,
> > it can now be used for BCB or Android AB command:
> >=20
> >   $ bcb load mtd 0 part_name
> >=20
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers.
>=20
> I don't know much about Android, but as far as I understand you are
> trying to store dynamic, boot-related information on the MTD device.
>=20
> This might be acceptable if the underlying device is a NOR flash, but
> for any type of NAND device it sounds like a rather bad idea.
>=20
> NAND devices need some kind of FTL (flash translation layer) in order to
> work reliably. Using a block filesystem directly on the NAND MTD device
> will cause problems as soon as any bad blocks or bit flips occur.
>=20
> People are therefore discouraged to use mtdblock on NAND and in the
> kernel there is even a warning if you try to mount a NAND mtdblock
> partition.

You are completely right. But, unfortunately, these are legacy ones that
need to be supported. On some boards this approach was chosen a long
time ago and mistakenly, so I think we need to support this for NAND.

>=20
> Maybe you should reconsider this and look into how to use UBIFS as a
> FTL. On the other hand I'm not quite sure if the UBIFS layer in U-Boot
> is really stable and maintained. So this might not be a good idea either.

Yeah, on our new boards we switched to using UBI, and we already have=20
an implementation UBI block device for U-Boot. Will send this to
mailing list in the near future.

>=20
> Anyway, I'm against implementing mtdblock for SPI NAND (or any other NAND=
).

Maybe we'll just add warning like it's done in the Linux?

>=20
> Best regards
> Frieder

--=20
Thank you,
Alexey=
