Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4273C47DB7
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 17:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEFA8785C;
	Sun, 21 Jan 2024 18:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="u3faGX19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99568774B; Sun, 21 Jan 2024 18:44:06 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C388777F
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
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJ11Z68Xhz9scL;
 Sun, 21 Jan 2024 18:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705859042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VI/HaJxdEWeroJf2kjBTDCiH4gwNC2iOgZWTX0EdlVk=;
 b=u3faGX19J+X3OxywsoxSKUGKO50oSMc2tuJzsOhMj6MgCqjn84Vm3rMHRWFhgRlShrhKSX
 1lMpf5XnlafIEC57tFvB2aJEbV3++IFzqymNiBIoBBZVHLaCnp7lBb5yMRhZf28Ry2Ma6n
 Xi/SK8xn/1X3pEx69MnoHKCPVwRebmtZn8dRzKOZiWmFM0rZEYCr9Mxu/U7HdbXrUWkXy1
 cVXDpi+r+WuL+6dxSEW78ic03wkihUAsaoMk0zLascC+1OaEbcj+TcR2uJPkeks+4CpDIk
 LDsRvva1HUxD3u6LufHbGmbiXn73Ytf+x5QZnXpTsA7/A8dUnYew37Fl/MKqsA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 02/11] dt-bindings: clock: Add R8A779H0 V4M CPG Core Clock
 Definitions
Date: Sun, 21 Jan 2024 18:41:05 +0100
Message-ID: <20240121174340.279465-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8b9ff457ddb034e5e78
X-MBO-RS-META: h6nytfoq7fq9qfawmo6umasbw5dd6k14
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

Add all Clock Pulse Generator Core Clock Outputs for the Renesas R-Car
V4M (R8A779H0) SoC.

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 include/dt-bindings/clock/r8a779h0-cpg-mssr.h | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a779h0-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a779h0-cpg-mssr.h b/include/dt-bindings/clock/r8a779h0-cpg-mssr.h
new file mode 100644
index 00000000000..d2efd2b8f96
--- /dev/null
+++ b/include/dt-bindings/clock/r8a779h0-cpg-mssr.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* r8a779h0 CPG Core Clocks */
+
+#define R8A779H0_CLK_ZX			0
+#define R8A779H0_CLK_ZD			1
+#define R8A779H0_CLK_ZS			2
+#define R8A779H0_CLK_ZT			3
+#define R8A779H0_CLK_ZTR		4
+#define R8A779H0_CLK_S0D2		5
+#define R8A779H0_CLK_S0D3		6
+#define R8A779H0_CLK_S0D4		7
+#define R8A779H0_CLK_S0D1_VIO		8
+#define R8A779H0_CLK_S0D2_VIO		9
+#define R8A779H0_CLK_S0D4_VIO		10
+#define R8A779H0_CLK_S0D8_VIO		11
+#define R8A779H0_CLK_VIOBUSD1		12
+#define R8A779H0_CLK_VIOBUSD2		13
+#define R8A779H0_CLK_S0D1_VC		14
+#define R8A779H0_CLK_S0D2_VC		15
+#define R8A779H0_CLK_S0D4_VC		16
+#define R8A779H0_CLK_VCBUSD1		17
+#define R8A779H0_CLK_VCBUSD2		18
+#define R8A779H0_CLK_S0D2_MM		19
+#define R8A779H0_CLK_S0D4_MM		20
+#define R8A779H0_CLK_S0D2_U3DG		21
+#define R8A779H0_CLK_S0D4_U3DG		22
+#define R8A779H0_CLK_S0D2_RT		23
+#define R8A779H0_CLK_S0D3_RT		24
+#define R8A779H0_CLK_S0D4_RT		25
+#define R8A779H0_CLK_S0D6_RT		26
+#define R8A779H0_CLK_S0D2_PER		27
+#define R8A779H0_CLK_S0D3_PER		28
+#define R8A779H0_CLK_S0D4_PER		29
+#define R8A779H0_CLK_S0D6_PER		30
+#define R8A779H0_CLK_S0D12_PER		31
+#define R8A779H0_CLK_S0D24_PER		32
+#define R8A779H0_CLK_S0D1_HSC		33
+#define R8A779H0_CLK_S0D2_HSC		34
+#define R8A779H0_CLK_S0D4_HSC		35
+#define R8A779H0_CLK_S0D8_HSC		36
+#define R8A779H0_CLK_SVD1_IR		37
+#define R8A779H0_CLK_SVD2_IR		38
+#define R8A779H0_CLK_IMPAD1		39
+#define R8A779H0_CLK_IMPAD4		40
+#define R8A779H0_CLK_IMPB		41
+#define R8A779H0_CLK_SVD1_VIP		42
+#define R8A779H0_CLK_SVD2_VIP		43
+#define R8A779H0_CLK_CL			44
+#define R8A779H0_CLK_CL16M		45
+#define R8A779H0_CLK_CL16M_MM		46
+#define R8A779H0_CLK_CL16M_RT		47
+#define R8A779H0_CLK_CL16M_PER		48
+#define R8A779H0_CLK_CL16M_HSC		49
+#define R8A779H0_CLK_ZC0		50
+#define R8A779H0_CLK_ZC1		51
+#define R8A779H0_CLK_ZC2		52
+#define R8A779H0_CLK_ZC3		53
+#define R8A779H0_CLK_ZB3		54
+#define R8A779H0_CLK_ZB3D2		55
+#define R8A779H0_CLK_ZB3D4		56
+#define R8A779H0_CLK_ZG			57
+#define R8A779H0_CLK_SD0H		58
+#define R8A779H0_CLK_SD0		59
+#define R8A779H0_CLK_RPC		60
+#define R8A779H0_CLK_RPCD2		61
+#define R8A779H0_CLK_MSO		62
+#define R8A779H0_CLK_CANFD		63
+#define R8A779H0_CLK_CSI		64
+#define R8A779H0_CLK_FRAY		65
+#define R8A779H0_CLK_IPC		66
+#define R8A779H0_CLK_POST2		67
+#define R8A779H0_CLK_POST3		68
+#define R8A779H0_CLK_POST4		69
+#define R8A779H0_CLK_POST		70
+#define R8A779H0_CLK_SASYNCRT		71
+#define R8A779H0_CLK_SASYNCPERD1	72
+#define R8A779H0_CLK_SASYNCPERD2	73
+#define R8A779H0_CLK_SASYNCPERD4	74
+#define R8A779H0_CLK_DSIEXT		75
+#define R8A779H0_CLK_DSIREF		76
+#define R8A779H0_CLK_ADGH		77
+#define R8A779H0_CLK_OSC		78
+#define R8A779H0_CLK_ZR0		79
+#define R8A779H0_CLK_ZR1		80
+#define R8A779H0_CLK_ZR2		81
+#define R8A779H0_CLK_RGMII		82
+#define R8A779H0_CLK_CPEX		83
+#define R8A779H0_CLK_CP			84
+#define R8A779H0_CLK_CBFUSA		85
+#define R8A779H0_CLK_R			86
+
+#endif /* __DT_BINDINGS_CLOCK_R8A779H0_CPG_MSSR_H__ */
-- 
2.43.0

