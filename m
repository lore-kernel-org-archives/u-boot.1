Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F0606A333
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hlE9gzj1;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EhG1hJ37
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B5DB605DA;
	Thu, 19 Nov 2026 21:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKqGGhSf3tlt; Thu, 19 Nov 2026 21:14:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DA3B60658
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795122870;
	b=bcA29AB+YiMBJ09TmKaTcslvtO9peV05e6M8O2U0izg9SWAuqF059ibaWHd+Ve1gtJgZ
	 IM5VkM5OCYOUaCM2lL+Dl9bOuIM8rM9rAkAlF1Tylm2VrMSIRGbSfkg5gmd8bH2ukXudl
	 sIDxENvAzGY2EJmNIiofsP5W/XVAvIZK/aWGRANAatzyJD3bX9Oexq/U9ftPXUuXwryTy
	 /peHQt85bt83rX2BQWDO20zDbypXqVOq7Mqb7ZqL//1TvyIzd8ggcT8WlcNhqUflNX+9Y
	 lQ/HjjdFUsLr4+/QAB+Ufjb62qPcYiiWboIDIgdu2BtkHbYSo26gPF72dT3OE1YkcRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795122870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gWUnnlVRJ0qEiVSTRRCYad6+zdcz8Z6qIUb1GM+bPj0=;
	b=iaTICz6ZeOyER4c+jQ/nT1T07V8ejb592lETz63l5zyVWMJtuxJukbo1Ipf5a4CFx25h
	 eNUnMq9R4fhbOAtbmXPJybIPVpn0WX+jZBFXR4hz7IkeNzvZ4L+ianDgLH/x2gTRGtywa
	 bUvvSukXlDXrxHoYvn3paraoCy4kgOjaq3lJy0EyoxaAxFv8Rl8DCRud0uER0i1P7JAyp
	 zeQdXnZ69xyYLlRKOIGmGQbCG4dkUqBwh6rMXdGSoC5Jnnsl6kBoetPuDEXCNrAZ1Li2J
	 eRxU+zsTAUsIx2MnIKgTy73ZlfNNOkErQ+vzFmjzTLMe4KlXt+BxabtfdXVTGe0gwQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795122870;
	bh=gWUnnlVRJ0qEiVSTRRCYad6+zdcz8Z6qIUb1GM+bPj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hlE9gzj1y7nQq+8wphxTgHX2ZGgUpWEFcXHYtu2bKynQ+RnxRxJwwR+KFiLUkn4em
	 FLjkwRa9T6LhiwfWmirn7J7FvXkfy7Ap45bg4I4hjVrUAV8NhpdOBMBCAipiExgFzG
	 wiBkqVZXgXMcAMMoeIxSvklAuRUychmxBJor08jqpzrGt1YrEey5srSMi7PH4TmItE
	 sxg6Qe1RuEj3aXLvRrZoOyxj+MBUWuYmKGaz06hUr+IgFUCC2JKlUl0Le7gA/E7tXT
	 2brQEiJfjrXk8A0cDdCit7Iq1S2lLZ0Pda7MwkVQoBH3WBkAYQpukrZ9tLz6Wdolp3
	 nNZtGMIcUeDdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DA3B60658;
	Thu, 19 Nov 2026 21:14:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBC8A79D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C24C540B04
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwRTKyys4x_D for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:14:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E70040A6C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EhG1hJ37
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E70040A6C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:14:27 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4a77761ff8aso163428fac.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795122866; x=1795727666;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gWUnnlVRJ0qEiVSTRRCYad6+zdcz8Z6qIUb1GM+bPj0=;
 b=EhG1hJ374D6P/y21nBLAogaeqvZlfTmvgyw7wkAt6leOun+MIk0gKZAUADtaDxpHEc
 oIblAcDDcAn5eFCHdYHybR7ksDYPTy92wCnYEa6d/D9uXdqfLl8pb+R57key0HlrhGIB
 cX+IbOcKlZmgfBoFwEMPuFAx5yB0pO9xNFi8/LaTReQiEIjEwFdI2j/PFsGbVN5ZGewL
 VOlo0VXDgaAKUeRJzLhC9yCkGQWJa4huUeqWzEEwJCRCUxp8Apql3dfaZLIrSSPGbeOr
 +GV9jlY3dU1gPnyiuiCqwuscmQuvdovpx/psJI+y+uRXUnRID/tvo/DkdPXZ7dzwkDwX
 vLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795122866; x=1795727666;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gWUnnlVRJ0qEiVSTRRCYad6+zdcz8Z6qIUb1GM+bPj0=;
 b=cabWrUX1s3HBLHoapiK4z4L5x9XHHQJ2Z6tbGfzZnrKJ7LYxqArTzDQL5cQcf02Kcm
 HX5/dCDBm2rzUF+j7IBuQ9olxAW9KSJGU0kLHjtYPoUFj9LxAB1ePo3mccCijesMW6oC
 FZ5sZtsdGy5eCPNwFVJwrLo1YaUgpDA6hxxQErSC10JmCqTTQh6/VGa7VVhqu19LymIr
 xM43MM6pAKaGxnWgD7wrIGDyNyjLlu8qEaqRt4vd1qMG5ggNmgnVOz4U35Zg8YSY35ZN
 sO4gjW/wvgNk4lLzQvsUSU9Z3k+4/uDpSvupS6I2BSl2Y47aXVAN39DzV/npxiuBJj2D
 5FWw==
