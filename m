Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75011D10F5B
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B0C84241;
	Wed, 26 Nov 2025 15:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iVFu7412";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28898423F; Wed, 26 Nov 2025 15:26:39 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B792D8423F
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso5104994f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764167197; x=1764771997; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZOntupVcfr3M8XmhEXE5gl8RdASq8d0R1kfmnOqm4AI=;
 b=iVFu7412nWrYivfYzTmcOVTe9cghZQQAFqHYngXRS5Y5y9bcZrF2V8CXg3aHDTFyqx
 fc6IKzOf0WbkSvYQNH4bIYjl4BIZ8FYmYKlBXqd8/MGr6AwGLfr79UhKLINpNMHo7OIw
 wevDLrUOhQpCgF25mcXmgcN+ZjClZCZ3JQsWJxP4PWi0S0a4Lsuz3xntODFKJ1eEpPDX
 dHd3WKWSTnZtcCIkUOCflwFcbvbJuVl0hT5rwMnKaq4wLf2m/WAtowryLeTvzkoekwQh
 YeB6hDCGHDBzI1VmC0vQUSjwBscCgzi1+NxVUtGL9lvVHbO2Vg+diy2m6getaWLaBcsj
 HGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764167197; x=1764771997;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOntupVcfr3M8XmhEXE5gl8RdASq8d0R1kfmnOqm4AI=;
 b=MzwuU3Qic/mwkxZ4WG+SLI+K+p+nU96tXpGcEaAjIOlibDZQ7/nYy/+X9C0tsJ4H4z
 G+wZRrLse/a8D9B1vpNxeSY7MiukDek02lFptSxV++oJlH5TeoF+MKCrRBsKVBg6P6vC
 7OOxExBWYmlq5uI3/izdg3VvLcIn8vPVGbuP2BT6eLKleOkTXWpcDOINz4yxvcn2Q80S
 wTQGc+knWfnjwQQXZ5jFQPhIVjIAmP7p2SuuB8+u8LHdK8gqCZ1fYzxN4If2veWqOYI4
 0C2HpFhUbNDy+gAHb+6tpP/D5nqM4YyC4mipzeJzqgD33jaPiYQIU76mhlgpa/U7aJ8G
 hvbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUNotRQm8ORua/N3bWsaad1mKw8VDC391/6OOxTZnr0yIY3N1970V9u5u55Wd0a6B+QAy8gRA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0F0s7RoarenGQC9coYoe4MdhYVjXKjVC11/fQWdgYhvMRQYC6
 njK1ZYwU9VGueE/mQjpEWoGooLmp1ELp84l6OjDZTNC5W6Y0FxxljKeTLssjTKaicpM=
X-Gm-Gg: ASbGncs5L+nJb0Wti+oYP4AJfDiI3P7t2EA0toOzaQS6Zstqs23nEEpZVnkOAnctVWu
 Mwe0LmS2EXahQ4+JjfgL3/DRDPV+s2EUER7mA9htZbnwF+rijvIV7RpGjGrHQPQByE9CC1QKK6L
 Qyl+w9gVovVnz3/OmPI282QdQKppMhJdZyAEYwuzbOCv3KPMJepgn5/R61A1jbJs01VZR+64E6v
 Wk5bcGDalGGu87f4EhoDbQRAuoczm0dfvGJ5kqI7wQv1GhO+sQt5gtl46///rDxiCqYSokFjdz3
 tp2qGkSzlvshKiXO+VrFkJXSV9EUL4alTa6IejfPb9Njsh8J9+q4CZNsyNT5TaYxBXK1N6RIHdv
 1OsrefCYajGa0+1APPgs9Z58HW1R6YUpS6CS5lTWhX5YkpxynVZQN/9f+cuiz14XSBAcqir1ZXW
 XlUmMQB6UKmwQzSPzLhKMLjw6o1mry4wi9F0A2pt9Xh5h4oHLIRkgl
X-Google-Smtp-Source: AGHT+IH6i5HJUFX0fT5t73VuW5beQ9alD8w9rLkOQ9yWyDLGrm8bRfakNskP+tP+fnnxo4Ff2CxMjw==
X-Received: by 2002:a05:6000:1846:b0:42b:5628:f4a3 with SMTP id
 ffacd0b85a97d-42cc1cd8f11mr22110898f8f.1.1764167197017; 
 Wed, 26 Nov 2025 06:26:37 -0800 (PST)
Received: from [192.168.1.36] (p549d4195.dip0.t-ipconnect.de. [84.157.65.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm41029627f8f.36.2025.11.26.06.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:26:36 -0800 (PST)
Message-ID: <bc4f1b0e-36b5-4cf1-a6f4-4f595db40ced@linaro.org>
Date: Wed, 26 Nov 2025 15:26:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY
 clocks
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-6-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251124155503.2839766-6-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Balaji,

On 24/11/2025 16:55, Balaji Selvanathan wrote:
> Override the USB QMP PHY clock properties to use only GCC clocks
> supported in U-Boot, removing the unsupported RPMH_CXO_CLK from
> the qcs6490-rb3gen2's device tree.

That clock should be handled by the stub clock driver, are you seeing an
error without this patch (with CONFIG_CLK_STUB=y)?


> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> index 50674b692ed..14669b50821 100644
> --- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> +++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> @@ -22,6 +22,14 @@
>  	/delete-property/ usb-role-switch;
>  };
>  
> +&usb_1_qmpphy {
> +	clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +		 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +		 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +	clock-names = "aux",
> +		      "com_aux",
> +		      "usb3_pipe";
> +};
>  // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
>  // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
>  // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000

-- 
// Casey (she/her)

