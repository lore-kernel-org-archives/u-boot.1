Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F6BC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266AB88568;
	Mon, 10 Jun 2024 15:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s/SIZ8yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E7E88566; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A73E5884C5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026449; x=1720618449;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x1sMGYvALogP5va2j58kC5xAHz82D0rlhgBv9epC4Zk=;
 b=s/SIZ8yuu7Dlzs3BDWZgUGpjAZlqmwgu2W0VFeM7XGSKhQqBtPOMoR2pPj+fo+WX
 rAFqXD+n41BGU8uJ/af5tt/AriAwJ/GiDU2+pmyFc0pawQMQpkYpCO9jxJCdZQ8r
 dUuKft66Li07lW3Mph18dxJ25Ihk52lfumqTcpe06WM=;
X-AuditID: ac14000a-03e52700000021bc-e3-666700d16285
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.7D.08636.1D007666;
 Mon, 10 Jun 2024 15:34:09 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:09 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 00/13] *** Various fixes & improvements for phycore-AM6* SoMs
 ***
Date: Mon, 10 Jun 2024 15:33:39 +0200
Message-ID: <20240610133352.2473414-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWyRpKBR/ciQ3qawc11UhYfGjezWUydtJnd
 4u3eTnaLd337mSy636k7sHq8OrCK3ePsnR2MHv3dLawefy6+Yw1gieKySUnNySxLLdK3S+DK
 uLf+AntBA1/FkosXWRsY53J3MXJySAiYSHz88Jqpi5GLQ0hgCZPE7O52dgjnMaPEhCf97CBV
 bALqEnc2fGMFsUUEgiR6L31iBLGZBTwktv7dABYXFgiUuLC7iRnEZhFQlXh0Zi0biM0rYCnx
 Ycdzdoht8hIzL31nh4gLSpyc+YQFYo68RPPW2cwQtoTEwRcvwGwhoPiLS8tZYHqnnXvNDGGH
 Smz9sp1pAqPALCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgkJYhIFrB2Pf
 HI9DjEwcjIcYJTiYlUR4hTKS04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1O
 TS1ILYLJMnFwSjUwCk/k/zVNX3Nix5OY9VF6hqu3W00ukP9pvGzWpOpzFfpzZQWvl9SuzFlv
 fX3rBZ7MvPW+N1X/pz9LP+ptnWcT3rEvWMM/i8v8uqX54s6zkcFPt93dNDvC2y2Nc9G2p/Gb
 Tvq0hWz9dOb69TXXj7Us4l33dibrmS6Zf389u9wUamZxlz1+7HCmXomlOCPRUIu5qDgRAJid
 BwpPAgAA
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

This patch set is for u-boot/next.
It includes various fixes and improvements for phyCORE-AM62x and
phyCORE-AM64x SoMs. Notable is the last patch which prepares for use
with future ECC memory fixups.

Nathan Morrisson (2):
  arch: arm: dts: k3-am625-phyboard-lyra: Add fixed partitions
  arch: arm: dts: k3-am642-phyboard-electra: Add fixed partitions

Wadim Egorov (11):
  board: phytec: common: k3: Copy fixed partitions to OS device tree
  board: phytec: phycore-am62x: Fix CONFIG_SPL_BOARD_INIT
  configs: phycore_am62x: Update environment location
  configs: phycore_am64x: Update environment location
  arm: dts: k3-am625-phyboard-lyra-rdk: Enable usb port in u-boot
  configs: phycore_am62x_a53_defconfig: Enable DFU boot
  board: phytec: phycore-am62x: Pull in k3_dfu.env
  configs: phycore_am6xx: Update MTD & SPI configs
  doc: board: phytec: phycore-am62x: Add USB DFU switch config
  doc: board: phytec: phycore-am6: Use mtd commands
  board: phytec: phycore-am62x: Use memory nodes in higher boot stages

 .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    | 35 +++++++++++++++++
 .../k3-am642-phyboard-electra-rdk-u-boot.dtsi | 26 +++++++++++++
 board/phytec/common/k3/board.c                | 10 +++++
 board/phytec/phycore_am62x/phycore-am62x.c    | 31 ++++++++++++++-
 board/phytec/phycore_am62x/phycore_am62x.env  |  2 +
 configs/phycore_am62x_a53_defconfig           | 38 +++++++++++++++++--
 configs/phycore_am62x_r5_defconfig            |  1 -
 configs/phycore_am64x_a53_defconfig           |  8 ++--
 configs/phycore_am64x_r5_defconfig            |  1 -
 doc/board/phytec/phycore-am62x.rst            | 12 ++++--
 doc/board/phytec/phycore-am64x.rst            |  8 ++--
 11 files changed, 155 insertions(+), 17 deletions(-)

-- 
2.34.1

