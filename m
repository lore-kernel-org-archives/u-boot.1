Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A366FD2D100
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 23:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C206F800AE;
	Wed, 14 Jan 2026 00:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3EF800B6; Wed, 14 Jan 2026 00:16:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1A1FB8004F
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 00:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B76497;
 Tue, 13 Jan 2026 15:16:29 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5063F694;
 Tue, 13 Jan 2026 15:16:34 -0800 (PST)
Date: Wed, 14 Jan 2026 00:15:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Hans de Goede <hdegoede@redhat.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] sunxi: setup_environment: do not generate a MAC
 address when one is set using nvmem-cells
Message-ID: <20260114001534.6062abaf@minigeek.lan>
In-Reply-To: <20250610053856.1873969-2-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
 <20250610053856.1873969-2-lukas.schmid@netcube.li>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 10 Jun 2025 07:38:54 +0200
Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi Lukas,

> Boards using MAC addresses stored in EEPROM via the device tree's
> `nvmem-cells` mechanism may already have a valid MAC loaded by the
> device model. However, setup_environment() currently ignores this
> and generates a fallback address from the SoC SID if no environment
> variable is set.
> 
> This leads to a mismatch warning during boot when the kernel or U-Boot
> detects the MAC from nvmem and compares it to the environment.
> 
> This patch checks whether the corresponding ethernet device node
> has a `nvmem-cells` property and skips generating a fallback MAC
> if it does, thus avoiding redundant or incorrect ethaddr setup.

So while this seems like a pragmatic solution, I feel it's not the
right one: This "peeking into the DT to skip something" sounds
backwards. You have probably investigated this more thoroughly, but how
does this work here? Did the generic code already parse the MAC address
and put it somewhere, and our code here was about to overwrite it? Or
will the generic code later fill the gap, if the sunxi code didn't set a
MAC address based on the SID?

I feel like the sunxi code is to blame here for doing it at the wrong
time or using its own method instead of coordinating with the generic
code, so I'd rather fix this properly than papering over it here.

I will help you find a better solution, but if you can dump here what
you learned, I'd be grateful, as I am too lazy atm to chase down the
code ;-)

Cheers,
Andre
 
> This improves compatibility with nvmem-based MAC provisioning and
> aligns U-Boot behavior with Linux.
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  board/sunxi/board.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index ac9cefc6..41b85c66 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -774,10 +774,23 @@ static void setup_environment(const void *fdt)
>  		return;
>  
>  	for (i = 0; i < 4; i++) {
> +		const char *alias;
> +		int nodeoffset;
> +		int len;
> +		const fdt32_t *prop;
> +
>  		sprintf(ethaddr, "ethernet%d", i);
> -		if (!fdt_get_alias(fdt, ethaddr))
> +		alias = fdt_get_alias(fdt, ethaddr);
> +		if (!alias)
>  			continue;
>  
> +		nodeoffset = fdt_path_offset(fdt, alias);
> +		if (nodeoffset >= 0) {
> +			prop = fdt_getprop(fdt, nodeoffset, "nvmem-cells", &len);
> +			if (prop && len > 0)
> +				continue;
> +		}
> +
>  		if (i == 0)
>  			strcpy(ethaddr, "ethaddr");
>  		else

