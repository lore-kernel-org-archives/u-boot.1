Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC73C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C480187534;
	Mon, 27 Nov 2023 11:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mvD0nFoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1662887544; Mon, 27 Nov 2023 11:29:30 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC4AD8753F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATPT7002169;
 Mon, 27 Nov 2023 04:29:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701080965;
 bh=eRBdPqzhMbf9UedzwdjQ5kz8yAkQAVzmEmUsakEx6fo=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=mvD0nFohPFOYF74b8/ZVsN/TfO/1qkQ85zvbBO6I5iXeMq02dOsuRoN6KTeVONshy
 H0AYpm2thnedRQaZP/RAvY4Rh+We9hIDCuOkL1OFELKTdlBNi1Arl1opxyA60z4paM
 I49vaBbLuy70TPwFoubvqrt1ZnuBFDzhWJ87F+YU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARATPnr072291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 04:29:25 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 04:29:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 04:29:25 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATDld089434;
 Mon, 27 Nov 2023 04:29:23 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 27 Nov 2023 15:59:14 +0530
Subject: [PATCH v2 3/3] env: ti: j721s2.env: Remove the processors that are
 in lockstep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-b4-upstream-j721e-rproc-support-v2-3-22ee7c8ef53c@ti.com>
References: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
In-Reply-To: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701080953; l=1013;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=bOnRPTdirTzACpeUYnPjO1rlKV0F0YjtUyqoCXnEljI=;
 b=wNuYGafpijNV28HSirsjKce/jPIu+e2aB3HHzor3/nk6VjyV+Djt23NAE1A1xZKRYLu58s305
 zgqZ5FttL8IDJel5fEZ+XQ21Y9eHL9TQ7vuwREtnAaZWkqF57hj/k6X
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

Linux 6.7-rc1 DT have the main R5s in lockstep configuration, since
U-boot is using the Linux DT files.

Remove the processors that will be booted in lockstep configuration.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j721s2/j721s2.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index 64e3d9da85f0..1802147a9034 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -31,6 +31,6 @@ name_mcur5f0_0fw=/lib/firmware/j7-mcu-r5f0_0-fw
 #endif
 rd_spec=-
 
-rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 3 /lib/firmware/j721s2-main-r5f0_1-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 5 /lib/firmware/j721s2-main-r5f1_1-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
+rproc_fw_binaries= 2 /lib/firmware/j721s2-main-r5f0_0-fw 4 /lib/firmware/j721s2-main-r5f1_0-fw 6 /lib/firmware/j721s2-c71_0-fw 7 /lib/firmware/j721s2-c71_1-fw
 
 

-- 
2.41.0

