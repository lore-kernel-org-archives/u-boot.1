Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62666C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 04:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280AB88488;
	Fri, 10 May 2024 06:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aYL0fM6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A10088488; Fri, 10 May 2024 06:50:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63EE687DEA
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 06:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A4oUIc090944;
 Thu, 9 May 2024 23:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715316630;
 bh=FZ8U2jq/Y+oeWQdKe9G52yKeYd6xgRs5Z5ZibmLSMEc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=aYL0fM6Tnaqtg6LaweMQkeJicx2CToCLKsGkXWX7QOEWjml2h1ThuJgBLcDBSxSow
 VPmQxepvALVmiNzxrPWZMMlxBMtH+dPsoJcE7RiZIMUKPRDa8btkT+sBwfJoPsBvva
 DENfdf4yOB9H9T3K+jcTY2SKN7GLNOioQQaK1G+4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A4oU48101371
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 23:50:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 23:50:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 23:50:30 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A4oMGK126967;
 Thu, 9 May 2024 23:50:27 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 10 May 2024 10:20:20 +0530
Subject: [PATCH v3 1/6] board: ti: j721s2: j721s2.env: Add explicit
 boot_targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240510-b4-upstream-j721s2-of-upstream-v3-1-43672b7134b7@ti.com>
References: <20240510-b4-upstream-j721s2-of-upstream-v3-0-43672b7134b7@ti.com>
In-Reply-To: <20240510-b4-upstream-j721s2-of-upstream-v3-0-43672b7134b7@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715316623; l=680;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=iUoIaGFgzDN+KiVHG83UNr6x3GKtvQVD2wwlc7cvMJw=;
 b=CDFpKgTgYYWtRdOhxDot4/5t9gOeWJu9hd63XdrHtez8fRsEUblsmgT6jc0Aj/ZSQiVIGvbdL
 Q8bl3nMYmYZCCnjwiKVIwRznQW8Hl+4vbjE4yOOgkatENXav4Yti9Go
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

From: Neha Malcom Francis <n-francis@ti.com>

Add explicit boot_targets to indicate the specific boot sequence to
follow.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/j721s2/j721s2.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/j721s2/j721s2.env b/board/ti/j721s2/j721s2.env
index 9a03b9f30aee..a6b22550809e 100644
--- a/board/ti/j721s2/j721s2.env
+++ b/board/ti/j721s2/j721s2.env
@@ -13,6 +13,7 @@ args_all=setenv optargs earlycon=ns16550a,mmio32,0x02880000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2

-- 
2.43.2

