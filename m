Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DAFC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 05:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4622187440;
	Thu, 16 Nov 2023 06:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wg/mz/8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51EB387440; Thu, 16 Nov 2023 06:08:12 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B378724E
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 06:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AG5853H022500;
 Wed, 15 Nov 2023 23:08:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700111285;
 bh=7e745DqT5x2zz9/7Jrn4m4XCTfih0YlObJQf2+X/Yr8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wg/mz/8JGmoNvXAEJhn+Z7hZ6SVD2vIdYNJ47GTMoIeSRj8DkOK7kC9xcG+eN3d/r
 3O9NYoNcqDFflYga2BNaIzMzFBpR4eeNfjaECHuO5nzP13HvAEyb01Seh2lpuPvz8M
 K4/MoGz8Fko5Vd29V+4ul85Vpp41L3Kr1SokJwvs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AG585kd019024
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Nov 2023 23:08:05 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 Nov 2023 23:08:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 Nov 2023 23:08:05 -0600
Received: from [172.24.227.36] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AG581M1019275;
 Wed, 15 Nov 2023 23:08:02 -0600
Message-ID: <202d11af-b2f2-412a-b9be-0e25174185d5@ti.com>
Date: Thu, 16 Nov 2023 10:38:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-*-binman: Move to using templated FITs
To: Andrew Davis <afd@ti.com>, <sjg@chromium.org>,
 <marcel.ziswiler@toradex.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <kamlesh@ti.com>, <m-chawdhry@ti.com>, <mkorpershoek@baylibre.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
 <20231115101024.3441093-3-n-francis@ti.com>
 <1beed541-c7bd-4ed0-943f-c3695ee1db93@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <1beed541-c7bd-4ed0-943f-c3695ee1db93@ti.com>
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

Hi Andrew,

On 15/11/23 21:22, Andrew Davis wrote:
> On 11/15/23 4:10 AM, Neha Malcom Francis wrote:
>> Reduce redundancy in code by using templates to generate the A72 boot
>> binaries (tispl.bin and u-boot.img) as well as R5 boot binary sysfw.itb
>> (for legacy boot following devices J721E and AM65x).
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm/dts/k3-am625-sk-binman.dtsi          | 157 +--------
>>   .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 155 +-------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi          | 158 +--------
>>   arch/arm/dts/k3-am64x-binman.dtsi             | 151 +-------
>>   arch/arm/dts/k3-am65x-binman.dtsi             | 273 +-------------
>>   arch/arm/dts/k3-j7200-binman.dtsi             | 159 +--------
>>   arch/arm/dts/k3-j721e-binman.dtsi             | 332 +-----------------
>>   arch/arm/dts/k3-j721s2-binman.dtsi            | 157 +--------
>>   8 files changed, 54 insertions(+), 1488 deletions(-)
> 
> 1488 deletions, nice!
> 
> Minor question, why was `ti-secure` not factored out of `dm` nodes like
> it was for `atf`/`tee` nodes? Guessing it has to do with not all SoCs
> needing this blob and signing nothing results in something, which
> messes up the 0 size check when loading it, but it wasn't clear to me.
> 

Yes that's right! It ends up being non-zero for devices that don't have DM and 
DM load fails.

> Anyway,
> 
> Acked-by: Andrew Davis <afd@ti.com>

-- 
Thanking You
Neha Malcom Francis
