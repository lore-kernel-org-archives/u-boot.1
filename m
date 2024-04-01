Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D606ACD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 05:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1CF882E1;
	Mon,  1 Apr 2024 07:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ICmprmqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A77882E6; Mon,  1 Apr 2024 07:47:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED8C882DC
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 07:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4315kspg010001;
 Mon, 1 Apr 2024 00:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711950414;
 bh=RgwgOAohJZNjzpn0t/Mmf/OmYc/J0YRuvONngNtVd5M=;
 h=From:Subject:Date:To:CC;
 b=ICmprmqIz80yPG0FkEVHdjIw//KjfBWjgceJvQZ4W3IoyOLoFKu5aZOfv1njwL9/h
 G0UDuvDDP9S+qowgL4WzEXwBjRNV911W2HhIQ4aOUwraT9PBpg0OIlZ566qIts/hhN
 ydbzb3a1P/vmT2yZTkNYDBmg2DhszMfe7LIh2WjI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4315ksmI081717
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 00:46:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 00:46:54 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 00:46:54 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4315koAD131070;
 Mon, 1 Apr 2024 00:46:51 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/4] Enable OSPI boot for j721s2
Date: Mon, 1 Apr 2024 11:16:45 +0530
Message-ID: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVKCmYC/x3NQQqDQAxA0atI1g1oHCvtVUoXUyfWFOqERIsg3
 r2Dy7f5fwdnE3a4VzsY/8QlzwXNpYJhivObUVIxUE2hbonwFXBVX4zjFz89NU6YXQV9Vc22YAp
 dGmO80TUNUCpqPMp2Hh7P4/gDgf9NeHEAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Pratyush Yadav <p.yadav@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711950410; l=1084;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=A3v0RVWEB1wZjsEcMguI37G3kKGnxa4ovjTCGfRk8WM=;
 b=U5Wtid6B8jO3NtqQ07XVxRm+g95Gyy7xXGNeNmz27gHi9zwNDgEGCxBVBaTGR2tEkMRf7qAae
 oDsgI2zFpExCxaz1vSLz3rk6nxAi/qr18QC7KRcrkEfZpqGKKrtCmf0
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
Manorit Chawdhry (3):
      arch: arm: dts: k3-j721s2-r5: Override ospi and fss for 32-bit mode
      arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the ospi0 node
      configs: j721s2_evm_*_defconfig: Enable OSPI configs

Pratyush Yadav (1):
      mtd: spi-nor-core: Do not start or end writes at odd address in DTR mode

 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  4 +-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 13 +++++
 configs/j721s2_evm_a72_defconfig                   |  3 ++
 configs/j721s2_evm_r5_defconfig                    |  3 ++
 drivers/mtd/spi/spi-nor-core.c                     | 59 ++++++++++++++++++++--
 5 files changed, 77 insertions(+), 5 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240322-b4-upstream-j721s2-ospi-support-d45dfaa926dc

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

