Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC371C61DC4
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 01:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06E0880EC0;
	Fri, 28 Aug 2026 01:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IrD1wOXzvK06; Fri, 28 Aug 2026 01:21:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787880097;
	bh=yoP6VEGX2qKT4fJJ41ckjTBIoHRo/cpY0rQo5BL3F5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PKqABShN6vuqH8TgLZ3yYIrv+80hf/MMoexaapc58l8QcDNBpfT5ZRRMxqlz0nS/B
	 WaYHtgS3UCgdAOUAxQLrUNpjCM8p5Xm4t3KyEOlKoV6iB740L0FI+w85E5g9gzCs7H
	 hvAE/f9hVwysYM8nS9Vqsfgw2iJxDxJ4Kqf/yZKQprxZgFUTpP3CXMdzDxGFL78KDh
	 9sIutfEswV/X4bN/W9VskGJq+4Wtm749EVUFZ2cKY/nnxIiBxZQ856LDcKbxUHMzXP
	 Lak/rs5WWIPmvj64CM0IRuZ5lgFJsejnhkHKNUlM/oxAdgKeHguLbmOqwYFUwMR5xv
	 mQHUIpqPSnuaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3780D80EF7;
	Fri, 28 Aug 2026 01:21:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E6EBB75
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D88A440063
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wm7zf-FxvIOK for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 01:21:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=DT/+e537
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C23B74005C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 01:21:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58D1511BDE6; Fri, 28 Aug 2026 03:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787880087;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=yoP6VEGX2qKT4fJJ41ckjTBIoHRo/cpY0rQo5BL3F5M=;
 b=DT/+e5373uCTY88e5m6Jl2JmLZLvIcsFMu26DVl8YUhvnkLu+0YGy5VBGBnHUrGyPhvS1o
 zMfrPXoRf0AyX4TGu0eewj+4ICht3H025FAmNn1CUFP+r5f6Zfd2Pk6j4RucPoqOkv2EkJ
 OjiVFOIyI8G19+MddnBABh7sYRprFMTaDWVSqZVGg7fLO1C5W/SyE0JXNopuKDLzjfKs2o
 G7ReKAOCtNm3FVauiVo33JuBLNydzVTEdLJ2RhSN1yJbLFOHU6WYRa/B0A0degUKh1g0tq
 lBIyIswX0kyXL8a6V21i7+l6boIa0PvXRFlJmefquKPYtJFEa5bTUhuGRu/foA==
Message-ID: <36740ee5-9cac-4bd4-a67a-3ab5cffe9691@nabladev.com>
Date: Thu, 27 Aug 2026 19:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
 <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
 <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
 <59ed6576-06dd-42bf-8ea2-18de427955a4@kontron.de>
 <ae6f34f9-ec68-42e3-8483-4208d6e2e883@nabladev.com>
 <5ef02e5a-c0ac-4afb-b90d-4d6d075b05e6@kontron.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <5ef02e5a-c0ac-4afb-b90d-4d6d075b05e6@kontron.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/27/26 3:35 PM, Frieder Schrempf wrote:
> On 26.08.26 14:24, Marek Vasut wrote:
>> On 8/26/26 10:12 AM, Frieder Schrempf wrote:
>>
>> [...]
>>
>>>>> I'm not sure, but even if it would work, it would require several
>>>>> separate init attempts only to read the IDs
>>>>
>>>> Why ? Init the bus in slowest mode with widest bus settings, then try
>>>> MRRD on all available DRAM chips, then figure out which ones report
>>>> valid IDs and which ones fail the MRd .
>>>
>>> As far as I can see this doesn't work. If we use the widest bus setting
>>> (CsPresent=0x3) on a single rank module, the training fails and the DDR
>>> remains in a state where the MR read doesn't work yet.
>>
>> Do you need training to read the IDs ? Simply force-use the slowest bus
>> mode (100 MTps iirc), the training is only relevant for the high-speed
>> modes.
> I don't see any existing code path for any i.MX with DDR4 that doesn't
> do the training before accessing MR registers. Do you have any
> references or examples? Do you have any sources for the claim that the
> training is only relevant for the high-speed modes? I couldn't find
> anything that supports this.

What happens if you simply skip the DDR training, return 0 from 
ddr_cfg_phy() ?

> Also I would assume that doing the MRRD on an unused CS would give me
> back some arbitrary random values. While I could interpret an unknown
> value as "rank/cs not present", I don't think its reliable enough. Or do
> you know of any error condition being reported for failed MRRD?

Try it and see what happens ?
