Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B824D44D4F
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00FB88E89;
	Wed,  6 Nov 2024 12:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC6D88FED; Wed,  6 Nov 2024 12:10:40 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3763388E63
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4A6BAFrh071323
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Wed, 6 Nov 2024 19:10:15 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 19:10:15 +0800
Date: Wed, 6 Nov 2024 19:10:11 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Marek Vasut <marex@denx.de>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Introduce configuration for 64bit version
 Microblaze V
Message-ID: <ZytOk0nmH4pcIebk@swlinux02>
References: <5b042f4ef4927b7f87e1f8623dabeab5a8642916.1730454641.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b042f4ef4927b7f87e1f8623dabeab5a8642916.1730454641.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4A6BAFrh071323
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

On Fri, Nov 01, 2024 at 10:50:45AM +0100, Michal Simek wrote:
> The commit 7576ab2facae ("riscv: Add support for AMD/Xilinx MicroBlaze V")
> added support for 32bit version. 64bit version is also available that's why
> wire it up too.
> DT is providing description for generic QEMU target.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/riscv/dts/Makefile              |  1 +
>  arch/riscv/dts/xilinx-mbv64.dts      | 99 ++++++++++++++++++++++++++++
>  configs/xilinx_mbv64_defconfig       | 44 +++++++++++++
>  configs/xilinx_mbv64_smode_defconfig | 48 ++++++++++++++
>  4 files changed, 192 insertions(+)
>  create mode 100644 arch/riscv/dts/xilinx-mbv64.dts
>  create mode 100644 configs/xilinx_mbv64_defconfig
>  create mode 100644 configs/xilinx_mbv64_smode_defconfig

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
