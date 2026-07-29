Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0AAC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB8E80E8A;
	Wed, 29 Jul 2026 19:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWVYS8C0_GAp; Wed, 29 Jul 2026 19:27:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6977F80E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785353223;
	bh=Ezw7WNTV0ykeEUbS4cSKV2IRzBLwqronYAYhQ6uwo2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaoL643lzRqxmDdEfDLg8X2W0glMoBT08siwe2BBh/y6yXW6xvkngKsQPhpG1N3k3
	 6VCW3QFS3BElg71Qs21w+43D0fveE7nRzdPZv3Hkd7bf1+4oC8wdglkTaFeEfNqumh
	 w7Uby0RTuRIjLEjkl+s48v/kA036aslYxGJYRkXxmFXZItXiHYoi8qMuJctJWubuCm
	 QznVrefpOdza8bHDSNWJ8x8qTU8cES/n/V6vgOvkXj53rycsopmcqhCP5s+YspUXve
	 wSlR/mmCfVLfL9bQ+NXg/df8/IbrGYtf/xRbl25F5s1gFidNtt4opgAPLkf0xWCXEW
	 GzPLtFC+iD5fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6977F80E91;
	Wed, 29 Jul 2026 19:27:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E86FC28E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9FD6400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vGUo2m7TsTh for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:27:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c32; helo=mail-oo1-xc32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D5E774009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5E774009C
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5E774009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:27:00 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6aae11ddd13so930445eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353219; x=1785958019;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ezw7WNTV0ykeEUbS4cSKV2IRzBLwqronYAYhQ6uwo2w=;
 b=YrYYseO3fSFSTR/oF6CsjysCLtf7fS6/29k34CLZxpPzATBlsqovHUFsqBq0eV9WO/
 woKErYsQiLMlk5fM0lN+sOM8x/sHBcAOCZ3jmpHK7S98fjNEDag3XZ/8ZUOqIoMjMnf3
 JEQB/6e/G35PPBESkVKSbxDGSWHRdhTmmhFmOr/4Uyr0QdjU06VjnfxZnN7Jq/iJCfvm
 v6talg6TkT9fA0YNOwYM5/VCyOde+Bk3+QOUizg6IRTCdZBlY9BneN9yb3T+Xt1QY16Y
 i+JPtwqkAK3u3/PhODGWljGBj0kZlmUXCK3T4JwLveH2GWEi/MuNXj2lcapWt0LFdPVu
 0rFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCXj6CBPXW/y3VBvLSiELVVR6MvUZeNXA7MbSnNSjNoQQTMjEOmUmxpqrgmnI2mV6AmGZn//o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzUgtFvi2c8IwiG3HEQ42FJzWSqxDVA6I6YWL2jB+Ifw+pnvMaI
 8Fz+DTHnzYNXQPk6OjM6y2inMBpv75x6SPm2djKxsNtbeXnt9RQihYQERyAZrpxlH2w=
X-Gm-Gg: AR+sD13cm0aWap/T8mxKj1rWkBr+JG2+xKXtzFNjv+QaOGwhqDCbRU/JrEMr/24Q2fm
 xwgirmbisyRUJV0digGa4jm+o4F9tP5W+ejtQrrtRS8JykvDwcY39z3Q+WWpeNOG2JEkX1S4hSc
 HMA6ELuGP9+mTvwVFXD1LkO+RfC9iwDO9VP9ed9JKHZzmVFDcWowzBeoNMiOtnFdJpSoXbOSwFQ
 5GQ/wJ8yRqoG07XAqoVqnfxgm5Ybt/NF0HNq8G2PwGjlbsu0OC3Hs9bK8qvoGG7a4EwCGJ2CQb8
 wtox4INfNjlrpT6ZC5itDCj5g2DAb1H9eAT4LYNez48hcrmnZRJqgUWhHUT0WhyJSxSf5Aa307x
 duqPi0oLgAshjZD8qe+NpijG1BGOa1CefyFimJSCZqDoj1iu+4y2D1lD3aXvifolWQQCTxilplE
 V6Npkp5wuItQQt+GhjHVkVeeMLdhPWRhWywOjkhvrWISx6Jyj5KNqlYwJ6hBQ5Vdpyl2R6YJQRK
 F+QGK/tFlJwDgUpTXpXiABQIAipvk094r/Aqto=
