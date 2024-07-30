Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB9C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 05:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CC6888E5;
	Tue, 30 Jul 2024 07:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722317519;
	bh=nGZmJTK2Hk5EvDGrCb/kMzNxo7EJcPQJE8HzDJbqcjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQRUPt6ptsCSO7m9wivaHyDQm+qrJ49i3lh/OYMyAgT38VkxG73kOFRAKAM/2MYcw
	 LNhtb4yjBL/56cgY+/VDcKCDgpqvmZFBESVc69LLpsh4q6UFDxmLQNPawmcfQuPBLl
	 n3GBspYE9gxPms5wuRwDc2Pzx5ZZJLFLSC7cb+wSJ3rRwWEkrU5QJa61zhmg9Vjoo8
	 uif5itD4SiPm5AU+j+u4CFEom5BitWdBk1kM1CM4L7aERvX4/eZIDOuzgnIt9unzlH
	 c0+tq/I496Hz4q8wv9GXH3Z+ct7yTZ2QwNW6WaBWm7wefqGjxj6cjoG2Zs6BMI32zr
	 ANv4GMoJ1gxoQ==
Received: from eryximachos (unknown
 [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D981A88855;
 Tue, 30 Jul 2024 07:31:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722317517;
 bh=nGZmJTK2Hk5EvDGrCb/kMzNxo7EJcPQJE8HzDJbqcjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xe7gf/jP7qDG8ZZYS55kzJjJ6K/WrNStsQRa0e0r2WEVJWzpZtBqLEh23DyujgOj2
 hG1VZwsOxnZk3i3x3tgLh04Qdx7wgHahnTE+nq5b5dJVcByQoBsQkqVlxKxw1xBy6+
 rSUYMUPKNl4Xuv9SWuToD3DGhakGLxL4FazGQT63ySIyqt7oWlz9Oy9o8Ef3+Kadp0
 Zs/jqxBjWBRxAu/3C6Sz13/Z7V/5l9wyvxefwUs9wW7FKK68V45CZhYshEKwW1TyjT
 DDEDgOaO8SjA+CH/H094YHNUoG46WoMWW0BHz8iYmwD3DYq3CDvSypismHuw4ukktH
 GKNolvHGN7yQw==
Date: Tue, 30 Jul 2024 07:31:54 +0200
From: Philip Oberfichtner <pro@denx.de>
To: rfried.dev@gmail.com, u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de,
 eugen.hristev@collabora.com, festevam@gmail.com,
 forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 xypron.glpk@gmx.de, marex@denx.de
Subject: Re: [PATCH v3 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Message-ID: <Zqh6yvNEFUD2AKUq@eryximachos>
References: <20240717122906.117861-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717122906.117861-1-pro@denx.de>
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

Hi Ramon,

Any comments on this series?

On Wed, Jul 17, 2024 at 02:29:01PM +0200, Philip Oberfichtner wrote:
> This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
> Before doing that, a few general adaptions to the dwc_eth_qos.c main
> driver are required. Most notably, the preparation for PCI based driver
> instances, which do not necessarily use a device tree.
> 
> This patch series depends on: "net: dwc_eth_qos: mdio: Implement clause 45":
> https://patchwork.ozlabs.org/project/uboot/patch/20240507094237.168238-1-pro@denx.de/
> 
> Changes in V3:
> 	- Replace mfence() with mb()
> 	- Clean-up eqos_get_base_addr()
> 	- Several style fixes for dwc_eth_qos_intel
> 
> Philip Oberfichtner (5):
>   x86: provide mb() macro
>   net: dwc_eth_qos: Fix header to be self-contained
>   net: dwc_eth_qos: Adapt probe() for PCI devices
>   net: dwc_eth_qos: Implement bind() for PCI devices
>   net: dwc_eth_qos: Add glue driver for Intel MAC
> 
>  arch/x86/cpu/mp_init.c             |  10 +-
>  arch/x86/include/asm/cpu.h         |   5 -
>  arch/x86/include/asm/io.h          |   1 +
>  drivers/net/Kconfig                |   7 +
>  drivers/net/Makefile               |   1 +
>  drivers/net/dwc_eth_qos.c          |  79 ++++-
>  drivers/net/dwc_eth_qos.h          |   8 +-
>  drivers/net/dwc_eth_qos_imx.c      |   6 +
>  drivers/net/dwc_eth_qos_intel.c    | 449 +++++++++++++++++++++++++++++
>  drivers/net/dwc_eth_qos_intel.h    |  57 ++++
>  drivers/net/dwc_eth_qos_qcom.c     |   6 +
>  drivers/net/dwc_eth_qos_rockchip.c |   6 +
>  drivers/net/dwc_eth_qos_starfive.c |   6 +
>  drivers/net/dwc_eth_qos_stm32.c    |   6 +
>  include/pci_ids.h                  |   9 +
>  15 files changed, 637 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/net/dwc_eth_qos_intel.c
>  create mode 100644 drivers/net/dwc_eth_qos_intel.h
> 
> -- 
> 2.39.2
> 

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
