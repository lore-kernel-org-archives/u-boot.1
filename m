Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OtoLNQRA;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VEM6oPMK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F354760632;
	Wed, 28 Oct 2026 06:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juWLbxfCunwd; Wed, 28 Oct 2026 06:13:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6816C60677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168032;
	b=Hd5XxiLxXJyhBjG0A6yeOWC/L9Be2dMRyyoNf3mvE5mIAikiXhp/G6wIqbUcfnBBaLop
	 IH1ufMofLKttuwY1eDVLgVEWKw/jy8D89B6ljRkWE4qBejnCyYoUxh7XWTTjPHFUOBWkg
	 MsJ/JdVhZe6/OX7/KWz7fORL91ebxm4LyYVQBeVx7EyiSVi4YtU2ivf24TSOQy5uLvWvJ
	 ZQ47J/7gRrszsujStJVO9pY7EVzcWJRGgfM1t2bSxJsb6/Mi6nVlIs8NIVI2xmAa4cRZY
	 k17dtCnLbKG2/ddM7Io3EAVBOEHWV6AgDKyufGzKmKsT5eW9921Z7HGHkwuIY2AOprA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168032;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/+lM7Bxu9KM/d9qjJRvTLwgEunexq3NCDsk6RQ/OE9A=;
	b=VMT7BwUq80yE2zkRxUtSOpttsbQg3blq1XE2Ih91Sd9mz3JbTfuYY1Lx/kzpCjcDv3jS
	 vRkzonGNHLyosB5xXTBw7uoPhXgrJdk6PPELDZpn6JW6USXISi5EqcTfuwzxnQ0fO/RxD
	 TMK1Cq4zIGzc11/IlF5vSrS2hW902MB/nrsZeXT7WxyFMsg8OjQC4J2V0EJm15RFvkBL8
	 0zHoQUVh2kq59fl+V7JGUowfPX5jpUjRZRbR0UvgSkSO1UCS3uk93X5wceSLKNjjsCQx/
	 N5RVbNKHOeiIEHu8DLpDsag/VIlH7zDmckiyuZtN/p84TLD/9FGTKlsMB1Pyv1xLGnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=VEM6oPMK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168032;
	bh=/+lM7Bxu9KM/d9qjJRvTLwgEunexq3NCDsk6RQ/OE9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtoLNQRAEKWZ2OfGvWg8CdQzYGlIPv6ywofrcTM3fXGaZn5MNnKtp/4iqc2qr0QMM
	 j2zenFGGs9yzeKYMcGeDo0RFLr+doZb+E0EcLDNdSABNqN64X6KqAxcLA4WWO5DEoe
	 bngDWQDkwGBrGF1dYXtvkqTHNwQVqbdDw7Vo0tSgV8BS+gtr0XXMzP+3DPAuNBgvep
	 ndI7d/EbXJkGnvTMONdEPtxixA2Vw5hTN3KWv7MkBHdhp0dKddyyRR3hgXVphTh6Yo
	 SClC9CsUfjkciz9JVCBOQzeD8yO0yoM8X/Cp6Q/2PnNE5m334/bQXjF+7AzO54k/uJ
	 t/J35WJ54WtiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6816C60677;
	Wed, 28 Oct 2026 06:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB9564D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D19CD60632
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7w6P0BLLdTMf for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27DF8605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168029;
 b=B7Qqro1cutRsCFlwNja99SJbg+L81AGEzrnO79Lq+hEtLqqBYw1QGRlpKF8a+06bL4kO
 dRR2XI6IzjXtYGFyJp9hOvK6i9Su3v8Mx3oB3/tPwKL6w/+/5Ibi4+hDtRObZBPmEC9FL
 /cYjT71Pa1Ib442+ol4PABlj+faYjZ0mf8aV2smWYp4E5ViftUfMJYPiUnyfyDgb4VEWR
 ig6ybBW09XSgBW/dTGl/JhLiYO/VQL7HejPLIWe4vnR5r/3POEPojWaYbtvvwDIespqcn
 RWls2FOc9tkrdrJ7gKpNaYnaXvgOf2ljTcMBmxcLpawCz5S/yi1hknvln4xuMfXuq6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168029;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=/+lM7Bxu9KM/d9qjJRvTLwgEunexq3NCDsk6RQ/OE9A=;
 b=ZamAjczsXcZ0Go74H/l8JdlCCmaT8igf6ImqlF+j2Q7UF8dI0rpiiMdqUJX3IAQ1R+fn
 0nEgLIWn64QnA2oPTJLXjkN2vEaMAFKGfz6bAmgQ+JGUqH/LiTay63QqEfUIxWWS3njwF
 RQ49NAlAkEJGpcCrP0UNAkyXDxkVNUaIc/J15EiIK4MhxUI76wgHFMQeL6paDbwcPvnPY
 YYn/eBz3s5UItKvdfb+1gDLiEhB/zCJL29pVyX+ZDu3ANLO1dazCaQSRHqNKPyNDINQjy
 cHlTgGAUtV3IuB8SluNxP9wJkfpgQIdr3Qlkon2jO0xOcYIxdBM/5UzGPayXOdOV+7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VEM6oPMK; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VEM6oPMK
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27DF8605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4EDF010BB00; Wed, 28 Oct 2026 07:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793168022; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/+lM7Bxu9KM/d9qjJRvTLwgEunexq3NCDsk6RQ/OE9A=;
 b=VEM6oPMKXCTcQUKmcz1bTTmr2+l/bLrKi9aWGlP+diHntjs9yZVW5MpJQTRTQXbCVrPc1I
 AOre4MQBkkEmlTGTCV29RB+ng7h5RiTZhLf+N93ZNMBRmIzPq5+G0DWQE0DMCqEh3jCwm0
 e619SMOs0ONbXNQpscXq213DdnrfNEbVpEDh7uY6EsC1FBmSVcEiJ4Eot1Oorn5lR7S1AR
 v8H930Yjg4OoECFfdwbB0pZhcSWgMzxMcDGYIIyrAcq9gTD0T1lohevMrw6gSExJ1dCeUb
 Z+l74hNuWtTsxqeXSUHBTKWW2Vb/XKeaIejjUE+q67Rouc5Se98Br85gPYupaQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/7] test: dm: add a test for the Microchip 23K256 and
 23LCV1024 SPI SRAM
