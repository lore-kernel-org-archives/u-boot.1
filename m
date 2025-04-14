Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6CC369B4
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 14:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5B082047;
	Mon, 14 Apr 2025 16:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qxpVeSA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2282B82102; Mon, 14 Apr 2025 16:40:26 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC18981E25
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 16:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEeL1t2780299
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 09:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744641621;
 bh=ZG1Q0XfGDKmxR2YJW479mbCzPECANH4S1AMnhvUsoJE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=qxpVeSA2+u9BGyPDzbkGr1fnhY15cM/inKFCVTvFP3VY1WQfSj+wTBrNqT2bDuEwC
 fFNITtUtDn/pWnC7Z2/QGF/Xlf7cuiLUiadsC3gRuhwTk9wpPJR3Y4f/MHFGlOLvnq
 DIWurIU9Xo/gttweFl1WGPQBPV4/7ddnv/XedVwM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEeLCb004609
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 09:40:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 09:40:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 09:40:21 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EEeK8T007453;
 Mon, 14 Apr 2025 09:40:20 -0500
Message-ID: <c10226c6-a79e-468f-831e-7d7c19a33348@ti.com>
Date: Mon, 14 Apr 2025 09:40:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] More MMC fixes
To: Bryan Brattlof <bb@ti.com>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Moteen Shah <m-shah@ti.com>
References: <20250408170527.2832563-1-jm@ti.com>
 <20250412170412.7empydbi3dtltjs5@bryanbrattlof.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250412170412.7empydbi3dtltjs5@bryanbrattlof.com>
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

Hi Bryan,

On 4/12/25 12:04 PM, Bryan Brattlof wrote:
> On April  8, 2025 thus sayeth Judith Mendez:
>> This patch series fixes MMC_HS_52 mode in am654_sdhci
>> driver, as well as HIGH_SPEED_ENA and UHS_MODE_SELECT
>> for HS modes.
>>
>> Also Disable eMMC HS400 mode for am62px device according
>> to silicon errata i2458 [0] and add TI_COMMON_CMD_OPTIONS
>> to K3 Sitara board a53 defconfigs.
>>
>> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
>>
>> Judith Mendez (5):
>>    mmc: am654_sdhci: Add MMC_HS_52 to timing data
>>    mmc: am654_sdhci: Fix HIGH_SPEED_ENA
>>    mmc: am654_sdhci: Add am654_sdhci_set_control_reg
>>    configs: am62px_evm_r5/a53_defconfig: Disable eMMC HS400
>>    configs: am62*_evm_a53_defconfig: Add TI_COMMON_CMD_OPTIONS
> 
> This last patch wasn't applying cleanly for me :/ Just needs a simple
> fixup when we rebase. Other than that this series looks good to me!

Got it, I will rebase against master again. Thanks for reviewing!!

> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
> ~Bryan

