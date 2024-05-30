Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5358C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 02:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C49B886AB;
	Thu, 30 May 2024 04:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HuavtWj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99BAA886AB; Thu, 30 May 2024 04:25:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBD0886AA
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 04:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U2PWcM048586;
 Wed, 29 May 2024 21:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717035932;
 bh=DyATt6I+/pI+Nf/CTGSwFyqg/ciz52ZEXTXk7rvSIys=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HuavtWj/ysH6npBbONt4hCdypQpFxbcLtLVzwXAhUa5zd7uoa80NYb7yYKwx2zBg4
 ORT9WBS8hFuMJCqkGJlUEOqzncIxK+lS5hCnhPWIX5ksp517voUiLUgchdz7ft8e1L
 gqOdaH0xayZLKkKf38xnGzydnd8iMWJ/U8S/zH8A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U2PWML113705
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 21:25:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 21:25:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 21:25:31 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U2PRJe055855;
 Wed, 29 May 2024 21:25:28 -0500
Message-ID: <bd5b2153-b7d6-4d39-8a54-067869a1136a@ti.com>
Date: Thu, 30 May 2024 07:55:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] ram: k3-ddrss: Enable the am62ax's DDR controller
 for J722S
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>, <afd@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-9-j-choudhary@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240529132448.459330-9-j-choudhary@ti.com>
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

On 29/05/24 18:54, Jayesh Choudhary wrote:
> The J722S family of SoCs uses the same DDR controller as found on the
> AM62A family. Enable this option when building for the J722S family.
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   drivers/ram/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
> index 9838a2798f..a64d2dff68 100644
> --- a/drivers/ram/Kconfig
> +++ b/drivers/ram/Kconfig
> @@ -65,7 +65,7 @@ choice
>   	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
>   	default K3_AM64_DDRSS if SOC_K3_AM642
>   	default K3_AM64_DDRSS if SOC_K3_AM625
> -	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
> +	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S
>   
>   config K3_J721E_DDRSS
>   	bool "Enable J721E DDRSS support"

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
