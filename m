Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84289C44520
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 00:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB3BC406D4;
	Tue, 21 Jul 2026 00:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjF1M1pDEP8o; Tue, 21 Jul 2026 00:01:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08239406CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784592082;
	bh=HDaAmIODc1Gg3cJwiPwNQSDlRmWLhy0761zBKp0eVuM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PhRNP3PAgqlM9LLRnwkni9HEsUhBLWx2vDF4VucGhH9HcaZ7ZO1SNFiSMG0T6Wj2Z
	 vP8MSf4Clpe5lmukku+AfCn7WNcKz7oTB2KVgFdNeyCA8CxM/GRJSTy0FWIp7qJH5y
	 4s/lzdnSLimjbgDIk6m3s9aFFaWl3SRHT6pgWPFPGo9s0p8o+bQ4OaH7GSRIb4zE/m
	 g/ZaHASgZ+9XT18AYb1E2vTLkPX/xs68YciqFjf6fNOtSsvqcGctPVY3nrZnTjxUqy
	 njGEwfcIidVuhpLExrsvYCaPXPxVJyre0O1RFSJpcXCP8LKfJaLnmSOcf5XVoIrzoZ
	 3bzjGi+O5NRoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08239406CD;
	Tue, 21 Jul 2026 00:01:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AE37313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4BD9400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 19A12-NOP9UC for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 00:01:20 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2D270400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D270400A5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D270400A5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 00:01:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6799483E76; Tue, 21 Jul 2026 02:01:16 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F2982991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 02:01:13 +0200 (CEST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-451d8064238so6505715fac.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 17:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784592072; x=1785196872;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HDaAmIODc1Gg3cJwiPwNQSDlRmWLhy0761zBKp0eVuM=;
 b=I/6OETXfMw7PdMduTUhFSMB7HOAsOflbnUCjNaoGlDGlFBYdrQJHkf5WXfviO4LDrv
 KdmwjJnsY3SfcVJI3MLKSrPoMgFORYlmu6Y1sN9+9bPr2y1tlQ8/pWIXpVs2SaPRoteX
 FFM4NzRUNFoU4bCxft58G8WYhMqrX3coWGsG8P7DMstzZz/G7hQCPAIzU3TzCe2H5+pY
 OAFRbZhIVx3xfG3RV0YaaJlWjUmJj+U22wtC+NYyEw9A/1NJOeNmUB4gv2jpDn6z/2mP
 E4o3XPTw/YWVjDunEXzJEIcZQfu3LvjhBeAPrnIq06MrEFgZMpl6gCokyZUGbEAyHvKz
 9/TA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2ixvUerfFga0CTZwNRr3Zvg1Jj3W44xjE9zKeWpWmnawXXERLymRQEcV9M+QFsQxgYXEqft4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp6rMs/3cufaIDYphjrEdQ6NC0IuIkpGSJE8QRd552bHq2rXYz
 5DDrmti0vMKPty7L26Z7+X8Zzcsb7uk8u8Gl6W3XfOrrbeb1WZvGjaYKvUESOSYnmEw=
X-Gm-Gg: AfdE7cljt6XH8ZJzYUKbRxp3KQmN7l5sghEHD8GPcN/OYnncUxNJG+K0Yu0rtbJue8x
 PTxjGWjJmzb3SwBFopieTsns/cUwMlOTLIyHMpFso5m+QoGqkY3JrYO5qMTRvs17WrR/OAKM51t
 /HZHCF1C6e/N28Y/8cfVyq2svmWUAvNhx66eiYSIz/VNyYIqmAmMl+x0CtqtuV6spEjCTxCWTLb
 Y4pD9HaS6LafHcXILDfVGipfN+vcnuSw9n8bFCr7begcy2uobVn659r+FxjcETgZcyZIKjBabHn
 vgCPznOJyN5Lq8+GOfzjfVjQpU8TQGxP8GT9gmvzjFMijKhvqowcHWpS6vvdVZExOdE5tf2Frn2
 eJXNsEIiAkm57AvDZsLgrO7N18O+TKTyx8flZQ7klXJxGfDR8tWtHQJKeqFuBIiHg2ZEPNVbGXO
 uPi4BsdvuhmQNeIDeevWs2U/sHuYcqyvi1+RIbccRnHDgeeabni4xH
X-Received: by 2002:a05:6808:c40c:b0:497:9df0:a1f with SMTP id
 5614622812f47-4a4d032169cmr11706363b6e.14.1784592072211; 
 Mon, 20 Jul 2026 17:01:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3aabaf5sm8376489b6e.6.2026.07.20.17.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 17:01:10 -0700 (PDT)
Message-ID: <aad6a791-7884-4e58-9b27-80d643f9525a@baylibre.com>
Date: Mon, 20 Jul 2026 19:01:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: mediatek: prepare Genio 700 devices for SPL
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com>
 <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260718-ccaione-upstream-mt8390-spl-v1-1-1256b6dfda3f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784592072; x=1785196872; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HDaAmIODc1Gg3cJwiPwNQSDlRmWLhy0761zBKp0eVuM=;
 b=DvkhgENyXhUsgQcRTk2v48vsqOISIGdoE0Hf8Hfi9+29zwvpX/fjaX0yx8oEHDvAAk
 29SA0a4PymqWv1+4cNi3dMQ/JetGK36iLrUM07/Ha0UcA1U/1ypATk5k3S11OEUq9lrn
 HV0TgeYhmA1V/5f0w4ptfZLJE1EGyaqCg8wU1f/XQMM/OzGZr6wLF6KcQVmUEgqZxY/k
 tt1UzTisiBAW4Ka7T65tuRtSWliZjqln2DMyaKD6562unUMAYbKZ80vR9Lnos8QH+WxZ
 CPp3Oiyr0uNZcLm/C+gqxY9rSSBfsWnCyQI6Na/kIEEwIYHHWEqrxfBdurvkQsKZhJOo
 acYQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DvkhgENy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="DvkhgENy"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/18/26 11:16 AM, Carlo Caione wrote:
> The Genio 700 boot flow enters U-Boot SPL after an external DDR loader
> has initialized DRAM. SPL then needs the debug UART and eMMC controller,
> together with their clock, syscon, pinctrl and watchdog providers, to
> load the firmware FIT.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  arch/arm/dts/mt8188-u-boot.dtsi               | 40 ++++++++++++++++++
>  arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 58 +++++++++++++++++++++++++++
>  board/mediatek/MAINTAINERS                    |  2 +
>  3 files changed, 100 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
> index 6d1b2ab82da..131377d9a97 100644
> --- a/arch/arm/dts/mt8188-u-boot.dtsi
> +++ b/arch/arm/dts/mt8188-u-boot.dtsi
> @@ -8,3 +8,43 @@
>  	compatible = "mediatek,mt8188-tphy", "mediatek,generic-tphy-v3",
>  		     "mediatek,generic-tphy-v2";
>  };
> +
> +&clk26m {
> +	bootph-pre-ram;
> +};
> +
> +&gic {
> +	bootph-pre-ram;
> +};
> +
> +&topckgen {
> +	bootph-pre-ram;
> +};
> +
> +&infracfg_ao {
> +	bootph-pre-ram;
> +};
> +
> +&pio {
> +	bootph-pre-ram;
> +};
> +
> +&watchdog {
> +	bootph-pre-ram;
> +};
> +
> +&apmixedsys {
> +	bootph-pre-ram;
> +};
> +
> +&uart0 {
> +	bootph-pre-ram;
> +};
> +
> +&pericfg_ao {
> +	bootph-pre-ram;
> +};
> +
> +&mmc0 {
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> new file mode 100644
> index 00000000000..ace9944ec41
> --- /dev/null
> +++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024, 2026 Baylibre SAS.
> + * Author: Julien Masson <jmasson@baylibre.com>
> + * Author: Carlo Caione <ccaione@baylibre.com>
> + */
> +
> +#include "mt8188-u-boot.dtsi"
> +
> +/ {
> +	memory@40000000 {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&mmc0_default_pins {
> +	bootph-pre-ram;
> +
> +	pins-clk {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-cmd-dat {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-rst {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&mmc0_uhs_pins {
> +	bootph-pre-ram;
> +
> +	pins-clk {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-cmd-dat {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-ds {
> +		bootph-pre-ram;
> +	};
> +
> +	pins-rst {
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&uart0_pins {
> +	bootph-pre-ram;
> +
> +	pins {
> +		bootph-pre-ram;
> +	};
> +};

Is there a plan to change these upstream so that we don't have to carry
this forever?

> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> index 37ca35b4dd4..efd38d52338 100644
> --- a/board/mediatek/MAINTAINERS
> +++ b/board/mediatek/MAINTAINERS
> @@ -21,6 +21,8 @@ MT8188/MT8370/MT8390
>  M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
>  M:	Julien Stephan <jstephan@baylibre.com>
>  S:	Maintained
> +F:	arch/arm/dts/mt8188-u-boot.dtsi
> +F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
>  F:	configs/mt8188.config
>  F:	configs/mt8370_genio_510_evk_defconfig
>  F:	configs/mt8390_genio_700_evk_defconfig
> 

