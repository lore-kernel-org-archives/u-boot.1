Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C1BC47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DAD87DB4;
	Wed, 24 Jan 2024 13:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PSLulgPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA0787C33; Wed, 24 Jan 2024 11:22:02 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA0087C35
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OALdvr082832;
 Wed, 24 Jan 2024 04:21:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706091699;
 bh=7ir3/MM/RJ+mkTCC8+sB5S+gSecVHfxfCSs2bxTzHEI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PSLulgPIle8A77sG26n/pwA0BTWUYC0f6xz6L6X9nZXrWAZP11XRxOIRTzmcRCg/t
 902v2bbdhx6rxt6lgU/XCeFBV8QjNbHZgsSfdvBr5tZRUyuFnIBloDbeWE/lBdhvU/
 6QgtqForqnNnjIR/oGMT/skiItkc7sKctz/17FCc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OALdS0026148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 04:21:39 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 04:21:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 04:21:38 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OALSH8100582;
 Wed, 24 Jan 2024 04:21:29 -0600
Message-ID: <4e3a76fa-5174-4600-a4f7-787e020d8ed8@ti.com>
Date: Wed, 24 Jan 2024 15:51:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/15] board: ti: am65x: Add check for
 k3-am654-icssg2 in board_fit_config_match()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Stefan Roese <sr@denx.de>, Qu Wenruo
 <wqu@suse.com>, Bryan Brattlof <bb@ti.com>, Sean Anderson
 <seanga2@gmail.com>, Martyn Welch <martyn.welch@collabora.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, FUKAUMI Naoki <naoki@radxa.com>, Christian Hewitt
 <christianshewitt@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
 <20240124064930.1787929-15-danishanwar@ti.com>
 <6017b04a-ec47-49a8-9bac-720137c0d13e@moroto.mountain>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <6017b04a-ec47-49a8-9bac-720137c0d13e@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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



On 24/01/24 1:57 pm, Dan Carpenter wrote:
> On Wed, Jan 24, 2024 at 12:19:29PM +0530, MD Danish Anwar wrote:
>> When CONFIG_TI_ICSSG_PRUETH is enabled, add config name check for the
>> icssg2 overlay in board_fit_config_match() API.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  board/ti/am65x/evm.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
>> index df209021c1..0b661f0084 100644
>> --- a/board/ti/am65x/evm.c
>> +++ b/board/ti/am65x/evm.c
>> @@ -90,10 +90,13 @@ int dram_init_banksize(void)
>>  #ifdef CONFIG_SPL_LOAD_FIT
>>  int board_fit_config_name_match(const char *name)
>>  {
>> -#ifdef CONFIG_TARGET_AM654_A53_EVM
>> -	if (!strcmp(name, "k3-am654-base-board"))
>> -		return 0;
>> -#endif
>> +	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH)) {
>> +		if (!strcmp(name, "k3-am654-icssg2"))
>> +			return 0;
>> +	} else {
>> +		if (!strcmp(name, "k3-am654-base-board"))
>> +			return 0;
>> +	}
>>  
>>  	return -1;
>>  }
> 
> It probably should support both configs being enabled.
> 
> 	if (IS_ENABLED(CONFIG_TI_ICSSG_PRUETH) &&
> 	    strcmp(name, "k3-am654-icssg2") == 0)
> 		return 0;
> 
> 	if (IS_ENABLED(TARGET_AM654_A53_EVM) &&
> 	    strcmp(name, "k3-am654-base-board"))
> 		return 0;
> 
> 	return -1;
> 

Sure Dan. This seems reasonable. I will add check for both configs in
next revision. Thanks for the review.

> regards,
> dan carpenter

-- 
Thanks and Regards,
Danish
