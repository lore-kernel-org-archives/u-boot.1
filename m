Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC373C5DF81
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 02:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13C58607E2;
	Fri, 21 Aug 2026 02:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wLZTMuW8TLFN; Fri, 21 Aug 2026 02:25:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787279106;
	bh=YfCcN7M1kn6leTKyuoCRzgQzuG28V3xx/iclmKbOjhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rhrt1dqXdCvm85qwliSWaKihManWD2UacUPt4pharZUZ66Tpy46LIJk6R6Bma6fq0
	 tLhSm5UOLVEJwgQzmCgSbGseW7sPUFqWRm/w/kymYxDjd5PVv4D6LHJjlgLajrZlCZ
	 3VpGJF2Ke4hJAi4ZQvghtwFDCRuxhTF3HL2Ip74poUTeyRwVsLr0WaB1u2iEtzIOCq
	 4zvIG1HqxPXwL3ZyvaS0d15SQkPJ6uDc6Hn6gTPmwiLepTW1hNxZ6NrEAHXwImV2TA
	 vrPW0ZlX/GJO6zFds9otj2S4AZkFvTCbRd1DERhKBlZmA/xWgSyfTytypoF8QBOVWg
	 QWqxWP/Pz8gHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F18E6071E;
	Fri, 21 Aug 2026 02:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 753B3336
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EA5980F8B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbzxcogntBdw for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 02:25:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=kE8UmpvN
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EA5780F86
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B364011C606; Fri, 21 Aug 2026 04:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787279096;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YfCcN7M1kn6leTKyuoCRzgQzuG28V3xx/iclmKbOjhY=;
 b=kE8UmpvNO+n56+1yLi+IYFOs+FNy3ouK7mFJH0c8u+B+cNWPCrbXbIp54BpNeRGo3Rpfkj
 ylpVIRplq8spYhVlMnnxgES0A6oBsOQBcCyMF3S0h+KQ5vcwmiNP8+usbYHG5+SdAsuWoE
 y8iBDmBkCpt1dTUhRQll93t9I80Su3IlYBV1HUDnkMCIcgPPJFWPHZywTtjgHc4Qbh0azH
 TAtXE7cnLL5fgKidylqazh+0haeMUkm42aj74JhYMER82jKIgoJxNwi3IL3lFwjGrIjnWu
 H09xgoL7/ELwoKyOtFGGKRIit/NFBu2r3BqaIkGsqPReZ630i2c/lFHme3nQSQ==
Message-ID: <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
Date: Thu, 20 Aug 2026 17:25:39 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
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

On 8/20/26 4:25 PM, Frieder Schrempf wrote:
> On 20.08.26 10:05, Marek Vasut wrote:
>> On 8/20/26 8:34 AM, Frieder Schrempf wrote:
>>> On 19.08.26 14:47, Marek Vasut wrote:
>>>> On 8/19/26 12:10 PM, Frieder Schrempf wrote:
>>>>> On 19.08.26 12:04, Marek Vasut wrote:
>>>>>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>>>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>>>>
>>>>>>> In some cases we need to call ddr_init() multiple times to try
>>>>>>> different configurations.
>>>>>>
>>>>>> What different configurations ? Details please ?
>>>>>
>>>>> The detection of different DDR types/sizes on our SoMs has always been
>>>>> based on trying the init and seeing if it succeeds, falling back to the
>>>>> smaller sizes on failure. See here [1].
>>>> Could you maybe bring the interface up in some minimal 400 MTps or 100
>>>> MTps configuration and then read out the MR ID registers from the DRAM
>>>> to discern which DRAM configuration is present on your SoM? This would
>>>> be the ideal generic way of doing this, and it would be reliable since
>>>> the IDs are stable and surely indicate which DRAM chip and how big it
>>>> is.
>>>
>>> No, unfortunately this doesn't work. We already tried. The MR ID can't
>>> be used as we have single and dual rank setups that report the same ID.
>>> We have no way of knowing how many dies are connected unless we try it.
>>
>> Is the controller unable to interact with each rank separately ? I would
>> expect in single rank setup, that read of MR ID from one rank would pass
>> and from the other rank it would fail ?
> 
> I'm not sure, but even if it would work, it would require several
> separate init attempts only to read the IDs

Why ? Init the bus in slowest mode with widest bus settings, then try 
MRRD on all available DRAM chips, then figure out which ones report 
valid IDs and which ones fail the MRd .

>, so I'm not sure if there is
> any benefit.

Generic solution that surely works and does not guess the DRAM size.

> Also I'm not seeing anyone doing this kind of thing. It
> might be worth looking at, but my primary goal now is to land patch 1 of
> this series in order to fix the regression.

What regression ? (I was not CCed on that)

You can (=should) send bugfixes separately.
