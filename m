Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BACCCD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93E384839;
	Fri, 22 May 2026 15:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RuZvjNl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737C0846F1; Fri, 22 May 2026 15:50:32 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E953F8486A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VJyelYMq8o98hON5iWUIFZQX8h586bJkndbtGDw1pgo=; b=RuZvjNl0r6RA97qDxYHy9Y7+s5
 ArKDuI+2YWVPDbasKKlkeqnuLv/SJ7LDJF87qXzIzS5amWjqrGkyYtDjMYTtIGADcv+eLUuDXbken
 8xW0u0lyg7zBOZB632ymc/CS409I4VIkrK7ruBaqi2KaLgeohkITYoApL3RV2QBe90R9zbG0usjKp
 Q+RsvEE1waHMOhLDKHMwDJE2249bgehKEjAiryU2Lq2fSwjgXf4iY0tS1iS25V3BJhngo2vQmFhy2
 FzonED0vNaqp8RTxBuJXxM0tLavKQYua6+OobuBTAStgPBf5Aw4p1zpwuG/XgUdm7qGRHw9m8ysAt
 GsXAU0Fg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wQQGh-0007sK-28; Fri, 22 May 2026 15:50:27 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wQQGg-000O3H-2l; Fri, 22 May 2026 15:50:27 +0200
Message-ID: <9292eda4-6d0e-46a3-b909-c57dcf770856@ew.tq-group.com>
Date: Fri, 22 May 2026 15:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "u-boot@ew.tq-group.com" <u-boot@ew.tq-group.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-9-Alexander.Feilke@ew.tq-group.com>
 <a1157d3794f49750aa51aa147057c7a3ae2e1a41.camel@siemens.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <a1157d3794f49750aa51aa147057c7a3ae2e1a41.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 12/05/2026 11:15, Sverdlin, Alexander wrote:
> Hi Alexander,
>
> On Mon, 2026-05-11 at 14:09 +0200, Alexander Feilke wrote:
>> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>>
>> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>> ---
>>  drivers/rtc/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 65d9bf533cb..1c703c1e229 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -163,6 +163,9 @@ config RTC_PCF85063
>>  	help
>>  	  If you say yes here you get support for the NXP PCF85063 RTC
>>  	  and compatible chips.
>> +	  Support for the following chip features is currently not implemented:
>> +	  - NVMEM
> I'm curious, what's missing in NVMEM implementation?

Linux exposes the REG_RAM register as NVMEM device, which is not done
in the current u-boot implementation
