Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBF3C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 08:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E20088BEE;
	Fri,  3 May 2024 10:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714726211;
	bh=huSvcz0FqCj1KqqDxCELy58ZCEwURhwbjhszNycDtr8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VSpgrWaSj7tNgPAwY46MnVf7Ax+g+MpjIzotH6WCDyj5Mzi2baocj0pXaUUiBbyGO
	 QzL/nknaiay8SgueP+HRhUSWzlXOsGG5Y/HSoT1p+wkbvoDhgayq6kSCBgi9IQwHNI
	 cB48CkCa4BS9h+sP4izgqg7qpmRpnSiGPVm5qw8aHzXmq0PuHlnaPCemmek+GEdUkU
	 /CKmGyD0u/5TYxl1oEv9RcfjCEPeG8O0Bbj2Hfp8+WCPHzo7sLbNx+XvIVs+0uuJbj
	 BcrDbUUXDnAYUHcdhrwGpUTgDSQw/C5u1r2qLJvoYrauxJ/p4wn8m/7VpgP7e3iMuW
	 VavP6rykotdFw==
Received: from localhost (unknown [IPv6:2001:861:52:5f60:ff6c:4545:dfcf:4c97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 60C1988BE1;
 Fri,  3 May 2024 10:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714726209;
 bh=huSvcz0FqCj1KqqDxCELy58ZCEwURhwbjhszNycDtr8=;
 h=From:To:Cc:Subject:Date:From;
 b=H3O+i5QJ/C701bbiuObKum//F6svjdPMFkbpI4UUou+aErcOJ5opDRwotcRpX9lBg
 8VM4ZH++Z0GuJcNNGCaKXrx8OFQYolQ5jN9UQMgcS/JmBqHiVhYdT11GmHgO+Ctntz
 AkLQ/sM5S6Vh6Z07NFN6A8EHFxJ12td4A8kwXMzr7hc1JTqgIY2eGlHYJgDaLOD+d3
 Pa9Mv6OQxwBiNbsJihrnLyCyWnwvXz+YhE2t6ZxG+kpe3jaJ/k7K5qMFP22jXDpKjc
 Nvpg+AIfpDkbPxlOb5+Ne2KeYsq7aPfYNurIoeDFLZpyeeIRMJo5e6/tmN9crYLx55
 rPI20BSn6LkGQ==
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
 trini@konsulko.com, xypron.glpk@gmx.de, yanhong.wang@starfivetech.com,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Date: Fri,  3 May 2024 10:49:45 +0200
Message-Id: <20240503084950.70680-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch series depends on: "net: dwc_eth_qos: mdio: Implement clause 45":
https://patchwork.ozlabs.org/project/uboot/patch/20240423085158.29246-1-pro@denx.de/

Philip Oberfichtner (5):
  x86: provide mb() macro
  net: dwc_eth_qos: Fix header to be self-contained
  net: dwc_eth_qos: Adapt probe() for PCI devices
  net: dwc_eth_qos: Implement bind() for PCI devices
  net: dwc_eth_qos: Add glue driver for Intel MAC

 arch/x86/include/asm/io.h          |   1 +
 drivers/net/Kconfig                |   7 +
 drivers/net/Makefile               |   1 +
 drivers/net/dwc_eth_qos.c          |  44 ++-
 drivers/net/dwc_eth_qos.h          |   9 +-
 drivers/net/dwc_eth_qos_imx.c      |   1 +
 drivers/net/dwc_eth_qos_intel.c    | 446 +++++++++++++++++++++++++++++
 drivers/net/dwc_eth_qos_intel.h    |  58 ++++
 drivers/net/dwc_eth_qos_qcom.c     |   1 +
 drivers/net/dwc_eth_qos_rockchip.c |   1 +
 drivers/net/dwc_eth_qos_starfive.c |   1 +
 drivers/net/dwc_eth_qos_stm32.c    |   1 +
 include/pci_ids.h                  |   9 +
 13 files changed, 576 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_intel.c
 create mode 100644 drivers/net/dwc_eth_qos_intel.h

-- 
2.39.2

