Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0379EEE8018
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 15:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4CA486A5A;
	Fri,  8 Sep 2023 17:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s1pss3AS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8239C86A63; Fri,  8 Sep 2023 17:55:22 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8793086A04
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 17:55:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388FtF81042092;
 Fri, 8 Sep 2023 10:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694188515;
 bh=rBglQhjKVhUWyzhPIwllD1XwrttnlKcBSLurfqovTek=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=s1pss3AS1OR6k3uRWquW+Vmm0Nzk6urrHmZ+XehDg7P9jbjXtirhRwQczhrF5lLYu
 VB0gyrSX4nvUyElVFLI+0fdQSzPUryjT+TBqmGqUsbF6wprAPJguUy0c118gJ4MYF1
 8pjrEP/rFl+vYAkbEOZ7847pWA76m76XdFfs1XIw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388FtFRj111249
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 10:55:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 10:55:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 10:55:15 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388FtEV3004424;
 Fri, 8 Sep 2023 10:55:14 -0500
Message-ID: <761447f2-e594-d24d-2971-9e43d0f3cbfc@ti.com>
Date: Fri, 8 Sep 2023 10:55:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
 <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
 <20230906051840.3747bkybpqd2m4gg@ula0497581>
 <4eb25acc-0d36-fa59-eb89-b8e3321dae3e@ti.com>
 <20230908114312.weraz2yvskcaboku@ula0497581>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230908114312.weraz2yvskcaboku@ula0497581>
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

On 9/8/23 6:43 AM, Manorit Chawdhry wrote:
> Hi Andrew,
> 
> On 08:54-20230906, Andrew Davis wrote:
>> On 9/6/23 12:18 AM, Manorit Chawdhry wrote:
>>> Hi Andrew,
>>>
>>> On 10:22-20230905, Andrew Davis wrote:
>>>> On 9/5/23 3:21 AM, Manorit Chawdhry wrote:
>>>>> The following commits adds the configuration of firewalls required to
>>>>> protect ATF and OP-TEE memory region from non-secure reads and
>>>>> writes using master and slave firewalls present in our K3 SOCs.
>>>>>
>>>>> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
>>>>> ---
>>>>>     arch/arm/dts/k3-j721e-binman.dtsi | 161 ++++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 161 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
>>>>> index 4f566c21a9af..0569a592597e 100644
>>>>> --- a/arch/arm/dts/k3-j721e-binman.dtsi
>>>>> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
>>>>> @@ -330,6 +330,73 @@
>>>>>     					ti-secure {
>>>>>     						content = <&atf>;
>>>>>     						keyfile = "custMpk.pem";
>>>>> +						auth_in_place = <0xa02>;
>>>>> +
>>>>> +						// cpu_0_cpu_0_msmc Background Firewall - 0
>>>>
>>>> I don't have a personal preference, but I see most comments in DTS
>>>> are C style /* */.
>>>>
>>>> Also it might be easier to understand if you put the comments right before
>>>> the properties that they relate to, i.g.
>>>>
>>>> firewall-0 {
>>>> 	/* cpu_0_cpu_0_msmc */
>>>> 	id = <257>;
>>>> 	region = <0>;
>>>> 	/* Background, Locked */
>>>> 	control = <0x31a>;
>>>> 	permissions = <0xc3ffff>;
>>>> 	start_address = <0x0 0x0>;
>>>> 	end_address = <0xff 0xffffffff>;
>>>> };
>>>>
>>>> For permissions, I wonder if it would be easier to read if we add
>>>> some helper macros:
>>>>
>>>> #define FWPRIVID_ALL 0xc3
>>>>
>>>> #define FWPERM_SECURE_PRIV_WRITE      BIT(0)
>>>> #define FWPERM_SECURE_PRIV_READ       BIT(1)
>>>> #define FWPERM_SECURE_PRIV_CACHEABLE  BIT(2)
>>>> #define FWPERM_SECURE_PRIV_DEBUG      BIT(3)
>>>> #define FWPERM_SECURE_USER_WRITE      BIT(4)
>>>> ...
>>>>
>>>> Then you would have:
>>>>
>>>> permissions = <FWPRIVID_ALL |
>>>
>>> I think we'll have to do some shift here for the right calculations.
>>>
>>>     #define FWPRIVID_SHIFT 8
>>>
>>>     permissions = <(FWPRIVID_ALL << FWPRIVID_SHIFT)
>>
>> Right, I must have meant #define FWPRIVID_ALL 0xc30000 above, but
>> a shift looks better.
>>
>>>>                  FWPERM_SECURE_PRIV_WRITE |
>>>>                  FWPERM_SECURE_PRIV_READ |
>>>
>>> Also, I would like to make FWPERM_SECURE_PRIV_RWCD too as it'll be
>>> commonly used.
>>>
>>> Would be sending another RFC with this change if you are fine with the
>>> suggestions. Thank you for reviewing!
>>>
>>
>> Works for me, should get rid of several of these magic numbers.
>>
>> Andrew
> 
> firewall-0 {
>      id = <257>;
>      region = <0>;
>      control = <(FWCTRL_EN | FWCTRL_LOCK |
>                  FWCTRL_BG | FWCTRL_CACHE)>;
>      permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
>                      FWPERM_SECURE_PRIV_RWCD |
>                      FWPERM_SECURE_USER_RWCD |
>                      FWPERM_NON_SECURE_PRIV_RWCD |
>                      FWPERM_NON_SECURE_USER_RWCD)>;
>      start_address = <0x0 0x0>;
>      end_address = <0xff 0xffffffff>;
> };
> 
> Does this look okay now?
> 

Yes, that can be parsed by humans now, which is much less
error-prone than bitmask'd magic numbers :)

Andrew

> Regards,
> Manorit
> 
>>
>>> Regards,
>>> Manorit
>>>
>>>>                  ...
>>>
>>>
>>>>> ;
>>>>
>>>>> +						firewall-0 {
>>>>> +							id = <257>;
>>>>> +							region = <0>;
>>>>> +							control = <0x31a>;
>>>>> +							permissions = <0xc3ffff>;
>>>>> +							start_address = <0x0 0x0>;
>>>>> +							end_address = <0xff 0xffffffff>;
>>>>> +						};
>>>>> +
>>>>> +						// cpu_0_cpu_0_msmc Foreground Firewall
>>>>> +						firewall-1 {
>>>>> +							id = <257>;
>>>>> +							region = <1>;
>>>>> +							control = <0x1a>;
>>>>> +							permissions = <0x0100ff>;
>>>>> +							start_address = <0x0 0x70000000>;
>>>>
>>>> This address might change if one moves ATF, might work to use CONFIG_K3_ATF_LOAD_ADDR?
>>>> Not sure how you would get the end address as we don't really know ATF size..
>>>>
>>>> Andrew
