Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30408C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6E087DC2;
	Wed, 14 Feb 2024 13:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="BJcZz/jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A71487DE3; Wed, 14 Feb 2024 09:39:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A6587DE6
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 09:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9E151100034;
 Wed, 14 Feb 2024 11:39:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9E151100034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1707899974;
 bh=saukfLdNBtB+ROItL7ANJ6zRXjkh1/XJo7Io9M/RweM=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=BJcZz/jzfGWNJER5Cv3ZgPQ0KdkUiempBW3Nkzk7hWwCAg1F/Pu1yY7ChXdh/1UZy
 Stbu32QLm+KxgVNZKaROOkO3BIEeAAUzJm/fTd7c0d1Zco5/wLltfsETbh1J33dfCo
 B26tK/7bd8AuoXas22Jwbi2GpIyKHZZ+MTKaBBS/sK8fjkvmDE679gUWA+E+CPrWap
 M0wXVGg//kec17kaNtfD9/9BHozuzcmrr3MsiU9ySFzkjZbpDP1P+UkaqEZcqerZ6Z
 sTXB1CHwo4RUYMpnVdcihRM3Knuma4VJccz7uoE6PmJxMRoNlkK+tapGB6E0MUMpL4
 S/b/E9cWaya2w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 14 Feb 2024 11:39:34 +0300 (MSK)
Received: from p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 14 Feb 2024 11:39:34 +0300
Received: from p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1]) by
 p-i-exch-sc-m01.sberdevices.ru ([fe80::6d41:e8f1:b95e:ba1%7]) with
 mapi id 15.02.1118.040; Wed, 14 Feb 2024 11:39:34 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "hs@denx.de" <hs@denx.de>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>, "dimorinny@google.com"
 <dimorinny@google.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "patrick.delaunay@foss.st.com"
 <patrick.delaunay@foss.st.com>
CC: kernel <kernel@sberdevices.ru>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v2 0/2] Introduce fastboot oem board command
Thread-Topic: [RFC PATCH v2 0/2] Introduce fastboot oem board command
Thread-Index: AQHaVO/pE+Z+TvMoTk66BBpFWW2rqbEJZncA
Date: Wed, 14 Feb 2024 08:39:33 +0000
Message-ID: <20240214083926.3xrdf7hhjkfbgh75@cab-wsm-0029881>
References: <20240201092027.6258-1-avromanov@salutedevices.com>
In-Reply-To: <20240201092027.6258-1-avromanov@salutedevices.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FD5DC1639753C43946B99E769359D17@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183422 [Feb 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/14 06:40:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/14 06:40:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/02/14 04:43:00 #23596813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 14 Feb 2024 13:42:37 +0100
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

On Thu, Feb 01, 2024 at 12:20:25PM +0300, Alexey Romanov wrote:
> Changes v2 since v1 at [1]:
>     - Added an example of using the command as requsted
>       by Sean Anderson [2].
>=20
> Links:
>     [1] https://lore.kernel.org/all/20231228152522.83291-1-avromanov@salu=
tedevices.com/
>     [2] https://lore.kernel.org/all/72ac233d-c18d-4f57-bc66-451fe0bd2997@=
seco.com/
>=20
> Alexey Romanov (2):
>   fastboot: introduce 'oem board' subcommand
>   board: ad401: example of fastboot oem board realization
>=20
>  board/amlogic/ad401/fastboot.c | 222 +++++++++++++++++++++++++++++++++
>  drivers/fastboot/Kconfig       |   7 ++
>  drivers/fastboot/fb_command.c  |  15 +++
>  include/fastboot.h             |   1 +
>  4 files changed, 245 insertions(+)
>  create mode 100644 board/amlogic/ad401/fastboot.c
>=20
> --=20
> 2.30.1
>=20

--=20
Thank you,
Alexey=
