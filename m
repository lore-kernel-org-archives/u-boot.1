Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDFCFED2DE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6EB183F8A;
	Thu, 12 Mar 2026 08:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="VgrZMk+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EF384099; Thu, 12 Mar 2026 08:40:40 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8A983F6D
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1773301232; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XN0qyEm+mvUSqM3nmJdR2rnVPDp9ohJ1lTj5Ah3T24w7O7uQ4TNAcJgYbxvQoRLyidpKPzLf/BZapRNmI8azpeBs1lWdPq9PhlCilLR3ODt4N8jfSXxT5Mf9E3tBou9rDZY+vVIJxud5B/1t+dwusPNVHcbfqdt3vHTyfeQbM6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773301232;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EKZtW1kcAU43xPVarbKry8rS6UPUp71e1zjkSeYjZ2o=; 
 b=JPbiNgfPUlB/jrGRGJGl4rckrNcydIBK3K9BfBukGwK552VFv6bo/OSoE0USllSUS47pvkPL7f19Pl9rHsOB3EQe/uMCc9ZdlNqSkR4HO+cNs1qi8JqoESrkcdd5g/rQk7TQNEbRC8PMJ6jQzpaYCjwUzo2c75LucShWmh/Qjms=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773301232; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=EKZtW1kcAU43xPVarbKry8rS6UPUp71e1zjkSeYjZ2o=;
 b=VgrZMk+xcNSd2n4OKP3pc9Ym84vyf6aWzIf4nW0IvQ0HsPlvZflDz1f+4Uxrr1Gw
 Sza0H6Rl/J2LyPHR30DO9BLvdEV/PMvY1irD7LYxe4uWWHVuo82wDvMjsmmGqkfMrxb
 WwNDDUpB+VHBvUGbdxwTh5dOKC88XtVrYSKKw490=
Received: by mx.zohomail.com with SMTPS id 1773301229074320.3486829100002;
 Thu, 12 Mar 2026 00:40:29 -0700 (PDT)
Date: Thu, 12 Mar 2026 07:40:22 +0000
From: Yao Zi <me@ziyao.cc>
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com,
 angelo@kernel-space.org
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] m68k: Add LTO support
Message-ID: <abJtug8itcufvkNk@pie>
References: <20260311093048.1773382-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311093048.1773382-1-daniel@thingy.jp>
X-ZohoMailClient: External
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

On Wed, Mar 11, 2026 at 06:30:48PM +0900, Daniel Palmer wrote:
> Most m68k retro/homebrew machines will have limited flash/RAM
> so having LTO working would be nice.
> 
> Not many changes are need really. Most of this is copy/paste
> from the ARM32 version.
> 
> The major change is that the direct register usage of d7 for gd
> needs to be hidden so that when LTO passes over everything it
> doesn't see multiple instances of d7.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
> 
> This is another patch from my vault that I have been using
> on various classic m68k machines for ages. I haven't tested
> it with coldfire though.
> 
>  arch/Kconfig                        |  1 +
>  arch/m68k/config.mk                 | 11 +++++++++--
>  arch/m68k/cpu/m680x0/cpu.c          |  2 +-
>  arch/m68k/include/asm/global_data.h | 19 +++++++++++++++++++
>  arch/m68k/lib/ashldi3.c             |  1 +
>  arch/m68k/lib/lshrdi3.c             |  1 +
>  arch/m68k/lib/muldi3.c              |  1 +
>  common/board_r.c                    |  4 ++--
>  common/init/board_init.c            |  2 +-
>  9 files changed, 36 insertions(+), 6 deletions(-)

...

> diff --git a/common/init/board_init.c b/common/init/board_init.c
> index 2a6f39f51adb..c56b33e7be7c 100644
> --- a/common/init/board_init.c
> +++ b/common/init/board_init.c
> @@ -17,7 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   * Unfortunately x86, ARM and RISC-V can't compile this code as gd is defined
>   * as macro and cannot be assigned.

This comment should probably be updated as well to reflect the code
behavior :)

>   */
> -#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV)
> +#if !defined(CONFIG_X86) && !defined(CONFIG_ARM) && !defined(CONFIG_RISCV) && !defined(CONFIG_M68K)
>  __weak void arch_setup_gd(struct global_data *gd_ptr)
>  {
>  	gd = gd_ptr;
> -- 
> 2.51.0
> 

Regards,
Yao Zi
