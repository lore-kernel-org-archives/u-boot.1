Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A4E7E0C7
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B6C839A5;
	Mon,  9 Feb 2026 12:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A49183BF4; Mon,  9 Feb 2026 12:18:47 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853A48341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:18:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BIJqU045874;
 Mon, 9 Feb 2026 19:18:19 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:18:18 +0800
Date: Mon, 9 Feb 2026 19:18:16 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <e@freeshell.de>
CC: Minda Chen <minda.chen@starfivetech.com>, Hal Feng
 <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/5] Add upstream board Xunlong Orange Pi RV
Message-ID: <aYnCeDTZDSiU3_7C@swlinux02>
References: <20260120155406.34916-1-e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120155406.34916-1-e@freeshell.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BIJqU045874
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

On Tue, Jan 20, 2026 at 07:53:33AM -0800, E Shattow wrote:
> Xunlong Orange Pi RV patches are now in the Linux v6.19 release candidate,
> so let's introduce support for this board.
> 
> Note: The content of EEPROM is known to not be unique on this board, and
> an (optional) invented "XOPIRV" identifier is implemented with this
> series. Without, there are reports that the board is detected in U-Boot as
> StarFive VisionFive 2 1.3b, and is then functional enough to load the
> devicetree prior to booting Linux.
> 
> Changes since v2:
> - Collect tags (no code changes)
> - Adjust missing S-o-by tag to first of tags list order for patch 4
>   "configs: starfive: Add Orange Pi RV to visionfive2".
> 
> Changes since RFC v1:
> - Cherrypick from devicetree-rebasing instead of importing upstream dts
>   as -u-boot.dtsi overrides.
> - Add basic documentation
> - Mention invented "XOPIRV" identifier in commit messages
> - Rebase on origin/next
> 
> E Shattow (3):
>   board: starfive: visionfive2: Add Orange Pi RV selection by product_id
>   configs: starfive: Add Orange Pi RV to visionfive2
>   doc: board: starfive: Add Xunlong OrangePi RV
> 
> Icenowy Zheng (2):
>   dt-bindings: riscv: starfive: add xunlong,orangepi-rv
>   riscv: dts: starfive: add Orange Pi RV
> 
>  board/starfive/visionfive2/spl.c              |  3 +
>  .../visionfive2/starfive_visionfive2.c        |  2 +
>  configs/starfive_visionfive2_defconfig        |  2 +-
>  doc/board/starfive/index.rst                  |  1 +
>  doc/board/starfive/orangepi_rv.rst            | 35 +++++++++
>  dts/upstream/Bindings/riscv/starfive.yaml     |  1 +
>  .../src/riscv/starfive/jh7110-orangepi-rv.dts | 76 +++++++++++++++++++
>  7 files changed, 119 insertions(+), 1 deletion(-)
>  create mode 100644 doc/board/starfive/orangepi_rv.rst
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
