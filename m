Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD98C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC1F86F4F;
	Wed, 15 Nov 2023 11:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700045260;
	bh=jEgYYLpBd1n7h+jhpOz/Cs06UhaCgz/u48LSlqaem58=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wzZJQ+6z6gTi6I2ZE2Zp/l+3eIm6gwFGzFDT4gsJKLWxpwHaSbKJLT3QyRemvSwe/
	 VOMAH1JO5tJSJ+LP/7K/1QnFJYNI6y3qZaYw7wstTSxc2CSkRm37p8tdm47i1htdqE
	 xt3VlZSuTsoN70nKd6nSjEMHveS0/a9JWUAGz9H6q3SsB6Sb7IBw+oWymv4tSO7CdM
	 rhFqFPq0S1psZsr9qAA16R9aVReQ4cL8siOzbW9tgB0AMK7K2YO+0k8+BGBL22YKFF
	 lpuXyixcIhRASfDYIOTz2MWR7iVkt/HCx7GmC7cqwOudH9rYDjkxb7cy/k3di0T7vR
	 eFZQO3e+bGh+Q==
Received: from [192.168.1.107] (82-131-157-239.pool.digikabel.hu
 [82.131.157.239])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4A2F9804CE;
 Wed, 15 Nov 2023 11:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700045258;
 bh=jEgYYLpBd1n7h+jhpOz/Cs06UhaCgz/u48LSlqaem58=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QryTSGG1gOJfKAaTBmxvoPKAa12nLpeoDyAX7qRdCTdyK9OaVa4XYio2JS45yDJ5i
 hvj4jueBA6lAGKNCWRBD7uXE1hXBKr9ubhcLwnJEUVc8BUomSRNFsXN92Z/jOn+dkb
 ZC3e7hikh4kFtW7ECqhEU89aJSL4g9YCgoSDR0vOsmRxXJl6IZRDubRJpknvHndWce
 aGxkTod/olz6+FoLCp94LZo19MF6BUYzOzNlqh9bYEekpPKwbqsX/0I7yOkvsa0tdk
 /JN0lmelomC6gXzQzBKLn3EjGAe7kTTB10vLd+oYGD27L30+806QJzca2rSIcPk/uQ
 w7e867ZZVxAWA==
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>, Roger Quadros <rogerq@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
References: <20231115054044.3937543-1-hs@denx.de>
 <AM7PR10MB37364EB893AFCEC4765D42DFFFB1A@AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM>
 <CAOf5uwkA2jSjXj9hrcB8YqEyP6HmJx76KZ6xvy7b-6XrO8aCfw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <7e8ee3fa-5f97-7d28-3985-5139f9bb67e1@denx.de>
Date: Wed, 15 Nov 2023 11:47:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOf5uwkA2jSjXj9hrcB8YqEyP6HmJx76KZ6xvy7b-6XrO8aCfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michael,

On 15.11.23 11:38, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Wed, Nov 15, 2023 at 11:37 AM Leto, Enrico <enrico.leto@siemens.com> wrote:
>>
>> Patch is working by me.
>>
>>> -----Original Message-----
>>> From: Heiko Schocher <hs@denx.de>
>>> Sent: Wednesday, November 15, 2023 6:41 AM
>>> To: U-Boot Mailing List <u-boot@lists.denx.de>; Leto, Enrico (SI BP R&D ZG FW
>>> CCP) <enrico.leto@siemens.com>
>>> Cc: Schocher, Heiko (EXT) (DENX Software Engineering GmbH) <hs@denx.de>;
>>> Dario Binacchi <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
>>> <michael@amarulasolutions.com>
>>> Subject: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
>>>
>>> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based
>>> correction")
>>>
>>> broke AM335x based boards booting from NAND with ECC BCH8 code.
>>>
>>> Use omap_enable_hwecc() instead of omap_enable_hwecc_bch() in SPL
>>> restores correct SPL nand_read_page functionality.
>>>
>>> Tested on draco thuban board.
>>>
>>> Signed-off-by: Heiko Schocher <hs@denx.de>
>>>
>>> ---
>>> fix NAND boot for BCH8 based TI AM335x boards
>>>
>>> Fix is based on series from Enrico:
>>>
> 
> We need test the boards that Roger add here.

Thanks!

Are this AM335x based boards booting from NAND ?

bye,
Heiko
> 
> Michael
> 
>>> https://lists.d/
>>> enx.de%2Fpipermail%2Fu-boot%2F2023-
>>> November%2F536793.html&data=05%7C01%7Cenrico.leto%40siemens.com
>>> %7Cbd939f15167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab4
>>> 2e1495d55a%7C1%7C0%7C638356236545245361%7CUnknown%7CTWFp
>>> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
>>> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=IUqjryYUtp%2Fdm9GgCALPTl8f%
>>> 2BlcrO0ErXjkvoDwz7v4%3D&reserved=0
>>>
>>> and fixes NAND boot for the draco thuban board. But this patch apply also
>>> without the patches from above patchseries, see azure build:
>>>
>>> https://dev.a/
>>> zure.com%2Fhs0298%2Fhs%2F_build%2Fresults%3FbuildId%3D111%26vie
>>> w%3Dresults&data=05%7C01%7Cenrico.leto%40siemens.com%7Cbd939f15
>>> 167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab42e1495d55a%
>>> 7C1%7C0%7C638356236545245361%7CUnknown%7CTWFpbGZsb3d8eyJ
>>> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>>> %7C3000%7C%7C%7C&sdata=S2itRHsR49lD9TlBexYw9J5waXiuFcS%2BhUp
>>> %2B7Yi60MA%3D&reserved=0
>>>
>>> which is clean.
>>>
>>> Above commit seems to change only U-Boot code and did not adapt
>>> am335x_spl_bch.c, which breaks nand_read_page in SPL code for AM335x
>>> based boards. So use in SPL "old" hw setup and reading page from NAND in
>>> SPL works again.
>>>
>>>
>>>  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/raw/omap_gpmc.c
>>> b/drivers/mtd/nand/raw/omap_gpmc.c
>>> index 1a5ed0de31..c9b66dadbd 100644
>>> --- a/drivers/mtd/nand/raw/omap_gpmc.c
>>> +++ b/drivers/mtd/nand/raw/omap_gpmc.c
>>> @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct
>>> nand_chip *nand,
>>>               nand->ecc.strength      = 8;
>>>               nand->ecc.size          = SECTOR_BYTES;
>>>               nand->ecc.bytes         = 14;
>>> +#if defined(CONFIG_SPL_BUILD)
>>> +             nand->ecc.hwctl         = omap_enable_hwecc;
>>> +#else
>>>               nand->ecc.hwctl         = omap_enable_hwecc_bch;
>>> +#endif
>>>               nand->ecc.correct       = omap_correct_data_bch;
>>>               nand->ecc.calculate     = omap_calculate_ecc_bch;
>>>               nand->ecc.read_page     = omap_read_page_bch;
>>> --
>>> 2.37.3
>>
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
