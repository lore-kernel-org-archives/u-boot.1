Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24230C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 08:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7C38753E;
	Wed, 31 Jan 2024 09:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737FF87579; Wed, 31 Jan 2024 09:14:35 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B58887252
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V8EA3v034905;
 Wed, 31 Jan 2024 16:14:10 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 16:14:06 +0800
Date: Wed, 31 Jan 2024 16:14:03 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>,
 "Michal Simek" <michal.simek@amd.com>, Padmarao Begari
 <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v4 1/3] riscv: dts: sophgo: add basic device tree for
 Milk-V Duo board
Message-ID: <ZboBSyPdw8j3fd0T@swlinux02>
References: <20240128070614.7702-1-seashell11234455@gmail.com>
 <20240128070614.7702-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240128070614.7702-2-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V8EA3v034905
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

On Sun, Jan 28, 2024 at 03:05:24PM +0800, Kongyang Liu wrote:
> Import device tree from Linux kernel to add basic support for CPU, PLIC,
> UART and Timer. The name cv1800b in the filename represent the chip used
> on Milk-V Duo board.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> Changes in v4:
> - Sync dts files with Linux kernel
> 
> Changes in v3:
> - Swap patch 1 and 2 duo to dependency of defconfig and device tree
> 
>  arch/riscv/dts/Makefile              |   1 +
>  arch/riscv/dts/cv1800b-milkv-duo.dts |  38 ++++++
>  arch/riscv/dts/cv1800b.dtsi          |  18 +++
>  arch/riscv/dts/cv18xx.dtsi           | 192 +++++++++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
>  create mode 100644 arch/riscv/dts/cv1800b.dtsi
>  create mode 100644 arch/riscv/dts/cv18xx.dtsi

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
