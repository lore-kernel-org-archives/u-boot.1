Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5169C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE84830F4;
	Mon,  7 Apr 2025 22:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bamM4zVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A02830E5; Mon,  7 Apr 2025 22:02:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43125830AF
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so4260411f8f.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056159; x=1744660959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjYFk1rITbC53hgO74cOixGOld1i5av2OAHTIphe74U=;
 b=bamM4zVAvUK3EHq3HqvrxNR8ffwchvLJyhzz2SDiQgkvky9yWV8bSNA9+G9Qqo1XFk
 6EJ4newIRK+K4zWO+baaUndlYL2WJ3Pn1pmCs4vpVJS7ZFSo0W/yEan/1/SQY+i7kNlF
 uBa+PHi5VN9ENp1/b92KENt+FkBUZTv4nVKMrhcNdCyKyVAxq1ubni1FPeJraOeFll7u
 iM6pz3gOtHPMDuLYyVW99539ENk3OCjK3QKdpLJB9wTY9PHuoFPWnQCZLbZwwKg5otzE
 6Dausq5uM/O06AOy/M0ELzMlLqYaIC6MsKGBzbMINPlJc9tojf3WQKUNA3GSM/dwsxP3
 BTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056159; x=1744660959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjYFk1rITbC53hgO74cOixGOld1i5av2OAHTIphe74U=;
 b=eL2HLRxmOrVoRv0l1OV2dFIDnmN3BBmh4E2yPWSmHlifBWb9NTUmGwe5a/sATTunZo
 Kko1wqNLC9loRRG20bm8HLI5Hk2zF9g3RM3XlYkPvB3Hjxwff3lgey4OBbkry/+1FM7n
 9PY4QIpjsmWQ9QYNC4M9sWyRJoaBjY8GAfkXPtBSlxeU0YyJ5mzfBFBfNn+mKJwKCwZr
 Q5jX/LpiDAKR2Zk146VrwMWvhv0UwOakT1Eekt+M4cLbJAhH9BSvTtOaix0lT2rQhQoK
 B4H6TIl9XoLWWJ+dU97NKb7aZhjZGb0/u46RfBCdAIJs9Naw3oGsWwWWwMXjwgywMf5b
 9/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRkGwx51NCVcBuCimOFp463Edc8iVF8Ukt35XakTRaM4DHWruGyq9g7qArHKI8d85s1imMN7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwGpA/FwrPynCf0WiR6xNbBqyYrhbQI3KDyKy9hh99x/D4uFyiD
 LSAJ8HnwuQqmVHukbpg2XpR6JgvBzZMvAaqNCqbyeGrzlesIxU5d
X-Gm-Gg: ASbGnct1vYiK6q/bNJ6Nwv8f41VK9kUPEeeprj80Mk31XfKtOQRSGs9cy2jvQzhXqvs
 5wisAgOSsdeBpmemkkY/wAIU24+OEBHCkmq9CSNXjMh5l3s6j/SgOgpKB/FlHjNBMvYr9MoUA5W
 irF2IVwS1gQGta081E7nH3Zo1y6/5isDZjBAIbtnKAXXHsWL/4WeV1kcYfg7oRNExiIRgbl01/X
 pltiaU5snBTLL/nnyFEtNjcjIXlwrdea7CuH6QZ+Ua5ddtiWsD9v4MNAFKcXluHuqjjuTHrqdTJ
 jHrcKDLSHeSFKd50TDu4iuHm0N5ubaSfCAwUDUfY9h3IMftCRhrn3bYdRmCtlATaSBOoLxI6bPG
 +zk5oI7YQfJkbDw==
X-Google-Smtp-Source: AGHT+IF13ExvTDfbjfEuVJaFQ3QCTKEp0qu5Cgt+4W91lvolq2lSADKJ8enzoXAjVDfcR4qggaZevQ==
X-Received: by 2002:adf:b60a:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-39d0de2ece2mr9552106f8f.34.1744056158668; 
 Mon, 07 Apr 2025 13:02:38 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 04/14] arch: arm: dts: an7581: Add Ethernet nodes
Date: Mon,  7 Apr 2025 22:01:48 +0200
Message-ID: <20250407200208.25594-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

Add Ethrnet nodes for Airoha AN7581 EVB board.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 9f8abfc3bcf..a569044195d 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <dt-bindings/reset/airoha,en7581-reset.h>
+
 / {
 	reserved-memory {
 		#address-cells = <2>;
@@ -17,9 +19,37 @@
 			compatible = "airoha,en7581-chip-scu", "syscon";
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
+
+		eth: ethernet@1fb50000 {
+			compatible = "airoha,en7581-eth";
+			reg = <0 0x1fb50000 0 0x2600>,
+				<0 0x1fb54000 0 0x2000>,
+				<0 0x1fb56000 0 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk EN7581_FE_RST>,
+				 <&scuclk EN7581_FE_PDMA_RST>,
+				 <&scuclk EN7581_FE_QDMA_RST>,
+				 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
+				 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
+				 <&scuclk EN7581_HSI_MAC_RST>,
+				 <&scuclk EN7581_XFP_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma",
+				      "hsi0-mac", "hsi1-mac", "hsi-mac",
+				      "xfp-mac";
+		};
+
+		switch: switch@1fb58000 {
+			compatible = "airoha,en7581-switch";
+			reg = <0 0x1fb58000 0 0x8000>;
+		};
 	};
 };
 
+&scuclk {
+	compatible = "airoha,en7581-scu", "syscon";
+};
+
 &uart1 {
 	bootph-all;
 };
-- 
2.48.1

