Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FC0C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758948091A;
	Mon, 12 May 2025 11:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3639C81DD6; Mon, 12 May 2025 11:36:38 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22720805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54C9aBeF085126
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 12 May 2025 17:36:11 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 17:36:11 +0800
Date: Mon, 12 May 2025 17:36:09 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, "Mayuresh
 Chitale" <mchitale@ventanamicro.com>, Anton Blanchard
 <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Evgeny Bachinin
 <EABachinin@salutedevices.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 "Nishanth Menon" <nm@ti.com>, <u-boot@lists.denx.de>, Nathaniel Hourt
 <I@nathaniel.land>
Subject: Re: [PATCH 2/2] riscv: Access gd with inline assembly when building
 with LTO or Clang
Message-ID: <aCHBCXzGA_lDiSwt@swlinux02>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-3-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250427145011.17331-3-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54C9aBeF085126
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

On Sun, Apr 27, 2025 at 02:50:11PM +0000, Yao Zi wrote:
> Similar to AArch64's case, Clang may wrongly fold accesses to gd pointer
> which is defined with register qualifier into constants, breaking
> various components.
> 
> This patch defines gd as a macro when building with Clang or LTO, which
> expands to get_gd() that accesses gp pointer in assembly, making RISC-V
> ports function properly and preparing for introduction of LTO in the
> future. Board initialization code is also adapted for non-assignable gd.
> 
> Reported-by: Nathaniel Hourt <I@nathaniel.land>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/cpu/cpu.c                 |  6 ++++++
>  arch/riscv/include/asm/global_data.h | 19 +++++++++++++++++++
>  common/board_r.c                     |  4 +++-
>  common/init/board_init.c             |  7 +++++--
>  4 files changed, 33 insertions(+), 3 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
