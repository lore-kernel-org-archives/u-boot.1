Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C67D5A6E4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 06:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE0A89C15;
	Tue, 26 Nov 2024 07:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FzIGGVsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10DE89C1A; Tue, 26 Nov 2024 07:36:01 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428D189C3C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ6Zu42467148
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 Nov 2024 00:35:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732602956;
 bh=fnW8q33tUf3a39lu97lYxvTuuJLq1ossS+xznfxpHG4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FzIGGVsu4Qq5HbXoADhEhLGbTvgCmXBItckiyay06NTCQtQa2rCf3Ohr2NRf2DQfH
 VKSAvSTx+3O2LQmMYkfjn13w4eCTinGHmg9EvT7rxkzQQrbw2dYeDSASpM3H7yGSkO
 t897wkDgerVB98s8H7stn3ZBCy1zGH3Xi4nKfIy8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ6ZugC079909;
 Tue, 26 Nov 2024 00:35:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 00:35:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 00:35:56 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ6ZikP051095;
 Tue, 26 Nov 2024 00:35:53 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <n-francis@ti.com>, <afd@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
 <reidt@ti.com>, <u-kumar1@ti.com>
Subject: [RFC PATCH 3/3] arm: dts: k3-j7200: Add bootph for esm and pmic nodes
Date: Tue, 26 Nov 2024 12:05:43 +0530
Message-ID: <20241126063543.2678052-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126063543.2678052-1-u-kumar1@ti.com>
References: <20241126063543.2678052-1-u-kumar1@ti.com>
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

In order to get esm and pmic probed by R5 SPL, these nodes should
be have bootph pre ram property.

However these changes are committed in kernel with following sha-id
b903ab269e67 (arm64: dts: ti: k3-j7200: Add bootph-* properties)
and bdb543b1664b (arm64: dts: ti: k3-j7200-evm*: Add bootph-* properties).

While we wait for above committed to get synched with u-boot.
Meanwhile add bootph in these nodes.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 53c8d7827b9..64a4ffd3605 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -115,3 +115,11 @@
 		bootph-pre-ram;
 	};
 };
+
+&bucka1 {
+	bootph-pre-ram;
+};
+
+&main_esm {
+	bootph-pre-ram;
+};
-- 
2.34.1

