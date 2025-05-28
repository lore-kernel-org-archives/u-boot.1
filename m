Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21CEC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 09:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4550C831EA;
	Wed, 28 May 2025 11:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kVCbKZ9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83C48391A; Wed, 28 May 2025 11:05:52 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A0D831E4
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 11:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6046ecc3e43so5217162a12.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748423149; x=1749027949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxrPWH6I2A25CUw4GaCE96NwZq+9ltrzxdXxfEYR43Q=;
 b=kVCbKZ9jh/fzb4kMw/zWLqFlL+QP4Nz+yuROg9st3SSMmmtKP3Slva4aAeq6A4H1Ka
 aUjdBeJxk665N4QP8dC9vxjUoMJvIOM4QypX2VzrAWGEPaNmDgDsaQhBTguFVhjwl4RN
 JCXuaFGFqIswc98if6PpPqD5qrfdZZ4DCv6GxoGN9P/Sq6+N3sZLPD7vEqvV1FA40c/g
 q1VI+4WvNVfkieEwz5bi0qzZ96AdtKzZEnrMQqKEWdNqvdBnFa01Wr5uMGxgNyXO3tWr
 mlVa0KWzrdHMhTCW+r8uKeOB7SJFPJ5w51X5FQ9lJuM7IzH3/iLCmGe3iwnZ0Z/e+LOW
 YHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748423149; x=1749027949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxrPWH6I2A25CUw4GaCE96NwZq+9ltrzxdXxfEYR43Q=;
 b=TgdJhdKLdfGiBreYwlnGF1DpefCNUgRKLyXY70s6OnuF8KVtUD42rs/S/yVoaiAe7W
 PTPOvDkRgBfblz4PUjdwCQ6w41YMRB5o/Ck4Tom4it2FAUVBMrbvE8wIABdJFBI/iGNQ
 W8rr4ulmwyz/5OLQ+LTwYwae0Lvygy/iXJtUcHqdqbrQoxydPfieghewjNcxQr+Lyb2h
 moCR/jh0hVJGe8U0Qdd6aR/jn4BQTxtRTkmlAkFgmI9Emas5So+3JqZH2Hl1NparHVkj
 siAc1U4AJTyXtSCol5iLW0DPiIwsbhZLxw0E4zJ9qiiL+4vPUyoZhma3yiHfMPGEMiIH
 nt6w==
X-Gm-Message-State: AOJu0YxFciWPgD4sLXPhBYW9oHM4Bw/UCT1ZGvFHCKVvl81uv9hBEf4o
 abMXkbcwSLmemP7D3cXKl5i4LTWH0D56H8o96wgjML20k0hAIewmOXSEpJ38Lg==
X-Gm-Gg: ASbGnct16hGKTJTie4nVGHV/HXaRIgnAwZluJ97FbrMIhXyiTU00TGh0Y/vUSi0sXPn
 wxDWGcLkQ52DwwNX9KVUPPVaMZJDDVYlamVorJ4EjF1hdhW1DTY8QXdekt4Cpnd8XKWqXzZhb0k
 1+pTdi5jbLrm+J5cMRnc/x3rpnxFZ/MX/8maDxAqfTmTt70k4bmOiLLGz7Yxzm1BYVOQ81MZ41V
 w6LSfHD9DBVw6J8+iBL8rlFA2wCQH346TVBZFS4cLyajjR5Zj32DG/nA6rs7upv/e9ZBHjEAI7j
 qkx7v9c0uPfGYUyrU264a0NF8wencBPVgBJYSGHIElO6Ax5v3c0+Vm/a3WCy0QwaxWZ+B0wlOmP
 Cs1U=
X-Google-Smtp-Source: AGHT+IGQwlAmeu0JAPjMhe/cAlQvlj0Zbf7WREqL1PMAqGu9DyfDcZhYDtn6+bP6Iovo1eUy1s0spg==
X-Received: by 2002:a05:6402:430a:b0:602:1061:5ebb with SMTP id
 4fb4d7f45d1cf-6051c50934bmr1266443a12.32.1748423149134; 
 Wed, 28 May 2025 02:05:49 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6051d5f80dfsm486990a12.30.2025.05.28.02.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 02:05:48 -0700 (PDT)
From: Heiko Thiery <heiko.thiery@gmail.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Thomas=20Sch=C3=A4fer?= <thomas.schaefer@kontron.com>,
 Michael Walle <mwalle@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH] arm: dts: remove k3-serdes.h
Date: Wed, 28 May 2025 11:05:37 +0200
Message-Id: <20250528090536.765499-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This file is a duplicate and also comes with the sync of the linux
mainline dts files. By removing this the one from the dts folder should
be taken that is more up-to-date.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm/dts/k3-serdes.h | 204 ---------------------------------------
 1 file changed, 204 deletions(-)
 delete mode 100644 arch/arm/dts/k3-serdes.h

diff --git a/arch/arm/dts/k3-serdes.h b/arch/arm/dts/k3-serdes.h
deleted file mode 100644
index 21b4886c47b..00000000000
--- a/arch/arm/dts/k3-serdes.h
+++ /dev/null
@@ -1,204 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for SERDES MUX for TI SoCs
- *
- * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#ifndef DTS_ARM64_TI_K3_SERDES_H
-#define DTS_ARM64_TI_K3_SERDES_H
-
-/* J721E */
-
-#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
-#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
-#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
-#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
-#define J721E_SERDES0_LANE1_USB3_0		0x2
-#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
-#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
-#define J721E_SERDES1_LANE1_USB3_1		0x2
-#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
-#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
-#define J721E_SERDES2_LANE1_USB3_1		0x2
-#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
-#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
-#define J721E_SERDES3_LANE1_USB3_0		0x2
-#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
-#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
-#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
-#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
-#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
-#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
-#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
-#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
-#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
-
-/* J7200 */
-
-#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
-#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
-#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
-#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
-#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
-#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
-#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
-#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
-#define J7200_SERDES0_LANE3_USB			0x2
-#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* AM64 */
-
-#define AM64_SERDES0_LANE0_PCIE0		0x0
-#define AM64_SERDES0_LANE0_USB			0x1
-
-/* J721S2 */
-
-#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
-#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
-#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J721S2_SERDES0_LANE1_USB		0x2
-#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
-#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J721S2_SERDES0_LANE2_USB_SWAP		0x2
-#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
-#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J721S2_SERDES0_LANE3_USB		0x2
-#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* J784S4 */
-
-#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
-#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
-#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J784S4_SERDES0_LANE3_USB		0x2
-#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
-#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
-#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
-#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
-#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
-#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
-#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
-#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
-#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
-#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
-#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
-#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
-#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
-#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
-#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES4_LANE0_EDP_LANE0		0x0
-#define J784S4_SERDES4_LANE0_QSGMII_LANE5	0x1
-#define J784S4_SERDES4_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES4_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES4_LANE1_EDP_LANE1		0x0
-#define J784S4_SERDES4_LANE1_QSGMII_LANE6	0x1
-#define J784S4_SERDES4_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES4_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES4_LANE2_EDP_LANE2		0x0
-#define J784S4_SERDES4_LANE2_QSGMII_LANE7	0x1
-#define J784S4_SERDES4_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES4_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES4_LANE3_EDP_LANE3		0x0
-#define J784S4_SERDES4_LANE3_QSGMII_LANE8	0x1
-#define J784S4_SERDES4_LANE3_USB		0x2
-#define J784S4_SERDES4_LANE3_IP4_UNUSED		0x3
-
-#endif /* DTS_ARM64_TI_K3_SERDES_H */
-- 
2.39.5

