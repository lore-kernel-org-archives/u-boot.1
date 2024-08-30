Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2C0CA0EF6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D27488D73;
	Fri, 30 Aug 2024 11:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="q41YBsvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CCF88D76; Fri, 30 Aug 2024 11:09:57 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F71888D74
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725008995; x=1727600995;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vMAJIi0vHVMyIFcl6XlNwoJs7rVFMlvm7sa7ImRh7EM=;
 b=q41YBsvcQT3jH4kkmX/hTcpnpktGxaJWwhxH1wzAgGoxLIPVVffYKQzXFIcA4R23
 IGRzUhrrnXDRHJn0I4DiMIkM6EWpT7P5BEjZq2Rtk939WRXklg1xkDw+ftMib0fA
 JCndIVbj89R2Ns62TsXTAi+BGoWehtsL2FLo7mIKzQw=;
X-AuditID: ac14000a-03251700000021bc-0f-66d18c63ea0e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C0.42.08636.36C81D66;
 Fri, 30 Aug 2024 11:09:55 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:09:53 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 00/13] phycore-am62/4: Add more boot sources
Date: Fri, 30 Aug 2024 02:09:27 -0700
Message-ID: <20240830090940.2592157-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWyRpKBRze552KaQfsRWYtPOx+zWkydtJnd
 4u3eTnaL7nfqDiwerw6sYvc4e2cHo0d/dwurx/Uz25kCWKK4bFJSczLLUov07RK4MtadXMxc
 8IKv4s3mK4wNjK08XYycHBICJhLHr9xn7mLk4hASWMIkcbb3JSOEc59RYv/CTywgVWwCWhJ3
 tsxlBrFFBJIkdj1ZxgZiMwu4SCy+8YEVxBYWsJHo3/EULM4ioCrxcvIVdhCbV8BKoqP5GhPE
 NnmJmZe+Q8UFJU7OfMICMUdeonnrbGYIW0Li4IsXYLaQgILE7G2TGWF6p517zQxhh0oc2bSa
 aQKjwCwko2YhGTULyagFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYICV4SBawdj3xyPQ4xM
 HIyHGCU4mJVEeE8cP5smxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1R3CqkEB6YklqdmpqQWoR
 TJaJg1OqgdFGtEezX3Fm9Iz6068unpGPjPyW1Rk39bRaTGaZwCzFN/e0Xnf9mMUkryfTEZfx
 83K5AOvz0P2lgdyC16ps7DfP0vzQfaLAlTmi/UzZ635nz1nXgx1cb+y+vvvNy1MX9j37x7mr
 c1tWgFLblXsTF2tfLlL8NWvDNZNQ8WXSdze2x+7apPC7wVuJpTgj0VCLuag4EQChmNBFSgIA
 AA==
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

This patch stack extends the phyCORE-AM62x/AM64x U-Boot by following boot
sources:

  - Load U-Boot with USB DFU
  - Load a Linux and initramfs from OSPI/QSPI NOR flash
  - Load a Linux and rootfs from Network

Moreover, it adds required changes to the environment to boot an A/B
system with RAUC and includes some minor fixes.

Daniel Schultz (12):
  include: env: phytec: k3_mmc: Rename variables
  include: env: phytec: Add raucinit to k3_mmc environment
  include: net: phytec: Add K3 network boot logic
  include: env: phytec: Add K3 boot logic for OSPI/QSPI flashes
  board: phytec: phycore_am62x: Add Network/SPI Boot
  board: phytec: phycore_am64x: Add Network/SPI Boot
  configs: phycore_am62x_a53_defconfig: Make BOOTCMD generic
  configs: phycore_am64x_a53_defconfig: Make BOOTCMD generic
  configs: phycore_am62x_a53_defconfig: Merge am62x_a53_usbdfu.config
  configs: Add phycore_am62x_r5_usbdfu_defconfig
  configs: phycore_am62x_a53_defconfig: Fix CONFIG_ENV_SIZE
  configs: phycore_am62x_*_defconfig: Set PHYTEC as Manufacturer

Wadim Egorov (1):
  configs: phycore_am64x_a53_defconfig: Enable CONFIG_OF_BOARD_SETUP

 board/phytec/phycore_am62x/phycore_am62x.env |  8 +++++++
 board/phytec/phycore_am64x/phycore_am64x.env |  8 +++++++
 configs/phycore_am62x_a53_defconfig          |  8 +++----
 configs/phycore_am62x_r5_usbdfu_defconfig    |  3 +++
 configs/phycore_am64x_a53_defconfig          |  3 ++-
 include/env/phytec/k3_mmc.env                | 16 +++++++-------
 include/env/phytec/k3_net.env                | 22 ++++++++++++++++++++
 include/env/phytec/k3_spi.env                | 18 ++++++++++++++++
 8 files changed, 74 insertions(+), 12 deletions(-)
 create mode 100644 configs/phycore_am62x_r5_usbdfu_defconfig
 create mode 100644 include/env/phytec/k3_net.env
 create mode 100644 include/env/phytec/k3_spi.env

-- 
2.25.1

