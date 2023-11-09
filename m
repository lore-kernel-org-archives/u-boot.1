Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6639EC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9811387138;
	Thu,  9 Nov 2023 14:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699537738;
	bh=uJZkHaaUanslXwlk5migqWMee5tP4Apt+Z5Dfn2WKC0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=eY3YJq+yLmCLAMILXvC2aHPCFkoTycZ7n1Mcu6ocPPQd8j7e3fln7Bz36mpAq6zs+
	 2Q/YCMVKkAgCVtijKrgiahNHcfrM0tz/xTA8trCKNmYYnAKjX+V29T4fdYXe47KtsH
	 Idxq3NHoOn5T6iOifgjdhn30KIrGghg1/7ZecKWqQw3jfJcM0syaLEqdGY2jo7k48k
	 1vAGBVObjxytccW4eYXsOCG0Y1uiLh8f6oQ044XsSu0rl71SSrzjci8ABCneT6u4dD
	 eWDCKTJFFy+XtX1H4h5v/iRJ+IEAVNRQdWPDRlOXdVeWMmaV8OS+3E61Uyk98k8RK5
	 T8VVgqyqXqE5Q==
Received: from [192.168.1.107] (82-131-203-152.pool.digikabel.hu
 [82.131.203.152])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 88A75870DF;
 Thu,  9 Nov 2023 14:48:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699537738;
 bh=uJZkHaaUanslXwlk5migqWMee5tP4Apt+Z5Dfn2WKC0=;
 h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
 b=mxdzSyQ+iKTa/7bWbmTTwUWUso3nMM1KMYE8jmdOyKOhldsIshX/uZk8SYW9iZB5x
 6/B2sKXcsRE0/cJLj11IIERihO/wC3UHct+wTILGBAkrRYHuKXv1UhHtFLqBdEH6kW
 06JBitarwfoWoEwXriXOfzhb5s1pHrwelWsVSekxguwcRgvzpvxWwln+OwQoXFiE4S
 +vGRQsqv6fif2Ggo2YgDentfsbXFh97R6d1vn1Kr+3e3500mACxNm+bEKh0zABSOD+
 y8PMNONDvY8kjd1ZyBZHzv2J72b5cAppWFO2CR3vpP3jVBHD1JbVIFxZjjN26QH16y
 StfTsIrDrZ6qw==
Subject: Re: [PATCH 0/6] siemens,am335x: clean up the draco board family
To: Tom Rini <trini@konsulko.com>, Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
 <20231108161137.GP6601@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
Message-ID: <7515c281-9e07-b836-9f19-0fce4f504ba1@denx.de>
Date: Thu, 9 Nov 2023 14:48:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231108161137.GP6601@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hello Tom,

On 08.11.23 17:11, Tom Rini wrote:
> On Wed, Nov 08, 2023 at 03:53:16PM +0100, Enrico Leto wrote:
> 
>> The boards were not maintained upstream since the development phase.
>>
>> Restore SPL and remove unused settings. We need i2c to read the DDR
>> settings from EEPROM, get u-boot from NAND, the console output and the
>> watchdog.
>>
>> Restore u-boot up to the user prompt. The complete functionality will
>> be restored in future patches.
>>
>> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
> 
> I'm glad to see this series and in general it looks fine and is a good
> start. As some parts of the future cleanup work I'd love to see a file
> under doc/board/siemens for the family and moving to plain text
> environment, both of which iot2050 do so there's some in-house
> experience I am hopeful you can leverage as well if needed. It would
> also be good to reduce the include/configs/ files to as little as
> possible, I believe there's a number of dead-comments there, and other
> defines that are only needed in a local context and can move to a
> specific file or other header.  Thanks!

Yep, good points!

I tried this patchset on my dxr2 thuban board, and see a problem when
booting from NAND.

SPL fails to load u-boot.img (wrong ecc calculation)

reverting commit:

commit 04fcd2587321: ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")

from Roger Quadros <rogerq@kernel.org> (as for this reason added to cc)

and SPL/U-Boot 2023.10 comes up fine with Enricos patchset!

remark: for plain U-Boot 2023.10 even SPL does not boot, so Enricos
  patchset is a big step in getting back a working board again, thanks!

So first, I wonder, if there is any am335x based board booting from
NAND with the above commit in?


If the above commit is in U-Boot, the following patch helps also
to get this board back booting:
"""
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 1a5ed0de31..d1c73b389c 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -644,7 +644,11 @@ static int omap_correct_data_bch(struct mtd_info *mtd, uint8_t *dat,

        /* check calculated ecc */
        for (i = 0; i < ecc->bytes && !ecc_flag; i++) {
+#ifdef CONFIG_SPL_BUILD
+               if (calc_ecc[i] != read_ecc[i])
+#else
                if (calc_ecc[i] != 0x00)
+#endif
                        goto not_ecc_match;
        }
        return 0;
"""

but of course, this is not the solution ...

Any ideas are welcome, Thanks!

bye,
Heiko

(Damn, that I have not longer automated testing up and running for
this board)
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
