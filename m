Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEE0CA1014
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 03:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C86E834AD;
	Thu,  4 Sep 2025 05:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b+Tzk7hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E711B836B8; Thu,  4 Sep 2025 05:37:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B677833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 05:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cHQD31ZP7z9t4F;
 Thu,  4 Sep 2025 05:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756957075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgJ0DKwxfP1/dksjITAzLt5BNe3/NhiSJBAU/FknUTE=;
 b=b+Tzk7hvOF+OvrBwFDAXySWv4fTj3fvNYPYln+8XEpAXugAorWlEhhm76O1qWfcoWjTEdi
 HC+XxKoJuxTVPHpQbE8HTkgp3j7ciYJlY5HXPsSsvpY6J3WFbZjt2cWaaOrkQ2sxNaDY3f
 HaUL3aIJBiZGmaD7rxoLLALPSU1Qf0ThozFvJjUtB0bLN1nbUcnF6721PcCzTLepFFc6XU
 Aka9Qg32T3nnwMLeF0A8X7LFwMkjWtmHht+L78k5R1WegxcN10CLWnNncqKl7LRrKV4ba7
 du6wfYYMRsEAlelFIxKnJtl/5xczViAk9oni8yDhel7aUQHsOEGl7VPVjhA7PQ==
Message-ID: <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
Date: Wed, 3 Sep 2025 14:59:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
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
 <20250903105653.335417-6-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250903105653.335417-6-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kommi89k57xo9yukokxjsoznt41ur6yt
X-MBO-RS-ID: 0effd34696bd2c0ad05
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
> Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Kconfig b/Kconfig
> index aa00669ba20..343299eed50 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
>   config SPL_SIZE_LIMIT
>   	hex "Maximum size of SPL image in bytes"
>   	depends on HAS_SPL_SIZE_LIMIT
> -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>   	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> +	default 0x11000 if ARCH_MX6
This makes it less obvious what the other case (!256 kiB SRAM SoCs) 
covers, why is that an improvement ?
