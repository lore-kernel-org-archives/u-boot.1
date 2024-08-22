Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDBAC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 07:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF0788E36;
	Thu, 22 Aug 2024 09:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="CzH+6wjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0279C88C10; Thu, 22 Aug 2024 09:04:24 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E4788EB2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 09:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B9926100055;
 Thu, 22 Aug 2024 10:04:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B9926100055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1724310256;
 bh=19OmqDSyqgbVOLYzeR1gzKBZjdVBsPgEtTyen6I4t/U=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=CzH+6wjCNU1qVny+GPaaU1OXscbUDyxaSODRlJxx6P2Yw5HGWmVnQQPsU4kAPz3dF
 pLau5GGqnclr5kz0fGwwhLWXIDEYbFxRKuVVwYD2pnSYeksef7zKbAT4pxohuIAxY6
 dF1nmkSvYhHi2mgvWSTb4zPsoWvjtGbvr/91iMVwgp8M3be9ZunJi4nyFKrFp/urTq
 PkzoQO5Nu9PzsFKtHKVeQKSBKvX4Nd33x6xkkC3flUkKUMPrWTbg+Fes5ihSc0ASqw
 K660GMPorpPtpE1jmC4HCroMJQCX3wKGbyRWQUJinBTCXbporqjZ2NLROZH5sUN6S2
 Bb7ubtdCnUorw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 22 Aug 2024 10:04:16 +0300 (MSK)
Message-ID: <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
Date: Thu, 22 Aug 2024 09:51:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
Content-Language: en-US
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "Tom
 Rini" <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, U-Boot-Denx
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, kernel
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.28.161.232]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187224 [Aug 22 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains},
 {Tracking_arrow_http, text}, {Tracking_from_domain_doesnt_match_to},
 salutedevices.com:7.1.1; lore.kernel.org:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/22 04:17:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/22 04:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/08/22 05:50:00 #26411090
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi, thanks!

Thanks, Arseniy

On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> I will read them tomorrow ;)
> 
> Thank you for understanding
> 
> Michael
> 
> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
> scritto:
> 
>> Hi, sorry, pls ping  😄
>>
>> Thanks
>>
>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
>>> Patchset is based on patchset for Linux (today merged to nand-next):
>>>
>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
>>>
>>> Here is description from it:
>>>
>>>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>>>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>>>  >  1) Contain some metadata about hardware.
>>>  >  2) Located with some interval starting from 0 offset, until some
>>>  >     specified offset. Interval and second offset are set in the
>>>  >     device tree.
>>>  >
>>>  >  This patchset adds R/W support for such pages. To enable it we can
>> setup
>>>  >  it in dts:
>>>  >
>>>  >      nand-is-boot-medium;
>>>  >      amlogic,boot-pages = <1024>;
>>>  >      amlogic,boot-page-step = <128>;
>>>  >
>>>  >  It means that each 128th page in range 0 to 1024 pages will be
>> accessed
>>>  >  in special mode ("short" ECC + scrambling). In practice this feature
>> is
>>>  >  needed when we want to update first block of NAND - driver will
>> enable
>>>  >  required mode by itself using value from device tree.
>>>
>>> The only difference is that patchset for Linux updates DT bindings, while
>>> this adds NAND_IS_BOOT_MEDIUM flag support.
>>>
>>> Changelog:
>>>  v1 -> v2:
>>>  * Pls see per-patch changelog.
>>>
>>> Arseniy Krasnov (3):
>>>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>>>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>>>   mtd: rawnand: meson: read/write access for boot ROM pages
>>>
>>>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>>>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
>>>  include/linux/mtd/rawnand.h       |  5 ++
>>>  3 files changed, 65 insertions(+), 27 deletions(-)
>>>
>>
> 
