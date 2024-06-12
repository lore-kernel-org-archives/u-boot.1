Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A15C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 11:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619C9887FB;
	Wed, 12 Jun 2024 13:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gBqFa43t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0CB887F0; Wed, 12 Jun 2024 13:08:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27309887B3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7vLP074099;
 Wed, 12 Jun 2024 06:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718190477;
 bh=h2iRrgQOI+/5OMVqCG0XrCtyverrR62sKmBaHq2xcFU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gBqFa43t3ZckFISGyNaKFK9VMKaS+uz/tsnvTvOll/ZS0ywtzBXpKA8pjC4bZKiHi
 g7Kp+uMcAwiwK45Z3Qa1+AMpM/evpWnfrOgmyOhfyzRmjrOl0C6XqTra7QaeAWoGDI
 HIIhjGCqlrJQp8ORd9jQOEVLt98wS8FVScMtlKsk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CB7vME014820
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 06:07:57 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 06:07:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 06:07:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CB7vnp099798;
 Wed, 12 Jun 2024 06:07:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45CB7uA8031843;
 Wed, 12 Jun 2024 06:07:57 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Judith Mendez <jm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: [PATCH v2 2/2] board: ti: am64x: Set storage_interface and
 fw_dev_part ENVs
Date: Wed, 12 Jun 2024 16:37:49 +0530
Message-ID: <20240612110749.1699824-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612110749.1699824-1-danishanwar@ti.com>
References: <20240612110749.1699824-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

When ICSSG driver is enabled (CONFIG_TI_ICSSG_PRUETH=y) set
storage_interface and fw_dev_part env variables.

These variables need be set appropriately in order to load different
ICSSG firmwares needed for ICSSG driver. By default the storage
interface is mmc and the partition is 1:2. User can modify this based on
their needs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 board/ti/am64x/am64x.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index 9a8812d4ee..8ad805a613 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -39,3 +39,8 @@ usbboot=setenv boot usb;
 	run get_kern_usb;
 	run get_fdt_usb;
 	run run_kern;
+
+#if CONFIG_TI_ICSSG_PRUETH
+storage_interface=mmc
+fw_dev_part=1:2
+#endif
-- 
2.34.1

