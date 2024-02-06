Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2733BC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1C787CF6;
	Tue,  6 Feb 2024 13:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ps5dsvB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A710F87CF9; Tue,  6 Feb 2024 13:21:44 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F5C87CE6
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416CLeNq074460;
 Tue, 6 Feb 2024 06:21:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707222100;
 bh=x6LWcdh1uCdBJ3vnD92keilbRDhbTqo9FQFcc4TYIkM=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Ps5dsvB1rm301EveX2nDPp3HQKLEeF1TJdAIy0zkj70wmDWOudqF0tycHXFeMiFt+
 67xtSe3UDcd8Sv+LTKtKI/Gm3P09ujxOHzzadGTgcwxueFRNd7AgrMKZvkcvZZUIVh
 1G+R9dwhPH7Zq8rD3/nV67JVxe2Mpx91tsA7bJ7g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416CLe8F076527
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 06:21:40 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 06:21:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 06:21:40 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416CLAi7081923;
 Tue, 6 Feb 2024 06:21:37 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 6 Feb 2024 17:51:15 +0530
Subject: [PATCH 08/10] arm: dts: j721s2: Add VTM node in R5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-b4-upstream-j721s2-avs-v1-8-b75043c59969@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707222070; l=678;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=mWJgcE7yQ1eVQlraZEusH8wazDXl6/mWpf+pmIuSh0o=;
 b=cps/JxDzY/7ZbwN8/gwv3gJqWnek4m+ExfLD+IMtTXEw4dmoQuhnZVFMPHVqr8zis9uwpNRJf
 DhN3DMu6rBGArmRPfNjhsZ0adz0qCPDe/njcGaJWGmBdiwFXK0Sz711
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

Add bootph-pre-ram property to VTM node and the pmic node.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index 03bd680f4421..391baff2b608 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -86,3 +86,12 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
+
+&tps659411 {
+	bootph-pre-ram;
+};
+
+&wkup_vtm0 {
+	vdd-supply-2 = <&bucka1234>;
+	bootph-pre-ram;
+};

-- 
2.43.0

