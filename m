Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5338C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 11:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7D88312E;
	Tue,  8 Apr 2025 13:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041DE833FA; Tue,  8 Apr 2025 13:39:11 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2748882FAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 13:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 538BcwUE051441
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 8 Apr 2025 19:38:58 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 19:38:58 +0800
Date: Tue, 8 Apr 2025 19:38:56 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Bin Meng <bmeng.cn@gmail.com>, Rick Chen <rick@andestech.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
Message-ID: <Z_UK0AyN30JHEwDZ@swlinux02>
References: <20250403142816.1057084-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403142816.1057084-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 538BcwUE051441
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

On Thu, Apr 03, 2025 at 04:28:16PM +0200, Heinrich Schuchardt wrote:
> The number of memory banks in QEMU is not bounded by 1.
> 
> In this example we have two banks:
> 
>     qemu-system-riscv64 \
>     -machine virt \
>     -nographic \
>     -m 8192 \
>     -smp 8,sockets=2,cores=4,threads=1 \
>     -numa node,cpus=0-3,mem=4096 \
>     -numa node,cpus=4-7,mem=4096 \
>     -kernel u-boot
> 
> As we will see RISC-V NUMA systems using U-Boot
> we should be able to emulate these.
> 
> Use the default value defined in /Kconfig as 4.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/qemu-riscv32_defconfig       | 1 -
>  configs/qemu-riscv32_smode_defconfig | 1 -
>  configs/qemu-riscv32_spl_defconfig   | 1 -
>  configs/qemu-riscv64_defconfig       | 1 -
>  configs/qemu-riscv64_smode_defconfig | 1 -
>  configs/qemu-riscv64_spl_defconfig   | 1 -
>  6 files changed, 6 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
