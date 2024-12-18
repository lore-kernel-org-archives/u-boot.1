Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6CDE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E016380269;
	Wed, 18 Dec 2024 14:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aBgpsbuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A51080283; Wed, 18 Dec 2024 14:47:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528EF8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D54745C4A3B;
 Wed, 18 Dec 2024 13:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C12C4CECD;
 Wed, 18 Dec 2024 13:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734529646;
 bh=seS04IUJ5vGB4kljFE/bSNqEAX85g6vFZufF4skth3E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aBgpsbuqLlsUW8qbciHlWueQePcvgxts/nB6LrYCH/Qv/N6EHqZXr+R7Q4gA/ifL1
 kktSN4Pv/3u3CvYetnSxWdOPHG9OoOnmRqaV7h4Zzo0Sro3g8DIjyb+v4ZsxM7NvRP
 K6vBlImS4OBsNOx0Irlgq6A5UJUyCkQE+I9yD29HQufwjJaXT9dy0d17Es8y9OW8BE
 0CsO2TInVbByD1OnYcROozQZcixU0Os7lwM4HLFunO6PmKtNZ9ZFI+bIArBffAGjpQ
 T7xWuONGTagO9zZO9TsX28EhlAQOQH3OvLszuTtoEjR7GvpNP+/brk0PDGe2rk2uzs
 v84P3GmHM8jgQ==
Message-ID: <7ac41391-b295-4601-94e5-5c18090d65cd@kernel.org>
Date: Wed, 18 Dec 2024 15:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] configs: am62px_evm_a53_defconfig: enable USB DFU
 support
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-4-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241218124542.3519447-4-s-vadapalli@ti.com>
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

Hi Siddharth,

On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
> for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it

Apparently "am62x_a53_usbdfu.config" adds USB Host and Gadget and DFU support.

> in "am62px_evm_a53_defconfig" in order to enable support for USB DFU
> flash and boot. Remove those configs from "am62px_evm_a53_defconfig" which
> are present in the "am62x_a53_usbdfu.config" config fragment that is being
> included.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

