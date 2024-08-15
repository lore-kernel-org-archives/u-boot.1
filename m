Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB6C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 03:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0465889F8;
	Thu, 15 Aug 2024 05:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wsavvhid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE2787C38; Thu, 15 Aug 2024 05:17:45 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C378889F8
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F3HfVc058671;
 Wed, 14 Aug 2024 22:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723691861;
 bh=3Jzkz+1xehu2A3bMiMcfvWCNugUiQEepILrh/QxS19M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wsavvhid7NLOfkSKw/eF35fpqzkyI5zP7HKzHB4WFmoxDZJyIr4+yD8wzHuVxojtw
 vkRQkllGHsORw/d+40Q1cBfQahdglAhBxCVWrHMK4AQwtgPhaoxWj+c1osQZUh85he
 Ia+Y2Ve41acXkvO99BWSk4rBOURMlsD3W6N82r7c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F3Hfpl085863
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 22:17:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:17:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 22:17:41 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47F3Ha41044931;
 Wed, 14 Aug 2024 22:17:37 -0500
Message-ID: <2c18e837-d3ce-46f6-9e26-9938d4c9aa00@ti.com>
Date: Thu, 15 Aug 2024 08:47:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm: dts: j721s2: Add VTM node in R5
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-6-5115d93cdeb2@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-6-5115d93cdeb2@ti.com>
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


On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> Add bootph-pre-ram property to VTM node and the pmic node.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> index e92b1917df4e..506ad9b7910d 100644
> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> @@ -10,3 +10,12 @@
>   #include "k3-j721s2-ddr.dtsi"
>   #include "k3-j721s2-common-proc-board-u-boot.dtsi"
>   #include "k3-j721s2-r5.dtsi"
> +
> +&tps659411 {
> +	bootph-pre-ram;
> +};

Ok for now. but do you plan to add this bootph-pre-ram in Linux DT too ?


> +
> +&wkup_vtm0 {
> +	bootph-pre-ram;
> +	vdd-supply-2 = <&bucka1234>;
> +};
>
