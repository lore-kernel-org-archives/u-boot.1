Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71939D1D878
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 07:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5BFC83C14;
	Thu,  4 Dec 2025 08:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5BF83C19; Thu,  4 Dec 2025 08:45:30 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802C983B87
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 08:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5B47jDZO047987
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 4 Dec 2025 15:45:13 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Dec
 2025 15:45:13 +0800
Date: Thu, 4 Dec 2025 15:45:10 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Tom
 Rini" <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH 1/2] riscv: create a custom CPU implementation for
 PolarFire SoC
Message-ID: <aTE8Bi9kmTqaUgpy@swlinux02>
References: <20251119123843.4171699-1-jamie.gibbons@microchip.com>
 <20251119123843.4171699-2-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251119123843.4171699-2-jamie.gibbons@microchip.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5B47jDZO047987
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

Hi Jamie,

On Wed, Nov 19, 2025 at 12:38:42PM +0000, Jamie Gibbons wrote:
> [EXTERNAL MAIL]
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> PolarFire SoC needs a custom implementation of top_of_ram(), so stop
> using the generic CPU & create a custom CPU instead.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/Kconfig                     |  1 +
>  arch/riscv/cpu/mpfs/Kconfig            | 16 +++++++++++
>  arch/riscv/cpu/mpfs/Makefile           |  6 ++++
>  arch/riscv/cpu/mpfs/cpu.c              | 22 +++++++++++++++
>  arch/riscv/cpu/mpfs/dram.c             | 38 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/arch-mpfs/clk.h |  8 ++++++
>  board/microchip/mpfs_generic/Kconfig   |  4 +--
>  7 files changed, 93 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/cpu/mpfs/Kconfig
>  create mode 100644 arch/riscv/cpu/mpfs/Makefile
>  create mode 100644 arch/riscv/cpu/mpfs/cpu.c

The cpu.c file only contains "cleanup_before_linux" and seems identical
with the one provided in arch/riscv/cpu/generic/cpu.c.

Other than that, LGTM.

If you don't mind, I could fix this on my side that you don't need to
resend the patchset again.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
