Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B851E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 15:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3C98012C;
	Tue, 10 Dec 2024 16:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ls3lAHM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22D980133; Tue, 10 Dec 2024 16:38:40 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3348010F
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAFcaLx2485019
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 09:38:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733845116;
 bh=PPcxGd6cTtDb+lI3cPHQsWODN8K3hSbpxOh1oEg2ZCk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Ls3lAHM0e9r0xLC3e8EZkmADacsYNt+dRJ+6B+HZknSyf+3dAR49EH6+Vof63AoUH
 u3oXKTDl6gDGVYTe/GAeORi+QEmRErh0lJoyGIcOrGplu+shdt9QqNCNP5z/DQ14ZK
 n83YufNrLi3U5dHL0c4hA3pjCiIEIa3XmMnsFaHM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BAFcacR027140
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Dec 2024 09:38:36 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 09:38:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 09:38:35 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BAFcVH3111858;
 Tue, 10 Dec 2024 09:38:32 -0600
Message-ID: <ab7e3013-8d77-479a-a829-12d7e5cdab76@ti.com>
Date: Tue, 10 Dec 2024 21:08:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: dts: k3-j722s*: Add overrides specific to OSPI
To: Prasanth Babu Mantena <p-mantena@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>
References: <20241210135731.1043269-1-p-mantena@ti.com>
 <20241210135731.1043269-5-p-mantena@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241210135731.1043269-5-p-mantena@ti.com>
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
> OSPI Booot requires overrides specific to R5 and also

Booot to Boot please


> to use DMA in R5 SPL stage the DM_TIFS needs to be enabled.

Sorry but, you are not enabling DM_TIFS, rather using it,

Please update commit message accordingly


> Add the corresponding overrides for R5 SPL stage.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-j722s-evm-u-boot.dtsi |  4 ++++
>   arch/arm/dts/k3-j722s-r5-evm.dts      | 13 +++++++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
> index 88c4a72db61..6ae76beea3e 100644
> --- a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
> @@ -16,3 +16,7 @@
>   &dmsc {
>   	bootph-pre-ram;
>   };
> +
> +&main_bcdma {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index 1bec997c93c..d797e954f97 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -81,3 +81,16 @@
>   &wkup_uart0 {
>   	status = "okay";
>   };
> +
> +&ospi0 {
> +	reg = <0x00 0x0fc40000 0x00 0x100>,
> +	      <0x00 0x60000000 0x00 0x08000000>;
> +};
> +
> +&main_bcdma {
> +	ti,sci = <&dm_tifs>;
> +};
> +
> +&main_pktdma {
> +	ti,sci = <&dm_tifs>;
> +};
