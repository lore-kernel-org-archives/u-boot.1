Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86535CA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 03:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC01183622;
	Thu,  4 Sep 2025 05:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j1SSzZsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A544783616; Thu,  4 Sep 2025 05:37:50 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFD3833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 05:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cHQCt2gxGz9sjQ;
 Thu,  4 Sep 2025 05:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756957066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUmaYko0N/9hXd4BTZnn5NG/mHyl4IzfAFg5IQCUlP4=;
 b=j1SSzZsbXKh01qav/PORb3oFAKPJkB6zq+OBfQSXJD8IS6yvvlcyxymxeJJOAm78n25O8D
 pNeYp8F6kCcnW/az0tE042I6G5SFaTMNRMsNldXiQfd/4KWzBUpUbdrOURJihNIDZF+Fob
 2DbznbmtLK1LoQmWXtINRHnwuUVSFQq6+7a4xdX4zqewDiyeOqmh/HcSV5ULjquC54a5Uq
 ucI72/ceBu5tICqciYOQJRVQQHT3fyaVuzj2+huq4/Aiy8R+BCBsXbQoGorJI/Wf7X3kKR
 DKGq3Kmssf8chfg2adCuHKtcEnlLC0dtPxs2z7g2shD1eqO8CyIki/Vpv6JEZg==
Message-ID: <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
Date: Wed, 3 Sep 2025 14:50:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/5] Image size checks: Move all configs in one place
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
 <20250903105653.335417-2-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250903105653.335417-2-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: e8zhf9uxjskktro4nyjk3n7bz1thy76b
X-MBO-RS-ID: 37bf93c43b77ac8a5c1
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
> How image size limiting works in U-Boot should be easier to grasp if we
> have all related options in one place.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
>   common/spl/Kconfig     | 38 ---------------------------
>   common/spl/Kconfig.tpl |  7 -----
>   common/spl/Kconfig.vpl |  7 -----
>   4 files changed, 59 insertions(+), 52 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 70125c4e5a6..f1a6be299e8 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -535,6 +535,8 @@ config BUILD_TARGET
>   	  special image will be automatically built upon calling
>   	  make / buildman.
>   
> +menu "Image size limits"
> +
>   config HAS_BOARD_SIZE_LIMIT
>   	bool "Define a maximum size for the U-Boot image"
>   	depends on !COMPILE_TEST
> @@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
>   	  include SPL nor TPL, on platforms that use that functionality, they
>   	  have separate options to restrict size.
>   
> +config VPL_SIZE_LIMIT
> +	depends on VPL
> +	hex "Maximum size of VPL image"
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the U-Boot VPL image.
> +	  If this value is zero, it is ignored.
> +
> +config TPL_SIZE_LIMIT
> +	depends on TPL
> +	hex "Maximum size of TPL image"
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the U-Boot TPL image.
> +	  If this value is zero, it is ignored.
The point of separate common/spl/Kconfig.tpl and common/spl/Kconfig.vpl 
files is to group SPL / TPL / VPL symbols in those files .
