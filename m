Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C64606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BgrJvyIk;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=AfGxB6q5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D889E40870;
	Fri,  6 Nov 2026 08:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XkcR-m_u87Fg; Fri,  6 Nov 2026 08:58:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1381F406D9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793955505;
	b=hPZtGcv4Po/x/NPNVi4fM5FBFiai1msYknB049ZMw212vXXC9Zd3XejS7B9WqbqYDxk+
	 qGPCOndkFlXgAqy8iYkGGON9+z0c6QT5/QnuxSMkpe1Vfh72NI0eGdINSmjOCMBdbn9yz
	 JqqCYDDJGcHBJYz8r4Elpg2SrK4hqJaCdMHdkcOUIqa9QG5HqiAaa5IFuOUzy0AZ+KWrb
	 7Yx+QOOgofvlX75pDWFtaqPlhs3RSPOGXJK1eqW6uFmaN/k4OOFj1k7iI7kOLm4Yz2FbE
	 fvwirzr/rI0Ydx+mKDS2kAu2Fo/46gmTUchRrLikr3KhDEc1+gfpreSulBUlhGht1LA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793955505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AcEgB86oWXoPrD6smxuv2IN3TSIeC9Pqx8Y7mzuTNS4=;
	b=AO5mXsnOZK/KEchMjWnMt/MlcyPYBLc02nH1KTNBflKlT1z8FXKSAzi7zihsrbiXGO9B
	 Z/2mprC7XylJ03Tshp78R7tdswgxYB8DG1e2pKAC230Xp4iTzXqAmGSwod8AAuDDibJ9t
	 Cq/50zeyXBUqJzB7DijWMnrkRssIeRwLgZiAbFdc6nOPoYcMzl3WcMGKGEGygp61EbS98
	 AzEWLJZYIfBty8w0POpdxLKvcqku20MI5TC032NeTR6fnz8FsK66SJhbmBEWOk/Z2Idcp
	 rF2SW+zLQ90veq7VAIAQcidpLlStqm4RgxZYEULi8SBV+WS273bY/o0hQdOrw0tiMmQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793955505;
	bh=AcEgB86oWXoPrD6smxuv2IN3TSIeC9Pqx8Y7mzuTNS4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgrJvyIkA6xrtbQACbF6WvMGZnryQwwsDPtXI/z1HEdc5Fzssxgz2QdDRT6Lra4Tl
	 +psb+NArfo6OwQMkvcpyIKR1LeMV/skXuAhCGHmXYYnkVqIX81X60dC07YIesbIg9G
	 cP8Ca+zKoLz81o+n0qORsxHL37IGmZ9rix9eZTF4aNY67W81BGXvaFfX/hlbuVc3bj
	 EQbbDhrHR8cuzQf6dVPd+7aSnb1lIkv60nKBFfX6tysqaAruHt/Zy1g8oGHHags3kR
	 c159yGDIo2MD1AFb0gKeaAdl+z6QxhfZUFM1JMlcWqyNRThTD2mTkXJ40FQO34PQsI
	 +lhscycrsaPSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1381F406D9;
	Fri,  6 Nov 2026 08:58:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD87F32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2C0A403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0XUUQfgkPac for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 08:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B2B8D400D5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=chenjh@rock-chips.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=rock-chips.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=AfGxB6q5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2B8D400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 08:58:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371658482A; Fri,  6 Nov 2026 09:58:13 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB20F84820
 for <u-boot@lists.denx.de>; Fri,  6 Nov 2026 09:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chenjh@rock-chips.com
Received: from [172.16.12.163] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 53c05a0f8;
 Fri, 6 Nov 2026 16:57:57 +0800 (GMT+08:00)
Message-ID: <1748270f-1eb2-4741-b75e-cf1e4d36dcd2@rock-chips.com>
Date: Fri, 6 Nov 2026 16:57:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Joseph Chen <chenjh@rock-chips.com>
Subject: Re: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
To: Chris Morgan <macromorgan@hotmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 clamor95@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com
References: <20261105151057.477529-1-macroalpha82@gmail.com>
 <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
 <PH0PR19MB99733827DB66CA431B1BD7DA94A5772@PH0PR19MB997338.namprd19.prod.outlook.com>
In-Reply-To: <PH0PR19MB99733827DB66CA431B1BD7DA94A5772@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1b014386403aakunm12d301b110a5cd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxgeVkofTE8eHR9JQkpOTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=AfGxB6q5nQj0CY1aMsNWX3PCKKnE7+S+3D0aQSaddX6LloWDxS5H1Pygeo2o17PWQuV5FnwpqpJ8vqXIqLNXlpPsdtc3ky7KFUeTQYkjVeFTRbLAHbD7K2V/KvN4aTeJk/mh3Z5hbxlUzwCiu39qPH0rKX0usv5owuvdkRB3RuY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=AcEgB86oWXoPrD6smxuv2IN3TSIeC9Pqx8Y7mzuTNS4=;
 h=date:mime-version:subject:message-id:from;
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_FAIL,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin, Chris:

