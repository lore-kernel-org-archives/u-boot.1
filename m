Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93E0C25B75
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 02:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38688816A;
	Mon, 20 May 2024 04:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="owApdGZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D458F8817B; Mon, 20 May 2024 04:51:41 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84A6880FB
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 04:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44K2paf4088989;
 Sun, 19 May 2024 21:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716173496;
 bh=VNRZI+vqJBGEnYRMNT5VdKEQ3Gd5Ib/rzTBgu+XBMSg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=owApdGZpjU9CfffF/fqw/1X0yOG31Mce6zyDlFXzOKCdSjKX+x5J3VNHvtKbtN8rk
 3nq51J8QbyVgKozgGPb0lzCfExLPfcBR0Oq26smxo4rmGMb4AmN9X+n1gUTPvnYHxI
 wcLfITwksYNVjrnt8TFsxCkERI+CcfUVE51DZxUs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44K2paTO048461
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 19 May 2024 21:51:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 19
 May 2024 21:51:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 19 May 2024 21:51:36 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44K2pXVT027612;
 Sun, 19 May 2024 21:51:33 -0500
Message-ID: <b14b84c7-2aca-4be8-b7e8-c942aeb4e1f5@ti.com>
Date: Mon, 20 May 2024 08:21:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
To: Andrew Davis <afd@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>
References: <20240510084707.1903133-1-s-k6@ti.com>
 <20240510084707.1903133-6-s-k6@ti.com>
 <e6387a6f-fe4b-4bff-99fd-1418b17aee78@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <e6387a6f-fe4b-4bff-99fd-1418b17aee78@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andrew

On 15/05/24 21:37, Andrew Davis wrote:
> On 5/10/24 3:47 AM, Santhosh Kumar K wrote:
>> From: Neha Malcom Francis <n-francis@ti.com>
>>
>> Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
>> only when the config has been enabled.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/ram/Kconfig | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
>> index 9838a2798f92..9d1eee1d5cad 100644
>> --- a/drivers/ram/Kconfig
>> +++ b/drivers/ram/Kconfig
>> @@ -107,6 +107,17 @@ config IMXRT_SDRAM
>>         to support external memories like sdram, psram & nand.
>>         This driver is for the sdram memory interface with the SEMC.
>> +config K3_INLINE_ECC
>> +    bool "Enable TI Inline ECC support"
>> +    depends on K3_DDRSS
>> +    default n
> 
> n is already the default, this line is never needed.
> 

Right thanks for catching that!

> Maybe we want this to be `default y` so that we do not change
> current behavior and platforms can opt-out as needed instead.
> 

Inline ECC should not be default behavior on our systems, rather those who need 
it opt to enable it; since it significantly impacts boot time on systems with 
large RAM. So I think we should keep it as default n.

> Andrew
> 
>> +    help
>> +      Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
>> +      is used for ECC storage and the rest 8/9th is available for system
>> +      use. Enabling ECC increases boot time as the ECC protected regions
>> +      need to be primed with a predefined value prior to enabling ECC
>> +      check.
>> +
>>   source "drivers/ram/aspeed/Kconfig"
>>   source "drivers/ram/cadence/Kconfig"
>>   source "drivers/ram/octeon/Kconfig"

-- 
Thanking You
Neha Malcom Francis
