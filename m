Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FADCC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 15:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FCC80C83;
	Mon, 12 May 2025 17:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=epochal.quest header.i=@epochal.quest header.b="F1v1ZMK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB40C81DD6; Mon, 12 May 2025 17:12:42 +0200 (CEST)
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1502805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 17:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masterr3c0rd@epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
 s=default; t=1747062759;
 bh=QuLJIuAQnXAdeilq2O8Kju7ulUQVs2l2UzjpfDomQCg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=F1v1ZMK3O9J2OID5oiYW2O1Gd6ANC517BZRfaLJJQhCNwlvOrc0uF/9dqzxkuvIFX
 ltC/ZBG6bqQYZ1Gxlhd0shGEiviTCQh6ZpABVq1tUmF8b+318yEK9rNiRZqEfym2IV
 Ap1va4i1X5D95Yf39G/+2GREGqBozrfUKPuK9rRArjcs3y9vYuEOaIGYs03fegAUSH
 44O+Sffa3qvx5s9t6eT8yX0m9qLsQPa/MiDeMVM68G4bUyH9aYPrghxs5syJN8Qi1e
 rGTFHrBc4mFKFm7BZh/4LAfHGw8M1Xq6SJ1yFJDdzLwUckboVF/Hmtn70MpIGe1cFT
 hLC2sHbghWJcw==
MIME-Version: 1.0
Date: Mon, 12 May 2025 12:12:36 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Philippe
 Simons <simons.philippe@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 linux-sunxi@lists.linux.dev, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 1/6] sunxi: A133: add DRAM init code
In-Reply-To: <20250511011003.15654-2-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-2-andre.przywara@arm.com>
Message-ID: <20165cde26bb95b5f79d01d37f1f4af2@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

On 2025/05/10 10:09 pm, Andre Przywara wrote:
> From: Cody Eksal <masterr3c0rd@epochal.quest>
> 
> This adds preliminary support for the DRAM controller in the Allwinner
> A100/A133 SoCs.
> This is work in progress, and has rough edges, but works on at least
> three different boards. It contains support for DDR4 and LPDDR4.
> 
> [Andre: formatting fixes, adapt to mainline, drop unused parameters,
> 	remove struct struct sunxi_mctl_com_reg, hardcode MR registers,
> 	switch to mctl_check_pattern(), remove simple DRAM check]

Thank you Andre for cleaning up my patches. Life has a nasty way of
getting in the way when it's least convenient.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

- Cody

> ---
>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>  .../include/asm/arch-sunxi/dram_sun50i_a133.h |  230 ++++
>  arch/arm/mach-sunxi/Kconfig                   |  104 +-
>  arch/arm/mach-sunxi/Makefile                  |    2 +
>  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1204 +++++++++++++++++
>  arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
>  arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
>  .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
>  9 files changed, 1722 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
>  create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
> 
