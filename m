Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C51075260
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 06:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C1D83AC5;
	Thu, 19 Mar 2026 07:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE3583BC8; Thu, 19 Mar 2026 07:45:17 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E278341A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 07:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J6iCx3061597;
 Thu, 19 Mar 2026 14:44:12 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 14:44:11 +0800
Date: Thu, 19 Mar 2026 14:44:08 +0800
From: Leo Liang <ycliang@andestech.com>
To: Raymond Mao <raymondmaoca@gmail.com>
CC: <u-boot@lists.denx.de>, <uboot@riscstar.com>, <u-boot-spacemit@groups.io>, 
 <raymond.mao@riscstar.com>, <rick@andestech.com>, <trini@konsulko.com>,
 <lukma@denx.de>, <hs@nabladev.com>, <jh80.chung@samsung.com>,
 <peng.fan@nxp.com>, <xypron.glpk@gmx.de>, <randolph@andestech.com>,
 <dlan@gentoo.org>, <junhui.liu@pigmoral.tech>,
 <neil.armstrong@linaro.org>, <quentin.schulz@cherry.de>,
 <samuel@sholland.org>
Subject: Re: [PATCH v2 01/16] spacemit: k1: support multi-board infrastructure
Message-ID: <abubOI6SAnAszlWh@swlinux02>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
 <20260210151459.2348758-2-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210151459.2348758-2-raymondmaoca@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J6iCx3061597
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

Hi Raymond,

On Tue, Feb 10, 2026 at 10:14:44AM -0500, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Restructure K1 SoC support to handle multiple boards through a single
> configuration:
> 
> 1. Rename bananapi-f3_defconfig to k1_defconfig.
> 2. Move all K1 board files to k1 directory.
> 
> Eliminates the need for board-specific defconfigs while maintaining
> hardware compatibility.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  arch/riscv/Kconfig                                    | 10 ++++++----
>  arch/riscv/cpu/k1/Kconfig                             |  4 ++++
>  board/spacemit/{bananapi-f3 => k1}/Kconfig            | 11 ++++++++---
>  board/spacemit/{bananapi-f3 => k1}/MAINTAINERS        |  4 ++--
>  board/spacemit/{bananapi-f3 => k1}/Makefile           |  0
>  board/spacemit/{bananapi-f3 => k1}/board.c            |  0
>  .../{bananapi-f3_defconfig => spacemit_k1_defconfig}  |  3 ++-
>  doc/board/spacemit/bananapi-f3.rst                    |  2 +-
>  include/configs/{bananapi-f3.h => k1.h}               |  0
>  9 files changed, 23 insertions(+), 11 deletions(-)
>  rename board/spacemit/{bananapi-f3 => k1}/Kconfig (63%)
>  rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
>  rename board/spacemit/{bananapi-f3 => k1}/Makefile (100%)
>  rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
>  rename configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} (97%)
>  rename include/configs/{bananapi-f3.h => k1.h} (100%)

This patch seems to cause recursive dependency error.
https://source.denx.de/u-boot/custodians/u-boot-riscv/-/jobs/1405503
Could you fix this and respin the patchset again?

Best regards,
Leo