在 2026/11/6 1:32, Chris Morgan 写道:
> On Thu, Nov 05, 2026 at 05:13:48PM +0100, Quentin Schulz wrote:
>> Hi Chris,
>>
>> On 11/5/26 4:10 PM, Chris Morgan wrote:
>>> From: Chris Morgan<macromorgan@hotmail.com>
>>>
>>> Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
>>> bits are not used by mainline Linux and actively setting them in U-boot
>>> interferes with their function for BSP kernels, causing systems to
>>> hang when regulators are enabled or disabled incorrectly. [1]
>>>
>> More information in the commit log would be welcome, in the event the gist
>> ever disappears.
>>
>> In essence, those two registers are used to store the current state of the
>> regulators (why? don't know and not explained in the gist, do you have some
>> info maybe Chris? Anbernic seems to be ignoring it anyway but we don't know
>> if there are actual users of it). They aren't meant for that at all, but
>> that's what they are used for. Downstream kernels then read those registers
>> and configure the regulators at boot based on the saved values. In upstream
>> U-Boot, these registers are set at PMIC driver probe time, which doesn't
>> make a lot of sense since no regulators would have been configured by then
>> (although, they may have if the PMIC driver was probed and used in xPL and
>> U-Boot proper then save the state as configured by xPL).
>>
>> I'm a bit worried other downstream kernels may actually be expecting these
>> registers to be set. But considering we probably are misconfiguring the save
>> registers anyway (by saving too early), I guess that's fine?
>>
>> Please expand the commit log to contain summarized information from the
>> gist, and that would be an:
>>
>> Acked-by: Quentin Schulz<quentin.schulz@cherry.de>
>>
>> Considering this has been the case forever, I'm tempted to get this into
>> 2027.04 rather than 2027.01 as it's not a new regression. That would leave
>> enough time for people to complain about it (though I'm not sure may people
>> are actually testing upstream -rc on Rockchip?). At the same time, we're
>> still relatively early in the 2027.01 rcs so maybe that's acceptable too.
>>
>> Thanks!
>> Quentin
>>
> I'll resubmit tomorrow with more information in the commit message, as
> requested. I'll save the ack so you can confirm if you think it's
> good.
>
> I don't know that we have a good answer as to why those regulators are
> stored. The BSP U-Boot driver (assuming it wasn't modified by Anbernic)
> would check the device-tree for a "not-save-power-en" parameter and if
> it was not set at 1 it would save the contents of registers
> RK817_POWER_EN0 through RK817_POWER_EN3 and then save the contents to
> RK817_POWER_EN_SAVE0 (0x99) and RK817_POWER_EN_SAVE1 (0xa4). These
> values would be saved at probe time which would be very early in the
> boot process. The BSP kernel driver would then read the
> RK817_POWER_EN_SAVE0 register and if it was not 0 it would then read
> RK817_POWER_EN_SAVE1 and write all of those saved values back to the
> PMIC as part of the reboot-notifier.
>
> So basically it looks like as part of the reboot/shutdown process for
> BSP kernel and bootloader, the initial values for what is on/off is
> getting written back to the regulators unless not-save-power-en is
> set in U-Boot. This process breaks down for boards where the BSP
> bootloader sets not-save-power-en.
>
> Since mainline Linux doesn't use these registers at all and there is
> no parameter to control their use in mainline U-Boot like there is in
> BSP U-Boot, we should just drop them so they don't interfere with the
> BSP kernel.
>
> Thank you,
> Chris
>   

The purpose for POWER_EN_SAVE0/1 is that:

During a PMIC reset, voltage settings are restored before enable (EN) 
settings. For example:
a regulator that is disabled by the PMIC hardware at power-on, with a 
default voltage of 1.8V,
may be enabled by the user and configured to output 1.0V during operation.
When a reboot triggers a PMIC reset, the regulator may briefly output 
1.8V before being disabled,
posing an overvoltage risk.

To prevent this, U-Boot saves the initial power-on enable states in 
POWER_EN_SAVE0/1.
The kernel restores these states in the reboot callback, disabling such 
regulators
before the PMIC reset to avoid unintended voltage output.


>>> [1]https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c
>>>
>>> Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
>>> ---
>>>    drivers/power/pmic/rk8xx.c | 11 -----------
>>>    1 file changed, 11 deletions(-)
>>>
>>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>>> index 95b71d2fe49..16b3dc7cb1c 100644
>>> --- a/drivers/power/pmic/rk8xx.c
>>> +++ b/drivers/power/pmic/rk8xx.c
>>> @@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
>>>    	int ret = 0, i, show_variant;
>>>    	u8 msb, lsb, id_msb, id_lsb;
>>>    	u8 on_source = 0, off_source = 0;
>>> -	u8 power_en0, power_en1, power_en2, power_en3;
>>> -	u8 value;
>>>    	/* read Chip variant */
>>>    	if (device_is_compatible(dev, "rockchip,rk817") ||
>>> @@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
>>>    		off_source = RK817_OFF_SOURCE;
>>>    		init_data = rk817_init_reg;
>>>    		init_data_num = ARRAY_SIZE(rk817_init_reg);
>>> -		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
>>> -		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
>>> -		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
>>> -		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
>>> -
>>> -		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
>>> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
>>> -		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
>>> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>>>    		break;
>>>    	case RK806_ID: {
>>>    		u32 rst_fun = 2;

-- 
Best regards,

陈健洪 (Joseph Chen)
chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573

