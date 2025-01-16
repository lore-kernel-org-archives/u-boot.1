Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0130E77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 07:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E3D806DD;
	Thu, 16 Jan 2025 08:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13F0806FB; Thu, 16 Jan 2025 08:42:02 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10C9D80214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 08:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 50G7fo0x033707
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 16 Jan 2025 15:41:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 16 Jan
 2025 15:41:50 +0800
Date: Thu, 16 Jan 2025 15:41:46 +0800
From: Leo Liang <ycliang@andestech.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/5] riscv: dts: canaan: Add basic device tree for K230
 CanMV board
Message-ID: <Z4i4OjX1062tZEua@swlinux02>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
 <20250115-k230-dev-1-v1-2-f4b77259e34a@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250115-k230-dev-1-v1-2-f4b77259e34a@pigmoral.tech>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 50G7fo0x033707
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

On Wed, Jan 15, 2025 at 12:46:38AM +0800, Junhui Liu wrote:
> Add initial dts for K230-CanMV powered by Canaan Kendryte K230 SoC,
> which has two RISC-V C908 cores, a big core with vector 1.0 extension
> and a small core without vector extension.
> 
> This patch is basically comes from Linux Kernel [1] and it assumes
> u-boot is running on the big core. Additionally, bootctl and reboot nodes
> are added to support sysreset [2] and an clk_dummy node is added to
> satisfy dependencies for usb [3].
> 
> Currently, u-boot is booted by the vendor's u-boot-spl. To meet the
> requirements [4][5] of vendor's u-boot-spl for u-boot, a binman node with
> mkimage child node is added here, which will compress u-boot.bin with
> gzip and generate an image named "uboot" in the file u-boot-gz.img.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=k230-basic
> [2] https://github.com/kendryte/k230_sdk/blob/v1.8/src/big/rt-smart/kernel/bsp/maix3/board/interdrv/sysctl/sysctl_boot/sysctl_boot.c#L67
> [3] https://lore.kernel.org/linux-riscv/tencent_AD84B436C2F31108B66B4739D6E306C5E80A@qq.com/
> [4] https://github.com/kendryte/k230_sdk/blob/v1.8/src/little/uboot/board/canaan/common/k230_img.c#L306
> [5] https://github.com/kendryte/k230_sdk/blob/v1.8/src/little/uboot/board/canaan/common/k230_img.c#L125
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/dts/Makefile         |   1 +
>  arch/riscv/dts/k230-canmv.dts   |  31 +++++++
>  arch/riscv/dts/k230-u-boot.dtsi |  25 ++++++
>  arch/riscv/dts/k230.dtsi        | 175 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 232 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
