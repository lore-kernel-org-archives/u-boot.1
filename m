Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63513CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 17:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E0086FF3;
	Wed, 18 Oct 2023 19:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697650792;
	bh=PJ0bQltpf9txPQbxYPjrPWhsOD/xrt6S0akGq9GL+oQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uV5y0Zg7kC8ybFfxdLdISQiGPG7Id1GHgB1t02FkaZGQ5tluOQ6QgfI7WfIVGZLj6
	 tvE+eVZCA6pN1gop5vTQvMPNlg7a3hrZze0L6HQ0Zl/9llTTFfhalUD6ecn2MHByPW
	 W/QpIm5w4vCdBQx/ZUyQpoIdFiVbMQSgoxZi0q8d03V8KXymInxkSCvNSLmw88T1fb
	 A/6NKpAnX6q8td5buhKpkaLQZ8N88wlVIjQPMZUhW7LqLBihkWLbsLXBrLhl8/N+G3
	 gsrYKv7hdGMbBMlfbom2K8kvHvDjU/0cz3xMhhEqw451hXCGIXY6XpZ+c+w2dnB6AY
	 xEQ7AjlsEs4Zw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E627686F94;
 Wed, 18 Oct 2023 19:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697650792;
 bh=PJ0bQltpf9txPQbxYPjrPWhsOD/xrt6S0akGq9GL+oQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lNnpE6HpsjH7KXRN/4+2NNuOtogbnkVI4GlnkYYDBTSl5MTL1X1cvHDoaLJubuOl4
 hM0Yz8c6NYypk8ecnORRtXwWuabZjkXMt46k+ARqMCZmDSAS/QxOsmB5pEclH5uzoO
 zPoJnpC75bl1eeCjN/wQvit0kSovD1lcMgsEJZN0SPZNS/+UwKKt7oS2Bm2ULeqtq2
 9Iz6elZsdtFoIO2j37TdiGPQsfiHKizMQ/6Ls6ddmAp+13rXv3Gj0DD8fSli97+iYE
 sTYDpC3F5EcuMZg+a3iD2RWDSztSinwxkJ3bGGl8alqANHcRX4LsY/pXDImjAXY+Xr
 8ACCp3u+/0YxA==
Message-ID: <33e08c71-35c5-44d8-9535-60c59a76b530@denx.de>
Date: Wed, 18 Oct 2023 19:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx8mp-dhcom-pdk3-overlay-rev100: Pass
 #address-cells/size-cells
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231018172103.1197671-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231018172103.1197671-1-festevam@gmail.com>
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

On 10/18/23 19:21, Fabio Estevam wrote:
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
> ---
>   arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
> index f27e6429ab..94bee3c508 100644
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
> +		ethphy0g: ethernet-phy@7 {

I think the ethphy0g: label shouldn't be needed, in fact it would 
override whatever label is already in the base DT. So please drop that 
one. With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
