Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366DDC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 23:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F07C8714E;
	Sat,  4 Nov 2023 00:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kHGi0WYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB24B8712E; Sat,  4 Nov 2023 00:31:27 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8F08712E
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 00:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3NV6XJ046643;
 Fri, 3 Nov 2023 18:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699054266;
 bh=Dco8H//ZsgiCAlxsu/FiumdyhLbJczDBvbQBjtPW2Q8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kHGi0WYzWEtcglLGBG7dJ1mCRxs/AIyBQQdjma16+ht7XVc6l+hmSYxULNQ7ICddL
 b5POH9Mvb5ZRDkcXJ4BsVdtK98Z/DR67n5VMv1MqFUipuEQt/kPhjyhjLxClSZO5Th
 q/mN/0t4XHVf4btas56wkg/+cgR7abLlzvOtBpio=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3NV62m013209
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 18:31:06 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 18:31:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 18:31:06 -0500
Received: from [10.250.33.210] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3NV5xF076430;
 Fri, 3 Nov 2023 18:31:05 -0500
Message-ID: <688df26b-b7be-4fd7-9d49-2627bf75a302@ti.com>
Date: Fri, 3 Nov 2023 18:31:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: Move K3 degenerate keys out of board folder
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Simon
 Glass <sjg@chromium.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Francesco Dolcini
 <francesco@dolcini.it>
References: <20231103224453.3264313-1-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231103224453.3264313-1-nm@ti.com>
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

On 11/3/23 5:44 PM, Nishanth Menon wrote:
> This file is common for all of K3, move it out of board/ directory and
> into mach-k3. And change the relative paths to absolute paths in the
> binman paths.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>
> Cc: Andrew Davis <afd@ti.com>
> 
> Similar to the patch https://lore.kernel.org/all/20231101183329.65091-1-afd@ti.com/
> 
>   arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi         | 2 +-
>   arch/arm/dts/k3-binman.dtsi                               | 2 +-
>   {board/ti/keys => arch/arm/mach-k3}/ti-degenerate-key.pem | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename {board/ti/keys => arch/arm/mach-k3}/ti-degenerate-key.pem (100%)
> 
> diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> index b489d8afbe36..a6d7c2df20e0 100644
> --- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> @@ -10,7 +10,7 @@
>   };
>   
>   &dkey_pem {
> -	filename = "../../ti/keys/ti-degenerate-key.pem";
> +	filename = "arch/arm/mach-k3/ti-degenerate-key.pem";
>   };

You shouldn't need to modify dkey_pem here anymore if the path is now
absolute, you can just drop this whole override node.

While here you might as well move the TI dummy key (custMpk.pem) over
the same way.

Andrew

>   
>   #ifdef CONFIG_TARGET_VERDIN_AM62_R5
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0212d44ee3b2..af0f83100bd5 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -20,7 +20,7 @@
>   	ti-degenerate-key {
>   		filename = "ti-degenerate-key.pem";
>   		dkey_pem: blob-ext {
> -			filename = "../keys/ti-degenerate-key.pem";
> +			filename = "arch/arm/mach-k3/ti-degenerate-key.pem";
>   		};
>   	};
>   };
> diff --git a/board/ti/keys/ti-degenerate-key.pem b/arch/arm/mach-k3/ti-degenerate-key.pem
> similarity index 100%
> rename from board/ti/keys/ti-degenerate-key.pem
> rename to arch/arm/mach-k3/ti-degenerate-key.pem
