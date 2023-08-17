Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77680C2FC14
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9FE86B2B;
	Thu, 17 Aug 2023 15:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VoHco6KY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0C686B2E; Thu, 17 Aug 2023 15:20:41 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB2486B24
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HDKZp0098504;
 Thu, 17 Aug 2023 08:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692278435;
 bh=ZV4ixFsDZ0wxdOqGY3SxiKfOuBaBwxhUR/bDnzhtXGk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VoHco6KYQzN6yGKa4M0D7EU+LvrlX4T2Dt0EuJeWBbpU+MQLPJ7aOZy2jt7YfkJ7F
 NfFXadWdP6Sne+6LyZLWLOlQ8rIykqrLn99R9mfA6q9uU0HLr2KSvfDH7zLH3YIX6M
 A0g2qSdf/ZpEW9tecmVSxdANmnDFL2lb5do4s1H0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HDKZaS065496
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 08:20:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 08:20:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 08:20:34 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HDKG7b019822;
 Thu, 17 Aug 2023 08:20:24 -0500
Message-ID: <47e38801-0aaf-a4a2-1424-7dbbcedcb4b0@ti.com>
Date: Thu, 17 Aug 2023 18:50:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
To: Nishanth Menon <nm@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-kumar1@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
 <20230816114445.c4c7rgdp5arhmiaq@polyester>
 <787c1106-f4ec-383b-14cf-d055ceebf86b@ti.com>
 <20230817113618.ssc6sfyzawdk5kis@ether>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230817113618.ssc6sfyzawdk5kis@ether>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 8/17/2023 5:06 PM, Nishanth Menon wrote:
> On 09:45-20230817, Kumar, Udit wrote:
>> On 8/16/2023 5:14 PM, Nishanth Menon wrote:
>>> On 14:53-20230816, Manorit Chawdhry wrote:
>>>> The following commit syncs the device tree from Linux tag
>>>> next-20230815 to U-boot and fixes the following to be compatible with
>>>> the future syncs -
>>> [..]
>>> +&mcu_timer0 {
>>> +		/delete-property/ power-domains;
>>> +		/delete-property/ assigned-clocks;
>>> +		/delete-property/ assigned-clock-parents;
>>> NAK - this should come in from R5 data.
>> Having clock data for R5 will not help atleast for  timer.
>>
>> As timer is getting probed before the clk frame work comes up ,
>>
> Well, u-boot framework is no different in AM625, is'nt it?
> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/k3-am625-sk-u-boot.dtsi#L28
>
> it does work. tells me there is some thing we are'nt pinpointing here.

This is what I am wondering, how AM625 works.

I don't see clock-data for main_timer0 in clk-data.c file.


Also if clock-frame is being used, I see no need of below

clock-frequency = <25000000>;


>
