Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11A2C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 10:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49AF58869A;
	Wed,  8 May 2024 12:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p0s2yFZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D1388662; Wed,  8 May 2024 12:40:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739EE886D1
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 12:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 448AdtwH031992;
 Wed, 8 May 2024 05:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715164795;
 bh=aijr0CfpetUxOi3MWC4/3KJneEF5PP+ZiR0cIpqd6f0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=p0s2yFZ1Tclptfu8g752IBMhjFmcafze9rjGJd48jJWULh1MO+PujF6iMXDTHLG6U
 L0+ZykYDoKye/RETUZyDqO8Yn06d7IGB1GnEt9q08Oe/WsUeYO4VGA0Uyh06FV7Z1c
 C51tuf0hC7RkaEeO2Vf4eEhtOA9j8z7Jql7JlLmY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 448AdtGf075008
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 May 2024 05:39:55 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 05:39:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 05:39:55 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 448AdqcI029756;
 Wed, 8 May 2024 05:39:52 -0500
Message-ID: <82dd9ec5-99c0-4e09-8ce9-e35c6dd98c36@ti.com>
Date: Wed, 8 May 2024 16:09:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5
 file
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
 <20240508-b4-upstream-j721s2-of-upstream-v1-4-ed0933172410@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240508-b4-upstream-j721s2-of-upstream-v1-4-ed0933172410@ti.com>
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

Hi Manorit,

On 08/05/24 12:56, Manorit Chawdhry wrote:
> Update the file with the required nodes from J721s2 R5 file to start
> using k3-am68-sk-r5 file for AM68.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---

What's the motivation behind this patch vs. squashing it into patch 5/6?

>   arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> index 695aadc287bd..038b08dc3e01 100644
> --- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
> @@ -24,7 +24,8 @@
>   		compatible = "ti,am654-rproc";
>   		reg = <0x0 0x00a90000 0x0 0x10>;
>   		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
>   		clocks = <&k3_clks 61 1>;
>   		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
> @@ -54,10 +55,12 @@
>   
>   &secure_proxy_mcu {
>   	bootph-pre-ram;
> +	status = "okay";
>   };
>   
>   &secure_proxy_sa3 {
>   	bootph-pre-ram;
> +	status = "okay";
>   };
>   
>   &cbass_mcu_wakeup {
> 

-- 
Thanking You
Neha Malcom Francis
