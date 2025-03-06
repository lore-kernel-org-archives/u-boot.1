Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E9AC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87A2808A2;
	Thu,  6 Mar 2025 13:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ALU1RQEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0571380F4C; Thu,  6 Mar 2025 13:59:07 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37FE4805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 526Cwx1O3720862
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 06:58:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741265939;
 bh=IMJKFCAGQFyO/gD/gcKKAhFTkILBqnWa4yBG9yjVlgc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ALU1RQECQsnBGuBrEEM/fMKO/xFUI7DEgWX/abQJ2l/P+1YhT9jbkNw1nshpA8oUo
 o6xk5KVBbj29KwVBD30Pe8CpYIfurFYCaoQFurcTdR4DoOwz/nQe/PpVUhIM/fbGvF
 bpKRz9JSNbmQGnVelt8l8hc5nVAsOTC4nkSxDbO8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 526Cwwk6032144
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Mar 2025 06:58:58 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Mar 2025 06:58:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Mar 2025 06:58:58 -0600
Received: from [10.24.72.128] (psdkl-workstation0.dhcp.ti.com [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 526Cwsq9046376; 
 Thu, 6 Mar 2025 06:58:55 -0600
Message-ID: <24951463-008b-4864-b8e4-c426b0e36122@ti.com>
Date: Thu, 6 Mar 2025 18:28:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 0/3] omap24xx_i2c: Enable Repeated Start
 functionality
To: <hs@denx.de>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <marcel.ziswiler@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250305155000.GR2640854@bill-the-cat>
 <5100f007-28c2-ed02-620f-a013e9c6ed60@denx.de>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <5100f007-28c2-ed02-620f-a013e9c6ed60@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Tom, Heiko,

On 06/03/25 11:15, Heiko Schocher wrote:
> Hello Tom, Aniket,
> 
> On 05.03.25 16:50, Tom Rini wrote:
>> On Wed, Mar 05, 2025 at 03:34:08AM +0530, Aniket Limaye wrote:
>>> This series implements Repeated Start functionality for the DM_I2C xfer
>>> API (omap_i2c_xfer())
>>>
>>> First, split out the actual implementation for each individual i2c msg
>>> transfer into a new function __omap24_i2c_xfer_msg() and use this to
>>> implement omap_i2c_xfer().
>>>
>>> Then, add support for the Repeated Start condition in omap_i2c_xfer()
>>> through the CONFIG_I2C_REPEATED_START option.
>>>
>>> Also add this config to Kconfig and enable it for ARCH_K3 platforms by
>>> default.
>>>
>>> Test logs (On AM68-SK with additional debug prints):
>>> https://gist.github.com/aniket-l/8c64c5bc81246751a02836a96510df14
>>>
>>> Requesting reviews/testing on specifically the CONFIG_I2C_REPEATED_START
>>> addition:
>>> - Is the Kconfig needed or should we simply always default to not
>>>    sending Stop bit? Drivers can use i2c_msg.flags to request Stop bit
>>>    for each msg, same as in the Linux Kernel i2c-omap driver[0].
>>
>> Yes, a Kconfig is needed as this driver works (as implied by the name)
>> on so much old and differently buggy IP.
>>
>>> - If yes, Should we re-use CONFIG_I2C_REPEATED_START from the legacy
>>>    implementation of the driver or define a new config
>>
>> Lets pick a new option, under the SYS_I2C_OMAP24XX namespace (and remove
>> the legacy and unused variant).
>>

I will update the patch with the proper namespace for this config.

The legacy one (CONFIG_I2C_REPEATED_START) was never added to Kconfig at 
all... So will just leave it be ( unless you meant remove support for it 
from the legacy driver code as well and use this new one instead? )

>>> - Default enable it for K3 devices?
>>
>> I'm fine with that.
>>
> 
> Yep, fully aggree, we need the Kconfig symbol for backward compatibility.
> 
> Thanks!
> 
> bye,
> Heiko


Thanks for your reviews!

Regards,
Aniket
