Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790A606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CgyBwmdL;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=K072SO+R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70ED681276;
	Sat,  7 Nov 2026 08:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yj-XWuPQ1ZBu; Sat,  7 Nov 2026 08:11:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8E7F81230
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794039082;
	b=TLO0O4fVg7yU5uuexyi9yP7c8Dc77ThlFncRgER++Ape8z78IIcj63bgKq+hVdFvr9sC
	 +g8S8irmqxzSzA8EZwrDhTbRez3JiCt6SM2suGL5QNfRkvvg2ei6XzzNblsEsytfFk61r
	 777wP1TJ+D4V4pZXif2Plrx/PCfpw2/YGqsJ+++B0jI+Gt+LPjP4rwq/UYcqkRz/N+8ZI
	 xqovy8jR5iCAXEN1n87SZE6XOYnSEbRqcFZXysaMQEGbIfdE1eO3VckJmCc2uEIyA59DQ
	 9CjUsu/zrEjZA3bBL/79lOY4+LDbSur949TyB4PJIHgjq96FEvqilpP/UwCK3LzKQyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794039082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=H3U9tB8FYrpyBvxHxoN+agWY5YfTVtk6YQltWymx+2k=;
	b=k6sKMDEOMAEOPwCUq1SY4CbY7gWzxJsV10uY4Bd1QFLpae8bSbRUeUzBJ6sCxZTzU87Q
	 e5L8nM6nV9o4AyFQzES22g3Hzf/37HF9PnlQwstgNgKbFRLRxew+KFeHDUw1uAvQM7+pt
	 6LsoEKoX3lOiPnaIJXNy6YsfL3xbApel7P8CUK5x3DUSfc1VN64SiamofvY0Bu9AWur+l
	 5YLF3vubDr9QH72g0jKIormwI+nEsrlmIrmV31QfgsWCcixHNILkVHfbJeZJGJ3/Wc/59
	 egG4miBFr/me65tvipeDcUDf0x4wSSCblxlg0e7ObmzdEo7rVhBcuxbyHV0JSiZwpSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794039082;
	bh=H3U9tB8FYrpyBvxHxoN+agWY5YfTVtk6YQltWymx+2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CgyBwmdLaxniuXs0yJPDjPw9dBALUNA0NS6xVjTPxNPRiWYdyp/5EQIhQcLQsZtYQ
	 JHnIHg29r7R3FJlmp5iU/iyplBnSgNlnIvDM19WPHEVy57LFQ5Ilud+kF60NSrZcKt
	 BmP5KdnEZssdfiIs2oG9h8H6E3szokTUtp0yjS4W1SiVe65nVfVUMIOQoVj8wl8PsI
	 sxI+7SWjgHl0gqNI2aRA4d2FZEL1v/VJj2cc6+ZXENTAO8uoc4tq2MOBuvfEW+Rxtr
	 bjWr+w4qa74DUGZWFDEXp0D9sJO4V1B5chhuZnXrRmfwGdURjrzUtmuHBM+3q6WTqx
	 6AvJVK23e/sjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8E7F81230;
	Sat,  7 Nov 2026 08:11:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B87A2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D0294005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:11:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3WJAHVNeUKu0 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 08:11:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4D36140042
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=chenjh@rock-chips.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=rock-chips.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=K072SO+R
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D36140042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:11:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B06F8482B; Sat,  7 Nov 2026 09:11:04 +0100 (CET)
Received: from mail-m1282.netease.com (mail-m1282.netease.com [103.209.128.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6832584820
 for <u-boot@lists.denx.de>; Sat,  7 Nov 2026 09:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chenjh@rock-chips.com
Received: from [172.16.12.163] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 53d7627c9;
 Sat, 7 Nov 2026 16:10:50 +0800 (GMT+08:00)
Message-ID: <4d524890-a85f-41b7-b173-481f9dfedbad@rock-chips.com>
Date: Sat, 7 Nov 2026 16:10:49 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 clamor95@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com,
 power.xu@rock-chips.com
References: <20261105151057.477529-1-macroalpha82@gmail.com>
 <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
 <PH0PR19MB99733827DB66CA431B1BD7DA94A5772@PH0PR19MB997338.namprd19.prod.outlook.com>
 <1748270f-1eb2-4741-b75e-cf1e4d36dcd2@rock-chips.com>
 <PH0PR19MB997338A34AEEDDAF76FF8D1B95A5762@PH0PR19MB997338.namprd19.prod.outlook.com>
From: Joseph Chen <chenjh@rock-chips.com>
In-Reply-To: <PH0PR19MB997338A34AEEDDAF76FF8D1B95A5762@PH0PR19MB997338.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1b50f719003aakunm17c19413177a07
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHh0eVktMGENOHk1OSkxMS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=K072SO+RMJmIXqt/NT//4CqqxhbOVd+VHWt/MSkECzKZ1fXdy5Ar+o6dMgub3OUZhK6va15xqk3oz9AzVRh6qANA/Xj2NMEol7Ts9PXD9+35ZkE3L7cZLG0Ae03NdX7wR5zvlow6L1HXrjaA/PuXkUhoNqVUAcKCNiUSlZFXDuo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=H3U9tB8FYrpyBvxHxoN+agWY5YfTVtk6YQltWymx+2k=;
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

Hi Chris,

在 2026-11-06 22:24, Chris Morgan 写道:
> On Fri, Nov 06, 2026 at 04:57:55PM +0800, Joseph Chen wrote:
>> Hi Quentin, Chris:
>>
>> 在 2026/11/6 1:32, Chris Morgan 写道:
>>> On Thu, Nov 05, 2026 at 05:13:48PM +0100, Quentin Schulz wrote:
>>>> Hi Chris,
>>>>
>>>> On 11/5/26 4:10 PM, Chris Morgan wrote:
>>>>> From: Chris Morgan<macromorgan@hotmail.com>
>>>>>
>>>>> Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
>>>>> bits are not used by mainline Linux and actively setting them in U-boot
>>>>> interferes with their function for BSP kernels, causing systems to
>>>>> hang when regulators are enabled or disabled incorrectly. [1]
>>>>>
>>>> More information in the commit log would be welcome, in the event the gist
>>>> ever disappears.
>>>>
>>>> In essence, those two registers are used to store the current state of the
>>>> regulators (why? don't know and not explained in the gist, do you have some
>>>> info maybe Chris? Anbernic seems to be ignoring it anyway but we don't know
>>>> if there are actual users of it). They aren't meant for that at all, but
>>>> that's what they are used for. Downstream kernels then read those registers
>>>> and configure the regulators at boot based on the saved values. In upstream
>>>> U-Boot, these registers are set at PMIC driver probe time, which doesn't
>>>> make a lot of sense since no regulators would have been configured by then
>>>> (although, they may have if the PMIC driver was probed and used in xPL and
>>>> U-Boot proper then save the state as configured by xPL).
>>>>
>>>> I'm a bit worried other downstream kernels may actually be expecting these
>>>> registers to be set. But considering we probably are misconfiguring the save
>>>> registers anyway (by saving too early), I guess that's fine?
>>>>
>>>> Please expand the commit log to contain summarized information from the
>>>> gist, and that would be an:
>>>>
>>>> Acked-by: Quentin Schulz<quentin.schulz@cherry.de>
>>>>
>>>> Considering this has been the case forever, I'm tempted to get this into
>>>> 2027.04 rather than 2027.01 as it's not a new regression. That would leave
>>>> enough time for people to complain about it (though I'm not sure may people
>>>> are actually testing upstream -rc on Rockchip?). At the same time, we're
>>>> still relatively early in the 2027.01 rcs so maybe that's acceptable too.
>>>>
>>>> Thanks!
>>>> Quentin
>>>>
>>> I'll resubmit tomorrow with more information in the commit message, as
>>> requested. I'll save the ack so you can confirm if you think it's
>>> good.
>>>
>>> I don't know that we have a good answer as to why those regulators are
>>> stored. The BSP U-Boot driver (assuming it wasn't modified by Anbernic)
>>> would check the device-tree for a "not-save-power-en" parameter and if
>>> it was not set at 1 it would save the contents of registers
>>> RK817_POWER_EN0 through RK817_POWER_EN3 and then save the contents to
>>> RK817_POWER_EN_SAVE0 (0x99) and RK817_POWER_EN_SAVE1 (0xa4). These
>>> values would be saved at probe time which would be very early in the
>>> boot process. The BSP kernel driver would then read the
>>> RK817_POWER_EN_SAVE0 register and if it was not 0 it would then read
>>> RK817_POWER_EN_SAVE1 and write all of those saved values back to the
>>> PMIC as part of the reboot-notifier.
>>>
>>> So basically it looks like as part of the reboot/shutdown process for
>>> BSP kernel and bootloader, the initial values for what is on/off is
>>> getting written back to the regulators unless not-save-power-en is
>>> set in U-Boot. This process breaks down for boards where the BSP
>>> bootloader sets not-save-power-en.
>>>
>>> Since mainline Linux doesn't use these registers at all and there is
>>> no parameter to control their use in mainline U-Boot like there is in
>>> BSP U-Boot, we should just drop them so they don't interfere with the
>>> BSP kernel.
>>>
>>> Thank you,
>>> Chris
>> The purpose for POWER_EN_SAVE0/1 is that:
>>
>> During a PMIC reset, voltage settings are restored before enable (EN)
>> settings. For example:
>> a regulator that is disabled by the PMIC hardware at power-on, with a
>> default voltage of 1.8V,
>> may be enabled by the user and configured to output 1.0V during operation.
>> When a reboot triggers a PMIC reset, the regulator may briefly output 1.8V
>> before being disabled,
>> posing an overvoltage risk.
>>
>> To prevent this, U-Boot saves the initial power-on enable states in
>> POWER_EN_SAVE0/1.
>> The kernel restores these states in the reboot callback, disabling such
>> regulators
>> before the PMIC reset to avoid unintended voltage output.
>>
> This behavior is not reflected in mainline Linux, should it be?
> If it should, it seems to me the proper fix would be:
>
> 1) Add the functionality to set the regulators in Linux, like it is
> done in the BSP, as part of the reset handler.
>
> 2) Gate both the Linux functionality and U-Boot functionality behind
> a device-tree option. Unlike BSP, make it opt-in rather than opt-out
> (to preserve backwards compatibility with the existing mainline
> kernel).
>
> Let me know what you think and I can start this process.
>
> Thank you,
> Chris

I have synced this with the rockchip RK817 owner, and we suggest the 
second approach "Gate both ...".
Additionally, the RK BSP kernel will add parsing for the 
`not-save-power-en` property to control whether POWER_EN_SAVE0/1 is used.

>>>>> [1]https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c
>>>>>
>>>>> Signed-off-by: Chris Morgan<macromorgan@hotmail.com>
>>>>> ---
>>>>>     drivers/power/pmic/rk8xx.c | 11 -----------
>>>>>     1 file changed, 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>>>>> index 95b71d2fe49..16b3dc7cb1c 100644
>>>>> --- a/drivers/power/pmic/rk8xx.c
>>>>> +++ b/drivers/power/pmic/rk8xx.c
>>>>> @@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
>>>>>     	int ret = 0, i, show_variant;
>>>>>     	u8 msb, lsb, id_msb, id_lsb;
>>>>>     	u8 on_source = 0, off_source = 0;
>>>>> -	u8 power_en0, power_en1, power_en2, power_en3;
>>>>> -	u8 value;
>>>>>     	/* read Chip variant */
>>>>>     	if (device_is_compatible(dev, "rockchip,rk817") ||
>>>>> @@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
>>>>>     		off_source = RK817_OFF_SOURCE;
>>>>>     		init_data = rk817_init_reg;
>>>>>     		init_data_num = ARRAY_SIZE(rk817_init_reg);
>>>>> -		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
>>>>> -		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
>>>>> -		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
>>>>> -		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
>>>>> -
>>>>> -		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
>>>>> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
>>>>> -		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
>>>>> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>>>>>     		break;
>>>>>     	case RK806_ID: {
>>>>>     		u32 rst_fun = 2;
>> -- 
>> Best regards,
>>
>> 陈健洪 (Joseph Chen)
>> chenjh@rock-chips.com
>> 福州瑞芯微电子股份有限公司
>> Fuzhou Rockchip Electronics Co.Ltd
>> 福建省福州市铜盘路软件大道89号软件园A区21号楼 (350003)
>> No. 21 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
>> TEL：0591-83991906/07-8573
>>
-- 
Best regards,

陈健洪 (Joseph Chen)
chenjh@rock-chips.com
福州瑞芯微电子股份有限公司
Fuzhou Rockchip Electronics Co.Ltd
福建省福州市铜盘路软件大道89号软件园A区17号楼 (350003)
No. 17 Building, A District, No.89,software Boulevard Fuzhou,Fujian,PRC
TEL：0591-83991906/07-8573

