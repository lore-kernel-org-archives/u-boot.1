Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15AFC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 10:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F299282F5D;
	Fri, 27 Jun 2025 12:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VssDtDG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 110E582E35; Fri, 27 Jun 2025 11:23:00 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30F182E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55R9MZbK2373346;
 Fri, 27 Jun 2025 04:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751016155;
 bh=7pwzjtCNnMkzDEofUfyAmwTh3WxNA0gNdZ4J78Xmhuw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VssDtDG40yvsoILqg+bta9xIcTeWh/I+MDHBlM0ZZBqI6veLTv34zS39cOdm+XFph
 zu0++SdTl37/IjWBxWe/eC+tkVekzWBLSVPt5E92U3WwLSh197XB2wUqzRDTH5f9aX
 3Jk6GiW3xiZlt1UIJR7tvoAJ14cbqrPXtzR+JIi4=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55R9MZEd3106383
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 04:22:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 04:22:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 04:22:34 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.72.138])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55R9MQWt2835580;
 Fri, 27 Jun 2025 04:22:31 -0500
From: Gokul <g-praveen@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>
CC: <1425075683@qq.com>, <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>, 
 Gokul Praveen <g-praveen@ti.com>
Subject: [PATCH 1/1] configs: KASLR OPTEE RNG support for K3 devices
Date: Fri, 27 Jun 2025 14:52:24 +0530
Message-ID: <20250627092224.36325-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627092224.36325-1-g-praveen@ti.com>
References: <20250627092224.36325-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 27 Jun 2025 12:51:18 +0200
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

Add KASLR OPTEE RNG support across K3 devices by enabling the required
configs.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
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
+	imply DM_RNG
+	imply TEE
+	imply OPTEE
 
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2+"
-- 
2.34.1

