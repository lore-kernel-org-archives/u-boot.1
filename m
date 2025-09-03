Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175A5CA1014
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 03:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B375836A6;
	Thu,  4 Sep 2025 05:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U4+lQd9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7470183692; Thu,  4 Sep 2025 05:37:53 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6F8833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 05:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cHQCx4Qtkz9sbt;
 Thu,  4 Sep 2025 05:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756957069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RG/bXLPbLfl7lDVbf3gUJeSLwvtzUBRGSW0UcTQhRpM=;
 b=U4+lQd9Fhj1j/c9xRtDvU9qGeZ+PjWJz9rcyBlvLuZdpnVc1LizqDKC9rVuHw0Uuf3otqt
 0pnWNrzC9oTSmxJ1L4y2mtDwybF76EkSdAcEuzZ7PUeW0Ir9/kiygEtKWHKs4ua9UYH9tS
 GZwmAXXSAHWKtrGitA5tpybXCmRu2jHarM+fL+S91YxXNsgTAGoPdzcr+2vwjZdnNtTej6
 Fro1I1cWwL2R8czLOn7Bfu2l5lAvqw4ndUixggbW+AWI7ok5FECb79IDGnZDOl0DGwCAJ7
 UqjFk4GKtMDH6Yt5yutOczok01Wz/EEeSvYswO1914K/5z/u+pKlGDsMkjDaHw==
Message-ID: <d1b371f3-df96-421d-8f26-635ac0382666@mailbox.org>
Date: Wed, 3 Sep 2025 14:51:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
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
 <20250903105653.335417-3-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250903105653.335417-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b5d16e7bafb25508c64
X-MBO-RS-META: nwhq85we5hyfsmk9nhm9k1a3rx45za76
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

> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> index 05853317fea..dfac96379ce 100644
> --- a/configs/am62x_beagleplay_a53_defconfig
> +++ b/configs/am62x_beagleplay_a53_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>   CONFIG_SPL_BSS_START_ADDR=0x80c80000
>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
>   CONFIG_SPL_STACK_R=y
> +CONFIG_HAS_SPL_SIZE_LIMIT=y
How much of this massive config file patching can be done using some 
"select" in Kconfig file ?
