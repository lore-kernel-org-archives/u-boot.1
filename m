Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245CC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F186987DB0;
	Tue, 12 Mar 2024 10:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687B187DE3; Tue, 12 Mar 2024 10:27:20 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D6587D82
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C9R68S033820;
 Tue, 12 Mar 2024 17:27:06 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 17:27:06 +0800
Date: Tue, 12 Mar 2024 17:27:01 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 2/3] riscv: dts: sophgo: Add clk node and sdhci node
Message-ID: <ZfAf5d5jge0rQd4j@swlinux02>
References: <20240309175330.79267-1-seashell11234455@gmail.com>
 <20240309175330.79267-3-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240309175330.79267-3-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C9R68S033820
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

On Sun, Mar 10, 2024 at 01:51:56AM +0800, Kongyang Liu wrote:
> Add clk node and sdhci node for cv18xx SoCs according to patches from Linux
> kernel.
> 
> clk: https://lore.kernel.org/all/IA1PR20MB4953F9AD6792013B54636F05BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com/
> sdhci: https://lore.kernel.org/all/20240217144826.3944-1-jszhang@kernel.org/
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> Changes in v2:
> - Sync device tree with ptaches from Linux kernel
> 
>  arch/riscv/dts/cv1800b-milkv-duo.dts |  8 ++++++++
>  arch/riscv/dts/cv1800b.dtsi          |  4 ++++
>  arch/riscv/dts/cv18xx.dtsi           | 22 ++++++++++++++++++++++
>  3 files changed, 34 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
