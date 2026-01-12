Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8755C9EC8D
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A315838A5;
	Mon, 12 Jan 2026 15:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bx5jYVpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED9283923; Mon, 12 Jan 2026 15:41:06 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12EA983885
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dqZn95YF3z9spP;
 Mon, 12 Jan 2026 15:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768228861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbbGfSueASLDGMSlhQ214Tbdjuv8gXSR1eJ8D5lCFHw=;
 b=bx5jYVppAWQTGNuU8D6NwjVNwdmOkCF3VYI99d6kU6MqXH4erRO4IzxhdVE18V70AcNnaP
 xsXjwktuD2hpb8HnhgXLaQBfB6gnwr5/OaODIzmw9whdEsTPYtj3VTO/9WNOumD4O9S+ta
 L0+P0qmTDG16IThVmH6UNze16y4IPmpvftiBq40TkbMJkg6irjF9f8c59/2a+Sgk/DN35x
 8l8D2In4s4YdfiSk3R6k6zWwDInb5sT9ualeQmU70EFv4sRTkFbYdK4jMOfVJ0Mf9SLeEV
 9AWY7xHutegGWF8+tPXyqYx6Ryg4OZTnDCyPQpRrpWo+SelAhFYjTiV/mh/hUw==
Message-ID: <f7562e91-03cb-4bb9-aabe-e7c0b6ea1b6b@mailbox.org>
Date: Mon, 12 Jan 2026 15:40:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Beleswar Padhi <b-padhi@ti.com>, trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 james.hilliard1@gmail.com, anshuld@ti.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260112101102.1417970-3-b-padhi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b23ef23f7d06fc7d3bf
X-MBO-RS-META: eainu6qkkp55paz5kc8pm3xk4te66uy3
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

On 1/12/26 11:11 AM, Beleswar Padhi wrote:
> The OMAP2 SPL linker script (also used for K3 platforms) currently uses
> a 4-byte alignment directive after the __u_boot_list section. This
> alignment directive only advances the location counter without padding
> the actual binary output.
> 
> When objcopy extracts u-boot-spl-nodtb.bin, it includes only actual
> data, stopping at the last byte of __u_boot_list (e.g., 0x41c359fc),
> not an aligned address (e.g., 0x41c35a00). So, when the FIT image
> containing device trees is concatenated to the SPL binary, it gets
> appended at this unaligned file size, causing libfdt validation failure.
> 
> To fix this, move the alignment directive into the __u_boot_list section
> itself and make it 8-byte aligned as per DT spec. This forces the linker
> to include padding as part of the section data, ensuring objcopy
> includes the padding bytes in the binary and the appended FIT image
> starts at an 8-byte aligned boundary.
> 
> Reported-by: Anshul Dalal <anshuld@ti.com>
> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> 1. Get rid of extra ALIGN() directive, replace it with a comment
> 2. Carry Reported-by, Closes and Fixes tag.
> 
> Link to v1:
> https://lore.kernel.org/all/20260109190026.58464-3-b-padhi@ti.com/
> 
>   arch/arm/mach-omap2/u-boot-spl.lds | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/u-boot-spl.lds b/arch/arm/mach-omap2/u-boot-spl.lds
> index 3bb759d8a1c..5ad169a37b7 100644
> --- a/arch/arm/mach-omap2/u-boot-spl.lds
> +++ b/arch/arm/mach-omap2/u-boot-spl.lds
> @@ -35,9 +35,13 @@ SECTIONS
>   	. = ALIGN(4);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
> +		/*
> +		 * Ensure 8-byte alignment at the end of the last section before
> +		 * DTB is appended, to satisfy DT spec alignment requirements
> +		 */
> +		. = ALIGN(8);
>   	} >.sram
Does this work even if the __u_boot_list section is empty ?

I think what you need is unconditional alignment of the end of the 
binary, that has to be 8 bytes aligned.
