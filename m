Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40B2C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 07:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E36F89092;
	Fri, 26 Apr 2024 09:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E998912C; Fri, 26 Apr 2024 09:52:28 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9278823F
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 09:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 43Q7pt3o031470;
 Fri, 26 Apr 2024 15:51:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Fri, 26 Apr 2024 15:51:53 +0800
Date: Fri, 26 Apr 2024 15:51:49 +0800
From: Leo Liang <ycliang@andestech.com>
To: <lukas.funke-oss@weidmueller.com>
CC: <u-boot@lists.denx.de>, E Shattow <lucent@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Lukas Funke <lukas.funke@weidmueller.com>, Anup Patel
 <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Green Wan
 <green.wan@sifive.com>, Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Tom Rini
 <trini@konsulko.com>, Vincent Chen <vincent.chen@sifive.com>, Zong Li
 <zong.li@sifve.com>
Subject: Re: [PATCH v3 1/2] board: sifive: Rename spl_soc_init() to
 spl_dram_init()
Message-ID: <ZitdFfUfBRHb5tNL@swlinux02>
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
 <20240424074339.210851-2-lukas.funke-oss@weidmueller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424074339.210851-2-lukas.funke-oss@weidmueller.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 43Q7pt3o031470
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

On Wed, Apr 24, 2024 at 09:43:38AM +0200, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Rename spl_soc_init() to spl_dram_init() because the generic function
> name does not reflect what the function actually does. Also
> spl_dram_init() is commonly used for dram initialization and should be
> called from board_init_f().
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>  arch/riscv/cpu/fu540/spl.c              | 2 +-
>  arch/riscv/cpu/fu740/spl.c              | 2 +-
>  arch/riscv/include/asm/arch-fu540/spl.h | 2 +-
>  arch/riscv/include/asm/arch-fu740/spl.h | 2 +-
>  board/sifive/unleashed/spl.c            | 4 ++--
>  board/sifive/unmatched/spl.c            | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
