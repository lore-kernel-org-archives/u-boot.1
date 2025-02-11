Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA9CC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FA35800B3;
	Tue, 11 Feb 2025 12:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="p+KhDclP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84BC8043C; Tue, 11 Feb 2025 12:38:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B79D80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cbf1=VC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739273881;
 bh=pPS3wuk6UxBYzx0fYwOcO//apncAkZHs/RcFOK/RxxU=;
 b=p+KhDclP2rYUQ/mvzBBkagGWOTQsNJfn+0qih+onwQZpa577bzWlLJgpH2udDiaUUr8s1PXKd
 hZwIAIz5EM1MEuMn/7/BtQPcipYmlhxdaTsvE13xlSdbRObcmwIRkt9YgOsGHX2XKSzq9GG3yfq
 IH5xqBgUbABBRj3xRsuUJrj3R39ApwTKmUtQYzb4D6d5xfEi5Gif7MVmu72nrgxjjtvXHhseV3V
 2Qbp2BLDVYtZboW88613G21y8lElfijr02uMFLk09rVKsk1aZpKCr+sbWb0iN1fsODb8yhLf1l4
 eel6oMEjCgpIgFbMU7ZMlq7Kbs3HmLIjf/Waxa242sVA==
X-Forward-Email-ID: 67ab36932c3b8c8cd9bb4e45
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c8ccb92f-6620-4baa-bf86-de0216b537a5@kwiboo.se>
Date: Tue, 11 Feb 2025 12:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk3399: do not generate u-boot.rom anymore
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-1-0d77f95b6239@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-1-0d77f95b6239@cherry.de>
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

Hi Quentin,

On 2025-02-11 11:29, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This was only used on RK3399 Gru Chromebooks and their maintainer
> (Simon) agreed[1] to its removal on the basis that the generic
> u-boot-rockchip-spi.bin is now enough, so let's do that.
> 
> At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
> since they were used only for that.
> 
> [1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for this cleanup :-)

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
>  arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
>  arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
>  2 files changed, 37 deletions(-)
>

[snip]
