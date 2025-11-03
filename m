Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63DFCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 10:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1EF838AE;
	Mon,  3 Nov 2025 11:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AaZiVXQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D06A2838CE; Mon,  3 Nov 2025 11:36:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA6783642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 11:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f764=5L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762166175;
 bh=BzA/9N4OwIpwFPmLq86ePRh4l2911CaD1CptTOwrf6s=;
 b=AaZiVXQzIPQucBU2QDg4PPsc8apKU2zAsy1h8t/ygwHdT/b1RMrIK6Yp+YMHsYgBt0Ugc+dYV
 J0U0F7S9lPwp4/Te+/qCgh4VbMIBkFYcAej1dDziiwhuNLYrWNq3sDrZcqM8shQipcL5xAuIy1N
 FdaGmBYdHKBYWk0l7pDy+RFoKK29jKO1mLcZ36J7Hf4gHEkDvFsWLNpPZpcwTqjHFII1Uw7vRGe
 oZdQbIjY/Ejy0WzHX9dVYasJ0RV4cPGrKWqIOg7dn3Wkvda2y0+XcBZ5BvBKYBDWFs3bbfpoJCK
 OwBS8fvluUKRCNsPr0W+qm/lWvcbpNi2iD9Ji2kDR4Lw==
X-Forward-Email-ID: 6908859c828d1c0fe857dea1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
Date: Mon, 3 Nov 2025 11:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Peng,

On 11/3/2025 9:51 AM, Peng Fan wrote:
> On Sat, Nov 01, 2025 at 08:34:26PM +0000, Jonas Karlman wrote:
>> Rockchip boards may depend on a working MMC regulator in SPL to
>> successfully load FIT payload from MMC. Typically, these boards only
>> include the vmmc-supply regulator and not its vin-supply in SPL control
>> FDT.
>>
>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>> boards due to now requiring the vin-supply to be included in the SPL
>> control FDT.
>>
>> The commit also strangely enables any found vin-supply in
>> regulator_common_of_to_plat() and not when a regulator is enabled or as
>> part of regulator_autoset().
>>
>> Revert the commit to fix FIT loading in SPL on broken boards.
>>
>> If a board needs to have its vin-supply enabled, two options come to
>> mind:
>>
>> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>>  any board.
>>
>> - Implement full support for reference counting of regulators and then
>>  update the regulator-uclass to enable any found vin-supply when a
>>  regulator is enabled.
>>
>> This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.
>>
>> Reported-by: Dang Huynh <danct12@riseup.net>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> drivers/power/regulator/regulator_common.c | 10 ----------
>> drivers/power/regulator/regulator_common.h |  1 -
>> 2 files changed, 11 deletions(-)
>>
>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>> index 3ed713ce5019..685d8735fa5c 100644
>> --- a/drivers/power/regulator/regulator_common.c
>> +++ b/drivers/power/regulator/regulator_common.c
>> @@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
>> 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>> 	}
>>
>> -	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>> -	if (ret) {
>> -		debug("Regulator vin regulator not defined: %d\n", ret);
>> -		if (ret != -ENOENT)
> 
> I understand it might be not proper to enable vin-supply in
> function regulator_common_of_to_plat().
> But I have a question, there is -ENOENT check in the original patch. If the
> board does not have vin-supply, there should be no issue. Or I miss something?

As mentioned in the commit message the SPL control FDT does not contain
the regulator references as a vin-supply, this result in -ENODEV to be
returned. I.e. following where the vcc_io is not included in SPL control
FDT.

  vcc_io: regulator@ {
  }
  vcc_sd: regulator@ {
  	bootph-pre-ram;
  	vin-supply = <&vcc_io>;
  }
  sdmmc: mmc@ {
  	bootph-pre-ram;
  	vmmc-supply = <&vcc_sd>;
  }

With the change introduced in this commit the core gpio/fixed regulator
behavior changed and this now result in unbootable boards.

Other reasons why I prefer a full revert instead of a workaround:
- The implementation changed core gpio/fixed regulator function without
  any review-by or acked-by.
- The patch was quickly merged after only being on the list for 1 week,
  the imx pull-request that included this did not even mention regulator
  changes.
- The implementation is not optimal, looking up vin-supply could be okay
  but not failing because it is missing, and enabling it during probe
  when we already have working enable count and regulator autoset to
  handle any needed auto-enable.
- The commit message does not give any insights on why this is needed.

My suggestion is that this is reverted and if needed it should can be
submitted as a separated patch/series with a proper implementation.

Regards,
Jonas

> 
> Thanks,
> Peng
> 
>> -			return ret;
>> -	}
>> -
>> -	if (plat->vin_supply)
>> -		regulator_set_enable_if_allowed(plat->vin_supply, true);
>> -
>> 	return 0;
>> }
>>
>> diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
>> index 799c968d0b66..d4962899d830 100644
>> --- a/drivers/power/regulator/regulator_common.h
>> +++ b/drivers/power/regulator/regulator_common.h
>> @@ -14,7 +14,6 @@ struct regulator_common_plat {
>> 	unsigned int startup_delay_us;
>> 	unsigned int off_on_delay_us;
>> 	unsigned int enable_count;
>> -	struct udevice *vin_supply;
>> };
>>
>> int regulator_common_of_to_plat(struct udevice *dev,
>> -- 
>> 2.51.0
>>

