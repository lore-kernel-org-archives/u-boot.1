Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE8FEB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0D388F35;
	Tue, 10 Sep 2024 12:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r8lKmghk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922E288F35; Tue, 10 Sep 2024 12:51:45 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB0888EBF
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AApcwg064120;
 Tue, 10 Sep 2024 05:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725965498;
 bh=co03eI94yRXVRxRl9fzlAC/UUcNjH4W2sZwzdvkzJcA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=r8lKmghkVeb8mwDM1jiP7fS6R+LnyjruVNrnJUVqWZWOIANU10eXrzhVPTOn5WLEi
 BTiDrYqVlzhmj3JF1NaFzWdUERE7ytLx1GxwvA3s4k82eTYBSPjg120JEHO1b0j+Ew
 iU2SsAmYIJat2R72JKJmpepPxp6bsFP7qZIh5gDc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48AApbhj016991
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 05:51:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 05:51:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 05:51:37 -0500
Received: from [172.24.19.92] (lt5cd2489kgj.dhcp.ti.com [172.24.19.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AApXxh064115;
 Tue, 10 Sep 2024 05:51:34 -0500
Message-ID: <a47a1830-9c06-4b59-8b44-2c376503bf91@ti.com>
Date: Tue, 10 Sep 2024 16:21:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 0/3] k3-j784s4-r5-evm: Enable ESMs and related PMIC
To: Andrew Halaney <ahalaney@redhat.com>, Apurva Nandan <a-nandan@ti.com>,
 "Tom Rini" <trini@konsulko.com>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, "Eric
 Chanudet" <echanude@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-boot@lists.denx.de>,
 Andrew Davis <afd@ti.com>
References: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com>
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

Hi Andrew

On 9/7/2024 2:54 AM, Andrew Halaney wrote:
> This enables the ESMs and the associated PMIC. Programming these bits is
> a requirement to make the watchdog actually reset the board.
>
> Note, this relies on the linked devicetree changes to land in Linux
> first and get synced here, otherwise the board will fail to boot!
>
> I've tested this series (with the linked change) on the k3-j784s4-evm,
> but not its sibling the k3-am69-sk. I'd appreciate at a minimum someone
> to test on that platform to ensure this doesn't break boot.


For am69-sk, I need to add esm node on top of your patches

Also, as commented in Linux patch series, boothph is enough in one child 
node

with these two changes , tested on AM69 for watchdog reset.


https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8

upto line 
https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8#file-gistfile1-txt-L28, 
Patch added for test

Line 
https://gist.github.com/uditkumarti/e5666b5623c3a78e23548fbfcbe813c8#file-gistfile1-txt-L1385 
to see watchdog reset action




>
> Link: https://lore.kernel.org/all/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com/
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Andrew Halaney (1):
>        configs: j784s4_evm_r5: Enable ESM related configs
>
> Keerthy (1):
>        board: ti: j784s4: Initialize the ESM & PMIC ESM
>
> Neha Malcom Francis (1):
>        arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node
>
>   arch/arm/dts/k3-j784s4-r5-evm.dts |  7 +++++++
>   board/ti/j784s4/evm.c             | 28 ++++++++++++++++++++++++++++
>   configs/j784s4_evm_r5_defconfig   |  7 +++++++
>   3 files changed, 42 insertions(+)
> ---
> base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> change-id: 20240906-j784s4-esm-enable-4c4f698fe7c4
>
> Best regards,
