Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C03C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 05:27:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B08806D8;
	Tue, 11 Mar 2025 06:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741670876;
	bh=XtLh/RKQeZec2QfBCPm+ODmQg8umLS884QlVzZm6wPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sfK6nhH1WAztgkpRBVrbQci3/4em4qWiWJ1AplW/7n6OtnVXgISxFIxFe1a0RsnF+
	 0URJohq66xUslgpe00U+2AQqclnR5FjWTWujY7/CZZ6i9TLYZtY+0blHffQxx63T7j
	 jCaYMbYaDg3huamhgs0ZB8f3tPdiiZmZ+WJcQrYTwo8zxy5Zq+2JIwYtn3hi63avFU
	 GH2HpHOIFAdmBtTelmtAo4g27lcJAIgrW/j/DZAU+v+SzLJQe0bYTMlDlFcSrjPedN
	 SV+sdJxCB95+Z4BnYSHOIGCVZa78H5CSGHa/3sWZRZ5nf7dHcMBenwjrkO/w7JPbNi
	 oEwUqtfn94clA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A7B807D9; Tue, 11 Mar 2025 06:27:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E692800C1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hREgCHJO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84FA410210BC0; Tue, 11 Mar 2025 06:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741670871;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XtLh/RKQeZec2QfBCPm+ODmQg8umLS884QlVzZm6wPA=;
 b=hREgCHJOGS6XFQoxElRO143JqiCaTjURidAsbjSWRnyKAWmNmYYu8M18/wBK5ZBjDEAeXX
 j5ZlHbDqa/I5mQ2UFzZuv1QEVGHMDjfvcKIeD319pReWEui+rPgDq771bvzqsxivbXwmvT
 VFlyk9K7gN8gmUBSBlTCeEmdpGaPMGtmJ3QpnvpJ4+xAXsqs14OHm/+3ZbktZ0twJTfrhK
 e6Es14e1KND4YjopidvH2WIuhV20gytFeasD7AQdxmPmHwnKEqxBW6OwAU8RQVILYdhVoy
 ymp0S3TdK+NTh/2YTlFP3+Vbnlx+Az0W+XPrD3TMP9jHN1V7WSMvKdQx04Lqkw==
Message-ID: <1ed8c4b9-eea6-64e6-8ad1-3e782b5b2cce@denx.de>
Date: Tue, 11 Mar 2025 06:28:27 +0100
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

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
