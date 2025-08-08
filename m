Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0426EC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 13:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3198473B;
	Fri,  8 Aug 2025 15:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mdbYBZ2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9F88473B; Fri,  8 Aug 2025 15:11:11 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89D884728
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 15:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bz4Cq6CRdz9t0j;
 Fri,  8 Aug 2025 15:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754658663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDtKEvQOme07roTQ0eezgFNKZm5dcxClJw3ggpZfjtk=;
 b=mdbYBZ2vQned3xjyj63USTpkHxIfysoUambXe5EJiPwBvbakpVM0BVeQUaZftEWLvUN5aG
 QqohmkERBUeKXMQWTTaES5GC/4pE4mpKueQn3RXHDwdB+f4nntxyvUNTN23ALnFvfb3Id5
 zykjHacaUfuUcBfXrJdMThvID0qhx6Dpxq2rSeC7RGqTOIXs7dwvaom9qGiJzpm4nRttPG
 U7oZ+OtlLJpUYOpvVvZulvXkoervY9MEcEdKObtr+nikRFZKM5Satx92isXvMAUOL6eRxj
 qacGD0HjEjhRpN5JimaOdxjVQ3PhAbx9I9zjfZuvOmbG1q5XriZsyLdsGjK3MA==
Message-ID: <6ecb3a72-a6ba-4930-ab57-292f17020b96@mailbox.org>
Date: Fri, 8 Aug 2025 15:10:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/4] Makefile: Add size check for u-boot-with-spl.bin
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250807075653.356088-1-pro@denx.de>
 <20250807075653.356088-3-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250807075653.356088-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 052784de66e25b2714a
X-MBO-RS-META: zri6tpuxrboqf6fhgew1fst7ttrwkgjz
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

On 8/7/25 9:56 AM, Philip Oberfichtner wrote:

[...]

> +++ b/Makefile
> @@ -1715,6 +1715,7 @@ OBJCOPYFLAGS_u-boot-with-spl.bin = -I binary -O binary \
>   				   --pad-to=$(CONFIG_SPL_PAD_TO)
>   u-boot-with-spl.bin: $(SPL_IMAGE) $(SPL_PAYLOAD) FORCE
>   	$(call if_changed,pad_cat)
> +	@$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT))

It seems other size checks are not called unconditionally, see Makefile 
around line 1100 . Why is this one called unconditionally ? Won't this 
break boards which default this new option to 0 ?

>   ifeq ($(CONFIG_ARCH_LPC32XX)$(CONFIG_SPL),yy)
>   MKIMAGEFLAGS_lpc32xx-spl.img = -T lpc32xximage -a $(CONFIG_SPL_TEXT_BASE)
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index ab05536bd02..b5c0c60ff6b 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -36,6 +36,13 @@ config SPL_FRAMEWORK_BOARD_INIT_F
>   	  - initialize the serial (preloader_console_init)
>   	  Unless you want to provide your own board_init_f, you should say Y.
>   
> +config UBOOT_WITH_SPL_SIZE_LIMIT
> +	hex "Maximum size of u-boot-with-spl.bin"
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the u-boot-with-spl.bin image.
> +	  If this value is zero, it is ignored.
Why not set SPL_SIZE_LIMIT and BOARD_SIZE_LIMIT ?
