Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D2C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A892878D7;
	Wed, 10 Jan 2024 14:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QtEXdfaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329D087732; Wed, 10 Jan 2024 07:02:08 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394CD876F6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-kapoor@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40A623l8056214
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 00:02:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704866523;
 bh=MyEpP0TANHKJzHg9XKWsfefS04jGsa/9fk5YqDB2vbc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QtEXdfaYxfiX6vM2zfX5+pfw2KMSyXfl5zieRPV45VQ0izelElDbSSnX6I3mJJFVG
 k5jV7KB2S7rd2ZVipZl7fmwx3OsgudP35p1H0tGsiIwwsKDRirLq/fb2WSPKJNWOPr
 OneciQGtqNJpPpnhtI0EijMXXnGwVSUkIPNpugag=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40A623KU015775
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 00:02:03 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 00:02:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 00:02:03 -0600
Received: from [10.24.68.175] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com
 [10.24.68.175])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40A620IY090786;
 Wed, 10 Jan 2024 00:02:01 -0600
Message-ID: <8a17f24b-62d3-4535-8433-02d3ff261331@ti.com>
Date: Wed, 10 Jan 2024 11:32:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: dts: Add Itap Delay Value For High Speed DDR
To: Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>, 
 <n-francis@ti.com>
References: <20240108051922.29044-1-b-kapoor@ti.com>
 <20240108140502.euuxmgutu4gcd7pn@bryanbrattlof.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240108140502.euuxmgutu4gcd7pn@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 10 Jan 2024 14:04:49 +0100
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


On 08/01/24 7:35 pm, Bryan Brattlof wrote:
> Hi Bhavya!
>
> On January  8, 2024 thus sayeth Bhavya Kapoor:
>> This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
>> J7200 SoC and for DDR50 speed mode for MMCSD in J721s2 SoC.
>>
>> Bhavya Kapoor (2):
>>    arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
>>    arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode
>>
>>   arch/arm/dts/k3-j7200-main.dtsi  | 1 +
>>   arch/arm/dts/k3-j721s2-main.dtsi | 1 +
> Because of the periodic syncs with the kernel, modifying these dt files
> in U-Boot will cause confusion. (Which node is correct why did we have
> to do this in U-Boot and not in the Kernel... bla bla bla) If they
> absolutely need to go in now please override these nodes in the
> *-u-boot.dtsi files with a comment so we can keep track of these changes
> during the next sync with Linux.
>
> ~Bryan

Hi Bryan, Fyi, This patch went in kernel as well.

Can be tracked below-

https://lore.kernel.org/all/170266085077.3490141.14935960940418963459.b4-ty@ti.com/

So , kernel and uboot dt files will remain in sync.

~B-Kapoor

