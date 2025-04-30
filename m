Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B485C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 07:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA46182145;
	Wed, 30 Apr 2025 09:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="KYgpePj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F8482ADA; Wed, 30 Apr 2025 09:11:55 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 816668210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 61f79dbe259211f0813e4fe1310efc19-20250430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=ExlWckpzbFHm5Tfe+I+sA0kXDV/Qa9sKoV+UlDLQT9Y=; 
 b=KYgpePj3fPNkG3eP1e/PT7EGn1ceu8HSn+Wk++1SsiUvew0wVYZCrhg3GBAThfcgkYSfUHCwmPJIragDkxTmj3IASYsX6kpEhR0rad+qkqZ7dzwgriBZ8lYAO3vJjar8LDbweFatPjHIqSvIpGXx76jZLC5pMNKpljXF2w844/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:a5aa2831-b1ce-4d71-8039-ad85c19518d0, IP:0,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-5
X-CID-META: VersionHash:0ef645f, CLOUDID:0c5b3507-829c-41bc-b3dd-83387f72f90e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 61f79dbe259211f0813e4fe1310efc19-20250430
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2008560470; Wed, 30 Apr 2025 15:11:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 30 Apr 2025 15:11:47 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 30 Apr 2025 15:11:46 +0800
Message-ID: <8212e069cefe4e2d24118469b8945dcf6e8c2266.camel@mediatek.com>
Subject: Re: [SPAM][REGRESSION] [PATCH v6 0/3] Static initcalls
From: Weijie Gao <weijie.gao@mediatek.com>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, Jerome Forissier
 <jerome.forissier@linaro.org>, <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Stefan Roese <sr@denx.de>, Andre Przywara
 <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, "Patrick
 Rudolph" <patrick.rudolph@9elements.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 30 Apr 2025 15:11:46 +0800
In-Reply-To: <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
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

Hi Marcel,

This regression is also found with mtk_eth driver and I've sent a patch
to fix it:


https://patchwork.ozlabs.org/project/uboot/patch/20250429020424.48795-1-weijie.gao@mediatek.com/

This patch should also fix the regression on rtl8169 driver

BRs

Weijie

