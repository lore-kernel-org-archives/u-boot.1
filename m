Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C2AC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1307387579;
	Wed, 31 Jan 2024 09:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9446387579; Wed, 31 Jan 2024 09:15:20 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B1B87252
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V8F6D7035183;
 Wed, 31 Jan 2024 16:15:06 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 16:15:02 +0800
Date: Wed, 31 Jan 2024 16:14:59 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Bin Meng <bmeng@tinylab.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland
 <samuel@sholland.org>, Shengyu Qu <wiagn233@outlook.com>, Tom Rini
 <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>
Subject: Re: [PATCH v4 2/3] riscv: sophgo: milkv_duo: initial support added
Message-ID: <ZboBg8a_F9q8Sc9m@swlinux02>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-3-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240128070614.7702-3-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V8F6D7035183
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

On Sun, Jan 28, 2024 at 03:05:25PM +0800, Kongyang Liu wrote:
> Add support for Sophgo's Milk-V Duo board, only minimal device tree and
> serial console are enabled, and it can boot via vendor first stage
> bootloader.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Enable EFI loader
> 
> Changes in v2:
> - Fold the defconfig patch to first patch
> - Remove unnecessary environment settings of consoledev and baudrate in
>   config
> 
>  arch/riscv/Kconfig                 |  4 ++++
>  board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
>  board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
>  board/sophgo/milkv_duo/Makefile    |  5 +++++
>  board/sophgo/milkv_duo/board.c     |  9 +++++++++
>  configs/milkv_duo_defconfig        | 23 +++++++++++++++++++++++
>  include/configs/milkv_duo.h        | 12 ++++++++++++
>  7 files changed, 87 insertions(+)
>  create mode 100644 board/sophgo/milkv_duo/Kconfig
>  create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
>  create mode 100644 board/sophgo/milkv_duo/Makefile
>  create mode 100644 board/sophgo/milkv_duo/board.c
>  create mode 100644 configs/milkv_duo_defconfig
>  create mode 100644 include/configs/milkv_duo.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
