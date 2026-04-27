Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2064FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B99483693;
	Mon, 27 Apr 2026 14:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mwJ8Wm84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162E283693; Mon, 27 Apr 2026 14:35:16 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A3BF080433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA071684;
 Mon, 27 Apr 2026 05:35:07 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3E533F62B;
 Mon, 27 Apr 2026 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777293312; bh=iWjPth9k+iOY52rKCibGBARkf2oOtTAUHUE62pj7AWQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mwJ8Wm84+Eo06Ytt72iykUOckbxM9+nPWN/nDMBWRB9m3HvxUgmL+T/QDp/uUYUmR
 Sahv35IRxnH6mdMrHmjccYflncAzgInIwK6U/CJCdJqKlJ90D+dpPyShZvowsBXQkp
 rTkzZBVwIfieGfp3VyZyjmVAgCQBaL8mryam3WJo=
Message-ID: <cfe67c5d-0762-4366-94df-e64728847f0b@arm.com>
Date: Mon, 27 Apr 2026 14:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <20260327140508.3680105-4-richard.genoud@bootlin.com>
 <CAOf5uwnYuZi46ZKijOJ-PLt_55Nwg9BQ5w+3Mtu+VxNvrER1Qw@mail.gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <CAOf5uwnYuZi46ZKijOJ-PLt_55Nwg9BQ5w+3Mtu+VxNvrER1Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 3/27/26 15:42, Michael Nazzareno Trimarchi wrote:
> Hi Richard
> 
> On Fri, Mar 27, 2026 at 3:05 PM Richard Genoud
> <richard.genoud@bootlin.com> wrote:
>>
>> In sunxi_nand_chip_init there's quite a lot of kfree/return, it's easy
>> to forget a kfree(), so use a goto/kfree instead.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand.c | 41 ++++++++++++++-----------------
>>   1 file changed, 18 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index 9fc9bc5e0198..ecab9ebc9576 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -1600,21 +1600,20 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
>>                  if (ret) {
>>                          dev_err(dev, "could not retrieve reg property: %d\n",
>>                                  ret);
>> -                       kfree(chip);
>> -                       return ret;
>> +                       goto out;
>>                  }
>>
>>                  if (tmp > NFC_MAX_CS) {
>>                          dev_err(dev,
>>                                  "invalid reg value: %u (max CS = 7)\n", tmp);
>> -                       kfree(chip);
>> -                       return -EINVAL;
>> +                       ret = -EINVAL;
>> +                       goto out;
>>                  }
>>
>>                  if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
>>                          dev_err(dev, "CS %d already assigned\n", tmp);
>> -                       kfree(chip);
>> -                       return -EINVAL;
>> +                       ret = -EINVAL;
>> +                       goto out;
>>                  }
>>
>>                  chip->sels[i].cs = tmp;
>> @@ -1640,15 +1639,13 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
>>                  dev_err(dev,
>>                          "could not retrieve timings for ONFI mode 0: %d\n",
>>                          ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          ret = sunxi_nand_chip_set_timings(nfc, chip, timings);
>>          if (ret) {
>>                  dev_err(dev, "could not configure chip timings: %d\n", ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          nand = &chip->nand;
>> @@ -1669,10 +1666,8 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
>>
>>          mtd = nand_to_mtd(nand);
>>          ret = nand_scan_ident(mtd, nsels, NULL);
>> -       if (ret) {
>> -               kfree(chip);
>> -               return ret;
>> -       }
>> +       if (ret)
>> +               goto out;
>>
>>          if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>                  nand->bbt_options |= NAND_BBT_NO_OOB;
>> @@ -1685,34 +1680,34 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
>>          ret = sunxi_nand_chip_init_timings(nfc, chip);
>>          if (ret) {
>>                  dev_err(dev, "could not configure chip timings: %d\n", ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          ret = sunxi_nand_ecc_init(mtd, &nand->ecc);
>>          if (ret) {
>>                  dev_err(dev, "ECC init failed: %d\n", ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          ret = nand_scan_tail(mtd);
>>          if (ret) {
>>                  dev_err(dev, "nand_scan_tail failed: %d\n", ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          ret = nand_register(devnum, mtd);
>>          if (ret) {
>>                  dev_err(dev, "failed to register mtd device: %d\n", ret);
>> -               kfree(chip);
>> -               return ret;
>> +               goto out;
>>          }
>>
>>          list_add_tail(&chip->node, &nfc->chips);
>>
>> -       return 0;
>> +out:
>> +       if (ret)
>> +               kfree(chip);
>> +
>> +       return ret;
>>   }
>>
>>   static int sunxi_nand_chips_init(struct udevice *dev, struct sunxi_nfc *nfc)
> 
> I need to go a bit in the code but seems that out can happen even if
> there is no error. It's
> not so common to have if (ret) if exit condition in case of errot

So I think it's fine in this case, ret is always set before we "goto", 
and in the success case "ret" must be 0 from the last check. But I agree 
that the construct is a bit uncommon and fragile, so what about keeping 
the "return 0;" (to use the common pattern and help readability), and 
rename the label to "out_err" or "out_free", to make it more obvious 
that this the error path only, and we expect ret to be set?

Cheers,
Andre

> 
> Michael

