Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BEBC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C7381F32;
	Wed,  7 May 2025 16:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yF2niX6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A16820EB; Wed,  7 May 2025 16:56:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478428059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 16:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 547Euin81403365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 09:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746629804;
 bh=slMy3vwIToiQjq6wnGcfmntgc7EWQQknctyuOh2H43E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=yF2niX6fw2UNrMjQ72Ns82XOgFv3rG/vMjNI/GfyIBhlQkMx7h49l524RXngoln1A
 DmCdNFEEFsJc8vfuXhoobdsnDmzpt2kQEiLhy+A809ybKafOW+Q1+7ugiloW4rU4hi
 UflTitdCgu635Nd9FzNPCK9wBM/IAwMnI8q4+9Rc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 547EuiIk013887
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 May 2025 09:56:44 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 09:56:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 09:56:43 -0500
Received: from [10.249.140.90] ([10.249.140.90])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 547Eua3m061987;
 Wed, 7 May 2025 09:56:37 -0500
Message-ID: <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
Date: Wed, 7 May 2025 20:26:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Anshul Dalal <anshuld@ti.com>, <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com> <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
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


On 5/7/2025 3:09 PM, Anshul Dalal wrote:
> On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
>> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
>> and used by R5 SPL to boot the HSM core. By default, point to the
>> firmware for HS-SE device type. This needs to be changed to point to
>> appropriate firmware when using a different device type.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> v2: Changelog:
>> None to this patch.
>>
>> Link to v1:
>> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>>
>>   arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>   arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
>> index 73af184d27e..9c8b29f53bb 100644
>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>> @@ -273,6 +273,14 @@
>>   
>>   					};
>>   				};
>> +#ifdef CONFIG_K3_HSM_FW
>> +				hsm {
>> +					hsm: blob-ext {
>> +						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>> +					};
>> +				};
>> +#endif
>> +
> Why do we have the hsm binaries pre-signed? Having a common binary like
> the DM with signing using ti-secure might be a better option.


Andrew can correct me if I am wrong,
HSM is meant to run secure software stack and services like 
Authentication etc. It is a +1 to TIFS. To establish ROT, we need the 
HSM binary to be encrypted, and authenticated by TIFS first before it 
can do stuff by itself. DM is not a secure entity, so signing the image 
doesn't make sense for me.

>
> Regards,
>
>>   				dm {
>>   					ti-secure {
>>   						content = <&dm>;
>> @@ -306,7 +314,11 @@
>>   				conf-0 {
>>   					description = "k3-j721s2-common-proc-board";
>>   					firmware = "atf";
>> +#ifdef CONFIG_K3_HSM_FW
>> +					loadables = "hsm", "tee", "dm", "spl";
>> +#else
>>   					loadables = "tee", "dm", "spl";
>> +#endif
>>   					fdt = "fdt-0";
>>   				};
>>   			};
>> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
>> index cb1fbc65923..7c8e580a8a3 100644
>> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
>> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
>> @@ -159,6 +159,16 @@
>>   
>>   		fit {
>>   			images {
>> +
>> +#ifdef CONFIG_K3_HSM_FW
>> +				hsm {
>> +					hsm: blob-ext {
>> +						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
>> +					};
>> +				};
>> +
>> +#endif
>> +
>>   				dm {
>>   					ti-secure {
>>   						content = <&dm>;
>> @@ -194,7 +204,11 @@
>>   				conf-0 {
>>   					description = BOARD_DESCRIPTION;
>>   					firmware = "atf";
>> +#ifdef CONFIG_K3_HSM_FW
>> +					loadables = "hsm", "tee", "dm", "spl";
>> +#else
>>   					loadables = "tee", "dm", "spl";
>> +#endif
>>   					fdt = "fdt-0";
>>   				};
>>   			};
