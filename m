Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD5BC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F25D8082A;
	Tue, 22 Apr 2025 16:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Va16w0CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D81380FF7; Tue, 22 Apr 2025 16:34:59 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEED8070C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEYtpP1236351
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 09:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745332495;
 bh=j1t5ngR2ztR8NlUFcEB7AFhiGTn70j9Mrg8AJi7A/N8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Va16w0CAyOduM7i/1QApEnnuY/zv2FIn0l60Op6tLp9M8lamU6gdSot8kae5CSE4p
 rag121W48qp8eikicmwxryVoLh7FXNlEwTD2hhE7L+jYkzH9gbqBKQXXgxwQGaJl4C
 MXqCsNqGk4Z99xVcvcl6CITtHlSb4A/dOjMuPGX4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEYtWD102049
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 09:34:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 09:34:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 09:34:54 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MEYsKF016935;
 Tue, 22 Apr 2025 09:34:54 -0500
Message-ID: <061dd508-b350-4f47-badb-ab773496be9e@ti.com>
Date: Tue, 22 Apr 2025 09:34:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-binman: Add template for packing HSM
 firmware
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-3-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250422095430.363792-3-b-padhi@ti.com>
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

On 4/22/25 4:54 AM, Beleswar Padhi wrote:
> The HSM M4 core needs to be booted at R5 SPL stage so that it can be
> used for further Authentication and security services. Therefore, the
> firmware for the HSM core needs to be packed in tispl.bin fit image so
> that it can be used by R5 SPL to boot the HSM core.
> 
> Add a template for packing the HSM firmware in tispl.bin. The size of
> HSM firmware is padded upto 256 KB. The HSM binaries are unloaded at a
> temporary DDR address.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 5163161b94d..c2b8388b06e 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -297,6 +297,17 @@
>   					};
>   				};
>   
> +#ifdef CONFIG_K3_HSM_FW
> +				hsm {
> +					description = "HSM binary";
> +					type = "standalone";
> +					compression = "none";
> +					os = "hsm";
> +					load = <0x82000000>;
> +					entry = <0x82000000>;

These addresses might already be in use. Why do you need an `entry`
address here? Or a `load` address?, if one isn't given then U-Boot
should pick a safe spot for you, or even do the operation in-place.

Andrew

> +				};
> +#endif
> +
>   				dm {
>   					description = "DM binary";
>   					type = "firmware";
