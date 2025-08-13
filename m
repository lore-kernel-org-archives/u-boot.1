Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB56CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 06:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D798D82CEA;
	Wed, 13 Aug 2025 08:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F309D82DA1; Wed, 13 Aug 2025 08:57:58 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F0A8144A
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 08:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57D6vE7h017932
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 13 Aug 2025 14:57:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 14:57:14 +0800
Date: Wed, 13 Aug 2025 14:57:10 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <rick@andestech.com>,
 <heinrich.schuchardt@canonical.com>, <ben.dooks@codethink.co.uk>,
 <jamie.gibbons@microchip.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <aJw3OPPRV8ZZosNR@swlinux02>
References: <aJr1oclCSUMcK3bb@swlinux02> <20250812152224.GT124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812152224.GT124814@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57D6vE7h017932
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

On Tue, Aug 12, 2025 at 09:22:24AM -0600, Tom Rini wrote:
> [EXTERNAL MAIL]

> Date: Tue, 12 Aug 2025 09:22:24 -0600
> From: Tom Rini <trini@konsulko.com>
> To: Leo Liang <ycliang@andestech.com>
> Cc: u-boot@lists.denx.de, rick@andestech.com,
>  heinrich.schuchardt@canonical.com, ben.dooks@codethink.co.uk,
>  jamie.gibbons@microchip.com, sputnik@on-the-web.ch, michal.simek@amd.com
> Subject: Re: [GIT PULL] u-boot-riscv/master
> 
> On Tue, Aug 12, 2025 at 04:04:49PM +0800, Leo Liang wrote:
> 
> > Hi Tom,
> > 
> > The following changes since commit acfacf452441d0a659e3afbd55fd6061aa17e647:
> > 
> >   Prepare v2025.10-rc2 (2025-08-11 13:47:46 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git 
> > 
> > for you to fetch changes up to bddcd6bcba081aaaaafe30d1b8f9f3c83f069bde:
> > 
> >   starfive: fix return code of `mac write_eeprom` (2025-08-12 15:34:39 +0800)
> > 
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/27348
> > ----------------------------------------------------------------
> > - Board: mbv: Prepare MBV for CI
> > - Board: MPFS Icicle Kit cleanup
> > - Board: Add Andes Voyager board support
> > - RISCV: Update SYS_BOOTM_LEN to commonly used value
> > - starfive: fix return code of `mac write_eeprom`
> 
> So, there's a few problems here. First, checkpatch.pl finds spacing and
> spelling issues, which I would normally just fixup in place. But second,
> voyager_spl doesn't build:
>    riscv64:  +   voyager_spl
> +(voyager_spl) In file included from include/linux/printk.h:4,
> +(voyager_spl)                  from include/linux/kernel.h:5,
> +(voyager_spl)                  from include/linux/libfdt_env.h:13,
> +(voyager_spl)                  from include/linux/libfdt.h:6,
> +(voyager_spl)                  from include/fdtdec.h:17,
> +(voyager_spl)                  from include/dm/ofnode.h:11,
> +(voyager_spl)                  from include/dm/device.h:13,
> +(voyager_spl)                  from include/dm.h:13,
> +(voyager_spl)                  from common/spl/spl.c:13:
> +(voyager_spl) common/spl/spl.c: In function 'spl_set_header_raw_uboot':
> +(voyager_spl) common/spl/spl.c:281:27: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Werror=format=]
> +(voyager_spl)   281 |                 log_debug("Default load addr %x (u_boot_pos=%lx)\n",
> +(voyager_spl)       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +(voyager_spl) include/log.h:234:24: note: in definition of macro 'log'
> +(voyager_spl)   234 |                 printf(_fmt, ##_args); \
> +(voyager_spl)       |                        ^~~~
> +(voyager_spl) common/spl/spl.c:281:17: note: in expansion of macro 'log_debug'
> +(voyager_spl)       |                 ^~~~~~~~~
> +(voyager_spl) common/spl/spl.c:281:47: note: format string is defined here
> +(voyager_spl)       |                                              ~^
> +(voyager_spl)       |                                               |
> +(voyager_spl)       |                                               unsigned int
> +(voyager_spl)       |                                              %lx
> +(voyager_spl) cc1: all warnings being treated as errors
> +(voyager_spl) make[3]: *** [scripts/Makefile.build:296: spl/common/spl/spl.o] Error 1
> +(voyager_spl) make[2]: *** [scripts/Makefile.xpl:547: spl/common/spl] Error 2
> +(voyager_spl) make[1]: *** [Makefile:2358: spl/u-boot-spl] Error 2
> +(voyager_spl) make: *** [Makefile:198: sub-make] Error 2
> 
> Please fix and re-submit, thanks.

Hi Tom,

Sorry! I will fix these and re-submit ASAP.

Best regards,
Leo

> 
> -- 
> Tom
