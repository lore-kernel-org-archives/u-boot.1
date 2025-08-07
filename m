Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F19C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20BA84543;
	Thu,  7 Aug 2025 15:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fOOmxYO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E0A84548; Thu,  7 Aug 2025 15:43:50 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C685884543
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bySy24FRzz9snV;
 Thu,  7 Aug 2025 15:42:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754574122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6Myji1UEHSV8w/J/ML21hvgSDzoUrDM0wjE+uN356k=;
 b=fOOmxYO518iVtUr5QVncV7hzt/mlq1T3U19iWorMKEM+wcp7mXdjvoW7OJygXVv1+ypmyu
 yBP/6yha8PcWMcZ+gxclLhaLtXb0um1IDRYff0Woa8DUJt63F2jx9x3TWzqguk75wxgLPq
 jRwuOourrwYjOeX3kSnUXQCJzWY3efct4pkRhUNMAI47bxuuKHGXh6oC161EANvBO7z1jS
 8BrqWpELpaKEUEz24kjQ+DhZq7HKbRH9CiKPPHxPqX/l75r+2sgoVbboQydY0qNdRQ+DbM
 MkPeZi3xplOxsVMfbqtgj2uVmJa+fgQKvfzFFSSgZ/RAQ8zMotg3VVw4Vn3P1w==
Message-ID: <1d3e5573-7e36-4050-88e8-90d31e5253a9@mailbox.org>
Date: Thu, 7 Aug 2025 15:41:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] Image size checks: Simplify help text
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-4-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250807102436.452691-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f22fae481eedf86020d
X-MBO-RS-META: itmsnp4w1p3ndtyc67zg9hpdwpaafsio
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

On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> For coherency, use the same help text for all related size checks
> options. Furthermore, simplify the depends-on logic.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>      Changes in v2: new
> 
>   Kconfig | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index ec20603883b..490a706101a 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -543,10 +543,8 @@ config BOARD_SIZE_LIMIT
>   	default 1048576 if RCAR_64
>   	default 0
>   	help
> -	  Maximum size of the U-Boot image. When defined, the build system
> -	  checks that the actual size does not exceed it.  This does not
> -	  include SPL nor TPL, on platforms that use that functionality, they
> -	  have separate options to restrict size.
> +	  Specifies the maximum length of the U-Boot image.
> +	  If this value is zero, it is ignored.

This makes the description less accurate, sorry, NAK.