Date: Wed, 28 Oct 2026 07:11:39 +0100
Message-ID: <20261028061231.39152-6-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
References: <20261028061231.39152-1-hs@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Emulate both devices on a second sandbox SPI bus and exercise the
driver through the MTD layer.

The emulation implements the three operating modes, because a transfer
past the 32 byte page only comes back unharmed in sequential operation,
and it takes the device as the byte stream it is, so a master which
splits the transfers differently from the driver has to get the same
result.

The tests cover the cases which would otherwise pass unnoticed, a
device left in byte operation, an erase on a device which has none, the
two byte address of the smaller part, and a partition at an offset no
erase block boundary allows, which divided by zero before the alignment
earlier in this series.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch asks for a blank line after the test functions, before the
DM_TEST() that registers them. But in test/dm/ all over is without a
blank line, so ignore this warning.

Changes in v3:
- The patch that taught the sandbox SPI bus to bind an emulation from a
  sandbox,emul phandle is gone. Mainline has that since commit
  3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM test"),
  which looks the emulation up with uclass_get_device_by_phandle(). The
  emulation nodes therefore sit at the root of test.dts, bound by the
  device tree scan, and the tests no longer unbind anything by hand
- The emulation treats whatever follows the address in the first
  transfer as data, so it follows the data sheet rather than the way the
  driver splits its transfers. The test sends a write in a single
  transfer to cover it (Simon)
- The erase is asked for over the data that was written, so the check
  afterwards would see an erase that went through (Simon)
- spi_get_bus_and_cs() dropped, the emulation is looked up with the MTD
  device itself (Simon)
- The second partition sits at 0xa001, an offset no erase block boundary
  allows, and the comment says why that matters. 0xa000 was 8K aligned
  and proved nothing (Simon)
- The emulation powers up in sequential operation, as the data sheet
  says. The test puts it into byte operation and probes again to see the
  driver select the mode
- Added a test for the 23K256 with its own emulation instance, which is
  what the second compatible of the driver needs

