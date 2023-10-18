Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4884DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8289787005;
	Wed, 18 Oct 2023 20:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697652677;
	bh=J/kPifKVIHHRKlyjVUzxrNKIKrUo6verJ9/FlSh1Jbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MBdV6+mKq37M6z/NXKRfZ3U6UuwRgpSI5IV8yyYbnWTedYhNaC/5QbZ/b0tqwZWyl
	 4f8RVHPOXNZ0+6PpxHsi2zALFyKrG3ToViIPBQ1s0Iy1ypwKk65Yh0Jh0lJddzEGdK
	 avck7r91VcfdtD8dDTaR6UWMajVvRNdVrWhEZSbZQJn05G1RxGCeYq+PCFNNa9ofc3
	 2GjlV0ut+ROVRythkyLMQ3105T1lU5Tz6jXH97GD8Ol0H090AZS/quBpqUBRa3kkoG
	 UQcxa9z+Gq8ZtdYdBupwc6xn/L/kXOc7bX7loR7c+VWu5vwlR+WbA02/iJVLgD3Vc0
	 ylykMGvXv9c/g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7054A86FC3;
 Wed, 18 Oct 2023 20:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697652673;
 bh=J/kPifKVIHHRKlyjVUzxrNKIKrUo6verJ9/FlSh1Jbw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vAKSMaXErp7htqJTwB7MvQZqJ4nTjKmyDQgboStMNyxuPF83y1A+ld+lJ7HbnRXPK
 lOAbeGzeRcJoisvRFNUXHG1YWl/TAUYUQabQQxxPJZZYb/QGtn/lXqfMig/qFogYiW
 v1BkeFSr9vTkt3RC0CbGL/2LPQ4Qy6ZZKPJD+adQRPus2GNFO6p5YVcIcL793xGHna
 LB47JTnW4b39tlt5kCAHX+K4JhAZ1PHH9JHYlQH4qYGbo8PC/ovTTfv5dqLwhkeAl/
 o/bif7RRfZ67zL5wT1yUCRj3z1FgeseyHI8I5G0LvsSuPJfeFtmKfYj53W1M4BH7Cu
 TvHY2OqOdwP6g==
Message-ID: <1c7a451a-56ea-4e5e-89ed-85964b62feaa@denx.de>
Date: Wed, 18 Oct 2023 20:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231018175413.1236767-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231018175413.1236767-1-festevam@gmail.com>
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

On 10/18/23 19:54, Fabio Estevam wrote:
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
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
> Changes since v1:
> - Remove the ethphy0g label. (Marek)
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

One more thing to fix, this should be ethernet-phy@5 , not 
ethernet-phy@7 . This is a local fix up for old hardware, which 
overrides the PHY MDIO address, see:

arch/arm/dts/imx8mp-dhcom-som.dtsi:             ethphy0g: ethernet-phy@5 
{ /* Micrel KSZ9131RNXI */
