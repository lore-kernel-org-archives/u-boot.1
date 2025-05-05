Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B8DC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19F48091A;
	Mon,  5 May 2025 08:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427791;
	bh=esUMX8pcryOyQRukA8i6LgrFs++JaXyTuUrYkRGFAeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=go4QwmYVVU8VAg/k56UeWDNrXb6we2aEW2TTSUDahZL46Uk5rQ9qtGINrSgL7yg/5
	 AsZWozw7DwSuJ5Ak9yZATOt4Dij1wD1TWmz4o+mFZVZr+C4HtWhA/nYsS2R78uEx7J
	 niuNN3l+t3WmqPNpvNP1DK5JFiOtn+ZhRNLKG/DeVKoQjboa8FIzC92Dc4VvofIvQz
	 LPKJXYmB6soIKc6lU9ct+qZZVetBBk56D79rpJVPttWPcSB6ymt6ZPRh7L5uQOWpTL
	 /Ce4V17JBpIcm6Cq10bdx3WglcbQdiyxTKTN+xSCNonvUDCSSBe9DZXnfZulaCoL3L
	 OHIoJgLverGjg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026A880BAE; Mon,  5 May 2025 08:49:51 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD88805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZrXFk64Lgz9tR0;
 Mon,  5 May 2025 08:49:46 +0200 (CEST)
Message-ID: <99a32527-57c8-41e4-b1da-214bb72e5d3f@denx.de>
Date: Mon, 5 May 2025 08:49:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 6/6] ARM: dts: at91: sam9x60-curiosity: Enable watchdog
 node
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-6-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-6-bb7d1c7c051a@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 28.04.25 11:16, Zixun LI wrote:
> Enable watchdog node on SAM9X60-Curiosity board.
> 
> A default timeout of 16s is added which is the maximum supported value,
> also matching Linux driver's behavior.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi | 4 ++++
>   arch/arm/dts/at91-sam9x60_curiosity.dts         | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> index dd4623311c9df6004c1715d406d3873bbcc254b5..9144387861eca5ab14b756063b89866d280d7dea 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> +++ b/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi
> @@ -95,3 +95,7 @@
>   &slow_xtal {
>   	bootph-all;
>   };
> +
> +&watchdog {
> +	timeout-sec = <16>;
> +};
> diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
> index 1c7f0fa6a49004943e5a4ac6637db5e806cc92f3..f165fdadb9e4abd08f9166e7cbec0507616c9939 100644
> --- a/arch/arm/dts/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
> @@ -336,3 +336,7 @@
>   &usb2 {
>   	status = "okay";
>   };
> +
> +&watchdog {
> +	status = "okay";
> +};
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

