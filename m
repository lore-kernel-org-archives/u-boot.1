Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B01DEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10CCA89004;
	Tue, 10 Sep 2024 12:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725963517;
	bh=obbBx79+BINc2fFD1CAqxPy3MoG0ZM6H/XK3HkCBUn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxMtfAft/xbIxAussmr3NyiCYPTMI3DB5QapX4qAWQVpYo+Ez8G43FQ4VVYKWUoRR
	 9AkViIJLiQcfCjWQ2/WSdHB0ABo7tbSB2+BWXiJmMN+clZpi7B3njjgRsbyaKHlY0E
	 0o3FoIKwHbP44ySZ/rGUet+oNUniHQgvLQmLGL1gd2OmuQoOn/EVTsyOzZ4ynNMvX4
	 wUSouYEShnWlNxLB/N0VehFDN3+5d24aowKMV7oQunupBb3ktczLWIw5LbqainNaIk
	 LPgxCf7VbTfJS8q8suk+dBFxIAjyD+pHMABoBIJoSvRQY9MEsWK+B+d449pnQoMq/I
	 gMlX+XdvkyLJw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DD5B988FFB;
 Tue, 10 Sep 2024 12:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725963515;
 bh=obbBx79+BINc2fFD1CAqxPy3MoG0ZM6H/XK3HkCBUn8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y2mOO9FP/pqS9vIggr5KHd//rnA0HHVeJHwAyY7AwZJZCS4ML/+h8l6aAqyITfKwS
 DM2oDWOgz+lTbL3qQ0PpiRhIMG0MGbCI3EoADKPF+USE9vy5s0HgGyNcM5hqf0DJz7
 cEpkbol8J/PAGU52aIH3yWAzBQcBUb7FlQi7fSXwtAmi+v845JWtkK4xxMAseOGbOU
 LFod3bzAC9gLejvGZHgRn9tGZg9qq5rcuZjDRcCKnGJZQJUzI1OARYEnnbdE3kh2kT
 vww5aXASHflH22SSCYSz8OfQ4tHvg8aua9j6IYJTBO2RVNS65p29aRYahdZuPy1ejO
 e6ShJtI0C5NEg==
Message-ID: <f778366b-bdaf-415d-a94e-c995f62e8c71@denx.de>
Date: Tue, 10 Sep 2024 12:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
 <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
 <eced1020-2157-44a4-98a9-845e218529d9@denx.de>
 <45c74c58-98cf-43df-b837-c48b0341c551@denx.de>
 <CAPVz0n2-DCKDcVrAi00kF6yDcE2bN1mtUhzBcw7JDiZoXgzu0w@mail.gmail.com>
 <e5837ce4-0a14-4822-960d-6ab667a9f4b1@denx.de>
 <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n323ktF6kb3WHR9JcE+xOzQr9-aWOR47+ZvwQr=ib18rg@mail.gmail.com>
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

On 9/10/24 11:05 AM, Svyatoslav Ryhel wrote:
> пн, 9 вер. 2024 р. о 19:13 Marek Vasut <marex@denx.de> пише:
>>
>> On 8/20/24 9:08 AM, Svyatoslav Ryhel wrote:
>>> пн, 19 серп. 2024 р. о 20:27 Marek Vasut <marex@denx.de> пише:
>>>>
>>>> On 8/1/24 2:28 AM, Marek Vasut wrote:
>>>>> On 7/29/24 1:55 PM, Svyatoslav Ryhel wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>> What is the problem you observe on tegra 3 ?
>>>>>>>> i2c line fails since it probes in spl with your patch, but it does not
>>>>>>>> relocate and then probes once more after relocation. Probe fails along
>>>>>>>> with all devices on same line.
>>>>>>>
>>>>>>> Could it be that you either have to:
>>>>>>> - Add DM_I2C to tegra 3 SPL
>>>>>>> - Remove bootph-* from DT to remove the regulator node from SPL
>>>>>>> - /delete-property/ regulator-always-on; and /delete-property/
>>>>>>> regulator-boot-on; in -u-boot.dtsi to prevent the regulator from being
>>>>>>> enabled in SPL ?
>>>>>>>
>>>>>> Obviously NO, you propose nonsense. Same dts is used for both stages.
>>>>>
>>>>> DT source yes, DT blob likely no.
>>>>>
>>>>>> And I have to add hack-ish stuff just because you wanna introduce code
>>>>>> which causes known regressions.
>>>>>
>>>>> I am trying to understand what problem there is on tegra 3, but it is
>>>>> still not clear to me.
>>>>>
>>>>> Is the problem somehow related to PMICs (?) being probed in SPL (?)
>>>>> because they have regulators (?) which are marked as regulator-always-on
>>>>> ? If so, then this is correct behavior, and if this is not desired in
>>>>> SPL, then you can remove this property from SPL DT in -u-boot.dtsi using
>>>>> /delete-property/ .
>>>>>
>>>>> [...]
>>>>>
>>>>>> "We must not probe things as we go. There might be other
>>>>>> dependencies not yet bound. It may also take some time. This is not
>>>>>> following driver model design, sorry.
>>>>>>
>>>>>> So please think of a way to do this properly."
>>>>>
>>>>> What is this quote about ? Where is this from ?
>>>>
>>>> What is the problem with Tegra 3 and this patchset ?
>>>>
>>>> Can you please explain that so this patchset can move forward ?
>>>>
>>>
>>> with your changes
>>>
>>> U-Boot 2024.07-00696-ge217e2769db9-dirty (Aug 20 2024 - 09:55:29 +0300)
>>>
>>> SoC: tegra114
>>> Model: NVIDIA Tegra Note 7
>>> Board: NVIDIA TegraTab
>>> DRAM:  1 GiB
>>> tegra_i2c_probe: called
>>> i2c: controller bus 0 at 7000d000, speed 0: tegra_i2c_probe: exit
>>> i2c_init_controller: speed=400000
>>> i2c_init_controller: CLK_DIV_STD_FAST_MODE setting = 25
>>> i2c_xfer: 2 messages
>>> i2c_xfer: chip=0x58, len=0x1
>>> i2c_write_data: chip=0x58, len=0x1
>>> write_data:  0x37
>>> pkt header 1 sent (0x10010)
>>> pkt header 2 sent (0x0)
>>> pkt header 3 sent (0x100b0)
>>> pkt data sent (0x37)
>>> tegra_i2c_write_data: Error (-1) !!!
>>> i2c_write_data(): rc=-1
>>> i2c_write: error sending
>>> read error from device: bd26f8e0 register: 0x37!
>>
>> This seems like the PMIC driver (palmas?) is trying to read register
>> 0x37 PGOOD and the I2C transfer fails . Why does the I2C transfer fail ?
> 
> You  are asking me? Because your patches break some important setup sequence.
> PMIC model does not matter, all behave same way.

These regulator patches do not modify anything related to I2C and I 
don't observe this kind of behavior on iMX8M or STM32 platforms, so I 
suspect this is something specific to tegra.

>> You did mention something regarding I2C/PMIC driver probe timing, but it
>> seems the I2C driver and PMIC drivers probe roughly around the same time
>> in both pass and fail cases ?
> 
> Yes, here I agree that they both probe and probe passes, but I assume
> timing of i2c call is critical and there may be some dependency which
> is not ready.

My guess would be pinmux or clock, maybe the i2c controller is marked as 
bootph-* in DT and its pinmux/clock is not? Maybe the i2c on tegra works 
by sheer coincidence right now? Can you have a look?
