Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SWEcU8ZX;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JfLALD5T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D8BE40623;
	Mon, 26 Oct 2026 09:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hB33oEAImxEe; Mon, 26 Oct 2026 09:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5670F40611
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007413;
	b=RvgbHxhBEa5sfJDXeDGL2UPUWfySqJAYKYL2bzZWV7gpU1soYjHtvYtW/2bHJBS8QNXc
	 6JmSAuwcMEHUObmCn9O8LamZyxsvuzVrewwzjNe0E/lmp6Rbpwyggp81yzxVlNhQzR//o
	 Aga7LUDVv1TJFHswjteEVLHWVFEL3xmqV8F+aG/Px131/6wRRIzlCUIzWx6HaaLXkqCKk
	 n8tD0A8nec3dZoNcJAF88P8jHwEV7LM3d2p09CLUn7Sjp3wruBlInaaQHMbJd+y2/LoNY
	 5UEkdgbvP5BM9Q6FKrtt/rL5mWeAGXlehygWvy56jsFwGporCTW4nNlS3mySUb4wt7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=15j7M3+g30HD5uj0Rb0yjjLkYc3OqF9uOmokws7gESU=;
	b=iwdZO/m4reMEw1NuLwWRv53Jy6HwUQ9UXqvRDShUuPfxvyv8GWLyCdFYD5xJni66VqtL
	 sxr+Blu2MRrYtU4bjyIyHlmGlNNn9gopQt0FgozVpGFvPjYfpWOQOAH0FvWSqvArNk9Fs
	 QglfrUh2sD9slb1HyZNIGYCeaiS8FDXCE1KtCk6PgdO+wBn42UzPTlG97Ukth3SSkW8K+
	 mPgLCpOJWRXS77ZEmDOBVYE+sacZ6CfoxOgyFYMhyuHEseIqiqibW6iuwwyxFvyCFrk0L
	 OSvMcMSWGJFX7WhrGOFjclyYj2C6MoXDJg27Vpym2tFeK3kmL0pTex4ruSwj8VUaWNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007413;
	bh=15j7M3+g30HD5uj0Rb0yjjLkYc3OqF9uOmokws7gESU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWEcU8ZXqhY79Tii71vFwRiiWU0Az8MG0TRa5obU6HhWrXQjpF+JROpAi1KV2H8d1
	 WcSFpciAAxxfURKETLERPXr4ELsErAeJJZ3snTYVhuJXGBgie/2CC+oRqlIgCbZyob
	 PhJjHHfbHrDFC2+KyLvYp0KLJ+nAfeZPZR3b2UUJH+0Lft23aTHz0F2bQAXPH/A1KN
	 /YWFWz8AeNf/0k24/xdzhvZMOZkOCMDPFhPkuq6ApOSAJ/TMEkrIlUtX156Iw2KEgz
	 adOw0lE4khnLgGpBDhevHgePvJS9JK25RS/LLBmpALoxwux784U5hFb3W8Mlvyn/zv
	 4ha5XLmM3MzWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5670F40611;
	Mon, 26 Oct 2026 09:36:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79D9F3B6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B1E54004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBqpBcNKtyfN for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:36:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 69B1240049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007410;
 b=tgOOEMd93MUNKiAycEzSjAjMItBwouZKehHr9j0rF6lXKITfxC0cUFB3kE59KzdBxJAR
 VjbKY88DVTPfRuc5RR7oGLP7cVOM9OGrLQmAV6rOysloIL2sv5wws2Pncv6zpi26R/W86
 Ca8Iq477eYhFyn14LQ9/eqp2zyrjCPBcIbaLBLfsrBza8brUi+LDHARL00EI0gIkWSQgh
 gIkAbyXdscNb5iZ0DLJhbSwHs/t6HBZUyfDgtF04zfPZHUpKICcT+XzYAOpkaokVBWDK9
 vM75AFelmyKVecHrgJTpOxiPKd9+/XnreyPEnvG3MSIBJ1zIw3K0n4/nGUg0b9hG39Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=15j7M3+g30HD5uj0Rb0yjjLkYc3OqF9uOmokws7gESU=;
 b=PUyR6l8sodO0f+5ejpDYakBQ41gTw/5f/nidCJP1qWW01VzovpVL8xh6Hi2XzVKkyxX4
 7Wih7QfDo5ze6JhZYUvcSf3ls3CbFrR42moWCALkUqVv0vkTf5mwlvfnELBJNfPI3STHF
 avcMjRjemXuI3W22rLG5N4pmONzH9EUdLYJ+pSvuXTYIjQSIwq6LS7BTRlEHHjT6CuZ/P
 zbMcFjY4rZiRTGx93RpnlPFkLNq/2TJYnfq5SHo+ZmseNNAHWemp/8IdX8ePiu+/a9a2C
 UX9R1Qw8QbE3HGSdIsgs7JHKt+FueAe5VDVIZvFTowDgu9bHCGxBa8HR2301rYdOW+Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JfLALD5T; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JfLALD5T
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69B1240049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:36:49 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1189419f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007408; x=1793612208;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=15j7M3+g30HD5uj0Rb0yjjLkYc3OqF9uOmokws7gESU=;
 b=JfLALD5TFV22aKxE9UFyQliJDxOuIn6wh2xo1fKUxSjt6Q5x6R/Upo5q8IxzR0K4Do
 2G0Aw3ccZWsSMSiPaCtruWMMSSV2cuhFSFzzaCWkB8NCXcSFzaAN/OaGUg2J+P+3ZG85
 yFSqeCScUmCtDRg9PiqSuzCsF0t0w/B5+WgCkMIj7ylLwUSEKO2KsYQWDJF3O6V9x/WF
 MlWrpbKiYqVPN9mz/ZoMo9BE8U752WlpJqIzlqBQXh7a1jFVaUPA3+8FC/5MUf06J8LA
 npfYD1KYncNcgcX1NvIUhYCzs5P1Fj1ZJ7VZFbkOHfqDuZS33uNxDPJT6DpNdMMH+IQB
 Gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007408; x=1793612208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15j7M3+g30HD5uj0Rb0yjjLkYc3OqF9uOmokws7gESU=;
 b=DVQaBO5y2wnZMp2hRKrLNaxhdk/DDBKObq9Euv93jWOCoq1SVIWf2Ruj6SmtrXbeoF
 DWFEnLroeuuX7q0NwyBDa1BoLV9kxQdYNq+i1Z+i16awT1nFVOi3Voo2rLGz00Kgh85W
 3rd8DQJk8RBSJ1WffeHHeVwN/CQNgj2VerpN0vZTXl1B3k54jXc+/V9+PooPYNsfmbod
 TTvKLof/U31pll/PQjWAmcGRzJGKdxqwsRo3ljzEKrKVN/8ICAuy4OowSVyxkgKu4j4O
 GqnbAZsYeHafcYiCBRmEkrJcoF9NWvDg9jdAcFdixLI96ucTmYiMo7ZCZ9J3ida8veUD
 GteA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzV4zI7cqr4eoJXirT6hvr311nwmlLls2KMxFGT59SRYLf8zZHM47s0aqpsbP2giYB7gSzm2q4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJxI8unKLHx+pgqyZo6ClFgZBpQ9DmtzOW8vNjsQqctxXb+/tMN
 W9EnoraVUbnXinjJQFDQrlsU3yMOXQrYxu8XSuhTSddeZoHNilyHZnw0+6jLyNXUUbw=
