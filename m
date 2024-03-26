Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE830C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 12:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4487888076;
	Tue, 26 Mar 2024 13:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KE9hoEGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C8688073; Tue, 26 Mar 2024 13:33:56 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D6087FDA
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCXjp5082791;
 Tue, 26 Mar 2024 07:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711456425;
 bh=m5w0gVKAo+V1bT33j3cAbgWJ+igUAW/FVJpXIF6F20g=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KE9hoEGl2rK4pqR8ELuHp3cqnR+nvng2qtCWyMqgVkNB/9zxY897fljaVAAKosC21
 x7/kepFN1ixCnlCvuYm35NrWKY72dZqfk068T4ERcLVmaqfsWhFM+U9Zva4ADfXEWv
 nqXZkNHHpEWvujJGx2pWUfkEE2KoWpCIkWDJKabA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCXj1x022962
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Mar 2024 07:33:45 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:33:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:33:44 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCXe4T096639;
 Tue, 26 Mar 2024 07:33:40 -0500
Message-ID: <01d903da-353f-4d9d-8b9a-610e34b6ee20@ti.com>
Date: Tue, 26 Mar 2024 18:03:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-*-binman.dtsi: Clean up and templatize
 boot binaries
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <sumit.garg@linaro.org>,
 <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>
References: <20240322131011.1029620-1-n-francis@ti.com>
 <20240322131011.1029620-4-n-francis@ti.com>
 <20240326122723.f2dwxggu7yop7jf2@booted>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240326122723.f2dwxggu7yop7jf2@booted>
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

Hi Nishanth

On 26/03/24 17:57, Nishanth Menon wrote:
> On 18:40-20240322, Neha Malcom Francis wrote:
>> Clean up templatized boot binaries for all K3 boards. This includes
>> modifying the k3-binman.dtsi to use SPL_BOARD_DTB, BOARD_DESCRIPTION and
>> UBOOT_BOARD_DESCRIPTION from the files that include it to further reuse
>> code.
>>
>> All k3-<soc>-binman.dtsi will contain only templates. Only required boot
>> binaries can be built from the templates in the boards' respective
>> -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
>> clear distinction between the SoC common stuff vs. what is additionally
>> needed to boot up a specific board.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 161 +---------
>>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 291 +----------------
>>   arch/arm/dts/k3-am625-r5-beagleplay.dts       |  39 ---
>>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 148 +--------
>>   arch/arm/dts/k3-am625-sk-u-boot.dtsi          |  42 +++
>>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 296 +-----------------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 146 +--------
>>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  42 +++
>>   arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  42 +++
>>   arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  42 +++
>>   arch/arm/dts/k3-am64x-binman.dtsi             | 239 +-------------
>>   arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |  49 +++
>>   arch/arm/dts/k3-am65x-binman.dtsi             | 144 +--------
>>   .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  26 ++
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  31 +-
>>   arch/arm/dts/k3-binman.dtsi                   |  96 ++++++
>>   arch/arm/dts/k3-j7200-binman.dtsi             | 145 +--------
>>   .../k3-j7200-common-proc-board-u-boot.dtsi    |  40 +++
>>   .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 154 +--------
>>   arch/arm/dts/k3-j721e-binman.dtsi             | 262 +++-------------
>>   .../k3-j721e-common-proc-board-u-boot.dtsi    |  84 +++++
>>   arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |  91 +-----
>>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  84 +++++
>>   arch/arm/dts/k3-j721s2-binman.dtsi            | 231 +-------------
>>   .../k3-j721s2-common-proc-board-u-boot.dtsi   |  42 +++
>>   arch/arm/dts/k3-j784s4-binman.dtsi            | 154 +--------
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  42 +++
>>   27 files changed, 858 insertions(+), 2305 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> index cca0f44b7d8..fc1898f1510 100644
>> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
>> @@ -6,7 +6,11 @@
>>    * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
>>    */
>>   
>> -#include "k3-binman.dtsi"
>> +#define SPL_BOARD_DTB "spl/dts/k3-am625-beagleplay.dtb"
>> +#define BOARD_DESCRIPTION "k3-am625-beagleplay"
>> +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM625 BeaglePlay"
>> +
>> +#include "k3-am625-sk-binman.dtsi"
> 
> Drop the "sk" ?
> 

Yes Andrew had pointed it out earlier, will make the change in the next version.

-- 
Thanking You
Neha Malcom Francis
