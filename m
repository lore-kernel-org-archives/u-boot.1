Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC149C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64CA5406E5;
	Thu, 27 Aug 2026 09:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWQI1DbHh-EG; Thu, 27 Aug 2026 09:50:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787824228;
	bh=DMySgr28lJjvuH/0jOFc4c+EURb/gDU1lX1tm3H37Yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRNr9Jx+iLFuNOcoOkITtokcD2NYDVYlXEa7jReD2blwcU7kPplMUXDw5zLg0hqbP
	 mqzWb8OiwG4oD1na+zWnXgrMwArGmyqHrq9N835EjIsyQPA2diqFpk+5SLNMwvuCQW
	 0IXbnll9RkXD/S114M/u/eEdhP/T2l9q/QJ6t7fQgFxpaNDSXS7BI8YKpE2ek5kBcM
	 XkFq99yUSddqOT+5zFJMvd5h54M4hwKXedvrfVqRdLx4vBr0MOAMraV9dgyMc9OaGA
	 AzBMfDkdXV57aEDsJwWuoTUmSzAf6U4zhr/kBYNuw8l3TC4Ye/clsh4VLVE1sh3yb8
	 PZJZp8TCBYFZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE824406B2;
	Thu, 27 Aug 2026 09:50:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CB373A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3244080DC6
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6d2h5_7s3RU for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:50:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Km2MwKEl
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BF4E807EF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 02B7311C4CB; Thu, 27 Aug 2026 11:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787824216;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=DMySgr28lJjvuH/0jOFc4c+EURb/gDU1lX1tm3H37Yw=;
 b=Km2MwKElrA/XsVcN79qzs1bB312lp1EkZucQmNbLBEaDiNPegxahgl7btVBUL9afKq2zNw
 KodRb/KHPQ2NuvCF5ZEudKFA7DW1ttDakBu6/Vzxs40PIsSSjgulWnTcGw/DD9EJ22f4jX
 nSsujY/26UdZZa/h30VfKXLVWdxXTRZk/LGdvNdEvOxgWobOJhRUh7eVmktSJP6EVqIAU5
 GzkHggKHb+p0c3iq6AbbPUnbEoW4prSh22+BIoOh7wuGDES11GPAgMCekCtA4+YVJJsT8j
 5hLxNWONm7Q0CgjzbAlaB9OOrhOACNRB0836u3QXLFRFPR7kFIe7aXxrmYJOnA==
Message-ID: <ae6f34f9-ec68-42e3-8483-4208d6e2e883@nabladev.com>
Date: Wed, 26 Aug 2026 14:24:48 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <59ed6576-06dd-42bf-8ea2-18de427955a4@kontron.de>
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

On 8/26/26 10:12 AM, Frieder Schrempf wrote:

[...]

>>> I'm not sure, but even if it would work, it would require several
>>> separate init attempts only to read the IDs
>>
>> Why ? Init the bus in slowest mode with widest bus settings, then try
>> MRRD on all available DRAM chips, then figure out which ones report
>> valid IDs and which ones fail the MRd .
> 
> As far as I can see this doesn't work. If we use the widest bus setting
> (CsPresent=0x3) on a single rank module, the training fails and the DDR
> remains in a state where the MR read doesn't work yet.

Do you need training to read the IDs ? Simply force-use the slowest bus 
mode (100 MTps iirc), the training is only relevant for the high-speed 
modes.

[...]