On Tue, 2025-04-29 at 23:52 +0200, Marcel Ziswiler wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi Jerome
> 
> On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > This series replaces the dynamic initcalls (with function pointers)
> > with
> > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > init_sequence_f_r and init_sequence_r. This makes the code simpler
> > and the
> > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and
> > -510
> > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> > 
> > Execution time doesn't seem to change noticeably. There is no
> > impact on
> > the SPL.
> > 
> > The inline assembly fixes, although they look unrelated, are
> > triggered
> > on some platforms with LTO enabled. For example:
> > kirkwood_defconfig.
> > 
> > CI: 
> > https://urldefense.com/v3/__https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514__;!!CTRNKA9wMg0ARbw!h0Wu3dmAIj7GcAAl7DMcs-OyDvxKbcP6QQh7EuYYFMB-6OkCPTOUSbqHhuFZWzgImuvWUmPQMzSAwU-I9YiHvwbrcTzq_ymldg$
> 
> This series seems to cause a regression on rock5b. E.g. on today's
> master:
> 
> => pci enum
> => setenv ipaddr 192.168.10.2
> => ping 192.168.10.1
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> failed to initialize card: -12
> No ethernet found.
> failed to initialize card: -12
> failed to initialize card: -12
> ping failed; host 192.168.10.1 is not alive
> 
> Seems the rtl8169 driver runs out of memory trying to allocate
> descriptors?
> 
> If I revert this series on top of today's master:
> 
> => pci enum
> => setenv ipaddr 192.168.10.2
> => ping 192.168.10.1
> 
> Warning: eth_rtl8169 MAC addresses don't match:
> Address in DT is                00:e0:4c:68:01:5a
> Address in environment is       fe:b1:db:60:25:69
> Using eth_rtl8169 device
> host 192.168.10.1 is alive
> 
> I just completed the bisection and will now look into what exactly
> could be going on.
> 
> Any insights are much appreciated.
> 
> Thanks!
> 
> > Changes in v6:
> > - Rebase on next branch
> > 
> > Changes in v5:
> > - Fix mistake in initcall_run_r():
> > CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
> > should have been !CONFIG_IS_ENABLED(...). As a result, several CI
> > tests
> > were failing. (Tom R.)
> > - Restore fixes in test/py/tests/test_trace.py and
> > arch/sh/lib/board.c
> > which had unexpectedly disappeared from v4 and caused CI errors.
> > - Fix CI error caused by wrong conditionals on the fix_fdt() call:
> >   tools/buildman/buildman -o /tmp -seP powerpc
> >   [...]
> >   common/board_f.c:752:12: error: 'fix_fdt' defined but not used [-
> > Werror=unused-function]
> > - Add "arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is
> > not set"
> > to fix a build error with LTO detecting mcr/mrc instructions
> > emitted in
> > Thumb mode on a CPU that doesn't support it:
> >   make sheevaplug_defconfig
> >   make -j$(nproc) CROSS_COMPILE="ccache arm-linux-gnueabi-"
> >   [...]
> >     LTO     u-boot
> >   {standard input}: Assembler messages:
> >   {standard input}:9241: Error: selected processor does not support
> > `mcr p15,1,r0,c15,c11,0' in Thumb mode
> >   {standard input}:19196: Error: selected processor does not
> > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19223: Error: selected processor does not
> > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19241: Error: selected processor does not
> > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19268: Error: selected processor does not
> > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19286: Error: selected processor does not
> > support `mrc p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19321: Error: selected processor does not
> > support `mcr p15,1,r3,c15,c1,0' in Thumb mode
> >   {standard input}:19341: Error: selected processor does not
> > support `mrc p15,0,r3,c1,c0,0' in Thumb mode
> >   {standard input}:19372: Error: selected processor does not
> > support `mcr p15,0,r3,c1,c0,0' in Thumb mode
> >   make[1]: *** [/tmp/ccu1wZWX.mk:11:
> > /tmp/ccIab81n.ltrans3.ltrans.o] Error 1
> > 
> > Changes in v4:
> > - Fold all changes to board_init_*() into a single patch
> > - Use '#if CONFIG_IS_ENABLED(FOO) INITCALL(init_foo) #endif'
> > instead of
> > 'CONFIG_IS_ENABLED(FOO, (INITCALL(init_foo);));' (Caleb C., Simon
> > G.).
> > As a consequence, drop Michal's patch ("common: board: Simplify
> > array
> > with function pointers with CONFIG_IS_ENABLED").
> > - Rebase on next
> > 
> > Changes in v3:
> > - Use printf() rather than debug() to report initcall failures
> > (Quentin S.)
> > - initcall_run_f(): replace one erroneous call to WATCHDOG_INIT()
> > with
> > WATCHDOG_RESET() (Ilias A.)
> > - Fix relocate_code() in arch/sh/lib/board.c to address CI failures
> > with
> > r2dplus (
> > https://urldefense.com/v3/__https://lists.denx.de/pipermail/u-boot/2025-January/576213.html__;!!CTRNKA9wMg0ARbw!h0Wu3dmAIj7GcAAl7DMcs-OyDvxKbcP6QQh7EuYYFMB-6OkCPTOUSbqHhuFZWzgImuvWUmPQMzSAwU-I9YiHvwbrcTyRLPlZiw$
> >  )
> > (Tom R.)
> > - Add comments to initcall_run_f() and initcall_run_r() (Simon G.)
> > 
> > Changes in v2:
> > - INTICALL() and INITCALL_EVT() now call hang() immediately on
> > error
> > - Fixed typo: s/intcall_run_f_r/initcall_run_f_r/
> > 
> > 
> > Jerome Forissier (3):
> >   arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set
> >   common: board: make initcalls static
> >   initcall: remove initcall_run_list()
> > 
> >  arch/arm/include/asm/system.h             |  22 +-
> >  arch/arm/lib/cache.c                      |   5 +-
> >  arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
> >  arch/sh/lib/board.c                       |   9 +-
> >  common/board_f.c                          | 223 +++++++++---------
> > -
> >  common/board_r.c                          | 247 +++++++++++-------
> > ----
> >  include/initcall.h                        |  45 ++--
> >  lib/Makefile                              |   1 -
> >  lib/initcall.c                            | 102 ---------
> >  test/py/tests/test_trace.py               |   8 +-
> >  10 files changed, 295 insertions(+), 376 deletions(-)
> >  delete mode 100644 lib/initcall.c
> 
> Cheers
> 
> Marcel

