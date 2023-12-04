Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBA3C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFB28709C;
	Mon,  4 Dec 2023 12:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC6CA870A0; Mon,  4 Dec 2023 12:34:08 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F72E87076
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B4BXkBa086537;
 Mon, 4 Dec 2023 19:33:46 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Dec 2023 19:33:43 +0800
Date: Mon, 4 Dec 2023 19:33:40 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Conor Dooley
 <conor.dooley@microchip.com>, Padmarao Begari
 <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2] riscv: Add support for AMD/Xilinx MicroBlaze V
Message-ID: <ZW25FAB_O42RyRhe@swlinux02>
References: <d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d488b7016e0d1b1324c64d8a8b2f033851aab6c6.1699271804.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3B4BXkBa086537
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

On Mon, Nov 06, 2023 at 12:56:47PM +0100, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor.
> 
> The patch contains initial wiring and configuration for initial HW design
> with memory, cpu, interrupt controller, timers and uartlite console
> (interrupt controller is listed but U-Boot is not using it).
> 
> Provided DT is just describing one configuration and should be taken only
> as example.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Extend commit message
> - DT changes, add interrupt controller, check agains dt schema
> - The patch for amd,mbv32 compatible string is here
> https://lore.kernel.org/r/d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com
> - The patch for board compatibility is here
> https://lore.kernel.org/r/50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com
> 
> xlnx,xps-intc-1.00.a driver exists in the Linux kernel but DT binding is
> missing. That's something what we need to work on.
> arch/arm64/boot/dts/xilinx/xilinx-mbv32.dtb: /axi/interrupt-controller@41200000: failed to match any schema with compatible: ['xlnx,xps-intc-1.00.a']
> 
> Public annoucement is available here if someone is interested.
> https://www.xilinx.com/products/design-tools/microblaze-v.html?utm_source=marketo&utm_medium=email&utm_campaign=EN-EM-2023-11-02-New-MicroBlaze-V-Processor&utm_term=btn&mkt_tok=NDA5LVdZWC03MjQAAAGPMMJYuPPscCags7WdvOeUSWy-_mC9aOwrobFaZRf5ok_eHoQUvTLBzJdHrkcBId9tQ4a-odfnU91WjUkIxx-iSG4OKGofjK5iZcAiK_VN8_xK
> 
> ---
>  arch/riscv/Kconfig                   |   4 +
>  arch/riscv/dts/Makefile              |   2 +
>  arch/riscv/dts/xilinx-mbv32.dts      | 106 +++++++++++++++++++++++++++
>  board/xilinx/Kconfig                 |   3 +-
>  board/xilinx/common/board.c          |   5 ++
>  board/xilinx/mbv/Kconfig             |  28 +++++++
>  board/xilinx/mbv/MAINTAINERS         |   7 ++
>  board/xilinx/mbv/Makefile            |   5 ++
>  board/xilinx/mbv/board.c             |  11 +++
>  configs/xilinx_mbv32_defconfig       |  30 ++++++++
>  configs/xilinx_mbv32_smode_defconfig |  32 ++++++++
>  include/configs/xilinx_mbv.h         |   6 ++
>  12 files changed, 238 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/dts/xilinx-mbv32.dts
>  create mode 100644 board/xilinx/mbv/Kconfig
>  create mode 100644 board/xilinx/mbv/MAINTAINERS
>  create mode 100644 board/xilinx/mbv/Makefile
>  create mode 100644 board/xilinx/mbv/board.c
>  create mode 100644 configs/xilinx_mbv32_defconfig
>  create mode 100644 configs/xilinx_mbv32_smode_defconfig
>  create mode 100644 include/configs/xilinx_mbv.h
 
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
