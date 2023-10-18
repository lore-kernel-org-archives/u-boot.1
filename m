Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD03CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 19:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2914486FD2;
	Wed, 18 Oct 2023 21:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697655667;
	bh=o93AOjOUHK3/WffVrh0Ank3oMOg5KRhzgmDj2tn7m2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SiSE3tzjNLKNncOubjhQ2zTsyEBQEdvZagi51aALSRjftsCpVoKIRBb3xzOdsytFP
	 0TS4Aqw9Lmm9PXODJmNKnTDcb7IUDxX5UxbwaX0r9yRt9S+3h5ImHI0aViRN9mNmbn
	 QLgF2KuTwaTm4grYGTCBFZsW8gwRnbwNt81ap/rrpQU79de1E+EwsU6iYH7PEhzX5E
	 FfFmXaVMXuIayWz3ZzO0O/Vw5+keH9+B0IoX7O/9pOTKtmklD48cw9kjryeXr34YRe
	 0vmswwtmUZ1cGIKBomV6o4UenSINZeE3t7YYDhqF3zo19ptcO+ak0OQ92VTeRoFcMO
	 t0gJMnFAy21NA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5A77686F8F;
 Wed, 18 Oct 2023 21:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697655660;
 bh=o93AOjOUHK3/WffVrh0Ank3oMOg5KRhzgmDj2tn7m2M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J1ndxPnckLnwutaeiKVSXSX9f10BOY01oiMwaXbTHiLZZo7cg8fQt6qIBAq47t7N+
 deBB2fgMchyO0xHQ87uKKKfFIbk1Pb8ao/UUHcgEKIwh23IWMQ9/nG1Avp+7skU9a1
 vnlP3A5kJbOGnI1oy4SjDt9twH5BgCcegXl1LLeAshYWJjXJtEMaJHXWzNGMEDXJXI
 Vtwfpn5HWuMfSy3z9OiASgQvCPF6iQ+Zv1Z6LpHNcIWZxTjhlq9ZVAAcX9BDzLJOQB
 kb65hebhB4t2RWOW8OpaI8ayewjjxT54wFCE+Rj6VhE7QxIVAfYbVT1IzMNXo8fcjf
 VszDoc8bamz8w==
Message-ID: <35cc73f7-3b96-4a3d-9f90-ab8ff9dacc26@denx.de>
Date: Wed, 18 Oct 2023 21:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231018185530.1272005-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231018185530.1272005-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/18/23 20:55, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Pass #address-cells/size-cells in the mdio node to avoid the following
> DTC warning:
> 
>    DTCO    arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo
> Warning (reg_format): /fragment@0/__overlay__:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #address-cells value
> Warning (avoid_default_addr_size): /fragment@0/__overlay__: Relying on default #size-cells value
> 
> Also change the Ethernet PHY address to 5, as per Marek's feedback.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v3:
> - Change the Ethernet PHY address to 5 for good :-). (Marek)
> 
>   arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
> index f27e6429abe4..bad015536166 100644
> --- a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
> +++ b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
> @@ -5,6 +5,13 @@
>   /dts-v1/;
>   /plugin/;
>   
> -&ethphy0g {
> -	reg = <7>;
> +&eqos {
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet-phy@5 {
> +			reg = <5>;

The reg should be 'reg = <7>' ;-) It's just the node name which should 
be 'ethernet-phy@5'. (Yes, I know, it is not consistent, that's because 
the DTO cannot "rename" the node itself easily).