X-Gm-Gg: AYBFou1fswJH78z3tTxKl0F8erMJXuU3efGquqtzQb/FjWHfMBr4NO0vgZthKCs+0LF
 qK9dGaCg/Xk4XsMWvYlVyjPiJPL5HnWVYeTkg5G+zclzgK9IE3gQDuP/HNL8/dpfUHsKsr40lp7
 TXmN086nTUoYsssD7HxqIRl3mdW8AN+t0p9sZeql4spPuCaQhnOE2F8/GhOA7Dgfq7UOWtzglsz
 ttIZtaxEWNWhVIHeEBmdfRwU6meXnM38xae6iIRxg58aJVALLOczEhFFCwkyDbFNFkGDOzS8y9Q
 jfiH+QGUCpgUgKhup3ffXiBY3eovtN2AZt4ZzxP6Lnvxdf24894hmBd4uv8EnMOJjY2j5MMWO+/
 9dZ0Wl4r5/bf6WBrQmdWqIK6ILAgB2m8VLdK3xdeZogU3aS9ZcgPEGL8W/9e6wcIHUVFbuphTEj
 hGiV4KRWwrrUcywPpM4l4gfVDUWSbyHifV4u1Qussd/ngjjhv1d+puyrnmNs3V6aQprxqT/7P3C
 VspnA2yimjhB9YKgX86S34rT4ssdmbHjH8aSzK1mUF7DxsHzA4SRgSru0bKBMwPRCLToqecbkSL
 Dv1GgGHhKidN+dpU/9mxwWTpn+gpWxGI31krcDqzXPSTW2EW4AzBpxJF3mfZxf06g9MajSdj
X-Received: by 2002:adf:e007:0:10b0:48e:84b:e83e with SMTP id
 ffacd0b85a97d-48e3eb2bca4mr7557328f8f.1.1793007408133; 
 Mon, 26 Oct 2026 02:36:48 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f305sm14248333f8f.3.2026.10.26.02.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:36:47 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:36:46 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 4/7] arm: dts: mediatek: prepare Genio 520 and 720
 devices for SPL
Message-ID: <at8fJe03mcyuCSUS@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-4-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-4-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:10 +0100, David Lechner wrote:
> Mark the debug UART, the eMMC controller and their clock and pinctrl
> providers for SPL, so that SPL can load the firmware FIT after an
> external DDR loader has initialized DRAM. Also mark the watchdog, which
> SPL uses to reset the board.
> 
> The MT8189 peripheral gates in pericfg_ao are parented by topckgen, whose
> muxes are in turn parented by apmixedsys, so all three clock controllers
> are needed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 81 ++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
> index b7a0c0a82a7..70c538a690e 100644
> --- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
> +++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
> @@ -26,3 +26,84 @@
>  	regulator-max-microvolt = <3000000>;
>  	regulator-always-on;
>  };
> +
> +&clk26m {
> +	bootph-pre-ram;
> +};
> +
> +&gic {
> +	/* Retain the eMMC interrupt parent even though SPL uses polling. */
> +	bootph-pre-ram;
> +};
> +
> +&apmixedsys_clk {
> +	bootph-pre-ram;
> +};
> +
> +&topckgen_clk {
> +	bootph-pre-ram;
> +};
> +
> +&pericfg_ao_clk {
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
> +&uart0 {
> +	bootph-pre-ram;
> +};
> +
> +&mmc0 {
> +	bootph-pre-ram;
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
> 
> -- 
> 2.53.0
> 
