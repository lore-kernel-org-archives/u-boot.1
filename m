Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FBECCFA13
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 10:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD28839D5;
	Fri,  1 May 2026 12:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="nDr4SSl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8ADB83E36; Fri,  1 May 2026 12:33:54 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACC280F0E
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 12:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777631629; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X8e79iFB3EDywo3eZfEzLKXz3L5E37hexABimtMbLJpzQNGu9/+HhRyu46913GzFcWxhMrlBBJCBq5qHLcVOAVKJOGGYO7hDKsRT/2YKIYzfcws7EeZg9oWr8G0oFctObodKuMgKwYqq7/GRC47grBhCQNqa4dFD8jwWQHyDAug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777631629;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Tr8Xvcmi+yIRY7o2MMf5ncu6ZZG17Pzw9JTAEaIohl8=; 
 b=eIfGXVqnAYArD11wFT5zQqnYDbYUZ4bhHIlsjRjlj3aR9aInoboR1bJanSh3H4uzxoxq+EmyUxtrcSduG6wbxTgtCOkqvYBgCp8uV5ovKCOPiwaPlVW0523BLzBy2QTPLG4KegUxss82ndA++g0d5uxlNz4fxiJltzUH30mUSBY=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777631629; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=Tr8Xvcmi+yIRY7o2MMf5ncu6ZZG17Pzw9JTAEaIohl8=;
 b=nDr4SSl3UdfGiy2oPcnce4H9rDNKRSHEkk879SO4aw+tTcYeysHNhKjZD6XqKsf+
 nKaLS7MwVcQlXRiUZiCW+tX4jfvM6r3l71MoccwF3tbcIVlOnBlsqW9B9kKneHyTy6l
 /A2vG+oKXCXSDU4lkKbGPvVYTp0ZiSf6uAPAIz/Q=
Received: by mx.zohomail.com with SMTPS id 1777631626431565.5155886551786;
 Fri, 1 May 2026 03:33:46 -0700 (PDT)
Date: Fri, 1 May 2026 10:33:38 +0000
From: Yao Zi <me@ziyao.cc>
To: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, <git@amd.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Exclude ACLINT for TARGET_XILINX_MBV
Message-ID: <afSBgg0wWVBn5gju@pie>
References: <75160eb268d7a445e8483b357f7814bef30b12d4.1777550306.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75160eb268d7a445e8483b357f7814bef30b12d4.1777550306.git.michal.simek@amd.com>
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

On Thu, Apr 30, 2026 at 01:58:28PM +0200, Michal Simek wrote:
> The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block. The timer functionality is
> provided through a different mechanism.
> 
> Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
> for TARGET_XILINX_MBV while keeping the default behavior for other
> generic RISC-V targets that do have ACLINT hardware.
> 
>    spl/u-boot-spl: all -1382 data -360 rodata -200 text -822
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/riscv/cpu/generic/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/cpu/generic/Kconfig b/arch/riscv/cpu/generic/Kconfig
> index 2baba2299238..8d53c69ba38c 100644
> --- a/arch/riscv/cpu/generic/Kconfig
> +++ b/arch/riscv/cpu/generic/Kconfig
> @@ -10,8 +10,8 @@ config GENERIC_RISCV
>  	imply CPU
>  	imply CPU_RISCV
>  	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> -	imply RISCV_ACLINT if RISCV_MMODE
> -	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
> +	imply RISCV_ACLINT if RISCV_MMODE && !TARGET_XILINX_MBV
> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE && !TARGET_XILINX_MBV

Would it be a better idea to make (SPL_)RISCV_ACLINT visible and
override them in your platform defconfigs? This avoids introducing
platform-specific conditions in a "generic" CPU Kconfig.

Regards,
Yao Zi

>  	imply CMD_CPU
>  	imply SPL_CPU
>  	imply SPL_OPENSBI
> -- 
> 2.43.0
> 
> base-commit: 0d875f98e9d81b68265ea26c379dae8ce5b1f5a9
