Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C4DC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 08:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D91A88641;
	Fri, 23 Aug 2024 10:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="rk9Bj1O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D8388641; Fri, 23 Aug 2024 10:42:00 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0F788754
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 10:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 77747100002;
 Fri, 23 Aug 2024 11:41:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 77747100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1724402517;
 bh=O5i5UG9ZaMsJlU6oO9qcoHI+IujwSXRUo0F3r6nzovw=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=rk9Bj1O5eZ79aFsNTavScAu58ktkwn+Ry6FouMQ44yhqqn8B2rmMl+zR17ko1D6pj
 vGshBHws/qTkPN9A4ow6pzyR9f4lsXB2D9ZtKN+OkuI5u/qUmHUFWdlbwMgAZryoP2
 SgIKmG5P2sjHrw0XkEycnBHvzijtAx62AOBxARh8D24c89YbhwCRwTT8PGVQFBxPTZ
 oXiAfPpGbH+s7WVUkXKK3zVOJtujLtBB0qMx6PE9dMyhGKvmXFWZK7ZyDGsdG2U8fC
 m/2uJJVIsQup8qDKoY9EUAzPxXN5wC871RoFU9O58UcR6C8Ip9jWyFGtV25oGvgE1z
 fwo4wPlZnZI7g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 23 Aug 2024 11:41:57 +0300 (MSK)
Message-ID: <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
Date: Fri, 23 Aug 2024 11:29:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "Tom
 Rini" <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, U-Boot-Denx
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>, kernel
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
 <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
Content-Language: en-US
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [77.220.140.242]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187254 [Aug 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27
 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_uf_ne_domains},
 {Tracking_arrow_http, text}, {Tracking_from_domain_doesnt_match_to},
 127.0.0.199:7.1.2; salutedevices.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/23 08:06:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/23 08:07:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/08/22 23:06:00 #26414143
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

Hi! Got it, thanks!

On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
> Hi Arseniy
> 
> On Thu, Aug 22, 2024 at 9:04 AM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Hi, thanks!
>>
>> Thanks, Arseniy
>>
>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
>>> Hi
>>>
>>> I will read them tomorrow ;)
>>>
>>> Thank you for understanding
>>>
> 
> All the series are delegated to Neil. I will review anyway but I think
> that will then pick from him
> 
> Michael
> 
>>> Michael
>>>
>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
>>> scritto:
>>>
>>>> Hi, sorry, pls ping  😄
>>>>
>>>> Thanks
>>>>
>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
>>>>> Patchset is based on patchset for Linux (today merged to nand-next):
>>>>>
>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
>>>>>
>>>>> Here is description from it:
>>>>>
>>>>>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>>>>>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>>>>>  >  1) Contain some metadata about hardware.
>>>>>  >  2) Located with some interval starting from 0 offset, until some
>>>>>  >     specified offset. Interval and second offset are set in the
>>>>>  >     device tree.
>>>>>  >
>>>>>  >  This patchset adds R/W support for such pages. To enable it we can
>>>> setup
>>>>>  >  it in dts:
>>>>>  >
>>>>>  >      nand-is-boot-medium;
>>>>>  >      amlogic,boot-pages = <1024>;
>>>>>  >      amlogic,boot-page-step = <128>;
>>>>>  >
>>>>>  >  It means that each 128th page in range 0 to 1024 pages will be
>>>> accessed
>>>>>  >  in special mode ("short" ECC + scrambling). In practice this feature
>>>> is
>>>>>  >  needed when we want to update first block of NAND - driver will
>>>> enable
>>>>>  >  required mode by itself using value from device tree.
>>>>>
>>>>> The only difference is that patchset for Linux updates DT bindings, while
>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
>>>>>
>>>>> Changelog:
>>>>>  v1 -> v2:
>>>>>  * Pls see per-patch changelog.
>>>>>
>>>>> Arseniy Krasnov (3):
>>>>>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>>>>>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>>>>>   mtd: rawnand: meson: read/write access for boot ROM pages
>>>>>
>>>>>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>>>>>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
>>>>>  include/linux/mtd/rawnand.h       |  5 ++
>>>>>  3 files changed, 65 insertions(+), 27 deletions(-)
>>>>>
>>>>
>>>
> 
> 
> 
