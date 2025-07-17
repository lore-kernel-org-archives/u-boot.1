Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F8EC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 05:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543AE831E1;
	Thu, 17 Jul 2025 07:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12477832BC; Thu, 17 Jul 2025 07:45:22 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA3D2805D7
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 56H5i45N067796
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 17 Jul 2025 13:44:04 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 13:44:04 +0800
Date: Thu, 17 Jul 2025 13:44:01 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/5] clk: thead: th1520-ap: Correctly handle flags for
 dividers
Message-ID: <aHiNoV_zR0rw98PX@swlinux02>
References: <20250710034201.39901-1-ziyao@disroot.org>
 <20250710034201.39901-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710034201.39901-2-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 56H5i45N067796
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

On Thu, Jul 10, 2025 at 03:41:57AM +0000, Yao Zi wrote:
> Unlike the gate clocks which make no use of flags, most dividers in
> TH1520 SoC are one-based, thus are applied with CLK_DIVIDER_ONE_BASED
> flag. We couldn't simply ignore the flag, which causes wrong results
> when calculating the clock rates.
> 
> Add a member to ccu_div_internal for defining the flags, and pass it to
> divider_recalc_rate(). With this fix, frequency of all the clocks match
> the Linux kernel's calculation.
> 
> Fixes: e6bfa6fc94f ("clk: thead: Port clock controller driver of TH1520 SoC")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
