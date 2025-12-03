Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF74D12D60
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10EC683FB6;
	Wed,  3 Dec 2025 15:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="hAV4QLtP";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="Vq/JdonB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F05983FBE; Wed,  3 Dec 2025 15:11:35 +0100 (CET)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB6F83FB2
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-qt3p.prod.antispam.mailspamprotection.com;
 s=arckey; t=1764771092; 
 b=UZgGVF/djQkdjkLmIvxOAiQV6XQE7G2l1OoMaotUDYmmEa6o4qjzU1N5A7NYJC6cxlhE7LXLIP
 UAq/IJ1w9T610egJVLXdbN/5G6BMX4VriSwxo7cQgzulT0MorIZPCLg+7IW367PBRP4Iwb7v3n
 udw1uHt0Fuz85V8u/F4NKUoa13ukFEF52iud4ie5UerG4xRdSH8a5Vl/si1aPbCH/xhUxpTcuu
 xE12oVhKuFDZi8/B6o3OMvMHlYw/AI2pj8JpRTjITxvxRe8q+WWAle+zLr/GNUwsvo51huvBWs
 zvRg1aw3XC+8gwzy9+eLMSzJgCH5O4Lv3og/6tx1aBaJWg==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-qt3p.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-qt3p.prod.antispam.mailspamprotection.com;
 s=arckey; t=1764771092; 
 bh=PSCHzYVVw2cADYKCkMvQaBMsxWRX1HdJahfTqh7qvBo=;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
 From:Date:DKIM-Signature:DKIM-Signature;
 b=kadOIRvxtlI/zQwSc/ZzzFyzSthTfQ28PqW2cnquWkRQShvQ6Uax664D0vW8ScIlfhUVy6gdum
 0rOZ2MNGkrUL+YoXxtUmVabdxCkoyDm8ZDiyOz594VVv8ibW/TOaz5Y9zHcp8MC4RN8QMxzvLm
 nQrPvL8LIMU/mOzLpuED+t4jt92NU/UZN23fcE+dqi9lE5TkS6oETRLBUt6RYRWGXYB67YxeYk
 1tdWpyXA4l2FtGEf7gLGAdl4qkszGx/vu/8+zSQoF/EKJYVeicPhyThOW1mtkn91Ck0DU9v2o8
 wDSqYL29/9oUkSeV+wBDSWDCSPiqpAvlC05DrP1EtRLGyQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 List-Unsubscribe:Content-Transfer-Encoding;
 bh=BoUan4rVMVXymggt88t7ep3h1UUzS7qrl5Wa/geWBds=; b=hAV4QLtPwLqQuhBo362/Lxszml
 MtiBimvWQKFswCd6eAxl2+u+obxyvbyN2rYxoKfETJLs4X27a0V6O1kL/BUt0qTSrRt2MkH7Y/zX7
 GURQFkX6HAdz422KDEDaNzhtRjvF6N70dOUcWOFlZpxQTB3ZJo7vSbEPfIWlWcoJPbJc=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-qt3p.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.98.1)
 (envelope-from <francesco@valla.it>) id 1vQnZp-00000009E9P-2tNM
 for u-boot@lists.denx.de; Wed, 03 Dec 2025 14:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=BoUan4rVMVXymggt88t7ep3h1UUzS7qrl5Wa/geWBds=; b=Vq/JdonBYam02cLZqMNri1kCbs
 r3dcpnTt+40jVTzbNTqDOFBcC3dASlF5EoFYiAq5xcrR71hRKHBimRjjgpo60DJakkuiHNDJkriB1
 6RFeKr+yVvne1iI5CG9kguxJw1ycVxfw+F9a+Ea8PEbSTxHNqxgAmgcLsGm9OllLzF/Y=;
Received: from [82.59.186.57] (port=60761 helo=bywater)
 by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <francesco@valla.it>)
 id 1vQnZj-00000000Dqj-1GpK; Wed, 03 Dec 2025 14:11:23 +0000
Date: Wed, 3 Dec 2025 15:11:21 +0100
From: Francesco Valla <francesco@valla.it>
To: Joseph Guo <qijian.guo@nxp.com>
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
Message-ID: <aTBFCc-8NzeS4MzT@bywater>
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: eb6f36cc1cc91f2838d6cbf5d24437fc
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vQnZp-00000009E9P-2tNM-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-qt3p.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hello Joseph,

thank you for the patch set.

