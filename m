Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFCECE7B10
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:32:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8F386E33;
	Thu, 28 Sep 2023 11:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="duBQYiZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690D686E3B; Thu, 28 Sep 2023 11:32:32 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB5C86E28
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38S9WS9K106916;
 Thu, 28 Sep 2023 04:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695893548;
 bh=13WHhK1iUCK1tuoa+nwT1L8Izbc/eLXrCkFPSWvI3jg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=duBQYiZEwqEIEfUqLVU+Y1yTy5CzdRVpphTbPBN42Ay83ja4oFe4YzrawTn2maJtx
 JNRIKATyde2rZztuGlNZKy7ecFdAlWL/6Z+sQJr9cxYYpUVliH/nCEUH4rkkgEPWlw
 EHIt7ZKghNPabgsboT13gtBIwFe9b/F7tjYCpPx4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38S9WSiI082042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Sep 2023 04:32:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Sep 2023 04:32:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Sep 2023 04:32:27 -0500
Received: from [10.24.69.29] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38S9WPpr029052;
 Thu, 28 Sep 2023 04:32:26 -0500
Message-ID: <cf40b7e1-81f5-1d04-e49c-3438059d7ba0@ti.com>
Date: Thu, 28 Sep 2023 15:02:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] Add AM62x LP SK support
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927115619.7os7ixn3fef2p3r4@faculty>
From: Nitin Yadav <n-yadav@ti.com>
In-Reply-To: <20230927115619.7os7ixn3fef2p3r4@faculty>
Content-Type: text/plain; charset="UTF-8"
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



On 27/09/23 17:26, Nishanth Menon wrote:
> On 13:51-20230927, Nitin Yadav wrote:
>> This series adds support of AM62x LP SK. The AM62x LP SK board
>> is similar to AM62x SK but has some significant changes that
>> requires different set of device tree at each stage of bootloader.
>> Also refactors to have common nodes at k3-am62x-r5-sk-common.dtsi
>> and k3-am62x-sk-common-u-boot.dtsi for all am62x SoC varients.
>>
>> Nitin Yadav (4):
>>   arm: dts: Refactor common dtsi file for R5 and A53 SPL
>>   arm: dts: Add support for AM62x LP SK
>>   arm: dts: k3-am62-lp-sk-binman: Add binman support
>>   board: ti: am62x: add am62x_lpsk_* defconfigs and env files
>>
>>  arch/arm/dts/Makefile                         |    2 +
>>  arch/arm/dts/k3-am62-lp-sk-binman.dtsi        |   29 +
>>  arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi        |    9 +
>>  arch/arm/dts/k3-am62-lp-sk.dts                |  231 ++
>>  arch/arm/dts/k3-am62-r5-lp-sk.dts             |   21 +
>>  arch/arm/dts/k3-am625-r5-sk.dts               |   94 +-
>>  arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  110 +-
>>  arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi | 2190 +++++++++++++++++
>>  arch/arm/dts/k3-am62x-r5-sk-common.dtsi       |   96 +
>>  arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi   |  109 +
>>  board/ti/am62x/am62x_lpsk_a53.config          |    5 +
>>  board/ti/am62x/am62x_lpsk_r5.config           |    5 +
>>  board/ti/am62x/am62xlpsk.env                  |   21 +
>>  13 files changed, 2724 insertions(+), 198 deletions(-)
>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-binman.dtsi
>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi
>>  create mode 100644 arch/arm/dts/k3-am62-lp-sk.dts
>>  create mode 100644 arch/arm/dts/k3-am62-r5-lp-sk.dts
>>  create mode 100644 arch/arm/dts/k3-am62x-ddr-lp4-50-800-800.dtsi
>>  create mode 100644 arch/arm/dts/k3-am62x-r5-sk-common.dtsi
>>  create mode 100644 arch/arm/dts/k3-am62x-sk-common-u-boot.dtsi
>>  create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
>>  create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
>>  create mode 100644 board/ti/am62x/am62xlpsk.env
>>
> 
> 
> Board documentation missing!

Should I just deltas in am62x_sk.rst or create a new lp_sk.rst ?
> 
> 

-- 
Regards,
Nitin
