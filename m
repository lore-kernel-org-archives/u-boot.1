Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8B7CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7CB86FE3;
	Wed, 18 Oct 2023 20:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697655238;
	bh=2NWGbazxeEEIjFhhovAcYPeza5DGAK1iZsI1HiwK+7I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ML9XxCbLgaHkqNbfB9A8RpXi1VrK6P4kEmOWCWrdhv6dORWBbIzrC94nu51LOk5cP
	 Swf1f/zyz6zXks7+vvVo6JzdpobSodH8NAn09JoSF7sIqK/g5h1GhLExGN9OW4w6xB
	 y/GcG+C15Sc50NAkCM24xNwykSAHEoSBaVQvR3XyHIbvlf3alD1dg47oRPmL9RqAjB
	 i6sd3eA+iKr9cfthJ+aAtiRb6A8BwCNuwi+oEHfV9u2YF+6vB0qkKHNVwoDLfdHL+m
	 uD90QWpKErNrurzrBLp9lAw8Ca2brNY7YPyrSoO/asHIRh1jykCifLTMG95LhsSrz3
	 dftAxK/jHoxjA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 158CF8701E;
 Wed, 18 Oct 2023 20:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697655237;
 bh=2NWGbazxeEEIjFhhovAcYPeza5DGAK1iZsI1HiwK+7I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m+Mp0IkYMANvVtz+enHc8lLuce2SA3rBhcoimLpiZiMYpDnpz6k0QHFaqUrXRgBdH
 eL2lOrhykFQcxR8mmF5YIHWPo8YmqKsALJzMTKPk0mdkhL93HltBp7bpy/EYZ/gY0d
 O1uVQmjMAlU9AtND77nEFbLdfZdH7w6hpQZG9fbbcQjUJ5DowciSuwxkOIDBOkkmwh
 YYMbz4qBIjAh2nCyYgTh1J4Oi7vEieRy0aIZ+/u04XuVNObdNayb9OXHJm9WElZHwQ
 lWglXo2CcvHKGrpfNHON4x1Ex7UF8zWZbj81QnBdS9TSELFy7hNnOrHf1WzDHqD1HW
 5B10lgNoygomw==
Message-ID: <6997320b-1b48-48f6-89ac-53015ae0e1c0@denx.de>
Date: Wed, 18 Oct 2023 20:53:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231018185225.1269962-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231018185225.1269962-1-festevam@gmail.com>
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

On 10/18/23 20:52, Fabio Estevam wrote:
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
> Changes since v2:
> - Change the Ethernet PHY address to 5. (Marek)
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
> +		ethernet-phy@7 {

Did you miss git commit --amend or git rebase --autosquash ? :)

This is still @7 here .
