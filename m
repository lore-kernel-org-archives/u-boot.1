Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C07C3DA62
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 18:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B93888763;
	Wed, 17 Jul 2024 20:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mjId3X7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6014B884CA; Wed, 17 Jul 2024 20:47:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96C788ABC
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HIlKkP125593;
 Wed, 17 Jul 2024 13:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721242040;
 bh=ZL5AsUd9sDhneexb9jNM4UCYWwFm717gcL52Dhybi5o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mjId3X7Nh2O1Ve9gIMn7xHJs3Cm4SbpBrosNSJ1DWKoKiBulDexgK7aJGP615SsCn
 epoReCl5u0A5/7fWcGnLj4/XLyRUUw81b7jXTpsImYShIxfAf7jNKKNYa4eRDRQgRs
 WGeJrUN9OaOx8lfGg/2R3Pjh3r9iUzQXd/ibSPNk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HIlKV1001799
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 13:47:20 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 13:47:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 13:47:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HIlJ61118150;
 Wed, 17 Jul 2024 13:47:19 -0500
Date: Wed, 17 Jul 2024 13:47:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V5 4/6] doc: ti: k3: Add TIFS Stub documentation
Message-ID: <20240717184719.cbfclsbvvgbgxsif@dentist>
References: <20240705164833.2386549-1-d-gole@ti.com>
 <20240705164833.2386549-5-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705164833.2386549-5-d-gole@ti.com>
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

On 22:18-20240705, Dhruva Gole wrote:
> Add documentation to briefly explain the role of TIFS Stub in relevant
> K3 SoC's.
> This also sheds light on why TIFS Stub isn't package with the DM firmware
> itself.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  doc/board/ti/k3.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 67b066a07d3a..c80060662074 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -193,6 +193,17 @@ online
>      device resources such as power, clock, interrupts, dma etc. This firmware
>      runs on a dedicated or multi-use microcontroller outside the security
>      enclave.
> +  * **TIFS Stub** - A small piece of code that helps restore the remaining
> +    context and resume the TIFS firmware when resuming from Low Power Modes
> +    like Suspend-to-RAM/ Deep Sleep. It is loaded into the ATCM (Tightly
> +    Coupled Memory 'A' of the DM R5) during DM startup. The reason it isn't
> +    merged with DM is because in HS devices we need to sign the tifs-stub with
> +    customer key. The DM cannot have a component signed using a customer key
> +    because a HS device customer owns the customer key and only customer
> +    has the access for the customer key. Since TIFS Stub signing has to happen
> +    from the customer side but DM is released by TI, we need to allow binman to
> +    sign the TIFS Stub and only then package it alongside other firmwares.
> +    This applies only to AM62x, AM62A and AM62P based devices.

This implies TI is hiding DM source - we are not. TIFS stub is prop
binary (the usual issues), but can you rephrase the description above? I
do not want to go and explicitly list out the devices this section has
either..

Futher, the way it is introduced, did you check the documentation for
other SoCs? we dont want tifs stub section to punch in for other SoCs
which dont matter.

>  
>   OR
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
