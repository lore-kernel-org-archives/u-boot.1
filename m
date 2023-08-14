Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E1BC001E0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 16:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365A886679;
	Mon, 14 Aug 2023 18:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D9B867B4; Mon, 14 Aug 2023 18:04:08 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DFA807B3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 18:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 9B2E067373; Mon, 14 Aug 2023 18:04:04 +0200 (CEST)
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 0/2] riscv: jh7110: visionfive2: fix u-boot crash due to
 missing timer
Message-Id: <20230814160404.9B2E067373@verein.lst.de>
Date: Mon, 14 Aug 2023 18:04:04 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

Hi all,

Since commit 55171aedda8, U-Boot on the visionfive2 stops at

| initcall sequence 00000000fffd76f8 failed at call 00000000402192c8 (err=-19)
| ### ERROR ### Please RESET the board ###

This is init_sequence_r[initr_dm_devices] calling dm_timer_init, which
returns ENODEV, because the riscv architectural timer got initialised
at the ROM stage, but then discarded at relocation, and never again to
be re-registered. A workaround hack was to allow it to register again
in drivers/core/root.c line 439:

if (CONFIG_IS_ENABLED(DM_EVENT) /* && !(gd->flags & GD_FLG_RELOC) */ ) {

but that would defeat the purpose of the commit 55171aedda8 cleanup.

However, the timer has a defined device tree binding which, when used,
IMHO makes things a lot clearer. AFAIU, the timer roughly corresponds
to the x86 TSC, which is defined on many x86 platforms, compare
yourself:

grep -r tsc_timer.dtsi arch/x86/dts
vs.
grep -r '"riscv,timer"' arch/riscv/dts

At first I tried to create a series that converts all riscv platforms
to use the DT for the CPU timer and removes the calls from the CPU
driver, but this takes too long. Release early, release often -- these
two patches fix the visionfive2, for a start. Others may follow and
the CPU driver calls can be removed later when they are not needed any
longer.

	Torsten

Fixes: 55171aedda8 ("dm: Emit the arch_cpu_init_dm() even only before relocation")
---
Torsten Duwe (2):
  riscv: allow riscv timer to be instantiated via device tree
  riscv: jh7110: enable riscv,timer in the device tree

 arch/riscv/dts/jh7110.dtsi  |  9 +++++++++
 drivers/timer/riscv_timer.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.35.3

