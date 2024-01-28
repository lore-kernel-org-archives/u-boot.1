Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4150C47DA9
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 15:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66DC687E48;
	Sun, 28 Jan 2024 16:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U6mYUonR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DADD87F07; Sun, 28 Jan 2024 16:55:56 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95CB87DED
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 16:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNGHW71vGz9sj8;
 Sun, 28 Jan 2024 16:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706457352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrSSdOSuEcpibwZL5SZV/hql5ZO1SF7mB2lweLwouL8=;
 b=U6mYUonRT3whDm6Zq6P/rUVgOECECL2DD7OKSbD0+3bspqOR5Eqsb7B22yVOjo9RqPYQ+k
 xnkXO5waBRZpto2XblIKePumyC6HPluRANlPj7ooU0P3pUAQpKBIJFpXBGpFHsZ+9mEfDt
 PLX6nMVT8kW1L+NiiSpl0EugUp1f3x7I+0ETIZ6XIfDMF5E63UXJ98tkPowxAAKw7kGS2o
 DW2M0lho1RF17oa3RvTz6+/SEnJiSfNIFF2e/NRruoRai10mmgKiSzNQcVK3YrKCA+kcGj
 YRVZ+56hM68FESH3n14jVg5yO94EeVsPGyg6pDrWoMQlEnw933mjSfb5clHQWg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 06/11] ARM: renesas: Add R8A779H0 V4M Kconfig entry and PRR
 ID
Date: Sun, 28 Jan 2024 16:52:04 +0100
Message-ID: <20240128155458.56712-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 627497d7f1adf7c23b3
X-MBO-RS-META: h5us8o48g1b6z8ahwytuuwqty11c9kij
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

From: Hai Pham <hai.pham.ud@renesas.com>

Add Kconfig entry and PRR ID to support R8A779H0 V4M SoC.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
V2: - Move the patch before PRR ID patch to satisfy macro dependency
    - Add RB from Paul
---
 arch/arm/mach-rmobile/Kconfig.rcar4          | 6 ++++++
 arch/arm/mach-rmobile/cpu_info.c             | 1 +
 arch/arm/mach-rmobile/include/mach/rmobile.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-rmobile/Kconfig.rcar4 b/arch/arm/mach-rmobile/Kconfig.rcar4
index d4f93c89cac..3c8d683974c 100644
--- a/arch/arm/mach-rmobile/Kconfig.rcar4
+++ b/arch/arm/mach-rmobile/Kconfig.rcar4
@@ -20,6 +20,12 @@ config R8A779G0
 	imply CLK_R8A779G0
 	imply PINCTRL_PFC_R8A779G0
 
+config R8A779H0
+	bool "Renesas SoC R8A779H0"
+	select GICV3
+	imply CLK_R8A779H0
+	imply PINCTRL_PFC_R8A779H0
+
 endmenu
 
 choice
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 895c0f5336b..3d5d5ba79a9 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -78,6 +78,7 @@ static const struct {
 	{ RMOBILE_CPU_TYPE_R8A779A0, "R8A779A0" },
 	{ RMOBILE_CPU_TYPE_R8A779F0, "R8A779F0" },
 	{ RMOBILE_CPU_TYPE_R8A779G0, "R8A779G0" },
+	{ RMOBILE_CPU_TYPE_R8A779H0, "R8A779H0" },
 	{ 0x0, "CPU" },
 };
 
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index 88b8b78671b..f0216210ba9 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -43,6 +43,7 @@
 #define RMOBILE_CPU_TYPE_R8A779A0	0x59
 #define RMOBILE_CPU_TYPE_R8A779F0	0x5A
 #define RMOBILE_CPU_TYPE_R8A779G0	0x5C
+#define RMOBILE_CPU_TYPE_R8A779H0	0x5D
 #define RMOBILE_CPU_TYPE_R9A07G044L	0x9A070440
 
 #ifndef __ASSEMBLY__
-- 
2.43.0

