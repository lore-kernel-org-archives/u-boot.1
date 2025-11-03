Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32760CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8AED82A9E;
	Tue,  4 Nov 2025 00:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lvcb8nlr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SW1TmRZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FFC838D7; Tue,  4 Nov 2025 00:03:30 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D4138144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d0nFD2TnTz9srB;
 Tue,  4 Nov 2025 00:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762211008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rm1tRgC3UMpWL71h4aQ+k8CylaCBmwutqe8nFyjVOvM=;
 b=lvcb8nlr217bQMoRHCRGVl3fbOWHBisPIwN59wpHt1D431t8AYtk56qKZxeCdVjAhvCdba
 xjYkwja4XC0V1Be/m2i+E4enJUwa0xWMLLZxygBCyEldaiZAcCajl4fpLLWLwAHtjPVqVo
 C1LZDcXfHsZZE7Vm5IbkqBax1OPOC122On5kMmRzTLJlKCeVv+1qy/KzICO/squqG2ZJS6
 +/aKqsofCW8bGqMRmmNbKQJ1yV/yOXH/EkObz53NMTKubF8wpv7SQO2JtTPjhaZDKpJHzk
 pomEKXMEIQjrUq7SCek5J4yJTdbWKZvC8l+RJgAs2ro88MLP8PSnvIakenCvVA==
Message-ID: <79277db1-c6d6-4fc5-b197-220e58dc0ce8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762211006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rm1tRgC3UMpWL71h4aQ+k8CylaCBmwutqe8nFyjVOvM=;
 b=SW1TmRZwnnYn6ynpLD/OwSVMFepjy0v462VuB2FB0s2IKLprVmsk7O1nRu/vBiUppwG70S
 QmGskFRdsakL6O1tMnYrEqjFMPN7PqIQBCvUv9JQFu9GLlEjZCv/8OflUa9lgVm0ZQEadO
 BPgW4VKm1RJ1gSpHeVmdb8BiwbBZc4E8kpZT/IePBMaYB8EaVJstIvPz8RQw5QkD7ADMyQ
 hjKaHOXYLBQ6cfoh74ilEG6Qe3pef83BPzeMYRdW2A5bsQ5S8hKqMPB4NWXL+5FkhLSEi/
 MJGlHxGPxbYALeVXhu+gFPl7yRjeVV27iDeuleWFCX2d9dWQ63KoZzcdnBPQAw==
Date: Mon, 3 Nov 2025 23:58:53 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjJdIGZpcm13YXJlOiBz?=
 =?UTF-8?Q?cmi=3A_Add_clock_v3=2E2_CONFIG=5FSET_support?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Alice Guo <alice.guo@nxp.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
References: <20251027135856.8909-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644989432FCE67C8B8F87BEE2FAA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <90fe8028-7e13-4434-bc9d-318b4e778c59@mailbox.org>
 <PAXPR04MB96441DDF7341ABBC54993642E2C7A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB96441DDF7341ABBC54993642E2C7A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b5be7e25c2811cd62fa
X-MBO-RS-META: dmr1i3776bthdr76ps4trxrabx58q46c
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

