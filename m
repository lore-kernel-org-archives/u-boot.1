Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F65FD21275
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 10:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9069A88EDE;
	Thu, 17 Oct 2024 12:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Rzrn/xR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD7588EDE; Thu, 17 Oct 2024 12:30:21 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC4388F57
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 12:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49HAUBvF105023;
 Thu, 17 Oct 2024 05:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729161011;
 bh=0wCevi1RzZUJWs4PRP6fDhd04HelkpKQlD1ZQkpy9Kw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Rzrn/xR2AioNcpP6BVWenv0PsO+5fYSqckOgJ1t0N+gQu2cbev1YSqxPIT105lCcF
 LQ0jF4A+yAI3cNnwVOfgZ+uFxhWLK5j9nbXrmptxPw3BOCtQq/g7Ne0uf9zimcS55Y
 nIedkcH7QbF6OJ9eiMhbGx/lTOTBs8BFDYiw6qv8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49HAUBdY098869
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Oct 2024 05:30:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 05:30:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 05:30:10 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49HAU850097591;
 Thu, 17 Oct 2024 05:30:08 -0500
Message-ID: <9a5dc591-a5ca-4d53-9465-242986f4a62e@ti.com>
Date: Thu, 17 Oct 2024 16:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
 <20241017062911.2241167-2-a-limaye@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241017062911.2241167-2-a-limaye@ti.com>
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

Hi Aniket

On 17/10/24 11:59, Aniket Limaye wrote:
> From: Reid Tonking <reidt@ti.com>
> 
> Define the MSMC clk in the a72 node

The usage of MSMC and A72SS interchangeably in this series is confusing. Could 
you expand on it in the cover letter why in J7200 this clock is defined as part 
of the A72 node as opposed to devices that have MSMC as a separate module 
altogether with its own clock (like J721S2 and J784S4)?
> 
> Signed-off-by: Reid Tonking <reidt@ti.com>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index f096b102793..759a1e83456 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -23,11 +23,11 @@
>   				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
> -		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
> -		assigned-clock-rates = <2000000000>, <200000000>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 202 2> ;
> +		clock-names = "gtc", "msmc", "core";
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 323 0>;
> +		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
> +		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
>   		ti,sci = <&dmsc>;
>   		ti,sci-proc-id = <32>;
>   		ti,sci-host-id = <10>;

-- 
Thanking You
Neha Malcom Francis
