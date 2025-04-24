Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD09C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 05:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A201806FC;
	Thu, 24 Apr 2025 07:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PB1R6op7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F3F8082A; Thu, 24 Apr 2025 07:35:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED5EF8056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 07:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5ZGUh2519059
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Apr 2025 00:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745472916;
 bh=tFakRovGnxNOCMRZHRZ/2vUVxQTGSIAnIV1SF/dASpc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=PB1R6op7B2YwWzeO0OP78nlM9Y48jun3Di+frQ6BG+Z+4/ksQlZbYP+eFGhUt+Qyj
 /k+z746kgSexNzgr9+tUS0ydjYn8GG7g6P8wWBkVg+z535aZsAM4/gAroKr/eMj4Bt
 RaAe0etksoKZOJTRiUolWRRbqJy/UcEemwogewFw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O5ZG6c064802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Apr 2025 00:35:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 00:35:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 00:35:15 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O5ZC5U099690;
 Thu, 24 Apr 2025 00:35:13 -0500
Message-ID: <0d332842-322b-4ad3-832c-727bb0b1936e@ti.com>
Date: Thu, 24 Apr 2025 11:05:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-4-b-padhi@ti.com>
 <07f83df4-fa97-47be-bedb-8bafad560a4a@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <07f83df4-fa97-47be-bedb-8bafad560a4a@ti.com>
Content-Type: text/plain; charset="UTF-8"
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


On 22/04/25 20:06, Andrew Davis wrote:
> On 4/22/25 4:54 AM, Beleswar Padhi wrote:
>> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
>> and used by R5 SPL to boot the HSM core. By default, point to the
>> firmware for HS-SE device type. This needs to be changed to point to
>> appropriate firmware when using a different device type.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>   arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
>> index d121d8c0c54..1e6cdf92421 100644
>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>> @@ -280,6 +280,14 @@
>>                         };
>>                   };
>> +#ifdef CONFIG_K3_HSM_FW
>
> Is there some way to make this blob "optional" so that
> we don't need all this #ifdef stuff everywhere? It makes
> the image structures here harder to follow.


That was the initial thought. But I don't think 'optional' is working the way we expect it to be.
Currently, if I mark the node as optional and build U-Boot without the firmware, I get errors:

```
BINMAN  .binman_stamp
Image 'tispl' has faked external blobs and is non-functional: hsm-demo-firmware-j784s4-hs.bin
Image 'tispl' is missing optional external blobs but is still functional: blob-ext
/binman/tispl/fit/images/hsm/blob-ext (ti-hsm/hsm-demo-firmware-j784s4-hs.bin):
   Missing blob

Some images are invalid
make[2]: *** [/src/u-boot/Makefile:1135: .binman_stamp] Error 103
```

There has been some discussion in getting optional working[0], but I am not sure what is the conclusion.

[0]: https://lore.kernel.org/all/20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de/

Thanks,
Beleswar

>
> Andrew
>
>> +                hsm {
>> +                    hsm: blob-ext {
>> +                        filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>> +                    };
>> +                };
>> +#endif
>> +
>>                   dm {
>>                       ti-secure {
>>                           content = <&dm>;
>> @@ -312,7 +320,11 @@
>>                   conf-0 {
>>                       description = "k3-j721s2-common-proc-board";
>>                       firmware = "atf";
>> +#ifdef CONFIG_K3_HSM_FW
>> +                    loadables = "hsm", "tee", "dm", "spl";
>> +#else
>>                       loadables = "tee", "dm", "spl";
>> +#endif
>>                       fdt = "fdt-0";
>>                   };
>>               };
>> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
>> index 0553825b383..ab417a47034 100644
>> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
>> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
>> @@ -159,6 +159,16 @@
>>             fit {
>>               images {
>> +
>> +#ifdef CONFIG_K3_HSM_FW
>> +                hsm {
>> +                    hsm: blob-ext {
>> +                        filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
>> +                    };
>> +                };
>> +
>> +#endif
>> +
>>                   dm {
>>                       ti-secure {
>>                           content = <&dm>;
>> @@ -194,7 +204,11 @@
>>                   conf-0 {
>>                       description = BOARD_DESCRIPTION;
>>                       firmware = "atf";
>> +#ifdef CONFIG_K3_HSM_FW
>> +                    loadables = "hsm", "tee", "dm", "spl";
>> +#else
>>                       loadables = "tee", "dm", "spl";
>> +#endif
>>                       fdt = "fdt-0";
>>                   };
>>               };
