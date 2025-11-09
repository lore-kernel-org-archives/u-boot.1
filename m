Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D79CCFA1A
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 19:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A54883D52;
	Sun,  9 Nov 2025 20:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FbIx0Y7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0AF83E2B; Sun,  9 Nov 2025 20:47:05 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A74838CE
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 20:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d4Nbn4plYz9v6Q;
 Sun,  9 Nov 2025 20:47:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762717621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6OgXkP0Ln8GpqP0VbmJdXL+harljAZqm35XiWajwne0=;
 b=FbIx0Y7Uk3fqpnWnRXf7xuF8lZp1UN2RXJMqbgHHt24ghplzGY2a62gsbbTAG+gOJqzI6g
 jdLWJOFpOibAy7/zkMv23pgPGhI16UgfeFSOWkhMnIt7l5naXSH7VikTr2jXdFMA/gAMen
 ybNZ4Hf4Pv232oBBmAQDO74ymlS2xa/nvR0NSSNT3ZjHUZ1Spn95GZXAiOtj9HsO6+CgPl
 tUc9xpKVMlHikiWLePEHXLDB5qj3xsQRbMQ79JxYxzzJi7p57G94RlZeHHnvNagS+ixNgv
 uFxBqY7SKZC8Q//IFJIvSm/QuSd+uEk0fPOPm4XiLRMtz+MItldxUwutQIf4zA==
Message-ID: <73d7e852-b2c3-4ef2-a9f6-af4e37941ceb@mailbox.org>
Date: Sun, 9 Nov 2025 19:41:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] Image size checks: Use HAS_SIZE_LIMIT consistently
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20251015012320.2331007-1-pro@denx.de>
 <20251015012320.2331007-2-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251015012320.2331007-2-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 99d379590c9ede0749f
X-MBO-RS-META: 84s6rn5jpmck9qaby8cpwh5y9xuxo41j
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

On 10/15/25 3:23 AM, Philip Oberfichtner wrote:
> Use a consistent logic for image size checks. No functional change.
> 
> Before this commit, there were two concurrent approaches of how image
> size checks are disabled: Whereas BOARD_SIZE_LIMIT was gated through a
> dedicated Kconfig symbol to achieve this, all the other size checks were
> disabled by assigning them a limit of zero bytes.
> 
> By this commit we achieve a consistent logic for size limiting, by
> introducing CONFIG_HAS_XXX_SIZE_LIMIT for all those options that don't
> have it yet.

[...]

> diff --git a/Makefile b/Makefile
> index 2402f9313d8..e68dce2c1d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1109,19 +1109,19 @@ else
>   BOARD_SIZE_CHECK =
>   endif
>   
> -ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> +ifneq ($(CONFIG_SPL_SIZE_LIMIT),)

Why does this check not use HAS_SPL_SIZE_LIMIT introduced below ?

>   SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
>   else
>   SPL_SIZE_CHECK =
>   endif
>   
> -ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
> +ifneq ($(CONFIG_TPL_SIZE_LIMIT),)

DTTO

>   TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
>   else
>   TPL_SIZE_CHECK =
>   endif
>   
> -ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
> +ifneq ($(CONFIG_VPL_SIZE_LIMIT),)

DTTO

[...]

> +++ b/common/spl/Kconfig
> @@ -36,19 +36,33 @@ config SPL_FRAMEWORK_BOARD_INIT_F
>   	  - initialize the serial (preloader_console_init)
>   	  Unless you want to provide your own board_init_f, you should say Y.
>   
> +config HAS_SPL_SIZE_LIMIT
> +	bool "Enable size limit check for the SPL image"
> +	depends on !COMPILE_TEST
[...]
