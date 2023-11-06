Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F8C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75114870BD;
	Mon,  6 Nov 2023 18:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fz+J/Gmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6935F86F9A; Mon,  6 Nov 2023 18:11:30 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF698718F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6HBEac061813;
 Mon, 6 Nov 2023 11:11:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699290674;
 bh=3ykaaJLqcuk/FtSF19bgdLPoT1OOlFZxMhohQP/8Vgk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fz+J/GmhCJhs8n/nz3qqSvnBaOBeY253hNjNJMrmV1lBjG9p5Ed2zxgrPv3So0dlL
 qy8lkM+3BRu6WFbF7G5sg6i8e1phJ1vV5uw8Y47GRBpXbXnZPrQqBGLy9JK8M5+GWv
 CsuvQ0LKpinXA6qgg6AThAGw7LaqE6nNdapozJe8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6HBEpQ107148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 11:11:14 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 11:11:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 11:11:14 -0600
Received: from [10.250.34.172] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6HBDA4088636;
 Mon, 6 Nov 2023 11:11:13 -0600
Message-ID: <0abbcaaf-412d-4d73-9d6f-834e472e1867@ti.com>
Date: Mon, 6 Nov 2023 11:11:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm: mach-k3: Move TI dummy keys out of board
 folder
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vignesh Raghavendra
 <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, <u-boot@lists.denx.de>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-3-nm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231104024511.3597476-3-nm@ti.com>
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

On 11/3/23 9:45 PM, Nishanth Menon wrote:
> This file is used to emulate customer keys on TI development board
> ecosystems, move it out of board/ directory and into mach-k3. And
> change the relative paths to absolute paths in the binman paths.
> 
> While at it, drop the reference in verdin-binman file which is
> redundant.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Moving custMpk.pem looks good. But I don't know how .crt and .key
are actually used right now, I'd guess they already get pulled in
during FIT signing using relative paths so this might be okay.

Good to get an ACK from +Manorit to be sure though.

Andrew

> New patch in series.
> 
>   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ----
>   arch/arm/dts/k3-binman.dtsi                       | 2 +-
>   {board/ti => arch/arm/mach-k3}/keys/custMpk.crt   | 0
>   {board/ti => arch/arm/mach-k3}/keys/custMpk.key   | 0
>   {board/ti => arch/arm/mach-k3}/keys/custMpk.pem   | 0
>   5 files changed, 1 insertion(+), 5 deletions(-)
>   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.crt (100%)
>   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.key (100%)
>   rename {board/ti => arch/arm/mach-k3}/keys/custMpk.pem (100%)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index ea22bfb9bad6..58fde95adf67 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -5,10 +5,6 @@
>   
>   #include "k3-binman.dtsi"
>   
> -&custmpk_pem {
> -	filename = "../../ti/keys/custMpk.pem";
> -};
> -
>   #ifdef CONFIG_TARGET_VERDIN_AM62_R5
>   
>   &binman {
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index b941726e6246..8d4b0b2454f6 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -13,7 +13,7 @@
>   	custMpk {
>   		filename = "custMpk.pem";
>   		custmpk_pem: blob-ext {
> -			filename = "../keys/custMpk.pem";
> +			filename = "arch/arm/mach-k3/keys/custMpk.pem";
>   		};
>   	};
>   
> diff --git a/board/ti/keys/custMpk.crt b/arch/arm/mach-k3/keys/custMpk.crt
> similarity index 100%
> rename from board/ti/keys/custMpk.crt
> rename to arch/arm/mach-k3/keys/custMpk.crt
> diff --git a/board/ti/keys/custMpk.key b/arch/arm/mach-k3/keys/custMpk.key
> similarity index 100%
> rename from board/ti/keys/custMpk.key
> rename to arch/arm/mach-k3/keys/custMpk.key
> diff --git a/board/ti/keys/custMpk.pem b/arch/arm/mach-k3/keys/custMpk.pem
> similarity index 100%
> rename from board/ti/keys/custMpk.pem
> rename to arch/arm/mach-k3/keys/custMpk.pem
