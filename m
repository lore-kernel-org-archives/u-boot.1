Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79C5CFD376
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 03:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266D383DB6;
	Tue,  2 Dec 2025 04:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ia2lesXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2758B83DBD; Tue,  2 Dec 2025 04:57:31 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8446483D9F
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 04:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2E1A025EF5;
 Tue,  2 Dec 2025 04:57:28 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vELiOjfv5unj; Tue,  2 Dec 2025 04:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1764647847; bh=X+toGMRuTrQUniRlghNESm7nLNijtYZnys6hsf+wnqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ia2lesXMpT8PuCi4HsbQI2X4FSOBREGLErsvTTb///lGcF97b+EkiWJ5OiQQzxJbh
 K7aU2AHWOTxWXy+yKFuBoohS9Zn+wBn5GwM6l+ip98xizZKWvQKWTTD4TO1gKwHkjg
 vJAOigGqMumaEoo/lVfTm6mOPA9bXusd/lO/4ArhQFzsptC/Lz6r1VlXYArTe+c3X1
 B0fyDW6XlM9HjLx01qYT7BVv/aK7jMlomEUx1QriCA3w82Spmv+3Vgzr/lBgoWoN8x
 yq4hmVT5hlfCcguqgnuviJFjZXtBCyhWxAhIbn9erdBn4ZdERhF1p9dNG6lJhTtpfB
 NtXn6OTxHmuKQ==
Date: Tue, 2 Dec 2025 03:57:15 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] RISC-V: implement private GCC library
Message-ID: <aS5jmyp_VanBqY6h@pie>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
 <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
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

On Mon, Dec 01, 2025 at 06:49:03PM +0100, Heinrich Schuchardt wrote:
> The following functions are provided:
> 
> Count leading zero bits
> 
> * int __clzsi2 (unsigned int a)
> * int __clzdi2 (unsigned long a)
> * int __clzti2 (unsigned long long a)
> 
> Count trailing zero bits
> 
> * int __ctzsi2 (unsigned int a)
> * int __ctzdi2 (unsigned long a)
> * int __ctzti2 (unsigned long long a)
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

I noted there's another series with the same subject[1] sent almost at
the same time, and I couldn't tell the difference at the first glance.
Is this an incident?

>  arch/Kconfig            |   1 +
>  arch/riscv/lib/Makefile |   2 +
>  arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/lib/ctz.c    |  95 ++++++++++++++++++++++++++++++++++++
>  lib/Kconfig             |   2 +-
>  5 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/lib/clz.c
>  create mode 100644 arch/riscv/lib/ctz.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 3133f892f94..4af0da2485f 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -159,6 +159,7 @@ config PPC
>  config RISCV
>  	bool "RISC-V architecture"
>  	select CREATE_ARCH_SYMLINK
> +	select HAVE_PRIVATE_LIBGCC if 64BIT

Are 32-bit platforms excluded for lacking of enough library functions?
Should we exclude !RISCV_ISA_F || !RISCV_ISA_D platforms as well? Though
there's no in-tree 64-bit port without F/D extension.

>  	select HAVE_SETJMP
>  	select HAVE_INITJMP
>  	select SUPPORT_ACPI

Regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/20251201174705.652626-1-zfsdt@canonical.com/
