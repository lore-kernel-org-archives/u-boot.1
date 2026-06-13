Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6234CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 03:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B0D839A8;
	Sat, 13 Jun 2026 05:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="E3qDi+KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEA284704; Sat, 13 Jun 2026 05:12:02 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E8A8063E
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 05:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48CB6117C02; Sat, 13 Jun 2026 05:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781320319; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=3DJTlLT6txCFyIBM3CnEN6xxNnOJCroap12O9rkgqtg=;
 b=E3qDi+KIp13lRpjMDaaTVQY68oP53SQjn1tOFbadXjF6nHiHFVs8wkpW8zi1W6WIAW/mWi
 jotSV2v9btxAGh/ytkPYafa2BRt6tWxTTGEFWD0fGB2pCJBXcrHGICuFxjPBx7+qqrGN72
 DBZ55p6m4fDXArVvqrJ8OXtW7R7pDm6CcE9JvqMrPcnM4lcu+i1YPxIXOcspuuNvtUvB5i
 tZWLQhZIrnJBu26KSxeaUZPwSulJ5GP3sA9YKoITthuoeR0KM6BBSSFoFYqacJFiACWIJz
 eGcHbTcW6n5lvMLbuB0M0hMMYnmqROw2GLlNi3wuL9sIQ8k+ymQlP8a42D4ZSw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] imx: fdt: Allow users to inhibit trip point setup
Date: Sat, 13 Jun 2026 05:11:43 +0200
Message-ID: <20260613031157.142115-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

During development or various dangerous experiments, it may
be necessary to override the trip points. Allow users to do
that. However, do keep in mind that this may damage the SoC.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/fdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
index f19ab9edce4..1ef26718463 100644
--- a/arch/arm/mach-imx/fdt.c
+++ b/arch/arm/mach-imx/fdt.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <env.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <malloc.h>
@@ -91,6 +92,15 @@ int fixup_thermal_trips(void *blob, const char *name)
 	int minc, maxc;
 	int node, trip;
 
+	/*
+	 * During development or various dangerous experiments, it may
+	 * be necessary to override the trip points. Allow users to do
+	 * that. However, do keep in mind that this may damage the SoC.
+	 */
+	if (CONFIG_IS_ENABLED(ENV_SUPPORT))
+		if (env_get("imx_skip_fixup_thermal_trips"))
+			return 0;
+
 	node = fdt_path_offset(blob, "/thermal-zones");
 	if (node < 0)
 		return node;
-- 
2.53.0

