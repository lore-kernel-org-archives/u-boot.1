Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FE3C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 11:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53350870E4;
	Thu, 30 Nov 2023 12:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="k8MVrZzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF670875FE; Thu, 30 Nov 2023 12:56:17 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06E8870AF
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1701345375; x=1703937375;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLvxRAVDh8fPwrEZy0TvzVpl2F/vWYnPNIJz0DB0IvQ=;
 b=k8MVrZzSUQIdxLWZGllUHJVVKQkPRkkeTTXsal80+F4OABA37GdtJOC7fP9x6If2
 cr1oJhK6UNcE/20/iT6TsTRG0UaJopZNikkrCp6qsAyN0gelML6HjaJAB7o9MoWh
 qQGlLCxsltiKEW9vFPp/pf2wAtcgMG2+asOutswTGbQ=;
X-AuditID: ac14000a-fadff7000000290d-5e-6568785ff27e
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9B.88.10509.F5878656;
 Thu, 30 Nov 2023 12:56:15 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 30 Nov
 2023 12:56:14 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <nm@ti.com>
Subject: [PATCH v2 0/2] *** Add support for phyCORE-AM62x ***
Date: Thu, 30 Nov 2023 12:56:05 +0100
Message-ID: <20231130115607.2150349-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWyRpKBVze+IiPVYO5JKYs3P84yWbzd28lu
 0f1O3YHZ4+ydHYwe/d0trB7Hb2xnCmCO4rJJSc3JLEst0rdL4Mo40P+bseCKXMXS6WuYGhiP
 SXQxcnJICJhIbD7zj7mLkYtDSGAxk0TL562MEM5jRolzS7YygVSxCahL3NnwjRXEFhGQknjZ
 uZEZxGYW0JY4e2MnWI2wgK3EiunLwGwWAVWJZevPsoHYvAKWEu1NV5ggtslLzLz0nR0iLihx
 cuYTFog58hLNW2dDzZSQOPjiBZgtBBR/cWk5C0zvtHOvmSHsUInOP/dZJjAKzEIyahaSUbOQ
 jFrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyhIRRi4djD2zfE4xMjEwXiIUYKDWUmE9/rT
 9FQh3pTEyqrUovz4otKc1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFINjB4FW7OU
 T3mZruByWfTqsMuFGZf6fwtYfZ2kIfhP8VkR57qIE9GG5lfZwnpuSKksj9QNXLPl5sf2eYuX
 2J12aSjv2CuVan595sIdXLMPd7qzaJlXyTDuEFndM3XTtmWbggXMi7dLFPSymJ8wCn0qmLZ2
 VSiXRvyUd6xNk55cU08zj0vQy/VZo8RSnJFoqMVcVJwIADrF/3pAAgAA
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

As requested by Dhruva, this patch set comes now with a cover-letter :).
This is a rebase on top of -next to address recent K3 updates.

It should be noted that the huge files are generated or copy pasted from
TI's evm. So I do not think they need big attention in the review process.

  - All yaml files are identical to TI's evm
  - k3-am62-phycore-som-ddr4-2gb.dtsi generated with TI's SysConfig DDR Tool
  - k3-am62-phycore-som.dtsi & k3-am625-phyboard-lyra-rdk.dts are 1:1 copies
    from Linux v6.7-rc3

v2:
  - Add cover-letter & mention Linux version I took the DTs from
  - Move board selection to mach-k3
  - Add missing SPL_LDSCRIPT definition
  - Refactore binman file for templated FITs & drop key overrides
  - Drop SoC provided bootph params from dt files
    Note: Later we can drop more bootph params after we added them to Linux
  - Drop CONFIG_TI_SECURE_DEVICE as it is set as default for K3
  - Drop cpsw3g custom DT property 'mac_efuse' and custom DT node cpsw-phy-sel
    as driver picks these from standard property/node (-u-boot.dtsi)
  - Add a53 cluster power to control from the rproc driver (a53 dt node)

v1: https://lists.denx.de/pipermail/u-boot/2023-October/535750.html

Wadim Egorov (2):
  board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
  doc: board: phytec: Add phyCORE-AM62x

 arch/arm/dts/Makefile                         |    4 +-
 .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
 arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  166 ++
 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  380 +++
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  118 +
 arch/arm/mach-k3/am62x/Kconfig                |   17 +
 board/phytec/phycore_am62x/Kconfig            |   33 +
 board/phytec/phycore_am62x/MAINTAINERS        |   15 +
 board/phytec/phycore_am62x/Makefile           |    8 +
 board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
 board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
 board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
 board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
 board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
 board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
 configs/phycore_am62x_a53_defconfig           |  115 +
 configs/phycore_am62x_r5_defconfig            |  130 +
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am62x.rst            |  125 +
 doc/board/ti/k3.rst                           |    1 +
 include/configs/phycore_am62x.h               |   15 +
 23 files changed, 5504 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
 create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
 create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
 create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
 create mode 100644 board/phytec/phycore_am62x/Kconfig
 create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
 create mode 100644 board/phytec/phycore_am62x/Makefile
 create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
 create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
 create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
 create mode 100644 configs/phycore_am62x_a53_defconfig
 create mode 100644 configs/phycore_am62x_r5_defconfig
 create mode 100644 doc/board/phytec/phycore-am62x.rst
 create mode 100644 include/configs/phycore_am62x.h

-- 
2.34.1

