Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E75CA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 03:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590D183692;
	Thu,  4 Sep 2025 05:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mM2hFG+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A778683616; Thu,  4 Sep 2025 05:37:56 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B465F833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 05:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cHQD05Wx6z9tKm;
 Thu,  4 Sep 2025 05:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756957072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnzVCNcxnqLN6aZsXIzLpHdEcP/K+pSDKDNN/nW6Mu4=;
 b=mM2hFG+BNjXn3sf9qpJUSh8NL50YObEgWDnkehsFDLVSqFU+/YcpIR0qfeB+N7Yecuieje
 L00Ejrgs6IAocL8DevKAzNOC0mlxjAU0Gtj6ebQgFNMoxoY4IdR8/HzjEpM8KpHwS6vdZ5
 Zr1M1F/KXO75qto+INl0kDYoi5YYw/68AdXVgmaRvdP9iz9JZNPLw7TW4vAaHu6b6Ra4Sz
 i7hS941jSocJW8fUt2RPsLggP+gpTOTpMspi6NSgRrhM9L69XGuCQdPEtRJKfkthUQuSyA
 YQLGGIgonTIAaPfLMhDL73ng4S3m441ek6TqHXhgHL2m52acU73JFcS8gZqnIw==
Message-ID: <d527832a-6f39-46d2-abba-aac2a4cdc2ab@mailbox.org>
Date: Wed, 3 Sep 2025 14:54:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/5] Image size checks: Use consistent help texts
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-4-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250903105653.335417-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6a7841bb4344778399d
X-MBO-RS-META: j749n56tyk8eg4p8uhia9fd1rktc5k4u
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

On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> The multiple XXX_SIZE_LIMIT options use slightly varying help texts.
> Their similarities and differences should become more clear if we use
> consistent help texts.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Kconfig | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index e73dd91a408..aa00669ba20 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -538,7 +538,7 @@ config BUILD_TARGET
>   menu "Image size limits"
>   
>   config HAS_BOARD_SIZE_LIMIT
> -	bool "Define a maximum size for the U-Boot image"
> +	bool "Enable size limit check for the U-Boot image"
>   	depends on !COMPILE_TEST
>   	default y if RCAR_32 || RCAR_64
>   	help
> @@ -562,11 +562,11 @@ config HAS_VPL_SIZE_LIMIT
>   	depends on VPL
>   
>   config VPL_SIZE_LIMIT
> -	hex "Maximum size of VPL image"
> +	hex "Maximum size of VPL image in bytes"
>   	depends on HAS_VPL_SIZE_LIMIT
>   	help
> -	  Specifies the maximum length of the U-Boot VPL image.
> -	  If this value is zero, it is ignored.
> +	  Maximum size of the VPL image. When defined, the build system checks

The "when defined ..." part should be in HAS_VPL_SIZE_LIMIT , which 
gates access to VPL_SIZE_LIMIT . If HAS_VPL_SIZE_LIMIT is set, then this 
is always defined.
