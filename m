Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199FFCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8708486BFE;
	Tue, 19 Sep 2023 20:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695147609;
	bh=Govy6y5wpQPX5p5EF9rztEGREOgcTfgPIjNn9prPtVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TJK2VgYmshm1wJLwwimjnbdQ04t4c75jVQJsoqhd+7yxElVGct75tCoN7IP5F011O
	 0uRHA9e5SJno+KGk7zyCINvkfDn7AMtq9pXSC77NSepXiEtAnd+0vpAQNh8R6ScWjC
	 Gx4+GwmBIUKt3LZsxws+O1CLhQoksVDpRL3ZxRkwUUa9pGUth2VfT2QiOJD6UjngfA
	 3wxsjPibmnG/OLOGd10VCLPlkM4STXVkOmAcz9B9FD5lSEgAzgKCccMVWukApaiD33
	 ogzpkUB9g/h4LWNdoGaPviX+qEBU0x4+10uPv0h46iRoosMTA5FEAR+V0659EE570h
	 KIvDA8N20qxmg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1B41586BF9;
 Tue, 19 Sep 2023 20:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695147608;
 bh=Govy6y5wpQPX5p5EF9rztEGREOgcTfgPIjNn9prPtVg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=OGMCyjg5rm7GPfcDRyGhrWqToyqH5KXgPYJ5lNwwvwtuDxehWdpaFxovdWyDIvqct
 e8YZGYHhQTEdGICox+x9VYsJWea9XZFXDYiQClDg+IrnGbcRz5AyCyPgzJGdXH/fnA
 79djcH64IlZXWKlv3X+Fg2UaADdEJyCTr64T3AOjf/zQyK5oIb8/jYy8E1i6uHxTGs
 VLzIuZK3YI8eAOsuLJgOE3Fmr7Utcbe8GC+qEHOWHLH65bfpMcWm2c5p84ammtg7EQ
 h4gRQ9VeJPjl4rNgMaDtEa7dvFgCZSyZotv0fF4VMWjjnxv6U7dZC3vw2uuLLGUKDY
 Y2E/Nz5/Y1DxA==
Message-ID: <b1bbecb9-8708-bf38-1016-8e2c66d3dab3@denx.de>
Date: Tue, 19 Sep 2023 20:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] imx8mp: binman: rename spl and u-boot nodes
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com
References: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
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

On 9/19/23 11:28, Rasmus Villemoes wrote:
> The hab signing script doc/imx/habv4/csf_examples/mx8m/csf.sh does
> 
>    fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset
> 
> to figure out the offset of u-boot.itb inside flash.bin. That works
> fine for imx8mm, imx8mn, imx8mq, but fails for imx8mp because in that
> case 'uboot' is merely a label and not actually the node name.
> 
> Homogenize these cases and make imx8mp the same as the other imx8m*
> variants. The binman type is explicitly given and no longer derived
> from the node name, and the csf.sh script will work for all four SOCs.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   arch/arm/dts/imx8mp-u-boot.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
> index 200938a980..355af16cf3 100644
> --- a/arch/arm/dts/imx8mp-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-u-boot.dtsi
> @@ -171,14 +171,16 @@
>   		filename = "flash.bin";
>   		pad-byte = <0x00>;
>   
> -		spl: blob-ext@1 {
> +		spl {
>   			filename = "spl.bin";
>   			offset = <0x0>;
> +			type = "blob-ext";
>   		};
>   
> -		uboot: blob-ext@2 {
> +		binman_uboot: uboot {
>   			filename = "u-boot.itb";
>   			offset = <0x58000>;
> +			type = "blob-ext";
>   		};
>   	};
>   };

Reviewed-by: Marek Vasut <marex@denx.de>
