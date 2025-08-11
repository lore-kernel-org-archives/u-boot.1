Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE0EC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 11:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DC68331B;
	Mon, 11 Aug 2025 13:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6C083321; Mon, 11 Aug 2025 13:39:51 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41908832AD
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 13:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57BBdbY8098276
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 11 Aug 2025 19:39:37 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 19:39:37 +0800
Date: Mon, 11 Aug 2025 19:39:33 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/4] xilinx: mbv: Add missing mmu-type cpu property
Message-ID: <aJnWdYz25beqMypC@swlinux02>
References: <cover.1753182218.git.michal.simek@amd.com>
 <e597b722b033d3c1d4f0d41f5f1644cb150fbb09.1753182218.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e597b722b033d3c1d4f0d41f5f1644cb150fbb09.1753182218.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57BBdbY8098276
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

On Tue, Jul 22, 2025 at 01:03:44PM +0200, Michal Simek wrote:
> OpenSBI expects mmu-type to be present in DT that's why add it. Without it
> OpenSBI disable CPU node which ends up in not working boot.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/riscv/dts/xilinx-mbv32.dts | 3 ++-
>  arch/riscv/dts/xilinx-mbv64.dts | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
