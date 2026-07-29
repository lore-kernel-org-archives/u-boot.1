Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54383C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6867B6075F;
	Wed, 29 Jul 2026 19:29:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3ial4XvFest; Wed, 29 Jul 2026 19:29:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE9F16071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353384;
	bh=x0Ql4aiKlfNH5ttwokMDXXttGiNldxisg0YwHb1VKM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SmKsHLj3ZJK5qyiwzMzg7/jolI6ZsNhgxdfMtQhTjy8UJ2xQgqflvizOcnR2WjUAv
	 UpDrqr7FvZ/FOqJv7ikGk96jpYkJF2tajtTuvMGtWEuQeqWe3hDcILPK6Nl9sH/9ig
	 ncRevzHPzpnV2ePMps8v9KeN+FBJMel2Cy57DlMoeBm+A53caJFGoQ3zWMre4sJaO3
	 tMeeJbTQWwyXehNksS0RtKy5v1xjoYUXkLhDVoSnDkd1RAIDN1V1wQjOP+QLWSk5JH
	 ip1bZd2M0Mh5yf+KSB40DTpNDZZJf1ZounPzgGy/GyGpaWECji7qpm4qEP94ICUVur
	 +IGuPJ9jm4ncw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE9F16071D;
	Wed, 29 Jul 2026 19:29:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D16F626E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3CD7400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:29:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocoqJ-C-lsN3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:29:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DFD5D4009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFD5D4009C
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFD5D4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:29:41 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6ab0223a3d3so760396eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353380; x=1785958180;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0Ql4aiKlfNH5ttwokMDXXttGiNldxisg0YwHb1VKM4=;
 b=SpjrJTlZ9SBVwRYV/bxwtdXNZ01u11N+UlyevOPHDY3Tv7SD5fQRRm09S7PycudDHI
 yII+gSBDEvqevGnDnYvRxlNHG8KjovGVpPEgduThe3qWMWrw7tvK13KeOqqT1sFfnDPx
 YwwpRgLd62loUGICt7MQjnEumu/HhL0Sn7WiIZO12+IeUCHdts4Mcc8HXIVOH47gPM6k
 qP1F+fPmC1PN2EyT7gk9yVIbrsNzFFzsShdJU4O3BJm0/tX2tLnpL0UoubEFJa2Qfc0P
 L6qy3CEEg8ze/g2tWq7D+TamEJ2K75kn/0wYE6IVIvhnl9oMcENHKWkage4aQGYFnum0
 FveA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0yr5Vunqpbt41KDfwRP1hhXSjLjOYa3mj1wBL58pbAYIlydUYeFVdMYuBis8zOkJSfAuzbwU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwkxomFzgmUNa6V2TF+AG6Uk8oxqnRNJLu4t9gu98WR15pXaZk/
 vQOrsYV1WAuMB1eM1IzVSmC6B9MU6Z5KDI78TE4tV3fQQsK4phyy6CxX/DKJFFBVB4g=
X-Gm-Gg: AR+sD13Grz4p3rutit/9xw+l+Bq6d7ZI3iLjWjVXbQPBZN6Z9NvIOY9iAoxOWOcXpZk
 Pmrs/TbpMdvolTTs+PslD2LCYcKv3i98agMg0FePs14AHcYeeClrGSNpSaxMR6/mblRWcI4rBes
 4CuQ4LfJRBS8nGYG3xG4V7HSXLTtepJ/FTv7rhfHoW9ILjRa3RXzHGs9EqZSAGQK6/jzJ68HUhW
 pTW8/0ywptnFlHjXXVAz6D/28ETZtwvMW8d0eFw5p3yWZJXpomisbVGNhvYnIIKn1hva++1kBwg
 XmTI9OZmgBHgWupoEmzDCDHw4SLJsWx0jM61YoE8rCCDlm882eRDL4vZvIwpCwHdhH9cmJFAuAy
 h1+zogprDgmWUAgzqGp0RjBQJyawvM9HiD+eXcfjAnyYpF7G413Bm7qD8FbjohBd8mrAkBmk2ik
 NUlOE9UYWKBXYuPND3Hks7Blb5TASncJcUl+CAyuEAfWG9xqCtoi3gGGOuk9X1Ljs8mt5LuFJRP
 zUMd4QhsbFoFNU2sPorv3MhyMnx2wMUCYQaQKs=
