Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F7CA0FF6
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 21:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A783383327;
	Thu, 28 Aug 2025 23:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC51833E1; Thu, 28 Aug 2025 23:37:48 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85998328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 23:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A3CDEB2201D4;
 Thu, 28 Aug 2025 23:37:44 +0200 (CEST)
Message-ID: <c9d2988b-2e25-4e3d-a452-1b3687b6b33a@freeshell.de>
Date: Thu, 28 Aug 2025 14:37:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] starfive: avoid NULL dereference in fdt_check_header()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
References: <20250828130335.24173-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250828130335.24173-1-heinrich.schuchardt@canonical.com>
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



On 8/28/25 06:03, Heinrich Schuchardt wrote:
> If the u-boot.itb read from SD-card is invalid, fdt_check_header() may be

Here is said SD-card, and later is said UART. Is SD-card the only way to
cause this condition?

> called with a NULL pointer.
> 
> This was observed on an StarFive VisionFive Lite when trying to revover the

"This was observed on an StarFive VisionFive 2 Lite when trying to
recover the board via UART."

There is a VisionFive product with JH7100 CPU, we are not that, here.

> board via UART.>
> Add a missing check in the starfive board code.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/spl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 3dfa931b655..fe14b44ce28 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -23,7 +23,8 @@ DECLARE_GLOBAL_DATA_PTR;
>  void spl_perform_fixups(struct spl_image_info *spl_image)
>  {
>  	/* Update the memory size which read from eeprom or DT */
> -	fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
> +	if (spl_image->fdt_addr)
> +		fdt_fixup_memory(spl_image->fdt_addr, 0x40000000, gd->ram_size);
>  }
>  
>  static void jh7110_jtag_init(void)

Commit message sounds confusing to me, code is fine though. Maybe some
debug output print would be helpful in case of failure, since it is a
void function and we have introduced a code path where the fdt fixup is
skipped without warning. Also fine as it is just improve the commit
message please. With that,

Reviewed-by: E Shattow <e@freeshell.de>