On 11/3/25 10:25 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marek.vasut@mailbox.org>
>> 发送时间: 2025年11月3日 1:39
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Marek Vasut
>> <marek.vasut+renesas@mailbox.org>; u-boot@lists.denx.de
>> 抄送: Vinh Nguyen <vinh.nguyen.xz@renesas.com>; Alice Guo
>> <alice.guo@nxp.com>; Cristian Marussi <cristian.marussi@arm.com>; Patrice
>> Chotard <patrice.chotard@foss.st.com>; Patrick Delaunay
>> <patrick.delaunay@foss.st.com>; Peng Fan <peng.fan@nxp.com>; Sean
>> Anderson <seanga2@gmail.com>; Tom Rini <trini@konsulko.com>; Valentin
>> Caron <valentin.caron@foss.st.com>; Ye Li <ye.li@nxp.com>
>> 主题: Re: 回复: [PATCH v2] firmware: scmi: Add clock v3.2 CONFIG_SET support
>>
>> On 10/29/25 9:54 AM, Alice Guo (OSS) wrote:
>>
>> Hello Alice,
>>
>>> I tested this patch on IMX95 and here is the log:
>>> U-Boot SPL 2026.01-rc1-00001-g9bb6f2fc0f57 (Oct 29 2025 - 16:42:02
>>> +0800) SYS Boot reason: por, origin: -1, errid: -1 Normal Boot Trying
>>> to boot from MMC2 Primary set selected Load image from MMC/SD 0xd7000
>>> NOTICE:  BL31: v2.12.0(release):android-16.0.0_1.0.0-rc2-2-ga266ff458
>>> NOTICE:  BL31: Built : 10:13:07, Oct 17 2025
>>>
>>>
>>> U-Boot 2026.01-rc1-00001-g9bb6f2fc0f57 (Oct 29 2025 - 16:42:02 +0800)
>>>
>>> CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz
>>> Model: NXP i.MX95 19X19 board
>>> DRAM:  15.8 GiB
>>> Core:  283 devices, 24 uclasses, devicetree: separate
>>> MMC:   "Synchronous Abort" handler, esr 0x96000006, far 0x0
>>> elr: 0000000090233fac lr : 0000000090233f60 (reloc)
>>> elr: 00000000fff4dfac lr : 00000000fff4df60
>>> x0 : 0000000000000004 x1 : 00000000fdf089c8
>>> x2 : 000000000000000c x3 : 00000000fdf19f18
>>> x4 : 000000000000001f x5 : 0000000000000000
>>> x6 : 00000000000013f0 x7 : 00000000fdf08bb0
>>> x8 : 00000000000013e0 x9 : 00000000fdf087fc
>>> x10: 0000000000000003 x11: 00000000000013c0
>>> x12: 0000000000000000 x13: 00000000fdf08bb0
>>> x14: 00000000fffffffb x15: 0000000000000002
>>> x16: 00000000fff6887c x17: 0000000000000000
>>> x18: 00000000fdf19dd0 x19: 00000000fdf2c640
>>> x20: 0000000000000001 x21: 0000000000000000
>>> x22: 00000000fffa7750 x23: 00000000fdf29f30
>>> x24: 00000000fdf2dd58 x25: 0000000000000000
>>> x26: 0000000000000000 x27: 0000000000000000
>>> x28: 0000000000000000 x29: 00000000fdf08950
>>>
>>> Code: f90047e2 f9004be1 9101e3e1 f9004fe0 (b94002a0) Resetting CPU ...
>>>
>>> resetting ...
>>>
>>> Store the protocol version in a global variable "ver" during probe, and use it in
>> scmi_clk_gate() instead of accessing priv->version. In this setup, the IMX95
>> board boots successfully.
>>
>> No global variables please.
>>
>> How does this crash even happen on MX95 ? I verified that the private data are
>> the same pointer in both probe and scmi_clk_gate(), so is the parent device. I
>> think this is either not the case for MX95 (how would that happen?) or the
>> private data or device is NULL or something ? Can you please apply the diff
>> below and share the output ?
>>
>> "
>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c index
>> 005968e8b75..dcc71ea4225 100644
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -137,6 +137,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int
>> clkid, char *name,
>>    static int scmi_clk_gate(struct clk *clk, int enable)
>>    {
>>    	struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
>> +printf("%s[%d] dev=%px / %px priv=%px\n", __func__, __LINE__, clk->dev,
>> clk->dev->parent, priv);
>>    	struct scmi_clk_state_in_v1 in_v1 = {
>>    		.clock_id = clk_get_id(clk),
>>    		.attributes = enable,
>> @@ -335,6 +336,8 @@ static int scmi_clk_probe(struct udevice *dev)
>>    	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
>>    					    &priv->version);
>>
>> +printf("%s[%d] dev=%px priv=%px\n", __func__, __LINE__, dev, priv);
>> +
>>    	/* register CCF children: CLK UCLASS, no probed again */
>>    	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
>>    		return 0;
>> "
>>
>> Thank you !
> 
> U-Boot 2026.01-rc1-00200-gf99ba9c02db2-dirty (Nov 03 2025 - 16:40:03 +0800)
> 
> CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz
> Model: NXP i.MX95 19X19 board
> DRAM:  15.8 GiB
> scmi_clk_probe[301] dev=00000000fdf1e190 priv=00000000fdf20030
> scmi_clk_gate[138] dev=00000000fdf2a390 / 00000000fdf1e190 priv=00000000fdf20030
> scmi_clk_gate[138] dev=00000000fdf24210 / 00000000fdf1e190 priv=00000000fdf20030Core:  283 devices, 24 uclasses, devicetree: separate
> MMC:   scmi_clk_gate[138] dev=00000000fdf2c690 / 00000000fdf20c50 priv=0000000000000000
> "Synchronous Abort" handler, esr 0x96000006, far 0x0
Thank you for that. Can you please test V3 and let me know whether the 
problem persists ? I suspect it should be fixed now that we use the SCMI 
device pointer in the driver.
