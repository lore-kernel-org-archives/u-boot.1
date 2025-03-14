Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA491C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4605D81FDE;
	Fri, 14 Mar 2025 21:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="AgQY80AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E7E81E92; Fri, 14 Mar 2025 21:09:12 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F6581E92
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id CF00CC026F;
 Fri, 14 Mar 2025 21:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741982949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WP724tOTX6Ghgn4M1J+ElrtHrmjnPJu7F90tpO45DhI=;
 b=AgQY80ABFDH/Ven96SQA53w6NL6MtVj005WLXoVBnSSFdhSu3IXMJYetIS4MpzzhN/1u80
 RytXtUSYua/a0srxzPRcrybUt1gpBBuz8FJzcUgDrFIns9CxSdnSoYR66EEhkejXB4x0sE
 v8RVQlzk4mXtLewVULiQIy226F9u4mHQ7+tiHley7RcM/rTl230QVHdqyF27zWgJuNTLWx
 dtsgbJW3lIztjQCmM1AOIUrhQPOvyeS5NJik3qvRd1dar/h41wIX5x2avRaqtQ2wNKYiDO
 xUX2n62iXtq7jBX07aI7Fv3rWzw4eADuc8rbRn2SAaZVgzxmrXNCbDW0oXXCPQ==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id 7331320032D;
 Fri, 14 Mar 2025 21:09:09 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: Hendrik Donner <hd@os-cillation.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] imx8qm: Do not use CONFIG_XPL_BUILD in device tree
Date: Fri, 14 Mar 2025 21:08:32 +0100
Message-ID: <20250314200832.154758-3-hd@os-cillation.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314200832.154758-1-hd@os-cillation.de>
References: <2849ff05-ef67-4471-aece-422daa57040f@cherry.de>
 <20250314200832.154758-1-hd@os-cillation.de>
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

In c9713c15512 the device tree was moved
from CONFIG_SPL to CONFIG_SPL_BUILD and later to CONFIG_XPL_BUILD, but
the CONFIG_xPL_BUILD defines are never set for device trees, breaking
the build. Move the guards back to CONFIG_SPL.

Also add a missing guard analog to 645a42d7ee8 to fix a similar build
issue.

Fixes: c9713c15512 ("imx8-u-boot: Fix SPL guard option")
Signed-off-by: Hendrik Donner <hd@os-cillation.de>
---
 arch/arm/dts/imx8qm-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot.dtsi
index af229501a4d..8492b3f4c78 100644
--- a/arch/arm/dts/imx8qm-u-boot.dtsi
+++ b/arch/arm/dts/imx8qm-u-boot.dtsi
@@ -10,7 +10,7 @@
 };
 
 &binman {
-#ifdef CONFIG_XPL_BUILD
+#ifdef CONFIG_SPL
 	u-boot-spl-ddr {
 		align = <4>;
 		align-size = <4>;
@@ -122,6 +122,7 @@
 		};
 	};
 
+#ifdef CONFIG_SPL
 	imx-boot {
 		filename = "flash.bin";
 		pad-byte = <0x00>;
@@ -132,4 +133,5 @@
 			type = "blob-ext";
 		};
 	};
+#endif
 };
-- 
2.43.0

