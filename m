Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B5CC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52E2560733;
	Wed, 29 Jul 2026 19:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ic3OyqRu-T8; Wed, 29 Jul 2026 19:21:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F41A6071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785352889;
	bh=ld4bgbzrd9Qxx3ls1/3LzTJm4W3vjAJPZMXr8WqTHvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/rLMzWwNBDG0CapldZPsl6U9CQ10QY/Z8+9OiQGTuo/O3VzWTbl7eT3ZTLOIdRkt
	 nQdeMChf3+XvxwVO2gV4s7+eM2t41lJP2umJfRDZEfzcGzhns1Y3YKHVLTIZvpOa9K
	 HoHnHL5MbeizUmZQ+3D1bB2lP5iOy++K8zxzyvB/2QZKvXswAySExn0xpMM/wrNNia
	 O2YqJl0iPG/UAV6XOOReyM91rp7uZUcTLBN7o4LLI34zMxL2HJAfobRuoS5T8Lqww9
	 Jq9r8ISUVgBmxS+1v8azY2cctyEZBW09BqB+7PlhPKD2yrlTHhTVEFsD3PsnonND01
	 7sGsmiHHjuN3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F41A6071D;
	Wed, 29 Jul 2026 19:21:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 812A227F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66E156071D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XkarfMIWffgx for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:21:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 189D5605CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 189D5605CF
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 189D5605CF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:21:25 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso699597a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785352884; x=1785957684;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ld4bgbzrd9Qxx3ls1/3LzTJm4W3vjAJPZMXr8WqTHvo=;
 b=jOF7C6Cb4IVmzimWMDMpA8XiykD7iFbJCqO37k0EgR2bE1GVQGfZzK0hsPuRJf5YLY
 yL/LWuMqjoVD4JU7mFFVfdlOQXyEH1bRNDprUWi/1KIlXv70cph5vVozTzJc00PaocD9
 FGq+mfFR+huYmVqjablmuq2jkDalImDP10A/e008yM/7tUNgDPzzOoQGW+fydfCm24eq
 udWf/Publhazpx8s2IMKRnmXJskwy9RPaRBClwqlsTsk1CxO01BrQWZqUUd696iLsODX
 xmOrcvClJc1DvFO6aP1LALDtnZ4fynwwip4s556rZdpIViw0ITr+micXoy1T2pw0sZNu
 +vhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAplpgiHVn83juoNG96Gq6NsrYDGWgKPBZbNoy4ADUXCqZUYZSLfkF8i3Tp9KFYoW7nwr5veM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwXuzoCpx9SwRgVNfcgo+NdylpEr8jkIXDsJ4B6LfISTR7YCnpJ
 Qe/RmqpOfl4lckR+K6PXztfQppV75rm7k0snAdwZuJmBy60BSpduDDaO8gwJfXch7nM=
X-Gm-Gg: AR+sD12jyRv4dO0Woqc327yCxEVzOM+EKH5JX3lWnLctjPU8T7NHevSNi2oo4UFzReT
 ecyDrvXEuEW0YnpD0GuyTtL41T78ajQYdc1yHV1bEySYOYte3TYJb6qjgHQuCXX+PxCcKNivXWZ
 2U/lQUacZmAgAhAdCHEeSxjvAIOebxksRxKkt/8XGSxqwVFTAXn10jA4yNOw0O7MaJ1W900Cwyp
 uimda8XQpnVV3Za1uQ6jHq1J4fxM2Yo35u96Ja7fRaFX7PmQ5lF8bXLfPIUzZZwp5UEuAez8v6v
 b6Owt9NN53y22XTORiGtPylI3zwgQZgz+noHaxmOuPb/osvmgrcGBPWyDM58j/1ERmchQkrT/fF
 e2g+RuNxa2PW8GAz6pbtCOZbMgF+zQCby41nUmr6DloT6jC/qjMMDYwZzIJitFawQLnv7TAN6ag
 +yYJkZnOF5PEJIYQxvqI9bhGLEOzF7au9S10Bq5c4z8y80PddySHQXDbx59jIk4ilUTM5/H9OYP
 2oVdiMQZPEo1PfP6hE0LXfYJGIbCd/bkxR1hUM=
X-Received: by 2002:a05:6830:8284:b0:7dc:cdea:7d9 with SMTP id
 46e09a7af769-7f0282cf605mr28394a34.22.1785352884652; 
 Wed, 29 Jul 2026 12:21:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d595321sm3030970a34.6.2026.07.29.12.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 12:21:24 -0700 (PDT)
Message-ID: <c7649d26-4f92-445c-9fad-b9295782e78e@baylibre.com>
Date: Wed, 29 Jul 2026 14:21:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] arm: dts: mt8188: add vdosys1-pipeline node
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
 <20260728-add-genio-510-and-genio-700-hdmi-v1-10-ac54bd75f960@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-10-ac54bd75f960@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785352884; x=1785957684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ld4bgbzrd9Qxx3ls1/3LzTJm4W3vjAJPZMXr8WqTHvo=;
 b=Le/3DSxuEnTiP2s0dkNb+2qiqkWKjXBzREEIPnqj0ZqInW+UDInFDHmg2Kh4sBTYI3
 UHm7p0WBEe4mKXpmUCBKpIIZZ1EpuMJJlV+FqMtwiB/RL830k2pkGLDXTB4Tefh47QSH
 WOeucP7Pe5tgu301zuHSkFUTSnvzOcoKHZCrMqR02atVT5THAlCKgljAmVQPjVDGIJkd
 fJtdP5Mdz+jU9ByrSu5wdwssW3B8bQi3vQanXhne/tztDZcjJsERBLWBXQs6oNDwhevS
 spX8Bq+ZZcSwztUnreMtZuNTrcNFk0JYN2YAPDyumj8XJJelAsSKS4A0Bf8i3FXyIgkH
 tMug==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Le/3DSxu
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 7:29 AM, Julien Stephan wrote:
> The vdosys1 syscon node from the upstream dtsi is bound by the clock
> driver in U-Boot, so the display routing (SEL_IN/SOUT muxes) of the
> same register block is described by a separate U-Boot specific node.
> It also carries the clocks of the HDR back-end path that are not
> attached to any component node.

In the U-Boot code (include/syscon.h), I see:

/*
 * Linux-compatible syscon-to-regmap
 * The syscon node can be bound to another driver, but still works
 * as a syscon provider.
 */
struct regmap *syscon_node_to_regmap(ofnode node)

So it seems like we should be able to make this work without adding
this extra device.

> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm/dts/mt8188-u-boot.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
> index 131377d9a97..fd1121a72cd 100644
> --- a/arch/arm/dts/mt8188-u-boot.dtsi
> +++ b/arch/arm/dts/mt8188-u-boot.dtsi
> @@ -4,6 +4,18 @@
>   * Author: Julien Masson <jmasson@baylibre.com>
>   */
>  
> +/ {
> +	vdosys1_pipeline: vdosys1-pipeline {
> +		compatible = "mediatek,mt8188-vdosys1-pipeline";
> +		reg = <0 0x1c100000 0 0x1000>;
> +		clocks = <&vdosys1 CLK_VDO1_SMI_LARB3>,
> +			 <&vdosys1 CLK_VDO1_SMI_LARB2>,
> +			 <&vdosys1 CLK_VDO1_HDR_VDO_BE>,
> +			 <&vdosys1 CLK_VDO1_DPI0>,
> +			 <&vdosys1 CLK_VDO1_DPI1_HDMI>;
> +	};
> +};
> +
>  &u3phy0 {
>  	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
>  		     "mediatek,generic-tphy-v2";
> 

