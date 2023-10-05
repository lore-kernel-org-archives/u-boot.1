Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB0CE9270A
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D42E986CA5;
	Thu,  5 Oct 2023 16:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EG9Rp10Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ABB586C2A; Thu,  5 Oct 2023 16:20:00 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2302086C6A
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395EJnf9032642;
 Thu, 5 Oct 2023 09:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696515589;
 bh=k1gOBXxS7YEGJxlQRypWzMdHC5Ytn2yJ6qMfByx441A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=EG9Rp10QkyIeIZ9bSSZcCFewv5FhL+2hfOtJBgGjpim81RnNfXfnnQ2/Zwc9gSdca
 e583Nm38DP1ApOx+3X77vvgB3EFJkCxEKjLEutoPC6ZKIKzdk6eRmsnZK2WxI5FNop
 uN9751Co6R0v80R7+aWZ6ERJteRcD83Hetk6qdvo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395EJn2B072308
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 09:19:49 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 09:19:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 09:19:49 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395EJmDx047984;
 Thu, 5 Oct 2023 09:19:49 -0500
Message-ID: <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
Date: Thu, 5 Oct 2023 09:19:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
To: Nishanth Menon <nm@ti.com>
CC: Roger Quadros <rogerq@kernel.org>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>, <sjg@chromium.org>, <jonas@kwiboo.se>,
 <srk@ti.com>, <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231004135436.ihofrxutzcdefica@audacious>
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

On 10/4/23 8:54 AM, Nishanth Menon wrote:
> On 08:48-20231004, Andrew Davis wrote:
>> On 10/4/23 8:23 AM, Roger Quadros wrote:
>>> ti_mmc is not a valid boot_target for standard boot flow so
>>
>> Is there some way to make it into a valid boot_target? Otherwise
>> how do we use uEnv.txt files, or boot from FIT images with overlays?
> 
> envboot takes care of uEnv.txt file (see
> https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> 
> Early remote proc loading and FIT image is a question for stdboot itself.
> 

If stdboot is missing these features then we shouldn't switch until it
has them. I'm all for switching to this, but only if it is complete.

Andrew

>>
>> Andrew
>>
>>> remove it. Prefer mmc1 (sd-card) over mmc0 (emmc).
>>>
>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>> ---
>>>    board/ti/am62x/am62x.env | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
>>> index 22a6c2c91b..e53a55c38f 100644
>>> --- a/board/ti/am62x/am62x.env
>>> +++ b/board/ti/am62x/am62x.env
>>> @@ -8,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
>>>    	${mtdparts}
>>>    run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
>>> -boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
>>> +boot_targets=mmc1 mmc0 usb pxe dhcp
>>>    boot=mmc
>>>    mmcdev=1
>>>    bootpart=1:2
> 
