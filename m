Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6701AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC71E87D7B;
	Wed,  1 Nov 2023 19:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cTNH6M4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E02387524; Wed,  1 Nov 2023 19:23:31 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D648186C3B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1698863006; x=1701455006;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ynNVK4+r6LnIF3JjNhHEFKyGGedTqPHiwyqA4Lb/CFk=;
 b=cTNH6M4EFLpqk/Gls6KHg8302ryCxpVH8FhIpw2XbtkY2cOYogm0vkw4cmBk5YN0
 H/n+OtnVpYd5PAggZUUt83a7U6TsX6A1EfL8W4t9DY3aut7o2TEOywEyeg38j4a1
 JP9utzz8PeBdrokgx9uS4pKbbqP8iYmd36We+mFdZVw=;
X-AuditID: ac14000a-b2f4b700000074e4-38-6542979eaded
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 68.B8.29924.E9792456;
 Wed,  1 Nov 2023 19:23:26 +0100 (CET)
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 1 Nov 2023
 19:23:25 +0100
Message-ID: <33df3edd-3ede-4cb9-83b0-984c1cada5bb@phytec.de>
Date: Wed, 1 Nov 2023 19:23:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>
References: <20231031133732.265589-1-w.egorov@phytec.de>
 <20231101155734.5mzpvq4xcm2o5emm@dhruva>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231101155734.5mzpvq4xcm2o5emm@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWyRpKBR3fedKdUg+fn5Cxa1npYvPlxlsni
 7d5Odovud+oOLB5n7+xg9OjvbmH1OH5jO1MAcxSXTUpqTmZZapG+XQJXxvOGMywF59Qqfn+c
 ydbAuFOui5GTQ0LARGJJZwtbFyMXh5DAYiaJ5nl3WCGcO4wSv1u7WUGqeAVsJJa/n8QOYrMI
 qEjM3XuEDSIuKHFy5hMWEFtUQF7i/q0ZYDXCAt4SX7/tALOZBcQlbj2ZzwRiiwDV/Fm1lAUi
 7izRePolWI2QQLJE47yFYLvYBNQl7mz4BmZzCphKzF12DareQmLxm4NQM+Ultr+dwwzRKy/x
 4tJyFohv5CWmnXvNDGGHShzZtJppAqPwLCSnzkJy0iwkY2chGbuAkWUVo1BuZnJ2alFmtl5B
 RmVJarJeSuomRlA0iDBw7WDsm+NxiJGJg/EQowQHs5II72FTh1Qh3pTEyqrUovz4otKc1OJD
 jNIcLErivPd7mBKFBNITS1KzU1MLUotgskwcnFINjMkb5ppNankZ9Dlq9fpvMUt17ya8Whjx
 VTuB9Vffv3ypJ5VrU360WL45mPZ5q9rum1/vL/Myjo5Z9FXW32ynczCPwBpuL559h2fzaO/s
 aaqda6fG0bJZQ3PWFheTV4L3bWKv+tq933rTdurN5JUXljO8Ysi/eW2C5kc1X9dKtoVJdzsn
 HDoaO1GJpTgj0VCLuag4EQDG2OE7dAIAAA==
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

Hi Dhruva,

Am 01.11.23 um 16:57 schrieb Dhruva Gole:
> Hi,
>
> On Oct 31, 2023 at 14:37:31 +0100, Wadim Egorov wrote:
>> Add basic support for PHYTEC phyCORE-AM62x SoM.
>>
>> Supported features:
>>    - 2GB DDR4 RAM
>>    - eMMC Flash
>>    - OSPI NOR Flash
>>    - external uSD
>>    - Ethernet
>>    - debug UART
>>
>> Product page SoM: https://www.phytec.com/product/phycore-am62x
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   arch/arm/dts/Makefile                         |    4 +-
>>   .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
>>   arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
>>   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  229 ++
>>   arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
>>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  532 ++++
>>   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  134 +
>>   arch/arm/mach-k3/Kconfig                      |    1 +
>>   board/phytec/phycore_am62x/Kconfig            |   52 +
>>   board/phytec/phycore_am62x/MAINTAINERS        |   15 +
>>   board/phytec/phycore_am62x/Makefile           |    8 +
>>   board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
>>   board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
>>   board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
>>   board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
>>   board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
>>   board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
>>   configs/phycore_am62x_a53_defconfig           |  116 +
>>   configs/phycore_am62x_r5_defconfig            |  131 +
>>   include/configs/phycore_am62x.h               |   15 +
>>   20 files changed, 5613 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
>>   create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
>>   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
>>   create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
>>   create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
>>   create mode 100644 board/phytec/phycore_am62x/Kconfig
>>   create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
>>   create mode 100644 board/phytec/phycore_am62x/Makefile
>>   create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
>>   create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
>>   create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
>>   create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
>>   create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
>>   create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
>>   create mode 100644 configs/phycore_am62x_a53_defconfig
>>   create mode 100644 configs/phycore_am62x_r5_defconfig
>>   create mode 100644 include/configs/phycore_am62x.h
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 55aceb51cd..8b371266dc 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -1383,7 +1383,9 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-sk.dtb \
>>   			      k3-am625-beagleplay.dtb \
>>   			      k3-am625-r5-beagleplay.dtb \
>>   			      k3-am625-verdin-wifi-dev.dtb \
>> -			      k3-am625-verdin-r5.dtb
>> +			      k3-am625-verdin-r5.dtb \
>> +			      k3-am625-phyboard-lyra-rdk.dtb \
>> +			      k3-am625-r5-phycore-som-2gb.dtb
> Thanks for upstreaming Wadim!
>
> However I would prefer that you split all these patches into smaller
> chunks for each file (preferrably) or group together files that have
> like 20-30 lines of changes.

Hm, seems to be difficult and not really reasonable to split like that.
The big files are generated files or copy pasted from TI's evm. So I do 
not think they need a big attention in the review process.

- All yaml files are identical to TI's evm
- k3-am62-phycore-som-ddr4-2gb.dtsi generated with TI's SysConfig DDR Tool
- k3-am62-phycore-som.dtsi & k3-am625-phyboard-lyra-rdk.dts are 1:1 
copies from vanilla Linux tree

The rest is pretty small and reviewable IMO.

I agree, I should have created a cover letter. I can do that in the next 
series.

Please let me know if you still want me to split it into more patches.
But it would be nice if you could tell me how to split it exactly 
without ending up with broken pieces.

Regards,
Wadim

>
> It's difficult to review thousands of lines of code at once, hope you
> understand.
>
> Also would appreciate it if you sent the series with a cover letter
> summarising your changes. You can also attach boot logs or any
> additional info you may want the people reviewing/ testing the patches to
> know in the cover letter.
>
>>   
>>   dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-sk.dtb \
>>   			      k3-am62a7-r5-sk.dtb
> [..snip..]
>
