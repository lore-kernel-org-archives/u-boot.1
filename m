Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E6C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 05:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF2258319A;
	Thu, 31 Jul 2025 07:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="C54//sNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB98832DA; Thu, 31 Jul 2025 07:57:34 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844E88318E
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 07:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4109B20A37;
 Thu, 31 Jul 2025 07:57:32 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gvuavtH7cPP8; Thu, 31 Jul 2025 07:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1753941451; bh=I+6JXMkYv8E04mksrM7K/WfIijlHR78M+DpAxS8EsIc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C54//sNUDcTpggOq7S1sWQgiZDFi6r9ix2A5BobXtpPGFsLANMnCw/n/uo7Vxok33
 hGSP4khIuQSeOLgCc+mCZFcvnt4My+9yI1fLiOHLxlT/JjpR1MZLiq5v1fXmrW/PGe
 AqfXWkGkl/W4rBEE6VswHYrC6wRuLUsOSCX71G7CysVryepcbZ0EPOU5Tol7MRAV0C
 Qv2HBPJbNXP+lWV7LXlUU+2HSx07aVkRYdJDDV4i+9osAlvA6uVLdnoAHzmH9KqZy6
 4L0DfR2FckKva5ypSf4ZN0j/L9dIgHcdbT1xDELhFKJiK0GwAStXOHTBbfJ9dm2NPf
 th7U0Ki625PPA==
Date: Thu, 31 Jul 2025 05:57:14 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: Re: [PATCH v3 12/12] timer: p8700: Add support for reading time from
 memory-mapped mtime
Message-ID: <aIsFunyE5mGhGhbV@pie>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
 <20250729162035.209849-13-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729162035.209849-13-uros.stajic@htecgroup.com>
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

On Tue, Jul 29, 2025 at 04:25:14PM +0000, Uros Stajic wrote:
> The P8700 core does not support reading the time CSR directly and
> raises an illegal instruction exception. This patch adds support for
> reading the timer value via its memory-mapped address at 0x16108050
> when running on a P8700 processor.
> 
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  drivers/timer/riscv_timer.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Sorry that I didn't review v2 further, but

> diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
> index 1f4980ceb38..5138236a028 100644
> --- a/drivers/timer/riscv_timer.c
> +++ b/drivers/timer/riscv_timer.c
> @@ -18,8 +18,15 @@
>  #include <timer.h>
>  #include <asm/csr.h>
>  
> +#define P8700_TIMER_ADDR 0x16108050
> +
>  static u64 notrace riscv_timer_get_count(struct udevice *dev)
>  {
> +	if (IS_ENABLED(CONFIG_P8700_RISCV)) {
> +		u32 *mtime_addr = (u32 *)P8700_TIMER_ADDR;
> +		return *mtime_addr;
> +	}
> +

This introduces platform-specific code to the generic RISC-V
TIME-CSR-based timer driver.

If your platform doesn't implement a TIME CSR in hardware, I suggest
using riscv_aclint_timer.c if the provider of P8700_TIMER is
compatible with the RISC-V ACLINT specification, or just introducing a
new driver otherwise.

Regards,
Yao Zi

>  	__maybe_unused u32 hi, lo;
>  
>  	if (IS_ENABLED(CONFIG_64BIT))
> -- 
> 2.34.1
