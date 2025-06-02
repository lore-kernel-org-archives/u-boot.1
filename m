Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBF4C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 08:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C50180584;
	Mon,  2 Jun 2025 10:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2129A80C93; Mon,  2 Jun 2025 10:45:39 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C543803DF
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 10:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5528iOY4061907
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 2 Jun 2025 16:44:24 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 16:44:24 +0800
Date: Mon, 2 Jun 2025 16:44:21 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Wei Fu <wefu@redhat.com>, Yixun Lan
 <dlan@gentoo.org>, Michal Simek <michal.simek@amd.com>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>, "Nathan
 Barrett-Morrison" <nathan.morrison@timesys.com>, Greg Malysa
 <malysagreg@gmail.com>, Trevor Woerner <twoerner@gmail.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marex@denx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 Andreas Schwab <schwab@suse.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yao Zi <ziyao@disroot.org>,
 "Padmarao Begari" <padmarao.begari@amd.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] configs: raise SPL_SYS_MALLOC_SIZE to 8 MiB on RISC-V
Message-ID: <aD1kZdnSqVU2gGHe@swlinux02>
References: <20250525104248.67180-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525104248.67180-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5528iOY4061907
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

On Sun, May 25, 2025 at 12:42:48PM +0200, Heinrich Schuchardt wrote:
> [EXTERNAL MAIL]
> 
> On several RISC-V boards we have seen that 1 MiB is a insufficient value
> for CONFIG_SPL_SYS_MALLOC_SIZE.
> 
> For instance qemu-riscv32_spl_defconfig fails booting because u-boot.itb
> exceeds 1 MiB.
> 
> 8 MiB is a reasonable value that allows adding FPGA blobs or splash images
> to main U-boot.
> 
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/Kconfig                     | 2 +-
>  configs/starfive_visionfive2_defconfig | 1 -
>  configs/th1520_lpi4a_defconfig         | 1 -
>  configs/xilinx_mbv32_defconfig         | 1 -
>  configs/xilinx_mbv32_smode_defconfig   | 1 -
>  configs/xilinx_mbv64_defconfig         | 1 -
>  configs/xilinx_mbv64_smode_defconfig   | 1 -
>  7 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
