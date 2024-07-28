Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0C8C3DA49
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 20:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200FE8806A;
	Sun, 28 Jul 2024 22:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722197313;
	bh=M8SOmneL0ou17T8Wxxz4W2dcTHrvs2gZ6XSpfWjq7J4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uQABJLHKXuNY+HqiEbe0xVnd1Xi17hEFeu/cU2aJ8sSkYSgvh9uouk97zJSLJOKwq
	 A+5StTOGZBu93j/kW0AsBisTlAJ79vIIxY3A39Dq1jJRPOkg028jVV2ycGMrOujIq/
	 U/uRLSa9WaRSKooogQghxMURtEJ4Z/HgyTb+Di/yrip+1uzP+c0yr7ZAVmfWXrfthk
	 SZdvD7A8N8enHyfrI+3OY/WSGM2MeFz63r+PVkf8vQesLwjkhwQ9pkvcGQG87Mh6jV
	 2wcdqladWBKTUVPY4WG+YEVZ94jFmkpVBhRMUudt+vvs4sJoSd5jAafAeQ70EIAZ2g
	 reeGYGkWD3Naw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 111CC841BC;
 Sun, 28 Jul 2024 22:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722197312;
 bh=M8SOmneL0ou17T8Wxxz4W2dcTHrvs2gZ6XSpfWjq7J4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B0Ha5Enyef3ySQi2BFJg6r5Wmy8JV3eOOcSdZ7UPkNSi/G1JaNzbMiepY0BRH15UI
 Ag31d+ndbOA8Dp7zT+R2MefBPyS8BlRSu9AnuB3+CVsNjwgNeoX8RfQL9FyyheNmdB
 eiwk1NL6hdQv/gcfJJmqxtR8I4Yh5v9VI9Z38efWQNk4N8WC4kJxPD/9AfU85R+wbk
 x/lu496nKKmxk5vDeaeoch/nH2YGjEAG3pmtiADmSW5aeS+O0NXilhEdQ5sfALTOC3
 QE1QeV82QoC6Fa4Oh77sGJtewPcCDhuDBegUfmwuz1uA1nGC4EiXlZ0OcpPVYZnLhd
 yAoNmjtaB76Zw==
Message-ID: <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
Date: Sun, 28 Jul 2024 22:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Svyatoslav <clamor95@gmail.com>
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
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

On 7/28/24 9:02 PM, Svyatoslav wrote:

Hi,

I'm trimming the CC because I keep getting ML blockage due to large CC 
list. If someone has been removed too hastily, sorry.

> 28 липня 2024 р. 21:35:27 GMT+03:00, Marek Vasut <marex@denx.de> написав(-ла):
>> On 7/28/24 7:55 PM, Svyatoslav Ryhel wrote:
>>> нд, 28 лип. 2024 р. о 19:38 Marek Vasut <marex@denx.de> пише:
>>>>
>>>> On 6/27/24 1:55 AM, Marek Vasut wrote:
>>>>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
>>>>> property, make sure the regulator gets correctly configured by U-Boot on start
>>>>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
>>>>> for introduction of .regulator_post_probe() which would trigger the regulator
>>>>> configuration.
>>>>>
>>>>> Parsing of regulator-always-on and regulator-boot-on DT property has been
>>>>> moved to regulator_post_bind() as the information is required early, the
>>>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>>>>> slowing down the boot process.
>>>>
>>>> Is there anything blocking this series from being applied ?
>>>
>>> This patchset causes PMIC regulators probe too early which results in
>>> i2c line setup failure. These patches MUST NOT be applied in this form
>>> since they will break at least 15 Tegra 3 devices which use DM PMIC,
>>> maybe more.
>>
>> Thank you for testing. I do not have any tegra 3 devices, but this patchset does not do anything with pinmuxing. If a regulator is probed, all of its dependencies (i2c bus, pinmux configuration, etc.) should be probed as well. Can you have a look at what the problem with pinmuxing is on tegra 3? It seems it might be unrelated to this patchset and would eventually show up elsewhere?
> 
> Pinmux? Wdym, I wrote about a PMIC which is usually located on i2c line.
> 
> <https://patchwork.ozlabs.org/project/uboot/patch/20231003062126.42026-4-clamor95@gmail.com/>
> 
> This is a similar patch.
> 
> You may be able to reproduce the issue I face if you have a device which uses SPL and has DM PMIC with regulators that need always-on/boot-on properties.

I actually do use:

configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_DM_PMIC=y
configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_DM_PMIC_PCA9450=y
configs/imx8mp_dhcom_pdk3_defconfig:CONFIG_SPL_DM_PMIC_PCA9450=y

which is one of the devices I test this on.

The PMIC is on I2C, DM_PMIC enabled in SPL, both buck4 and buck5 
regulators are enabled in SPL, have regulator-always-on and 
regulator-boot-on and bootph-pre-ram properties.

This seems similar enough, right ?

What is the problem you observe on tegra 3 ?
