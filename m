Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C5FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 20:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DC71882DD;
	Thu,  2 May 2024 22:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oGnsWYq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE25882AE; Thu,  2 May 2024 22:01:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CC188313
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 22:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d175=MG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714680053;
 bh=npmPRTYMC/6/YvMWNRFJM84L1BcfU4k8YzIjIN57tlU=;
 b=oGnsWYq6+PwyE8x2De1rEALNNvtVdoKbVwPbWZW8MaB74rh3dsw18CTCA2RzN09gxYqpQ4VgG
 XusP2Rt/4qXgLIhF8H4xsh15Uu83ksI1z8RhGsxpKL42P/+Qhap4oGmIJe+ttrJ9ONFdjNbitTh
 ip0bcgT81Xy4WByiZveAlR+KxCHlwpkm2QdGCk7NYf6TvAiL6p1x1VwMCZlH6PeJKbVk54M7tVw
 jW6opBg4JrttcM5V9vrdHpEd8Fu5FMBGS9LFTPLlahBDwjwIkQ1lVF4A9DlLbMAo97YRdWHtx9S
 MkpKRQcR4Jd4YJSiEhA6LUMZ40TdC7MsKn2v0KfDSDXg==
Message-ID: <ff2f5c65-2f86-4ac5-866a-afbee5a05c98@kwiboo.se>
Date: Thu, 2 May 2024 22:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: rgxx3: Use sdmmc0 as first device
To: Chris Morgan <macroalpha82@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>
Cc: dsimic@manjaro.org, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, u-boot@lists.denx.de
References: <20240502193410.1080938-1-macroalpha82@gmail.com>
 <20240502193410.1080938-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240502193410.1080938-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6633f0f3fc25b563c159cbf5
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

Hi Chris,

On 2024-05-02 21:34, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Some of the rgxx3 devices do not have a way to recover from a poor
> flash of a bootloader to eMMC. Set the device to always attempt to boot
> from sdmmc0 first which ensures that we can override the boot from
> emmc if we have a card present with a valid U-Boot stage.

I would expect that after [1] was merged in v2024.07-rc1 the likelihood
of booting a bad/poor flash (where FIT checksum is invalid) have been
mitigated and the boot process now fall back to loading FIT from SD-card?

Or is it to protect against flashing a FIT containing a non working
U-Boot proper that this tries to protect against?

Also sdmmc1 seem to be missing from SPL control FDT so that could also
impact fallback logic in SPL. Following nodes should be added to
rk3566-anbernic-rgxx3-u-boot.dtsi:

&sdmmc1 {
	bootph-pre-ram;
	bootph-some-ram;
};

&sdmmc1_bus4 {
	bootph-pre-ram;
	bootph-some-ram;
};

&sdmmc1_clk {
	bootph-pre-ram;
	bootph-some-ram;
};

&sdmmc1_cmd {
	bootph-pre-ram;
	bootph-some-ram;
};

&sdmmc1_det {
	bootph-pre-ram;
	bootph-some-ram;
};

[1] https://source.denx.de/u-boot/u-boot/-/commit/61177bead95d366d3155722eb52db8077829579c

Regards,
Jonas

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> index 793ed4ae8a..18f540a3a2 100644
> --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> @@ -4,7 +4,7 @@
>  
>  / {
>  	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
> +		u-boot,spl-boot-order = &sdmmc0, &sdmmc1, &sdhci;
>  	};
>  };
>  

