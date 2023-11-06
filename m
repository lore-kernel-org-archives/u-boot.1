Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F9C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8664686F9A;
	Mon,  6 Nov 2023 18:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KjWr8Bby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278C786F9A; Mon,  6 Nov 2023 18:07:03 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EDD486489
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6H6kOt081743;
 Mon, 6 Nov 2023 11:06:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699290406;
 bh=bw7hiigWccmothA8H1R5aVPtg62OyBUut1mMU34fUV4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KjWr8BbyHlJcFMKieCH3oNxUITY7R2TLnfjOV+gz0eVh+Lx09nfPnjOqB9HD4PEAN
 2BaV3hRn1FRddC/cfASGtQCVzsIhmr3odjXvOOGeS6oY6Kp8jO68XygdfkJbiCrXLA
 B52mXeTuaXb6iAVHDHm65n6Dx3sCxPpAqtP+fGDw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6H6kY3104324
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 11:06:46 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 11:06:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 11:06:46 -0600
Received: from [10.250.34.172] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6H6jcm108032;
 Mon, 6 Nov 2023 11:06:46 -0600
Message-ID: <84bb42c5-8974-49f9-9eec-fbd74966a318@ti.com>
Date: Mon, 6 Nov 2023 11:06:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] arm: mach-k3: Move K3 degenerate keys out of board
 folder
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vignesh Raghavendra
 <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, <u-boot@lists.denx.de>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-2-nm@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231104024511.3597476-2-nm@ti.com>
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
> This file is common for all of K3, move it out of board/ directory and
> into mach-k3. And change the relative paths to absolute paths in the
> binman paths.
> 
> While at it, drop the reference in verdin-binman file which is
> redundant.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> Changes from V1:
> * Dropped the override from verdin dtsi
> 
> V1: https://lore.kernel.org/all/20231103224453.3264313-1-nm@ti.com/
> 
>   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi         | 4 ----
>   arch/arm/dts/k3-binman.dtsi                               | 2 +-
>   {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem | 0
>   3 files changed, 1 insertion(+), 5 deletions(-)
>   rename {board/ti => arch/arm/mach-k3}/keys/ti-degenerate-key.pem (100%)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index b489d8afbe36..ea22bfb9bad6 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -9,10 +9,6 @@
>   	filename = "../../ti/keys/custMpk.pem";
>   };
>   
> -&dkey_pem {
> -	filename = "../../ti/keys/ti-degenerate-key.pem";
> -};
> -
>   #ifdef CONFIG_TARGET_VERDIN_AM62_R5
>   
>   &binman {
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0212d44ee3b2..b941726e6246 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -20,7 +20,7 @@
>   	ti-degenerate-key {
>   		filename = "ti-degenerate-key.pem";
>   		dkey_pem: blob-ext {
> -			filename = "../keys/ti-degenerate-key.pem";
> +			filename = "arch/arm/mach-k3/keys/ti-degenerate-key.pem";
>   		};
>   	};
>   };
> diff --git a/board/ti/keys/ti-degenerate-key.pem b/arch/arm/mach-k3/keys/ti-degenerate-key.pem
> similarity index 100%
> rename from board/ti/keys/ti-degenerate-key.pem
> rename to arch/arm/mach-k3/keys/ti-degenerate-key.pem
