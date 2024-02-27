Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AABEC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 11:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482CC87FFA;
	Tue, 27 Feb 2024 12:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u6IvXM34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3812587FEE; Tue, 27 Feb 2024 12:24:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2EAB87F64
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 12:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RBODQB037585;
 Tue, 27 Feb 2024 05:24:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709033053;
 bh=QImEEQKpYW2qXe5+tWCF4J3le3acpESvfE+sG/sFbWw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=u6IvXM34TNGq8TxipXmHBkjg3J/2TE4ELDUmB8gRlbLzlz7NZKBeRW/su47LEHlUT
 s5IpsVYQ93qMGfni4m/IU4k2R14Eh3EXHWWFN0oFdwsrFRG8lR3NTfKQIS2ZvKJwVj
 6BfCv7HKt3o9l1kXHCAk7rxoRrHihKX77SO4lQwU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RBOD5C024868
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Feb 2024 05:24:13 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 05:24:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 05:24:13 -0600
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RBOAEi006785;
 Tue, 27 Feb 2024 05:24:10 -0600
Message-ID: <ee1d16fd-b99b-4b07-97bb-a896e179157a@ti.com>
Date: Tue, 27 Feb 2024 16:54:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-8-s-vadapalli@ti.com>
 <20240112123055.5h3qio3w55godccy@gallstone>
 <1c0040f2-0113-4580-9af7-510d9320407b@ti.com>
 <20240123205720.vqfua5i2qkfuryms@flatness>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240123205720.vqfua5i2qkfuryms@flatness>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 24/01/24 02:27, Nishanth Menon wrote:
> On 15:49-20240122, Chintan Vankar wrote:
>>
>> On 12/01/24 18:00, Nishanth Menon wrote:
>>> On 12:17-20240112, Siddharth Vadapalli wrote:
>>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>>
>>>> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS driver
>>>> in board_init_f().
>>> Why? doesn't the DM framework handle this?
Hello,
In board_init_f(), the ESM driver which is modeled as UClASS_MISC driver
seems to be probed explicitly. So it appears to me that the DM framework 
is probably not capable of handling probe of UCLASS_MISC. The am65-cpsw 
driver is also a UCLASS_MISC driver because of which it has to be probed 
similar to the ESM driver. Can someone suggest me if there is a way to 
trigger probe of all UCLASS_MISC drivers using the DM framework or 
am65-cpsw should be probed in this way only ?
> 
>> Can you suggest how can we do this ?
> 
> Did'nt you guys  just discuss this in
> https://lore.kernel.org/all/48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com/
> ?
> 
