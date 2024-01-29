Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75DAC47DDB
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 18:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3349087C52;
	Mon, 29 Jan 2024 19:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lqTTZSJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D1F87C68; Mon, 29 Jan 2024 19:03:32 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7140387C20
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 19:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TI3GqH065990;
 Mon, 29 Jan 2024 12:03:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706551396;
 bh=T+B3LiRDa+qemzWfdCfE5Z9pdcb2LYJKEszLyVUbcrs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lqTTZSJ/nf4vbE0FTcJjPuqiYhp8LPrM3LWFGYoMW+OllDjCyD7nDAy0Vq9SkcfY/
 uEQItZPNh3QwiHmuc2gBvs4IAIwAMz5Ym0iPps74DK++qdV0dh1yJNQ2DOdLpIHQf8
 yLwmEyGIG2RN6Qk0BL32IhOdlE9C2gNTbQU3txCU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TI3GBJ023157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jan 2024 12:03:16 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 12:03:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 12:03:16 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TI3APw038234; 
 Mon, 29 Jan 2024 12:03:10 -0600
Message-ID: <3a7c817b-de29-463a-b4b6-d62c0df66ade@ti.com>
Date: Mon, 29 Jan 2024 23:33:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/16] arm: mach-k3: Add basic support for J784S4 SoC
 definition
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-3-a-nandan@ti.com>
 <20240119193403.kgzt2zcxa55wexr3@skedaddle>
 <c5fd33d8-a1be-41e0-974e-7b4c5f80b318@ti.com>
 <20240123204710.hlv4x4y3gst7utoe@squealing>
 <2d566dde-5428-400e-a30e-47cb80ccf5d1@ti.com>
 <20240129121917.j3sy2bkzu2berjkg@audition>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240129121917.j3sy2bkzu2berjkg@audition>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 29/01/24 17:49, Nishanth Menon wrote:
> On 17:02-20240129, Apurva Nandan wrote:
>> Hi,
>>
>> On 24/01/24 02:17, Nishanth Menon wrote:
>>> On 20:21-20240123, Apurva Nandan wrote:
>>> [...]
>>>>>> +void k3_mem_init(void)
>>>>>> +{
>>>>>> +	struct udevice *dev;
>>>>>> +	int ret, ctr = 1;
>>>>>> +
>>>>>> +	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
>>>>>> +		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>>>>> +		if (ret)
>>>>>> +			panic("DRAM 0 init failed: %d\n", ret);
>>>>>> +
>>>>>> +		while (dev) {
>>>>> why loop on dev? is it possible to have ret != 0 and dev = 0?
>>>>>
>>>> Some variable needs to be used for loop condition, do you want it to be ret?
>>>> or maybe you can suggest your idea for this please.
>>>>>> +			ret = uclass_next_device_err(&dev);
>>>>>> +			if (ret) {
>>>>>> +				printf("Initialized %d DRAM controllers\n", ctr);
>>>>>> +				break;
>>>>>> +			}
>>>>>> +			ctr++;
>>>>> What is the use of ctr++ ?? please do a limit check for instances.
>>>> This is to keep the logic independent of board evm, so that no include of
>>>> EVM config is needed.
>>>> ctr is just used to notify user about how many DDR are up during boot, else
>>>> it is not needed.
>>>>
>>>> I can remove the ctr and printf, if you want.
>>>>
>>>> For a limit check, how can we get number of DDR instances on the EVM, I
>>>> don't know, can you please suggest some way?
>>>>
>>>> There is no config that stores this info afaik.
>>> Why? J784s4 has only specific number of controllerns, correct?
>>>
>>> A variant of the below -> but still have a question:
>>>
>>> while (ctrl < J784S4_MAX_CONTROLLERS) {
>> Is J784S4_MAX_CONTROLLERS going to be a #define in j784s4_init.c
>>
>> Or a Kconfig option like:
>>
>> config DDR_MAX_CONTROLLERS
>>      int "Max number of DRAM controllers"
>>      default 4 if SOC_K3_J784S4
>>      default 1
>>      help
>>
> I dont see a need for Kconfig - but that is just me.
Ohkay, sending with #define.
>>> 	ret = uclass_next_device_err(&ret);
>>> 	if (ret) /* Question: How do we differentiate between valid
>>> 		  * failure and next instance not being present? */
>>> 		break;
>> how about:
>>
>>              ...
>>              if (ret == -ENODEV)
>>                  break;
>>
>>              if (ret)
>>                   panic("DRAM %d init failed: %d\n", ctrl,  ret);
>>              ...
> What ever is appropriate.
>
>
-- 
Regards,
Apurva Nandan,
Texas Instruments.

