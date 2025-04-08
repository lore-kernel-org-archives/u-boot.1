Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C2C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 11:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591A48312E;
	Tue,  8 Apr 2025 13:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF2F6833C8; Tue,  8 Apr 2025 13:37:02 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F18482FAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 13:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 538BaLPC050893
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 8 Apr 2025 19:36:21 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 19:36:21 +0800
Date: Tue, 8 Apr 2025 19:36:18 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>,
 Sumit Garg <sumit.garg@kernel.org>, "E Shattow" <lucent@gmail.com>,
 Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] riscv: dts: jh7110: add bootph-pre-ram for &pllclk
Message-ID: <Z_UKMqWetNFi0MFY@swlinux02>
References: <20250330162421.238483-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250330162421.238483-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 538BaLPC050893
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

On Sun, Mar 30, 2025 at 06:24:21PM +0200, Heinrich Schuchardt wrote:
> Since commit f98cd471f06b ("clk: clk-composite: Resolve parent clock by
> name") the StarFive VisionFive 2 board fails to boot.
> 
> Before that patch the SPL debug UART showed warnings like:
> 
>     clk_register: failed to get pll0_out device (parent of perh_root)
>     clk_register: failed to get pll0_out device (parent of qspi_ref_src)
>     clk_register: failed to get pll0_out device (parent of usb_125m)
>     clk_register: failed to get pll0_out device (parent of gmac_src)
>     clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
>     clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
> 
> The &pllclk clock needs to be enabled early.
> 
> Fixes: f98cd471f06b ("clk: clk-composite: Resolve parent clock by name")
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/jh7110-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
