Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943AC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE1082F50;
	Tue,  8 Apr 2025 14:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744117164;
	bh=j8iVZ5EvixqpQ9tGE0QQ3nyR/Il2PubblNNtugJqe2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qPHC4jKbAPcbYiXwh3IF7/Zh2u+6NL5kCooIY3f3Ci4iB1BmIlsLHcY5BsmuAQcwj
	 suCFHoaxkmtGlU3ulaTyo/BTe+zFBksKQiA8SFnmiPjmdzxmjFbbDyN0NBWyylS9D9
	 mL4iJNKXmjcGp7Bk3mAAqVmfC9XcXlu5F8YBEoINWYYrnS3v+/eQbc9rQIIqVvfA48
	 febwldI39Z6kdJu7YWbl+TJ4t7dDFZL1hdqpi83VMcugk3j+1O+KNGe2Tx5ncSS36q
	 kTyWm/Ms+1Dx8FSDc0GgMAE4855Ca2FcOqVbt3kuwHuz4uyxxulzFmL+CBCWpVljrW
	 TAxZUYK8eHDZA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDF583414; Tue,  8 Apr 2025 14:59:23 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732F682EAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="czOr16T3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D4C03102F673A; 
 Tue,  8 Apr 2025 14:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744117159;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=j8iVZ5EvixqpQ9tGE0QQ3nyR/Il2PubblNNtugJqe2k=;
 b=czOr16T3fX3PPNHEbdGCAlnu+CX+dWw7tnEwRNcB0ZJjnVERp6rIAnlgX4U97PV8CDLgJW
 MjkXwcvc8DBQXckbkYXNFCfz97CmDbyCa6YV46udQc9bmSdUUy9oSKv+21dCBhkqhsm7dd
 ff5LUomjWogR0xa9HAIaUKrNHBrrTPxf/Vd5oH2JXZPOFGgYbJo5UNqWQV7wLWzcGO1X/1
 x7HoZDMI8dsMV7JWqo2DilpmuxPOL1D1XGt5n9uVx3O5+TD55WbhVDOkMbHNokVG8AH0rs
 YGIUWbhTU4njWI/7wUx0NRmTXriGyJo480ZEpxP0t/yA8m6Ur5ickYCux40OgQ==
Message-ID: <d4b0e883-058f-8097-5d78-06bf39f22968@denx.de>
Date: Tue, 8 Apr 2025 14:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/4] i2c: omap24xx_i2c: Use new function
 __omap24_i2c_xfer_msg()
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, stefan.agner@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250310103702.1464782-1-a-limaye@ti.com>
 <20250310103702.1464782-3-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250310103702.1464782-3-a-limaye@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Aniket,

On 10.03.25 11:36, Aniket Limaye wrote:
> Remove __omap24_i2c_read/write() usage from omap_i2c_xfer() in favour of
> the more flexible __omap24_i2c_xfer_msg().
> Consequently, these are also no longer needed when DM_I2C is enabled.
> 
> New function __omap24_i2c_xfer_msg() will take care of individual read
> OR write transfers with a target device. It goes through below sequence:
> - Program the provided Target Chip address (OMAP_I2C_SA_REG)
> - Program the provided Data len (OMAP_I2C_CNT_REG)
> - Program the provided Control register flags (OMAP_I2C_CON_REG)
> - Read from or Write to the provided Data buffer (OMAP_I2C_DATA_REG)
> 
> For a detailed programming guide, refer to the TRM[0] (12.1.3.4 I2C
> Programming Guide).
> 
> This patch by itself should be a transparent change. However this is
> needed for implementing a proper Repeated Start (Sr) functionality for
> i2c_msgs.
> 
> Previous implementation for omap_i2c_xfer called __omap24_i2c_read/write
> functions, with hardcoded addr=0 and alen=0 for each i2c_msg. Each of
> these calls would program the registers always with a Stop bit set, not
> allowing for a repeated start between i2c_msgs in the same xfer().
> 
> [0]: https://www.ti.com/lit/zip/spruj28 (TRM)
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - Use proper error codes in __omap24_i2c_xfer_msg()
> - Use proper error prints to indicate omap24xx i2c driver
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-2-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/omap24xx_i2c.c | 143 +++++++++++++++++++++++++++++++------
>   1 file changed, 123 insertions(+), 20 deletions(-)

This patch drops failures in CI, for example:

https://dev.azure.com/hs0298/hs/_build/results?buildId=174&view=logs&j=8d774156-03aa-5a8d-58c3-e707e7e6b7b9&t=9810a296-c5d9-5d86-70ea-69525d43e83a&l=661

https://dev.azure.com/hs0298/hs/_build/results?buildId=174&view=logs&j=b0438df5-671b-55ba-8fc5-1746d486c477&t=d9c340c5-b4ec-5d48-b218-d3f9f8f479f8&l=700

in clear text it is:
"""
+drivers/i2c/omap24xx_i2c.c:538:12: error: '__omap24_i2c_xfer_msg' defined but not used 
[-Werror=unused-function]
"""

Could you please send a fix?

Thanks in advance!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
