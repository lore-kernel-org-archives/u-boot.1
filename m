Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E5EC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359F98885B;
	Wed, 22 May 2024 18:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WDCtdKNw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE0988870; Wed, 22 May 2024 18:08:19 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3768287F19
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MG8BNg051468;
 Wed, 22 May 2024 11:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716394091;
 bh=PiPpFy6gorQoP2NELSIekxxGnhIH0WYOxM4Aou97b0E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=WDCtdKNwizXZJPn/X7Zp3rtpDsllGCxdD+ZLNjfBxr8jWtn+5vO5Szu22UbIHx9sq
 YU5t2QHm/gCk/peSKUJ+59unnLkIfKuuDcjs/R3fRk7wZS7XM0g/NB1DxINYOJfFSo
 mHHizPGHM0AvrS4OSYA9lDieTyfgUozyFZruDHqw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MG8A46111683
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 11:08:10 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 11:08:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 11:08:10 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MG8Ah3005835;
 Wed, 22 May 2024 11:08:10 -0500
Message-ID: <cb53651f-a823-41b8-81e5-c3939bd33764@ti.com>
Date: Wed, 22 May 2024 11:08:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: k3-am642-evm-u-boot: Add remoteproc-name
 for PRU cores
To: MD Danish Anwar <danishanwar@ti.com>, Judith Mendez <jm@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, Neha Malcom
 Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20240522063652.3759497-1-danishanwar@ti.com>
 <20240522063652.3759497-2-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240522063652.3759497-2-danishanwar@ti.com>
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

On 5/22/24 1:36 AM, MD Danish Anwar wrote:
> Add remoteproc-name property for PRU cores.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   arch/arm/dts/k3-am642-evm-u-boot.dtsi | 44 +++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> index 705b3baa81..25ddace74e 100644
> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
> @@ -11,6 +11,50 @@
>   	};
>   };
>   
> +&pru0_0 {
> +	remoteproc-name = "pru0_0";

Why do we need all these? Looks like we fallback to using `dev->name` if
these are not set, does that not work for us here?

Andrew

> +};
> +
> +&rtu0_0 {
> +	remoteproc-name = "rtu0_0";
> +};
> +
> +&tx_pru0_0 {
> +	remoteproc-name = "tx_pru0_0";
> +};
> +
> +&pru0_1 {
> +	remoteproc-name = "pru0_1";
> +};
> +
> +&rtu0_1 {
> +	remoteproc-name = "rtu0_1";
> +};
> +
> +&tx_pru0_1 {
> +	remoteproc-name = "tx_pru0_1";
> +};
> +
> +&pru1_0 {
> +	remoteproc-name = "pru1_0";
> +};
> +
> +&rtu1_0 {
> +	remoteproc-name = "rtu1_0";
> +};
> +
> +&tx_pru1_0 {
> +	remoteproc-name = "tx_pru1_0";
> +};
> +
> +&pru1_1 {
> +	remoteproc-name = "pru1_1";
> +};
> +
> +&rtu1_1 {
> +	remoteproc-name = "rtu1_1";
> +};
> +
>   &main_timer0 {
>   	clock-frequency = <200000000>;
>   };
