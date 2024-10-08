Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF9CED26E
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 06:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF74688C7E;
	Tue,  8 Oct 2024 08:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RnRLh9nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F0B88DA3; Tue,  8 Oct 2024 08:14:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6157C88B6C
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 08:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4986EToe040771;
 Tue, 8 Oct 2024 01:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728368069;
 bh=GQ/XsRbkoX8O9c/naIxJisYfbGfe2nXnzOyuFttBmMk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RnRLh9nmCZ9/zJtuSGq4bQ9Y5mSnQ6rkmO34ZaKc9u9/+LP2sxXJrQszQzB9Gz6N0
 P5Otleqj3VP5Z2oL661Vf9pCb3zPGrE6BethiIRlzN2JrIbotJfp0gFV7XDeL6ffnw
 TEdhs8TwW9SeOzim5wcMy/f5D7tF0uT2uEgzon+o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4986ETId020736;
 Tue, 8 Oct 2024 01:14:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 01:14:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 01:14:29 -0500
Received: from [172.24.31.55] (lt5cd112gt3k.dhcp.ti.com [172.24.31.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4986EQa7001566;
 Tue, 8 Oct 2024 01:14:27 -0500
Message-ID: <8578ab95-add4-4adb-97ff-57f8b5e4b842@ti.com>
Date: Tue, 8 Oct 2024 11:44:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: dts: k3-j7200-r5-evm: Enable AVS feature
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>, <reidt@ti.com>,
 <j-humphreys@ti.com>
References: <20240911083722.1285509-1-u-kumar1@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20240911083722.1285509-1-u-kumar1@ti.com>
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



On 9/11/2024 2:07 PM, Udit Kumar wrote:
> During DT sync with kernel 6.6, AVS feature was removed by mistake.
> So adding back AVS feature.
> 
> Fixes: df73e791ce09("arm: dts: j7200: dts sync with Linux 6.6-rc1")
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> ---
> Test logs with this patch
> Added print in avs driver to see, voltage being set.
> 
> U-Boot SPL 2024.10-rc4-00436-ga252ef4f0842-dirty (Sep 11 2024 - 13:57:26 +0530)
> SYSFW ABI: 4.0 (firmware rev 0x000a '10.0.8--v10.00.08 (Fiery Fox)')
> avs init
> volt 800000
> Trying to boot from MMC2
> 
> 
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index 94760c78dd..fac108ce14 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -102,3 +102,8 @@
>   &mcu_udmap {
>       ti,sci = <&dm_tifs>;
>   };
> +
> +&wkup_vtm0 {
> +	vdd-supply-2 = <&buckb1>;
> +	bootph-pre-ram;
> +};

