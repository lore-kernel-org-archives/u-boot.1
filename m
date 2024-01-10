Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E126C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 06:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594998786E;
	Wed, 10 Jan 2024 07:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UivAfYqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5E58789B; Wed, 10 Jan 2024 07:51:15 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9893487866
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40A6p3qp030393;
 Wed, 10 Jan 2024 00:51:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704869463;
 bh=8YtJyyxSjyp8PLcEz9ZdrJ6cvPjIF+O3atYOrXOfoso=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=UivAfYqzg90vRT+iUi/NmNm5+eIM01ZAG1EYz15ji3BSI0bQ5sCpQTHwh1uQnxgtw
 E9G9JgpGNo1BvObee/5bGZIxQRpJgzjvL4Q28A49hl7PLUsSY3MLrs1+w23/3AADy8
 V2kq9muRbGY6Wr4gjX1P+rXyBNxnfOvMODBpuULg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40A6p31U129239
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jan 2024 00:51:03 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jan 2024 00:51:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jan 2024 00:51:03 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40A6ovLd026159;
 Wed, 10 Jan 2024 00:50:58 -0600
Message-ID: <427c0741-5daf-4370-9cf6-5c70d8d6f673@ti.com>
Date: Wed, 10 Jan 2024 12:20:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/16] arm: dts: k3-am65x-binman: Add ICSSG2 overlay
 and configuration
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
To: Roger Quadros <rogerq@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-13-danishanwar@ti.com>
 <1745ec33-7446-41fc-886a-704eb6e53c7e@kernel.org>
 <a5d94983-5b36-45d3-b1ef-92cc0da1a505@ti.com>
In-Reply-To: <a5d94983-5b36-45d3-b1ef-92cc0da1a505@ti.com>
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

Hi Roger,

On 27/12/23 3:49 pm, MD Danish Anwar wrote:
> On 20/12/23 4:10 pm, Roger Quadros wrote:
>>
>>
>> On 19/12/2023 12:34, MD Danish Anwar wrote:
>>> Add ICSSG2 overlay and configuration to tispl and u-boot images.
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  arch/arm/dts/k3-am65x-binman.dtsi | 85 +++++++++++++++++++++++++++++++
>>>  1 file changed, 85 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
>>> index 8cc24da1f3..9a0c0fca47 100644
>>> --- a/arch/arm/dts/k3-am65x-binman.dtsi
>>> +++ b/arch/arm/dts/k3-am65x-binman.dtsi
>>> @@ -98,6 +98,8 @@
>>>  #define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
>>>  #define AM654_EVM_DTB "u-boot.dtb"
>>>  
>>> +#define AM654_EVM_ICSSG2_DTBO "arch/arm/dts/k3-am654-icssg2.dtbo"
>>> +
>>>  &binman {
>>>  	ti-spl {
>>>  		insert-template = <&ti_spl_template>;
>>> @@ -124,6 +126,20 @@
>>>  						filename = SPL_AM654_EVM_DTB;
>>>  					};
>>>  				};
>>> +
>>> +				fdt-1 {
>>> +					description = "k3-am654-icssg2 overlay";
>>> +					type = "flat_dt";
>>> +					arch = "arm";
>>> +					compression = "none";
>>> +					ti-secure {
>>> +						content = <&spl_am65x_evm_icssg2_dtb>;
>>> +						keyfile = "custMpk.pem";
>>> +					};
>>> +					spl_am65x_evm_icssg2_dtb: blob-ext {
>>> +						filename = AM654_EVM_ICSSG2_DTBO;
>>> +					};
>>
>> This is wrong.
>>
>> ICSSG2 Ethernet should be part of the fdt-0 configuration as the 2 Ethernet ports
>> on the board are hardwired to ICSSG2. Not having them working by default
>> is an invalid configuration.
>>
> 
> ICSSG2 ethernet ports should be enabled by default. But the ICSSG2 nodes
> is added in the overlay file (k3-am654-icssg2.dtso) in kernel so they
> are added in same overlay file in u-boot as well.
> 
> I am keeping,
> fdt-0  as k3-am654-base-board dtb,
> fdt-1  as k3-am654-icssg2 dtbo,
> conf-0 as k3-am654-base-board and
> conf-1 as k3-am654-icssg2.
> 
> Do you want me to keep k3-am654-icssg2 dtbo as fdt-0 and
> k3-am654-base-board as fdt-1? I tried doing this but this results into
> u-boot getting stuck. The tispl and u-boot images are not able to load
> if I swap fdt-0 and fdt-1 , and conf-0 and conf-1.
> 
> If the current combination doesn't look OK, please let me know what
> should be the correct combinations for fdt-0, fdt-1, conf-0 and conf-1.
> 

Can you please comment on this. I'll send v2 with all the suggested
changes once you confirm the correct fdt and configurations.

<snip>

-- 
Thanks and Regards,
Danish
