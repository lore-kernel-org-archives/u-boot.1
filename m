Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1DFC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B99687ABC;
	Thu, 14 Dec 2023 17:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4823087ACC; Thu, 14 Dec 2023 17:25:52 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A774987AB9
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1rDoWw-00BWP7-SQ; Thu, 14 Dec 2023 16:25:46 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
Date: Thu, 14 Dec 2023 08:25:43 -0800
Message-Id: <20231214162543.1200276-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214162543.1200276-1-tharvey@gateworks.com>
References: <20231214162543.1200276-1-tharvey@gateworks.com>
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

Prepare for DEK blob encapsulation support through "dek_blob" command.
On ARMv8, u-boot runs in non-secure, thus cannot encapsulate a DEK blob
for encrypted boot.

The DEK blob is encapsulated by OP-TEE through a trusted application
call. U-boot sends and receives the DEK and the DEK blob binaries
through OP-TEE dynamic shared memory.

To enable the DEK blob encapsulation, add to the defconfig:
CONFIG_SECURE_BOOT=y
CONFIG_FAT_WRITE=y
CONFIG_CMD_DEKBLOB=y

Taken from NXP's commit 56d2050f4028 ("imx8m: Add DEK blob encapsulation for imx8m").

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mm-venice-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/imx8mm-venice-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-u-boot.dtsi
index 8337c4aea807..b232002b8937 100644
--- a/arch/arm/dts/imx8mm-venice-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-venice-u-boot.dtsi
@@ -11,6 +11,13 @@
 		wdt = <&wdog1>;
 		bootph-pre-ram;
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
 };
 
 &gpio1 {
-- 
2.25.1

