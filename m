Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32563C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 10:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8831D87866;
	Thu, 21 Dec 2023 11:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12C887860; Thu, 21 Dec 2023 11:06:07 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F35B87853
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 11:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BLA5uJO095738;
 Thu, 21 Dec 2023 18:05:56 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 21 Dec 2023 18:05:54 +0800
Date: Thu, 21 Dec 2023 18:05:51 +0800
From: Leo Liang <ycliang@andestech.com>
To: Michal Simek <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>
Subject: Re: [PATCH] riscv: Extend board compatible string with "qemu,mbv"
Message-ID: <ZYQN__IW1MP4tgG1@swlinux02>
References: <575ac34167776f3a3a00aa23cc5e182d1e41492f.1703084004.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <575ac34167776f3a3a00aa23cc5e182d1e41492f.1703084004.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BLA5uJO095738
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

On Wed, Dec 20, 2023 at 03:53:28PM +0100, Michal Simek wrote:
> Extend compatible string to match the latest change in dt binding.
> 
> Fixes: 7576ab2facae ("riscv: Add support for AMD/Xilinx MicroBlaze V")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> dt binding patch is available here.
> https://lore.kernel.org/all/69670e5a46c98a2eb73d4f2e2d571a27c46b4640.1700722941.git.michal.simek@amd.com/
> 
> ---
>  arch/riscv/dts/xilinx-mbv32.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
