Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E0CC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 05:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2F287440;
	Thu, 16 Nov 2023 06:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zFYk7f+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFE58746E; Thu, 16 Nov 2023 06:08:50 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0298724E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 06:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AG58j76071846;
 Wed, 15 Nov 2023 23:08:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700111325;
 bh=U6dP5Df2zwbjGNJiiYMfQ/b28vIIbv9TYOMD2IY95Vs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zFYk7f+O0oh4AucYM4pFIpmrp7u4LWwmsCSNCVvrBoAPSvqliQT3ogG3RqpBqKzrH
 jhfu0Cke7t82W/GR0tz9XAPBDE4BdQEE9y9IE4gFCtS43SEA6aR7TW30dp0zbmwZVa
 OZrF9zjRHLxVM8J7HDe8zuPXfVXqiJ5BtS9sGuvM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AG58jI1096911
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 23:08:45 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 23:08:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 23:08:45 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AG581M2019275;
 Wed, 15 Nov 2023 23:08:42 -0600
Message-ID: <4454dcb0-f97a-4f10-9a87-d043b48d9f31@ti.com>
Date: Thu, 16 Nov 2023 10:38:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanup K3 binman FIT images
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "sjg@chromium.org"
 <sjg@chromium.org>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "afd@ti.com" <afd@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "nm@ti.com"
 <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <8aee10aca8ef6f5acb5687a114d25453fd27b3d0.camel@toradex.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <8aee10aca8ef6f5acb5687a114d25453fd27b3d0.camel@toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Marcel,

On 15/11/23 23:03, Marcel Ziswiler wrote:
> Hi Neha
> 
> On Wed, 2023-11-15 at 15:40 +0530, Neha Malcom Francis wrote:
>> Instead of duplicating the same FIT formats over and over again for
>> different K3 devices, make use of the templating support to have FIT
>> templates for the same.
>>
>> Note: I purposely did not add the trial to template out the non-FIT
>> bootloader image (tiboot3.bin) as it reduces the readibility and
>> understandability of how the image is packaged because of the various
>> different boot flows.
>>
>> Boot logs:
>> https://gist.github.com/nehamalcom/9abe7955ebb4a251923e76412834c886
> 
> For the whole series:
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 

Thanks for testing!

>> Neha Malcom Francis (2):
>>    arm: dts: k3-binman: Add support for FIT templates
>>    arm: dts: k3-*-binman: Move to using templated FITs
>>
>>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
>>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
>>   arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
>>   arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
>>   arch/arm/dts/k3-binman.dtsi                   | 327 +++++++++++++++++
>>   arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
>>   arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
>>   arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
>>   9 files changed, 381 insertions(+), 1488 deletions(-)
> 
> Thanks!
> 
> Cheers
> 
> Marcel

-- 
Thanking You
Neha Malcom Francis
