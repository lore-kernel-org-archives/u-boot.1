Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB3CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E310F886DF;
	Tue, 24 Sep 2024 08:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nm31mKgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C611A8855C; Tue, 24 Sep 2024 08:38:58 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FC088387
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O6cqK3065822;
 Tue, 24 Sep 2024 01:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727159932;
 bh=tb/LO8Un7PObev6obHQb/3YXkPVuHPmAGLHR1TpxXLw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nm31mKgZB4plhUGn+9iFd+9r5V3B07tqC4ir8IuHiih/2aqKr8IRZGj16PzkBMMkJ
 kudjkESALZnP4ZWlEIAU9nGNS282GU9pu8OtXscjqNEZw/TKDNXURp1cTLL8DARzUv
 rQH/DCg/1cRI/YK1NfNIJDSZVxBy41OJMq4teS0Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O6cqK4026482
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 24 Sep 2024 01:38:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 01:38:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 01:38:51 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O6cm9S052352;
 Tue, 24 Sep 2024 01:38:49 -0500
Message-ID: <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
Date: Tue, 24 Sep 2024 12:08:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
Content-Language: en-US
To: Martin Stolpe <martinstolpe@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>
CC: <u-boot@lists.denx.de>, Francois Berder <fberder@outlook.fr>, Matthias
 Brugger <mbrugger@suse.com>, Nikhil M Jain <n-jain1@ti.com>, Peter Robinson
 <pbrobinson@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom
 Rini <trini@konsulko.com>
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Martin, Ivan

On 24/09/24 11:56, Martin Stolpe wrote:
> Hi,
> 
> Am Fr., 20. Sept. 2024 um 10:10 Uhr schrieb Ivan T. Ivanov <iivanov@suse.de
>> :
> 
>> Hi,
>>
>> On 09-20 08:32, Martin Stolpe wrote:
>>>
>>> When the CONFIG_VIDEO option is set to disabled for Raspberry Pi devices
>>> the build will fail with the following error message:
>>> "undefined reference to `fdt_simplefb_enable_and_mem_rsv'."
>>>

Thanks for the patch.

>>> Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
>>> ---
>>>
>>>  board/raspberrypi/rpi/rpi.c | 2 +-
>>>  boot/fdt_simplefb.c         | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
>>> index ab5ea85cf9..bc49708f85 100644
>>> --- a/board/raspberrypi/rpi/rpi.c
>>> +++ b/board/raspberrypi/rpi/rpi.c
>>> @@ -572,7 +572,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>>       node = fdt_node_offset_by_compatible(blob, -1,
>> "simple-framebuffer");
>>>       if (node < 0)
>>>               fdt_simplefb_add_node(blob);
>>> -     else
>>> +     else if (IS_ENABLED(CONFIG_VIDEO))
>>>               fdt_simplefb_enable_and_mem_rsv(blob);
>>
>> I think there is one more user of this function which end of same
>> situation stm32mp1.
>>
> 
> Would it make sense to replace the config option CONFIG_FDT_SIMPLEFB with
> CONFIG_VIDEO? CONFIG_FDT_SIMPLEFB is only used in the Raspberry Pi default
> configurations but in no other board configuration and I don't see it being
> used in the code besides in stm32mp1.c.
> 

CONFIG_FDT_SIMPLEFB is only used in splash-screen context which in-turn
depends on CONFIG_VIDEO. So CONFIG_FDT_SIMPLEFB is in a way dependent on
CONFIG_VIDEO. We had fixed similar issue in past in vendor tree and by making
CONFIG_FDT_SIMPLEFB dependent on CONFIG_VIDEO using below set of patches [1]
which I was planning to post upstream too.

Kindly let me know If these patches look good to you and fix your problem too,
I can post same set of patches to upstream too.

[1] :
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1199800505f11f2162030cb641c6d0c9276d5c9c
[2] :
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=5b4b8eac243cbd86286ff2cf57ca0469c4d86345

Regards
Devarsh


> Regards
> Martin
> 
