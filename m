Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECA8CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 13:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EC2832DD;
	Tue,  2 Sep 2025 15:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uD/CiPpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C74083303; Tue,  2 Sep 2025 15:31:47 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8C1832BC
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 15:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582DVhm82594566;
 Tue, 2 Sep 2025 08:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756819903;
 bh=LuNyb5HOgT0dXzTC6nt1QPCu2G96J55m6LiDjNBBPPk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uD/CiPpfkSze+uQKjVcRu1y5X2c/8o+ZsTiVnV4uONd427j2jXTRYEN2LbVNqOq0S
 wQv8RJSbNDdokt+PZwnw5yKQNmyal6MHTv5N73uL5gQkrr9hHzfyCXs9DuRZBl9i7F
 GwSoVfrs1aBRVOuURkv/qyaE/6xJapCHCEWsp8qc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582DVh6X2769156
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 08:31:43 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 08:31:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 08:31:43 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582DVXSr4137914;
 Tue, 2 Sep 2025 08:31:38 -0500
Message-ID: <f046426c-011a-41ec-bb91-62486e2fd18c@ti.com>
Date: Tue, 2 Sep 2025 19:01:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm: dts: k3-j721e-r5-common-proc-board: Enable
 HBMC in R5 SPL stage
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-4-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902102000.1388848-4-a-dutta@ti.com>
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


On 9/2/2025 3:50 PM, Anurag Dutta wrote:
> Enable HBMC in the R5 SPL stage
>
> Fixes: c9df79ee64d0 ("arm: dts: k3-j721e-r5-common: Add HBMC overrides for R5 SPL")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>   arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index c775432505b..e4f799dfb27 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -52,6 +52,7 @@
>   };
>   
>   &hbmc {
> +	status = "okay";

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	reg = <0x0 0x47040000 0x0 0x100>,
>   		<0x0 0x50000000 0x0 0x8000000>;
>   	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>,
