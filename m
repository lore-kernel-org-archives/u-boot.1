Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBFC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 11:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9E9832AD;
	Mon, 11 Aug 2025 13:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5861832DD; Mon, 11 Aug 2025 13:48:03 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2761A8329F
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 13:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57BBlI3X099746
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 11 Aug 2025 19:47:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 19:47:18 +0800
Date: Mon, 11 Aug 2025 19:47:15 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yixun Lan <dlan@gentoo.org>
CC: Niu Zhihong <zhihong@nzhnb.com>, <u-boot@lists.denx.de>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH] board: spacemit: Add SpacemiT MUSE Pi Pro
Message-ID: <aJnYQyfeWBaln8ff@swlinux02>
References: <20250728082547.454505-1-zhihong@nzhnb.com>
 <20250728100607-GYA777015@gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250728100607-GYA777015@gentoo>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57BBlI3X099746
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

On Mon, Jul 28, 2025 at 06:06:07PM +0800, Yixun Lan wrote:
> [EXTERNAL MAIL]
> 
> Hi Niu,
> 
>   You need to split the patch, and prepare a cover letter..
> 
>   Have to say, generally, this patch isn't really different comparing
> with current in tree bananapi-f3, so neither it is useful..
> 
>   I personally would expect to see more drivers support for K1 SoC,
> then figure out how to have more boards enabled..
>   (I'd propose to not merge this patch, but if maintainer is ok with
>   this, then I'd have no objection)

Hi Niu and Yixun,

I am OK merging the patch for new board,
but as Yixun and Yao's suggestion,
there are some modifications need to be made.
Please follow the advice and re-spin a patchset, thanks!

Best regards,
Leo

> 
>   CC spacemit mailing list for more wide comments
> 
> On 16:25 Mon 28 Jul     , Niu Zhihong wrote:
> > MUSE Pi Pro uses spacemit K1,
> > a new generation of octa-core 64-bit RISC-V processor,
> > which includes octa-core X60.
> >
> > Features tested on a MUSE Pi Pro 16GB:
> > - SD-card boot
> > - eMMC boot
> this brings some confusions, as currently there is no SD/eMMC driver support
> for K1, only means it's able to boot from SD/eMMC (with brom support)
> 
> >
> > Signed-off-by: Niu Zhihong <zhihong@nzhnb.com>
> > ---
> >  arch/riscv/Kconfig                     |  4 ++
> >  arch/riscv/dts/Makefile                |  1 +
> >  arch/riscv/dts/k1-muse-pi-pro.dts      | 27 ++++++++
> >  board/spacemit/muse-pi-pro/Kconfig     | 37 +++++++++++
> >  board/spacemit/muse-pi-pro/MAINTAINERS |  6 ++
> >  board/spacemit/muse-pi-pro/Makefile    |  3 +
> >  board/spacemit/muse-pi-pro/board.c     |  8 +++
> >  configs/muse-pi-pro_defconfig          |  6 ++
> >  doc/board/spacemit/index.rst           |  1 +
> >  doc/board/spacemit/muse-pi-pro.rst     | 85 ++++++++++++++++++++++++++
> >  include/configs/muse-pi-pro.h          | 11 ++++
> >  11 files changed, 189 insertions(+)
> >  create mode 100644 arch/riscv/dts/k1-muse-pi-pro.dts
> >  create mode 100644 board/spacemit/muse-pi-pro/Kconfig
> >  create mode 100644 board/spacemit/muse-pi-pro/MAINTAINERS
> >  create mode 100644 board/spacemit/muse-pi-pro/Makefile
> >  create mode 100644 board/spacemit/muse-pi-pro/board.c
> >  create mode 100644 configs/muse-pi-pro_defconfig
> >  create mode 100644 doc/board/spacemit/muse-pi-pro.rst
> >  create mode 100644 include/configs/muse-pi-pro.h