Changes in v2:
Added comments from Simon:
- The test drives the device through the MTD layer instead of the
  spi_flash uclass.
- Uses sandbox_spi_get_emul() rather than reaching into state->spi[][].
- Added a spi1 alias so that dev_seq() of the bus does not depend on
  probe order.
- The erase part checks for -EOPNOTSUPP now. The v1 comment about
  covering more than one staging step went with the erase loop.
- The emulation lives in its own node with its own compatible, which
  the sandbox SPI bus resolves the phandle to.
- Added the emulation and the test to the MAINTAINERS entry.
Found while Stefan Bigler tested the series on hardware:
- Added partitions to the device in the test device tree and a second
  test that writes through one of them, which is what "mtd list" on his
  board fell over.

 MAINTAINERS                              |   2 +
 arch/sandbox/dts/test.dts                |  49 +++++
 arch/sandbox/include/asm/test.h          |  18 ++
 configs/sandbox_defconfig                |   1 +
 drivers/mtd/devices/Kconfig              |   8 +
 drivers/mtd/devices/Makefile             |   1 +
 drivers/mtd/devices/mchp23k256_sandbox.c | 268 +++++++++++++++++++++++
 drivers/spi/Kconfig                      |   2 +-
 test/dm/Makefile                         |   1 +
 test/dm/mchp23k256.c                     | 228 +++++++++++++++++++
 10 files changed, 577 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/devices/mchp23k256_sandbox.c
 create mode 100644 test/dm/mchp23k256.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dc2067d1f2..f3fe3597d6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1667,6 +1667,8 @@ MICROCHIP 23K256/23LCV1024 SPI SRAM
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
 F:	drivers/mtd/devices/mchp23k256.c
+F:	drivers/mtd/devices/mchp23k256_sandbox.c
+F:	test/dm/mchp23k256.c
 
 SPI-NOR
 M:	Vignesh R <vigneshr@ti.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b79..78ab51d8344 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -59,6 +59,7 @@
 		rtc0 = &rtc_0;
 		rtc1 = &rtc_1;
 		spi0 = "/spi@0";
+		spi1 = "/spi@1";
 		testfdt6 = "/e-test";
 		testbus3 = "/some-bus";
 		testfdt0 = "/some-bus/c-test@0";
@@ -1712,6 +1713,54 @@
 		sandbox,size = <2048>;
 	};
 
