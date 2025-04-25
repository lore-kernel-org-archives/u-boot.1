Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A45C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCB9829A1;
	Fri, 25 Apr 2025 19:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745601406;
	bh=pzJzj+iuoyz/Hv3+6ODKdOs2SQTqtTl1usheblEXWZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+nYvfOUKCEIRNSB6itoNGPQ566NMkWB1G7tO8qJnn8mjE6oTSPGe44ijw3Et/Rfu
	 Ag6BI6CXtRBh+hHTzkYq3hYgeUOBsNJ84uZVMeK7hUjPGqcWrQ92Yb1tBLFhG0Q6lx
	 P38eCMjF3+wK0aZJPvE2Rc5ag+koY6T7MjrzIy4yPTzT9xBAa+7S5SvCHkowXmh7X/
	 pQBK8Pg7aWggow7Ro4hXoYsbwVhnN3p7p5EIuCrX1BZJe0pe2Yey+TpsFRhhxY8Okv
	 oODZMwohTV4VFxgeNXF+TYPlW6aUGbdyoid3J5I6BEKu7hPSJ/TMSsdrjFZ+RtIhr9
	 YOwgoc8/NrJZQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93388298E; Fri, 25 Apr 2025 19:16:44 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C9B82958
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Qnp6cobD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 56E9310275AD5; 
 Fri, 25 Apr 2025 19:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745601401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pzJzj+iuoyz/Hv3+6ODKdOs2SQTqtTl1usheblEXWZU=;
 b=Qnp6cobDJ0QU8e4JAzRRGWo0d2lsr7lcatM49Xn20gFpR5O7f2GMUwpBRRuJ/TYfW7m+uL
 1FTAk4r1W2Gv9CjAwnsrp+dIrouFH9aS8ZCCIOAjGtiHwRHpV23d47mhuTrVagfU2YEUNn
 LXniQZ8cvbpZUgi7hoiEsRw7lGHG13toXUCZV74YmbWbZlM6JCwYeyLx8vk6S6s9ccTMpH
 iFwSLtE2QfMt8fNrFzshPC0mV6J4BMUZPPaXPwPAhIgTL9sOO0TwA25A2Q5360JXtzGSNJ
 AKinJQNyZCqeNh30HqvNQ9kdO6OjVXHEHw4AQ2GUuG/rJcj+xqJ4n7oc54svkg==
Message-ID: <cd79aa6d-e291-4683-91e4-abc0046c25ab@denx.de>
Date: Fri, 25 Apr 2025 19:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: Remove unreferenced
 clock-controller clocks in SPL DTs
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250425135220.1929510-1-festevam@gmail.com>
 <20250425135220.1929510-2-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250425135220.1929510-2-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/25/25 3:52 PM, Fabio Estevam wrote:
> From: Marek Vasut <marex@denx.de>
> 
> Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"),
> drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk)
> fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in the
> end calls fdtdec_parse_phandle_with_args(), which iterates over all phandles
> in clock-controller@30380000 { clocks = <&osc_32k>, <&osc_24m>, ... } node
> 'clocks' property in an attempt to find the "osc_24m" clock, but fails to
> resolve the &osc_32k phandle and returns with -EINVAL.
> 
> Remove the clocks property phandles which cannot be resolved because their
> matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with_args()
> can resolve all the remaining valid nodes and successfully look up the osc_24m
> clock.
> 
> Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
> index 96a6df94c6c..bb0e5b4e31c 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -51,6 +51,10 @@
>   	/delete-property/ assigned-clocks;
>   	/delete-property/ assigned-clock-parents;
>   	/delete-property/ assigned-clock-rates;
> +#ifdef CONFIG_SPL_BUILD
> +	clocks = <&osc_24m>;
> +	clock-names = "osc_24m";
> +#endif
>   };
See my comment on 4/4 .
