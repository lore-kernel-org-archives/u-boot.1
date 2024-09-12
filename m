Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02075EE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7544E88EEF;
	Thu, 12 Sep 2024 09:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YWCls1j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769D188EFE; Thu, 12 Sep 2024 09:59:02 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7A288EEC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48C7wlIZ020536;
 Thu, 12 Sep 2024 02:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726127927;
 bh=gELGYlEYHdyLs2JRrsdAIGABFdIKnK2e6x7nmVc1FVU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YWCls1j5kBlDCyIlHBVfEJbVTNDVHRQmTQypiHAt1Cz6ilw1CM6DhO+Dbk4k83Wk2
 aOFpgxfJxs1O/1HWaD7mfXZ4oW4FG3NdZC8VwJnF2vuLuAkZAnn/qxB5czCAjCtTSI
 rzZPANwXzG/Vjcq9wI8OXvXetLT/25kyBVTOhxJM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48C7wlrs012414
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Sep 2024 02:58:47 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Sep 2024 02:58:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Sep 2024 02:58:46 -0500
Received: from [172.24.19.92] (lt5cd2489kgj.dhcp.ti.com [172.24.19.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48C7wfLh129670;
 Thu, 12 Sep 2024 02:58:42 -0500
Message-ID: <3bf2177d-178f-46bf-abfe-6f00a52c623b@ti.com>
Date: Thu, 12 Sep 2024 13:28:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT v2 0/4] k3-j784s4-r5-evm: Enable ESMs and related
 PMIC
To: Andrew Halaney <ahalaney@redhat.com>, Tom Rini <trini@konsulko.com>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Eric
 Chanudet <echanude@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240911-j784s4-esm-enable-v2-0-957f56b588d9@redhat.com>
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

Andrew Thanks,

On 9/11/2024 11:09 PM, Andrew Halaney wrote:
> NOTE: this relies on the linked devicetree changes to land in Linux
> first and get synced here, otherwise the board will fail to boot!
> I'm leaving this as a RFC/RFT at this time for that reason until
> things get merged and synced over (if there's a faster way to get that
> done please let me know, otherwise I'll be patient. Maybe the
> cherry-picking described over at
> https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> would be appropriate to do *in* this series after that is merged in
> Linux?).
>
> This enables the ESMs and the associated PMIC. Programming these bits is
> a requirement to make the watchdog actually reset the board.
>
> I've tested this series (with the linked change) on the k3-j784s4-evm,
> but not its sibling the k3-am69-sk. I'd appreciate at a minimum someone
> to test on that platform to ensure this doesn't break boot.
>
> Link: https://lore.kernel.org/lkml/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com/
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v2:
> - Loop over ESMs, only configure if prior was successful
>    as without all of them they're not useful (Udit)
> - Add am69-sk PMIC ESM node (Udit)
> - Link to v1: https://lore.kernel.org/r/20240906-j784s4-esm-enable-v1-0-b83b17d5a744@redhat.com

LGTM

For AM69, please use

Tested-by: Udit Kumar <u-kumar1@ti.com>


Test logs (WDT working as expected)  after locally applying patch

https://lore.kernel.org/lkml/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com/ 
into u-boot DTS.

https://gist.github.com/uditkumarti/3ec9afac94c081d09515b66b7ae6c0e5


> ---
> Andrew Halaney (2):
>        arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
>        configs: j784s4_evm_r5: Enable ESM related configs
>
> Keerthy (1):
>        board: ti: j784s4: Initialize the ESM & PMIC ESM
>
> Neha Malcom Francis (1):
>        arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node
>
>   arch/arm/dts/k3-am69-r5-sk.dts    |  7 +++++++
>   arch/arm/dts/k3-j784s4-r5-evm.dts |  7 +++++++
>   board/ti/j784s4/evm.c             | 24 ++++++++++++++++++++++++
>   configs/j784s4_evm_r5_defconfig   |  7 +++++++
>   4 files changed, 45 insertions(+)
> ---
> base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
> change-id: 20240906-j784s4-esm-enable-4c4f698fe7c4
>
> Best regards,
