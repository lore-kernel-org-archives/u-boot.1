Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0EECD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 11:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 792948656E;
	Sun, 17 Sep 2023 13:47:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fdQR6kS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A088656E; Sun, 17 Sep 2023 13:47:58 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193638642D
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 13:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 49E563F97B; 
 Sun, 17 Sep 2023 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694951274;
 bh=ZBSEqR74MFgL3Kl0S3KeLFBtVfhcnSR67Uh4p3YIXW0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=fdQR6kS4nIbYyqyLvNc/b14pSafZNzCiezHrK4H8dr6YhWc1MblN4u2DzWa0/CTNu
 eI99xEym+d1E4phVG64Y5sx5jGxBm2qFDZ23R/L7cVKpElTvkd5D7Y/lctim1eV6ya
 u7mk8Sw3saIY2K0cseAXOOeoV5B19XbFajTpCWHiIC5PAO4orpPrv3BF4XPi99Vz2b
 P0Y2dZ5fY3/K3gECp/IaUk+lmX448Pv4cdW64cm4CV34vQXNzqB7yhsoK+G9mDTijd
 X+4I5vYcodwHlaJ+TMOgL2lL5NPc6jMB9CtNSQ031G+H0rhW+gJ8KmFMCCSQqQ5347
 9srcquZUUcoig==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
Date: Sun, 17 Sep 2023 13:47:31 +0200
Message-Id: <20230917114731.23695-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230917114731.23695-1-heinrich.schuchardt@canonical.com>
References: <20230917114731.23695-1-heinrich.schuchardt@canonical.com>
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

The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
prefixed header. We have referring to a vendor tool (spl_tool) for this
task. 'mkimage -T sfspl' can generate the prefixed file.

Use binman to invoke mkimage for the generation of file
spl/u-boot-spl.bin.normal.out.

Update the documentation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	Rename binman node for SPL image.
	Use u-boot-spl instead of blob as mkimage subnode.
v2:
	Fix a typo in a comment in tools/sfspl.c
	Add Tested-by credits
---
 .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 11 +++++++++++
 doc/board/starfive/visionfive2.rst                 | 14 ++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
index 13f69da31e..55185314dd 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
@@ -103,4 +103,15 @@
 			};
 		};
 	};
+
+	spl-img {
+		filename = "spl/u-boot-spl.bin.normal.out";
+
+		mkimage {
+			args = "-T sfspl";
+
+			u-boot-spl {
+			};
+	};
+};
 };
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 941899a0a4..f5575ab68b 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
 	make starfive_visionfive2_defconfig
 	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
 
-This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
-
-u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
-to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
-the below command:
-
-	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
-
-More detailed description of spl_tool,please refer spl_tool documenation.
-(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
-
-This will generate u-boot-spl.bin.normal.out file.
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
 Flashing
 ~~~~~~~~
-- 
2.40.1

