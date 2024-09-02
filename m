Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EE7CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 14:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B6B887B9;
	Mon,  2 Sep 2024 16:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725286104;
	bh=x2ucmcPwAVZuwvZ8sjsBRiuXvQKdjLjOzs1k3Oy4uuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LBt80PdZ8EcsmO13uXJdhOUlsFSvKhYVLRGjX5GCu7nzoBE05gi7GZdXGp0qEz7sU
	 ON0KSGP5jSmILnHbwI+239t9EYcFF/Wpp+UIPvTK2feM8qZyfQWpvicrsTAn1BaUjk
	 eAx8zarilX1sRDHy3I3rP2fQ8TvnZZVC1QS2KyUKd6NYDN8PTDdgUYoVl28rOve/pa
	 2wikXSfl2zrUI5l+pTJs2xaNUQWLR8RKFEvU6/0HV5vrb4mRpqmsjlwpYP6f8u9Qjw
	 S5vVM0UNpy463Yk5ffEciexh8Ipu9ZwP7sLQjeZZz03F5ePwls50F9Ij+5roNE4Ibk
	 i/scGmiVqNmlA==
Received: from eryximachos (unknown [185.51.87.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C06FA8641C;
 Mon,  2 Sep 2024 11:44:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725270299;
 bh=x2ucmcPwAVZuwvZ8sjsBRiuXvQKdjLjOzs1k3Oy4uuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sk28wTJ8SPZOfgzUbBjaXpfPQinVTSXsH5xD88z/7sxv96TQmhozaMwKiXv06o29Q
 nVN3YqL5SaCuP0SgulG1ecnXGeR6MkSMU7ROJPWNOtr5zzTYgzZaS2LZSPxBa6gl1S
 e8QMzdxG8YGliA9OskivikSVnkuoMo4uogX4JwWwoFcnJdwk8l8z3nlh04HbQzVimD
 BCb2QG6d/mwv2r84g7LjRrOUMrAu+WoBoHBHM7+zbYP0vXDuoI2BZNXcx5EqxvhUBk
 ZAkYGqT5dpwAwsTn+tiwEsqrfZcsZafxTUr91J2jTM0ZXDY0tEvirO01JKlFHWB674
 iH48kanAFT6Uw==
Date: Mon, 2 Sep 2024 11:44:55 +0200
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de, rfried.dev@gmail.com, trini@konsulko.com,
 joe.hershberger@ni.com
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
Subject: Re: [PATCH v4 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Message-ID: <ZtWJF5JH-Snxe_ur@eryximachos>
References: <20240802092539.162892-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802092539.162892-1-pro@denx.de>
X-Mailman-Approved-At: Mon, 02 Sep 2024 16:08:23 +0200
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

Hi all,

Seems there is no more comments to the series. Can we get it merged
then?

Best regards,
Philip


On Fri, Aug 02, 2024 at 11:25:34AM +0200, Philip Oberfichtner wrote:
> This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
> Before doing that, a few general adaptions to the dwc_eth_qos.c main
> driver are required. Most notably, the preparation for PCI based driver
> instances, which do not necessarily use a device tree.
> 
> Changes in V4:
> 	- Fix printf format string
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
>  drivers/net/dwc_eth_qos.c          |  83 +++++-
>  drivers/net/dwc_eth_qos.h          |   8 +-
>  drivers/net/dwc_eth_qos_imx.c      |   6 +
>  drivers/net/dwc_eth_qos_intel.c    | 449 +++++++++++++++++++++++++++++
>  drivers/net/dwc_eth_qos_intel.h    |  57 ++++
>  drivers/net/dwc_eth_qos_qcom.c     |   6 +
>  drivers/net/dwc_eth_qos_rockchip.c |   6 +
>  drivers/net/dwc_eth_qos_starfive.c |   6 +
>  drivers/net/dwc_eth_qos_stm32.c    |   6 +
>  include/pci_ids.h                  |   9 +
>  15 files changed, 641 insertions(+), 19 deletions(-)
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
