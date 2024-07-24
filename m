Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D5CC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 08:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CF688204;
	Wed, 24 Jul 2024 10:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ceOakncp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8037E887F6; Wed, 24 Jul 2024 10:04:51 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5EC787C80
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 10:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 1D37F100008;
 Wed, 24 Jul 2024 11:04:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1D37F100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721808287;
 bh=4LzMiGhTu3M+5/KxjTXRIwE7jqSP8hGTqgenzu8bfok=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=ceOakncpvD0wZDf+vOutyp+tPqle0pAvVWQrLlSorkWs7ffo8gXhf611hCmbu012Z
 +m5ciQubOGXRzgqNoZQegYDP3gqx16pVAaq9/W6FnrpL9WBr+m5g6Kj8wDq94qm9DL
 srD9RvZ3OyoOkj7mHZuYQ0ULoL1YNhMrdSeWAsp8sO3gm1jyfFo9QWO29Ikh4Nj/d8
 aOgNEdcGRWTd/998q4ydwssK1Qxj8zvEKaVfcLcWuTr0iZ+/f1nccum48jMxtGOXIr
 p9D0PAL02U93XCVhRxEVSmXR/YCCPS8Ca+slddGR6jlym2Vh1s2ltjmeyITy098cZq
 bfRW9rwfUly8Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 24 Jul 2024 11:04:46 +0300 (MSK)
Received: from [172.28.128.200] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jul 2024 11:04:46 +0300
Message-ID: <8d569e2a-15b3-9ce3-f660-635bd683af22@salutedevices.com>
Date: Wed, 24 Jul 2024 10:52:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
Content-Language: en-US
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186693 [Jul 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; lore.kernel.org:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress:
 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/24 07:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/24 07:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/24 05:26:00 #26138188
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

Hi, sorry, pls ping, 2 weeks :)

Thanks

On 08.07.2024 10:13, Arseniy Krasnov wrote:
> Patchset is based on patchset for Linux (today merged to nand-next):
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
> 
> Here is description from it:
> 
>  >  Amlogic's boot ROM code needs that some pages on NAND must be written
>  >  in special "short" ECC mode with scrambling enabled. Such pages:
>  >  1) Contain some metadata about hardware.
>  >  2) Located with some interval starting from 0 offset, until some
>  >     specified offset. Interval and second offset are set in the
>  >     device tree.
>  >  
>  >  This patchset adds R/W support for such pages. To enable it we can setup
>  >  it in dts:
>  >  
>  >      nand-is-boot-medium;
>  >      amlogic,boot-pages = <1024>;
>  >      amlogic,boot-page-step = <128>;
>  >  
>  >  It means that each 128th page in range 0 to 1024 pages will be accessed
>  >  in special mode ("short" ECC + scrambling). In practice this feature is
>  >  needed when we want to update first block of NAND - driver will enable
>  >  required mode by itself using value from device tree.
> 
> The only difference is that patchset for Linux updates DT bindings, while
> this adds NAND_IS_BOOT_MEDIUM flag support.
> 
> Changelog:
>  v1 -> v2:
>  * Pls see per-patch changelog.
> 
> Arseniy Krasnov (3):
>   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>   mtd: rawnand: meson: read/write access for boot ROM pages
> 
>  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>  drivers/mtd/nand/raw/nand_base.c  |  3 ++
>  include/linux/mtd/rawnand.h       |  5 ++
>  3 files changed, 65 insertions(+), 27 deletions(-)
> 
