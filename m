Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12498C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 10:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75381887D1;
	Mon, 29 Jul 2024 12:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722249780;
	bh=yVvbakc+wM8eVZyrNeBGH2mcSSr+uO3HeU+UAdcW0i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RY+jMeLbn3yLjnqth7FdCdIckT195E2aY3Nuyr70n0VM4c0g5QfklHvifoC8zwrKK
	 Y68CDb/3eHwy6XvEXJaurWIFgJF5loAd0Y9aNJ0CIfdDxgNt05m3G7vH4JXViYuaxl
	 FvSxjFK3wxVvrExBQohMLCSGYEWdfPxGg2FTpmmGORkcp/vKX02dhAUd1Zn3vFC/VD
	 dW1KofF0M9PRkPjoO9YOmsoQ5JZ4hyJuex70gJxY5tFnQLQ5LfMT4w+ts0/n6atgRN
	 8qf0AAPVA/nfwhb7Aq9AjPYhgKgeLA9nKniT11mmk4HxMFpYEWsqZyNM/4z99XzVYF
	 s09N/dQDZa09g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1A0F288365;
 Mon, 29 Jul 2024 12:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722249779;
 bh=yVvbakc+wM8eVZyrNeBGH2mcSSr+uO3HeU+UAdcW0i4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OT9fg5OTNpHxeXSOIoFcK6wWBN9WY84SIYarPehNma4c9uP+ioODfuBovyPkbNp3F
 s5W52ESDgArPcv585fPEveu7vFuO3kN6Aa9xoPWvZUN2a62Ol+f/6acfekrZHO8i26
 hLeFL8tbaWYh2Rpr+wWdlOkgUYBwQyYtxqMg65JCGaIMEKdVL6hUnq935wLrZ/pEvf
 C5fjDvNlkbXwQiWkpaZVeUOWva7aVo+IoGHhR/+1VC0sfZmQarZc2ZVoELR2XNYUrz
 jn7pw6ysf0gqBBBNal+vuLmbu6UyKQSV5qw60SwtbrS0E+y4j7pmeNgQfygJ6ycTNZ
 0YEkfO6SZ/35A==
Message-ID: <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
Date: Mon, 29 Jul 2024 12:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/29/24 7:38 AM, Svyatoslav Ryhel wrote:

[...]

>> The PMIC is on I2C, DM_PMIC enabled in SPL, both buck4 and buck5
>> regulators are enabled in SPL, have regulator-always-on and
>> regulator-boot-on and bootph-pre-ram properties.
>>
>> This seems similar enough, right ?
>>
> Yes, though SPL must remain as small as possible and you propose add
> there i2c driver,  PMIC driver, PMIC regulator drivers, PMIC GPIO
> drivers along with relocation of all this stuff. It is not optimal at
> all.

Sure, if you do use DM_PMIC for PMIC on I2C bus, then you also need 
DM_I2C . You can also do non-DM PMIC configuration in SPL, non-DM in SPL 
is allowed.

>> What is the problem you observe on tegra 3 ?
> i2c line fails since it probes in spl with your patch, but it does not
> relocate and then probes once more after relocation. Probe fails along
> with all devices on same line.

Could it be that you either have to:
- Add DM_I2C to tegra 3 SPL
- Remove bootph-* from DT to remove the regulator node from SPL
- /delete-property/ regulator-always-on; and /delete-property/ 
regulator-boot-on; in -u-boot.dtsi to prevent the regulator from being 
enabled in SPL ?

regulator-always-on means the regulator has to be enabled 
unconditionally, and the system software has no other way to test 
whether the regulator is enabled but access the PMIC, so that is why the 
regulator is probed, even if it is early.
