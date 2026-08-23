Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11670C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE7D660751;
	Sun, 23 Aug 2026 19:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 65LSyn3aq8QM; Sun, 23 Aug 2026 19:15:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512513;
	bh=N5fUsaWyhFWpV8sFgvVXZ2vTZRRWqCCL/k6g4+8UObc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hg8Y0HDItk6KvmLhYuddeT4NDs94ARvSyCkgcQR0nnNdfWSGc56FBeE97GmHKCx/V
	 6PBXwGqtuwz9UFjauvKO0cHc3FVTKiCxb8rCSGiY7viXsi9nXmOK3E7wWzdF6ak/2i
	 isJnRTnPNmSvoagOt7RsPLRm06on7od9jLPL6KjPT4KAscFtKaWoJJhVQSKcZ/4Es2
	 hAgjlmC6Wn3Bml36Rgn6Vwp3vrw0YkxUFVa8vmf9GwPmzuvJkK1DAtweiytsqNlYsQ
	 Wr35MwyQxzmJpT7Kwefm9QyGZwZatAd02nhhq6BUg4FxnKsiAWG8q7EYXp9z5K7vcD
	 X6KcPCI4zdvIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 423EC6065E;
	Sun, 23 Aug 2026 19:15:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A360242B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8460F40611
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4BR8bzx0e6Kp for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:15:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2322A40575
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:15:10 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wyDei-000000001p7-3Pau; Sun, 23 Aug 2026 19:14:56 +0000
Date: Sun, 23 Aug 2026 20:14:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 7/9] configs: sandbox: enable imagemap and its storage backends
Message-ID: <98c5d0524ec9b1064d218babd5a453548c7c317b.1787272661.git.daniel@makrotopia.org>
References: <cover.1787272661.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787272661.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable CONFIG_IMAGEMAP and, so the end-to-end unit tests can exercise
the real block paths, the storage that feeds them: CONFIG_MTD_BLOCK
and CONFIG_SPI_FLASH_MTD (a bare non-NAND MTD reached via mtd_blk) and
CONFIG_CMD_UBI / CONFIG_UBI_BLOCK (a UBI volume reached via ubi_blk).

Give the sandbox SPI-NOR two device-tree partitions for the mtd_blk
test and add a clean sandbox NAND chip (nand@2, no injected errors) so
UBI can format on it for the ubiblock test.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/sandbox/dts/test.dts | 29 +++++++++++++++++++++++++++++
 configs/sandbox_defconfig |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index bed2a4b65ab..b794a44a4e1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1623,6 +1623,22 @@
 			compatible = "spansion,m25p16", "jedec,spi-nor";
 			spi-max-frequency = <40000000>;
 			sandbox,filename = "spi.bin";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "nor-fit";
+					reg = <0x0 0x100000>;
+				};
+
+				partition@100000 {
+					label = "nor-spare";
+					reg = <0x100000 0x100000>;
+				};
+			};
 		};
 		spi.bin@1 {
 			reg = <1>;
@@ -2232,6 +2248,19 @@
 			sandbox,err-count = <3>;
 			sandbox,err-step-size = <512>;
 		};
+
+		/* Clean chip (no injected errors) for UBI/ubiblock tests */
+		nand@2 {
+			reg = <2>;
+			nand-ecc-mode = "soft";
+			sandbox,id = [00 e3];
+			sandbox,erasesize = <(8 * 1024)>;
+			sandbox,oobsize = <16>;
+			sandbox,pagesize = <512>;
+			sandbox,pages = <0x2000>;
+			sandbox,err-count = <0>;
+			sandbox,err-step-size = <512>;
+		};
 	};
 
 	graph1 {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f65e50590a3..05876cb36ba 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOOTMETH_RAUC=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
+CONFIG_IMAGEMAP=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_BOOTSTAGE_FDT=y
@@ -399,3 +400,8 @@ CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_MTD_BLOCK=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_CMD_UBI=y
+CONFIG_MTD_UBI=y
+CONFIG_UBI_BLOCK=y
-- 
2.55.0
