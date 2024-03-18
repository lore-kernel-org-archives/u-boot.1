Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9966DC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 10:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5A987D82;
	Mon, 18 Mar 2024 11:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="k/TP3Rga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C688087EDD; Mon, 18 Mar 2024 11:29:09 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3FB8879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 11:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2d81=KY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710757723;
 bh=+N94wnrr6nIHz49f5smbQBbgZNNtrfD54IBLEWueqR4=;
 b=k/TP3RgacXeAR8SigMwujCZTulTpzup0UqnIQIUGI/89wfdL+CKFpqubP2IuHTmY2aqwydHXm
 o8cLUQcRRGNqm3A9Rnk4yb8ejLP4LNwsYh9N4z6tNZP7P6efIchicr6S+R9vN0A3BCsRoLOUebS
 qajEXyE7D5YQCXupcYZejqmhEXL/IoTyvMqvl0D5rGxg3++cd6L95HViqVZtPhTPWQ2Hx7Yvtwt
 Hby++id9m65zz7JWMaEyTEkqmBs7vLvdZD9VU+pLEob1kmEJa063Av2OrasYcj6VkKpQP2YZwic
 PZhqFTKo6p2lf3egDLxO/90aK9gh5q05/Yp2AbI9lQKA==
Message-ID: <732568d1-0961-4a43-98a1-cc8155444df9@kwiboo.se>
Date: Mon, 18 Mar 2024 11:28:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: rockchip: sync ROCK Pi 4A DTS from Linux
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, kernel@collabora.com, Kever Yang
 <kever.yang@rock-chips.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240315120126.75424-1-chris.obbard@collabora.com>
 <20240315120126.75424-2-chris.obbard@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240315120126.75424-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f8175b94d3faf4be110166
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

On 2024-03-15 13:01, Christopher Obbard wrote:
> To prepare for ROCK Pi 4A SPI flash support, sync the DTS from Linux which
> includes an SPI flash node.
> 
> Kernel tag: v6.6-rc1
> Kernel commits:
>  - eddf73029770 ("arm64: dts: rockchip: Enable internal SPI flash for ROCK \
>                   Pi 4A/B/C")
> 
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> 
> Changes in v2:
> - Collect Reviewed-by tag from Kever Y.
> 
>  arch/arm/dts/rk3399-rock-pi-4a.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-rock-pi-4a.dts b/arch/arm/dts/rk3399-rock-pi-4a.dts
> index 931334aa3d6..d5df8939a65 100644
> --- a/arch/arm/dts/rk3399-rock-pi-4a.dts
> +++ b/arch/arm/dts/rk3399-rock-pi-4a.dts
> @@ -12,3 +12,13 @@
>  	model = "Radxa ROCK Pi 4A";
>  	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";
>  };
> +
> +&spi1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +	};
> +};

