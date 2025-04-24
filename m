Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38424C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE66809D4;
	Thu, 24 Apr 2025 22:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F10581B4B; Thu, 24 Apr 2025 22:36:32 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E028056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.25.173])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7D0C5B4C1BC8;
 Thu, 24 Apr 2025 22:36:27 +0200 (CEST)
Message-ID: <941ffb8c-b97d-4e3e-92a6-61264faed784@freeshell.de>
Date: Thu, 24 Apr 2025 13:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] doc: jh7110: describe debug UART
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
 <20250424121315.144549-9-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250424121315.144549-9-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

I do not know what a Debug UART is (different than Serial Console?) and
did not test on hardware available to me but the description sounds
reasonable enough.

On 4/24/25 05:13, Heinrich Schuchardt wrote:
> Provide the settings for using the debug UART in SPL.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	no change
> v3:
> 	no change
> v2:
> 	new patch
> ---
>  doc/board/starfive/jh7110_common.rst | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
> index fb8d87a1551..4a8058ee5da 100644
> --- a/doc/board/starfive/jh7110_common.rst
> +++ b/doc/board/starfive/jh7110_common.rst
> @@ -87,3 +87,17 @@ u-boot.itb via the Y-modem protocol.
>  Due to restrictions of the boot ROM not all X-modem implementations are
>  compatible. The package tio (https://github.com/tio/tio) has been found to be
>  usable.
> +
> +Debug UART
> +----------
> +
> +By default the SBI interface is used for the debug UART. But this only works
> +in main U-Boot. To enable the debug UART in SPL, too, use the following
> +settings::
> +
> +    CONFIG_DEBUG_UART=y
> +    CONFIG_DEBUG_UART_NS16550=y
> +    CONFIG_DEBUG_UART_BASE=0x10000000
> +    CONFIG_SPL_DEBUG_UART_BASE=0x10000000
> +    CONFIG_DEBUG_UART_CLOCK=24000000
> +    CONFIG_DEBUG_UART_SHIFT=2

Reviewed-by: E Shattow <e@freeshell.de>
