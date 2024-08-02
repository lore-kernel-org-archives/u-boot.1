Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B63AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AA6688AFF;
	Fri,  2 Aug 2024 11:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722590745;
	bh=j5sKJddfgXw3eA241AIghqV37xnAyXedLP1BsTiopSQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u1CNw4wVvEF+ddGQ0z4zYeHyMKxYMX+vvPInrcL4GnFETye1pL5LHqhJcMxrTYY5F
	 ln8E/f2KvLsoxkynJsJHPy4fP5XEGhn4vpHEr6y6LjhhjQuVq1hrUcQmKP7ObS2xmZ
	 LWo9p3/RmJu3b08QKXxiiAgiotRPdQFyhakxgFrWoImN7mk2XE778ZTSDCfqlNFK8L
	 g7KjV5iw3fwpgoC1cnFVlrgQE7hqic0V4tWJ5KqBDrQzsry4TBvzZarw3Q4/ziqjpO
	 RYbt3pnwW3hMle92UmwfwjB+U1ygFcOe861NuKuwG3j1G+pYCLyV56Er+RTNJymmX+
	 FLY1wpkjghG3Q==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:7f4c:42be:fdf8:3b8a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4075088967;
 Fri,  2 Aug 2024 11:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722590743;
 bh=j5sKJddfgXw3eA241AIghqV37xnAyXedLP1BsTiopSQ=;
 h=From:To:Cc:Subject:Date:From;
 b=vZFuKjg7oCQs9wBhnJNAwLSg5OCQRwj+QpDLa8Anv4BvQ6l5IFRhqqwwhZ0Mg52J+
 XXVH6Sr/SldQ5NVaWvY6eAWsEkX6NyD1uGrzEx/M9YDnEu8EGm2C5DYUVsP1npc8QR
 itoA3CF7EA67LrmIX9QW6P3VWYdCqgIHgEW6Y0GeCplBRtoElhNPIwroVLO9ruqKHZ
 jEF8E72y9jB7HXXCduII3J532J2uphXO8zL/HA2rltuFl6TfDJhxO6UHwbNlFDSgrV
 h1QAcWBNDdMUdoiryMnC4HCPRN44ni7CmymZ5SY7XKpqMf9TJBg63s3j5X49v7txCa
 /DiGrpk3lWqMg==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com,
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com, sebastian.reichel@collabora.com,
 sebastien.szymanski@armadeus.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH v4 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Date: Fri,  2 Aug 2024 11:25:34 +0200
Message-Id: <20240802092539.162892-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
Before doing that, a few general adaptions to the dwc_eth_qos.c main
driver are required. Most notably, the preparation for PCI based driver
instances, which do not necessarily use a device tree.

Changes in V4:
	- Fix printf format string

Changes in V3:
	- Replace mfence() with mb()
	- Clean-up eqos_get_base_addr()
	- Several style fixes for dwc_eth_qos_intel

Philip Oberfichtner (5):
  x86: provide mb() macro
  net: dwc_eth_qos: Fix header to be self-contained
  net: dwc_eth_qos: Adapt probe() for PCI devices
  net: dwc_eth_qos: Implement bind() for PCI devices
  net: dwc_eth_qos: Add glue driver for Intel MAC

 arch/x86/cpu/mp_init.c             |  10 +-
 arch/x86/include/asm/cpu.h         |   5 -
 arch/x86/include/asm/io.h          |   1 +
 drivers/net/Kconfig                |   7 +
 drivers/net/Makefile               |   1 +
 drivers/net/dwc_eth_qos.c          |  83 +++++-
 drivers/net/dwc_eth_qos.h          |   8 +-
 drivers/net/dwc_eth_qos_imx.c      |   6 +
 drivers/net/dwc_eth_qos_intel.c    | 449 +++++++++++++++++++++++++++++
 drivers/net/dwc_eth_qos_intel.h    |  57 ++++
 drivers/net/dwc_eth_qos_qcom.c     |   6 +
 drivers/net/dwc_eth_qos_rockchip.c |   6 +
 drivers/net/dwc_eth_qos_starfive.c |   6 +
 drivers/net/dwc_eth_qos_stm32.c    |   6 +
 include/pci_ids.h                  |   9 +
 15 files changed, 641 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_intel.c
 create mode 100644 drivers/net/dwc_eth_qos_intel.h

-- 
2.39.2

