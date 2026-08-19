Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D53C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92BBB80BF0;
	Thu, 20 Aug 2026 03:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lMHALk5R0soR; Thu, 20 Aug 2026 03:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787198130;
	bh=rGkAYs8r70E3SAfgQh8WJhs7LVhz/yLPW+ADckJ22iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VjHxMz1jaJcMxvWvsyq3zwzAk7E8Wwi5AFyJnumuj5QJJK/FAy0Zo/LrZfv4nNIgL
	 XyOsuYSY6ag3grzcSPxoeYThatx9XCkaOZ+9Mk8BtDf/xR+OJFMqM3TyYzLPHsKdf8
	 CQwOGaAL9Ue/YjwyTe1BYJ4yDOtzrtj6trSGN2qlLMMI2LruuNFXPwSwCaNCrYcReX
	 M8Tja2kTN3uNesorhHt7bTAzBRKjyF3tP/so/Ss7NwWYZHhEAKWHxR/JiVivVHmEnq
	 g9ycwcWYdBdjKQ5JiG3WWQKwhXY/XhngOfSigw6+Bl/wdovBhKOwYxf19oGC3lHadM
	 h4dYO1S0iR9Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 035A680C31;
	Thu, 20 Aug 2026 03:55:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F3A1339E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E536460675
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wo24kanHUgv6 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:55:28 +0000 (UTC)
X-Greylist: delayed 64282 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 03:55:27 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=D/PWNbZx
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6566B60623
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 13EB511C4E3; Thu, 20 Aug 2026 05:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787198120;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=rGkAYs8r70E3SAfgQh8WJhs7LVhz/yLPW+ADckJ22iU=;
 b=D/PWNbZx5dx7uJsP+NXGwb3G2BMQkyzuVfpVvUxqA5g3Iv/xwEsYF543s/tAVKhT5pyDJs
 c95cKVAJM+6j1aBgfI68dLAgPPg0rL1cn/8F/YyfGLDAZHEyPq6oBFLgCW/4yjCN1Yfj0Q
 Cd4rUNpwxvwukAgSFWMBBuOXZOBNF9AmXNebyXw05ifQeao9UV8DLsBhqPGK0JAj4MPp3R
 aGPhGBRoJpR43sTj4IprvKeO4tjCm4SjDXAkqTf8bhta8dQdfxORw/UsSXz7OrhuLauz6/
 nct8cPsJXHJtqwfpw322vxocq29ubAMzEfQBLREMmSQvp6BSOj9yKbqltC4ZlQ==
Message-ID: <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
Date: Wed, 19 Aug 2026 14:47:31 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
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

On 8/19/26 12:10 PM, Frieder Schrempf wrote:
> On 19.08.26 12:04, Marek Vasut wrote:
>> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>
>>> In some cases we need to call ddr_init() multiple times to try
>>> different configurations.
>>
>> What different configurations ? Details please ?
> 
> The detection of different DDR types/sizes on our SoMs has always been
> based on trying the init and seeing if it succeeds, falling back to the
> smaller sizes on failure. See here [1].
Could you maybe bring the interface up in some minimal 400 MTps or 100 
MTps configuration and then read out the MR ID registers from the DRAM 
to discern which DRAM configuration is present on your SoM? This would 
be the ideal generic way of doing this, and it would be reliable since 
the IDs are stable and surely indicate which DRAM chip and how big it is.
