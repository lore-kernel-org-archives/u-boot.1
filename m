Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F7C47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 05:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D538785E;
	Thu,  1 Feb 2024 06:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="qZTxKXs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4F28785E; Thu,  1 Feb 2024 06:32:08 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20A887776
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 06:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W2G9lTDtEckUCRkXC41gzMk6T509gFdhiF322m++nc4=; b=qZTxKXs7DY0qB+um/Toxr+6S72
 XAdIbaputowobWbCfHZtSqC/fMj+q9s45XIioKJqriipx6B+SH8WHbnhCGWTzAtKtMjiy8rO/SzxH
 1apxiEPRCIv//8sBT3Q0dB/48heM6eo60Pq0DZN7D9Z9ON773I2Svi8MoEDObp+eerEUf+8FKmAOH
 0hwaT1E2CPi0dL1h/IGGjRD1W//4MIZ/4MhhRZe+p7JxuAW3QPHmZU6EuAH08L2bg7/mlJ0xVUANd
 JhKOWnGsMw+DspyRfZrR5qRvdNXE7s/xDjoyNDDdb7nr0Jl4EsnC7jbBNpITvYggC0KrkmRqtcs0+
 OS824P5A==;
Received: from [89.212.21.243] (port=51934 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rVPgD-000y1u-1N;
 Thu, 01 Feb 2024 06:32:05 +0100
Message-ID: <115a88bd-8939-48ff-890c-7bc126a695eb@norik.com>
Date: Thu, 1 Feb 2024 06:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
To: Mathieu Othacehe <othacehe@gnu.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20240130145037.32672-1-othacehe@gnu.org>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <20240130145037.32672-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Mathieu,

Thanks for v4. I have no more remarks.

Also tested your v4 on the board.

Everything works, even eMMC booting which you were not able to test.

With that my Tested-by: can be applied.

Tested-by: Primoz Fiser <primoz.fiser@norik.com>

BR,
Primoz

On 30. 01. 24 15:50, Mathieu Othacehe wrote:
> Add initial support for the PHYTEC phyBOARD-Segin-i.MX93 board based on
> the PHYTEC phyCORE-i.MX93 SoM.
> 
> Supported features:
> - 1GB LPDDR4 RAM
> - eMMC
> - external SD
> - FEC Ethernet
> - debug UART
> - watchdog
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
> Hello,
> 
> This new revision fixes the remarks of Primoz. The configuration is now
> aligned on the savedefconfig output. The FEC Ethernet is also tested to be
> working if this patch is in:
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20240130124337.497748-1-primoz.fiser@norik.com/
> 
> The proposed patch has been rebased on top of 6faba41.
> 
> Thanks,
> 
> Mathieu
> 
> v3: https://lists.denx.de/pipermail/u-boot/2024-January/544493.html
> 
>  arch/arm/dts/Makefile                         |    3 +-
>  arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  293 ++++
>  arch/arm/dts/imx93-phyboard-segin.dts         |  117 ++
>  arch/arm/dts/imx93-phycore-som.dtsi           |  126 ++
>  arch/arm/mach-imx/imx9/Kconfig                |    6 +
>  board/phytec/phycore_imx93/Kconfig            |   13 +
>  board/phytec/phycore_imx93/MAINTAINERS        |   10 +
>  board/phytec/phycore_imx93/Makefile           |   14 +
>  board/phytec/phycore_imx93/lpddr4_timing.c    | 1546 +++++++++++++++++
>  board/phytec/phycore_imx93/phycore-imx93.c    |   42 +
>  board/phytec/phycore_imx93/phycore_imx93.env  |   73 +
>  board/phytec/phycore_imx93/spl.c              |  148 ++
>  configs/imx93-phyboard-segin_defconfig        |  138 ++
>  doc/board/phytec/imx93-phyboard-segin.rst     |   61 +
>  doc/board/phytec/index.rst                    |    1 +
>  include/configs/phycore_imx93.h               |   28 +
>  16 files changed, 2618 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>  create mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
>  create mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
>  create mode 100644 board/phytec/phycore_imx93/Kconfig
>  create mode 100644 board/phytec/phycore_imx93/MAINTAINERS
>  create mode 100644 board/phytec/phycore_imx93/Makefile
>  create mode 100644 board/phytec/phycore_imx93/lpddr4_timing.c
>  create mode 100644 board/phytec/phycore_imx93/phycore-imx93.c
>  create mode 100644 board/phytec/phycore_imx93/phycore_imx93.env
>  create mode 100644 board/phytec/phycore_imx93/spl.c
>  create mode 100644 configs/imx93-phyboard-segin_defconfig
>  create mode 100644 doc/board/phytec/imx93-phyboard-segin.rst
>  create mode 100644 include/configs/phycore_imx93.h
> 

<snip>
