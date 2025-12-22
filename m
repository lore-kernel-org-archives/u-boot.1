Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF2FD711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843CC83D1A;
	Mon, 22 Dec 2025 09:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cF8WpN3d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA74B83D3C; Mon, 22 Dec 2025 09:42:41 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2E083AAE
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dZWqL0Psyz9smP;
 Mon, 22 Dec 2025 09:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766392958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQCLZzrx6DdFyxHyOA65dayU5a6YrqDcVx5j8ROtoP0=;
 b=cF8WpN3dZu3E9mvo77mxHagW3V8Y4dgs+tM5H8xNACRxRw+ghqcXCsha3rmtACrddOLoy3
 vW+b/A/xhph0Vs37X1sqL8T/GADaOYWnOlpWC5Y57WKVSHTo/ImJ6KulvYHJcgi2/7WjjS
 QaCDKU7E2DkR2BvZpD6b53POOrDGEInEJ9Wpa10qe59WNg/3Iruwe8u1PBs+oW9xL27jiJ
 XoAjKZz6qJsnyIDnbMFePRBhZZ1Ue17a700sEsGJeicza93DCJrkKq6bKsoaQvR+pTe6lU
 x42qaiZUil9kv9uAn8X257KYQjLcJWouGwUmFIujEOOaVA2HFpxi++x0FCixlA==
Message-ID: <cc1428ef-30d3-49ea-8a2c-8db0ecc5adcc@mailbox.org>
Date: Mon, 22 Dec 2025 09:42:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCHv1 1/3] lzma: Add Kconfig options to optimize for size
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <20251218233654.3938385-1-trini@konsulko.com>
 <20251218233654.3938385-2-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251218233654.3938385-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b014057d709db32ddfe
X-MBO-RS-META: y4j81xgp3ya6f7framiumpb3tfocrf16
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

On 12/19/25 00:30, Tom Rini wrote:
> Currently, our LZMA library has an option for optimizing for size,
> rather than speed. It is a minimal savings today, and has not been worth
> enabling. As this will change in the near future, add options now to
> allow disabling it in full U-Boot or in SPL, and enable these on
> gardena-smart-gateway-mt7688 which is very close to the size limit
> today.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   configs/gardena-smart-gateway-mt7688_defconfig |  2 ++
>   lib/Kconfig                                    | 14 ++++++++++++++
>   lib/lzma/Makefile                              |  1 +
>   3 files changed, 17 insertions(+)
> 
> diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
> index 3c2bcc6a3c44..aba8a2ffd1de 100644
> --- a/configs/gardena-smart-gateway-mt7688_defconfig
> +++ b/configs/gardena-smart-gateway-mt7688_defconfig
> @@ -101,4 +101,6 @@ CONFIG_MT7621_SPI=y
>   CONFIG_WDT=y
>   CONFIG_WDT_MT7621=y
>   CONFIG_LZMA=y
> +CONFIG_LZMA_SIZE_OPTIMIZATION=y
>   CONFIG_SPL_LZMA=y
> +CONFIG_SPL_LZMA_SIZE_OPTIMIZATION=y
> diff --git a/lib/Kconfig b/lib/Kconfig
> index fe0b878a206b..96032eaddf95 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -838,6 +838,13 @@ config LZMA
>   	  ratio and fairly fast decompression speed. See also
>   	  CONFIG_CMD_LZMADEC which provides a decode command.
>   
> +config LZMA_SIZE_OPTIMIZATION
> +	bool "Optimize the LZMA algorithm for smaller binary size"
> +	help
> +	  This enables building the LZMA library optimized for size, rather
> +	  than performance. This can be a loss of 15-20% in decompression
> +	  speed, but a savings of close to two kilobytes in many cases.
> +
>   config LZO
>   	bool "Enable LZO decompression support"
>   	help
> @@ -932,6 +939,13 @@ config SPL_LZMA
>   	help
>   	  This enables support for LZMA compression algorithm for SPL boot.
>   
> +config SPL_LZMA_SIZE_OPTIMIZATION
> +	bool "Optimize the LZMA algorithm for smaller binary size in SPL"
> +	help
> +	  This enables building the LZMA library optimized for size, rather
> +	  than performance. This can be a loss of 15-20% in decompression
> +	  speed, but a savings of close to two kilobytes in many cases.
> +
>   config TPL_LZMA
>   	bool "Enable LZMA decompression support for TPL build"
>   	depends on TPL
> diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
> index c2fd3e494541..b8ad570ab1c2 100644
> --- a/lib/lzma/Makefile
> +++ b/lib/lzma/Makefile
> @@ -7,5 +7,6 @@
>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   
>   ccflags-y += -D_LZMA_PROB32
> +ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -D_LZMA_SIZE_OPT
>   
>   obj-y += LzmaDec.o LzmaTools.o

