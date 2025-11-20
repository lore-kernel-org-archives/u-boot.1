Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DA2CF856F
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D430584088;
	Thu, 20 Nov 2025 10:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XCCMncTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9420D840AE; Thu, 20 Nov 2025 10:20:08 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9B58407F
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 427D810B3A0; Thu, 20 Nov 2025 10:20:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763630405;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=X++7di51E6KmA1lLP4fvkm6WflYPicupC7JU1uW52QE=;
 b=XCCMncTA6wd3HGigKSK2sV4RMg3+arcDSweRPQE6MsyuvHsrRfX+8Ea6+MeILH62Fyf1Ms
 bQ4cM8dB19k07bV2KS21PFhrniRkYLisNuYTIi21/QNjlQQNbDjFGchDXgqksjo3nFiptt
 qUQUI+T4ZjB4kUCvLTo08uG6G+EFQfeG8NkteAvU608DsY/oyLhW9D7wAZ4jFOdWKAXHvL
 eTLDBylbZcXSP5k1aW6SovRL90hdXaE01MNzuZSC1FhixRGwOl8l3XqFROQxXMrWztVNiL
 xa+RqK39pVSqLFhVJ+WzQvYwkUh/0Xswumz2zYpNPVCoi0D9KvGYKmEAIklRjQ==
Message-ID: <9f66439e-3257-d7b9-4100-8c6f10aa0fe0@nabladev.com>
Date: Thu, 20 Nov 2025 10:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] led: remove support for green status led in legacy API
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-2-ce86b8d59dfc@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119-corvus-led-red-green-v1-2-ce86b8d59dfc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

added Adrian

On 19.11.25 18:01, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The last user of it was removed in a previous commit so let's remove its
> support entirely.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   cmd/legacy_led.c        |  6 ------
>   common/board_f.c        |  2 --
>   doc/api/led.rst         |  5 +----
>   drivers/led/Kconfig     | 14 --------------
>   drivers/misc/gpio_led.c | 12 ------------
>   include/status_led.h    |  4 ----
>   6 files changed, 1 insertion(+), 42 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
