Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76302C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 17:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE0886076F;
	Wed, 26 Aug 2026 17:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zuvt_mYW749f; Wed, 26 Aug 2026 17:17:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787764655;
	bh=ciCj1OmCHaxmOfKGUgfM/bJsTF0Nd05RtuSchRgWUyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=slyWn1ZAjNSYOO3Cfze4yDyFGf6/VJBdlp529I3xqjXuA+g+ojJIG2tXyONZojSM+
	 a4oXbqTY9ya7pTdxSCX5ulwBG2pN1OckTKKod88qwINBU4fNfEkbbZEotP6SPgAVn5
	 +TDALWmUihmvq9v8jq++n2KOGj114RWNXK1ED0KSDbSQK15BzwiN4N5gAND0ioTKkm
	 GEM1I1XMAQsFD1CZLsdHoSL9tAFWw66BK1ajozjNOZY4z4OHBTszgWpEsT/sfvQZTn
	 X5kRa0LrGtgTqG3d66zwkJbvje6goTlnfPPc0Q98LqIcgjbuEgEk3SnAVy+ZMR/g56
	 ezvjHf0RqPJzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE5A0605E0;
	Wed, 26 Aug 2026 17:17:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 847C7323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 765EE404E7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqziveQ6nTFf for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 17:17:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=anNVroOa
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3D3A404A2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:17:31 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so1648565fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787764650; x=1788369450;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ciCj1OmCHaxmOfKGUgfM/bJsTF0Nd05RtuSchRgWUyc=;
 b=anNVroOa6K0zP/uMO1HcB2fkLy5QvAhRoBHvBSLsSiWI4ILqXdCtQPZAUA8BQc9ETq
 TjLJ4eGiz7RNiZtztmXQC57YxfZz1WL5NVOOoY0xUST+FMOMP4NaijR+SxU7ilW00MEk
 ELoknGrTX2Ia5ozKmB8jGlybMy3edZpFK29Jf0Mj0jjLIjg+Kw4P3F44d0uGdnbEjsfA
 hz7JbssCtJQHYXjOR42WaIA1vQdaM6e4yWBm3iSkw4Hc6agvu3cfVu+Xb66DC6aitRpk
 r1XgNfZidWRNzhUuPgtBinXo/+BiPfnafkNSTQnjZJ3n7wvz9u9c7+bX0NRpgcaNoIXl
 LJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764650; x=1788369450;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciCj1OmCHaxmOfKGUgfM/bJsTF0Nd05RtuSchRgWUyc=;
 b=eqD1o0XJI+axBG2vAppOppbYq4+VVd5/Lav5HBGrbQA9aA6luiTXy2ZUPuuaGffBKW
 caV0OQXWi1bBwLYVx3Ogr5TRL2ZgSib3y3q9GKRQXx5UfjT2hA6Z+60y9ZR3HnFxZ3OM
 4a9uwzQ+RQEqZcVD7CHapPRj7wd0VV2XxwmPkllF/tXin0ZVXKBFldVowdMKnInVtVh7
 2QTL3AS5JoepniGc07XbKAIHHa43m2Qm4mOXFPqTKLEfJd7xIZbivgZ3mLpD/vclzHK2
 ubfVwc8sOZZigCEe3n+HYLfskpzQUrKx5jBoj6GCZ/FoBw4i7Qvg5QsERqjnokULraKd
 4b0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RptM55CzK/PBdAqEDCbpVs6R9mMon5qE9Iskha7bpvzxLD9+v8QH/H4wU+yPTSNaZm1AKAquS4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmbZwxTYybCNYRvfguiMiOhOg8iJLlTxzKI2mUgWgH/GCqqaY9
 pR1hFqxuwXl6eoJOxzLPFK1uzikf56CPuu5O8Ca4FKIbkISwWBvQlBgbvAVHIh1jTLI=
X-Gm-Gg: AR+sD10KgPAKCKWRBVe3iH5otLYkthVrAGzUTe3QUpkZu1kV833uA69og/6TKsA2glT
 VpXfKamuhO8BEIljaUbFanZZ/2Q8zBuOspYOZet6UbspCeqUzR2jmkMUSkktVqdW0wS21OhFOUU
 uiApcrU9Im2vh9fgbReDFiawSewl7mAZJ2KYzho1YKyIEzGd8TtoVIrv2QMDiv+w8WYutLK60pY
 gt3XULRmLDilFkLw576H+KKbXv8q+fC3fIHgXpPnUWNyjzcnTFoaBqE+heay2ddvQE1zMHmlU35
 uyWAn5xHWuIZKl5+ASsH42Dg/GOSXTeefJq2xrkl0PTbX5QmFV9/wMUPPkgNMLxSJ14a0yvcrb6
 yVzCpks5ZgtKutXGOUAA84IthtvCDF1vL68qcmsHEKxqVygz2MEyTdl0DO8TD5AF/FETrcSpyKu
 hgsqXqKt0IuKuwllmhzeYLbxCKkNbdgiOBGz7f4IJ8N4uBtZ/I+TofyeMpagH6ieTxgxL0vRuBC
 RSf2+vu6VzsXFeELX6FGyCKFqMEldXZeEYHMRQ=
X-Received: by 2002:a05:6820:561c:b0:6b1:7289:fc89 with SMTP id
 006d021491bc7-6b1a0402039mr6237397eaf.8.1787764650081; 
 Wed, 26 Aug 2026 10:17:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c8183518sm2148347a34.5.2026.08.26.10.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:17:29 -0700 (PDT)
Message-ID: <2a915313-7298-4984-89c6-926df646d67f@baylibre.com>
Date: Wed, 26 Aug 2026 12:17:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] arm: dts: mt8390: add hdmi override node
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
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-13-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-13-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
> interface attached to the vdosys1 display data path.
> 
> Add the U-Boot specific bits to mt8390-genio-common-u-boot.dtsi:
> - a "memory-region" phandle on the hdmi node pointing at the framebuffer
>   reserved-memory region;
> - aliases for the pipeline resources that have no upstream alias (the
>   vdosys1 syscon and the larb2/larb3 SMI larbs), which the video driver
>   resolves directly since U-Boot has no DRM framework to walk the graph.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> index 95b2f66973c..9485315b79b 100644
> --- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> +++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
> @@ -5,6 +5,18 @@
>   */
>  
>  / {
> +	/*
> +	 * U-Boot specific: the video driver looks up every pipeline component
> +	 * by alias. These resources have no upstream alias, so add one here:
> +	 * the vdosys1 syscon (whose register block holds the display routing
> +	 * muxes) and the SMI larbs feeding the display data path.
> +	 */
> +	aliases {
> +		larb2 = &larb2;
> +		larb3 = &larb3;
> +		vdosys1 = &vdosys1;
> +	};
> +

It would be nice to avoid these aliases if we can. For example, we can
get vdosys1 with of_node_by_compatible().

The larbs are a bit more complicated but still doable with
dev_read_phandle_with_args(rdma, "iommus", "#iommu-cells", ...) to get
the node with the mediatek,larbs property. Then ofnode_parse_phandle()
on that property to get the larbs.

>  	reserved-memory {
>  		/*
>  		 * Keep these regions clear of the board reserved-memory
> @@ -24,3 +36,8 @@
>  		};
>  	};
>  };
> +
> +&hdmi {
> +	/* U-Boot specific: the framebuffer lives in this reserved region */
> +	memory-region = <&framebuffer>;
> +};
> 

