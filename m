Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6822C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 05:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB15380AE2;
	Thu, 30 Jan 2025 06:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738214609;
	bh=5mJYOW3WW8Z5lhi2q/P4y1kQoaE7eb+q60QCxQ1LNU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HIhG67HcKRvtPyEZ4b8EaJSPsdOmse4MT+apTQxgSjm+EBocoN6o5IMPZcqBSWVKD
	 /M9wU/hfv+FIo7iNG7dSZM6x0mZJxCmhvmWo9k2nUpb405sDeiUUNDA0bjvXkFm8HW
	 yVQpiXm+NonrC429vYUHC0T+dFt1xXdvLlxnp8tFOxF5FK+k5pLlzkDc1xIPjLhKmH
	 DRS6a5ThTTEHCG1GhFAGq9iJmhTW+kVGlupOg26d2phzY1oZsWngJRZCE+7JCLsdYQ
	 mpIEwmm3KVot7lTou2F7rN5Jhechyy7P0x6jiURCRbzZw9obWBMdkHlJ6oMXcBnipU
	 tAnTPlFPDryZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3873180AE4; Thu, 30 Jan 2025 06:23:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC5A80ADF
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="d0YObzlO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 79AAA10382D0A; Thu, 30 Jan 2025 06:23:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738214604; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mJYOW3WW8Z5lhi2q/P4y1kQoaE7eb+q60QCxQ1LNU0=;
 b=d0YObzlO/IVj1jxyRTG99xoxIGDaoI3NKhnYjjXmeS6XMtFneRaFw9Boq1MnoXrAPIVs65
 JPebalyJX8yVQQUVAW/sKE1oxkH7zzp3JxkYjPlsh56L3ggHmqZVEjmeXpp0t7/HhISIQA
 loEGija0UflqG7YB8eckpOrkX2XBbP9ZyrWv5RMfXG6+rzTZ8ZLf6yUNKF1SecqJTncjoR
 iyrjj+hL2prdurZ+f+AMfdF/zcEVKtyAfAqylqCXxDZaC5zf1obYK5eSrS1xoInprLEsDd
 JYvzaN8hdu2Y7KfMO61CSCI7apDyhLafih33/EdVfuXg1MenFLYo+VI/6mhLZg==
Message-ID: <4f7e2e18-57bb-f7e2-1202-663240668ef1@denx.de>
Date: Thu, 30 Jan 2025 06:24:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] bootcount: zynqmp: Extend ZynqMP specific bootcount
 support
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
References: <20250130013726.337914-1-marex@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250130013726.337914-1-marex@denx.de>
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

Hello Marek,

On 30.01.25 02:37, Marek Vasut wrote:
> The PGGS area contains four registers, each of which can hold up to
> 32bit of data. Extend the boot counter to support storing boot count
> in either of the four registers with arbitrary mask to avoid limiting
> the boot counter only to the PGGS register 2 LSByte.
> 
> Drop U_BOOT_DRVINFO() as that would instantiate the boot counter even
> if there is no DT node associated with it, that is undesired behavior.
> 
> The boot counter configuration is implemented using three new DT properties:
> reg - PGGS register address, fallback to PGGS 2 at 0xffd80058
> u-boot,bootcount-reg-mask - Register mask, applied on PGGS register
> u-boot,bootcount-mask - Boot counter mask, applied on boot counter
> u-boot,bootcount-magic - Boot counter magic, applied on boot counter
> 
> Example configuration of 16bit boot counter with 0xb0010000 magic in PGGS0:
> 
> &amba {
> 	bootcount@0xffd80050 {
> 		compatible = "u-boot,bootcount-zynqmp";
> 		reg = <0 0xffd80050 0 0x4>;
> 		u-boot,bootcount-magic = <0xb0010000>;
> 		u-boot,bootcount-mask = <0xffff>;
> 		u-boot,bootcount-reg-mask = <0xffffffff>;
> 	};
> };
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/bootcount/bootcount_zynqmp.c | 79 +++++++++++++++++++++++++---
>   1 file changed, 71 insertions(+), 8 deletions(-)

Nitpick: Should there not be a change in a file where the new properties
and the compatible entry is documented?

Beside of that:

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
