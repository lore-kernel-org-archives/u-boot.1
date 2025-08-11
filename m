Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6FCC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 11:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB85832AD;
	Mon, 11 Aug 2025 13:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B8A832DD; Mon, 11 Aug 2025 13:45:24 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0712832AD
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 13:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57BBhTUw098829
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 11 Aug 2025 19:43:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 19:43:29 +0800
Date: Mon, 11 Aug 2025 19:43:27 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Conor Dooley <conor.dooley@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>, Hal Feng
 <hal.feng@starfivetech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Junhui Liu" <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Marek Vasut <marex@denx.de>, Padmarao Begari
 <padmarao.begari@amd.com>, "Rick Chen" <rick@andestech.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 4/4] xilinx: mbv: Use separate DTB for binman nodes
Message-ID: <aJnXX--NrkBaQy6A@swlinux02>
References: <cover.1753182218.git.michal.simek@amd.com>
 <614e624d84b0f83d706b6b9b839da0dbe105a85e.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <614e624d84b0f83d706b6b9b839da0dbe105a85e.1753182218.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57BBhTUw098829
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

On Tue, Jul 22, 2025 at 01:03:46PM +0200, Michal Simek wrote:
> The commit d92fdb60677b ("binman: Add option for pointing to separate
> description") added support for separating binman description to own file
> not the be the part of DT for OS.
> The main reason is that binman is not passing dt schema validation that's
> why want to keep it separated.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/riscv/dts/Makefile              |  1 +
>  arch/riscv/dts/xilinx-binman.dts     | 12 ++++++++++++
>  arch/riscv/dts/xilinx-mbv32.dts      |  2 --
>  arch/riscv/dts/xilinx-mbv64.dts      |  2 --
>  configs/xilinx_mbv32_defconfig       |  1 +
>  configs/xilinx_mbv32_smode_defconfig |  1 +
>  configs/xilinx_mbv64_defconfig       |  1 +
>  configs/xilinx_mbv64_smode_defconfig |  1 +
>  8 files changed, 17 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/dts/xilinx-binman.dts

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