X-Received: by 2002:a05:6820:1799:b0:6aa:f8a1:8c6d with SMTP id
 006d021491bc7-6ac96c0ac38mr3777467eaf.39.1785353219535; 
 Wed, 29 Jul 2026 12:26:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d5f4f62sm3108315a34.12.2026.07.29.12.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 12:26:59 -0700 (PDT)
Message-ID: <22f6b659-af63-4e19-9764-ec87744bb694@baylibre.com>
Date: Wed, 29 Jul 2026 14:26:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] arm: dts: mt8188: add framebuffer and splash
 reserved-memory
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
 <20260728-add-genio-510-and-genio-700-hdmi-v1-11-ac54bd75f960@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-11-ac54bd75f960@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785353219; x=1785958019;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ezw7WNTV0ykeEUbS4cSKV2IRzBLwqronYAYhQ6uwo2w=;
 b=Jp/sQasz12I3Rudv8AF4dNx735yYt0GSnDmKRRRDqDL3vPy2PEQj9NIg8+Q+Pdvuud
 ruhir/hC16lDnnG9QHXq193M/PGA73PL+KWZKBHS//sykgtJZoaStSlZ3FlKymn7jGpL
 /+vXDhpqN0BHDNKXq+XgYs5pF4p+cgll7a6pxEkMlx8DYTpx+deut3ftmwTB8bWV1695
 5CIoQBAUkpO0bEI969Np9oW3nY5SGU60CXjpj1xprL1QJiyTH1e4ku0LNLRgq69PMz2h
 Ad3CNMEo+XUHvUMZhnGan91XqKeC088VpiZi+rSmW5u37P7EvWz14U5yDXDU0azAnghR
 EhKg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Jp/sQasz
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
> These regions are specific to U-Boot, so define them in
> mt8188-u-boot.dtsi. They are placed at 0x70000000 to stay clear of the
> reserved-memory pools declared by the boards using this SoC (the Genio
> EVKs reserve the range 0x60000000-0x61100000 for the ADSP and AFE DMA
> pools) and of the kernel load window (the Genio kernel FIT images load
> and decompress the kernel at 0x64000000).
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm/dts/mt8188-u-boot.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
> index fd1121a72cd..923e52522de 100644
> --- a/arch/arm/dts/mt8188-u-boot.dtsi
> +++ b/arch/arm/dts/mt8188-u-boot.dtsi
> @@ -5,6 +5,25 @@
>   */
>  
>  / {
> +	reserved-memory {
> +		/*
> +		 * Keep these regions clear of the board reserved-memory
> +		 * pools (the boards using this SoC reserve regions up to
> +		 * 0x61100000 for the adsp/afe DMA pools) and of the kernel
> +		 * load window: the kernel FIT images load and decompress
> +		 * the kernel at 0x64000000.
> +		 */
> +		splashscreen: memory@70000000 {
> +			reg = <0 0x70000000 0 0x02000000>;
> +			no-map;
> +		};
> +
> +		framebuffer: memory@72000000 {
> +			reg = <0 0x72000000 0 0x02000000>;
> +			no-map;
> +		};
> +	};
> +

I'm not sure everyone using mt8188 compatible chips will want/need this
reserved memory if they don't need the splashscreen. Maybe this is better
placed in mt8390-genio-common-u-boot.dtsi (following upstream dts naming
convention)?


>  	vdosys1_pipeline: vdosys1-pipeline {
>  		compatible = "mediatek,mt8188-vdosys1-pipeline";
>  		reg = <0 0x1c100000 0 0x1000>;
> 

