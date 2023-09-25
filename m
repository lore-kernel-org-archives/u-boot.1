Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19321CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 11:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E8586AEE;
	Mon, 25 Sep 2023 13:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EC886B18; Mon, 25 Sep 2023 13:46:19 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C31186ACC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38PBiloZ032630;
 Mon, 25 Sep 2023 19:44:47 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 19:44:44 +0800
Date: Mon, 25 Sep 2023 19:43:36 +0800
From: Leo Liang <ycliang@andestech.com>
To: Shengyu Qu <wiagn233@outlook.com>
CC: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, <u-boot@lists.denx.de>,
 <mps@arvanta.net>
Subject: Re: [PATCH 1/1] riscv: set fdtfile on VisionFive 2
Message-ID: <ZRFyaEahYVJ_zZP7@swlinux02>
References: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
 <TY3P286MB2611E76FC176D2A629BFF01698FFA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB2611E76FC176D2A629BFF01698FFA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38PBiloZ032630
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

On Fri, Sep 22, 2023 at 09:54:23PM +0800, Shengyu Qu wrote:
> Hello Leo,
> 
> This patch seems only landed in next branch, not master. It is seriously
> 
> needed to make visionfive 2 working properly. Could you merge it to
> 
> master branch?
> 
> Best regards,
> 
> Shengyu
> 

Hi Shengyu, 

Got it!
Will do ASAP!

Best regards,
Leo

> > Multiple revisions of the StarFive VisionFive 2 board exist. They can be
> > identified by reading their EEPROM.
> > 
> > Linux uses two differently named device-tree files. To load the correct
> > device-tree we need to set $fdtfile to the device-tree file name that
> > matches the board revision.
> > 
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > Tested-by: Milan P. Stanić <mps@arvanta.net>
> > ---
> >   arch/riscv/Kconfig                            |  1 +
> >   .../visionfive2/starfive_visionfive2.c        | 43 ++++++++++++++++++-
> >   2 files changed, 42 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 6771d8d919..1c62c2345b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -26,6 +26,7 @@ config TARGET_SIFIVE_UNMATCHED
> >   config TARGET_STARFIVE_VISIONFIVE2
> >   	bool "Support StarFive VisionFive2 Board"
> > +	select BOARD_LATE_INIT
> >   config TARGET_TH1520_LPI4A
> >   	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
> > diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> > index d609262b67..05d8d2d657 100644
> > --- a/board/starfive/visionfive2/starfive_visionfive2.c
> > +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> > @@ -5,14 +5,20 @@
> >    */
> >   #include <common.h>
> > -#include <asm/io.h>
> > -#include <asm/sections.h>
> >   #include <cpu_func.h>
> >   #include <dm.h>
> > +#include <env.h>
> > +#include <asm/arch/eeprom.h>
> > +#include <asm/io.h>
> > +#include <asm/sections.h>
> >   #include <linux/bitops.h>
> >   #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
> >   #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> > +#define FDTFILE_VISIONFIVE2_1_2A \
> > +	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
> > +#define FDTFILE_VISIONFIVE2_1_3B \
> > +	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> >   /* enable U74-mc hart1~hart4 prefetcher */
> >   static void enable_prefetcher(void)
> > @@ -33,6 +39,31 @@ static void enable_prefetcher(void)
> >   	}
> >   }
> > +/**
> > + * set_fdtfile() - set the $fdtfile variable based on the board revision
> > + */
> > +static void set_fdtfile(void)
> > +{
> > +	u8 version;
> > +	const char *fdtfile;
> > +
> > +	version = get_pcb_revision_from_eeprom();
> > +	switch (version) {
> > +	case 'a':
> > +	case 'A':
> > +		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
> > +	        break;
> > +
> > +	case 'b':
> > +	case 'B':
> > +	default:
> > +		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
> > +	        break;
> > +	};
> > +
> > +	env_set("fdtfile", fdtfile);
> > +}
> > +
> >   int board_init(void)
> >   {
> >   	enable_caches();
> > @@ -41,6 +72,14 @@ int board_init(void)
> >   	return 0;
> >   }
> > +int board_late_init(void)
> > +{
> > +	if (CONFIG_IS_ENABLED(ID_EEPROM))
> > +		set_fdtfile();
> > +
> > +	return 0;
> > +}
> > +
> >   void *board_fdt_blob_setup(int *err)
> >   {
> >   	*err = 0;
