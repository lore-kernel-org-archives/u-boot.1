Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B471C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 04:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD558082A;
	Thu, 24 Apr 2025 06:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xG2tw9hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6620180944; Thu, 24 Apr 2025 06:45:00 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E90806FC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 06:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O4iuCh1750435
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 23:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745469896;
 bh=y//RAMym/dR7ckY7U+OusF11KrivO5Qw8IMdxPdzU5Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=xG2tw9hbFV+T8ciwnLe/hlpsrgfzTCE7OSIDuD+sCViSRDUiGdjWK7eaSKBlBZzGR
 OAuglDI7zzklK5a54WJUqpLFYCDOVjqoGuZjeg8VlqGSuZaVvcnj7TKYxAf+OqOyF+
 IfqTNh3XC+qXmwMEffciT1keLx3C/5CxYBAO26xs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O4iuoW119440
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Apr 2025 23:44:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 23:44:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 23:44:56 -0500
Received: from [172.24.22.140] (lt5cd2489kgj.dhcp.ti.com [172.24.22.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O4imSk039154;
 Wed, 23 Apr 2025 23:44:50 -0500
Message-ID: <79e3544a-ec47-49c9-9de4-43f7c7aefa88@ti.com>
Date: Thu, 24 Apr 2025 10:14:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC
 in R5 SPL stage
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20250416061652.2394419-1-a-dutta@ti.com>
 <20250416061652.2394419-3-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250416061652.2394419-3-a-dutta@ti.com>
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


On 4/16/2025 11:46 AM, Anurag Dutta wrote:
> Enable HBMC in the R5 SPL stage

Please add

Fixes c9df79ee64d0: ("arm: dts: k3-j721e-r5-common: Add HBMC overrides 
for R5 SPL")

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

With fixes tag added,  Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	reg = <0x0 0x47040000 0x0 0x100>,
>   		<0x0 0x50000000 0x0 0x8000000>;
>   	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>,
