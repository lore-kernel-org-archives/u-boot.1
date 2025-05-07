Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCD7C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA6D81FAB;
	Wed,  7 May 2025 17:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pi3y3QoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080598214B; Wed,  7 May 2025 17:23:29 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B26B48059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 547FNIQ6850384
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 10:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746631399;
 bh=NOu2wT6cPm6sbtbiGCH2v46n6QGmSyfb4HPuyWGB8Tc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pi3y3QoBPcGsR7Qc8DWnr20bhA6oOBcI1XN4bW1c42IqifOfaeh7oTQkw23BCMvxW
 c6dePiIRSlAMDbwATyMG1xt5YVf0VkMYcOyBwsmh8+2s3RUWO7hKybT4mOGkF4dWbz
 FWQB0UmIvRVg68wNnc7Ci+np3rg5Ezz9bTZCB41A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 547FNITT061237
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 May 2025 10:23:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 10:23:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 10:23:17 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 547FNHGX097688;
 Wed, 7 May 2025 10:23:17 -0500
Message-ID: <2fb353e4-b119-40d8-9eb2-717ec2422eaa@ti.com>
Date: Wed, 7 May 2025 10:23:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com> <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
 <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 5/7/25 9:56 AM, Beleswar Prasad Padhi wrote:
> 
> On 5/7/2025 3:09 PM, Anshul Dalal wrote:
>> On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
>>> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
>>> and used by R5 SPL to boot the HSM core. By default, point to the
>>> firmware for HS-SE device type. This needs to be changed to point to
>>> appropriate firmware when using a different device type.
>>>
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>> ---
>>> v2: Changelog:
>>> None to this patch.
>>>
>>> Link to v1:
>>> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>>>
>>>   arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>>   arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
>>> index 73af184d27e..9c8b29f53bb 100644
>>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>>> @@ -273,6 +273,14 @@
>>>                       };
>>>                   };
>>> +#ifdef CONFIG_K3_HSM_FW
>>> +                hsm {
>>> +                    hsm: blob-ext {
>>> +                        filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>>> +                    };
>>> +                };
>>> +#endif
>>> +
>> Why do we have the hsm binaries pre-signed? Having a common binary like
>> the DM with signing using ti-secure might be a better option.
> 
> 
> Andrew can correct me if I am wrong,
> HSM is meant to run secure software stack and services like Authentication etc. It is a +1 to TIFS. To establish ROT, we need the HSM binary to be encrypted, and authenticated by TIFS first before it can do stuff by itself. DM is not a secure entity, so signing the image doesn't make sense for me.
> 

I think Anshul is not suggesting that the HSM binary be unencrypted/unauthenticated.
Rather that the encrypting/signing be done here in binman like we do with TF-A/OP-TEE.
(which both are part trusted images to be loaded by TIFS).

To that suggestion I agree, the customer will be doing the signing of this binary, right?
If so then since all other customer signing is done as part of binman, it makes sense
to also sign HSM firmware here too.

Andrew

>>
>> Regards,
>>
>>>                   dm {
>>>                       ti-secure {
>>>                           content = <&dm>;
>>> @@ -306,7 +314,11 @@
>>>                   conf-0 {
>>>                       description = "k3-j721s2-common-proc-board";
>>>                       firmware = "atf";
>>> +#ifdef CONFIG_K3_HSM_FW
>>> +                    loadables = "hsm", "tee", "dm", "spl";
>>> +#else
>>>                       loadables = "tee", "dm", "spl";
>>> +#endif
>>>                       fdt = "fdt-0";
>>>                   };
>>>               };
>>> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
>>> index cb1fbc65923..7c8e580a8a3 100644
>>> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
>>> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
>>> @@ -159,6 +159,16 @@
>>>           fit {
>>>               images {
>>> +
>>> +#ifdef CONFIG_K3_HSM_FW
>>> +                hsm {
>>> +                    hsm: blob-ext {
>>> +                        filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
>>> +                    };
>>> +                };
>>> +
>>> +#endif
>>> +
>>>                   dm {
>>>                       ti-secure {
>>>                           content = <&dm>;
>>> @@ -194,7 +204,11 @@
>>>                   conf-0 {
>>>                       description = BOARD_DESCRIPTION;
>>>                       firmware = "atf";
>>> +#ifdef CONFIG_K3_HSM_FW
>>> +                    loadables = "hsm", "tee", "dm", "spl";
>>> +#else
>>>                       loadables = "tee", "dm", "spl";
>>> +#endif
>>>                       fdt = "fdt-0";
>>>                   };
>>>               };
