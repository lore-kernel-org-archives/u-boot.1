Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3BDC47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D0E8786B;
	Sun, 21 Jan 2024 18:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CSCy/Bx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AF98786B; Sun, 21 Jan 2024 18:44:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1BC876B1
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 18:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJ11Z12m5z9sX2;
 Sun, 21 Jan 2024 18:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705859042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xbk8Yi5kz+1t3osES9mjCp5C9klXnAmCDYhtM1/JlcM=;
 b=CSCy/Bx7m1+00vMfQgIl1AtZMVoU+gMAsXJCU6g374aP7EJn+n6hOTpDIHlAdDj1SRpzfg
 RC/RBxJ5nsMgJq/1FIfCdl2COttvqjFucFg5kX+f1FDPO7cfx8E+i2NXS0EC06HmvE8KQW
 PXli+F/xGUVpa/xIBp3bR9aZhYiO41ppBtRZZAbijhGbiY2yyuB0bDgl+uf/cppYdPOxgB
 KiSAXdDrY+C54E7jtCFmRGYkJHe8pYdJ8QWp9nRDHUnCUU/pbDTZhdSQHoiCxBvrYmRAoH
 NeSoV2vrAKxqUmt5nxp9G+cRQbUJkUsZcE4OdcPSP1dtOwUoVlGJS55lmd++4A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 01/11] dt-bindings: power: Add R8A779H0 V4M SYSC power domain
 definitions
Date: Sun, 21 Jan 2024 18:41:04 +0100
Message-ID: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4e83d752b479f3cf283
X-MBO-RS-META: wc8sy46zaq345emom9apkxka8ae6w3sb
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

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

Add power domain indices for R-Car V4M (R8A779H0).

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 include/dt-bindings/power/r8a779h0-sysc.h | 49 +++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a779h0-sysc.h

diff --git a/include/dt-bindings/power/r8a779h0-sysc.h b/include/dt-bindings/power/r8a779h0-sysc.h
new file mode 100644
index 00000000000..29f05f0401a
--- /dev/null
+++ b/include/dt-bindings/power/r8a779h0-sysc.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A779H0_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A779H0_SYSC_H__
+
+/*
+ * These power domain indices match the Power Domain Register Numbers (PDR)
+ */
+
+#define R8A779H0_PD_A1E0D0C0		0
+#define R8A779H0_PD_A1E0D0C1		1
+#define R8A779H0_PD_A1E0D0C2		2
+#define R8A779H0_PD_A1E0D0C3		3
+#define R8A779H0_PD_A2E0D0		16
+#define R8A779H0_PD_A3CR0		21
+#define R8A779H0_PD_A3CR1		22
+#define R8A779H0_PD_A3CR2		23
+#define R8A779H0_PD_A33DGA		24
+#define R8A779H0_PD_A23DGB		25
+#define R8A779H0_PD_C4			31
+#define R8A779H0_PD_A1DSP0		33
+#define R8A779H0_PD_A2IMP01		34
+#define R8A779H0_PD_A2PSC		35
+#define R8A779H0_PD_A2CV0		36
+#define R8A779H0_PD_A2CV1		37
+#define R8A779H0_PD_A3IMR0		38
+#define R8A779H0_PD_A3IMR1		39
+#define R8A779H0_PD_A3VC		40
+#define R8A779H0_PD_A2CN0		42
+#define R8A779H0_PD_A1CN0		44
+#define R8A779H0_PD_A1DSP1		45
+#define R8A779H0_PD_A2DMA		47
+#define R8A779H0_PD_A2CV2		48
+#define R8A779H0_PD_A2CV3		49
+#define R8A779H0_PD_A3IMR2		50
+#define R8A779H0_PD_A3IMR3		51
+#define R8A779H0_PD_A3PCI		52
+#define R8A779H0_PD_A2PCIPHY		53
+#define R8A779H0_PD_A3VIP0		56
+#define R8A779H0_PD_A3VIP2		58
+#define R8A779H0_PD_A3ISP0		60
+#define R8A779H0_PD_A3DUL		62
+
+/* Always-on power area */
+#define R8A779H0_PD_ALWAYS_ON		64
+
+#endif /* __DT_BINDINGS_POWER_R8A779H0_SYSC_H__ */
-- 
2.43.0

