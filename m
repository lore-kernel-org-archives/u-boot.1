Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450FC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A7587B51;
	Tue, 23 Jan 2024 15:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mkbFEdz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D974287CAA; Tue, 23 Jan 2024 15:59:08 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363EA8794F
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NEwl9Z067769;
 Tue, 23 Jan 2024 08:58:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706021927;
 bh=DxnLiaIXGCteNEymoEM8YQ9yict2CfCJtrqaYaryoOA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mkbFEdz5IfS7WCBsvGQCJwjCFL0mETJvTa4pbXQJx3GbpYvvl3NF6pjilbG0BNsmK
 BeONFf7RsPEfJn34gB0rnWk+H0dhXhiyjhzBlPbrt/vwUAx4Qr8tvJvwAKTkZlsAAf
 jbBuUCz2aa2p3ErkZxRX6sC4XloFEt8dYlXQus8I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NEwlO9023406
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 08:58:47 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:58:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:58:46 -0600
Received: from [10.24.68.115] (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NEweAY111280; 
 Tue, 23 Jan 2024 08:58:41 -0600
Message-ID: <f7cd5cbe-7c14-429e-b5c1-9f994f3ea4f7@ti.com>
Date: Tue, 23 Jan 2024 20:28:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/16] arm: dts: Introduce j784s4 u-boot dts files
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20240119175043.3904751-1-a-nandan@ti.com>
 <20240119175043.3904751-13-a-nandan@ti.com>
 <20240119191743.xtxtuhnmhw7eq662@bonus>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20240119191743.xtxtuhnmhw7eq662@bonus>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 20/01/24 00:47, Nishanth Menon wrote:
> On 23:20-20240119, Apurva Nandan wrote:
> [...]
>
>> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
>> new file mode 100644
>> index 0000000000..d0d49b5bbe
>> --- /dev/null
>> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
>> @@ -0,0 +1,345 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Texas Instruments Incorporated -https://www.ti.com/
>> + */
>> +
>> +#include "k3-binman.dtsi"
>> +
>> +#ifdef CONFIG_TARGET_J784S4_R5_EVM
>> +
>> +&rcfg_yaml_tifs {
>> +	config = "tifs-rm-cfg.yaml";
>> +};
>> +
>> +&binman {
>> +	tiboot3-j784s4-hs-evm.bin {
>> +		filename = "tiboot3-j784s4-hs-evm.bin";
>> +
> https://lore.kernel.org/u-boot/20240103174756.xa4rzbn4klk5gv2x@aware/
>
> You haven't responded on thread why
> "Prefer #1 - j784s4 binman template" is not feasible or not desirable.
>
> Something like:
>
> in j784s4-binman.dtsi:
>
>
>   &binman {
>          j784s4_tiboot3_hs_fs_template: template-9 {
>
> and then in sk.dtsi:
sk.dtsi means sk-uboot.dtsi or sk-binman.dtsi?
> &binman {
>        ti-j784s4-hs-evm.bin {
>           insert-template =<&j784s4_tiboot3_hs_fs_template>;
>       };
> };
>
> This allows boards to readily include the template for the binaries of
> choice and generate just relevant output. Wont it save much confusion?
>
> [...]
It is still little unclear what is the full thing that you are 
recommending to implement here.
 From what I understood, is it as follows?

- Three binman files will be there: j784s4-binman.dtsi (soc binman), 
j784s4-evm-binman.dtsi and am69-sk-binman.dtsi (board binman)
- j784s4-binman.dtsi will be a SoC binman, and will have only templates 
for all tiboot3 gp, hs, hsfs, and tispl/uboot
- The board binman files will include these templates and update the dtb 
files in them.
- Final board.dts will use the correct board-binman.dtsi files

Please correct wherever wrong.

-- 
Regards,
Apurva Nandan,
Texas Instruments.
