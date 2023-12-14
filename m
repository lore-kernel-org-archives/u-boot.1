Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91415C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FF087A69;
	Thu, 14 Dec 2023 11:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MInxbS9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3117987A65; Thu, 14 Dec 2023 11:36:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA0487A6A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8BE19B82166;
 Thu, 14 Dec 2023 10:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07476C433C8;
 Thu, 14 Dec 2023 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702550203;
 bh=EsO8goaQVqffnUPtLWcA+tXXoaUhduJHufKSvMtikEQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MInxbS9b1tjpM6gDKiO5b+DvGC3jYeNKjjd9Xn3ZWdaEMrjn9kS/kln4s8S1QYjJ/
 AbKjJRT9xnlS54AoT4opY/Y1cKpx5QUAmbT3aFned4UbUoACwyuzlbqbknVTChRys3
 cYfVU4D7TL/hkqWzaQ1XUmUcuX93V0Uxe0LktETuN8pu+cn1st13iVervxiOKXL5Oe
 Yg/Y2T6Hg+IscIgBoNJYIMZMzZFCUEYpt0Wm32TDd6m3CSaMQQkTUZwfrOfDWlLGME
 A06Pltmx4euLX4Ij3doxf83E8eY3eTTwzChl6GzO8M14YzGTjf4YFqGXiNd9wLykNs
 oZGg4O7KayK4g==
Message-ID: <054aa15f-05b9-4645-ab00-fac1be46dad7@kernel.org>
Date: Thu, 14 Dec 2023 12:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm: dts: k3-am625-sk: Enable usb ports in u-boot
Content-Language: en-US
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Nishanth Menon <nm@ti.com>, Martyn Welch <martyn.welch@collabora.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Julien Panis <jpanis@baylibre.com>
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-4-sjoerd@collabora.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231212210234.509309-4-sjoerd@collabora.com>
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



On 12/12/2023 23:02, Sjoerd Simons wrote:
> Enable both usb0 as a peripheral for use with DFU and
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Enable usb nodes in all boot phases
> 
> Changes in v2:
> - Only enable usb port 0 DFU in SPL
> 
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4c..1fc0d407cbf 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,12 @@
>  &cpsw_port2 {
>  	status = "disabled";
>  };
> +
> +&usbss0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	dr_mode = "peripheral";

There was a series [1] just to undo this.

Can we make it auto-magically work even when mode is "otg"
Can we address anything missing at the driver level?

> +	bootph-all;
> +};

[1] https://lore.kernel.org/all/20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com/

-- 
cheers,
-roger
