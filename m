Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8778C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39117810F4;
	Tue, 22 Apr 2025 12:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745319582;
	bh=PRLejLHxsWQjNFE5KFl4z0XSyLs1D9p9saMHQTJWvmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rphSDHJ30MUmpqaMIW6wCxZ88RJWpkPiEnreYOtW+p17Lkrnni4RIccZUKyApkcWK
	 0d1XDsQPqaDsCa6Zz3d9tdGqtcxGbHeEyEOFu0rdE0n7KEd/9ftRLs5Ba1o2h1SUSG
	 mUf+RlLJ2qJoKfpjJtHSggRUeIOU8nBwtzZWgJU5D0irRGAUyEX8qWTPoFg2e4nj6j
	 Jl62Eu2XOX6WRg0bGkeUts7d9mhnINOIoUwvTYZMtT4JhjAsKsKiMRDcnCanB2tbkF
	 835FJiyabAQWrv7147bEj9bzKE/jRVvfjFObqQeUIe+qIakP1TH5mcyuuaTHcsMndE
	 ULRrOobUYyKaw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C0E812BC; Tue, 22 Apr 2025 12:59:41 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BE6810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hArAk1ZF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E2BE102A8C9A; 
 Tue, 22 Apr 2025 12:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745319578;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PRLejLHxsWQjNFE5KFl4z0XSyLs1D9p9saMHQTJWvmA=;
 b=hArAk1ZFK6SEwfIwLQZyazX5/MrtwKypOmpYUkhg1hk67jkVS1AyU0uoSD94pyMrxyr/Xr
 HGjVDV9G9G6CPR+VYwe9gsGpBY31HYvastlZXFZMm0hYePVIVwjPATf43/OSi7Kcz2G8KS
 norQm+YzPZMWVXZLABgQUGjW6GVE78ShgQ5gVQGIGbb4qN5CY3WE4J2qRBmj1NOV17aoBn
 /bjHg3Aa9T36tq8zxrbIgomWvm5EyoY+a9DdnW7CDcA5ij297hxdC8dQYCzUi0Ol8UkpYd
 4LgeJCBP4/Oc51z+fY/RL9og04b9rWZp7FYbdssjFu9FW9UFokAfT7+XJDsdfQ==
Message-ID: <f614ebcf-301a-2a32-e683-b63756871f57@denx.de>
Date: Tue, 22 Apr 2025 13:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/4] i2c: omap24xx_i2c: Use new function
 __omap24_i2c_xfer_msg()
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, w.egorov@phytec.de, j-keerthy@ti.com,
 u-kumar1@ti.com
References: <20250422101957.1949448-1-a-limaye@ti.com>
 <20250422101957.1949448-3-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422101957.1949448-3-a-limaye@ti.com>
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

On 22.04.25 12:19, Aniket Limaye wrote:
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
> v3:
> - Fixup to avoid unused function __omap24_i2c_xfer_msg() compile time
>    warnings... Move this behind DM_I2C ifdef
> - Link to v2: https://lore.kernel.org/all/20250310103702.1464782-3-a-limaye@ti.com/
> 
> v2:
> - Use proper error codes in __omap24_i2c_xfer_msg()
> - Use proper error prints to indicate omap24xx i2c driver
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-2-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/omap24xx_i2c.c | 143 +++++++++++++++++++++++++++++++------
>   1 file changed, 123 insertions(+), 20 deletions(-)

Thanks for the update!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
