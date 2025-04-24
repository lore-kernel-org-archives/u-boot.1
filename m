Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E9AC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 04:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4875D806FC;
	Thu, 24 Apr 2025 06:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K7l1bBn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4385C8070C; Thu, 24 Apr 2025 06:42:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC628056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 06:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O4gdEe1750049
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 23:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745469759;
 bh=FsseBlaggM2HgC/5wtpSNJ6eausc+MZSCtTtAEkJYPs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=K7l1bBn+H1fj33K7pDOtm681AZKehMLWXjxBsViqSHo4SUXcl7cSQD4yNaPWz7Sao
 ZCU304abPjHzcoreoG/JK2Nn2EPjSiaWv6IYA0EzGhtd9Bl49mhwLopDalJNETRx13
 A8MKLBQP9RqNezOl8FY+1BtfXumyNwzG3wgBiqZ4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O4gdnS118649
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Apr 2025 23:42:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Apr 2025 23:42:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Apr 2025 23:42:39 -0500
Received: from [172.24.22.140] (lt5cd2489kgj.dhcp.ti.com [172.24.22.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O4gaD1037561;
 Wed, 23 Apr 2025 23:42:37 -0500
Message-ID: <90f140c2-0ae8-453c-9c6b-32673133ebc6@ti.com>
Date: Thu, 24 Apr 2025 10:12:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC
 driver
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>
References: <20250416061652.2394419-1-a-dutta@ti.com>
 <20250416061652.2394419-2-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250416061652.2394419-2-a-dutta@ti.com>
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


On 4/16/2025 11:46 AM, Anurag Dutta wrote:
> The MUX_MMIO is enabled both in SPL as well as U-Boot proper. Hence,
> add SPL_MUX_MMIO dependency from HBMC driver.

May be you can reword commit message

MUX_MMIO is needed by HBMC ,
So enable it at SPL and u-boot proper stage.

>
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>   drivers/mtd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 2b7f5e5ed7b..729db904200 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -202,7 +202,7 @@ config RENESAS_RPC_HF
>   
>   config HBMC_AM654
>   	bool "HyperBus controller driver for AM65x SoC"
> -	depends on MULTIPLEXER && MUX_MMIO
> +	depends on MULTIPLEXER && (MUX_MMIO || SPL_MUX_MMIO)

With above change in commit message

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   	help
>   	 This is the driver for HyperBus controller on TI's AM65x and
>   	 other SoCs