On Tue, Dec 02, 2025 at 07:05:01PM +0900, Joseph Guo wrote:
> This series add initial support for the FRDM i.MX91 11x11 development
> board in U-Boot:
> https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-IMX91
> 
> Include:
> - Device tree for the board.
> - Defconfig and Kconfig for the board.
> - Header file defining memory layout and hadware addresses.
> 
> The board devicetree already attempted to upstream, but not been accepted yet:
> https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com/
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
> Changes in v2:
> - add upstream link
> - rename 'vrpi' to 'vexp' to keep align with upstream dts
> - move bootph- property from u-boot.dtsi to dts   
> - correct commit message 'EVK' to 'FRDM'
> - use #include in ecc config file to avoid duplication
> - add ecc description in README
> - drop extraneous includes
> - rename 'imx91_frdm.rst' to 'imx91_11x11_frdm.rst'
> - drop IMX91_FRDM_LPDDR4 symbol
> - Link to v1: https://lore.kernel.org/r/20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com
> 
> ---
> Joseph Guo (2):
>       arm64: dts: add NXP FRDM-IMX91 device tree
>       imx: Support i.MX91 11x11 FRDM board
> 
>  arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi          |   51 +
>  arch/arm/dts/imx91-11x11-frdm.dts                  |  767 ++++++++
>  arch/arm/mach-imx/imx9/Kconfig                     |    9 +
>  board/freescale/imx91_frdm/Kconfig                 |   12 +
>  board/freescale/imx91_frdm/MAINTAINERS             |    7 +
>  board/freescale/imx91_frdm/Makefile                |   16 +
>  board/freescale/imx91_frdm/imx91_frdm.c            |   25 +
>  board/freescale/imx91_frdm/imx91_frdm.env          |   88 +
>  .../imx91_frdm/lpddr4_2400mts_1gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_2gb_timing.c         | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_1gb_timing.c     | 1996 ++++++++++++++++++++
>  .../imx91_frdm/lpddr4_2400mts_ecc_2gb_timing.c     | 1996 ++++++++++++++++++++
>  board/freescale/imx91_frdm/lpddr4_timing.h         |   12 +
>  board/freescale/imx91_frdm/spl.c                   |  193 ++
>  configs/imx91_11x11_frdm_defconfig                 |  143 ++
>  configs/imx91_11x11_frdm_inline_ecc_defconfig      |    3 +
>  doc/board/nxp/imx91_11x11_frdm.rst                 |  100 +
>  doc/board/nxp/index.rst                            |    1 +
>  include/configs/imx91_frdm.h                       |   25 +
>  19 files changed, 9436 insertions(+)
> ---
> base-commit: e199db57c00ba2c2aba81069800126b6543a644c
> change-id: 20251117-imx91_frdm-7a2db95f279d
> 
> Best regards,
> -- 
> Joseph Guo <qijian.guo@nxp.com>
> 

I tested the series on the actual hardware with [0] on top of the
mainline Linux kernel and encountered a unmanaged interrupt warning
during boot, which wasn't there using the downstream NXP u-boot
version:

[    1.840096] mmc1: host does not support reading read-only switch, assuming write-enable
[    1.850352] mmc1: new high speed SDHC card at address 1234
[    1.857170] mmcblk1: mmc1:1234 SA08G 7.21 GiB
[    1.864850]  mmcblk1: p1 p2
[    2.279012] random: crng init done
[   11.720182] platform pwrseq-usdhc3: deferred probe pending: pwrseq_simple: reset control not ready
[   11.734562] platform 42890000.ethernet: deferred probe pending: platform: wait for supplier /soc@0/efuse@47510000/mac-address@4ec
[   17.947574] irq 99: nobody cared (try booting with the "irqpoll" option)
[   17.954292] CPU: 0 UID: 0 PID: 55 Comm: irq/99-1-0022 Not tainted 6.18.0-01544-g0817234e6cf9-dirty #1 PREEMPT 
[   17.954302] Hardware name: NXP FRDM-IMX91 Development Board (DT)
[   17.954306] Call trace:
[   17.954310]  show_stack+0x18/0x30 (C)
[   17.954326]  dump_stack_lvl+0x60/0x80
[   17.954335]  dump_stack+0x18/0x24
[   17.954341]  __report_bad_irq+0x4c/0xec
[   17.954351]  note_interrupt+0x33c/0x390
[   17.954361]  handle_irq_event+0x94/0xbc
[   17.954368]  handle_level_irq+0xd8/0x170
[   17.954375]  handle_irq_desc+0x34/0x58
[   17.954380]  generic_handle_domain_irq+0x1c/0x28
[   17.954386]  vf610_gpio_irq_handler+0x70/0x110
[   17.954395]  handle_irq_desc+0x34/0x58
[   17.954401]  generic_handle_domain_irq+0x1c/0x28
[   17.954407]  gic_handle_irq+0x4c/0x140
[   17.954412]  call_on_irq_stack+0x30/0x48
[   17.954419]  do_interrupt_handler+0x80/0x84
[   17.954426]  el1_interrupt+0x38/0x60
[   17.954436]  el1h_64_irq_handler+0x18/0x24
[   17.954443]  el1h_64_irq+0x6c/0x70
[   17.954448]  _raw_spin_unlock_irqrestore+0x8/0x44 (P)
[   17.954457]  wake_threads_waitq+0x60/0x70
[   17.954463]  irq_thread+0x194/0x32c
[   17.954469]  kthread+0x12c/0x204
[   17.954478]  ret_from_fork+0x10/0x20
[   17.954485] handlers:
[   18.064352] [<00000000ec900a2b>] irq_default_primary_handler threaded [<00000000a61af792>] pca953x_irq_handler
[   18.074353] Disabling IRQ #99
[   18.080294] nxp-pca9450 1-0025: pca9451a probed.

Further analysis led me to think that this is caused by the fact that
the PCAL6524 GPIO expander (1-0022) shares its interrupt line with the
USB Type C port controller (PTN5110). As soon as the first interrupt
line from the PCAL is enabled (i.e., when the PCA9451A PMIC requests
its interrupt line, which is provided by the aforementioned PCAL6524),
the corresponding parent interrupt - which is shared - is also enabled
and this causes an interrupt storm, at least until the PTN5110 driver
is probed.

The interrupt storm causes a noticeable delay during the boot sequence,
as well as the disabling of the shared IRQ #99, making the device not
really usable.

In the downstream version of u-boot, this is taken care by the support
for the TypeC port controller logic [1], which is however not available
in upstream u-boot. Until that support is added, I'd suggest to add a
workaround in here (maybe in SPL code?) that simply disables the
interrupts for the PTN5110 and clears the interrupt latch as well.
The IRQ can then be enabled in a proper way by the kernel driver.


[0] https://lore.kernel.org/all/20251114-imx91_frdm-v1-0-e5763bdf9336@nxp.com/
[1] https://github.com/nxp-imx/uboot-imx/blob/lf_v2025.04/board/freescale/common/tcpc.c#L1058


Thank you


Regards,

Francesco



