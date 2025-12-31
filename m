Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74861EE644A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 21:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015DD841E3;
	Wed, 31 Dec 2025 22:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yrbnEMKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7655841FA; Wed, 31 Dec 2025 22:29:10 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049B3841DD
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 22:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dhNPZ70QHz9sp7;
 Wed, 31 Dec 2025 22:29:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767216547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZbs5muWw5CQ+FNezH2D103PNnpab3PN4L1s72ib6og=;
 b=yrbnEMKwGkO7/JV8pKOSIA3D07JRPjDUUbQHZ4c/+kjIHahBXio/MEUoxaWTg/iq2D1P5B
 Kl7sFTKbUTH6xDvdAjmMlN97xd9csgIr5RyHB3wK/K1YqXSVS/0XnXTA89xeMlKVNivDJL
 iFNBSkXduoRxWQ5gwZnmWfnXZqZDRET654f+yGWy19z8Lo2ik0PHir+8v0R53/bRo+smmx
 ZTUnrswqRZ8v62soNI2vsXNAAVlbRhxOeBeEn7QYBYeuaqYeFMcpKYND7RiMVvogs2yRQi
 rkVfxidr5n0f2p280KnC4OgLbbPFwTdPfSiZmxw/blJryZBkglFLyvoR3cEbSA==
Message-ID: <1f18b0bf-019c-45ee-a38b-5d29f8ee9b12@mailbox.org>
Date: Wed, 31 Dec 2025 22:27:44 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v5 1/3] Image size checks: Use HAS_SIZE_LIMIT consistently
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
References: <20251110091256.2422534-1-pro@denx.de>
 <20251110091256.2422534-2-pro@denx.de>
Content-Language: en-US
In-Reply-To: <20251110091256.2422534-2-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: axmtof1syg9aknsz9ipnkzmtjog94wm8
X-MBO-RS-ID: 21ac1bed877e37b5bc1
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

On 11/10/25 10:12 AM, Philip Oberfichtner wrote:

[...]

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 8dade2b501e..97c7bfdad47 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -36,19 +36,33 @@ config SPL_FRAMEWORK_BOARD_INIT_F
>   	  - initialize the serial (preloader_console_init)
>   	  Unless you want to provide your own board_init_f, you should say Y.
>   
> +config HAS_SPL_SIZE_LIMIT
> +	bool "Enable size limit check for the SPL image"
> +	depends on !COMPILE_TEST
> +	depends on SPL
> +	default y if ARCH_MX6
> +	default y if ARCH_MVEBU && ARMADA_32BIT
> +	default y if ARMADA_38X
> +	default y if K3_DM_FW

K3_DM_FW is some driver, what you likely want here is:

default y if ARCH_K3 && CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && 
!CLK_TI_SCI && !TI_SCI_POWER_DOMAIN

But it seems am64x_evm_r5_defconfig below enables HAS_SPL_SIZE_LIMIT too 
, so likely remove !SOC_K3_AM642 from the above, which will allow you to 
reduce the amount of configs/ file changes.

> +	default y if SOC_K3_AM625
> +	default y if SOC_MT7621
> +	default y if TARGET_SOCFPGA_GEN5

You could also add Xilinx Zynq/ZynqMP into the defaults here, which will 
further reduce the configs/ file changes.

The rest looks fine, thanks !
