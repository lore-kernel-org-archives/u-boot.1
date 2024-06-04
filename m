Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74BAC25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A88788438;
	Tue,  4 Jun 2024 08:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sq27QXZX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DE28843A; Tue,  4 Jun 2024 08:09:20 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16CF488418
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45469FrQ053979;
 Tue, 4 Jun 2024 01:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717481355;
 bh=tG2TjvCajQJ2fSd9TaCXr13ih32vs9nyQM0d8hm1Sgc=;
 h=From:Subject:Date:To:CC;
 b=sq27QXZXFTrmFSMpXi50pYBe1TvfOnjpVkSYgumBKqzW2hPEc6sT7YQOLT9eY0epY
 +O2dUU7fqT9wuUK2hEKWgW9ej2qwUV8UwVx0lmzkJQFu0AIHQINQ3Nv5MjJFUfIxAk
 tv7U778boOvalQUx9q4P1fPxuS//C3doid5HMi8o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45469Fg1109543
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 01:09:15 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 01:09:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 01:09:15 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45469BfD022510;
 Tue, 4 Jun 2024 01:09:12 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/4] Enable OSPI boot for j721s2
Date: Tue, 4 Jun 2024 11:39:09 +0530
Message-ID: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIWvXmYC/4XNQQ6CMBCF4auQrh1ThiLiynsYFy0dpCbQpi1EQ
 7i7BRNdsvwnme/NLJA3FNglm5mnyQRjhxTFIWNNJ4cHgdGpGXIUvEAEJWB0IXqSPTwrzAOCDc5
 AGJ2zPoIWpW6lrPGkG5YU56k1r23hdk/dmRCtf2+DU75ev7bg+a495cABOQnJ04tW9TWaY2N7t
 sIT/rESz/sYJkwhFRWSarSuftiyLB/F2gZbGAEAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Jon Humphreys <j-humphreys@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Pratyush Yadav <p.yadav@ti.com>, Apurva Nandan
 <a-nandan@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717481351; l=1345;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=xRoTpkl5Mnc1W+1AJGRekbQp0JctbhzL0QJ8cJ733I8=;
 b=ya9WCyla3OnDj6Eq23/N3VRX6APAX2t7491QSBp2pu8ZYqaRIqQmJcicCD8LbMRa/FOOtfyo7
 9hct76TJV9NCGFoptd8jcCSjgp5uf0116Ga8aPG3x28HDmd1Wps6NMO
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The series enables ospi boot for j721s2.

Test logs: https://gist.github.com/manorit2001/6bb91885c608e3a8cb0267ab2c614781

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
- Rebase on top of -next
- Remove SF_DEFAULT_MODE as it's default 0
- Add new properties in correct location as per savedefconfig
- Link to v2: https://lore.kernel.org/r/20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com

---
Manorit Chawdhry (3):
      arch: arm: dts: k3-j721s2-r5: Override ospi and fss for 32-bit mode
      arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the ospi0 node
      configs: j721s2_evm_*_defconfig: Enable OSPI configs

Pratyush Yadav (1):
      mtd: spi-nor-core: Do not start or end writes at odd address in DTR mode

 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  4 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                     | 13 +++++
 configs/j721s2_evm_a72_defconfig                   |  1 +
 configs/j721s2_evm_r5_defconfig                    |  1 +
 drivers/mtd/spi/spi-nor-core.c                     | 59 ++++++++++++++++++++--
 5 files changed, 73 insertions(+), 5 deletions(-)
---
base-commit: 15d0dcc0ec1f424199dff2a3cbe037bc3a7d8749
change-id: 20240322-b4-upstream-j721s2-ospi-support-d45dfaa926dc

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

