Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084C3C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F8087FA7;
	Wed,  6 Mar 2024 13:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ACgTXAl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB4687D14; Wed,  6 Mar 2024 07:38:07 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005B287FC8
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4266c4eQ022868
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709707084;
 bh=0ihdpssQ4vcbsXb2m65ousmQos3XEDVMROqaBmiQKgI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ACgTXAl4cr/wK6O1FqJxqtIIDMnV7SjR1KLADI7SgaHAaQsQaH+bIaGj4XEzED4ll
 VLc/jj5H1wpORLgwF+fsvhATIAoGx23TJIqmpzwEgCgt9olmLN/n3EhWyKFk9f1bB7
 ocmYQcXFmIluKh9hwCpD48AeUz17rF0H3ltSb4hg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4266c4Yu059866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:38:04 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 00:38:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 00:38:04 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.68.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4266bsdo012351;
 Wed, 6 Mar 2024 00:38:02 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <a-nandan@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH 4/4] arm: dts: k3-j7200-r5-common: Add missing overrides for
 ringacc and udmap
Date: Wed, 6 Mar 2024 12:07:49 +0530
Message-ID: <20240306063749.1411176-5-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306063749.1411176-1-a-limaye@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Corrects the ti,sci property to point to dm_tifs node for proper
functioning of mcu_ringacc and mcu_udmap.

Fixes: df73e791ce09 ("arm: dts: j7200: dts sync with Linux 6.6-rc1")
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index c4ca09b1e0..fb7e2e5023 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -88,3 +88,11 @@
     reg = <0x0 0x47040000 0x0 0x100>,
           <0x0 0x50000000 0x0 0x8000000>;
 };
+
+&mcu_ringacc {
+    ti,sci = <&dm_tifs>;
+};
+
+&mcu_udmap {
+    ti,sci = <&dm_tifs>;
+};
-- 
2.34.1

