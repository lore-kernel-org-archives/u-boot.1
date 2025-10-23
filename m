Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CDCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 14:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97BD8006D;
	Thu, 23 Oct 2025 16:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="StntsyKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C5A8334F; Thu, 23 Oct 2025 16:24:39 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23E68003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 16:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NEOVhk1683956;
 Thu, 23 Oct 2025 09:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761229471;
 bh=3jQ/Yz9RL1yNG/Oe99mmeBc+u97dVl0kFScL58Ncn8Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=StntsyKiW89iYj684+mX1J/lvH4RsS9r32nZ9nobj3D6ZZngp8loz4AANnC0SlbYN
 9b8otL2yg9IWfb4qtSaJ4xcwZ4dIv/nsbxGOmhL2Ha7WPT9L8CpJoWR39XikwUnWP0
 CGltR/CsbQacrJ8lcd4HPPUfHsbzswC+zkgonxxs=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NEOUv32872933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 09:24:31 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 09:24:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 09:24:30 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NEOUS22982276;
 Thu, 23 Oct 2025 09:24:30 -0500
Message-ID: <f499c3ea-72ce-4698-91d2-b10aa8c438bf@ti.com>
Date: Thu, 23 Oct 2025 09:24:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] mach-k3: security: Propagate verified image addr
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Tom Rini <trini@konsulko.com>
References: <20251023094631.16742-1-dev@pschenker.ch>
 <20251023094631.16742-5-dev@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251023094631.16742-5-dev@pschenker.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 10/23/25 4:46 AM, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> The ti_secure_image_check() function may relocate the image during
> authentication, updating image_addr to point to the verified location.
> The caller was not updated with this new address, causing it to
> reference the original unverified location.
> 
> Update p_image with the verified image address after authentication
> to ensure subsequent operations use the correct location.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> ---

Seems reasonable,

Acked-by: Andrew Davis <afd@ti.com>

BTW, did you actually run into an issue with having a binary moved
by the authentication, or was this found some other way? Normally
binaries don't move (but they can, so this is still valid).

> 
>   arch/arm/mach-k3/security.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
> index 3468a370a455..9255505a7944 100644
> --- a/arch/arm/mach-k3/security.c
> +++ b/arch/arm/mach-k3/security.c
> @@ -119,6 +119,8 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
>   	 */
>   	*p_size = image_size;
>   
> +	*p_image = (void *)image_addr;
> +
>   	/*
>   	 * Output notification of successful authentication to re-assure the
>   	 * user that the secure code is being processed as expected. However

