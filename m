Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6DFCD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 13:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34A8881B0;
	Wed, 10 Apr 2024 15:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="nH5TnBSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17128772A; Wed, 10 Apr 2024 14:43:07 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9A5879A0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7B29F100071;
 Wed, 10 Apr 2024 15:43:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7B29F100071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712752983;
 bh=wIG6Sfcs+2bFhS0W3UmnD8Y+HJ7BexsThDoNgCm73hU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=nH5TnBSb7Ro/TqU8NKf5u7vex0+qyz/bizDQRd/pYZHmdpkz1cIrGjf7TQWRcle52
 bOB0Eq+53g3/ADeUSNKT0+LCjLfcg5wE0xY4tRWa5pUgvaEgoGrd7FQv65+MNiceif
 QzlnIGZKCKi+kjab2prodJpR/b9P3WVGIkhsyn3QztSHedIFSPYDY3CA9AnI8C53sO
 9syDhsPnXEf3uFXcRSvVw8c+WWNeNVqOXXf+ZdXtBdz2yWyuV1NjtGqadR3PDJZ5p7
 Ld9esm4adyiwThSfrGxEpkanr9auDrh0qvi1HL7X/h7s7fo36ey7s5iEeB37gn5Rud
 J4awUHyACkHUw==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 10 Apr 2024 15:43:03 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 15:43:02 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Wed, 10 Apr 2024 15:43:02 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
Thread-Topic: [PATCH v4 1/1] fastboot: introduce 'oem board' subcommand
Thread-Index: AQHaizX/1A9erjw9rEuSh9/cxo0mpbFhNSuAgAALWIA=
Date: Wed, 10 Apr 2024 12:43:02 +0000
Message-ID: <20240410124257.3zc673n2jb3msiep@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240410105804.22757-1-avromanov@salutedevices.com>
 <20240410105804.22757-2-avromanov@salutedevices.com>
 <20917bf6-2be2-4a1f-8c87-a69a2241d1fc@theobroma-systems.com>
In-Reply-To: <20917bf6-2be2-4a1f-8c87-a69a2241d1fc@theobroma-systems.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F255A55CB9D63F4F8C21C15FAE18746C@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184652 [Apr 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16
 6e64c33514fcbd07e515710c86ba61de7f56194e, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/10 11:03:00 #24738255
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 10 Apr 2024 15:04:14 +0200
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

Hi guys,

On Wed, Apr 10, 2024 at 02:02:21PM +0200, Quentin Schulz wrote:
> Hi Alexey,
>=20
> On 4/10/24 12:58, Alexey Romanov wrote:
> > Currently, fastboot protocol in U-Boot has no opportunity
> > to execute vendor custom code with verifed boot. This patch
> > introduce new fastboot subcommand fastboot oem board:<cmd>,
> > which allow to run custom oem_board function.
> >=20
> > Default implementation is __weak. Vendor must redefine it in
> > board/ folder with his own logic.
> >=20
> > For example, some vendors have their custom nand/emmc partition
> > flashing or erasing. Here some typical command for such use cases:
> >=20
> > - flashing:
> >=20
> >    $ fastboot stage bootloader.img
> >    $ fastboot oem board:write_bootloader
> >=20
> > - erasing:
> >=20
> >    $ fastboot oem board:erase_env
> >=20
> > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > ---
> >   doc/android/fastboot.rst      | 18 ++++++++++++++++++
> >   drivers/fastboot/Kconfig      |  7 +++++++
> >   drivers/fastboot/fb_command.c | 30 ++++++++++++++++++++++++++++++
> >   include/fastboot.h            |  1 +
> >   4 files changed, 56 insertions(+)
> >=20
> > diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> > index 1ad8a897c8..2a627f9890 100644
> > --- a/doc/android/fastboot.rst
> > +++ b/doc/android/fastboot.rst
> > @@ -29,6 +29,7 @@ The following OEM commands are supported (if enabled)=
:
> >     with <arg> =3D boot_ack boot_partition
> >   - ``oem bootbus``  - this executes ``mmc bootbus %x %s`` to configure=
 eMMC
> >   - ``oem run`` - this executes an arbitrary U-Boot command
> > +- ``oem board`` - this executes a custom board function which is defin=
ed by the vendor
> >   Support for both eMMC and NAND devices is included.
> > @@ -245,6 +246,23 @@ including multiple commands (using e.g. ``;`` or `=
`&&``) and control structures
> >   (``if``, ``while``, etc.). The exit code of ``fastboot`` will reflect=
 the exit
> >   code of the command you ran.
> > +Running Custom Vendor Code
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +U-Boot allows you to execute custom fastboot logic, which can be defin=
ed
> > +in board/ files. It can still be used for production devices with veri=
fied
> > +boot, because the vendor define logic at compile time by implementing
>=20
> I think it should be "defines" here?

Yep. If there are no more comments, maybe Mattijs will correct this when
he picks up a patch? So that I don't send a new series with typo fix :)

>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> Thanks,
> Quentin

--=20
Thank you,
Alexey=
