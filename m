Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC5C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BDD82D32;
	Wed, 13 Aug 2025 13:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B205B834B6; Wed, 13 Aug 2025 13:59:48 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 505F582C84
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57DBxEvE006127
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 13 Aug 2025 19:59:14 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 19:59:14 +0800
Date: Wed, 13 Aug 2025 19:59:12 +0800
From: Leo Liang <ycliang@andestech.com>
To: Martin Herren <sputnik@on-the-web.ch>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <rick@andestech.com>, <heinrich.schuchardt@canonical.com>,
 <ben.dooks@codethink.co.uk>, <jamie.gibbons@microchip.com>,
 <michal.simek@amd.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <aJx-EOUdKblkrVni@swlinux02>
References: <aJr1oclCSUMcK3bb@swlinux02> <20250812152224.GT124814@bill-the-cat>
 <aJw3OPPRV8ZZosNR@swlinux02>
 <uJi-tonJnS-rzzWk93UNmq_US0NLjQsxtmcyv7P-18bETLOaqQX28xSPPDbohOwyUPGbRKqfscsqd1-L1pXS6saFXdmMMIu62cVeWPddF94=@on-the-web.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <uJi-tonJnS-rzzWk93UNmq_US0NLjQsxtmcyv7P-18bETLOaqQX28xSPPDbohOwyUPGbRKqfscsqd1-L1pXS6saFXdmMMIu62cVeWPddF94=@on-the-web.ch>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57DBxEvE006127
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

On Wed, Aug 13, 2025 at 11:16:09AM +0000, Martin Herren wrote:
> [EXTERNAL MAIL]
> 
> > > So, there's a few problems here. First, checkpatch.pl finds spacing and
> > > spelling issues, which I would normally just fixup in place. But second,
> > > voyager_spl doesn't build:
> > > riscv64: + voyager_spl
> > > +(voyager_spl) In file included from include/linux/printk.h:4,
> > > +(voyager_spl) from include/linux/kernel.h:5,
> > > +(voyager_spl) from include/linux/libfdt_env.h:13,
> > > +(voyager_spl) from include/linux/libfdt.h:6,
> > > +(voyager_spl) from include/fdtdec.h:17,
> > > +(voyager_spl) from include/dm/ofnode.h:11,
> > > +(voyager_spl) from include/dm/device.h:13,
> > > +(voyager_spl) from include/dm.h:13,
> > > +(voyager_spl) from common/spl/spl.c:13:
> > > +(voyager_spl) common/spl/spl.c: In function 'spl_set_header_raw_uboot':
> > > +(voyager_spl) common/spl/spl.c:281:27: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Werror=format=]
> > > +(voyager_spl) 281 | log_debug("Default load addr %x (u_boot_pos=%lx)\n",
> > > +(voyager_spl) | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +(voyager_spl) include/log.h:234:24: note: in definition of macro 'log'
> > > +(voyager_spl) 234 | printf(_fmt, ##_args); \
> > > +(voyager_spl) | ^~~~
> > > +(voyager_spl) common/spl/spl.c:281:17: note: in expansion of macro 'log_debug'
> > > +(voyager_spl) | ^~~~~~~~~
> > > +(voyager_spl) common/spl/spl.c:281:47: note: format string is defined here
> > > +(voyager_spl) | ~^
> > > +(voyager_spl) | |
> > > +(voyager_spl) | unsigned int
> > > +(voyager_spl) | %lx
> > > +(voyager_spl) cc1: all warnings being treated as errors
> > > +(voyager_spl) make[3]: *** [scripts/Makefile.build:296: spl/common/spl/spl.o] Error 1
> > > +(voyager_spl) make[2]: *** [scripts/Makefile.xpl:547: spl/common/spl] Error 2
> > > +(voyager_spl) make[1]: *** [Makefile:2358: spl/u-boot-spl] Error 2
> > > +(voyager_spl) make: *** [Makefile:198: sub-make] Error 2
> > > 
> 
> > > Please fix and re-submit, thanks.
> > 
> 
> > 
> 
> > Hi Tom,
> > 
> 
> > Sorry! I will fix these and re-submit ASAP.
> > 
> 
> > Best regards,
> > Leo
> 
> Hi Leo,
> 
> As you'll resubmit, may I propose two little cleanups ?
> 
> You merged my change to the default SYS_BOOTM_LEN, so this config for both configs/microchip_mpfs_icicle_defconfig and configs/voyager_spl_defconfig could be removed as it corresponds to the now default one.
> 
> For the Icicle board, the config has been unnecessarily re-added in the `configs: microchip_mpfs_icicle: enable CONFIG_OF_BOARD_SETUP` commit.
> 
> For the Voyager board it is a new board that I didn't address in my patch as it was not yet merged.
> 
> This way the defconfigs stay minimal and clean.
> 
> Thanks and best regards,
> 
> Martin

Hi Martin,

Thanks for the proposal.
I will fix them up in place and send out the PR to Tom.

Best regards,
Leo
