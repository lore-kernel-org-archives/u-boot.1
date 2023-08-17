Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A4C2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 04:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6FE86A30;
	Thu, 17 Aug 2023 06:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vS1Dk5pM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C7086A2B; Thu, 17 Aug 2023 06:16:08 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A2786927
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H4G2TR055347;
 Wed, 16 Aug 2023 23:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692245762;
 bh=OWvYL7Qlr+hTDigr1hD9QM/3suP9JVRC0AQJGncgtCU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=vS1Dk5pM50UiDdgvydW2aLkVNLrh3X4nTbXq9Xglg4Hj1JNbcA73vMWpWaFySh/Ro
 9vsAbXWK6saUZwEJPRUm2fiTSScZ1uuTOv3DHugSexMM1x8ZsiZ2QDtaIXYvGb9gD1
 XsFIpqMljlJ9l4o52ECowtKfqOFTl8eGgETKPOLs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H4G2FX103523
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 23:16:02 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 23:15:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 23:15:57 -0500
Received: from [172.24.25.97] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H4Fs1o002197;
 Wed, 16 Aug 2023 23:15:55 -0500
Message-ID: <787c1106-f4ec-383b-14cf-d055ceebf86b@ti.com>
Date: Thu, 17 Aug 2023 09:45:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] k3-j721s2: Sync from linux-next tag next-20230815
To: Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-1-f4548452760a@ti.com>
 <20230816114445.c4c7rgdp5arhmiaq@polyester>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230816114445.c4c7rgdp5arhmiaq@polyester>
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


On 8/16/2023 5:14 PM, Nishanth Menon wrote:
> On 14:53-20230816, Manorit Chawdhry wrote:
>> The following commit syncs the device tree from Linux tag
>> next-20230815 to U-boot and fixes the following to be compatible with
>> the future syncs -
> [..]
> +&mcu_timer0 {
> +		/delete-property/ power-domains;
> +		/delete-property/ assigned-clocks;
> +		/delete-property/ assigned-clock-parents;
> NAK - this should come in from R5 data.

Having clock data for R5 will not help atleast for  timer.

As timer is getting probed before the clk frame work comes up ,

> you should just have:
> &mcu_timer0 {
> 	clock-frequency = <250000000>;
> 	bootph-pre-ram;
> };
>
> Introduce the required data into the power / clock data for R5.

> A72 side should just work fine with this since DM should be up and
> running by this time.

This timer is not included in A72 ,

so i suggest to keep any append/delete property in R5 specific files only


>
> [...]
