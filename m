Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323D9E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9038C800D0;
	Tue, 10 Dec 2024 16:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tbVCJmai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94429800D3; Tue, 10 Dec 2024 16:32:43 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F318800CF
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFWcak086486;
 Tue, 10 Dec 2024 09:32:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733844758;
 bh=rd0u7OcGtXjsvKyHq9Ge0Te1Hm3Kf2e5txaurANzZLQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tbVCJmaiurl033/Pdl7zbvQNY1JtWRwg62cDWt1xwhc2i2efGrWM69huo2TD2OTfF
 yrGiEsjGClwEu15mC44qvJaMvU0C55xy7MnnMUb8Lw0BwAtesr7XG5wPiJZ42R67JM
 EQ4EqR2VOb5CqzF3Kl3gQtFD62NKJbY/4+vF+HDw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFWcTT113055;
 Tue, 10 Dec 2024 09:32:38 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 09:32:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 09:32:38 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFWYxN045203;
 Tue, 10 Dec 2024 09:32:35 -0600
Message-ID: <6167a719-b0d3-4290-b869-d96fef717d8c@ti.com>
Date: Tue, 10 Dec 2024 21:02:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy
 thread ID
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20241210135731.1043269-1-p-mantena@ti.com>
 <20241210135731.1043269-3-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241210135731.1043269-3-p-mantena@ti.com>
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


On 12/10/2024 7:27 PM, Prasanth Babu Mantena wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> Fix the DM2TIFS secureproxy thread ID as per the latest TISCI
> documentation for J722S.

Please use Fixes tag


> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-j722s-r5-evm.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index 5e5c2e3111e..1bec997c93c 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -41,8 +41,8 @@
>   		ti,host-id = <36>;
>   		ti,secure-host;
>   		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> +		mboxes= <&secure_proxy_main 28>,
> +			<&secure_proxy_main 29>;

With Fix tag added,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   		bootph-all;
>   	};
>   };
