Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E366EC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 15:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D31E829C7;
	Mon, 28 Apr 2025 17:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tqjhFImZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A17E82A33; Mon, 28 Apr 2025 17:14:37 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594D58293C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 17:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53SFEV2r3426898
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 10:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745853271;
 bh=izPqII9Qyp7brvp0is598ozXZrq+l8RkZaf4i7TMsrs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tqjhFImZeTDJdSAcjXBFmFPLGTCHUgfc4CFM0h/BR69bB7vs85bt+aw65n+sMQoPx
 Y9rkg1Dlcy5aNUg1kabdzz5wDoYJaVk7+pdO9hfCEMOpNheqjBMDJrAJIfstxu/bYJ
 8rSCScaT7xHdes7upjrQAlYJe1xb9Wx/tRdNfniI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53SFEVlR051316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Apr 2025 10:14:31 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 10:14:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 10:14:31 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53SFEUtK031047;
 Mon, 28 Apr 2025 10:14:31 -0500
Message-ID: <c9bff9b1-ac26-4467-abf4-5bfc2d7b2783@ti.com>
Date: Mon, 28 Apr 2025 10:14:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3: binman: Fix DM firmware selection
To: Bryan Brattlof <bb@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20250425225403.861034-1-afd@ti.com>
 <20250428133626.iebmz3j3tgakrvkd@bryanbrattlof.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250428133626.iebmz3j3tgakrvkd@bryanbrattlof.com>
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

On 4/28/25 8:36 AM, Bryan Brattlof wrote:
> On April 25, 2025 thus sayeth Andrew Davis:
>> Just like TF-A and OP-TEE, the documentation states a custom path for DM
>> can be provided at build time by setting TI_DM. This should then set
>> ti-dm-path which updates ti-dm node filenames in binman.
>>
>> Two issues prevent this from functioning for most K3 boards. One is when
>> then DM firmware name is inside a blob-ext node instead of a ti-dm node.
>>
>> The second is when the filename in the ti-dm node is a pointer to a
>> blob-ext node. In this case even though the filename is updated, the
>> filename in the blob-ext is not, so build can fail if the default
>> file in the blob-ext cannot be found, even if the updated ti-dm file
>> does exist.
>>
>> Fix both of these for all K3 by removing any indirect ti-dm nodes and
>> making sure all DM nodes are labeled with "ti-dm".
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
> 
> For the few sitars boards this works :)
> 
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
>> ---
>>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 11 ++-----
>>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 15 +++-------
>>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 14 +++------
>>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 11 ++-----
>>   arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 14 +++------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 14 +++------
>>   arch/arm/dts/k3-am62p-sk-binman.dtsi          | 11 ++-----
>>   arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi  | 12 ++------
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           | 29 +++++++++++++------
>>   arch/arm/dts/k3-j7200-binman.dtsi             | 13 +++------
>>   .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   | 11 ++-----
>>   arch/arm/dts/k3-j721e-binman.dtsi             | 13 +++------
>>   arch/arm/dts/k3-j721s2-binman.dtsi            | 13 +++------
>>   arch/arm/dts/k3-j722s-binman.dtsi             | 12 ++------
>>   arch/arm/dts/k3-j742s2-evm-u-boot.dtsi        | 29 +++++++++++++------
>>   arch/arm/dts/k3-j784s4-binman.dtsi            |  8 ++---
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        | 29 +++++++++++++------
>>   17 files changed, 104 insertions(+), 155 deletions(-)
>>
> 
> ...
> 
>>   
>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
>> index 534eb14795b..cc619f5920e 100644
>> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
>> @@ -156,14 +156,6 @@
>>   #define AM625_SK_DTB "u-boot.dtb"
>>   
>>   &binman {
>> -	ti-dm {
>> -		filename = "ti-dm.bin";
>> -		blob-ext {
>> -			filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>> -			optional;
>> -		};
>> -	};
>> -
>>   	tifsstub-hs {
>>   		filename = "tifsstub.bin_hs";
>>   		ti-secure-rom {
>> @@ -270,7 +262,8 @@
>>   						keyfile = "custMpk.pem";
>>   					};
>>   					dm: ti-dm {
>> -						filename = "ti-dm.bin";
>> +						filename = "ti-dm/am62xx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
>> +						optional;
>>   					};
> 
> So I was curious of this optional flag. Is the issue here that we only
> check for mandatory binaries via BINMAN_INDIRS and not through all the
> custom arguments like TI_DM?
> 

I would like to remove all these optional flags for DM here at some point.
DM is not optional for these platforms, without it you will not have a
functional U-Boot.

Looking at the history on the list, seems these were added to make automatic
testing with buildman happy. Marking these optional made the build pass for
test builds without needing to download our firmware repo. BINMAN_ALLOW_MISSING=1
is the solution but it was broken at one point. It seems to be working now
and these optional flags can go away.

I didn't do it as part of this series to keep things simple and as they were
before, but feel free to start removing them. Some platforms already have
this non-optional (AM62x Verdin, BeaglePlay).

Andrew
