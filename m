Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4672AE7E0C7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B455A8341A;
	Mon,  9 Feb 2026 12:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98CBD839A5; Mon,  9 Feb 2026 12:20:46 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF76805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BKSTL048266;
 Mon, 9 Feb 2026 19:20:28 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:20:28 +0800
Date: Mon, 9 Feb 2026 19:20:25 +0800
From: Leo Liang <ycliang@andestech.com>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Tom
 Rini" <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Yao Zi
 <ziyao@disroot.org>, Junhui Liu <junhui.liu@pigmoral.tech>, Cyril Jean
 <cyril.jean@microchip.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2] riscv: Add support for BeagleV-Fire
Message-ID: <aYnC-TXvQdxtcL2F@swlinux02>
References: <20260116140830.1422571-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116140830.1422571-1-jamie.gibbons@microchip.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BKSTL048266
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

On Fri, Jan 16, 2026 at 02:08:30PM +0000, Jamie Gibbons wrote:
> Bring U-Boot support for the BeagleV-Fire by adding a device tree and
> supporting board files etc.
> 
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
> v1 -> v2:
> - add missing configs to defconfig
> - reorder defconfig from `make savedefconfig`
> - add missing implied configs to kconfig for target
> ---
>  arch/riscv/Kconfig                       |   4 +
>  board/beagle/beaglev_fire/Kconfig        |  43 +++++++++
>  board/beagle/beaglev_fire/MAINTAINERS    |   7 ++
>  board/beagle/beaglev_fire/Makefile       |   6 ++
>  board/beagle/beaglev_fire/beaglev_fire.c | 117 +++++++++++++++++++++++
>  configs/beaglev_fire_defconfig           |  29 ++++++
>  include/configs/beaglev_fire.h           |  57 +++++++++++
>  7 files changed, 263 insertions(+)
>  create mode 100644 board/beagle/beaglev_fire/Kconfig
>  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
>  create mode 100644 board/beagle/beaglev_fire/Makefile
>  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
>  create mode 100644 configs/beaglev_fire_defconfig
>  create mode 100644 include/configs/beaglev_fire.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
