Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80BDC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 10:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4444D8847C;
	Thu,  9 May 2024 12:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B4fUM+0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE2C88482; Thu,  9 May 2024 12:17:20 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD0788474
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 12:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449AHEDr071724;
 Thu, 9 May 2024 05:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715249834;
 bh=IZwtyFH9xNXsxc/cS683AYpLLIlGTp4RoBdcToFdxAQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=B4fUM+0sbheU2UsetvKrYhFBkihhehmD/A3sh3tO8V4SrcPvZ5o2Z3ithNSxDVMk9
 7md+M9SPjKeHqD7cB5g8L9UY0NtpAsFU0bN0AHQX0eMd3OXTLcVLOh4eIcTtvR5HNA
 T7QwTgibgAlmvfEcaVw1al9PDXOwozGxSNSmIcS4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449AHES1030319
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 05:17:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 05:17:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 05:17:13 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449AHALT124345;
 Thu, 9 May 2024 05:17:11 -0500
Message-ID: <dc4de6d3-eeca-455d-b0b1-2b7833afa089@ti.com>
Date: Thu, 9 May 2024 15:47:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5
 file
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Sumit Garg <sumit.garg@linaro.org>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
 <20240509-b4-upstream-j721s2-of-upstream-v2-3-149563cd4901@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-3-149563cd4901@ti.com>
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

Hi Manorit

On 09/05/24 15:23, Manorit Chawdhry wrote:
> Currently AM68 SK boots with J721s2 R5 DTS and then later changes to
> AM68 SK DT during runtime.
> 
> To split the support of J721s2 and AM68, sync AM68 R5 DT with J721s2 R5
> DT as that contains some essential node changes for booting up AM68
> using AM68 R5 DT.
> 
> secure_proxy_mcu and secure_proxy_sa3 node changes are required for
> establishing contact with TIFS running on M4 core, and the addition of
> new power domain helps in holding A72 in reset for configuration of
> firewalls.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
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

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