X-Forwarded-Encrypted: i=1;
 AL+hErFuwL35BmQw7AE60A8nKKgXtJGSA0qD/fae3tMijOIN7Z+dxpX0T4yF3IKGl5Vqlhj31rwLjiY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9UM1mE5bsNY0RkFBb6eLqN0PUTt9ZLJ71RHFFij4pejyZja3nQ
 1BxZ2n0W9GMCosoh73a1BIL3djulpXsUOPeZORnouW9UAzTW8UgEqVMna6BwFReBysA=
X-Gm-Gg: AYBFou0OCY4H3IKfptV1oJNOgd5cAkVdUNJ+7dzeaHpIe1IvF8z4tP2q0H1vXG4Ipll
 FrjOeH6P/sZWsuZ8ddelUW93QKA0GzzF4vAnsS1a8ERGJRvNL7f1J8ha3DRZBYWM+VAlY1zuT/C
 yDiDwzSkldvvdiadiNpu8TZfaLLEI+li5iNBN0e3fktjKJos72Jkop9F347YnGpNAK48R9cPdOu
 8CT1oe847sTQab01AO+IvK2nQBQlgTC0etYxqO/FTlLBnjgkuflnpXOa3ST4IIAkoHb1WzuZPtH
 k+luT63Esz/toRPe2SLmITzlvllr29yQj7Aw2TaURATUuJxQihPK239C4DmgFDXYtB7FciPxVNY
 9UfKNEk9rFst6rveGjX8SaNb3lgolFIhthn4tq4KPP+rw+47exkxguCY00DETufoG412bnx4PEh
 TdpIFhlAEuza7QRcueW1eYjGcrSWhN85P9sbUSZWPMPAVcJrfo6tWNS8cbUuagfHgTu8xZaSCWS
 nQQF2G04k0nOqGhK2dslzLHDxxnsAzDvae0HU9kPkvM6NPwuYQUNrK5Sm5oH9yQQB8pi8CJbHel
 dwITUqhGsu4e5Iz7EskBkkgQ7095iJN+0Fi4i5jzKw1ztikHqrohrs4O2FnREr1dWTWFCsPbBNq
 ARN8=
X-Received: by 2002:a05:6870:6111:b0:494:c04a:1a6a with SMTP id
 586e51a60fabf-4bc85308abcmr958319fac.55.1795122866000; 
 Thu, 19 Nov 2026 13:14:26 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:43e1:bc37:7497:58db?
 ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm901569fac.12.2026.11.19.13.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 13:14:25 -0800 (PST)
Message-ID: <93e75e61-0ffd-4c1e-a6e0-1810348b0c19@baylibre.com>
Date: Thu, 19 Nov 2026 15:14:24 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm: dts: mt8189: describe the I2C controllers and
 wrapper clocks
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@nabladev.com>, Macpaul Lin
 <macpaul.lin@mediatek.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
 <20261118-ccaione-upstream-mtk-g720-i2c-v1-6-916dd6cc8d1a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261118-ccaione-upstream-mtk-g720-i2c-v1-6-916dd6cc8d1a@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 2:29 PM, Carlo Caione wrote:
> Describe all nine I2C controllers and their four clock providers.
> Leave the buses disabled so each board can enable the ones it uses.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8189.dtsi | 141 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
> index ce4c32c46b..33b717f6fe 100644
> --- a/arch/arm/dts/mt8189.dtsi
> +++ b/arch/arm/dts/mt8189.dtsi
> @@ -450,6 +450,147 @@
>  			#reset-cells = <1>;
>  		};
>  
> +		imp_iic_wrap_ws: clock-controller@11b21000 {
> +			compatible = "mediatek,mt8189-iic-wrap";

As in the reply to the clock driver patch, these compatibles need to be
changed to the upstream binding.

> +			reg = <0 0x11b21000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imp_iic_wrap_e: clock-controller@11c22000 {
> +			compatible = "mediatek,mt8189-iic-wrap";
> +			reg = <0 0x11c22000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imp_iic_wrap_s: clock-controller@11d74000 {
> +			compatible = "mediatek,mt8189-iic-wrap";
> +			reg = <0 0x11d74000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imp_iic_wrap_en: clock-controller@11f32000 {
> +			compatible = "mediatek,mt8189-iic-wrap";
> +			reg = <0 0x11f32000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		i2c0: i2c@11c20000 {
> +			compatible = "mediatek,mt8188-i2c";

These don't match upstream binding either.

			compatible =  "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";

> +			reg = <0 0x11c20000 0 0x1000>,
> +			      <0 0x11300200 0 0x80>;
> +			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&imp_iic_wrap_e CLK_IMPE_I2C0>,
> +				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
> +			clock-names = "main", "dma";

			clock-div = <1>;

Bindings say clock-div is required.

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