+	spi@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1 1>;
+		compatible = "sandbox,spi";
+
+		sram@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0>;
+			compatible = "microchip,mchp23lcv1024";
+			spi-max-frequency = <20000000>;
+			sandbox,emul = <&mchp23lcv1024_emul>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "spi-ram-part0";
+					reg = <0x0 0xa000>;
+				};
+
+				/* An offset no erase block boundary would allow */
+				partition@a001 {
+					label = "spi-ram-part1";
+					reg = <0xa001 0x1000>;
+				};
+			};
+		};
+
+		sram@1 {
+			reg = <1>;
+			compatible = "microchip,mchp23k256";
+			spi-max-frequency = <20000000>;
+			sandbox,emul = <&mchp23k256_emul>;
+		};
+	};
+
+	mchp23lcv1024_emul: mchp23lcv1024-emul {
+		compatible = "sandbox,mchp23lcv1024-emul";
+	};
+
+	mchp23k256_emul: mchp23k256-emul {
+		compatible = "sandbox,mchp23k256-emul";
+	};
+
 	syscon0: syscon@0 {
 		compatible = "sandbox,syscon0";
 		reg = <0x10 16>;
diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0438790028b..80ae334cb1c 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -251,6 +251,24 @@ uint sandbox_spi_get_mode(struct udevice *dev);
  */
 uint sandbox_spi_get_wordlen(struct udevice *dev);
 
+/**
+ * sandbox_mchp23k256_is_sequential() - check the mode of the emulated SPI SRAM
+ *
+ * @dev:	the emulation device
+ * Return: true if the MODE register selects sequential operation
+ */
+bool sandbox_mchp23k256_is_sequential(struct udevice *dev);
+
+/**
+ * sandbox_mchp23k256_force_byte_mode() - leave the emulated SRAM in byte mode
+ *
+ * The device powers up in sequential operation, so a test that wants to see
+ * the driver select a mode has to put the emulation into another one first.
+ *
+ * @dev:	the emulation device
+ */
+void sandbox_mchp23k256_force_byte_mode(struct udevice *dev);
+
 /**
  * sandbox_get_pch_spi_protect() - Get the PCI SPI protection status
  *
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 728470bb0d2..70187799b0a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -266,6 +266,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_MCHP23K256=y
+CONFIG_MTD_MCHP23K256_SANDBOX=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
 CONFIG_SYS_NAND_USE_FLASH_BBT=y
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 1b39382bcb9..0ba17618f1b 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -15,3 +15,11 @@ config MTD_MCHP23K256
 
 	  If unsure, say N
 
+config MTD_MCHP23K256_SANDBOX
+	bool "Sandbox emulation of the Microchip 23LCV1024"
+	depends on SANDBOX && MTD_MCHP23K256
+	help
+	  Emulate a 23LCV1024 on the sandbox SPI bus, so that the driver can
+	  be exercised by the unit tests. The emulation implements all three
+	  operating modes of the device, which is what makes it able to tell
+	  whether the driver selects the right one.
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index e8404019cb6..330937b58db 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_MTD_MCHP23K256) += mchp23k256.o
+obj-$(CONFIG_MTD_MCHP23K256_SANDBOX) += mchp23k256_sandbox.o
diff --git a/drivers/mtd/devices/mchp23k256_sandbox.c b/drivers/mtd/devices/mchp23k256_sandbox.c
new file mode 100644
index 00000000000..374d6fb8100
--- /dev/null
+++ b/drivers/mtd/devices/mchp23k256_sandbox.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sandbox emulation of the Microchip 23K256 and 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <malloc.h>
+#include <spi.h>
+#include <asm/test.h>
+#include <linux/bitops.h>
+#include <linux/sizes.h>
+
+/* Instruction set of the 23x series serial SRAMs */
+#define MCHP23K256_CMD_WRITE_STATUS	0x01
+#define MCHP23K256_CMD_WRITE		0x02
+#define MCHP23K256_CMD_READ		0x03
+
+/* MODE register, bits 7:6 select byte, page or sequential operation */
+#define MCHP23K256_MODE_MASK		GENMASK(7, 6)
+#define MCHP23K256_MODE_BYTE		0x00
+#define MCHP23K256_MODE_SEQ		BIT(6)
+#define MCHP23K256_MODE_PAGE		BIT(7)
+
+/* Page of the 23LCV1024, the part the page mode of this emulation models */
+#define MCHP23K256_PAGE_SIZE		32
+
+/**
+ * struct sandbox_mchp23_caps - what the emulated device looks like
+ *
+ * @size:	size of the emulated array in bytes
+ * @addr_width:	width of the address a command carries, in bytes
+ */
+struct sandbox_mchp23_caps {
+	u32 size;
+	u8 addr_width;
+};
+
+/**
+ * struct sandbox_mchp23k256_priv - state of the emulated SRAM
+ *
+ * @caps:	the device being emulated
+ * @data:	the emulated memory array
+ * @mode:	contents of the MODE register, see MCHP23K256_MODE_*
+ * @cmd:	opcode of the command being processed
+ * @addr:	address that command started at
+ * @pos:	data bytes of that command transferred so far
+ */
+struct sandbox_mchp23k256_priv {
+	const struct sandbox_mchp23_caps *caps;
+	u8 *data;
+	u8 mode;
+	u8 cmd;
+	u32 addr;
+	uint pos;
+};
+
+bool sandbox_mchp23k256_is_sequential(struct udevice *dev)
+{
+	struct sandbox_mchp23k256_priv *priv = dev_get_priv(dev);
+
+	return priv->mode == MCHP23K256_MODE_SEQ;
+}
+
+void sandbox_mchp23k256_force_byte_mode(struct udevice *dev)
+{
+	struct sandbox_mchp23k256_priv *priv = dev_get_priv(dev);
+
+	priv->mode = MCHP23K256_MODE_BYTE;
+}
+
+/**
+ * sandbox_mchp23k256_addr() - address of the n-th byte of the current command
+ *
+ * The three modes differ in how the device address counter changes
+ * during multi-byte transfers.
+ *
+ * @priv:	state of the emulated SRAM
+ * @n:		position of the byte within the data of the command
+ * Return: index into the emulated memory array
+ */
+static u32 sandbox_mchp23k256_addr(struct sandbox_mchp23k256_priv *priv,
+				   uint n)
+{
+	switch (priv->mode) {
+	case MCHP23K256_MODE_SEQ:
+		/* The counter runs across the whole array and wraps around */
+		return (priv->addr + n) % priv->caps->size;
+	case MCHP23K256_MODE_PAGE:
+		/* The counter wraps around within the addressed page */
+		return (priv->addr & ~(MCHP23K256_PAGE_SIZE - 1)) |
+		       ((priv->addr + n) & (MCHP23K256_PAGE_SIZE - 1));
+	default:
+		/* Byte operation transfers one byte and gets no further */
+		return priv->addr;
+	}
+}
+
+/**
+ * sandbox_mchp23k256_data() - move the data bytes of the current command
+ *
+ * @priv:	state of the emulated SRAM
+ * @out:	bytes clocked into the device, NULL when reading
+ * @in:		where to put the bytes clocked out, NULL when writing
+ * @bytes:	number of bytes
+ * Return: 0 on success, negative on error
+ */
+static int sandbox_mchp23k256_data(struct sandbox_mchp23k256_priv *priv,
+				   const u8 *out, u8 *in, uint bytes)
+{
+	uint n;
+
+	for (n = 0; n < bytes; n++) {
+		u32 addr = 0;
+
+		if (priv->cmd != MCHP23K256_CMD_WRITE_STATUS)
+			addr = sandbox_mchp23k256_addr(priv, priv->pos + n);
+
+		switch (priv->cmd) {
+		case MCHP23K256_CMD_READ:
+			if (!in)
+				return -EINVAL;
+			in[n] = priv->data[addr];
+			break;
+		case MCHP23K256_CMD_WRITE:
+			if (!out)
+				return -EINVAL;
+			priv->data[addr] = out[n];
+			break;
+		case MCHP23K256_CMD_WRITE_STATUS:
+			if (!out)
+				return -EINVAL;
+			/* Only the byte right after the opcode is the register */
+			if (!priv->pos && !n)
+				priv->mode = out[n] & MCHP23K256_MODE_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	priv->pos += bytes;
+
+	return 0;
+}
+
+/*
+ * The device sees the opcode, address and data as one continuous byte
+ * stream while chip select remains asserted, regardless of transfer
+ * boundaries.
+ */
+static int sandbox_mchp23k256_xfer(struct udevice *dev, unsigned int bitlen,
+				   const void *dout, void *din,
+				   unsigned long flags)
+{
+	struct sandbox_mchp23k256_priv *priv = dev_get_priv(dev);
+	const u8 *out = dout;
+	u8 *in = din;
+	uint bytes = bitlen / 8;
+	uint cmd_len;
+	uint i;
+
+	if (bitlen % 8) {
+		log_err("transfer of %u bits is not a whole number of bytes\n",
+			bitlen);
+		return -EINVAL;
+	}
+
+	if (flags & SPI_XFER_BEGIN) {
+		if (!out || !bytes)
+			return -EINVAL;
+
+		priv->cmd = out[0];
+		priv->pos = 0;
+
+		switch (priv->cmd) {
+		case MCHP23K256_CMD_WRITE_STATUS:
+			/* The register follows the opcode, no address */
+			cmd_len = 1;
+			break;
+		case MCHP23K256_CMD_READ:
+		case MCHP23K256_CMD_WRITE:
+			cmd_len = 1 + priv->caps->addr_width;
+			if (bytes < cmd_len)
+				return -EINVAL;
+
+			priv->addr = 0;
+			for (i = 1; i < cmd_len; i++)
+				priv->addr = (priv->addr << 8) | out[i];
+
+			if (priv->addr >= priv->caps->size)
+				return -EINVAL;
+			break;
+		default:
+			log_err("unknown command %#x\n", priv->cmd);
+			return -EINVAL;
+		}
+
+		/* Whatever follows the address in this transfer is data */
+		bytes -= cmd_len;
+		out += cmd_len;
+		if (in)
+			in += cmd_len;
+	}
+
+	return sandbox_mchp23k256_data(priv, out, in, bytes);
+}
+
+static int sandbox_mchp23k256_probe(struct udevice *dev)
+{
+	struct sandbox_mchp23k256_priv *priv = dev_get_priv(dev);
+
+	priv->caps = (const struct sandbox_mchp23_caps *)
+			dev_get_driver_data(dev);
+
+	/* The device comes out of reset in sequential operation */
+	priv->mode = MCHP23K256_MODE_SEQ;
+
+	priv->data = calloc(1, priv->caps->size);
+	if (!priv->data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int sandbox_mchp23k256_remove(struct udevice *dev)
+{
+	struct sandbox_mchp23k256_priv *priv = dev_get_priv(dev);
+
+	free(priv->data);
+	priv->data = NULL;
+
+	return 0;
+}
+
+static const struct dm_spi_emul_ops sandbox_mchp23k256_emul_ops = {
+	.xfer = sandbox_mchp23k256_xfer,
+};
+
+static const struct sandbox_mchp23_caps sandbox_mchp23k256_caps = {
+	.size = SZ_32K,
+	.addr_width = 2,
+};
+
+static const struct sandbox_mchp23_caps sandbox_mchp23lcv1024_caps = {
+	.size = SZ_128K,
+	.addr_width = 3,
+};
+
+static const struct udevice_id sandbox_mchp23k256_ids[] = {
+	{ .compatible = "sandbox,mchp23k256-emul",
+	  .data = (ulong)&sandbox_mchp23k256_caps },
+	{ .compatible = "sandbox,mchp23lcv1024-emul",
+	  .data = (ulong)&sandbox_mchp23lcv1024_caps },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_mchp23k256_emul) = {
+	.name		= "sandbox_mchp23k256_emul",
+	.id		= UCLASS_SPI_EMUL,
+	.of_match	= sandbox_mchp23k256_ids,
+	.probe		= sandbox_mchp23k256_probe,
+	.remove		= sandbox_mchp23k256_remove,
+	.priv_auto	= sizeof(struct sandbox_mchp23k256_priv),
+	.ops		= &sandbox_mchp23k256_emul_ops,
+};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..7127337c6ac 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -518,7 +518,7 @@ config SANDBOX_SPI
 config SANDBOX_SPI_MAX_BUS
 	int
 	depends on SANDBOX
-	default 1
+	default 2
 
 config SANDBOX_SPI_MAX_CS
 	int
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..0b768dcc548 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_IOMMU) += iommu.o
 obj-$(CONFIG_LED) += led.o
 obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += video_bridge.o
 obj-$(CONFIG_DM_MAILBOX) += mailbox.o
+obj-$(CONFIG_MTD_MCHP23K256_SANDBOX) += mchp23k256.o
 obj-$(CONFIG_DM_MDIO) += mdio.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio_mux.o
 obj-$(CONFIG_MEMORY) += memory.o
diff --git a/test/dm/mchp23k256.c b/test/dm/mchp23k256.c
new file mode 100644
index 00000000000..cab8dbee547
--- /dev/null
+++ b/test/dm/mchp23k256.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the Microchip 23K256 and 23LCV1024 SPI SRAM
+ *
+ * Copyright (C) 2026 Heiko Schocher, Nabla Software Engineering <hs@nabladev.com>
+ */
+
+#include <dm.h>
+#include <mtd.h>
+#include <spi.h>
+#include <asm/test.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* The 23LCV1024 and the 23K256 of the test device tree */
+#define MCHP23_PATH		"/spi@1/sram@0"
+#define MCHP23_SMALL_PATH	"/spi@1/sram@1"
+
+/*
+ * Long enough to run past the 32 byte page of the device, and starting
+ * just before a page boundary, so that the transfer only comes back
+ * unharmed if the driver put the device into sequential operation.
+ */
+#define MCHP23_OFFSET		0x1f
+#define MCHP23_LEN		100
+
+/*
+ * A write command with its address and data in one transfer, opcode 0x02,
+ * the 24 bit address of the 23LCV1024 and four data bytes.
+ */
+#define MCHP23_ONE_ADDR		0x100
+#define MCHP23_ONE_DATA_LEN	4
+
+/*
+ * The second partition in the test device tree. Its offset is not aligned
+ * to any erase block size, which does not matter for a device without
+ * erase requirements, where writes are aligned to single bytes.
+ */
+#define MCHP23_PART		"spi-ram-part1"
+#define MCHP23_PART_OFFSET	0xa001
+#define MCHP23_PART_SIZE	0x1000
+
+static int dm_test_mchp23k256(struct unit_test_state *uts)
+{
+	struct udevice *dev, *emul;
+	struct erase_info instr = { };
+	struct mtd_info *mtd, *found;
+	u8 src[MCHP23_LEN], dst[MCHP23_LEN];
+	u8 one[] = { 0x02, (MCHP23_ONE_ADDR >> 16) & 0xff,
+		     (MCHP23_ONE_ADDR >> 8) & 0xff, MCHP23_ONE_ADDR & 0xff,
+		     0xde, 0xad, 0xbe, 0xef };
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(MCHP23_PATH),
+						&dev));
+
+	mtd = dev_get_uclass_priv(dev);
+	ut_asserteq(SZ_128K, mtd->size);
+	ut_asserteq(MTD_RAM, mtd->type);
+
+	/*
+	 * Registering with the MTD layer is what makes the mtd command able
+	 * to reach the device, so check the name it was given resolves back
+	 * to it rather than checking the string itself.
+	 */
+	found = get_mtd_device_nm(mtd->name);
+	ut_asserteq_ptr(mtd, found);
+	put_mtd_device(found);
+
+	/* The emulation the slave points at, probed by the lookup */
+	ut_assertok(uclass_get_device_by_phandle(UCLASS_SPI_EMUL, dev,
+						 "sandbox,emul", &emul));
+
+	/*
+	 * The device powers up in sequential mode, but its current mode
+	 * may have been changed by a previous user. Switch to byte mode,
+	 * where each command transfers one byte, and probe again to ensure
+	 * the driver selects sequential mode itself.
+	 */
+	sandbox_mchp23k256_force_byte_mode(emul);
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assertok(device_probe(dev));
+	ut_assert(sandbox_mchp23k256_is_sequential(emul));
+
+	mtd = dev_get_uclass_priv(dev);
+
+	for (i = 0; i < MCHP23_LEN; i++)
+		src[i] = i + 1;
+
+	ut_assertok(mtd_write(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, src));
+	ut_asserteq(MCHP23_LEN, retlen);
+
+	memset(dst, 0, MCHP23_LEN);
+	ut_assertok(mtd_read(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, dst));
+	ut_asserteq(MCHP23_LEN, retlen);
+	ut_asserteq_mem(src, dst, MCHP23_LEN);
+
+	/* Neighbouring cells must not have been touched */
+	ut_assertok(mtd_read(mtd, 0, MCHP23_OFFSET, &retlen, dst));
+	for (i = 0; i < MCHP23_OFFSET; i++)
+		ut_asserteq(0, dst[i]);
+
+	/*
+	 * The device does not support erase and sets MTD_NO_ERASE. Reject
+	 * erase requests rather than pretending the data was cleared.
+	 * Request the erase over the data just written so the following
+	 * check would detect an erase that incorrectly succeeded.
+	 */
+	ut_assert(mtd->flags & MTD_NO_ERASE);
+	instr.addr = MCHP23_OFFSET;
+	instr.len = MCHP23_LEN;
+	ut_asserteq(-EOPNOTSUPP, mtd_erase(mtd, &instr));
+
+	ut_assertok(mtd_read(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, dst));
+	ut_asserteq_mem(src, dst, MCHP23_LEN);
+
+	/*
+	 * The device sees a byte stream while the chip select is asserted,
+	 * so a master that sends the write command, the address and the data
+	 * in one transfer has to get the same result as the driver, which
+	 * sends the data in a second one.
+	 */
+	ut_assertok(spi_claim_bus(dev_get_parent_priv(dev)));
+	ut_assertok(spi_xfer(dev_get_parent_priv(dev), sizeof(one) * 8, one,
+			     NULL, SPI_XFER_BEGIN | SPI_XFER_END));
+	spi_release_bus(dev_get_parent_priv(dev));
+
+	ut_assertok(mtd_read(mtd, MCHP23_ONE_ADDR, MCHP23_ONE_DATA_LEN,
+			     &retlen, dst));
+	ut_asserteq_mem(&one[sizeof(one) - MCHP23_ONE_DATA_LEN], dst,
+			MCHP23_ONE_DATA_LEN);
+
+	return 0;
+}
+DM_TEST(dm_test_mchp23k256, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* The 23K256 is a quarter of the size and takes a two byte address */
+static int dm_test_mchp23k256_small(struct unit_test_state *uts)
+{
+	u8 src[MCHP23_LEN], dst[MCHP23_LEN];
+	struct mtd_info *mtd;
+	struct udevice *dev;
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(MCHP23_SMALL_PATH),
+						&dev));
+
+	mtd = dev_get_uclass_priv(dev);
+	ut_asserteq(SZ_32K, mtd->size);
+
+	for (i = 0; i < MCHP23_LEN; i++)
+		src[i] = 0x80 - i;
+
+	/* An offset the two byte address reaches, but not in its low byte */
+	ut_assertok(mtd_write(mtd, SZ_16K + MCHP23_OFFSET, MCHP23_LEN,
+			      &retlen, src));
+	ut_asserteq(MCHP23_LEN, retlen);
+
+	memset(dst, 0, MCHP23_LEN);
+	ut_assertok(mtd_read(mtd, SZ_16K + MCHP23_OFFSET, MCHP23_LEN,
+			     &retlen, dst));
+	ut_asserteq_mem(src, dst, MCHP23_LEN);
+
+	/* Nothing may have landed at the offset the low byte alone gives */
+	ut_assertok(mtd_read(mtd, MCHP23_OFFSET, MCHP23_LEN, &retlen, dst));
+	for (i = 0; i < MCHP23_LEN; i++)
+		ut_asserteq(0, dst[i]);
+
+	return 0;
+}
+DM_TEST(dm_test_mchp23k256_small, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_mchp23k256_part(struct unit_test_state *uts)
+{
+	struct mtd_info *mtd, *part;
+	struct udevice *dev;
+	u8 src[MCHP23_LEN], dst[MCHP23_LEN];
+	size_t retlen;
+	int i;
+
+	ut_assertok(uclass_get_device_by_ofnode(UCLASS_MTD,
+						ofnode_path(MCHP23_PATH),
+						&dev));
+	mtd = dev_get_uclass_priv(dev);
+
+	/*
+	 * This is what the mtd command does through mtd_probe_devices(),
+	 * called here for this device alone so that the test does not depend
+	 * on what else is registered with the MTD layer.
+	 */
+	ut_assertok(add_mtd_partitions_of(mtd));
+
+	part = get_mtd_device_nm(MCHP23_PART);
+	ut_assert(!IS_ERR_OR_NULL(part));
+
+	/*
+	 * The device has no erase size to align a partition to, so the
+	 * partition is aligned on the write size of one byte and stays
+	 * writeable at an offset no erase block would allow.
+	 */
+	ut_assert(part->flags & MTD_NO_ERASE);
+	ut_assert(part->flags & MTD_WRITEABLE);
+	ut_asserteq(MCHP23_PART_SIZE, part->size);
+
+	for (i = 0; i < MCHP23_LEN; i++)
+		src[i] = 0xa0 + i;
+
+	ut_assertok(mtd_write(part, 0, MCHP23_LEN, &retlen, src));
+	ut_asserteq(MCHP23_LEN, retlen);
+	put_mtd_device(part);
+
+	/* what the partition took has to land at its offset in the device */
+	memset(dst, 0, MCHP23_LEN);
+	ut_assertok(mtd_read(mtd, MCHP23_PART_OFFSET, MCHP23_LEN, &retlen,
+			     dst));
+	ut_asserteq_mem(src, dst, MCHP23_LEN);
+
+	return 0;
+}
+DM_TEST(dm_test_mchp23k256_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.55.0

