Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3182C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 09:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E18A86F1E;
	Tue, 19 Mar 2024 10:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 857A5871C7; Tue, 19 Mar 2024 10:03:52 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407C786D38
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 10:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42J93iGu042639;
 Tue, 19 Mar 2024 17:03:44 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 19 Mar 2024 17:03:40 +0800
Date: Tue, 19 Mar 2024 17:03:32 +0800
From: Leo Liang <ycliang@andestech.com>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
CC: <u-boot@lists.denx.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] riscv: Repeat virtio scan
Message-ID: <ZflU5LScAfHSy2K-@swlinux02>
References: <CGME20240219124142eucas1p179abec33d2cf344a2c21cec12f192679@eucas1p1.samsung.com>
 <20240219124139.1541868-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219124139.1541868-1-l.stelmach@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42J93iGu042639
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

Hi Łukasz,

On Mon, Feb 19, 2024 at 01:41:39PM +0100, Łukasz Stelmach wrote:
> The first time virtio_init() gets called from board_init() PCI isn't
> ready. Thus any virtio-over-PCI (e.g. network interfaces) devices can't
> be detected and used without additional `virtio scan` scan in the shell
> or a script.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
> The patch works for my but:
> 
> a) maybe virtio_init() should called only from board_init() the same
>    way as on ARM?
> b) can a repeated virtio_init() break already detected/initialized
>    devices?
> 

A repeated virtio_init() call would not break the already probed devices.
But we should prevent this redundancy by moving the virtio_init() call to
board_late_init() like what this commit[1] does for ARM.

Could you send a v2 to move the virtio_init() into board_late_init() ?

[1] https://patchwork.ozlabs.org/project/uboot/patch/20201230135712.5289-3-sughosh.ganu@linaro.org/
    e1ee06dde7 ("qemu: arm: Initialise virtio devices in board_late_init")

Best regards,
Leo

>  board/emulation/qemu-riscv/qemu-riscv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
> index 181abbbf97d..567b9dc6170 100644
> --- a/board/emulation/qemu-riscv/qemu-riscv.c
> +++ b/board/emulation/qemu-riscv/qemu-riscv.c
> @@ -46,6 +46,9 @@ int board_late_init(void)
>  	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
>  		usb_init();
>  
> +	/* Repeat virtio scan to detect PCI attached virtio devices. */
> +	virtio_init();
> +
>  	return 0;
>  }
>  