X-Received: by 2002:a05:6820:4de9:b0:6a0:f3b5:12a2 with SMTP id
 006d021491bc7-6ac96be6511mr3866028eaf.20.1785353380544; 
 Wed, 29 Jul 2026 12:29:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aca52129bfsm2569078eaf.2.2026.07.29.12.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 12:29:40 -0700 (PDT)
Message-ID: <4d29df61-dbe0-4149-b482-f5774e5dd34d@baylibre.com>
Date: Wed, 29 Jul 2026 14:29:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] arm: dts: mt8188: add hdmi override node
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
 <20260728-add-genio-510-and-genio-700-hdmi-v1-12-ac54bd75f960@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-12-ac54bd75f960@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785353380; x=1785958180;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0Ql4aiKlfNH5ttwokMDXXttGiNldxisg0YwHb1VKM4=;
 b=mZIIivghozLh52g2RNcOrekkUJRbPq/JH4yhxusfTrrd0VSW+rpOLZ3qhTzh0TqCam
 6O3htfXKTnlGI4GeZ8pIdVYvLfzhJLuSvGl6wc20vmuB2sBggVEXuykTjJ//Zasdx5nz
 Q+0J5k9KKW4LPkPTt3XAxVqce6veTuA2s1PY0ddVk5iHJ2DwdGE2AOK58O994CPMiVvk
 HATtOpS4eb/ke7O7OAdoDZ71+UnJpp75dH5CXKZRMgHSUYybJj9iVW0S/OFiriQCS3Fl
 gQgZGTLUQw4GmeMZtQ16t2RNQ3Ko5Z08aasVu3H2VlazDYhvR5LBm0W5qaDYSRJXvY7h
 kCmQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mZIIivgh
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
> The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
> interface attached to the vdosys1 display data path.
> 
> Compared to the kernel, the following U-Boot specific properties are
> added to the hdmi node:
> - a "memory-region" phandle to the framebuffer reserved-memory region
> - phandles to all the components of the pipeline, since U-Boot has no
>   DRM framework to walk the graph
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm/dts/mt8188-u-boot.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
> index 923e52522de..26a2bddd24e 100644
> --- a/arch/arm/dts/mt8188-u-boot.dtsi
> +++ b/arch/arm/dts/mt8188-u-boot.dtsi
> @@ -79,3 +79,24 @@
>  &mmc0 {
>  	bootph-pre-ram;
>  };
> +
> +&hdmi {
> +	/* U-Boot specific: the framebuffer lives in this reserved region */
> +	memory-region = <&framebuffer>;

As in the previous patch, this could be in mt8390-genio-common.dtsi.

> +
> +	/*
> +	 * U-Boot specific: U-Boot has no DRM framework, so the video
> +	 * driver locates the components of the display pipeline directly
> +	 * through these phandles.
> +	 */
> +	mediatek,dpi1 = <&dpi1>;
> +	mediatek,vdosys1 = <&vdosys1_pipeline>;
> +	mediatek,merge3 = <&merge3>;
> +	mediatek,merge5 = <&merge5>;
> +	mediatek,mixer = <&ethdr0>;
> +	mediatek,mutex1 = <&mutex1>;
> +	mediatek,padding4 = <&padding4>;
> +	mediatek,padding5 = <&padding5>;
> +	mediatek,rdma4 = <&vdo1_rdma4>;
> +	mediatek,rdma5 = <&vdo1_rdma5>;

I see that the upstream device tree has aliases for a lot of
these phandles. In the U-Boot driver, could we look up by alias
instead of adding these properties?

> +};
> 

