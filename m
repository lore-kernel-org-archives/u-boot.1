Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B8BCD128A
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 05:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11333882FF;
	Mon,  1 Apr 2024 07:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N5NRUmd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55188882FF; Mon,  1 Apr 2024 07:47:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360C288300
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 07:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4315l4WO099716;
 Mon, 1 Apr 2024 00:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711950424;
 bh=NISPWknPHTO9vfH063Nl4Dw4FV9h9eXIA+yh8+ouXes=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=N5NRUmd1ieFBMxHgoyVFTsfNOkXFpd4a7gXWzNUu8sf3mEkcddyI9oWttRC1/0Xky
 rpI3xZ4QIOEa/bMubpCqlOvmDR3wOBqsnvvNhPJOa/dg7kg2vcORwNw8lv0qLS4sD0
 nyn83g8up3o1TMDwCEl4iPWbMJDE/JS/TLWW4WKU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4315l4CD007106
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Apr 2024 00:47:04 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 00:47:03 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 00:47:03 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4315koAG131070;
 Mon, 1 Apr 2024 00:47:01 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 1 Apr 2024 11:16:48 +0530
Subject: [PATCH 3/4] arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the
 ospi0 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240401-b4-upstream-j721s2-ospi-support-v1-3-20e4a0024db9@ti.com>
References: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
In-Reply-To: <20240401-b4-upstream-j721s2-ospi-support-v1-0-20e4a0024db9@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711950410; l=630;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=/HdC54+2LzEShgKSP+5IgqS7V4thD/O940+e6cJmGgo=;
 b=scYJV8utzi26SqZnRmrSt16tgLyENTive3B+9PwJgr0xTV2ebiSlDPmcde1nqen4/S/9TyQj0
 dcL+lNQHYRbAiKLdRjCr0tH9uehk1hq6UauZd3RMlSDHRqAkHF8t+GU
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

Enable ospi0 node for all boot stages

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index a3ebf5996eac..132cd5a456ba 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -110,7 +110,9 @@
 };
 
 &ospi0 {
-	status = "disabled";
+	flash@0 {
+		bootph-all;
+	};
 };
 
 &ospi1 {

-- 
2.43.2

