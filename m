Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D13DC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A165380F9C;
	Tue, 22 Apr 2025 12:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fj12Lmd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4013180FEC; Tue, 22 Apr 2025 12:27:03 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A725180C93
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAQqmG1911470
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 05:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745317612;
 bh=cwm8YO1POo/m0/nWakT7b3appIeG12mHNoUHDcF13/c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Fj12Lmd1tVuk+2MdL+I+7izxBZsgN1lyl4iwq5AlVq9oEN1WcifpYIyWHcKU3lkj9
 JIY406xSKH/UApwdOidyvGmxqNXvZuchjxCWEZ1JnMKWxZQz9AO/zmZL2cNJKQgohf
 ZoGHIzLHyomqxraw8B975+L7Ts+/3v6D6U/aUYsU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAQqeP076070
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 05:26:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:26:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:26:51 -0500
Received: from [10.24.72.128] (psdkl-workstation0.dhcp.ti.com [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MAQla3124352; 
 Tue, 22 Apr 2025 05:26:48 -0500
Message-ID: <2298f729-597a-4fac-8150-3c4a945ab1be@ti.com>
Date: Tue, 22 Apr 2025 15:56:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] i2c: omap24xx_i2c: Use new function
 __omap24_i2c_xfer_msg()
To: <hs@denx.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <stefan.agner@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>
References: <20250310103702.1464782-1-a-limaye@ti.com>
 <20250310103702.1464782-3-a-limaye@ti.com>
 <d4b0e883-058f-8097-5d78-06bf39f22968@denx.de>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <d4b0e883-058f-8097-5d78-06bf39f22968@denx.de>
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



On 08/04/25 18:29, Heiko Schocher wrote:
> Hello Aniket,
> 
> On 10.03.25 11:36, Aniket Limaye wrote:
>> Remove __omap24_i2c_read/write() usage from omap_i2c_xfer() in favour of
>> the more flexible __omap24_i2c_xfer_msg().
>> Consequently, these are also no longer needed when DM_I2C is enabled.
>>
>> New function __omap24_i2c_xfer_msg() will take care of individual read
>> OR write transfers with a target device. It goes through below sequence:
>> - Program the provided Target Chip address (OMAP_I2C_SA_REG)
>> - Program the provided Data len (OMAP_I2C_CNT_REG)
>> - Program the provided Control register flags (OMAP_I2C_CON_REG)
>> - Read from or Write to the provided Data buffer (OMAP_I2C_DATA_REG)
>>
>> For a detailed programming guide, refer to the TRM[0] (12.1.3.4 I2C
>> Programming Guide).
>>
>> This patch by itself should be a transparent change. However this is
>> needed for implementing a proper Repeated Start (Sr) functionality for
>> i2c_msgs.
>>
>> Previous implementation for omap_i2c_xfer called __omap24_i2c_read/write
>> functions, with hardcoded addr=0 and alen=0 for each i2c_msg. Each of
>> these calls would program the registers always with a Stop bit set, not
>> allowing for a repeated start between i2c_msgs in the same xfer().
>>
>> [0]: https://www.ti.com/lit/zip/spruj28 (TRM)
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>
>> v2:
>> - Use proper error codes in __omap24_i2c_xfer_msg()
>> - Use proper error prints to indicate omap24xx i2c driver
>> - Link to v1: 
>> https://lore.kernel.org/u-boot/20250304220546.866602-2-a-limaye@ti.com/
>>
>> ---
>>   drivers/i2c/omap24xx_i2c.c | 143 +++++++++++++++++++++++++++++++------
>>   1 file changed, 123 insertions(+), 20 deletions(-)
> 
> This patch drops failures in CI, for example:
> 
> https://dev.azure.com/hs0298/hs/_build/results?buildId=174&view=logs&j=8d774156-03aa-5a8d-58c3-e707e7e6b7b9&t=9810a296-c5d9-5d86-70ea-69525d43e83a&l=661
> 
> https://dev.azure.com/hs0298/hs/_build/results?buildId=174&view=logs&j=b0438df5-671b-55ba-8fc5-1746d486c477&t=d9c340c5-b4ec-5d48-b218-d3f9f8f479f8&l=700
> 
> in clear text it is:
> """
> +drivers/i2c/omap24xx_i2c.c:538:12: error: '__omap24_i2c_xfer_msg' 
> defined but not used [-Werror=unused-function]
> "" >
> Could you please send a fix?

Ahh, thanks for catching this.
Sent a v3:
https://lore.kernel.org/u-boot/20250422101957.1949448-1-a-limaye@ti.com/

Regards,
Aniket

> 
> Thanks in advance!
> 
> bye,
> Heiko
