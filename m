Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBDFC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A7EC8334C;
	Tue, 22 Jul 2025 10:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sIuiHxrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3456B83371; Tue, 22 Jul 2025 10:53:39 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EB283346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56M8rY3U1458780;
 Tue, 22 Jul 2025 03:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753174414;
 bh=/Gx0xc6gAY6CjOoHTZfUnRuxgvaVIEpUgqtGIhsYgKo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sIuiHxrfrVnEOLQBzGpSs8e7mggwEMvbPCxY11FvXGcn1t5y85S61RGnfA+9mIETE
 mNZieqR4n6HonvJkmBreCYXH4fqiRUy9oKTiEeHGsr4K6WnLBp4cD0J3LPC945qSAr
 mbEpmk02Rzso+Dc9QUznlkWOYYKVC3QJQEh6hEeI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56M8rXH11507030
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 22 Jul 2025 03:53:33 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 22
 Jul 2025 03:53:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 22 Jul 2025 03:53:33 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56M8rVYw768689;
 Tue, 22 Jul 2025 03:53:32 -0500
Message-ID: <5510f947-bdbf-481c-8339-34b010b6a683@ti.com>
Date: Tue, 22 Jul 2025 14:23:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Let fit-dtb.blob generated all the time
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>,
 <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <c2952da3c064d67821cd166d2392db39c1d23b2c.1752822270.git.michal.simek@amd.com>
From: Neha Malcom Francis <n-francis@ti.com>
Content-Language: en-US
In-Reply-To: <c2952da3c064d67821cd166d2392db39c1d23b2c.1752822270.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Michal

On 18/07/25 12:34, Michal Simek wrote:
> There is a value to generate fit-dtb.blob even for cases without SPL
> because flows with FSBL also require it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm/dts/zynqmp-binman-som.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
> index a70123feeadd..469b94bbde60 100644
> --- a/arch/arm/dts/zynqmp-binman-som.dts
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -20,7 +20,6 @@
>  	binman: binman {
>  		multiple-images;
>  
> -#ifdef CONFIG_SPL
>  		fit-dtb.blob {
>  			filename = "fit-dtb.blob";
>  			pad-byte = <0>;
> @@ -109,6 +108,7 @@
>  			};
>  		};
>  
> +#ifdef CONFIG_SPL
>  		/* Generation in a static way */
>  		itb {
>  			filename = U_BOOT_ITB_FILENAME;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
