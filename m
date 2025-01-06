Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76266E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D744B80137;
	Mon,  6 Jan 2025 09:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="run3h0eP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC354801DE; Mon,  6 Jan 2025 09:35:34 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1D58007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5068ZThN2461039
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 02:35:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736152529;
 bh=wrAdnNjpqwF9shyKROQPIPAfvl7Atwp19e2qqLvcCCM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=run3h0ePDPT97zjhEsYdvDxgaIX5zE386+o2mXBQhLe+WnGEbPtL6RWgg4KRuGt+F
 RTZudu4O/ND37m4xtOQWyEwPAR2q//tvxc8T/ehXEmHyqfg8Fz51bBUicx2tww4gzU
 dBOd5fnD2IY+a2QYD9wMobMvBlDzP5yVX8uUt0Nw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5068ZTMu008825
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 02:35:29 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 02:35:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 02:35:28 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5068ZOCX087133; 
 Mon, 6 Jan 2025 02:35:25 -0600
Message-ID: <c73101a2-8a34-430b-82dd-5f3759ea279c@ti.com>
Date: Mon, 6 Jan 2025 14:05:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
To: Tom Rini <trini@konsulko.com>
CC: "Menon, Nishanth" <nm@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
 "Kumar, Udit" <u-kumar1@ti.com>, "Brattlof, Bryan" <bb@ti.com>, "Chawdhry,
 Manorit" <m-chawdhry@ti.com>, "Achath, Vaishnav" <vaishnav.a@ti.com>,
 "Choudhary, Jayesh" <j-choudhary@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "Francis, Neha" <n-francis@ti.com>, <s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-10-s-k6@ti.com> <20241231225131.GA494453@bill-the-cat>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20241231225131.GA494453@bill-the-cat>
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

Hi, Tom,

On 01/01/25 04:21, Tom Rini wrote:
> On Fri, Dec 13, 2024 at 04:01:29PM +0530, Santhosh Kumar K wrote:
> 
>> As there are few redundant functions in board/ti/*/evm.c files, pull
>> them to a common location of access to reuse and include the common file
>> to access the functions.
>>
>> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
>> device tree and resize the available amount of DDR, if ECC is enabled.
>> Otherwise, fixup the device tree using the regular
>> fdt_fixup_memory_banks().
>>
>> Also call dram_init_banksize() after every call to
>> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
>> correctly.
>>
>> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
>> controllers present.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> 
> This causes a failure to build on current next on j722s_evm_a53 so
> please rebase and repost, thanks.

Sure, thanks for pointing out.

Regards,
Santhosh.

> 
