Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F538E732C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 12:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF3D8656E;
	Thu, 28 Sep 2023 14:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IS4iHn4P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F8786611; Thu, 28 Sep 2023 14:59:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DC38654D
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 14:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6E60261BA3;
 Thu, 28 Sep 2023 12:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72941C433C8;
 Thu, 28 Sep 2023 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695905945;
 bh=5PJs7RmR/nOSfo5zzPw2F0nX2h+3wqs2UY0QIEyg5sY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IS4iHn4Pq0jxvxn5XXlJAi/F35ZI2rCioLO2sKxPLcIVLdZXX7AeSwPSZDXFwEf1g
 W2sxlk6xBly5Tf53AFA1+tzt9VZ1vMbzR351RYb+1Txd8wqr9vQifXuP8Ss55L/dkz
 Ics18W/dkqXIH0ZuMZK+2QT9KmTTbhNWC1ojg9DAKKeYfMfGtdTb00Ryq+LR7v4ekB
 AMlH7jndXIfcyO/pIaGDao+kXKGrnXlWjH5GTtjxC7ErBB98aKnEeAf2erDNHJ8E0B
 N4hB2I9mKdd4F5gFnY1/o4tMpOBq2kdCVykdgtB7bxFSCHxYyGeKliZzWwcXg1iFic
 l2qupZfDIzsjA==
Message-ID: <05a3d9d4-cdcd-4145-aece-727f14a7efb3@kernel.org>
Date: Thu, 28 Sep 2023 15:59:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dm: core: Report bootph-pre-ram/sram node as pre-reloc
 after relocation : regression
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 "Andrew F. Davis" <afd@ti.com>, "Berard, Brian" <bberard@ti.com>
References: <20230820220316.3517102-1-jonas@kwiboo.se>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230820220316.3517102-1-jonas@kwiboo.se>
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

Hi,

On 21/08/2023 01:03, Jonas Karlman wrote:
> Nodes with bootph-pre-sram/ram props are bound in multiple phases:
> 1. At TPL (bootph-pre-sram) or SPL (bootph-pre-ram) phase
> 2. At U-Boot proper pre-relocation phase
> 3. At U-Boot proper normal phase
> 
> However the binding and U-Boot Driver Model documentation indicate that
> only nodes marked with bootph-all or bootph-some-ram should be bound in
> the U-Boot proper pre-relocation phase.
> 
> Change ofnode_pre_reloc to report a node with bootph-pre-ram/sram prop
> with a pre-reloc status only after U-Boot proper pre-relocation phase.
> Also update the ofnode_pre_reloc documentation to closer reflect the
> binding and driver model documentation.
> 
> This changes behavior of what nodes are bound in the U-Boot proper
> pre-relocation phase. Change to bootph-all or add bootph-some-ram prop
> to restore prior behavior.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2:
> - Drop use of !! to convert into bool
> - Update documentation for ofnode_pre_reloc
> - Rewrite commit message
> - Collect r-b tag

This patch breaks boot on AM642-EVM. Boot log at the end.

> 
>  drivers/core/ofnode.c | 2 +-
>  include/dm/ofnode.h   | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 8df16e56af5c..b1e94b2d60df 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1353,7 +1353,7 @@ bool ofnode_pre_reloc(ofnode node)
>  	 */
>  	if (ofnode_read_bool(node, "bootph-pre-ram") ||
>  	    ofnode_read_bool(node, "bootph-pre-sram"))
> -		return true;
> +		return gd->flags & GD_FLG_RELOC;
>  
>  	if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
>  		/* detect and handle old tags */
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 0f38b3e736de..13700f8266d7 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -1198,15 +1198,15 @@ int ofnode_read_simple_size_cells(ofnode node);
>   * determine if a node was bound in one of SPL/TPL stages.
>   *
>   * There are 4 settings currently in use
> - * - bootph-some-ram: U-Boot proper pre-relocation only
> + * - bootph-some-ram: U-Boot proper pre-relocation phase
>   * - bootph-all: all phases
>   * Existing platforms only use it to indicate nodes needed in
>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
> - * - bootph-pre-ram: SPL and U-Boot pre-relocation
> - * - bootph-pre-sram: TPL and U-Boot pre-relocation
> + * - bootph-pre-ram: SPL phase
> + * - bootph-pre-sram: TPL phase
>   *
>   * @node: node to check
> - * Return: true if node is needed in SPL/TL, false otherwise
> + * Return: true if node should be or was bound, false otherwise
>   */
>  bool ofnode_pre_reloc(ofnode node);
>  

---boot log---

U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
Resetting on cold boot to workaround ErrataID:i2331
Please resend tiboot3.bin in case of UART/DFU boot
resetting ...

U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:53:09 +0300)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
SPL initial stack usage: 13408 bytes
Trying to boot from MMC2
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Loading Environment from MMC... *** Warning - No MMC card found, using default environment

Starting ATF on ARM64 core...

NOTICE:  BL31: v2.8(release):v2.8-226-g2fcd408bb3-dirty
NOTICE:  BL31: Built : 00:42:57, Jan 13 2023
I/TC: 
I/TC: OP-TEE version: 3.20.0 (gcc version 11.3.0 (GCC)) #1 Fri Jan 20 15:42:54 UTC 2023 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Activated SA2UL device
I/TC: Fixing SA2UL firewall owner for GP device
I/TC: Enabled firewalls for SA2UL TRNG device
I/TC: SA2UL TRNG initialized
I/TC: SA2UL Drivers initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2023.10-rc4-00480-g9e644284ab (Sep 28 2023 - 15:54:37 +0300)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
Trying to boot from MMC2
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted

---boot log end---

we expect U-Boot banner to be printed next but nothing is printed.

-- 
cheers,
-roger
