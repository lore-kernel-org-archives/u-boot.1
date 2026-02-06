Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6BBEE209E
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 12:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA68F83B86;
	Fri,  6 Feb 2026 13:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ueMOftOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 430C783A64; Fri,  6 Feb 2026 08:18:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F4A836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chleroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 15F8A41866;
 Fri,  6 Feb 2026 07:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B112C116C6;
 Fri,  6 Feb 2026 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770362301;
 bh=f9iiI6yOmbJWv0To+zs4hRraG6yuRXPKYD/8AbQXvmw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ueMOftOnFmypUEBo1mOTBv0Lrd6O8l2PY/9J26Zk366wPUsSI5Iw47IzJabuS0wEP
 WWUcgl3xgUiN780zqSdU8o0Qb19gQvDX3liILHiDOHgE5U4n1SUbyjOXbPmx+2nyv+
 4ao49rjHrN1g0EoK+Yd8lF8xhVhve+slEh8gq8DenLHRvRMSZIvdPWg1EFNMUsAYmH
 XeqaKMF6xnkZfmsMp3n0v+0KsHACxHf5L3GizTm5zHvqZ2NkkSmwqsfnFGQxxTXHNW
 +f47wPtpvXm2WXalDgGzPlQnmOF5J8EDfSqJJkbI4Q1+Uql5M75OAIeOYLNTe7xT4b
 TqnwD3VWuK0jQ==
Message-ID: <937f4082-985e-4f14-bd90-1bcddd62b8b0@kernel.org>
Date: Fri, 6 Feb 2026 08:18:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] powerpc: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-8-trini@konsulko.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260115222828.3931345-8-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Feb 2026 13:53:15 +0100
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



Le 15/01/2026 à 23:19, Tom Rini a écrit :
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end by 8-bytes by adding '. =
>    ALIGN(8);' or changing an existing ALIGN(4) statement.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>    aligned we fail to link (and explain why).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Cc: "Marek Behún" <kabel@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>   arch/powerpc/cpu/mpc83xx/u-boot.lds | 3 +++
>   arch/powerpc/cpu/mpc85xx/u-boot.lds | 4 +++-
>   board/cssi/cmpc885/u-boot.lds       | 3 +++
>   board/cssi/mcr3000/u-boot.lds       | 3 +++
>   4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/cpu/mpc83xx/u-boot.lds b/arch/powerpc/cpu/mpc83xx/u-boot.lds
> index 1a1e537b2a76..5becc4d236ef 100644
> --- a/arch/powerpc/cpu/mpc83xx/u-boot.lds
> +++ b/arch/powerpc/cpu/mpc83xx/u-boot.lds
> @@ -56,6 +56,7 @@ SECTIONS
>      * _end - This is end of u-boot.bin image.
>      * dtb will be appended here to make u-boot-dtb.bin
>      */
> +  . = ALIGN(8);
>     _end = .;
>   
>     . = ALIGN(4096);
> @@ -77,3 +78,5 @@ SECTIONS
>     PROVIDE (end = .);
>   }
>   ENTRY(_start)
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/arch/powerpc/cpu/mpc85xx/u-boot.lds b/arch/powerpc/cpu/mpc85xx/u-boot.lds
> index 3af0dfdf336b..3c9959bef097 100644
> --- a/arch/powerpc/cpu/mpc85xx/u-boot.lds
> +++ b/arch/powerpc/cpu/mpc85xx/u-boot.lds
> @@ -78,7 +78,7 @@ SECTIONS
>     __init_begin = .;
>     .text.init : { *(.text.init) }
>     .data.init : { *(.data.init) }
> -  . = ALIGN(4);
> +  . = ALIGN(8);
>     __init_end = .;
>     _end = .;
>   
> @@ -119,3 +119,5 @@ SECTIONS
>     __bss_end = . ;
>     PROVIDE (end = .);
>   }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/board/cssi/cmpc885/u-boot.lds b/board/cssi/cmpc885/u-boot.lds
> index 167606357e00..da9cff64d465 100644
> --- a/board/cssi/cmpc885/u-boot.lds
> +++ b/board/cssi/cmpc885/u-boot.lds
> @@ -72,6 +72,7 @@ SECTIONS
>   	 * _end - This is end of u-boot.bin image.
>   	 * dtb will be appended here to make u-boot-dtb.bin
>   	 */
> +	. = ALIGN(8);
>   	_end = .;
>   
>   	. = ALIGN(4096);
> @@ -93,3 +94,5 @@ SECTIONS
>   	PROVIDE (end = .);
>   }
>   ENTRY(_start)
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> diff --git a/board/cssi/mcr3000/u-boot.lds b/board/cssi/mcr3000/u-boot.lds
> index 66afdebc0f77..1fd98726b2a8 100644
> --- a/board/cssi/mcr3000/u-boot.lds
> +++ b/board/cssi/mcr3000/u-boot.lds
> @@ -72,6 +72,7 @@ SECTIONS
>   	 * _end - This is end of u-boot.bin image.
>   	 * dtb will be appended here to make u-boot-dtb.bin
>   	 */
> +	. = ALIGN(8);
>   	_end = .;
>   
>   	. = ALIGN(4096);
> @@ -93,3 +94,5 @@ SECTIONS
>   	PROVIDE (end = .);
>   }
>   ENTRY(_start)
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");

