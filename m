Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9618EE7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 02:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D947C86C96;
	Wed, 27 Sep 2023 04:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7445C805CA; Wed, 27 Sep 2023 04:45:43 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2834386D46
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 04:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38R2jPXs062715;
 Wed, 27 Sep 2023 10:45:25 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 27 Sep 2023 10:45:23 +0800
Date: Wed, 27 Sep 2023 10:44:15 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] riscv: enable CONFIG_DEBUG_UART by default
Message-ID: <ZROW9hgHVfQMFWmA@swlinux02>
References: <20230922233526.62642-1-heinrich.schuchardt@canonical.com>
 <ZRKN7VB6MNttakKv@swlinux02>
 <2e0732ae-ade7-4f36-9c50-168b34a3838b@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2e0732ae-ade7-4f36-9c50-168b34a3838b@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38R2jPXs062715
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

Hi Heinrich,

On Tue, Sep 26, 2023 at 10:38:48AM +0200, Heinrich Schuchardt wrote:
> On 9/26/23 09:53, Leo Liang wrote:
> > Hi Heinrich,
> > 
> > On Sat, Sep 23, 2023 at 01:35:26AM +0200, Heinrich Schuchardt wrote:
> > > Most boards don't enable the pre-console buffer. So we will not see any
> > > early messages. OpenSBI 1.3 provides us with the debug console extension
> > > that can fill this gap.
> > > 
> > > For S-Mode U-Boot enable CONFIG_DEBUG_UART by default.
> > > 
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/riscv/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 1c62c2345b..06fae7ebe8 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -141,6 +141,7 @@ config RISCV_MMODE
> > >   config RISCV_SMODE
> > >   	bool "Supervisor"
> > > +	imply DEBUG_UART
> > 
> > This patch will cause the following compilation warnings.
> > Could you take a look at them ?
> > 
> > It seems that some configuration values will not be set
> > if we imply DEBUG_UART.
> > 
> > u-boot$ make qemu-riscv64_spl_defconfig
> >    HOSTCC  scripts/basic/fixdep
> >    HOSTCC  scripts/kconfig/conf.o
> >    YACC    scripts/kconfig/zconf.tab.c
> >    LEX     scripts/kconfig/zconf.lex.c
> >    HOSTCC  scripts/kconfig/zconf.tab.o
> >    HOSTLD  scripts/kconfig/conf
> > #
> > # configuration written to .config
> > #
> > 
> 
> Hello Leo,
> 
> thanks for testing.
> 
> > u-boot$ make ARCH_FLAGS="-march=rv64imafdc" -j`nproc`
> 
> This does not work with a current gcc.
> arch/riscv/lib/cache.c:12: Error: unrecognized opcode `fence.i', extension
> `zifencei' required
> 
> > scripts/kconfig/conf  --syncconfig Kconfig
> > .config:78:warning: symbol value '' invalid for DEBUG_UART_BASE
> 
> Please, observe:
> 
> origin/next lacks these patches
> 
> d14222e7c152 ("risc-v: implement DBCN write byte")
> dfe08374943c ("risc-v: implement DBCN based debug console")
> 
> You must add these when testing the current patch.
> 
> On Ubuntu 23.10 I have been running
> 
> export CROSS_COMPILE=riscv64-linux-gnu-
> make clean
> make qemu-riscv64_spl_defconfig
> make -j8
> 
> for origin/master and the current patch. I did not see any warning.
> 
> Same for origin/next and all three patches applied.
> 
> We have
> 
> config DEBUG_UART_BASE
>         hex "Base address of UART"
>         depends on DEBUG_UART
>         default 0 if DEBUG_SBI_CONSOLE
> 
> since 41f7be73344.
> 
> I don't see any issues in
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17882
> (origin/master + this patch).
> 
> Best regards
> 
> Heinrich

Totally Got it! Thanks for the detailed explanation!

Best regards,
Leo

> 
> > .config:79:warning: symbol value '' invalid for DEBUG_UART_CLOCK
> > .config:1347:warning: symbol value '' invalid for SPL_DEBUG_UART_BASE
> > ...
> > 
> > Best regards,
> > Leo
> > 
> > >   	help
> > >   	  Choose this option to build U-Boot for RISC-V S-Mode.
> > > -- 
> > > 2.40.1
> > > 
> 
