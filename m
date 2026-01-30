Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274F7E6BF1B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A87783C30;
	Fri, 30 Jan 2026 16:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qbiK3wvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9CB844C0; Fri, 30 Jan 2026 16:39:37 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E23C883AA7
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1065784fac.2
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787573; x=1770392373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GMxpgNNrjoHv0jtFyvpH/mqqhUiJiwOGzFzEMLTMnnc=;
 b=qbiK3wvYXttnYTyOf0sLeupwhMgmDWS7wnTE6dqc+oIGItRyxcc+ZgFFMK8FHuFaVu
 5c65SXTPt1xML2FPFuOS5S2BFyOYfvIFNtoAWNonojqXniGBPnWDHX3baj17iFBEwXus
 74uMX3yfQ2pXYVtx7Qi3bUI7jyD/kgfpI0OOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787573; x=1770392373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMxpgNNrjoHv0jtFyvpH/mqqhUiJiwOGzFzEMLTMnnc=;
 b=HpzZx/kdTKkwxPODDupBGtNXREZpR6K3lq4jzZUCHL3rz6om3sLUiSA6yyVOwRbmdE
 Y9DcuGs23EWgRWmWd01B9r45UDLpG5YzzZRbkmptoS8/Xx15H+/e+sJaO33J7vV9YjVF
 CgrWpugLskLBMtQAJ4hR20c1XOPHmcb0GVe0aMK8ABwUvHydkw0pXnlXLWzyJ+rTT2H7
 idP2Njk2vkampTPtinm6gWXW9szapzVS1gfeb13xufYWVd8x/K6bYVEdO1oxceufwqXt
 9CF/gBQQY7p45cS0RL0uDYvtWq31TMCQVINnMj3317JU4cQ6RiHy9SXGdm4EqScqxZrc
 AkoQ==
X-Gm-Message-State: AOJu0YyfCPDYbIfqbUUhrsLaV/hgc9Zcu4kuS/cUVHzCgkElinAkMr8k
 xj7kcJhjlbz7dSGTQ0M2u2F2hiNFhC3T6gCQW/DSemj/RHZrAglsO9tT2GExwMQJP7RIcTXzlFd
 0BBEX
X-Gm-Gg: AZuq6aKijL3c3aRkUbuILHrKh7p6Cj3OutRqTFbzttm4Ry4a9IMLmDyWgOEtpOXq60T
 MkZnHwotm6qya/yStWeVAqWdrO91lXq8UtLrT/JZBQ65n51OggeowTWLsj+nmtVyLP0wspWJRj5
 I14DJwNUGFRHvQEhB6QiSCUxBhv357a8d9Dwvpk7Gtv/tG47xXFd2PcfDtxAtwP0K28hX1Lv3Ji
 ecw51Wy/xMxq6JKQKaHaheCfeuqnvn4BN5FVO9UClQ0+O+z5tDmqPKKRlv6o8qgkcl6/uvptjIx
 geZC5Kc2aNYmOLzsZW9aW5hE4c3u3p2+2LaI1bS+V1XTgzNj0obCzBP5Alr5iMjoO46glqpS4Z8
 fKyvxIr8T70kzaGOugd+9opp99/4MuhT24iz/1BeYBLozIInTu6a2TIDeB4JFeatwLr1uYSrHwU
 Gvna3n4XYKsqiCkm3pBTS1tAK93/g18JNqTJoQ/5/U0Gwg4A==
X-Received: by 2002:a05:6871:e28a:b0:409:3f13:f5e with SMTP id
 586e51a60fabf-409a6b755cdmr1669760fac.22.1769787572549; 
 Fri, 30 Jan 2026 07:39:32 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:32 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Judith Mendez <jm@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH v2 0/6] arm: k3: j722s: add PCIe support
Date: Fri, 30 Jan 2026 09:38:00 -0600
Message-ID: <20260130153856.2049575-1-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

This patch series brings over several changes from Linux that are required
to get PCIe working on the j722s and also enables PCIe in
j722s_evm_a53_defconfig. This allows Linux to be booted from an NVMe drive.

The J722S SoC provides pcie0 (using pcie_cdns_ti) thru serdes1
(using phy-cadence-torrent) thru serdes_wiz1 (using phy-j721e-wiz). Changes
to the three drivers needed to be ported from Linux to enable the REFCLK
output which is used with this SoC. These changes should be tested on other
platforms using these drivers by those with the hardware available to make
sure no problems were introduced.

The PCIe controller in this SoC relies on the code performing the PCI scan
not scanning devices which cannot exist. In Linux this is implemented as
only_one_child() in probe.c. If this mechanism is not used, PCI config reads
for subsequent functions will return information for device 0 resulting in
U-Boot detecting 32 devices when only 1 is present. This change should be
tested on other platforms with PCI to ensure the same PCI devices are
enumerated before and after the patch is applied.

I would like to thank Opto 22 for sponsoring the initial development and
anyone that is able to contribute to testing of patches.

Changes in v2:
- Return 0 if dev_get_parent_plat(dev) is invalid.

George McCollister (6):
  pci: skip unnecessary PCIe scanning
  phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
  phy: cadence-torrent: Add support to drive refclk out
  pci: pcie_cdns_ti: Add support to provide refclk to PCIe connector
  pci: pcie_cdns_ti: Add PCIe support for J722S SoC
  configs: j722s_evm_a53_defconfig: enable PCIe

 configs/j722s_evm_a53_defconfig           |   8 ++
 drivers/pci/pci-uclass.c                  |  35 +++++
 drivers/pci/pcie_cdns_ti.c                |  23 +++
 drivers/phy/cadence/phy-cadence-torrent.c | 168 ++++++++++++++++++++++
 drivers/phy/ti/phy-j721e-wiz.c            |  46 ++++++
 5 files changed, 280 insertions(+)

-- 
2.52.0

base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
branch: j722s-pcie-next
