Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D25C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 08:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD628091A;
	Thu,  5 Jun 2025 10:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="wp6sfU98";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="qeozFeBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5442981E25; Thu,  5 Jun 2025 10:46:20 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6408C80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 10:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 25cf9eeb;
 Thu, 5 Jun 2025 08:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=s1; bh=j
 MxEZQMaq2BsOLrHHtCevByCBMQ=; b=wp6sfU98+E5ANiqOQ/PyeDWt+CwKleSyo
 YaQFvwk4rqGBN0VvR1s0NLKWOBOIbJ3d6U837BFlR/AtYiygoXIr1baS4HTDgIDt
 okuJgL2TSUQNp18xa/tIMbolamIF5YavhEibLur39WOi7P9JyZG+HzXHM5v5hlqp
 21YcLAV9hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=date
 :from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; q=dns; s=
 s1; b=gF1nCtEeOxUF1JjnQcc71aOl/Mo+V+8/qfkVhHNHvm1UFn/w9oVdr8TsP8
 ubl3mHXGetVRG5We/7F3KIz00TqQXvabYmOiq39EIjs6JSVYtAlzLTujjAk6RUs/
 3DVxd43mOGwu9Lp+1Py5CRDPfFzRdj30Sebh6ZXequN7+4nRk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1749113169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG8yW7TZ3ToTqo1IyLZrEk4eLG21E1XTeexOxAauAnY=;
 b=qeozFeBKKi4laZ3FfIkrRiTekW9E98tc3+Er+ER8S01WeIILu7uiS3I+2RpRKwg6yWVwJW
 2lGzqVdDpkqKt0gjvx4g8mk85g1Zn9i9bLK3DKilPNBIbxBvDzVXGJTpW7Q4Xoygib5aUn
 +JaWvvkRFxA6U18j2rMDoDfD3MPQGlA=
Received: from archlinux (host-80-116-51-117.pool80116.interbusiness.it
 [80.116.51.117])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 6e61dc0a
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 5 Jun 2025 08:46:09 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:45:02 +0200
From: Angelo Dureghello <angelo@kernel-space.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Alexey Brodkin
 <alexey.brodkin@synopsys.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Rick Chen <rick@andestech.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 06/12] m68k: drop pointless #if 0 block
Message-ID: <20250605104502.54e16e7a@archlinux>
In-Reply-To: <20250604195612.2312979-7-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604195612.2312979-7-ravi@prevas.dk>
Organization: kernelspace
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
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


thanks,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On Wed,  4 Jun 2025 21:56:06 +0200

Rasmus Villemoes <ravi@prevas.dk> wrote:

> The way DECLARE_GLOBAL_DATA_PTR is used, the stuff under #if 0 can
> never compile as you cannot have a non-constant initializer at global
> scope (and one would get linker errors as well because the 'gd' symbol
> would be defined in multiple TUs).
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  arch/m68k/include/asm/global_data.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
> index 29b46645676..aea2ccabe08 100644
> --- a/arch/m68k/include/asm/global_data.h
> +++ b/arch/m68k/include/asm/global_data.h
> @@ -32,11 +32,6 @@ struct arch_global_data {
>  
>  #include <asm-generic/global_data.h>
>  
> -#if 0
> -extern gd_t *global_data;
> -#define DECLARE_GLOBAL_DATA_PTR     gd_t *gd = global_data
> -#else
>  #define DECLARE_GLOBAL_DATA_PTR     register gd_t *gd asm ("d7")
> -#endif
>  
>  #endif /* __ASM_GBL_DATA_H */
> -- 
> 2.49.0
> 
