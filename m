Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B5C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32CAB80B56;
	Thu, 20 Aug 2026 09:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZrOU167CV1C; Thu, 20 Aug 2026 09:11:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787217114;
	bh=I2yQA+VWBiHuk7NDSPCtYNNCQsfah7CPUhGXiWpyoGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kjaNbUpKD+zO0lvl4oJFWtWdFWIjV+OlmlYpnUQQL4ovJ1le5nT4BY1x6rC3NY/7U
	 IKBODbty2AuCc++lQkY/d69y0c0+yxiGtxPOxuxVwqZpCkWKh0s+DF9jHavXC3ZNho
	 ITmZ057GbXzVtK13FOwPtC1pyiPvfyCtPqL11ZxBhkRlXbTB92f4ZyfJlnntCMYIci
	 h8OLfOlATLPuwr0tomfw3OPNTPe4T5ectMLddgPnZYqa486D3+WElafyEOwGnFSJAG
	 qpAWWIJuXwOkW0W9j8j5yEXrZMWjmQrfSX2skoh3YJlFjfPGgMd8GLTj4LaBs7OKVy
	 +aFeT4M7/O55Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D54080B78;
	Thu, 20 Aug 2026 09:11:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC2A229D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91AD74058A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TSDDf9Zb93dg for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:11:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=M1ghjIDG
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42DD24057C
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:11:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2FDC11C3FB; Thu, 20 Aug 2026 11:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787217102;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=I2yQA+VWBiHuk7NDSPCtYNNCQsfah7CPUhGXiWpyoGc=;
 b=M1ghjIDGHAl51p5VtGDKTGDTSEYcVh8ibKkd/d2P3WV3/CcZPAB+nTVOZtE74JiVetAZZ1
 a3ogHFzR7BYHWmziZR/LqVqFPUjBW31oWK/TdV7Yeev0+0GAeOYlCcQNiXA1xKrhoepdkA
 oiqkON/hl8oGU8jVbSdGd/aVQ5GzRqiDjofRKNZfQEtkZMnJcvDD7mgXxbi1S3IlbD2B3I
 BkX+fM4z4JU0cMRQDcF23mzGS7lhLPpxLfHjCmYQe6pKTXU0KMcCpxEgNsPyaqAHm3/njw
 x+IsEjNya1RYYjwSv+DdkjPuiZWG0Qdw5X+brgtYWaDferzFYiDNlcecvw+L6g==
Message-ID: <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
Date: Thu, 20 Aug 2026 10:05:18 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
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

On 8/20/26 8:34 AM, Frieder Schrempf wrote:
> On 19.08.26 14:47, Marek Vasut wrote:
>> On 8/19/26 12:10 PM, Frieder Schrempf wrote:
>>> On 19.08.26 12:04, Marek Vasut wrote:
>>>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>>
>>>>> In some cases we need to call ddr_init() multiple times to try
>>>>> different configurations.
>>>>
>>>> What different configurations ? Details please ?
>>>
>>> The detection of different DDR types/sizes on our SoMs has always been
>>> based on trying the init and seeing if it succeeds, falling back to the
>>> smaller sizes on failure. See here [1].
>> Could you maybe bring the interface up in some minimal 400 MTps or 100
>> MTps configuration and then read out the MR ID registers from the DRAM
>> to discern which DRAM configuration is present on your SoM? This would
>> be the ideal generic way of doing this, and it would be reliable since
>> the IDs are stable and surely indicate which DRAM chip and how big it is.
> 
> No, unfortunately this doesn't work. We already tried. The MR ID can't
> be used as we have single and dual rank setups that report the same ID.
> We have no way of knowing how many dies are connected unless we try it.

Is the controller unable to interact with each rank separately ? I would 
expect in single rank setup, that read of MR ID from one rank would pass 
and from the other rank it would fail ?
