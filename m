Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72582EB8FB6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F46E86977;
	Wed,  6 Sep 2023 14:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RXDqRQR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FA47865A0; Wed,  6 Sep 2023 14:00:21 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3B586682
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0B49F3F6E9; 
 Wed,  6 Sep 2023 12:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694001616;
 bh=6gdseB9FUsLJav6NYmiTFWpBFIBSm80fgP+OqZFhVJ0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=RXDqRQR6GWyRXjIPI2mABqckhuqP5LY3ximf35WvCh/BzJTRVIemDWCD42eUgJgo/
 NA8/R3mzyzBf3ksZEd9LgdQrSwke0zaJP27uGxyGsv3+IFYextEsuSEX/bn1c95KT9
 xfVIibXa2eRj18JeirFOeM2qN5cI06P3P+1kXjzfSY3gbRsAKnI8idMyUUN5LVEiGv
 DUe8iMdnOFYI0h0NJZQqWeabS1S1csScICaRuV6X6fBXaefPFBAqT+M6VCTtIys1p5
 iVXgNRkbY47kM1gYRpaiw4+jZXB+PBiK5bVbH4AO93vxoT+I3Dg1W1OdTDPzm4JjM6
 H8dqB8jcZ9Glg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
Date: Wed,  6 Sep 2023 14:00:08 +0200
Message-Id: <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
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
Tested-by: Chanho Park <chanho61.park@samsung.com>
---
v2:
	Fix a typo in a comment in tools/sfspl.c
	Add Tested-by credit
---
 .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
 doc/board/starfive/visionfive2.rst                 | 14 ++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
index 13f69da31e..defe2b605f 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
@@ -103,4 +103,14 @@
 			};
 		};
 	};
+	u-boot-spl {
+		filename = "spl/u-boot-spl.bin.normal.out";
+
+		mkimage {
+			args = "-T sfspl";
+			blob {
+				filename = "spl/u-boot-spl.bin";
+			};
+		};
+	};
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

