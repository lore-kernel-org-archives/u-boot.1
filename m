Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45CCC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 03:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A6287E1C;
	Mon, 26 Feb 2024 04:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xdnz5v3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE66D87E1C; Mon, 26 Feb 2024 04:17:15 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1789087E02
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 04:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41Q3H8aV079745;
 Sun, 25 Feb 2024 21:17:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708917428;
 bh=4r+AtNirDALY/dGxcCRYXxsM6k/yq8hz6rQtTy1wnL8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Xdnz5v3P70DkunQUfX8xLlgS7eK3IYPY1u//PPRSqJ4i3tzKuEV5Be3b3vjblr9dU
 xV35PDtkzHEeDOGJkWJCRHqAYnuBkuwPXcmaFJK73jwznaUvbeKglcO342T8AFLEjb
 nbZad0x8v/Q7XSDitC1HiVXnwbZHVPOxmkdRmGdk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41Q3H8uI021711
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 25 Feb 2024 21:17:08 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 25
 Feb 2024 21:17:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 25 Feb 2024 21:17:08 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41Q3H5kF109274;
 Sun, 25 Feb 2024 21:17:06 -0600
Message-ID: <c7a255a0-dbc6-4cdb-b46c-3b81d17ce30c@ti.com>
Date: Mon, 26 Feb 2024 08:47:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-binman: Make optee optional as requirement
To: Michael Trimarchi <michael@amarulasolutions.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>, "Raghavendra, Vignesh"
 <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Manorit
 Chawdhry <m-chawdhry@ti.com>, <linux-amarula@amarulasolutions.com>
References: <20240225173834.1637789-1-michael@amarulasolutions.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240225173834.1637789-1-michael@amarulasolutions.com>
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

Hi Michael

+ Vignesh

On 25/02/24 23:08, Michael Trimarchi wrote:
> Boards can use the ti_spl_template but avoid to define a tee
> node to be loaded. This is true form board with 512Mb or less

s/form board/for boards? I am guessing that is what was meant. I am not really 
understanding the commit message... does <512MB memory always mean no using 
OPTEE? (AM62 SIP would be an exception) The commit message is putting out a 
misleading reason why we don't need OPTEE in some cases, I don't think memory is 
the primary reason.

> memory. We can limit this in configuation removing the tee

s/configuation/configuration

> node
> 
> configurations {
> 	default = "conf-0";
> 
> 	conf-0 {
> 		description = "k3-am62_ccm_m3";
> 		firmware = "atf";
> 		loadables = "dm", "spl";
> 		fdt = "fdt-0";
> 	};
> };
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   arch/arm/dts/k3-binman.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 758c8bf6ea..5ef5af315a 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -293,6 +293,7 @@
>   						keyfile = "custMpk.pem";
>   					};
>   					tee: tee-os {
> +						optional;
>   					};
>   				};
>   
> @@ -360,6 +361,7 @@
>   					entry = <0x9e800000>;
>   					tee-os {
>   						filename = "tee-raw.bin";
> +						optional;
>   					};
>   				};
>   

The patch excluding the commit message LGTM.

-- 
Thanking You
Neha Malcom Francis
