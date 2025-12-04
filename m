Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEB2D1F9DA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5557E83FE9;
	Thu,  4 Dec 2025 13:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81A183BB1; Thu,  4 Dec 2025 03:30:58 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940C083B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 03:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D49121A1409;
 Thu,  4 Dec 2025 03:30:54 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E7E21A3225;
 Thu,  4 Dec 2025 03:30:54 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 53EC8180007D;
 Thu,  4 Dec 2025 10:30:52 +0800 (+08)
Date: Thu, 4 Dec 2025 11:30:51 +0900
From: Joseph Guo <qijian.guo@nxp.com>
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
Subject: Re: [PATCH v2 0/2] Add FRDM-IMX91 initial support
Message-ID: <aTDyW8Rm1u6hWUuc@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <aTBFCc-8NzeS4MzT@bywater>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBFCc-8NzeS4MzT@bywater>
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

On Wed, Dec 03, 2025 at 03:11:21PM +0100, Francesco Valla wrote:
> Hello Joseph,
> 
> thank you for the patch set.
> 
> 
> I tested the series on the actual hardware with [0] on top of the
> mainline Linux kernel and encountered a unmanaged interrupt warning
> during boot, which wasn't there using the downstream NXP u-boot
> version:
> 
> [    1.840096] mmc1: host does not support reading read-only switch, assuming write-enable
> [    1.850352] mmc1: new high speed SDHC card at address 1234
> [    1.857170] mmcblk1: mmc1:1234 SA08G 7.21 GiB
> [    1.864850]  mmcblk1: p1 p2
> [    2.279012] random: crng init done
> [   11.720182] platform pwrseq-usdhc3: deferred probe pending: pwrseq_simple: reset control not ready
> [   11.734562] platform 42890000.ethernet: deferred probe pending: platform: wait for supplier /soc@0/efuse@47510000/mac-address@4ec
> [   17.947574] irq 99: nobody cared (try booting with the "irqpoll" option)
> [   17.954292] CPU: 0 UID: 0 PID: 55 Comm: irq/99-1-0022 Not tainted 6.18.0-01544-g0817234e6cf9-dirty #1 PREEMPT 
> [   17.954302] Hardware name: NXP FRDM-IMX91 Development Board (DT)
> [   17.954306] Call trace:
> [   17.954310]  show_stack+0x18/0x30 (C)
> [   17.954326]  dump_stack_lvl+0x60/0x80
> [   17.954335]  dump_stack+0x18/0x24
> [   17.954341]  __report_bad_irq+0x4c/0xec
> [   17.954351]  note_interrupt+0x33c/0x390
> [   17.954361]  handle_irq_event+0x94/0xbc
> [   17.954368]  handle_level_irq+0xd8/0x170
> [   17.954375]  handle_irq_desc+0x34/0x58
> [   17.954380]  generic_handle_domain_irq+0x1c/0x28
> [   17.954386]  vf610_gpio_irq_handler+0x70/0x110
> [   17.954395]  handle_irq_desc+0x34/0x58
> [   17.954401]  generic_handle_domain_irq+0x1c/0x28
> [   17.954407]  gic_handle_irq+0x4c/0x140
> [   17.954412]  call_on_irq_stack+0x30/0x48
> [   17.954419]  do_interrupt_handler+0x80/0x84
> [   17.954426]  el1_interrupt+0x38/0x60
> [   17.954436]  el1h_64_irq_handler+0x18/0x24
> [   17.954443]  el1h_64_irq+0x6c/0x70
> [   17.954448]  _raw_spin_unlock_irqrestore+0x8/0x44 (P)
> [   17.954457]  wake_threads_waitq+0x60/0x70
> [   17.954463]  irq_thread+0x194/0x32c
> [   17.954469]  kthread+0x12c/0x204
> [   17.954478]  ret_from_fork+0x10/0x20
> [   17.954485] handlers:
> [   18.064352] [<00000000ec900a2b>] irq_default_primary_handler threaded [<00000000a61af792>] pca953x_irq_handler
> [   18.074353] Disabling IRQ #99
> [   18.080294] nxp-pca9450 1-0025: pca9451a probed.
> 
> Further analysis led me to think that this is caused by the fact that
> the PCAL6524 GPIO expander (1-0022) shares its interrupt line with the
> USB Type C port controller (PTN5110). As soon as the first interrupt
> line from the PCAL is enabled (i.e., when the PCA9451A PMIC requests
> its interrupt line, which is provided by the aforementioned PCAL6524),
> the corresponding parent interrupt - which is shared - is also enabled
> and this causes an interrupt storm, at least until the PTN5110 driver
> is probed.
> 
> The interrupt storm causes a noticeable delay during the boot sequence,
> as well as the disabling of the shared IRQ #99, making the device not
> really usable.
> 
> In the downstream version of u-boot, this is taken care by the support
> for the TypeC port controller logic [1], which is however not available
> in upstream u-boot. Until that support is added, I'd suggest to add a
> workaround in here (maybe in SPL code?) that simply disables the
> interrupts for the PTN5110 and clears the interrupt latch as well.
> The IRQ can then be enabled in a proper way by the kernel driver.
> 
> 
> [0] https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com/
> [1] https://github.com/nxp-imx/uboot-imx/blob/lf_v2025.04/board/freescale/common/tcpc.c#L1058
Hi Francesco,

Thank you for your test.
Yes we also observe such issue. But we are thinking about find a kernel fix for that,
that's why I didn't submit v2 on kernel upstream.
I appreciate your test result and NXP will have a disucss about this issue to find a fix.

Regards,
Joseph

> 
> 
> Thank you
> 
> 
> Regards,
> 
> Francesco
> 
> 
> 
