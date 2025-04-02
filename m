Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A296BC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 05:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B7781E6C;
	Wed,  2 Apr 2025 07:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F51817C4; Wed,  2 Apr 2025 07:39:15 +0200 (CEST)
Received: from inet11.abb.com (inet11.abb.com [138.225.1.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294CF8035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 07:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
Received: from brsmtp01.br-automation.co.at ([10.43.60.20])
 by inet11.abb.com (8.15.2/8.14.7) with ESMTPS id 5325d4xk3445465
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Apr 2025 07:39:04 +0200
Received: from extmail.br-automation.com ([192.168.112.26])
 by brsmtp01.br-automation.co.at (HCL Domino Release 14.0FP3 HF8)
 with ESMTP id 2025040207390513-82129 ;
 Wed, 2 Apr 2025 07:39:05 +0200 
Received: from ATEGGE3725.br-automation.co.at ([10.43.64.28])
 by extmail.br-automation.com (HCL Domino Build V1202_05192022)
 with ESMTP id 2025040207390536-28500 ;
 Wed, 2 Apr 2025 07:39:05 +0200 
From: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>
To: u-boot@lists.denx.de
Cc: "Bernhard Messerklinger" <bernhard.messerklinger@br-automation.com>,
 "Tom Rini" <trini@konsulko.com>,
 "Wolfgang Wallner" <wolfgang.wallner@br-automation.com>
Subject: [PATCH v3 2/4] board/BuR/common: add parameter for reset controller
 I2C bus selection
Date: Wed, 2 Apr 2025 07:38:33 +0200
Message-ID: <20250402053901.8149-3-bernhard.messerklinger@br-automation.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
References: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BRSMTPINTERN2/InternSMTP(Build
 V1202_05192022|May 19, 2022) at 04/02/2025 07:39:05 AM,
 Serialize by Router on BRSMTPINTERN2/InternSMTP(Build V1202_05192022|May 19,
 2022) at 04/02/2025 07:39:05 AM,
 Itemize by SMTP Server on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3
 HF8|December 13, 2024) at 04/02/2025 07:39:05 AM,
 Serialize by Router on BRSMTP01/Eggelsberg/AT/B&R(Release 14.0FP3 HF8|December
 13, 2024) at 04/02/2025 07:39:05 AM,
 Serialize complete at 04/02/2025 07:39:05 AM
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
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

Normally B&R reset controllers are located at I2C bus 0. This patch adds
the possibility to change this bus number with the kconfig option
BR=5FRESETC=5FI2CBUS.

Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation=
.com>
---

(no changes since v2)

Changes in v2:
- Move BR=5FRESETC=5FI2CBUS to Kconfig

 board/BuR/common/Kconfig     |  8 ++++++++
 board/BuR/common/br=5Fresetc.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 board/BuR/common/Kconfig

diff --git a/board/BuR/common/Kconfig b/board/BuR/common/Kconfig
new file mode 100644
index 00000000000..490201e7407
--- /dev/null
+++ b/board/BuR/common/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# B&R Industrial Automation GmbH - http://www.br-automation.com
+
+config BR=5FRESETC=5FI2CBUS
+	int "I2C Bus address of B&R reset controller"
+	depends on SYS=5FVENDOR =3D "BuR" && DM=5FI2C
+	default 0
diff --git a/board/BuR/common/br=5Fresetc.c b/board/BuR/common/br=5Fresetc.c
index f5d09fef3d3..248064f974b 100644
--- a/board/BuR/common/br=5Fresetc.c
+++ b/board/BuR/common/br=5Fresetc.c
@@ -52,10 +52,16 @@ static int resetc=5Finit(void)
 {
 	struct udevice *i2cbus;
 	int rc;
+#if !defined(BR=5FRESETC=5FI2CBUS)
+	int busno =3D 0;
+#else
+	int busno =3D CONFIG=5FBR=5FRESETC=5FI2CBUS;
+#endif
+
+	rc =3D uclass=5Fget=5Fdevice=5Fby=5Fseq(UCLASS=5FI2C, busno, &i2cbus);
=20
-	rc =3D uclass=5Fget=5Fdevice=5Fby=5Fseq(UCLASS=5FI2C, 0, &i2cbus);
 	if (rc) {
-		printf("Cannot find I2C bus #0!\n");
+		printf("Cannot find I2C bus #%d!\n", busno);
 		return -1;
 	}
=20
--=20
2.49.0

