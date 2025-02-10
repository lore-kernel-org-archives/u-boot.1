Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F7C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77797803B5;
	Mon, 10 Feb 2025 12:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FJD+fsOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9152807D6; Mon, 10 Feb 2025 12:23:06 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A9BE801F5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABMkS6032325
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Feb 2025 05:22:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186566;
 bh=kBo9Cu78zDj80DfdQmvQuCeklzoao9Mj54Bl7QC0Fxw=;
 h=From:To:CC:Subject:Date;
 b=FJD+fsOB1fj8b6+fNF1FJeyIG/jpWUaHtB7HTkHBhzz7F6XygibpQmV/8HBtgu5Tj
 eSoxvH9l8gfF9I+nJKXurXMgZdfhUjlBE2rOP/R4/xTgsIICII9315BJbCoTjELut0
 Ac6lyMeDHWWcHb0IwNP+NPfSb0MCW9cxHsHTD6cI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMkrv126299;
 Mon, 10 Feb 2025 05:22:46 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:22:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:22:46 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb2047041; 
 Mon, 10 Feb 2025 05:22:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 0/7] AM62,AM62-LP,AM62A,AM62P,J722S: USB DFU and UMS
Date: Mon, 10 Feb 2025 16:52:23 +0530
Message-ID: <20250210112239.2639009-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello,

This series enables USB DFU and USB Mass Storage functionality for
AM62, AM62-LP, AM62A, AM62P and J722S SoCs.

Series is based on commit
d6da3dbaef Merge patch series "cmd: Add support for optee commands."
of the next branch of U-Boot.

The first patch of this series is a repost of the v1 patch at:
https://patchwork.ozlabs.org/project/uboot/patch/20250122121338.1055249-1-s-vadapalli@ti.com/

Patches 2, 3 and 4 are a repost of the v3 series at:
https://patchwork.ozlabs.org/project/uboot/cover/20241221025229.361625-1-s-vadapalli@ti.com/

Patches 5, 6 and 7 have been newly introduced in this series.

Regards,
Siddharth.

Siddharth Vadapalli (7):
  configs: am62ax_evm_a53_defconfig: enable USB DFU support
  board: ti: am62px: env: include environment for DFU Boot
  configs: am62x_r5_usbdfu: extend for AM62Px
  configs: am62px_evm_a53_defconfig: enable USB DFU support
  board: ti: j722s: env: include environment for DFU
  configs: j722s_evm_a53_defconfig: enable USB DFU support
  configs: am62x_a53_usbdfu: enable USB MASS Storage command

 board/ti/am62px/am62px.env       |  5 +++--
 board/ti/j722s/j722s.env         |  1 +
 configs/am62ax_evm_a53_defconfig |  2 ++
 configs/am62px_evm_a53_defconfig | 24 +-----------------------
 configs/am62x_a53_usbdfu.config  |  1 +
 configs/am62x_r5_usbdfu.config   |  3 +++
 configs/j722s_evm_a53_defconfig  |  5 +++--
 7 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.43.0

