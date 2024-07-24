Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DDAC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 12:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB481887F5;
	Wed, 24 Jul 2024 14:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="KM7uXiQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE926888A5; Wed, 24 Jul 2024 12:31:30 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C763888F6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9D09E100021;
 Wed, 24 Jul 2024 13:31:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9D09E100021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721817087;
 bh=vg4D6pTJ0cwKiF4S3SWao84rTPVc0JT1KDzE9yTJYn8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=KM7uXiQLceqSLvkjfpWSP9xuPpdMz9WIB0Y51FEiPi3TthiWn7hshW8zUcFCgFSoy
 pwjkO0qKGzEP/9DW4cQxMPldwy9QOJ1UNj4RnTExnRIjBnVLSID1wWr9wG3aF563W+
 Mh9Wj5ztgyn861ef9q0AGL5e1Fcb7yiX4BV4/5Yt2KGsRWMchJz6kBLtGVJbe0k9GF
 awRLhB8G7TLSCFi27AUf9bHrDYb5GT9SDKj6XDUrlLVeLEpUBGRXWePIDMX0QQ8km0
 4oIlgcGseYMAqYujtBJCRu5hlsXOvGGDeL5Eni4m5lj1cMhDWahfCK4o0/qItGJBK9
 tWlmupo2RZ7fA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 24 Jul 2024 13:31:27 +0300 (MSK)
Received: from p-i-exch-a-m1.sberdevices.ru (172.24.196.116) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jul 2024 13:31:27 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 13:31:26 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518%9]) with
 mapi id 15.02.1118.040; Wed, 24 Jul 2024 13:31:26 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Michael Walle <michael@walle.cc>
CC: "dario.binacchi@amarulasolutions.com"
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
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, kernel
 <kernel@sberdevices.ru>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v7 0/3] Introduce mtdblock device
Thread-Index: AQHa2NXQXYourbtGaEyeJouKDxf6ULH9bcMAgAgXeQA=
Date: Wed, 24 Jul 2024 10:31:26 +0000
Message-ID: <20240724103110.dhsla6mekkncaoal@cab-wsm-0029881>
References: <20240718054606.799665-1-avromanov@salutedevices.com>
 <D2TBIZ3HDGMJ.2S5Q1ZYD44D7I@walle.cc>
In-Reply-To: <D2TBIZ3HDGMJ.2S5Q1ZYD44D7I@walle.cc>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A52477187CBABF4B98AE6C3848F3D133@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186694 [Jul 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/24 09:34:00 #26140072
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 24 Jul 2024 14:35:57 +0200
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

Hi Michael,

Sorry for the late reply.

On Fri, Jul 19, 2024 at 08:57:04AM +0200, Michael Walle wrote:
> Hi,
>=20
> > Tested only on SPI NAND, so bind is made only for
> > SPI NAND drivers.
>=20
> If tried to test this with the SPI NOR framework but I couldn't get
> it to work. The SPI NOR flash didn't register with/was found by the
> mtdblock subsystem. I guess that is probably because the SPI NOR
> flash has it's own UCLASS_SPI_FLASH. There is some kind of
> compatibility layer (drivers/mtd/spi/sf_mtd.c) but it doesn't
> register a UCLASS_MTD.
>=20
> Do you have any idea how to get this to work?

I think you have to try bind driver via mtd_bind(), just like
I do for SPI-NAND in patch "spinand: bind mtdblock".

I see what in file drivers/mtd/spi/sf_probe.c there is struct
mtd_info and also you have U_BOOT_DRIVER. Maybe try to bind there?

>=20
> -michael



--=20
Thank you,
Alexey=
