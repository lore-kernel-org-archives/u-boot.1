Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584DEC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 11:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A129B80885;
	Wed, 29 Jan 2025 12:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF5080EEF; Wed, 29 Jan 2025 12:28:52 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 928F480820
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 12:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.60.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 041353430AB;
 Wed, 29 Jan 2025 11:28:47 +0000 (UTC)
Date: Wed, 29 Jan 2025 11:28:38 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/3] Unify implementation of cleanup_before_linux()
 for RISC-V ports
Message-ID: <20250129112838-GYA50750@gentoo>
References: <20250123091134.63634-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123091134.63634-2-ziyao@disroot.org>
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

Hi Yao:

I think you can just drop "RFC" in next version

On 09:11 Thu 23 Jan     , Yao Zi wrote:
> This series introduces a generic version of cleanup_before_linux(),
> because most RISC-V SoCs have similar implementation. Ports for generic
> platforms and JH7110 are converted to use it for now: these devices are
> available to me and I have verified that Linux boots with these changes.
> 
thanks, generally I like this direction

> With a quick look at the codebase, I think this could be done for all
> RISC-V ports ultimately. Thanks for your feedback and review.
> 
can you go ahead and further cleanup other boards?

> Yao Zi (3):
>   riscv: add a generic implementation for cleanup_before_linux()
>   riscv: cpu: generic: fallback to generic cleanup_before_linux()
>   riscv: cpu: jh7110: fallback to generic cleanup_before_linux()
> 
>  arch/riscv/cpu/cpu.c            | 17 +++++++++++++++++
>  arch/riscv/cpu/generic/Makefile |  1 -
>  arch/riscv/cpu/generic/cpu.c    | 22 ----------------------
>  arch/riscv/cpu/jh7110/Makefile  |  1 -
>  arch/riscv/cpu/jh7110/cpu.c     | 23 -----------------------
>  5 files changed, 17 insertions(+), 47 deletions(-)
>  delete mode 100644 arch/riscv/cpu/generic/cpu.c
>  delete mode 100644 arch/riscv/cpu/jh7110/cpu.c
> 
> -- 
> 2.48.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
