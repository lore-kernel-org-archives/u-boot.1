Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 06:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C5086C83;
	Wed, 13 Dec 2023 07:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975D087083; Wed, 13 Dec 2023 07:08:09 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ECC86335
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 07:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BD681ud005330;
 Wed, 13 Dec 2023 14:08:01 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 13 Dec 2023 14:08:00 +0800
Date: Wed, 13 Dec 2023 14:07:57 +0800
From: Leo Liang <ycliang@andestech.com>
To: Randolph <randolph@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph.sklin@gmail.com>, <dylan@andestech.com>, 
 <tim609@andestech.com>, CL Wang <cl634@andestech.com>
Subject: Re: [PATCH V2 2/2] configs: andes: add watchdog support fot andes
 ae350
Message-ID: <ZXlKPa1w8tDG_uAK@swlinux02>
References: <20231130120729.1362747-1-randolph@andestech.com>
 <20231130120729.1362747-2-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231130120729.1362747-2-randolph@andestech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BD681ud005330
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

On Thu, Nov 30, 2023 at 08:07:29PM +0800, Randolph wrote:
> It adds the ATCWDT200 support for Andes AE350 platform.
> It also enables wdt command support.
> 
> Signed-off-by: CL Wang <cl634@andestech.com>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  configs/ae350_rv32_defconfig         | 4 ++++
>  configs/ae350_rv32_spl_defconfig     | 4 ++++
>  configs/ae350_rv32_spl_xip_defconfig | 4 ++++
>  configs/ae350_rv32_xip_defconfig     | 4 ++++
>  configs/ae350_rv64_defconfig         | 4 ++++
>  configs/ae350_rv64_spl_defconfig     | 4 ++++
>  configs/ae350_rv64_spl_xip_defconfig | 4 ++++
>  configs/ae350_rv64_xip_defconfig     | 4 ++++
>  8 files changed, 32 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
