Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8F0C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3488780E;
	Fri, 22 Dec 2023 16:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=loiseau.fr header.i=@loiseau.fr header.b="QdWweLRS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CD48786F; Fri, 22 Dec 2023 16:44:45 +0100 (CET)
Received: from envoi.jabatus.fr (envoi.jabatus.fr [109.234.163.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD59874D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anthony@loiseau.fr
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-25.979, required 5, autolearn=disabled, MED_SPX 1.00,
 RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00, SPF_PASS -1.50, VM03 0.01,
 WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail
 Service Provider for details
X-MailPropre-MailScanner-ID: 6690DE0325.A3DED
X-MailPropre-MailScanner-Information: Please contact the ISP for more
 information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr; 
 s=default;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dzQgUaMc4xJFKmH00D/oj3xMQs6IaqysnQmReY1ITyM=; b=QdWweLRSHZ6uS9wACwb78mRmQN
 P+p2rgPj0xhb/2neL3znY1iwqtnJ3cQLwbaj3RAkE3RWU5FxkOdtzI/3dB+Zh+ANo3JcesCdshCC1
 FPD0TGthnnzD9OQqaEO1jrnpPKgWGhB24A1+ayw5y3byjFn3QK/+cB14ZD/uAqhD3f5zumOQm2+lp
 I57AdE7H0vRyOpomJUx+0kw18xrbxiVDHokvmZhTHjXmDORbJm9kOcKxdQthVu8qo92JDmPaqGKET
 5hvYTAXNFNEeBNibEqUmtx3V1/KDXaaVocDcmDHSWBnU/Wcj4qASECPxDgz1OqFISoxuxDZoxl1v+
 ZnvSI2yg==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: u-boot@lists.denx.de
Cc: Anthony Loiseau <anthony.loiseau@allcircuits.com>,
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 1/1] MAINTAINERS: fix folders within glob pattern
Date: Fri, 22 Dec 2023 16:44:08 +0100
Message-Id: <20231222154408.21519-2-anthony@loiseau.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231222154408.21519-1-anthony@loiseau.fr>
References: <20231222154408.21519-1-anthony@loiseau.fr>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - sucre.o2switch.net
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - loiseau.fr
X-Get-Message-Sender-Via: sucre.o2switch.net: authenticated_id:
 anthony@loiseau.fr
X-Authenticated-Sender: sucre.o2switch.net: anthony@loiseau.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

From: Anthony Loiseau <anthony.loiseau@allcircuits.com>

A "F: foo*" entry does not match any foo*/ folder nor its subtree,
another "F: foo*/" entry is needed for that.

Add missing foo*/ entries where an existing folder was ignored,
so this folder and its subtree is properly covered.

Arm tegra, Arm TI and Environment sections are affected.

Cc: Tom Rini <trini@konsulko.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 969514468c..8c57d142d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -675,6 +675,7 @@ F:	arch/arm/dts/tegra*
 F:	arch/arm/include/asm/arch-tegra*/
 F:	arch/arm/mach-tegra/
 F:	drivers/*/tegra*
+F:	drivers/*/tegra*/
 
 ARM TI
 M:	Tom Rini <trini@konsulko.com>
@@ -690,6 +691,7 @@ F:	arch/arm/include/asm/arch-omap*/
 F:	arch/arm/include/asm/ti-common/
 F:	board/ti/
 F:	drivers/dma/ti*
+F:	drivers/dma/ti*/
 F:	drivers/firmware/ti_sci.*
 F:	drivers/gpio/omap_gpio.c
 F:	drivers/memory/ti-aemif.c
@@ -701,6 +703,7 @@ F:	drivers/phy/omap-usb2-phy.c
 F:	drivers/phy/phy-ti-am654.c
 F:	drivers/phy/ti-pipe3-phy.c
 F:	drivers/ram/k3*
+F:	drivers/ram/k3*/
 F:	drivers/remoteproc/ipu_rproc.c
 F:	drivers/remoteproc/k3_system_controller.c
 F:	drivers/remoteproc/pruc_rpoc.c
@@ -1029,8 +1032,10 @@ ENVIRONMENT
 M:	Joe Hershberger <joe.hershberger@ni.com>
 S:	Maintained
 F:	env/
+F:	include/env/
 F:	include/env*
 F:	test/env/
+F:	tools/env/
 F:	tools/env*
 F:	tools/mkenvimage.c
 
-- 
2.11.0

