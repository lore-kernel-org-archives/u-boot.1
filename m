Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF0CCDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 11:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD4986D6E;
	Fri, 13 Oct 2023 13:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CZ7b36cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B3286E4F; Fri, 13 Oct 2023 13:05:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C018F86D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 13:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DB5DeF103764;
 Fri, 13 Oct 2023 06:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697195113;
 bh=zbJjsoP5fwmYFCX2DRVov0E/ASEGd5odk8+v/92DzHw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CZ7b36cmlEFcsStFbrw41diU2WHdRJjHu3kycVoxQA+sTy6F6GtF1o398U+m1C8P7
 KmBeAeD/KEUdHnS0GVZe/bDkDIcdWmFJk+92clp7V7orTBEEK1/k5luwWO6v9aBzvP
 5tII4oVU8uxuNK3H6pp3diH1vLD/I0uJzrx7+r10=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DB5Db2121039
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Oct 2023 06:05:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 06:05:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 06:05:12 -0500
Received: from [172.24.20.156] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DB5APF020942;
 Fri, 13 Oct 2023 06:05:10 -0500
Message-ID: <454562f1-d120-9719-62c3-7ef64861307c@ti.com>
Date: Fri, 13 Oct 2023 16:35:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arm: dts: k3-j721e-mcu-wakeup: Add MCU domain ESM instance
Content-Language: en-US
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
References: <20231013102941.548209-1-n-francis@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231013102941.548209-1-n-francis@ti.com>
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


On 10/13/2023 3:59 PM, Neha Malcom Francis wrote:
> Currently J721E defines only the main_esm in DTS. Add node for mcu_esm
> as well.
>
> According to J721E TRM (12.11.2.2 ESM Environment) [1], we see that the
> interrupt line from ESMi (main_esm) is routed to MCU_ESM (mcu_esm). This
> is MCU_ESM0_LVL_IN_95 with interrupt ID 95. Configure mcu_esm
> accordingly so that errors from main_esm are routed to mcu_esm and
> handled.
>
> [1] https://www.ti.com/lit/zip/spruil1
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Upstream kernel effort:
> https://lore.kernel.org/lkml/20230926142810.602384-1-n-francis@ti.com/


should part of next u-boot, kernel sync, no?


>
>   arch/arm/dts/k3-j721e-mcu-wakeup.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
> index 05d6ef127b..fa8af20c78 100644
> --- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
> @@ -671,4 +671,11 @@
>   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
>   	};
> +
> +	mcu_esm: esm@40800000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x40800000 0x00 0x1000>;
> +		ti,esm-pins = <95>;
> +		bootph-pre-ram;
> +	};
>   };
