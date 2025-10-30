Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87066CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8EC838D5;
	Thu, 30 Oct 2025 17:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AeWNO1sQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A53838CE; Thu, 30 Oct 2025 17:57:04 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DEA836D3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cy9JC6fy6z9t2V;
 Thu, 30 Oct 2025 17:56:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761843419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Xwh6o1PU7uF6H1SQr5tsKEnT0IAdv02BRzpHwPbJ7M=;
 b=AeWNO1sQu3+v42V68Ysgsj8p1BnGWnl8diIqqW+/c0ccFqB8QmDiPpxecaxAihXBHkeH5m
 AK5bCdd8DcXyZA8kZQXOG/Ik6savuulivtLyZuMQrtzjgaGKqgY3voTXqL0cVXFEgxP1An
 qZKuUmS/N0FkTTnO2cFLe9VVbSgHBfSdgovvfKjOmhCkjTrc6V+AxcEuI+GQn3lgzNA3yx
 dJ4z9NEP2rJFmjlEO9Bf98XLg93IOGKarwL7AWl3/DKHuGEO+RY6NH4eNPCN6f63t1IiUp
 e6//jnJJy1A9vsHq/Ixm71uCLvRd1VHMmxB6c02rjq20mf9Q+ztsNOhAD5q6SA==
Message-ID: <eca51372-3bcd-4873-ba47-c06781d18466@mailbox.org>
Date: Thu, 30 Oct 2025 14:58:25 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0hdIGZpcm13YXJlOiBzY21p?=
 =?UTF-8?Q?=3A_Drop_mmu=5Fset=5Fregion=5Fdcache=5Fbehaviour=28=29_misuse?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
 <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB964488C508F283B14E8B9B11E2FBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: morqzor7mq1rmqzsz6jwrzggq8rsxpzx
X-MBO-RS-ID: ae475291ccbc16ca2c9
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

On 10/30/25 4:58 AM, Alice Guo (OSS) wrote:

Hello Alice,

>>>> diff --git a/drivers/firmware/scmi/smt.c
>>>> b/drivers/firmware/scmi/smt.c index
>>>> 237871559f0..cd1c0801f72 100644
>>>> --- a/drivers/firmware/scmi/smt.c
>>>> +++ b/drivers/firmware/scmi/smt.c
>>>> @@ -61,20 +61,6 @@ int scmi_dt_get_smt_buffer(struct udevice *dev,
>>>> struct scmi_smt *smt)
>>>>    	if (device_is_compatible(dev, "arm,scmi") &&
>>>> ofnode_has_property(dev_ofnode(dev), "mboxes"))
>>>>    		scmi_smt_enable_intr(smt, true);
>>>>
>>>> -#ifdef CONFIG_ARM
>>>> -	if (dcache_status()) {
>>>> -		u32 align_size;
>>>> -
>>>> -		if (IS_ENABLED(CONFIG_ARM64))
>>>> -			align_size = PAGE_SIZE;
>>>> -		else
>>>> -			align_size = MMU_SECTION_SIZE;
>>>> -
>>>> -
>>>> 	mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf,
>>>> align_size),
>>>> -						ALIGN(smt->size, align_size), DCACHE_OFF);
>>>> -	}
>>>> -#endif
>>>> -
>>>>    	return 0;
>>>>    }
>>>>
>>>> --
>>>> 2.51.0
>>>
>>> Tested-by: Alice Guo <alice.guo@nxp.com>
>>>
>>> Tested on two boards: IMX94 and IMX95. No regressions were observed
>> during boot. Looks good to me.
>> Thank you !
> 
> Hi Marek,
> 
> Applied this patch on the U-Boot NXP tree and found that it affects the i.MX8ULP. On i.MX8ULP, the SCMI buffer is in SRAM and mapped as normal memory.

Thank you for testing, this helps greatly !

Would it be possible to fix up the SRAM mapping in:

arch/arm/mach-imx/imx8ulp/soc.c:static struct mm_region 
imx8ulp_arm64_mem_map[] = {

?

-- 
Best regards,
Marek Vasut
