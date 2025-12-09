Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D102D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 03:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712FE83BBE;
	Tue,  9 Dec 2025 04:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F5083BDD; Tue,  9 Dec 2025 04:40:26 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE11683B81
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 04:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 5B93IrwK045083
 for <u-boot@lists.denx.de>; Tue, 9 Dec 2025 11:18:53 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B93Hglx044778
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 9 Dec 2025 11:17:42 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 11:17:42 +0800
Date: Tue, 9 Dec 2025 11:17:38 +0800
From: Leo Liang <ycliang@andestech.com>
To: <Jamie.Gibbons@microchip.com>
CC: <ziyao@disroot.org>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>, <junhui.liu@pigmoral.tech>,
 <rick@andestech.com>
Subject: Re: [PATCH 1/2] riscv: create a custom CPU implementation for
 PolarFire SoC
Message-ID: <aTeU0rLz6qDwpOdM@swlinux02>
References: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
 <20251119123843.4171699-2-jamie.gibbons@microchip.com>
 <aTE8Bi9kmTqaUgpy@swlinux02>
 <471395da081e977a4db8795e7cfd5022ebd058e6.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471395da081e977a4db8795e7cfd5022ebd058e6.camel@microchip.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B93IrwK045083
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

Hi Jamie,

On Mon, Dec 08, 2025 at 12:10:28PM +0000, Jamie.Gibbons@microchip.com wrote:
> [EXTERNAL MAIL]
> 
> Hi Leo,
> 
> On Thu, 2025-12-04 at 15:45 +0800, Leo Liang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know
> > the content is safe
> >
> > Hi Jamie,
> >
> > On Wed, Nov 19, 2025 at 12:38:42PM +0000, Jamie Gibbons wrote:
> > > [EXTERNAL MAIL]
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > PolarFire SoC needs a custom implementation of top_of_ram(), so stop
> > > using the generic CPU & create a custom CPU instead.
> > >
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  arch/riscv/Kconfig                     |  1 +
> > >  arch/riscv/cpu/mpfs/Kconfig            | 16 +++++++++++
> > >  arch/riscv/cpu/mpfs/Makefile           |  6 ++++
> > >  arch/riscv/cpu/mpfs/cpu.c              | 22 +++++++++++++++
> > >  arch/riscv/cpu/mpfs/dram.c             | 38
> > > ++++++++++++++++++++++++++
> > >  arch/riscv/include/asm/arch-mpfs/clk.h |  8 ++++++
> > >  board/microchip/mpfs_generic/Kconfig   |  4 +--
> > >  7 files changed, 93 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/riscv/cpu/mpfs/Kconfig
> > >  create mode 100644 arch/riscv/cpu/mpfs/Makefile
> > >  create mode 100644 arch/riscv/cpu/mpfs/cpu.c
> >
> > The cpu.c file only contains "cleanup_before_linux" and seems
> > identical
> > with the one provided in arch/riscv/cpu/generic/cpu.c.
> >
> > Other than that, LGTM.
> >
> > If you don't mind, I could fix this on my side that you don't need to
> > resend the patchset again.
> >
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> 
> Thank you for your response, review and feedback.
> 
> Regarding 'mpfs/cpu.c', you're corect that it is currently identical to
> the generic implementation. Our intent was to provide a placeholder for
> any future Polarfire-specific logic and also assumed it was manditory,
> but if duplication is unneccessary, I'm happy for you to adjust as you
> see fit.
> 
> In other words, if U-Boot prefers to avoid duplication and this file is
> not mandatory for build or architextural reasons per CPU implementation,
> than please go ahead and use the generic version.

Got it! Thanks for the explanation.
I’ve updated it to use the generic implementation.
If any Polarfire-specific logic is needed in the future,
we can add this file back at that time.

Best regards,
Leo

> 
> Thanks,
> Jamie.
> 
