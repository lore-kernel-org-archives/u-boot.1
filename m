Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB73D2AB0A
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 09:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5844890CE;
	Tue, 29 Oct 2024 10:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FD28910C; Tue, 29 Oct 2024 10:35:24 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507F38904E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 10:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 49T9ZA3M047964
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 29 Oct 2024 17:35:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 17:35:10 +0800
Date: Tue, 29 Oct 2024 17:35:04 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <ZyCr3a8I52q1gkfZ@swlinux02>
References: <Zx-C0_rHzfNmG-yt@swlinux02> <20241028152010.GP4959@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028152010.GP4959@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 49T9ZA3M047964
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

Hi Tom,

On Mon, Oct 28, 2024 at 09:20:10AM -0600, Tom Rini wrote:
> [EXTERNAL MAIL]
> Date: Mon, 28 Oct 2024 09:20:10 -0600
> From: Tom Rini <trini@konsulko.com>
> To: Leo Liang <ycliang@andestech.com>
> Cc: u-boot@lists.denx.de, rick@andestech.com
> Subject: Re: [GIT PULL] u-boot-riscv/next
> 
> On Mon, Oct 28, 2024 at 08:25:55PM +0800, Leo Liang wrote:
> > Hi Tom,
> > 
> > The following changes since commit 28dc47038edc4e93f32d75a357131bcf01a18d85:
> > 
> >   Merge branch 'u-boot-nand-20241005' of https://gitlab.denx.de/u-boot/custodians/u-boot-nand-flash into next (2024-10-05 11:19:24 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> > 
> > for you to fetch changes up to f07daa5967f65771f90221ee9bfad9814e549647:
> > 
> >   riscv: mbv: Align DT with QEMU (2024-10-28 17:49:25 +0800)
> > 
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/23049
> > 
> > ----------------------------------------------------------------
> > Michal Simek (1):
> >       riscv: mbv: Align DT with QEMU
> > 
> >  arch/riscv/dts/xilinx-mbv32.dts | 30 ++++++++++--------------------
> >  board/xilinx/mbv/Kconfig        |  6 +++---
> >  configs/xilinx_mbv32_defconfig  | 12 ++++++------
> >  3 files changed, 19 insertions(+), 29 deletions(-)
> 
> Why is this for -next and not master? We're not so far in to the cycle
> that next is open, and this seems clear enough to pull in today. Thanks.
> 
> -- 
> Tom


Michal said that this patch might have to wait for its counterpart in QEMU be merged.
(https://lore.kernel.org/all/20241017072507.4033413-1-sai.pavan.boddu@amd.com/)
But like you said, this seems clear enough for master. I will create another PR for this patch. 
Thanks!

Best regards,
Leo
