Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F0FCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE24584702;
	Tue, 26 May 2026 09:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="P5hgWps1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA6984843; Tue, 26 May 2026 09:06:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2628A8469D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=DuADxlV9k1GDGBSdEXHL00/8sJFv5qeHCoIjXsJDhZ8=; b=P5hgWps1/bkv0Fk4s+FfwZ4XJx
 rfg52nNbSAO0FIe5Dm0xUpbyFYrRnri65sfFx6i8AFeLceQUC3CdEkJR2QNdqOW5EtxEbEUMka8IB
 ig+sbFZBXZCn2uSPhel9QnUF4W6ACv4y0rf88IC2bzBzfAH9nIW0MVbRjDstdBAsOFZd3T6JwdwxB
 hSTK1GDfXvsMQQu3G8q6wIrwHwc1oy4XBrK1ij6ybBIQdfHqfIMs5BeVZIzWHuWMXlclUD6YuXrTs
 k7NU6WKj55uv6H1oimnFvSvr5GuN00ux8pa7WyYyOZSay1Kr7XFkNiXi/dNq8tXljzofZRtzaYkLS
 xVHLSB1w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wRlry-000Ivz-1v; Tue, 26 May 2026 09:06:30 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wRlrx-000Lqm-2Z; Tue, 26 May 2026 09:06:30 +0200
Message-ID: <1a6066e6-388c-477e-a684-4e7e82bc472e@ew.tq-group.com>
Date: Tue, 26 May 2026 09:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "trini@konsulko.com" <trini@konsulko.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
 <20260522153929.2472552-10-Alexander.Feilke@ew.tq-group.com>
 <494910afd80143f9c32483e8ba6c6d75057d497d.camel@siemens.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <494910afd80143f9c32483e8ba6c6d75057d497d.camel@siemens.com>
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



On 26/05/2026 08:51, Sverdlin, Alexander wrote:
> Hi Alexander,
>
> On Fri, 2026-05-22 at 17:39 +0200, Alexander Feilke wrote:
>> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>>
>> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>> ---
>>  drivers/rtc/Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 65d9bf533cb..3b74770b18a 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -163,6 +163,9 @@ config RTC_PCF85063
>>  	help
>>  	  If you say yes here you get support for the NXP PCF85063 RTC
>>  	  and compatible chips.
>> +	  Support for the following chip features is currently not implemented:
>> +	  - NVMEM device for RAM register
> I wonder if any dedicated "support" for REG_RAM is actually required in pcf85063 driver,
> taking into account commit c8ce7ba87d1560babc9f1436035cf2b332f4f603
> ("misc: Add support for nvmem cells") and the pcf85063 existing support for dm_rtc_read().
>
> I suppose the rest could be specified in the Device Tree?

Ah you are right, then this note can be dropped from the patch.

