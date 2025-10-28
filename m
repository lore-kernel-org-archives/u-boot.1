Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE72CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC6A832AD;
	Tue, 28 Oct 2025 15:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mYGuqabJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Kh45EWYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21C9836D1; Tue, 28 Oct 2025 15:38:46 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98E080422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwtKc46Rcz9tVV;
 Tue, 28 Oct 2025 15:38:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761662324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ep/WRai9hwlXy2SnZFAGeNYllyp83jM14Y46hz3+IVA=;
 b=mYGuqabJSh3aQ7ra1cKAVlV48kZEBXO6o/bTCY720jwGLJnvk0LMK7KCuOWsFcrGeW1tiF
 w0B9eyhp6FmN6oPWMaNWk34vrHhcsIocL4JOBpnhkf/wijpArJKsWXGZjMlHuwnF9NEoAH
 TK17dZ46af7XNnnPHKjNqS6IJcwqjhiSKnKo6WgKRfFlmjTzgRFOJjMciVCg5c0gHQNZXM
 1tNqToJKf0t1QwfCPEiHhNKz7d9SLNbwHXIQYqcCq4KFHKtk3RCzU0c6Tcc0jmnZj6nEkO
 QsNtuyxM5JG7d6nB+oKM7qvoOjr2DxfM+8EwpIx2uShJSxhkC0ZqYeajk0yd4Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Kh45EWYl;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e7063153-036d-4079-b9c0-252a5d1eb364@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761662322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ep/WRai9hwlXy2SnZFAGeNYllyp83jM14Y46hz3+IVA=;
 b=Kh45EWYlEIb09aU5AjkFeZnbzzYK3z6f6NX+2rdZkv4Q7QlSBc5jllDAkAOD2ZFZf7swnz
 oE/8tAXFMDdmGjqTipUUy36xBQifQrLeqwB5qz03Z2on/4+JRQS9ug//sdnWiGPlJ7NWvT
 4Yve+83I2ekedNIX081v2XRteKOWCDswUMYkBw7gjO6evrEVvQqDsW0cNonGx9gXcfGid+
 AwDo7KAsi2bmwGPPcQg2Jlr3PmXofmXNXpkaXygK40PNloZYDYfkJi9SsU2/ASZSA27HmZ
 MmASXJidFWoXBHLQkcef22GWOLtP2AQnoJy6xeyO6zYT6KFNW830BcH7H4uGEg==
Date: Tue, 28 Oct 2025 15:38:39 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRHJvcCBt?=
 =?UTF-8?Q?mu=5Fset=5Fregion=5Fdcache=5Fbehaviour=28=29_misuse?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644A04B5499EA2BDC3130A7E2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fn9dm5bw7cjfu544751pygmm5q489414
X-MBO-RS-ID: 7a0c2a1cf9894ef5339
X-Rspamd-Queue-Id: 4cwtKc46Rcz9tVV
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

On 10/28/25 9:00 AM, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: U-Boot <u-boot-bounces@lists.denx.de> 代表 Marek Vasut
>> 发送时间: 2025年10月26日 5:35
>> 收件人: u-boot@lists.denx.de
>> 抄送: Marek Vasut <marek.vasut+renesas@mailbox.org>; Alice Guo
>> <alice.guo@nxp.com>; Etienne Carriere <etienne.carriere@linaro.org>; Patrick
>> Delaunay <patrick.delaunay@foss.st.com>; Peng Fan <peng.fan@nxp.com>;
>> Tom Rini <trini@konsulko.com>; Vinh Nguyen <vinh.nguyen.xz@renesas.com>;
>> Viorel Suman <viorel.suman@nxp.com>; Ye Li <ye.li@nxp.com>
>> 主题: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
>> misuse
>>
>> MMU region cache behavior configuration for SCMI/SMT mailboxes is platform
>> specific. Even on ARM systems, the mailbox memory may not even be located in
>> any cacheable MMU region and may instead reside in some SRAM. Remove this
>> non-generic cache behavior configuration code from generic code path.
>>
>> It is unlikely that any platform is affected by this change if it did configure its
>> MMU regions correctly on start up. Platforms which might be affected are
>> i.MX94/95 and STM32MP.
>>
>> Fixes: 240720e9052f ("firmware: scmi: mailbox/smt agent device")
>> Fixes: 2a3f161c8b16 ("scmi: correctly configure MMU for SCMI buffer")
>> Fixes: b2ae10970d40 ("firmware: scmi: use PAGE_SIZE alignment for ARM64")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Etienne Carriere <etienne.carriere@linaro.org>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>> Cc: Viorel Suman <viorel.suman@nxp.com>
>> Cc: Ye Li <ye.li@nxp.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/firmware/scmi/smt.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c index
>> 237871559f0..cd1c0801f72 100644
>> --- a/drivers/firmware/scmi/smt.c
>> +++ b/drivers/firmware/scmi/smt.c
>> @@ -61,20 +61,6 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct
>> scmi_smt *smt)
>>   	if (device_is_compatible(dev, "arm,scmi") &&
>> ofnode_has_property(dev_ofnode(dev), "mboxes"))
>>   		scmi_smt_enable_intr(smt, true);
>>
>> -#ifdef CONFIG_ARM
>> -	if (dcache_status()) {
>> -		u32 align_size;
>> -
>> -		if (IS_ENABLED(CONFIG_ARM64))
>> -			align_size = PAGE_SIZE;
>> -		else
>> -			align_size = MMU_SECTION_SIZE;
>> -
>> -
>> 	mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf,
>> align_size),
>> -						ALIGN(smt->size, align_size), DCACHE_OFF);
>> -	}
>> -#endif
>> -
>>   	return 0;
>>   }
>>
>> --
>> 2.51.0
> 
> Tested-by: Alice Guo <alice.guo@nxp.com>
> 
> Tested on two boards: IMX94 and IMX95. No regressions were observed during boot. Looks good to me.
Thank you !
