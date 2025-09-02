Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A94CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 07:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499B583253;
	Tue,  2 Sep 2025 09:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HiCHX7Vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76E783280; Tue,  2 Sep 2025 09:38:58 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A768304F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5827ct362535426;
 Tue, 2 Sep 2025 02:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756798735;
 bh=ND7IcKOFKN17WaZPskDS+FPs12Gyh8hvrBO+QZdbN+E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HiCHX7VpjzLKk8/SpMy3Imsf1pDqVfKdjo7yld4+0dtjhFVFISW5FLYYjVif6st/j
 jdL0snVhbxV7VH7odvzNBIE7gRYBQgsmLBZtXdzmxQtsSz8d2ohaS8wb/mYUAVKoKY
 GnRzF51RQ8d5p263ZPAbBQYhi0oUctJTznROExjI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5827ctoK2112701
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 02:38:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 02:38:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 02:38:55 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5827cqZs3711088;
 Tue, 2 Sep 2025 02:38:53 -0500
Message-ID: <b655df4e-e34b-4689-823b-bb555ed2d420@ti.com>
Date: Tue, 2 Sep 2025 13:08:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: dts: k3-j721e-r5-common-proc-board: Enable
 HBMC in R5 SPL stage
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>
References: <20250902064839.1296877-1-a-dutta@ti.com>
 <20250902064839.1296877-4-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250902064839.1296877-4-a-dutta@ti.com>
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


On 9/2/2025 12:18 PM, Anurag Dutta wrote:
> Enable HBMC in the R5 SPL stage
>
> Fixes: c9df79ee64d0 ("arm: dts: k3-j721e-r5-common: Add HBMC overrides for R5 SPL")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>   arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
>   1 file changed, 1 insertion(+)


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> index c775432505b..e4f799dfb27 100644
> --- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
> @@ -52,6 +52,7 @@
>   };
>   
>   &hbmc {
> +	status = "okay";
>   	reg = <0x0 0x47040000 0x0 0x100>,
>   		<0x0 0x50000000 0x0 0x8000000>;
>   	ranges = <0x0 0x0 0x0 0x50000000 0x4000000>,
