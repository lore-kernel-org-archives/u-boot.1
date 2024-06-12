Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D3BC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66878796B;
	Wed, 12 Jun 2024 19:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="TLm4RLGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BA6887ED; Wed, 12 Jun 2024 18:00:18 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B528881A
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718208015; x=1720800015;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l/6OVXP/fKVDpQMj4e9fQDP+Mk7tngQqF96+3iy7i64=;
 b=TLm4RLGDJ+QqCTAwgfHj/ZWgvIz3CYPXTCaDkWc0hkvmjGYttkWOiUA9orGwCo09
 Pruy0ZosjMD975BckR4PO0LJV9wK5Dja1z2KEAaLFqLMYzPEfVaiKoh+nMDbYIwN
 d4ptpDtuuVqigaKiLh2uUl93Op1TY2wgxRUB7gYPpWI=;
X-AuditID: ac14000a-03251700000021bc-aa-6669c60f3abf
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7E.1C.08636.F06C9666;
 Wed, 12 Jun 2024 18:00:15 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jun
 2024 18:00:12 +0200
Message-ID: <6e6557e5-9ea3-430f-80f5-3e45bb6694ff@phytec.de>
Date: Wed, 12 Jun 2024 18:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] *** Various fixes & improvements for phycore-AM6*
 SoMs ***
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.phytec.de>,
 <upstream@lists.phytec.de>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <nmorrisson@phytec.com>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWyRpKBR5f/WGaawdGtlhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 6N05h7XgAH/FvocbGRsYp/N0MXJySAiYSKw+tYcVxBYSWMIk8e1UWBcjF5B9i1Hi5OF2RpAE
 r4CNxLyPm9m7GDk4WARUJa7NdoMIC0qcnPmEBcQWFZCXuH9rBjuILSwQLvHs5Qk2EFtEoFSi
 //oeMJtZwFBi/cGnzBC7LCUWfVrDAhEXl7j1ZD4TiM0moCVxZ8tcsBpOASuJH2v2skLUWEgs
 fnOQHcKWl9j+dg7UHAWJ2dsmM0L8Ii8x7dxrZgg7VOLIptVMExiFZyE5dRaSdbOQjJ2FZOwC
 RpZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEHxIcLAtYOxb47HIUYmDsZDjBIczEoivGdi0tOE
 eFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MDrK7r0e53xz
 3wuFtVJqPbfYNFuKP4tUX3y6+ZGGTFalwPrb05tULQ/4xBWsZYqeEzX7qPPfj83aRQ+u1E5x
 Zru3cnmmqHRH+ilfiwczAvSqtrdznJ3ILjHF8tXp6u+NF/6f4DhX69P1YfqRL2+ztwsFbp1x
 KGQei8/D0EPaq3a79f+4z5kZoaXEUpyRaKjFXFScCACHBR/kfQIAAA==
X-Mailman-Approved-At: Wed, 12 Jun 2024 19:41:46 +0200
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

For all 13 patches,

Reviewed-by: Daniel Schultz <d.schultz@phytec.de>

On 10.06.24 15:33, Wadim Egorov wrote:
> This patch set is for u-boot/next.
> It includes various fixes and improvements for phyCORE-AM62x and
> phyCORE-AM64x SoMs. Notable is the last patch which prepares for use
> with future ECC memory fixups.
>
> Nathan Morrisson (2):
>    arch: arm: dts: k3-am625-phyboard-lyra: Add fixed partitions
>    arch: arm: dts: k3-am642-phyboard-electra: Add fixed partitions
>
> Wadim Egorov (11):
>    board: phytec: common: k3: Copy fixed partitions to OS device tree
>    board: phytec: phycore-am62x: Fix CONFIG_SPL_BOARD_INIT
>    configs: phycore_am62x: Update environment location
>    configs: phycore_am64x: Update environment location
>    arm: dts: k3-am625-phyboard-lyra-rdk: Enable usb port in u-boot
>    configs: phycore_am62x_a53_defconfig: Enable DFU boot
>    board: phytec: phycore-am62x: Pull in k3_dfu.env
>    configs: phycore_am6xx: Update MTD & SPI configs
>    doc: board: phytec: phycore-am62x: Add USB DFU switch config
>    doc: board: phytec: phycore-am6: Use mtd commands
>    board: phytec: phycore-am62x: Use memory nodes in higher boot stages
>
>   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 35 +++++++++++++++++
>   .../k3-am642-phyboard-electra-rdk-u-boot.dtsi | 26 +++++++++++++
>   board/phytec/common/k3/board.c                | 10 +++++
>   board/phytec/phycore_am62x/phycore-am62x.c    | 31 ++++++++++++++-
>   board/phytec/phycore_am62x/phycore_am62x.env  |  2 +
>   configs/phycore_am62x_a53_defconfig           | 38 +++++++++++++++++--
>   configs/phycore_am62x_r5_defconfig            |  1 -
>   configs/phycore_am64x_a53_defconfig           |  8 ++--
>   configs/phycore_am64x_r5_defconfig            |  1 -
>   doc/board/phytec/phycore-am62x.rst            | 12 ++++--
>   doc/board/phytec/phycore-am64x.rst            |  8 ++--
>   11 files changed, 155 insertions(+), 17 deletions(-)
>
