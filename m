Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC01C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 05:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA13C8212F;
	Fri,  9 May 2025 07:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dnqI7Fvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55E282153; Fri,  9 May 2025 07:15:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5E08210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 07:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5495FOw01283868;
 Fri, 9 May 2025 00:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746767724;
 bh=789FUWyJkusOtyylLFu1VxR/RlTSrSa/g1a4H7mAUd0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dnqI7FvuuHysHpzWir8nwu3ZpkHkNJCOSz8FpqU8RNHC1WRfUSiOkKDsyKqX2Dk7l
 DhCZNm7lPUlBeoZbJlyh4Z5uIdRvA1tfW7W7dxz5tqjSAAIYveqozNv6Lio9bU9cYs
 /xBL8svHtsRSAC+iKPyseKa9zHf5OCXvaf3vK0SU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5495FOEn2672372
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 9 May 2025 00:15:24 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 May 2025 00:15:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 May 2025 00:15:23 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5495FIFt036693;
 Fri, 9 May 2025 00:15:19 -0500
Message-ID: <00107029-5e1c-4e41-a21f-7dbfd024e8ac@ti.com>
Date: Fri, 9 May 2025 10:45:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <trini@konsulko.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-5-b-padhi@ti.com> <D9PTUSDYSWS0.J9VVKD57OPPM@ti.com>
 <218f2201-6094-4a93-aae6-e919cbeeda56@ti.com>
 <2fb353e4-b119-40d8-9eb2-717ec2422eaa@ti.com>
 <D9QRG0VOG7FQ.3G9WFJ8ZYUBDZ@ti.com>
 <2f00f1d7-b64f-4419-a9ee-71fa57aa310f@ti.com>
 <949dceec-a4f2-4420-9b34-caf3f54f49b6@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <949dceec-a4f2-4420-9b34-caf3f54f49b6@ti.com>
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

Hi Andrew,

On 08/05/25 20:58, Andrew Davis wrote:
> On 5/8/25 10:03 AM, Beleswar Prasad Padhi wrote:
>>
>> On 5/8/2025 5:29 PM, Anshul Dalal wrote:
>>> On Wed May 7, 2025 at 8:53 PM IST, Andrew Davis wrote:
>>>> On 5/7/25 9:56 AM, Beleswar Prasad Padhi wrote:
>>>>> On 5/7/2025 3:09 PM, Anshul Dalal wrote:
>>>>>> On Tue May 6, 2025 at 4:11 PM IST, Beleswar Padhi wrote:
>>>>>>> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
>>>>>>> and used by R5 SPL to boot the HSM core. By default, point to the
>>>>>>> firmware for HS-SE device type. This needs to be changed to point to
>>>>>>> appropriate firmware when using a different device type.
>>>>>>>
>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>> ---
>>>>>>> v2: Changelog:
>>>>>>> None to this patch.
>>>>>>>
>>>>>>> Link to v1:
>>>>>>> https://lore.kernel.org/all/20250422095430.363792-4-b-padhi@ti.com/
>>>>>>>
>>>>>>>    arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>>>>>>>    arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>>>>>>>    2 files changed, 26 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>>>> index 73af184d27e..9c8b29f53bb 100644
>>>>>>> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>>>> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
>>>>>>> @@ -273,6 +273,14 @@
>>>>>>>                        };
>>>>>>>                    };
>>>>>>> +#ifdef CONFIG_K3_HSM_FW
>>>>>>> +                hsm {
>>>>>>> +                    hsm: blob-ext {
>>>>>>> +                        filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
>>>>>>> +                    };
>>>>>>> +                };
>>>>>>> +#endif
>>>>>>> +
>>>>>> Why do we have the hsm binaries pre-signed? Having a common binary like
>>>>>> the DM with signing using ti-secure might be a better option.
>>>>>
>>>>> Andrew can correct me if I am wrong,
>>>>> HSM is meant to run secure software stack and services like Authentication etc. It is a +1 to TIFS. To establish ROT, we need the HSM binary to be encrypted, and authenticated by TIFS first before it can do stuff by itself. DM is not a secure entity, so signing the image doesn't make sense for me.
>>>>>
>>>> I think Anshul is not suggesting that the HSM binary be unencrypted/unauthenticated.
>>>> Rather that the encrypting/signing be done here in binman like we do with TF-A/OP-TEE.
>>>> (which both are part trusted images to be loaded by TIFS).
>>>>
>>>> To that suggestion I agree, the customer will be doing the signing of this binary, right?
>>>> If so then since all other customer signing is done as part of binman, it makes sense
>>>> to also sign HSM firmware here too.
>>>>
>>>> Andrew
>>> Yeah, that is what I was going for. With that change it could be
>>> possible to also have a single binary for all platforms (gp, hs, hs-fs)
>>> in ti-linux-firmware?
>>>
>>> Also, why are we not adding an unsigned variant of the hsm binary in
>>> tispl.bin_unsigned?
>>
>>
>> What's the use case for that? I think we established that HSM won't be used unsigned. So it will just bloat the FIT and never be used.
>>
>
> We ship an unsigned HSM firmware for GP devices[0], and in patch [7/7] of this
> series you add support for loading that unsigned HSM firmware. 


That is a System Firmware limitation; i.e., no support of loading HSM FW for GP devices. We are providing a workaround for that by manually loading it from MCU R5 core. Besides, HSM SRAM should not even be accessible by MCU R5F core in the first place. HSM should only be accessible & loaded by TIFS. So once the SRAM is firewalled, this flow for loading GP bins won't work, and SYSFW will somehow have to support that, or we just give up unsigned bin load support.

> Seems odd to
> then not ever package it here in binman and claim we will never use it?


IMHO, users can "choose" to package that unsigned HSM bin and boot it in the current flow. Please let me know, if you are okay with packaging an unsigned HSM binary "by default", given the above caveat?

Thanks,
Beleswar

>
> Andrew
>
> [0] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-hsm?h=ti-linux-firmware
