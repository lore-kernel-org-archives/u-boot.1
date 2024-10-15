Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FCECFC288
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650CD89181;
	Tue, 15 Oct 2024 12:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sDwjjPYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C8E891AB; Tue, 15 Oct 2024 12:52:52 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D681B89182
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqjuK105000;
 Tue, 15 Oct 2024 05:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989565;
 bh=qoRhkOHuDBq9sVJlHhvyof9v1p3YvpXVwivAABQiOMY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=sDwjjPYwl7NfQi/vgzawK13s/Hdes1TJYTaLriIc6vPa3cdk04DL3Ag+9AaotPkzj
 FRdk6xwDbuKRrGqW2AxHdE7DO4PMqgf11ypIeDzpDa+ZvBhNY+jgwk5rUaC/rsdvbP
 WVRfJof5xog5jRuKTb6VCjao+RvYqKODx8aeRGFM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FAqjZg096009
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 05:52:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:45 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbk044559;
 Tue, 15 Oct 2024 05:52:42 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 15 Oct 2024 16:22:22 +0530
Subject: [PATCH v5 6/7] arm: dts: j721s2: Add VTM node in R5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-6-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=1106;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=6BwEbGil6535yH1We6z11goVexToo20wCKkKbJ+Czfw=;
 b=s+TQMtUuQze0d4Uq8dHZ7yp80ZB9FgbqDO/2da4p/Wg6dj8gLsk/g5cMMEX5C4uWVpfBLDwI+
 XCfohWX8bXSB1s+0no7HXuCGXjxLHjtV+1xj6Kp5LGZSJHoE/lDEX2z
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Also adds bootph-pre-ram property to VTM node and the pmic node.

vdd-supply is used to assign the buck regulator that the AVS driver can
use to program the proper voltage which it picked up from e-fuse.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    Patches are posted to Linux [0]
    
    [0]: https://lore.kernel.org/linux-arm-kernel/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/#

 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index e92b1917df4e..506ad9b7910d 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -10,3 +10,12 @@
 #include "k3-j721s2-ddr.dtsi"
 #include "k3-j721s2-common-proc-board-u-boot.dtsi"
 #include "k3-j721s2-r5.dtsi"
+
+&tps659411 {
+	bootph-pre-ram;
+};
+
+&wkup_vtm0 {
+	bootph-pre-ram;
+	vdd-supply-2 = <&bucka1234>;
+};

-- 
2.46.0

