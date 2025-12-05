Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83351D2F7EE
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 13:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72278042F;
	Fri,  5 Dec 2025 14:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BQJynffr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32B2809A5; Fri,  5 Dec 2025 14:53:06 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204438004F
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 14:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA3A43AF5;
 Fri,  5 Dec 2025 13:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB778C4CEF1;
 Fri,  5 Dec 2025 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764942782;
 bh=tIQNQxgEwWrx/A3zja2NFK5UaPdQCTCajcGDrnuivvk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BQJynffrMUPLNHPKjQYZMOx80GMLMHWnTmPxIc8NgCc0aErxG749um1QiyO/cf/OS
 +/5qa8uPUU3xKok3VgSOkQitrD9aLZ66Q9LpKZouOmzlSJFyof5OvbJMqZjk8NWfyW
 KoMLUfVDP0z4pWW+ICCJLGeHsrJmCMh6OGTmX455UQd0Ukwh4NReWx8bGxZqx5uGNJ
 PJbwU+7fPPIuqMzfEpRgwzNyZOn0y7LRlVwtbvRCSoetEfv6jgb+KSYjuVNs9iM/mr
 aHyiufhmXfY6WkO6SVYs+hkBrDG0rPLdJoAKAtcgpz7PnugjLciMpHpBJJqQYmH26m
 OfYvXsqUZRI7A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Udit Kumar <u-kumar1@ti.com>, trini@konsulko.com
Cc: nm@ti.com, u-boot@lists.denx.de, mkorpershoek@kernel.org,
 n-francis@ti.com, anshuld@ti.com, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v2] doc: board: ti: Add J742S2 support
In-Reply-To: <20251205043602.845730-1-u-kumar1@ti.com>
References: <20251205043602.845730-1-u-kumar1@ti.com>
Date: Fri, 05 Dec 2025 14:52:59 +0100
Message-ID: <87pl8trq6c.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Udit,

Thank you for the patch.

On Fri, Dec 05, 2025 at 10:06, Udit Kumar <u-kumar1@ti.com> wrote:

> J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
> to build u-boot for J742S2 EVM board.
>
> Add guide users on how to build for that board.
>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Test logs
> https://gist.github.com/uditkumarti/b2e23151728628805a680b6eab528e7c
>
> Changelog:
> Changes in v2:
> - Removed extra =
> - link to v1:
> https://lore.kernel.org/all/20251204142451.834404-1-u-kumar1@ti.com/
>
>  doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index 22442874110..69deeee1076 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>  .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
>  
> -J784S4 and AM69 Platforms
> -=========================
> +J742S2, J784S4 and AM69 Platforms
> +=================================
>  
>  Introduction
>  ------------
> @@ -37,6 +37,11 @@ Platform information:
>  * https://www.ti.com/tool/J784S4XEVM
>  * https://www.ti.com/tool/SK-AM69
>  
> +J742S2 is derivative of J784S24 SOC, More info can be found in
> +
> +* TRM : https://www.ti.com/lit/ug/spruje3/spruje3.pdf
> +* Platform Information : https://www.ti.com/tool/J742S2XH01EVM
> +
>  Boot Flow
>  ---------
>  Below is the pictorial representation of boot flow:
> @@ -99,6 +104,15 @@ Set the variables corresponding to this platform:
>        export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
>        export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
>  
> +.. note::
> +
> +   For J742S2-EVM, use the following U_BOOT_CFG instead:
> +
> +   .. prompt:: bash
> +
> +      export UBOOT_CFG_CORTEXR=j742s2_evm_r5_defconfig
> +      export UBOOT_CFG_CORTEXA=j742s2_evm_a72_defconfig
> +

nitpick: Can't this be grouped in the same .. note:: block as for AM69
defconfigs ?

I tend to dislike multiple notes blocks one after another.
It is fine if you don't want to change this as it's a "personal preference".

>  .. j784s4_evm_rst_include_start_build_steps
>  
>  1. Trusted Firmware-A
> @@ -146,13 +160,19 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
>   - HS-FS
>  
>      * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
> +    * tiboot3-j742s2-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>      * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
>  
>   - HS-SE
>  
>      * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
> +    * tiboot3-j742s2-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>      * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
>  
> +.. note::
> +
> +   For J742S2, GP variant is not available.
> +

Can't this note be in the - GP section?
Just after:
"""
    * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
"""

In my opinion, it would make more sense than at the end of the
Target Images section.

>  Image formats
>  -------------
>  
> -- 
> 2.34.1
