Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7E6D3B7CF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 03:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8298995B;
	Mon, 25 Nov 2024 04:58:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I0FT5Gh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E097B899C3; Mon, 25 Nov 2024 04:58:03 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4520F895EF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 04:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AP3vt0r104808;
 Sun, 24 Nov 2024 21:57:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732507075;
 bh=BUinEdFt6g94+UCa65/SkhWByjkyEsY23nWfWNIrJCQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=I0FT5Gh3Cqrr+ek6eCrUxNj5+tOPZ8f82QHsWeak05sirKIvgdRdFr5s9lcUrKoAc
 du1TsRAaD1PF95n7m8bapQXgChNZaPIVVNHkQ0HngCvcYyK+yPXKsloSGWwQkA5u4n
 V0iGNJXj2Ji+EwBmHN4T1klJko23DNqxWxKaY9EU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP3vtIX125405;
 Sun, 24 Nov 2024 21:57:55 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Nov 2024 21:57:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Nov 2024 21:57:55 -0600
Received: from [172.24.30.208] (lt5cd2489kgj.dhcp.ti.com [172.24.30.208])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP3voQf051291;
 Sun, 24 Nov 2024 21:57:51 -0600
Message-ID: <5d7974f8-7b29-43f7-a6bf-e364ce37967f@ti.com>
Date: Mon, 25 Nov 2024 09:27:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] board: ti: am64x: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <j-humphreys@ti.com>, <m-chawdhry@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <sjg@chromium.org>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <afd@ti.com>,
 <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <u-kumar1@ti.com>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-2-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241124070828.617558-2-s-vadapalli@ti.com>
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

On 11/24/2024 12:37 PM, Siddharth Vadapalli wrote:
> Commit 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
> updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
> However, this breaks use-cases where interface is not Serial Flash ("sf").
> Fix this by setting "dfu_alt_info" only when the interface is "sf".
>
> Fixes: 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20241124051545.382397-2-s-vadapalli@ti.com/
> Changes since v1:
> - Replaced "SPI Flash" with "Serial Flash" everywhere.
>
> Regards,
> Siddharth.
>
>   board/ti/am64x/evm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 00b8317d6b..18f7770bc1 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -56,7 +56,13 @@ struct efi_capsule_update_info update_info = {
>   #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
>   void set_dfu_alt_info(char *interface, char *devstr)
>   {
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))

Could you evaluate possibility of moving this function along with others to

board/ti/common/ area.


Regards

Udit


> +	/*
> +	 * Since the EFI Capsule support is enabled only for Serial Flash,
> +	 * update the "dfu_alt_info" environment variable only if the
> +	 * interface happens to be "sf" (Serial Flash).
> +	 */
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> +	    (strcmp(interface, "sf") == 0))
>   		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
