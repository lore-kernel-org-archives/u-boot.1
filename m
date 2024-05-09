Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0687DC25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 09:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52908848D;
	Thu,  9 May 2024 11:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aRqGmsWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74EF588470; Thu,  9 May 2024 11:53:40 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576CC88480
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 11:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4499rZxS088335;
 Thu, 9 May 2024 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715248415;
 bh=OTMLHRYOw2mcmFbkn1sdbJGR+flk2hP8ruarAxDqftI=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=aRqGmsWVm0upucyhJkeAXZ6NL5TmSyj//aFjpiXgRpQqB9ei4JLbJ8tpJ2bLbRabP
 02ZCjMPoYwiVcQ+aLCZ6fN/Jp/CJkfxlLM7+WAPD1KvJ644Bam+Biv8zgp9WEPKEAG
 JXxce6qpgT3ZeLLyJ9oJdaWJIeqEw0rKWUl0LBo0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4499rZkP055299
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 04:53:35 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 04:53:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 04:53:34 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4499rKt4075143;
 Thu, 9 May 2024 04:53:31 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 9 May 2024 15:23:17 +0530
Subject: [PATCH v2 3/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5 file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240509-b4-upstream-j721s2-of-upstream-v2-3-149563cd4901@ti.com>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715248401; l=1473;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=px1ygQx8uXTg4Ux6TwbBUJxRwUvaiu9lRzqmhzy7ZpA=;
 b=opTq9Q44uKKEjX8QGCTVmsAdoe+PnxtVn0gLd8yYybvPp/j+BwQAs+cabit/NJiPcmWxDORWq
 qZkDCAZO0FqDzlWEcM0XNfoVjIWaVMhH+pBTCZwfQnwn/FsFkaJKxRp
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

Currently AM68 SK boots with J721s2 R5 DTS and then later changes to
AM68 SK DT during runtime.

To split the support of J721s2 and AM68, sync AM68 R5 DT with J721s2 R5
DT as that contains some essential node changes for booting up AM68
using AM68 R5 DT.

secure_proxy_mcu and secure_proxy_sa3 node changes are required for
establishing contact with TIFS running on M4 core, and the addition of
new power domain helps in holding A72 in reset for configuration of
firewalls.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
index 695aadc287bd..038b08dc3e01 100644
--- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
@@ -24,7 +24,8 @@
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
 		clocks = <&k3_clks 61 1>;
 		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
@@ -54,10 +55,12 @@
 
 &secure_proxy_mcu {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &secure_proxy_sa3 {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &cbass_mcu_wakeup {

-- 
2.43.2

