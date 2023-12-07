Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A96C10F04
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 04:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C038701F;
	Thu,  7 Dec 2023 05:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ueL/EubG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4BB86EF1; Thu,  7 Dec 2023 05:42:04 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46567869F7
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 05:42:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B74fwYi093559;
 Wed, 6 Dec 2023 22:41:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701924118;
 bh=0UzwPhuWTXOjETuTBifgJt6CMpCFTyTEIyuCNR9+uso=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ueL/EubGS98wYvl7xqmO/iLeKbu6jbYPpQKm2vC1JtQ4k5GFhQC+AUX4byoVSSsYZ
 5YhNd7EOcB8YYUD54tLRo9o/DVEVqNiSEWlDY59OMfxrxzFCr0In2Ya5EYslB8iCkO
 IromK2tq9fNcIIjUTvM3Hu9SkKO18hUPb2I/jk80=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B74fwZi033108
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 22:41:58 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 22:41:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 22:41:58 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B74f6Xx093945;
 Wed, 6 Dec 2023 22:41:55 -0600
Message-ID: <2adde27f-e84a-45fb-9c9b-f7eaa846755f@ti.com>
Date: Thu, 7 Dec 2023 10:11:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm: dts: k3-j7200-r5-common-proc-board: Set
 parent clock for clock ID 323
Content-Language: en-US
To: Reid Tonking <reidt@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <m-chawdhry@ti.com>, <bb@ti.com>,
 <a-nandan@ti.com>, <vishalm@ti.com>
References: <20231206211753.2225158-1-reidt@ti.com>
 <20231206211753.2225158-3-reidt@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231206211753.2225158-3-reidt@ti.com>
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


On 12/7/2023 2:47 AM, Reid Tonking wrote:
> Previously, dynamic frequency scaling supported rates only through fixed
> divison.
>
> This virtual clock mux configuration enables more varied rates on A72
> clock ID 202 by setting up the required register.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Reid Tonking <reidt@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index f0a73605020..018faaa13b6 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -24,7 +24,8 @@
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
>   		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
> +		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;

For this patch

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   		assigned-clock-rates = <2000000000>, <200000000>;
>   		ti,sci = <&dmsc>;
>   		ti,sci-proc-id = <32>;
