Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0543FC83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 13:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E436835C9;
	Thu, 10 Jul 2025 15:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VJ3VLX4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0682D835B6; Thu, 10 Jul 2025 11:59:35 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C29834BC
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 11:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A9xSWx1108685;
 Thu, 10 Jul 2025 04:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752141568;
 bh=boMjefzbQ1NBGkmMncIjnAaawQglbwdoa49apJQyKvg=;
 h=From:To:CC:Subject:Date;
 b=VJ3VLX4aKtAEwK0oAjpFj6WHG28+r+XhDTMWpW8HJyXVKbKDsmErBsDBYFdWVkIrw
 yVrSZF2q1eg9B7GiqHBxhXG+thYGfrUGSiss12e/tYChBpFGDlgcEwcxeFN8oeSmdF
 kVE/Wz1/2cZkKJEDOcHzwy5DtYQ47hx3zbcBKdSA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A9xSTt2928385
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 10 Jul 2025 04:59:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 04:59:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 04:59:27 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A9xOes1147418;
 Thu, 10 Jul 2025 04:59:25 -0500
From: Gokul <g-praveen@ti.com>
To: <trini@konsulko.com>, <rayagonda.kokatanur@broadcom.com>,
 <casey.connolly@linaro.org>, <sjg@chromium.org>, <m-chawdhry@ti.com>
CC: <g-praveen@ti.com>, <u-boot@lists.denx.de>, <j-keerthy@ti.com>
Subject: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
Date: Thu, 10 Jul 2025 15:29:22 +0530
Message-ID: <20250710095922.144361-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 10 Jul 2025 15:05:38 +0200
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

From: Gokul Praveen <g-praveen@ti.com>

KASLR, or Kernel Address Space Layout Randomization, is a security
feature in the Linux kernel that randomizes the memory location
where the kernel is loaded during boot.

OP-TEE RNG is a Random Number Generator (RNG) component within the
Open Portable Trusted Execution Environment (OP-TEE) which provides
a random number to U-BOOT and U-BOOT provides this random number
as seed value to the LINUX kernel for KASLR.

Add KASLR OPTEE RNG support across K3 devices by enabling the required
configs.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
v2<==> v1
===========
* Added 'if' condition for configs to avoid enabling this feature
  in R5.

Boot logs Link :

https://gist.github.com/GokulPraveen2001/44aa8c0962438c12ffc55e6ed67742e5
---
 arch/arm/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7282c4123b0..cd27e5a5422 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -805,6 +805,9 @@ config ARCH_K3
 	select REGEX
 	select FIT_SIGNATURE if ARM64
 	imply TI_SECURE_DEVICE
+	imply DM_RNG if ARM64
+	imply TEE if ARM64
+	imply OPTEE if ARM64
 
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2+"
-- 
2.34.1

