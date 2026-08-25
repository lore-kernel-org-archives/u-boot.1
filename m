Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B0EC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7358060714;
	Tue, 25 Aug 2026 15:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dry2DexEVZo8; Tue, 25 Aug 2026 15:59:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673590;
	bh=N5fUsaWyhFWpV8sFgvVXZ2vTZRRWqCCL/k6g4+8UObc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xr1oKgjkOyjCM5enmBABjdnZiI7cucmQhH8Vr8DJ/DjPm56G3lG5BbQeJxO8LX4pq
	 lVdoshgkq5Zjn/7ET9VIlPoO8F7Q8LLJsuIZKenem1mDzeGalwtJCCbVuivQRPgcQC
	 l/3+l/89bx7xCx/Ap1znLDuekD5r5xYtELGY9h8qPDVi7oHGiKcnO0HraDusXAHyiR
	 DLrdGQQ3M4apZLvyJelgI28RLEul1rlzJbpGb9tlnj6+pewNhX+3NPOv0lPN1SDFl1
	 DjA+Y1Y8tz6Xpm6AJJedmLFkQkcbO1+WJQLYCNHN3dUoy59wr+1wWhppsMJ2uwkKPc
	 DMBKtcXsCFklw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23BDF606AE;
	Tue, 25 Aug 2026 15:59:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FF7118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6301D40639
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrSY_u0ruktg for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 15:59:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AC2F405EB
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:46 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wytYv-000000003vR-0fbP; Tue, 25 Aug 2026 15:59:45 +0000
Date: Tue, 25 Aug 2026 16:59:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 09/11] configs: sandbox: enable imagemap and its storage
 backends
Message-ID: <f30c04e65dc0da58322a6c62a33540b112658b9f.1787673209.git.daniel@makrotopia.org>
References: <cover.1787673209.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787673209.git.daniel@makrotopia.org>
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
